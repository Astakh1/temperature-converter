use temperature_converter::convert_temperature;

fn main() {
    println!("30°C = {} K", convert_temperature(30.0, "C", "K").unwrap());
    println!("100°F = {} K", convert_temperature(100.0, "F", "K").unwrap());
    println!("-10°C = {} °F", convert_temperature(-10.0, "C", "F").unwrap());
}