<template>
  <div class="posts">
    <h1>Posts</h1>
    <div class="card">
      <div class="card-header">Add a new post</div>
      <div class="card-body">
        <form v-on:submit.prevent="onSubmit" class="form-inline">
          <div class="form-group">
            <label for="title">Title</label>
            <input type="text" v-model="postData.title" required>
          </div>
          <div>
            <button type="submit">Add</button>
          </div>
        </form>
      </div>
    </div>
    <div v-for="post in posts" v-bind:key="post.id">
      <p>{{post.title}}</p>
    </div>
    <p>{{ message }}</p>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "Posts",
  data: function() {
    return {
      message: "Hello Vue!",
      posts: [],
      postData: {
        title: ""
      }
    };
  },
  async created() {
    await this.getPosts();
  },
  methods: {
    async getPosts() {
      const response = await axios.get("http://localhost:8888/api/posts");
      this.posts = response.data;
    },
    async onSubmit() {
      await axios.post("http://localhost:8888/api/posts", {
        post: this.postData
      });
      this.postData.title = "";
      await this.getPosts();
    }
  }
};
</script>

<style scoped>
p {
  font-size: 2.1em;
  text-align: center;
}
</style>
