module LocalStorage exposing (..)

import Token exposing (Model, Msg(Save, Load, Loaded))
import Html exposing (Html, div, p, input, button, text)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (value)
import Html.App as App


main = 
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- TOKEN


type alias Model = 
  { tokenModel: Token.Model
  }


init : (Model, Cmd Msg)
init =
    (Model (Token.Model "" ""), Cmd.none)


-- UPDATE


type Msg
  = TokenUpdated Token.Msg


update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of
    TokenUpdated msg ->
          let 
              (newToken, cmd) = Token.update msg model.tokenModel
          in
              ({model | tokenModel = newToken }, Cmd.map TokenUpdated cmd)


-- VIEW


view : Model -> Html Msg
view model =
  div[]
    [
      (App.map TokenUpdated <| Token.view model.tokenModel)
    ]

subscriptions model = 
  Sub.none
