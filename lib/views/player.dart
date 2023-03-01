import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:music_player/constants/colors.dart';

import '../controllers/player_controller.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Obx(
            (() => Expanded(
                  child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 320,
                      width: 320,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: QueryArtworkWidget(
                        id: data[controller.playIndex.value].id,
                        type: ArtworkType.AUDIO,
                        artworkHeight: double.infinity,
                        artworkWidth: double.infinity,
                        nullArtworkWidget: const Icon(
                          Icons.music_note_outlined,
                          color: Colors.white,
                          size: 300,
                        ),
                      )),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(9),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(18))),
              child: Obx(
                () => Column(children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    data[controller.playIndex.value].displayNameWOExt,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    data[controller.playIndex.value].artist.toString(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w100, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Row(
                      children: [
                        Text(
                          controller.position.value,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: Slider(
                                thumbColor: Colors.lightGreen,
                                inactiveColor: bgDarkColor,
                                activeColor: sliderColor,
                                min: const Duration(seconds: 0)
                                    .inSeconds
                                    .toDouble(),
                                max: controller.max.value,
                                value: controller.value.value,
                                onChanged: (newValue) {
                                  controller.changeDurationToSeconds(
                                      newValue.toInt());
                                  newValue = newValue;
                                })),
                        Text(
                          controller.duration.value,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.playSong(
                              data[controller.playIndex.value - 1].uri,
                              controller.playIndex.value - 1);
                        },
                        icon: const Icon(
                          Icons.skip_previous_rounded,
                          color: bgDarkColor,
                          size: 42,
                        ),
                      ),
                      Obx(
                        () => CircleAvatar(
                          radius: 36,
                          backgroundColor: bgDarkColor,
                          child: Transform.scale(
                            scale: 2.5,
                            child: IconButton(
                                onPressed: () {
                                  if (controller.isPlaying.value) {
                                    controller.audioPlayer.pause();
                                    controller.isPlaying(false);
                                  } else {
                                    controller.audioPlayer.play();
                                    controller.isPlaying(true);
                                  }
                                },
                                icon: controller.isPlaying.value
                                    ? const Icon(
                                        Icons.pause,
                                        color: whiteColor,
                                      )
                                    : const Icon(
                                        Icons.play_arrow_rounded,
                                        color: whiteColor,
                                      )),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.playSong(
                                data[controller.playIndex.value - 1].uri,
                                controller.playIndex.value + 1);
                          },
                          icon: const Icon(
                            Icons.skip_next_rounded,
                            size: 42,
                            color: bgDarkColor,
                          ))
                    ],
                  )
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
