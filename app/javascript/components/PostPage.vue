<template>
  <section class="section">
    <div class="container">
      <div class="message is-medium">
        <div class="message-header">
          <div>{{postData.title}}</div>
          <div class="is-pulled-right">
            <button
              v-if="user === postData.author && !editing"
              class="icon is-medium is-pulled-right"
              aria-label="edit"
            >
              <font-awesome-icon v-on:click="onEdit()" icon="pen" />
            </button>
            <button
              v-if="user === postData.author && editing"
              class="icon is-medium is-pulled-right"
              aria-label="cancel"
            >
              <font-awesome-icon v-on:click="onCancel()" icon="ban" />
            </button>
            <button
              v-if="user === postData.author && editing"
              class="icon is-medium is-pulled-right"
              aria-label="save"
            >
              <font-awesome-icon v-on:click="onSave()" icon="check" />
            </button>
          </div>
        </div>
        <div class="message-body">
          <template v-if="postData.id && !editing">
            <div class="field">
              <div id="pic" class="content">
                <img v-if="postData.image_source" :src="postData.image_source" alt="image" />
              </div>
            </div>
            <div class="field">
              <div class="content">
                <strong>Post by:</strong>
                {{postData.author}}
              </div>
            </div>
            <div class="field">
              <div class="content" v-html="postData.body"></div>
            </div>
          </template>
          <template v-else-if="postData.id && editing">
            <div class="field">
              <label class="label">Title</label>
              <div class="control">
                <input class="input" type="text" v-model="postData.title" required />
              </div>
            </div>
            <div class="field">
              <label class="label">Image Source</label>
              <div class="control">
                <input class="input" type="text" v-model="postData.image_source" required />
                <img v-if="postData.image_source" :src="postData.image_source" />
              </div>
            </div>
            <div class="field">
              <label class="label">Body</label>
              <div class="control">
                <vue-editor v-model="postData.body" required></vue-editor>
              </div>
            </div>
          </template>
          <template v-else>
            <progress class="progress is-small is-primary" max="100">loading</progress>
          </template>
        </div>
      </div>
      <router-link :to="'/'" class="button is-primary">Back</router-link>
    </div>
  </section>
</template>

<script>
import { VueEditor } from "vue2-editor";
import axios from "../plugins/axios";

export default {
  name: "PostPage",
  computed: {
    user() {
      return this.$store.getters.user;
    }
  },
  components: {
    VueEditor
  },
  data: () => {
    return {
      editing: false,
      postData: {
        title: "",
        image_source: "",
        author: "",
        body: ""
      },
      editPostData: {
        title: "",
        image_source: "",
        body: ""
      }
    };
  },
  async beforeCreate() {
    const response = await axios.get(`api/posts/${this.$route.params.id}`);
    this.postData = response.data;
  },
  methods: {
    onEdit() {
      this.editing = true;
      this.editPostData = this.postData;
    },
    async onSave() {
      this.editPostData.title = this.editPostData.title.trim();
      if (this.editPostData.title === "")
        this.editPostData.title = this.postData.title;
      const response = await axios.put(`api/posts/${this.$route.params.id}`, {
        post: this.editPostData
      });
      if (response.status === 200) this.postData = this.editPostData;
      this.editing = false;
    },
    onCancel() {
      this.editing = false;
    }
  }
};
</script>
<style scoped>
img {
  max-width: 200px;
  height: auto;
}
</style>

