port module Token exposing (Model, Msg, update, Msg(..), view)
{-| The goal of this exercise is to see if I can use local storage to store 
the details of something - in this case a user's login details - and then 
retrieve the details later in a module that has no view. The latter point
is relevant because it means that I can use subscriptions in modules that
have no view, if I want to. -}

import Html exposing (Html, div, p, text, input, button)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput, onClick)


-- MODEL: We just want a model that takes a token as a string


type alias Model = 
  { token: String
  }

-- UPDATE


type Msg
  = Save
    | Load
    | Loaded String
    | SetToken String


port save: String -> Cmd msg

port load: String -> Cmd msg


update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of
    SetToken t ->
      ({model | token = t}, Cmd.none)

    Save ->
      ({model | token = "saved"}, save model.token)

    Load ->
      ({ model | token = "loading" }, load "")

    Loaded token ->
        ({ model | token =  "loaded: " ++ token }, Cmd.none)


-- SUBSCRIPTIONS


port loadToken : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model = 
  loadToken Loaded


view : Model -> Html Msg
view model = 
  div [] 
    [
      button [onClick Save] [ text "Save" ]
    , button [onClick Load] [ text "Load" ]
    , input [onInput SetToken, value model.token ] []
    , p[] [text model.token]
    ]
