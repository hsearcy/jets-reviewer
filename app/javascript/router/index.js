import Vue from "vue";
import Router from "vue-router";
import Posts from "../components/Posts";
import PostPage from "../components/PostPage";

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: "/",
      name: "Posts",
      component: Posts
    },
    {
      path: "/post/:id",
      name: "PostPage",
      component: PostPage
    }
  ]
});
