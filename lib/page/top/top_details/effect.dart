import 'package:bujuan/entity/top_entity.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutterstarrysky/song_info.dart';
import 'action.dart';
import 'state.dart';

Effect<TopDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<TopDetailsState>>{TopDetailsAction.playSong: _onPlaySong, Lifecycle.initState: _init});
}

void _onPlaySong(Action action, Context<TopDetailsState> ctx) async {
//  SpUtil.putBool(ISFM, false);
//  var index2 = action.payload;
//  var list2 = ctx.state.list;
//  GlobalStore.store
//      .dispatch(GlobalActionCreator.changeCurrSong(ctx.state.list[index2]));
//  SpUtil.putObjectList(playSongListHistory, ctx.state.list);
//  var jsonEncode2 = jsonEncode(list2);
//  BujuanMusic.sendSongInfo(songInfo: jsonEncode2, index: index2);
  var list = ctx.state.list;
  var index = action.payload??0;
  NetUtils().setPlayListAndPlayById(list, index, '${ctx.state.id}');
}

void _init(Action action, Context<TopDetailsState> ctx) async{
  var topEntity = await _getTopData(ctx.state.id);
  ctx.dispatch(TopDetailsActionCreator.onGetTop(await _changeType(topEntity)));
}

Future<List<SongInfo>> _changeType(TopEntity topEntity) async {
  var playlist = topEntity.playlist;
  var songToSongInfo = await BuJuanUtil.songToSongInfo(playlist.tracks);
  return songToSongInfo;
}

Future<TopEntity> _getTopData(id) async {
//  var answer = await top_list({'idx': id},await BuJuanUtil.getCookie());
//  Response top = await HttpUtil().get('/top/list', data: {'idx': id});
//  var data2 = top.data;
//  var jsonDecode2 = jsonDecode(data2);
  return NetUtils().getTopData(id);
}
