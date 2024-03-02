extern crate ncurses;

use ncurses::*;
use std::{thread, time};

fn render_map() {
    addstr("  ");
    for x in 0..0x10 {
        addstr(format!("{:0x} ", x).as_ref());
    }
    addstr("\n");

    for y in 0..0x10 {
        addstr(format!("{:0x} ", y).as_ref());
        for _x in 0..0x10 {
            addstr(". ");
        }
        addstr("\n");
    }
}

fn main() {
    let frame_delay = time::Duration::from_millis(250);
    let mut n : i64 = 0;
    let mut running = true;

    initscr();

    halfdelay(1);

    while running {
        clear();

        addstr(format!("Frame: {}\n", n).as_ref());
        render_map();
        n = n + 1;

        refresh();
        thread::sleep(frame_delay);

        let ch = getch();

        if ch == 'q' as i32 {
            running = false;
        }
    }

    endwin();
}
