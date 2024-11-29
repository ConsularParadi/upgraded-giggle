<script lang="ts">
    import type { IndexMonster } from "../routes/+page"
    import { page } from "$app/stores"; 
    import { goto } from "$app/navigation";

    export let monster: IndexMonster;
    export let isInteractive: boolean = false;

    // const handleKeyDown = (event: KeyboardEvent) => {
    //     if (event.key === "Enter") {
    //         updateSearchParams(monster);
    //     }
    // }

    const updateSearchParams = (key: string, value: string) => {
        const searchParams = new URLSearchParams($page.url.searchParams);
        searchParams.set(key, value)
        console.log(searchParams.toString())
        goto(`?${searchParams.toString()}`)
    }
</script>


<div class="monster">
    <div class="monster-content" on:click={() => isInteractive? updateSearchParams("monsterId", monster.id) : () => {}}>
        <div class="monster-id">{monster.id}</div>
        <img src={monster.image} alt={monster.name}/>
        <p class="monster-name">{monster.name}</p>
    </div>  
    {#if isInteractive}  
    <div class = "add-another" on:click={() => updateSearchParams("anotherMonsterId", monster.id)}>
        <p>Add as 2nd monster</p>
    </div>
    {/if}
</div>

<style>
    .monster {
        width: 150px;
        border: 1px solid black;
        margin: 10px;
        padding: 10px;
        position: relative;
        background-color: aliceblue;
    }

    .monster:hover {
        background-color: lightblue;
    }

    .monster-id {
        position: absolute;
        top: 8px;
        left: 8px;
        font-size: 0.8em;
        color: #aaa;
    }
    .monster-content {
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .monster-name {
        font-size: large;
    }

    .add-another {
        cursor: pointer;
        text-align: center;
        color: blue;
    }
</style>