<script lang="ts">
  import { feedbackStore as FeedbackStore } from "./components/stores";
  import FeedbackList from "./components/feedback-list.svelte";
  import FeedbackStats from "./components/feedback-stats.svelte";
  import FeedbackForm from "./components/feedback-form.svelte";
  let count: number;
  let avgRating: number;
</script>
<main class="container">
  <FeedbackForm />
  <FeedbackStats />
  <FeedbackList/>
</main>
