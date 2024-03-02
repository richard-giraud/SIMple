fn render_map() {
    print!("  ");
    for x in 0..0x10 {
        print!("{:0x} ", x);
    }
    print!("\n");

    for y in 0..0x10 {
        print!("{:0x} ", y);
        for _x in 0..0x10 {
            print!(". ");
        }
        print!("\n");
    }
}

fn main() {
    render_map();
}
