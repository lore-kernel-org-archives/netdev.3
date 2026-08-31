Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8F3F1656;
	Mon, 31 Aug 2026 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170892; cv=none; b=aaeS/RwUlOun7HxYPz+lzTuUUN5oMH4ofOhC1/nYa52LYc22rnJD/jcXDfwE3GLMBYFe17PvmWfVQvQBB/NxAq431sJW1guFe6mHR+KOv6jGv+i9MASv93W58yQPv11SFG+Bana8vO3z7O51P0EcOjyBL2kTOt5H+mTfj9IIzW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170892; c=relaxed/simple;
	bh=rrvu1D1uh6lhftC4Nqqp85VInlE6jcsyNcH8Oj1qMdA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FGePhYEpgAnSiz0oT5F1Qd22Xi6I/uYJJ/rEwBCeshWmD4MrPBXX1abFuJJdOWdNEatmT5f8gqTEekrf0aZU01YX3HFPVAfsIrG+/utYRT1gUJq6qUrVtlA7KnA73IYjrNCs9E/ybxDY/iKvVYJKKtqextUZZghOrMFo4yF639o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=FjZvGscn; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=kIFxinwi; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="FjZvGscn";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="kIFxinwi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170338;
	bh=rrvu1D1uh6lhftC4Nqqp85VInlE6jcsyNcH8Oj1qMdA=;
	h=From:Subject:Date:To:Cc:From;
	b=FjZvGscnm566tGA2t1r92MYr+tgk21eUUAR3uS9E8Mck8B5ZYqyZACqUbYvYotRgj
	 EApaxTE2ktTPCFzQmfDwPrMGiejK6U9UMNTYATTWCrSy55smyQKne0K5eLYlUBKtJs
	 H9r71P696iOSqLO/HMNCibLqaXqD+N1XrJg+vpKyEyV9GeZ9fSo3dEryRZUcQgSdlP
	 FBX+biVwnM2JbWYzwNhuvZ2R23mFIHhj+J50EtxKc+Xzh3Jxv+QHKC3r1FDS1Gxp7g
	 ftCIPRsddeiznsH9z/uDl86x/KOsmxlXb/kDlubspI/YkYxScGcM097ftaRe+9Tc7v
	 BLNa3Q2VEKM7g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 40DAE3EC67; Mon, 31 Aug 2026 09:58:58 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170336;
	bh=rrvu1D1uh6lhftC4Nqqp85VInlE6jcsyNcH8Oj1qMdA=;
	h=From:Subject:Date:To:Cc:From;
	b=kIFxinwiKc/FCeWxUX9FNPyo1jfbQc7mv6lvLVMtwWvkqZt4o58VH0KyzUT7Wctku
	 bTCrpSm5bgWxFVH9BrV93BQBrIktCpQN9USPY10uKsnjH/vF40M+94bc7xDaarTrrm
	 aV6Bxe3MiKvyg6YDvY1UgtCioABPSNmEJXCPf0ZoH4c17lYZwUi3CC1dz84AiSRdgH
	 QXgG7+omCye0zmPf7Di7BMeDZjdefUO841oPSSBqJuKi8gHdfjW99L3c/rwOhnPzDY
	 YpSJQzpJAR00YiXNnbIOVOxobvdmLmc7W6Z3a28pA4UiTjISMlNfCqOpXvijGGWDgL
	 JkkIjx+VOXY1A==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 635123EC1C;
	Mon, 31 Aug 2026 09:58:56 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v8 00/15] ax88179_178a: Add support for
 AX88179A-based chips
Date: Mon, 31 Aug 2026 11:58:49 +0200
Message-Id: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFlQlWoC/3XRS07EMAwA0KuMsiYozj+suAdikdTOTARqUVpVh
 VHvTuhmsqBLy9bz785mqoVm9nK5s0prmcs0tsA/Xdhwi+OVeMEWMymkFVYJHjfvwYXII6APmSQ
 4JVgr/6qUy3ZQb2ykhY+0Ley9ZW5lXqb6ffRY4cgfnBPw4FbggoOy3mC2zoB5TaVeqfKPKX2W5
 ecZ6cBW2QO+A2QDhBciEyZJYM8A1QFSd4BqQEIknYMw3qszQHeA6lfQDZBDhuwgAaI8A8wD8EJ
 2gGkADqmdNeo4oD4DbA/YDrANyEhOg7YQ6PQGrgOge+rq/iaIVikIMIAM/wH7vv8CcLqJejgCA
 AA=
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
Changes in v8:
- Fix resume sequence as Suggested-by: Jianhui Xu <neuromoments@gmail.com>
- Add handling of PHYs with broken forced mode in phylib to handle AX88279 PHY
- Multple formatting fixes
- Fix transiently unused functions ax88179a_mac_disable_tx_lpi() and
  ax88179a_mac_enable_tx_lpi()
- Removed unnecessary checks for dev initialized
- Link to v7: https://lore.kernel.org/r/20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de

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
Birger Koblitz (15):
      phylink: Add phylink_mac_interrupt
      phylib: Add support for PHYs with broken forced mode
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
 drivers/net/phy/phy.c              |    4 +
 drivers/net/phy/phylink.c          |   16 +
 drivers/net/usb/Kconfig            |   10 +-
 drivers/net/usb/Makefile           |    3 +-
 drivers/net/usb/ax88179_178a.c     |  664 ++------------------
 drivers/net/usb/ax88179_lib.c      |  506 +++++++++++++++
 drivers/net/usb/ax88179_lib.h      |  358 +++++++++++
 drivers/net/usb/ax88179a_devices.c | 1222 ++++++++++++++++++++++++++++++++++++
 include/linux/phy.h                |    1 +
 include/linux/phylink.h            |    1 +
 12 files changed, 2347 insertions(+), 624 deletions(-)
---
base-commit: 1a9edf8be190decb17227e3cba540513d93ebb85
change-id: 20260630-ax88179a-a1d89fe21730

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>

