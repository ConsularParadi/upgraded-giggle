package main

import (
	"errors"
	"fmt"
	"unicode/utf8"
)

func main() {
	//VARIABLES
	var intNum int = 100 //16,32,64 defaults to system architecture (int)
	fmt.Println(intNum)

	var floatNum float64 = 99.1032                  //decides the precision of decimal values
	var result float64 = floatNum + float64(intNum) //cannot directly add int and float, have to typecast
	fmt.Println(result)

	var myString string = "Hello Moto"
	var yourString string = `Hello 
  Moto`
	fmt.Println(myString)
	fmt.Println(yourString)

	fmt.Println(
		len("Hello"),
	) // Gives bytes in string, follows utf-8 encoding and restricted by ASCII
	utf8.RuneCountInString("Hello") //Gives actual count of characters in string

	var myRune rune = 'a' // character in go
	fmt.Println(myRune)

	var myBoolean bool = false
	fmt.Println(myBoolean)

	// Decalre but not initialize - gives default value
	var intNum3 int
	fmt.Println(intNum3)

	myVar := "test" // can remove var keyword and initialize as follows
	fmt.Println(myVar)
	var var1, var2 int = 1, 2
	fmt.Println(var1, var2)

	const myConst string = "const value" //cannot be only declared

	//Calling a function
	var res, rem, err = printme(10, 5)
	// && -> and, || -> or
	// IF ELSE
	if err != nil {
		fmt.Printf(err.Error())
	} else if rem == 0 {
		fmt.Printf("Integer division is %v", res)
	} else {
		fmt.Printf("Integer division is %v with remainder %v", res, rem)
	}
	// SWITCH
	switch err {
	case nil:
		fmt.Printf("Success")
	default:
		fmt.Println(err.Error())
	}
	// ARRAYS
	var intArr [3]int //Fixed Length, Same type, Indexable, Contiguous in Memory, Zero indexed

	// Initializing arrays
	fmt.Println(intArr)
	var intArr2 [3]int = [3]int{1, 2}
	fmt.Println(intArr2)
	intArr3 := [3]int{1, 2, 3}
	fmt.Println(intArr3)
	intArr4 := [...]int{1, 23, 4, 5}
	fmt.Println(intArr4)

	intArr[1] = 12
	fmt.Println(intArr[0])
	fmt.Println(intArr[1 : 2+1])
	fmt.Println(&intArr[0])

	//SLICES - wrapper for arrays with additional capabilities
	//checks if existing array has space for more elements in memory else creates another array with updated elements
	fmt.Println("SLICES")
	//Initialization
	var intSlice []int32
	fmt.Println("Length: ", len(intSlice), "Capacity: ", cap(intSlice), " ", intSlice)
	var intSlice2 []int32 = []int32{4, 5, 6}
	fmt.Println("Length: ", len(intSlice2), "Capacity: ", cap(intSlice2), " ", intSlice2)
	//Using make function
	intSlice3 := make([]int32, 5, 8)
	fmt.Println(
		"Length: ",
		len(intSlice3),
		"Capacity: ",
		cap(intSlice3),
		" ",
		intSlice3,
	)
	// Values beyond length even if in capacity are not accessible
	intSlice = append(intSlice, 7)
	fmt.Println(intSlice)

	//MAPS - Dictionary, Key value pairs
	fmt.Println("MAPS")
	var myMap map[string]uint8 = make(map[string]uint8)
	fmt.Println(myMap)
	myMap["Rishi"] = 32
	myMap["Hello"] = 32
	fmt.Println(myMap["Rishi"])
	fmt.Println(myMap)

	var age, ok = myMap["Hello"] // Map always returns something even if key does not exist
	if ok {
		println(age)
	} else {
		println("Does not exist", age)
	}
	delete(myMap, "Rishi")
	fmt.Println(myMap)

	//LOOPS
	// For loop and while loop are both written using for loop

	for name, age := range myMap {
		fmt.Println(name, age)
	}
	for i, v := range intArr {
		fmt.Println(i, v)
	}
	//While loop
	for i := 0; i < 10; i++ {
		fmt.Println(i)
	}

}

// FUNCTIONS
func printme(num int, den int) (int, int, error) {
	var error error
	if den == 0 {
		error = errors.New("cannot divide by zero")
		return 0, 0, error
	}
	var result int = num / den
	var rem int = num % den
	return result, rem, error
}
