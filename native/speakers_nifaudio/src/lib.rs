#[macro_use]
extern crate lazy_static;

use rustler::{Encoder, Env, Error, Term};
use std::io::Cursor;

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
    Ok(format!("Player::Paused").encode(env))
}

fn resume<'a>(env: Env<'a>, _args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    CURRENT_SINK.play();
    Ok(format!("Player::Resumed").encode(env))
}

fn get_queue_len<'a>(env: Env<'a>, _args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let queue_len = CURRENT_SINK.len();
    Ok((queue_len).encode(env))
}

fn add_to_queue<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let audio_url: &str = args[0].decode()?;

    let mut audio_stream = reqwest::get(audio_url).expect("Failed to get audio stream");
    let mut audio_buffer = vec![];
    audio_stream.copy_to(&mut audio_buffer).expect("Failed to copy stream to audio buffer");

    CURRENT_SINK.append(rodio::Decoder::new(Cursor::new(audio_buffer)).unwrap());

    Ok(format!("Player::Added_To_Queue").encode(env))
}

fn get_volume<'a>(env: Env<'a>, _args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let current_volume = CURRENT_SINK.volume();
    Ok((current_volume).encode(env))
}

fn set_volume<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let new_volume: f32 = args[0].decode()?;
    let new_set_volume = CURRENT_SINK.set_volume(new_volume);
    Ok((new_set_volume).encode(env))
}