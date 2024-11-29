import { writable } from "svelte/store";

export const feedbackStore = writable([
    {
        id: 1,
        rating: 10,
        text: 'Feedback 1',
      },
      {
        id: 2,
        rating: 9,
        text: 'Feedback 2',
      },
      {
        id: 3,
        rating: 8,
        text: 'Feedback 3',
      }
])