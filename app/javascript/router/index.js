import Vue from "vue";
import Router from "vue-router";
import { components, AmplifyEventBus } from "aws-amplify-vue";
import Amplify, * as AmplifyModules from "aws-amplify";
import { AmplifyPlugin } from "aws-amplify-vue";
import AmplifyStore from "../store/store";
import Posts from "../components/Posts";
import PostPage from "../components/PostPage";
import Login from "../components/Login";
import Logout from "../components/Logout";
import Register from "../components/Register";

Vue.use(Router);

Vue.use(AmplifyPlugin, AmplifyModules);

let user;

getUser().then((user, error) => {
  if (user) {
    router.push({ path: "/" });
  }
});

AmplifyEventBus.$on("authState", async state => {
  if (state === "signedOut") {
    user = null;
    AmplifyStore.commit("setUser", null);
    router.push({ path: "/auth" });
  } else if (state === "signedIn") {
    user = await getUser();
    router.push({ path: "/" });
  }
});

function getUser() {
  return Vue.prototype.$Amplify.Auth.currentAuthenticatedUser()
    .then(data => {
      if (data && data.signInUserSession) {
        AmplifyStore.commit("setUser", data);
        return data;
      }
    })
    .catch(e => {
      AmplifyStore.commit("setUser", null);
      return null;
    });
}

const router = new Router({
  routes: [
    {
      path: "/",
      name: "Posts",
      component: Posts,
      meta: { requiresAuth: true}
    },
    {
      path: "/post/:id",
      name: "PostPage",
      component: PostPage,
      meta: { requiresAuth: true}
    },
    {
      path: "/register",
      name: "Register",
      component: Register
    },
    {
      path: "/login",
      name: "Login",
      component: Login
    },
    {
      path: "/logout",
      name: "Logout",
      component: Logout
    },
    {
      path: '/auth',
      name: 'Authenticator',
      component: components.Authenticator
    }
  ]
});

router.beforeResolve(async (to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    user = await getUser();
    if (!user) {
      return next({
        path: "/auth",
        query: {
          redirect: to.fullPath
        }
      });
    }
    return next();
  }
  return next();
});

export default router;
