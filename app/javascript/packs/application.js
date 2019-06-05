import "core-js/stable";
import "regenerator-runtime/runtime";
import Vue from "vue";
import App from "../app.vue";
import router from "../router";
import "./main.scss";

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    render: h => h(App),
    router
  }).$mount();
  document.body.appendChild(app.$el);

  console.log(app);
});
