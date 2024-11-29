import type { PageLoad } from './$types';

type ApiMonster = {
    name: string,
    url: string,
}

export type IndexMonster = ApiMonster & {
    id: string,
    image: string
} 

export const load = (async ( {fetch, url} ) => {
    const generation = url.searchParams.get('generation') || '1'
    const generationResponse = await fetch(`https://pokeapi.co/api/v2/generation/${generation}`)
    const generationJson = await generationResponse.json();

    const generationMonsters = generationJson.pokemon_species.map((monster: ApiMonster) => {
        let id: string = monster.url.split('/')[6]
        return {
            name: monster.name,
            url: monster.url,
            id: id,
            image: `https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${id}.png`
        }
    })

    return {
        monsters: generationMonsters
    }
}) satisfies PageLoad;