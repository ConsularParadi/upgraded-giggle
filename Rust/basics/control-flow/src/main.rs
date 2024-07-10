use std::io;

fn main() {
    // if-else
    let mut nput = String::new();

    io::stdin()
        .read_line(&mut nput)
        .expect("Failed to read std input");

    let num: i32 = nput
        .trim()
        .parse()
        .expect("Input not an integer");

    if num < 5 {
        println!("condition -> True");
    } else {
        println!("condition -> False");
    }
    
    let mut condition = false;

    // if-elseif-else
    if num%2 == 0 {
        println!("Number divisible by 2");
        condition = true;
    } else if num%3 == 0 {
        println!("Number divisible by 3"); 
    } else {
        println!("Number not divisble by 2 or 3");
    }

    let result = if condition {"Found IT"} else {"NOT Found"};

    println!("{result}");
}
