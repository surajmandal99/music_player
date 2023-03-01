import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/constants/textStyle.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contorller = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 130, 167, 11),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: whiteColor))
        ],
        leading: const Icon(
          Icons.sort_rounded,
          color: whiteColor,
        ),
        title: const Center(
          child: Text(
            "Music Player",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
          future: contorller.audioQuery.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null,
          ),
          builder: (BuildContext context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                ),
              );
            } else if (snapshot.data!.isEmpty) {
              return Center(child: Text("No Songs found", style: ourStyle()));
            } else {
              print(snapshot.data);
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext contex, int index) {
                        return Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            child: Obx(
                              () => ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22)),
                                  tileColor: bgColor,
                                  title: Text(
                                    snapshot.data![index].displayNameWOExt,
                                    // textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: ourStyle(
                                      size: 17,
                                    ),
                                  ),
                                  subtitle: Text(
                                    // textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    "${snapshot.data![index].artist}",
                                    style: ourStyle(size: 14),
                                  ),
                                  leading: QueryArtworkWidget(
                                    id: snapshot.data![index].id,
                                    nullArtworkWidget: const Icon(
                                      Icons.music_note_rounded,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    type: ArtworkType.AUDIO,
                                  ),
                                  trailing:
                                      contorller.playIndex.value == index &&
                                              contorller.isPlaying.value
                                          ? const Icon(Icons.play_arrow,
                                              color: whiteColor, size: 30)
                                          : null,
                                  onTap: () {
                                    Get.to(
                                        () => Player(
                                              data: snapshot.data!,
                                            ),
                                        transition: Transition.downToUp);
                                    contorller.playSong(
                                        snapshot.data![index].uri, index);
                                  }),
                            ));
                      }));
            }
          }),
    );
  }
}
