<script lang="ts">
    import {feedbackStore as FeedbackStore} from '../components/stores';
    import Card from '../components/card.svelte';
    export let item: {id: number, text: string, rating: number};
    
    const deleteItem = (itemId: number) => {
        FeedbackStore.update((currentFeedback) => {
            return currentFeedback.filter((item) => item.id != itemId)
        })
    }
</script>

<Card>
    <div class="num-display">
        {item.rating}
    </div>
    <div class="text-display">
        {item.text}
    </div>
    <button class="close" on:click={() => deleteItem(item.id)}>
        X
    </button>
</Card>

<style>
    .num-display {
        position: absolute;
        top: -10px;
        left: -10px;
        width: 50px;
        height: 50px;
        background: #ff6a95;
        color: #fff;
        border: 1px #eee solid;
        border-radius: 50%;
        padding: 10px;
        text-align: center;
        font-size: 19px;
    }

    .close {
        position: absolute;
        top: 10px;
        right: 20px;
        cursor: none;
        background: none;
        border: none;
    }
</style>