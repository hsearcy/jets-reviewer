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
                  <input class="input" type="text" v-model="postData.title" required>
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
    <section class="section is-small">
      <div class="container">
        <table class="table is-striped is-hoverable">
          <thead>
            <tr>
              <th>All Posts</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="post in posts" v-bind:key="post.id">
              <template v-if="editId === post.id">
                <td>
                  <input class="input" type="text" v-model="editPostData.title" required>
                </td>
                <td>
                  <span class="icon">
                    <font-awesome-icon v-on:click="onSubmitEdit(post.id)" icon="check"></font-awesome-icon>
                  </span>
                  <span class="icon">
                    <font-awesome-icon v-on:click="onCancelEdit()" icon="ban"></font-awesome-icon>
                  </span>
                </td>
              </template>
              <template v-else>
                <td>{{post.title}}</td>
                <td>
                  <a href="#" class="icon has-text-danger">
                    <font-awesome-icon v-on:click="onDelete(post.id)" icon="trash"></font-awesome-icon>
                  </a>
                  <a href="#" class="icon">
                    <font-awesome-icon v-on:click="onEdit(post)" icon="pen"></font-awesome-icon>
                  </a>
                  <router-link :to="{ name: PostPage, params: { id: post.id }}" class="icon">
                    <font-awesome-icon v-on:click="onView(post.id)" icon="eye"></font-awesome-icon>
                  </router-link>
                </td>
              </template>
            </tr>
          </tbody>
        </table>
      </div>
    </section>
  </section>
</template>

<script>
import axios from "axios";
export default {
  name: "Posts",
  data: function() {
    return {
      editId: "",
      editPostData: {
        title: ""
      },
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
    },
    async onDelete(id) {
      await axios.delete(`http://localhost:8888/api/posts/${id}`);
      await this.getPosts();
    },
    onEdit(post) {
      this.editId = post.id;
      this.editPostData.title = post.title;
    },
    async onSubmitEdit() {
      await axios.put(`http://localhost:8888/api/posts/${this.editId}`, {
        post: this.editPostData
      });
      this.editPostData.title = "";
      this.editId = "";
      await this.getPosts();
    },
    onCancelEdit() {
      this.editPostData.title = "";
      this.editId = "";
    }
  }
};
</script>

<style scoped>
</style>
