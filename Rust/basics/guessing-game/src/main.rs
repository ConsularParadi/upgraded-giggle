use std::io;
use rand::Rng;
use std::cmp::Ordering;


fn main() {
    println!("THE GUESSING GAME");
    loop {
        println!("Please input your guess b/w 1 & 100: ");
        let mut guess = String::new();
        
        let secret_num = rand::thread_rng().gen_range(1..=100);

        io::stdin()
            .read_line(&mut guess)
            .expect("Failed to read line");
   
        println!("you guessed {guess}");

        let guess: u32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };

        match guess.cmp(&secret_num) {
            Ordering::Less => println!("Too small"),
            Ordering::Greater=> println!("Too big"),
            Ordering::Equal => {
                println!("You win");
                break;
            }
        }
    }
}
