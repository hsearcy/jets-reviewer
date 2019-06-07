<template>
  <section class="section">
    <div class="container">
      <div class="message">
        <div class="message-header is-centered">Post</div>
        <div class="message-body">
          <template v-if="postData.id">
            <div class="field">
              <div id="postId" class="content">
                <strong>ID:</strong>
                {{postData.id}}
              </div>
            </div>
            <div class="field">
              <div class="content">
                <strong>Title:</strong>
                {{postData.title}}
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
import axios from "../plugins/axios";

export default {
  name: "PostPage",
  data: () => {
    return {
      postData: {
        title: ""
      }
    };
  },
  async beforeCreate() {
    const response = await axios.get(`api/posts/${this.$route.params.id}`);
    this.postData = response.data;
  }
};
</script>
<style scoped>
</style>

