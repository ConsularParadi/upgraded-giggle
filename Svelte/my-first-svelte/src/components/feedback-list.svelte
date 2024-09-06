<script lang="ts">
    import {onMount, onDestroy} from 'svelte';
    import { feedbackStore as FeedbackStore } from './stores';
    import {fade, fly} from 'svelte/transition';
    import FeedbackItem from "./feedback-item.svelte";
    let feedback: {id: number, text: string, rating: number}[] = [];
    let item: {id: number, text: string, rating: number};

    // const unsubsribe = feedbackStore.subscribe((data) => {
    //     feedback = data
    // })

    // onMount(() => {
    //     console.log("mounted");
    // })

    // onDestroy(() => {
    //     console.log("destroyed");
    //     unsubsribe()
    // })

</script>

{#each $FeedbackStore as item}
<div in:fly="{{x: -300}}" out:fade="{{duration: 300}}">
    <FeedbackItem {item}/>
</div>
{/each}
