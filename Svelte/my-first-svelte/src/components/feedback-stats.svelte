<script lang="ts">
    import {feedbackStore as FeedbackStore} from '../components/stores';

    $: count = $FeedbackStore.length;
    $: avgRating = $FeedbackStore.reduce((a, {rating}) => a + rating, 0) / $FeedbackStore.length;
</script>

<div class="feedback-stats">
    <h4>{count} Reviews</h4>
    <h4>Average Rating: {avgRating}</h4>
</div>

<style>
    .feedback-stats {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
</style>