fn main() {
    //Variables
    let mut x = 5;
    println!("the value of x is {x}");
    x = 6;
    println!("the value of x is {x}");

    //Constants
    const THREE_HOURS_IN_SECONDS: u32 = 60*60*3;
    println!("value of constant is {THREE_HOURS_IN_SECONDS}"); 

    let x = 5;
    let x = x + 1;
    {
        let x = x * 2;
        println!("The value of x in inner scope: {x}");
    }
    println!("The value of x is {x}");
}
