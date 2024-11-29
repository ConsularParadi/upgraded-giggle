<script lang="ts">
    // Can access page data that is specified in +page.ts load function
    import type { PageData } from "./$types";

    // Can access several information about page like url, route etc.
    import { page } from "$app/stores"; 
	import Monster from "../components/Monster.svelte";    
    import type { IndexMonster } from "./+page";
    import { generations } from "./generations";

    // Changes the url
	import { goto } from "$app/navigation";
    export let data: PageData;

    // $: is for reactivity (only required when derived data is used)
    $: monsterId = $page.url.searchParams.get('monsterId') || "";
    $: monster = data.monsters.find((monster: IndexMonster) => monster.id === monsterId);
    $: anotherMonsterId = $page.url.searchParams.get('anotherMonsterId') || "";
    $: anotherMonster = data.monsters.find((monster: IndexMonster) => monster.id === anotherMonsterId);
    $: activeGenerationId = $page.url.searchParams.get('generation') || "";

    // const monsterClick: any = (monster: IndexMonster) => {
    //     monsterId = monster.id;
    //     // `${}` is for adding variables to string
    //     goto(`?monsterId=${monsterId}`);
    // }

    let form = {
        searchString: ""
    }

    let searchString = ""

    $: selectedMonsters = data.monsters.filter((monster: IndexMonster) => {
        return monster.name.toLowerCase().includes(searchString.toLowerCase());
    })

    const submitSearch = (e: Event) => {
        searchString = form.searchString
    }

    const updateSearchParams = (key: string, value: string) => {
        const searchParams = new URLSearchParams($page.url.searchParams);
        searchParams.set(key, value)
        console.log(searchParams.toString())
        goto(`?${searchParams.toString()}`)
    }

</script>

{#if monster}
    <Monster monster={monster}/>
{/if}

{#if anotherMonster}
    <Monster monster={anotherMonster}/>
{/if}

<div class="generations">
{#each generations as generation (generation.id)}
    <button 
        class="generation"
        class:active = "{activeGenerationId === generation.id.toString() ? "active" : ""}"
        on:click={() => updateSearchParams("generation", generation.id.toString())}>
    {generation.main_region}
    </button>
{/each}
</div>

<form class="search-form" on:submit={submitSearch}>
<input class="search" type="text" bind:value={form.searchString} placeholder="Pokemon Name"/>
<input type="submit" value="Search"/>
</form>
<div class="monsters">
    {#each selectedMonsters as monster (monster.id)}
        <Monster monster={monster} isInteractive={true}/>
    {/each}
</div>

<style>
    .generations {
        display: flex;
        flex-direction: row;
        flex-wrap: wrap;
        justify-content: center;
    }
    .generation {
        margin: 10px;
        padding: 5px 10px;
        font-weight: bold;
        color: black;
        border: 1px solid black;
        justify-content: center;
        border-radius: 5px;
        cursor: pointer;
    }

    .generation.active {
        background-color: black;
        color: aliceblue;
    }

    .generation.active:hover {
        background-color: #444;
    }

    .generation:hover {
        background-color: lightgray;
        /* font-weight: bolder; */
    }

    .monsters {
        display: flex;
        flex-direction: row;
        flex-wrap: wrap;
        justify-content: center;
    }

    .search-form {
        display: flex;
        flex-direction: row;
        justify-content: center;
        margin: 10px 0px;
    }
    .search-form input[type="text"] {
        margin: 0px 5px;
        padding: 5px 10px;
        border-radius: 5px;
        width: 400px;
        border: 1px solid #333;;
    }

    .search-form input[type="submit"] {
        margin: 0px 5px;
        padding: 5px 10px;
        border-radius: 5px;
        background-color: aliceblue;
        border: 1px solid #333;
        font-weight: bold;
    }

    .search-form input[type="submit"]:hover {
        background-color: blue;
        color: white;
    }

</style>