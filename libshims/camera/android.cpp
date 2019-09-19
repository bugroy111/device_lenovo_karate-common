/*
 * Copyright (C) 2020 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <stdint.h>

namespace android {
    extern "C" void ALooper_forThread() {}
    extern "C" void ALooper_pollOnce() {}
    extern "C" void ALooper_prepare() {}
    extern "C" void ALooper_wake() {}
    extern "C" void ASensor_getMaxRange() {}
    extern "C" void ASensor_getMinDelay() {}
    extern "C" void ASensor_getName() {}
    extern "C" void ASensor_getVendor() {}
    extern "C" void ASensorEventQueue_disableSensor() {}
    extern "C" void ASensorEventQueue_enableSensor() {}
    extern "C" void ASensorEventQueue_getEvents() {}
    extern "C" void ASensorEventQueue_setEventRate() {}
    extern "C" void ASensorManager_createEventQueue() {}
    extern "C" void ASensorManager_destroyEventQueue() {}
    extern "C" void ASensorManager_getDefaultSensor() {}
    extern "C" void ASensorManager_getInstanceForPackage() {}

    extern "C" void _ZNK7android6Sensor11getMaxValueEv() {}
}
