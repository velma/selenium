// Licensed to the Software Freedom Conservancy (SFC) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The SFC licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

package org.openqa.selenium.ie;

import com.google.auto.service.AutoService;

import org.openqa.selenium.Capabilities;
import org.openqa.selenium.ImmutableCapabilities;
import org.openqa.selenium.Platform;
import org.openqa.selenium.SessionNotCreatedException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebDriverException;
import org.openqa.selenium.WebDriverInfo;

import java.util.Optional;

import static org.openqa.selenium.remote.Browser.IE;
import static org.openqa.selenium.remote.CapabilityType.BROWSER_NAME;

@AutoService(WebDriverInfo.class)
public class InternetExplorerDriverInfo implements WebDriverInfo {

  @Override
  public String getDisplayName() {
    return "Internet Explorer";
  }

  @Override
  public Capabilities getCanonicalCapabilities() {
    return new ImmutableCapabilities(BROWSER_NAME, IE.browserName());
  }

  @Override
  public boolean isSupporting(Capabilities capabilities) {
    return IE.is(capabilities) ||
           capabilities.getCapability("se:ieOptions") != null;
  }

  @Override
  public boolean isSupportingCdp() {
    return false;
  }

  @Override
  public boolean isSupportingBiDi() {
    return false;
  }

  @Override
  public boolean isAvailable() {
    try {
      if (Platform.getCurrent().is(Platform.WINDOWS)) {
        InternetExplorerDriverService.createDefaultService();
        return true;
      }
      return false;
    } catch (IllegalStateException | WebDriverException e) {
      return false;
    }
  }

  @Override
  public int getMaximumSimultaneousSessions() {
    return 1;
  }

  @Override
  public Optional<WebDriver> createDriver(Capabilities capabilities)
      throws SessionNotCreatedException {
    if (!isAvailable()) {
      return Optional.empty();
    }

    return Optional.of(new InternetExplorerDriver(new InternetExplorerOptions().merge(capabilities)));
  }
}
