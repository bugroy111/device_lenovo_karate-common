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

namespace android {
     extern "C" void ashmem_init() {}
     extern "C" void createProcessGroup() {}
     extern "C" void killProcessGroup() {}
     extern "C" void qtaguid_tagSocket() {}
     extern "C" void qtaguid_untagSocket() {}
     extern "C" void qtaguid_setCounterSet() {}
     extern "C" void qtaguid_deleteTagData() {}
     extern "C" void removeAllProcessGroups() {}
     extern "C" void UsePerAppMemcg() {}
     extern "C" void _ZN7android6Parcel24readCallingWorkSourceUidEv() {}
     extern "C" void _ZN7android6Parcel27replaceCallingWorkSourceUidEj() {}
     extern "C" void _ZNK7android14IPCThreadState13isServingCallEv() {}
     extern "C" void _ZN7android14IPCThreadState22clearCallingWorkSourceEv() {}
     extern "C" void _ZN7android14IPCThreadState23setCallingWorkSourceUidEj() {}
     extern "C" void _ZNK7android14IPCThreadState23getCallingWorkSourceUidEv() {}
     extern "C" void _ZN7android14IPCThreadState24restoreCallingWorkSourceEx() {}
}
