use leptonic::prelude::*;
use leptos::*;

#[component]
pub fn App(cx: Scope) -> impl IntoView {
    view! { cx, <Root default_theme=LeptonicTheme::default()>"Content goes here :)"</Root> }
}

fn main() {
    mount_to_body(App)
}
