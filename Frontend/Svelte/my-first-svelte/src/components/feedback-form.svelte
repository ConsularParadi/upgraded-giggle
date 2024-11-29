<script lang="ts">

import { feedbackStore as FeedbackStore } from "./stores";

import Card from "../components/card.svelte";
import Button from "./button.svelte";
import RatingSelect from "./rating-select.svelte";

let text = "";
let btnDisabled = true;
let min = 10;
let msg: string | null = `The feedback is less than ${min} characters`; 
let rating: number = 10;

const handleInput = () => {
    if(text.trim().length <= min) {
        btnDisabled = true;
        msg = `The feedback is less than ${min} characters`;
    } else {
        btnDisabled = false;
        msg = null;
    }
}

const handleSelect = (e: CustomEvent) => {
    rating = e.detail;
}

const handleSubmit = () => {
    if(text.trim().length > min) {
        const newFeedback = {
            id: new Date().getTime(),
            text,
            rating: +rating
        }

        FeedbackStore.update((currentFeedback) => {
            return [newFeedback, ...currentFeedback]
        })
        text = '';
    }
}

</script>

<Card>
    <header>
    <h2>How would you rate your service with us?</h2>
    </header>
<form on:submit|preventDefault={handleSubmit}>
    <!--Rating Select-->
    <RatingSelect on:rating-select={handleSelect}>
    </RatingSelect>
    <div class="input-group">
        <input type="text" on:input={handleInput} bind:value={text} placeholder="Write a review">
        <Button disabled={btnDisabled} type="submit">Send</Button>
    </div>
    {#if msg}
    <div class="message">
        {msg}
    </div>
    {/if}
</form>
</Card>



<style>
    header {
        max-width: 470px;
        margin: auto;
    }
    .input-group {
    display: flex;
    flex-direction: row;
    align-items: center;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    overflow: hidden;
  }
  .input-group input {
    border: none;
    flex-grow: 1;
    padding: 10px;
  }
    .message {
        padding-top: 10px;
        text-align: center;
        color: #ff6a95;
    }  
</style>