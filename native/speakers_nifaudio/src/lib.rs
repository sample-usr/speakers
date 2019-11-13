#[macro_use]
extern crate lazy_static;

use rustler::{Encoder, Env, Error, Term};
use std::io::BufReader;
use std::fs::File;

mod atoms {
    rustler::rustler_atoms! {
        atom ok;
        //atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

rustler::rustler_export_nifs! {
    "Elixir.Speakers.NifAudio",
    [
        ("add_to_queue", 1, add_to_queue),
        ("pause", 0, pause),
        ("resume", 0, resume),
        ("get_queue_len", 0, get_queue_len),
        ("get_volume", 0, get_volume),
        ("set_volume", 1, set_volume)
    ],
    None
}

lazy_static! {
    static ref CURRENT_SINK: rodio::Sink = {
        let device = rodio::default_output_device().unwrap();
        let sink = rodio::Sink::new(&device);
        sink
    };
}

fn pause<'a>(env: Env<'a>, _args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    CURRENT_SINK.pause();
    Ok((atoms::ok()).encode(env))
}

fn resume<'a>(env: Env<'a>, _args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    CURRENT_SINK.play();
    Ok((atoms::ok()).encode(env))
}

fn get_queue_len<'a>(env: Env<'a>, _args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let queue_len = CURRENT_SINK.len();
    Ok((atoms::ok(), queue_len).encode(env))
}

fn add_to_queue<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let file_path: &str = args[0].decode()?;
    let audio_file = File::open(file_path).unwrap();

    CURRENT_SINK.append(rodio::Decoder::new(BufReader::new(audio_file)).unwrap());

    Ok((atoms::ok()).encode(env))
}

fn get_volume<'a>(env: Env<'a>, _args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let current_volume = CURRENT_SINK.volume();
    Ok((atoms::ok(), current_volume).encode(env))
}

fn set_volume<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let new_volume: f32 = args[0].decode()?;
    let new_set_volume = CURRENT_SINK.set_volume(new_volume);
    Ok((atoms::ok(), new_set_volume).encode(env))
}