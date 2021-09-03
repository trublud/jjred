ControlEnum = class(Enum)

-- Taken from here https://github.com/crosire/scripthookvdotnet/blob/master/source/scripting_v3/GTA/Control.cs
function ControlEnum:__init()
    self:EnumInit()

    self.NextCamera = 1
    self.LookLeftRight = 2
    self.LookUpDown = 3
    self.LookUpOnly = 4
    self.LookDownOnly = 5 
    self.LookLeftOnly = 6
    self.LookRightOnly = 7
    self.CinematicSlowMo = 8 
    self.FlyUpDown = 9
    self.FlyLeftRight = 10
    self.ScriptedFlyZUp = 11
    self.ScriptedFlyZDown = 12
    self.WeaponWheelUpDown = 13
    self.WeaponWheelLeftRight = 14
    self.WeaponWheelNext = 15
    self.WeaponWheelPrev = 16
    self.SelectNextWeapon = 17
    self.SelectPrevWeapon = 18
    self.SkipCutscene = 19
    self.CharacterWheel = 20
    self.MultiplayerInfo = 21
    self.Sprint = 22
    self.Jump = 23
    self.Enter = 24
    self.Attack = 25
    self.Aim = 26
    self.LookBehind = 27
    self.Phone = 28
    self.SpecialAbility = 29
    self.SpecialAbilitySecondary = 30
    self.MoveLeftRight = 31
    self.MoveUpDown = 32
    self.MoveUpOnly = 33
    self.MoveDownOnly = 34
    self.MoveLeftOnly = 35
    self.MoveRightOnly = 36
    self.Duck = 37
    self.SelectWeapon = 38
    self.Pickup = 39
    self.SniperZoom = 40
    self.SniperZoomInOnly = 41
    self.SniperZoomOutOnly = 42
    self.SniperZoomInSecondary = 43
    self.SniperZoomOutSecondary = 44
    self.Cover = 45
    self.Reload = 46
    self.Talk = 47
    self.Detonate = 48
    self.HUDSpecial = 49
    self.Arrest = 50
    self.AccurateAim = 51
    self.Context = 52
    self.ContextSecondary = 53
    self.WeaponSpecial = 54
    self.WeaponSpecial2 = 55
    self.Dive = 56
    self.DropWeapon = 57
    self.DropAmmo = 58
    self.ThrowGrenade = 59
    self.VehicleMoveLeftRight = 60
    self.VehicleMoveUpDown = 61
    self.VehicleMoveUpOnly = 62
    self.VehicleMoveDownOnly = 63
    self.VehicleMoveLeftOnly = 64
    self.VehicleMoveRightOnly = 65
    self.VehicleSpecial = 66
    self.VehicleGunLeftRight = 67
    self.VehicleGunUpDown = 68
    self.VehicleAim = 69
    self.VehicleAttack = 70
    self.VehicleAttack2 = 71
    self.VehicleAccelerate = 72
    self.VehicleBrake = 73
    self.VehicleDuck = 74
    self.VehicleHeadlight = 75
    self.VehicleExit = 76
    self.VehicleHandbrake = 77
    self.VehicleHotwireLeft = 78
    self.VehicleHotwireRight = 79
    self.VehicleLookBehind = 80
    self.VehicleCinCam = 81
    self.VehicleNextRadio = 82
    self.VehiclePrevRadio = 83
    self.VehicleNextRadioTrack = 84
    self.VehiclePrevRadioTrack = 85
    self.VehicleRadioWheel = 86
    self.VehicleHorn = 87
    self.VehicleFlyThrottleUp = 88
    self.VehicleFlyThrottleDown = 89
    self.VehicleFlyYawLeft = 90
    self.VehicleFlyYawRight = 91
    self.VehiclePassengerAim = 92
    self.VehiclePassengerAttack = 93
    self.VehicleSpecialAbilityFranklin = 94
    self.VehicleStuntUpDown = 95
    self.VehicleCinematicUpDown = 96
    self.VehicleCinematicUpOnly = 97
    self.VehicleCinematicDownOnly = 98
    self.VehicleCinematicLeftRight = 99
    self.VehicleSelectNextWeapon = 100
    self.VehicleSelectPrevWeapon = 101
    self.VehicleRoof = 102
    self.VehicleJump = 103
    self.VehicleGrapplingHook = 104
    self.VehicleShuffle = 105
    self.VehicleDropProjectile = 106
    self.VehicleMouseControlOverride = 107
    self.VehicleFlyRollLeftRight = 108
    self.VehicleFlyRollLeftOnly = 109
    self.VehicleFlyRollRightOnly = 110
    self.VehicleFlyPitchUpDown = 111
    self.VehicleFlyPitchUpOnly = 112
    self.VehicleFlyPitchDownOnly = 113
    self.VehicleFlyUnderCarriage = 114
    self.VehicleFlyAttack = 115
    self.VehicleFlySelectNextWeapon = 116
    self.VehicleFlySelectPrevWeapon = 117
    self.VehicleFlySelectTargetLeft = 118
    self.VehicleFlySelectTargetRight = 119
    self.VehicleFlyVerticalFlightMode = 120
    self.VehicleFlyDuck = 121
    self.VehicleFlyAttackCamera = 122
    self.VehicleFlyMouseControlOverride = 123
    self.VehicleSubTurnLeftRight = 124
    self.VehicleSubTurnLeftOnly = 125
    self.VehicleSubTurnRightOnly = 126
    self.VehicleSubPitchUpDown = 127
    self.VehicleSubPitchUpOnly = 128
    self.VehicleSubPitchDownOnly = 129
    self.VehicleSubThrottleUp = 130
    self.VehicleSubThrottleDown = 131
    self.VehicleSubAscend = 132
    self.VehicleSubDescend = 133
    self.VehicleSubTurnHardLeft = 134
    self.VehicleSubTurnHardRight = 135
    self.VehicleSubMouseControlOverride = 136
    self.VehiclePushbikePedal = 137
    self.VehiclePushbikeSprint = 138
    self.VehiclePushbikeFrontBrake = 139
    self.VehiclePushbikeRearBrake = 140
    self.MeleeAttackLight = 141
    self.MeleeAttackHeavy = 142
    self.MeleeAttackAlternate = 143
    self.MeleeBlock = 144
    self.ParachuteDeploy = 145
    self.ParachuteDetach = 146
    self.ParachuteTurnLeftRight = 147
    self.ParachuteTurnLeftOnly = 148
    self.ParachuteTurnRightOnly = 149
    self.ParachutePitchUpDown = 150
    self.ParachutePitchUpOnly = 151
    self.ParachutePitchDownOnly = 152
    self.ParachuteBrakeLeft = 153
    self.ParachuteBrakeRight = 154
    self.ParachuteSmoke = 155
    self.ParachutePrecisionLanding = 156
    self.Map = 157
    self.SelectWeaponUnarmed = 158
    self.SelectWeaponMelee = 159
    self.SelectWeaponHandgun = 160
    self.SelectWeaponShotgun = 161
    self.SelectWeaponSmg = 162
    self.SelectWeaponAutoRifle = 163
    self.SelectWeaponSniper = 164
    self.SelectWeaponHeavy = 165
    self.SelectWeaponSpecial = 166
    self.SelectCharacterMichael = 167
    self.SelectCharacterFranklin = 168
    self.SelectCharacterTrevor = 169
    self.SelectCharacterMultiplayer = 170
    self.SaveReplayClip = 171
    self.SpecialAbilityPC = 172
    self.PhoneUp = 173
    self.PhoneDown = 174
    self.PhoneLeft = 175
    self.PhoneRight = 176
    self.PhoneSelect = 177
    self.PhoneCancel = 178
    self.PhoneOption = 179
    self.PhoneExtraOption = 180
    self.PhoneScrollForward = 181
    self.PhoneScrollBackward = 182
    self.PhoneCameraFocusLock = 183
    self.PhoneCameraGrid = 184
    self.PhoneCameraSelfie = 185
    self.PhoneCameraDOF = 186
    self.PhoneCameraExpression = 187
    self.FrontendDown = 188
    self.FrontendUp = 189
    self.FrontendLeft = 190
    self.FrontendRight = 191
    self.FrontendRdown = 192
    self.FrontendRup = 193
    self.FrontendRleft = 194
    self.FrontendRright = 195
    self.FrontendAxisX = 196
    self.FrontendAxisY = 197
    self.FrontendRightAxisX = 198
    self.FrontendRightAxisY = 199
    self.FrontendPause = 200
    self.FrontendPauseAlternate = 201
    self.FrontendAccept = 202
    self.FrontendCancel = 203
    self.FrontendX = 204
    self.FrontendY = 205
    self.FrontendLb = 206
    self.FrontendRb = 207
    self.FrontendLt = 208
    self.FrontendRt = 209
    self.FrontendLs = 210
    self.FrontendRs = 211
    self.FrontendLeaderboard = 212
    self.FrontendSocialClub = 213
    self.FrontendSocialClubSecondary = 214
    self.FrontendDelete = 215
    self.FrontendEndscreenAccept = 216
    self.FrontendEndscreenExpand = 217
    self.FrontendSelect = 218
    self.ScriptLeftAxisX = 219
    self.ScriptLeftAxisY = 220
    self.ScriptRightAxisX = 221
    self.ScriptRightAxisY = 222
    self.ScriptRUp = 223
    self.ScriptRDown = 224
    self.ScriptRLeft = 225
    self.ScriptRRight = 226
    self.ScriptLB = 227
    self.ScriptRB = 228
    self.ScriptLT = 229
    self.ScriptRT = 230
    self.ScriptLS = 231
    self.ScriptRS = 232
    self.ScriptPadUp = 233
    self.ScriptPadDown = 234
    self.ScriptPadLeft = 235
    self.ScriptPadRight = 236
    self.ScriptSelect = 237
    self.CursorAccept = 238
    self.CursorCancel = 239
    self.CursorX = 240
    self.CursorY = 241
    self.CursorScrollUp = 242
    self.CursorScrollDown = 243
    self.EnterCheatCode = 244
    self.InteractionMenu = 245
    self.MpTextChatAll = 246
    self.MpTextChatTeam = 247
    self.MpTextChatFriends = 248
    self.MpTextChatCrew = 249
    self.PushToTalk = 250
    self.CreatorLS = 251
    self.CreatorRS = 252
    self.CreatorLT = 253
    self.CreatorRT = 254
    self.CreatorMenuToggle = 255
    self.CreatorAccept = 256
    self.CreatorDelete = 257
    self.Attack2 = 258
    self.RappelJump = 259
    self.RappelLongJump = 260
    self.RappelSmashWindow = 261
    self.PrevWeapon = 262
    self.NextWeapon = 263
    self.MeleeAttack1 = 264
    self.MeleeAttack2 = 265
    self.Whistle = 266
    self.MoveLeft = 267
    self.MoveRight = 268
    self.MoveUp = 269
    self.MoveDown = 270
    self.LookLeft = 271
    self.LookRight = 272
    self.LookUp = 273
    self.LookDown = 274
    self.SniperZoomIn = 275
    self.SniperZoomOut = 276
    self.SniperZoomInAlternate = 277
    self.SniperZoomOutAlternate = 278
    self.VehicleMoveLeft = 279
    self.VehicleMoveRight = 280
    self.VehicleMoveUp = 281
    self.VehicleMoveDown = 282
    self.VehicleGunLeft = 283
    self.VehicleGunRight = 284
    self.VehicleGunUp = 285
    self.VehicleGunDown = 286
    self.VehicleLookLeft = 287
    self.VehicleLookRight = 288
    self.ReplayStartStopRecording = 289
    self.ReplayStartStopRecordingSecondary = 290
    self.ScaledLookLeftRight = 291
    self.ScaledLookUpDown = 292
    self.ScaledLookUpOnly = 293
    self.ScaledLookDownOnly = 294
    self.ScaledLookLeftOnly = 295
    self.ScaledLookRightOnly = 296
    self.ReplayMarkerDelete = 297
    self.ReplayClipDelete = 298
    self.ReplayPause = 299
    self.ReplayRewind = 301
    self.ReplayFfwd = 302
    self.ReplayNewmarker = 303
    self.ReplayRecord = 304
    self.ReplayScreenshot = 305
    self.ReplayHidehud = 306
    self.ReplayStartpoint = 307
    self.ReplayEndpoint = 308
    self.ReplayAdvance = 309
    self.ReplayBack = 310
    self.ReplayTools = 311
    self.ReplayRestart = 312
    self.ReplayShowhotkey = 313
    self.ReplayCycleMarkerLeft = 314
    self.ReplayCycleMarkerRight = 315
    self.ReplayFOVIncrease = 316
    self.ReplayFOVDecrease = 317
    self.ReplayCameraUp = 318
    self.ReplayCameraDown = 319
    self.ReplaySave = 320
    self.ReplayToggletime = 321
    self.ReplayToggletips = 322
    self.ReplayPreview = 323
    self.ReplayToggleTimeline = 324
    self.ReplayTimelinePickupClip = 325
    self.ReplayTimelineDuplicateClip = 326
    self.ReplayTimelinePlaceClip = 327
    self.ReplayCtrl = 328
    self.ReplayTimelineSave = 329
    self.ReplayPreviewAudio = 330
    self.VehicleDriveLook = 331
    self.VehicleDriveLook2 = 332
    self.VehicleFlyAttack2 = 333
    self.RadioWheelUpDown = 334
    self.RadioWheelLeftRight = 335
    self.VehicleSlowMoUpDown = 336
    self.VehicleSlowMoUpOnly = 337
    self.VehicleSlowMoDownOnly = 338
    self.MapPointOfInterest = 339
    self.ReplaySnapmaticPhoto = 340
    self.VehicleCarJump = 341
    self.VehicleRocketBoost = 342
    self.VehicleParachute = 343
    self.VehicleBikeWings = 344
    self.VehicleFlyBombBay = 345
    self.VehicleFlyCounter = 346
    self.VehicleFlyTransform = 347
end

ControlEnum = ControlEnum()