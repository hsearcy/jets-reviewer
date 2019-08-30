import "core-js/stable";
import "regenerator-runtime/runtime";
// import Amplify from "aws-amplify";
// import aws_exports from "./aws-exports";
import Vue from "vue";
import App from "../app.vue";
import store from "../store/store";
import axios from "axios";
import router from "../router";

import "./theme.scss";
import { icon, library as icons } from "@fortawesome/fontawesome-svg-core";
import { faTrash, faPen, faEye, faBan, faCheck } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";

icons.add(faTrash);
icons.add(faPen);
icons.add(faEye);
icons.add(faBan);
icons.add(faCheck);
icon({ prefix: "fas", iconName: "trash" });
icon({ prefix: "fas", iconName: "pen" });
icon({ prefix: "fas", iconName: "eye" });
icon({ prefix: "fas", iconName: "ban" });
icon({ prefix: "fas", iconName: "check" });

Vue.component("font-awesome-icon", FontAwesomeIcon);

// Amplify.configure(aws_exports);
Vue.prototype.$http = axios;
Vue.prototype.$store = store;

const token = localStorage.getItem("token");
if (token) {
  Vue.prototype.$http.defaults.headers.common["Authorization"] = token;
}

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    render: h => h(App),
    router
  }).$mount();
  document.body.appendChild(app.$el);

  console.log(app);
});
