<template>
  <section class="section">
    <section class="section is-small">
      <div class="container">
        <div class="card column is-half is-centered">
          <div class="card-header-title is-centered">Add a new post</div>
          <div class="card-content">
            <form v-on:submit.prevent="onSubmit" class="form-inline">
              <div class="field">
                <label class="label">Title</label>
                <div class="control">
                  <input class="input" type="text" v-model="postData.title" required />
                </div>
              </div>
              <div class="field">
                <label class="label">Image Source</label>
                <div class="control">
                  <input class="input" type="text" v-model="postData.image_source" />
                  <img v-if="postData.image_source" :src="postData.image_source" />
                </div>
              </div>
              <div class="field">
                <label class="label">Body</label>
                <div class="control">
                  <vue-editor v-model="postData.body" required></vue-editor>
                </div>
              </div>
              <div class="control">
                <button class="button is-primary" type="submit">Add</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>
    <section class="section is-large">
      <div class="columns is-multiline">
        <div class="column is-one-quarter" v-for="post in posts" v-bind:key="post.id">
          <div class="card posts">
            <router-link :to="{ name: 'PostPage', params: { id: post.id }}">
              <div class="card-image post-image has-text-centered level">
                <figure class="image is-inline-block level-item">
                  <img v-if="post.image_source" :src="post.image_source" />
                  <img v-else src="no-image.png" />
                </figure>
              </div>
              <div class="card-content post-content">
                <div class="content">
                  <p class="subtitle has-text-centered">{{post.title}}</p>
                </div>
              </div>
            </router-link>
              <footer class="card-footer post-footer">
                <p class="card-footer-item">By: {{post.author}}</p>
                <p v-if="user === post.author" class="card-footer-item">
                  <a class="icon has-text-danger">
                    <font-awesome-icon v-on:click="onDelete(post.id)" icon="trash" />
                  </a>
                </p>
              </footer>
          </div>
        </div>
      </div>
    </section>
  </section>
</template>

<script>
import { VueEditor } from "vue2-editor";
import axios from "../plugins/axios";
export default {
  name: "Posts",
  components: {
    VueEditor
  },
  computed: {
    user() {
      return this.$store.getters.user;
    }
  },
  data: () => {
    return {
      posts: [],
      postData: {
        title: "",
        image_source: "",
        body: ""
      }
    };
  },
  async created() {
    await this.getPosts();
  },
  methods: {
    async getPosts() {
      const response = await axios.get("api/posts");
      this.posts = response.data;
    },
    async onSubmit() {
      await axios.post("api/posts", {
        post: { ...this.postData, author: this.$store.getters.user }
      });
      this.postData.title = "";
      this.postData.image_source = "";
      this.postData.body = "";
      await this.getPosts();
    },
    async onDelete(id) {
      await axios.delete(`api/posts/${id}`);
      await this.getPosts();
    }
  }
};
</script>

<style scoped>
img {
  max-width: 200px;
  max-height: 200px;
}

.posts {
  height: 350px;
}

.post-image {
  height: 200px;
}

.post-content {
  height: 75px;
}

.post-footer {
  height: 50px;
}
</style>
