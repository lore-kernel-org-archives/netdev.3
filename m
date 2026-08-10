Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056073D6CD3;
	Mon, 10 Aug 2026 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365232; cv=none; b=YiCWgkIi0UnCHOfgqRWHwcIhucCasCazP1w/4xaLhuA1FBBDDDyQYh++NUiySZXrfve2EUw5lnwaiwTcF+voQXrxQniwMqmt0bYT2eYNwx6M148PRO+i7F/7fzBkG1aGlpatrt3jN+46aHG3vgI1Vhx5xCYHWMkM5qLt8GWFyAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365232; c=relaxed/simple;
	bh=eGj38bVdMg6AXUQ51YvLCSiNN1BPHlLTO22c45ui93Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oprhdgRlj6K8e9G4jSGpsJpV/SP2K2i0iuLPWA9IAW7PnjWXpKaqaJRBniQqZSiBppjK++21vU+IURqqa4jEXMjWNhMIx1/p0I+huwwxFYc0IeOSmuGAZGcC5LFAs6z1cujyJmXjBhDHLVD8LaAdX1+ROzShKreA6Ed9mlCsx+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=alUsvXdI; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=uDR+ZwGw; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="alUsvXdI";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="uDR+ZwGw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365229;
	bh=eGj38bVdMg6AXUQ51YvLCSiNN1BPHlLTO22c45ui93Q=;
	h=From:Subject:Date:To:Cc:From;
	b=alUsvXdI0iBRUk+568uONngOVkzwa5lq3K7QOhHM9h0/FV8VW0ytNjBsSLIaw/C5B
	 89LBTMgzZN3E29Mhbpc0pV7ARP8VbSmwq59q9oCqfmQk/zYBx4TSFtFTI4xFiUhJv8
	 DgBEudzHo+0GpBOu9xtv6akdytiHhLUSeP8NSdxld4PE8VjPVfigUDACS+UKzQQNWX
	 gnHcj0CB/0HDZ6YZvSvEc61VlVAjJpJefdmxuq2WSc2McKztvKu9XsOl0cFXrDr/Hr
	 qPx9sMGtLFb8AIo7fJgDAF4nZT+1bu+iJFhfkvkEVwWwj2UeEtP6qbHZV/elQBuRpK
	 LmUcdNJhGLOhA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 07ED14976C; Mon, 10 Aug 2026 12:33:49 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365216;
	bh=eGj38bVdMg6AXUQ51YvLCSiNN1BPHlLTO22c45ui93Q=;
	h=From:Subject:Date:To:Cc:From;
	b=uDR+ZwGw2dggz21lH2eGMTRArWVO8VGMhePCEEfGT2Cr7vdAz0G81glEVfCqz30ka
	 xBRyeWmJ1SwctcMvqjTTJ/Ugo4EL0In7OcImkSdwlULd2Ci2ayBtmIDofDRgAv50QC
	 WhbFzPTVER3Q8tWRJKez9JFVzOQ9di8ekdwAXdZqPkDN9TBm1hQEGWKYmPxtLAdFMM
	 choXKTxw4Zzz/uLD4auSt4GUdkOe/3cfQU4RVfnFc2Y8nFGDiDpbGtQaMBVQZ7vymx
	 KW3AdyRFoh47J2UbDoVdgtPpuJpEF0H0t/JjDK72n7cDXOsw5/OKMrNFZ8E3CUAmHs
	 vAownVnxUZ+ow==
Received: from DebianDesktop.lan (p200300c69f06340062b039dfa3272a8e.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:62b0:39df:a327:2a8e])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C95594976C;
	Mon, 10 Aug 2026 12:33:35 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v7 00/14] ax88179_178a: Add support for
 AX88179A-based chips
Date: Mon, 10 Aug 2026 14:33:25 +0200
Message-Id: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABXFeWoC/3XQTWrEMAwF4KsMXtfF8n+66j1KF3Ykz5iWZHBCS
 Dvk7jXejBfNUjzxCb0HW6hkWtjb5cEKbXnJ81QH93Jh4y1MV+IZ68ykkFZYJXjYvQc3BB4A/ZB
 IglOC1fV7oZT3Rn2wiVY+0b6yz5rc8rLO5afd2KDljXMCntwGXHBQ1htM1hkw7zGXKxX+Ncfvv
 P6+IjVskz3gO0BWQHghEmGUBPYMUB0gdQeoCkRE0mkQxnt1BugOUP0LugJyTJAcRECUZ4B5Al7
 IDjAVwDHWWoMOI+ozwPaA7QBbgYTkNGgLA/3bwXEcf5XmhA73AQAA
X-Change-ID: 20260630-ax88179a-a1d89fe21730
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

This adds support for the current generation of ASIX network adapter chips,
which are based on the AX88179A. This includes the AX88179A/B (1GBit-PHY),
AX88772D/E (100MBit) and AX88279 (2.5GBit).

The AX179A-based chips all provide both a CDC-NCM compatible USB interface,
and a proprietary vendor interface with more features. By default, the
proprietary vendor interface is not active and Linux will load the CDC-NCM
driver to support the devices. If the ax88179_178a module is configured by
the OS to have precedence over CDC-NCM, then this driver will switch the
device to use the vendor interface, and the device will be controlled by
the ax88179_178a driver when the device is probed again after an automatic
reset of the device bringing up the vendor interface.

