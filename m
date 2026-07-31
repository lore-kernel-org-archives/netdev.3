Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6E43802C;
	Fri, 31 Jul 2026 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514748; cv=none; b=hsVy+A44RgdFPttMQHdv6lK2f53knymHcM9bpyXajrVBEPVME8fIQI8tmjrN9HUEhLPhXcdpb9IoyUlywral4iA/e9vjSURrdZ7NoEz4llxPBXeWZcFgsvyjavup6r8J5d0ex8gfCs8S+K1hUapPh8Z0hPHG48Poez9pX+3rCAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514748; c=relaxed/simple;
	bh=77dPU3aCVLiyLZPqpkAAbRzsa6LcmIYFGd9fJND0R4E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mXgV+uJdpjNJ+Cbea/CtAslxp36sQtEPis7sRznwvxPPfIcNI7lRX4vmPXBijV89Ax06wp2toMTPk3HL9wyme8rDr4Oa2eNNmBigf/lGGPTa1K3rofbpmCu5W3nIPzl4JzKDpZ5Bg9yQ20tb/DQ5+GDx+F8X2hPl2lnv3IQtOqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=t9nHkfaU; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=b2+THnQu; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="t9nHkfaU";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="b2+THnQu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514743;
	bh=77dPU3aCVLiyLZPqpkAAbRzsa6LcmIYFGd9fJND0R4E=;
	h=From:Subject:Date:To:Cc:From;
	b=t9nHkfaUh09OjX+aQyObImJlIiM5sC9L4NgPXC3sbb9+BVptSk9ZvfzNvIL1Devvh
	 wQp0TT+d7HdXpSC8fuUA3m+cHLgZPk4fPBlQiibnVKtIbWqloRT2DniP+8YVHddrG0
	 FV9xHVvA9HLdMGO1pfF8OgrV0KFEphELa9OXi9hHqArdksdkl0oUQD0rcnJdqrHQTp
	 PplBMihnoFWx+gDakxMB4FgmCkXYq9HKoHO+/BVwUYdoVIelBMJsBTh1PQcwwI9Zvo
	 A9cTWzN37XbZr1mWGTYUq1HegJw7xddWSIbN+sCwxbO7abwR2mFcWDCTtwom5NJHT4
	 ve68xfAZqkgGg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A3830494FA; Fri, 31 Jul 2026 16:19:03 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514742;
	bh=77dPU3aCVLiyLZPqpkAAbRzsa6LcmIYFGd9fJND0R4E=;
	h=From:Subject:Date:To:Cc:From;
	b=b2+THnQu3xt6xaDBZzYMJGsd5irTvSNW2zX1MCMaBUEF/nkfGH3pKdEJ6REOmFkSp
	 lpTS8D5bKDOnqbY4DjFkqEZJat7KqdnD/MgCgttY+699MdMGo7kjMg/KKDIGEpTgKK
	 F+kO0F3IuTFTYEyUAS78GdzRmqQfwiD1ti4qS/nV477Umn6E65WNsHZSbuPfmgLgMZ
	 Uch5sdTiU28R4qxD4RPSm+5Jcm/XeUdVEtzE9AMzKtRxSS6PGthvBET60wjkAA/GRQ
	 TvqqPWp3b1uwKsUtybUhn2tfgAUddFWaBKTpnhfCGRUorhJ6GoqyXUMaKlXEFFNZ7w
	 YCADVVYImEKdg==
Received: from ThinkPadAMD.lan (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 1D791494ED;
	Fri, 31 Jul 2026 16:19:02 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v4 00/12] ax88179_178a: Add support for
 AX88179A-based chips
Date: Fri, 31 Jul 2026 18:19:00 +0200
Message-Id: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPTKbGoC/3XNQQ6CMBQE0KuQrq35v6WluPIexkWxv9BowBRCU
 MLdbbqRhS4nM3mzspFioJGdipVFmsMYhj6F8lCwW2f7lnhwKTMBQoOWwO1iDFa15RadqT0JrCS
 wNH9G8mHJ1IX1NPGeloldU9OFcRriK3/MmPvMVYBfbkYOHKU2ynldKVTnJsSWIr8PzSNM76Ojj
 M1iD5gdIBIABsCTawSh/gfIHSDKHSAT0DhHpa9BGSN/Adu2fQBcLkqxNAEAAA==
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
Birger Koblitz (12):
      ax88179_178a: Fix endianness of pause watermark register
      ax88179_178a: Split driver into library and device specific code
      ax88179_178a: Add HW support for AX179A-based chips
      ax88179_178a: Add EEE configuration support for AX88179A MACs
      ax88179_178a: Add EEE configuration support for AX88179A PHYs
      ax88179_178a: Add VLAN offload support for AX88179A
      ax88179_178a: Add AX179A/AX279 multicast configuration
      ax88179_178a: Add Suspend/resume support for AX88179A/772D/279
      ax88179_178a: Add ethtool get_drvinfo
      ax88179_178a: update driver information
      ax88179_178a: Add support for AX88179A/772D/279 EEPROM access
      ax88796b: Add support for AX88772D, AX88179A and AX88279

 drivers/net/phy/ax88796b.c         |  192 ++++++
 drivers/net/usb/Kconfig            |    9 +-
 drivers/net/usb/Makefile           |    3 +-
 drivers/net/usb/ax88179_178a.c     |  664 ++-----------------
 drivers/net/usb/ax88179_lib.c      |  508 +++++++++++++++
 drivers/net/usb/ax88179_lib.h      |  357 +++++++++++
 drivers/net/usb/ax88179a_devices.c | 1245 ++++++++++++++++++++++++++++++++++++
 7 files changed, 2355 insertions(+), 623 deletions(-)
---
base-commit: 1a9edf8be190decb17227e3cba540513d93ebb85
change-id: 20260630-ax88179a-a1d89fe21730

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>

