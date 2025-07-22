class Players {
  String _player_x_name;
  String _player_o_name;

  Players(this._player_x_name, this._player_o_name);

  String toStringPlayerX() {
    return _player_x_name;
  }

  String toStringPlayerO() {
    return _player_o_name;
  }
}