The following hardware was tested:
Delock 66046 2.5GBit adapter (AX88279, FW: 1.2.0.0)
TP-Link UE306 1GBit adapter (AX88179B, FW: 1.3.0.0)
Renkforce RF-4708614 1GBit adapter (AX88179A, FW: 1.0.4.0)
UGREEN CR110 100MBit adapter (AX88722E, FW: 1.3.0.0)

The driver supports the following features
- EEE
- TCP segmentation offload
- VLAN filtering/tagging offload 
  (NETIF_F_HW_VLAN_CTAG_FILTER, NETIF_F_HW_VLAN_CTAG_RX/TX)
- RX/TX checksum offload
- FC/Pause configuration
- EEPROM read access

The code is based on the ASIX 4.1.0 out-of-tree driver published under
the GPL,, the aqc111 driver which provides support for the AX88279A,
and some tracing of USB-transfers of the Windows-driver.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Tested-by: Jianhui Xu <neuromoments@gmail.com>
---
Changes in v7:
- Add phylink_mac_interrupt() function to phylink and stop
  polling the PHY to prevent a race condition between the controller
  and phylink when configuring a new link.
- Fix typo in ax88179_read_cmd Reported-by: Jianhui Xu <neuromoments@gmail.com>
- Return -EOPNOTSUPP in asix_ax88279_config_aneg when autoneg is being disabled
- Link to v6: https://lore.kernel.org/r/20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de

Changes in v6:
- Use genphy_read_status() in asix_ax88279_read_status()
- Use SGMII and 2500BaseX interfaces for PHY
- Fix speed determination of MAC/PHY link
- Fix bulk transfer configuration to use enums for bulk configuration types
- Link to v5: https://lore.kernel.org/r/20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de

Changes in v5:
- Fixed read_status() and config_aneg() in PHY driver
- Introduced netdev2data() as convenience function
- netdev_info instances and debugging relicts removed
- Several instances of badly written/formatted code that was copy and pasted from
  the original driver corrected
- select PHYLINK added to Kconfig when phylib dependency added
- PHYLINK selects PHYLIB, so not needed to specify separately
- Link to v4: https://lore.kernel.org/r/20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de

Changes in v4:
- Split driver into library part and part2 for AX88179 and AX88179A-based
  controllers
- Driver renamed ax88179
- Improved phylink use: use phylink standard functions for speed and EEE-settings,
  correct MAC capabilities, removed ax88179_status() irq-urb callback
- Fixes in PHY driver for AX88179A integrated PHYs
- Link to v3: https://lore.kernel.org/r/20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de

Changes in v3:
- Add PHY drivers for the PHYs of the AX88179A-based controllers
- Use phylink for the AX88179A-based chips
- Link to v2: https://lore.kernel.org/r/20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de

Changes in v2:
- Correctly use net-next prefix
- Fix compilation issue in HW support patch
- Split MMD support patch into patches for EEE/new chip support
- Do not use ADVERTISE_RESV but private flag definition
- Fix pause configuration to keep track of settings when autoneg disabled
- Fix issue with unitialized variable reported by kernel test robot <lkp@intel.com>
- Avoid white-space changes

- Link to v1: https://lore.kernel.org/r/20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de

---
Birger Koblitz (14):
      phylink: Add phylink_mac_interrupt
      ax88179_178a: Fix endianness of pause watermark register
      ax88179_178a: Split driver into library and device specific code
      ax88179_178a: Add netdev2data() convenience function
      ax88179_178a: Add HW support for AX179A-based chips
      ax88179_178a: Add EEE configuration support for AX88179A MACs
      ax88179_178a: Add EEE configuration support for AX88179A PHYs
      ax88179_178a: Add VLAN offload support for AX88179A
      ax88179_178a: Add AX179A/AX279 multicast configuration
      ax88179_178a: Add Suspend/resume support for AX88179A/772D/279
      ax88179_178a: Add ethtool get_drvinfo
      ax88179_178a: Update driver name and information
      ax88179_178a: Add support for AX88179A/772D/279 EEPROM access
      ax88796b: Add support for AX88772D, AX88179A and AX88279

 MAINTAINERS                        |    6 +
 drivers/net/phy/ax88796b.c         |  180 ++++++
 drivers/net/phy/phylink.c          |   16 +
 drivers/net/usb/Kconfig            |   10 +-
 drivers/net/usb/Makefile           |    3 +-
 drivers/net/usb/ax88179_178a.c     |  664 ++------------------
 drivers/net/usb/ax88179_lib.c      |  515 +++++++++++++++
 drivers/net/usb/ax88179_lib.h      |  358 +++++++++++
 drivers/net/usb/ax88179a_devices.c | 1222 ++++++++++++++++++++++++++++++++++++
 include/linux/phylink.h            |    1 +
 10 files changed, 2351 insertions(+), 624 deletions(-)
---
base-commit: 1a9edf8be190decb17227e3cba540513d93ebb85
change-id: 20260630-ax88179a-a1d89fe21730

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>

