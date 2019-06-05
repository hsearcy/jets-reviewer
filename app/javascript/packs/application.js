import "core-js/stable";
import "regenerator-runtime/runtime";
import Vue from "vue";
import App from "../app.vue";
import router from "../router";

import "./theme.scss";
import { icon, library as icons } from "@fortawesome/fontawesome-svg-core";
import { faTrash, faPen, faEye } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";

icons.add(faTrash);
icons.add(faPen);
icons.add(faEye);
icon({ prefix: "fas", iconName: "trash" });
icon({ prefix: "fas", iconName: "pen" });
icon({ prefix: "fas", iconName: "eye" });

Vue.component("font-awesome-icon", FontAwesomeIcon);

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    render: h => h(App),
    router
  }).$mount();
  document.body.appendChild(app.$el);

  console.log(app);
});
