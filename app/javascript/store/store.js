import Vue from "vue";
import Vuex from "vuex";
import axios from "axios";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    status: "",
    token: localStorage.getItem("token") || "",
    user: {}
  },
  mutations: {
    auth_request(state) {
      state.status = "loading";
    },
    auth_success(state, token, user) {
      state.status = "success";
      state.token = token;
      state.user = user;
    },
    auth_error(state) {
      state.status = "error";
    },
    logout(state) {
      state.status = "";
      state.token = "";
    }
  },
  actions: {
    async register({ commit }, userData) {
      try {
        commit("auth_request");
        console.log("User is : ", userData);
        const response = await axios.post("api/register", userData);
        const token = response.data.token;
        const user = response.data.user;
        localStorage.setItem("token", token);
        axios.defaults.headers.common["Authorization"] = token;
        commit("auth_success", token, user);
        return response;
      } catch (err) {
        commit("auth_error", err);
        localStorage.removeItem("token");
        throw err;
      }
    },
    async login({ commit }, userData) {
      try {
        commit("auth_request");
        const response = await axios.post("api/login", userData);
        console.log("response = ", response)
        const token = response.data.token;
        const user = response.data.user;
        localStorage.setItem("token", token);
        axios.defaults.headers.common["Authorization"] = token;
        commit("auth_success", token, user);
        return response;
      } catch (err) {
        commit("auth_error", err);
        localStorage.removeItem("token");
        throw err;
      }
    },
    logout({ commit }) {
      commit("logout");
      localStorage.removeItem("token");
      delete axios.defaults.headers.common["Authorization"];
      return;
    }
  },
  getters: {
    isLoggedIn: state => !!state.token,
    authStatus: state => state.status
  }
});

async function authUser({ commit }, user, endpoint) {
  try {
    commit("auth_request");
    const response = await axios.post(endpoint, user);
    const token = response.data.token;
    const user = response.data.user;
    localStorage.setItem("token", token);
    axios.defaults.headers.common["Authorization"] = token;
    commit("auth_success", token, user);
    return response;
  } catch (err) {
    commit("auth_error", err);
    localStorage.removeItem("token");
    throw err;
  }
}
