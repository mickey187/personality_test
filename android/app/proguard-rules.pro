# WorkManager's Room-generated WorkDatabase gets its rawWorkInfoDao() accessor
# stripped by R8 full mode (used transitively via google_mobile_ads' background
# work), which crashes app startup with "Failed to create an instance of
# androidx.work.impl.WorkDatabase". Keep WorkManager's impl classes intact.
-keep class androidx.work.impl.** { *; }
-keep class androidx.work.WorkerParameters { *; }
-keep class * extends androidx.work.ListenableWorker { *; }

# Room-generated database/DAO implementations rely on matching abstract method
# signatures at runtime; don't let R8 strip or rename members on them.
-keep class * extends androidx.room.RoomDatabase { *; }
-keep @androidx.room.Entity class * { *; }
-dontwarn androidx.room.paging.**
