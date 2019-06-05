<template>
  <div class="posts">
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
      posts: []
    };
  },
  async created() {
    const response = await axios.get("http://localhost:8888/api/posts");
    this.posts = response.data;
  }
};
</script>

<style scoped>
p {
  font-size: 2.1em;
  text-align: center;
}
</style>
