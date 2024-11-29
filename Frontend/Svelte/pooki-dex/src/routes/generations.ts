export type Generation = {
    id: number,
    name: string,
    games: string[],
    main_region: string,
    pokemon_species?: string[],
}

export const generations: Generation[] = [
    {
        id: 1,
        name: 'Generation I',
        games: ['red', 'blue', 'yellow'],
        main_region: 'Kanto',
    },
    {
        id: 2,
        name: 'Generation II',
        games: ['gold', 'silver', 'crystal'],
        main_region: 'Johto',
    },
    {
        id: 3,
        name: 'Generation III',
        games: ['ruby', 'sapphire', 'emerald', 'firered', 'leafgreen'],
        main_region: 'Hoenn',
    },
    {
        id: 4,
        name: 'Generation IV',
        games: ['diamond', 'pearl', 'platinum', 'heartgold', 'soulsilver'],
        main_region: 'Sinnoh',
    },
    {
        id: 5,
        name: 'Generation V',
        games: ['black', 'white', 'black2', 'white2'],
        main_region: 'Unova',
    },
    {
        id: 6,
        name: 'Generation VI',
        games: ['x', 'y', 'omega-ruby', 'alpha-sapphire'],
        main_region: 'Kalos',
    },
    {
        id: 7,
        name: 'Generation VII',
        games: ['sun', 'moon', 'ultra-sun', 'ultra-moon'],
        main_region: 'Alola',
    },
    {
        id: 8,
        name: 'Generation VIII',
        games: ['sword', 'shield'],
        main_region: 'Galar',
    }
]
        
