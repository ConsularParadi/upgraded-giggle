fn main() {
    println!("Hello, world!");
    another_function(38);
    stmt_function();
    println!("{}", expr_function());
}

fn another_function(x: i32) {
    println!("Value given is {x}");
}

fn stmt_function(){
    let y = {
        let x = 3;
        x + 1
    };
    println!("The value of y is: {y}");
}

fn expr_function() -> i32{
    let x = 3;
    x + 1
}
