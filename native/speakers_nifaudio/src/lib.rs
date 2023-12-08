#[macro_use]
extern crate lazy_static;

use std::fs::File;
use std::io::BufReader;

mod atoms {
    rustler::atoms! {
        ok,
        //atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

rustler::init!(
    "Elixir.Speakers.NifAudio",
    [
        add_to_queue,
        pause,
        resume,
        get_queue_len,
        get_volume,
        set_volume
    ]
);

lazy_static! {
    static ref CURRENT_SINK: rodio::Sink = {
        let device = rodio::default_output_device().unwrap();

        rodio::Sink::new(&device)
    };
}

#[rustler::nif]
fn pause()  -> rustler::Atom {
    CURRENT_SINK.pause();
    atoms::ok()
}

#[rustler::nif]
fn resume() -> rustler::Atom {
    CURRENT_SINK.play();
    atoms::ok()
}

#[rustler::nif]
fn get_queue_len() -> (rustler::Atom, usize) {
    (atoms::ok(), CURRENT_SINK.len())
}

#[rustler::nif]
fn add_to_queue(file_path: &str) -> rustler::Atom {
    let audio_file = File::open(file_path).unwrap();

    CURRENT_SINK.append(rodio::Decoder::new(BufReader::new(audio_file)).unwrap());

    atoms::ok()
}

#[rustler::nif]
fn get_volume() -> (rustler::Atom, f32) {
    let current_volume = CURRENT_SINK.volume();
    (atoms::ok(), current_volume)
}

#[rustler::nif]
fn set_volume(new_volume: f32) -> (rustler::Atom, f32) {
    CURRENT_SINK.set_volume(new_volume);
    (atoms::ok(), new_volume)
}
