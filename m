Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A409440F721;
	Tue, 29 Sep 2026 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651958; cv=none; b=EdRWsmLdJLhMr5ep8fO/Xe4832u7cYtVSQYn4C9Ku7XOmk5q4b1R5MMJJVS19QFPSpckItKMN8uCG8eE6tzO74kEDcKdi8xPPIzYMJ81uALvWwdEwSFlbvhybaT3YNtGxHAMCyWLwYq7FUDD2IX1DX9kCU4w7ea+hpV2HdLNYpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651958; c=relaxed/simple;
	bh=1TaoxoaKIr+XKvEfbqU46Kdw93DxMwV3OcOPhmb6yrw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FGbu+YQxsizq5/tPplShJpPxtOaDbbwz8mJh0K5etwA0wUYE2PXPXj0xpjZRU/tApCXjCmglpKchg1tCIPS4aSE0WzA62+R2mAF5f4wBnO2/xoMsa3Zfzlz0F/Hmt4hZBq46LooZq/orG6LzR7b1PJ/QY9x89XyRzqnLWE4Nw1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=0iOSvRQm; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Cdua/db5; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="0iOSvRQm";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Cdua/db5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790651941;
	bh=1TaoxoaKIr+XKvEfbqU46Kdw93DxMwV3OcOPhmb6yrw=;
	h=From:Subject:Date:To:Cc:From;
	b=0iOSvRQm91JP1qkVWb9CIgHWq4bwcLN8vU3SyHbAtGCVS+fBCUwjpg9xK9rEYjWGI
	 5q/+8pnRJqV9PH2xPDLYHiNUdggR7TrZ6JFLuC7PZSwlBYcBrQX4DCB+6xLjN1eo7i
	 jsZD8/ADaWqq7DE1vtihqy1fwAQYwGQHiaeoBlO/jzKEB0Rxlw2n2j07Ifc0YqnLBt
	 cbQCiE1K9VRZWVrt1RItts3c1z1xO3WRhgzZsVoil1MK2O9Sz6izXqDp9/sB/0Qfki
	 eqqcXdBYW0C5Vxlpta/Nmv4d8bu5eUHffKDOJNggdT5wiEo3VSl+hQjZo+Pc903zuM
	 UPRXRwlDm9t2w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 9719842284; Tue, 29 Sep 2026 03:19:01 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790651938;
	bh=1TaoxoaKIr+XKvEfbqU46Kdw93DxMwV3OcOPhmb6yrw=;
	h=From:Subject:Date:To:Cc:From;
	b=Cdua/db5NDDc2aIGzcuuMtoqjxQUSHicL9RELtBbMr/7QQe1KsDJaEhCWTv2JVGRz
	 ez3Jc81WpN4pPe7RYgHZTLcg5sH9roOVT31OilykESc/9gAI16rtUiCe+EPmmSYZBV
	 XkwmXX+DN7xPtCKuoBXqsurEUvohcc6cwGrwfmeRk1GkHzYTwW2/iUp4fZjrRJFZEq
	 mkF6Y/CDwPv8/2G30cdu63AuBx/XrQ27hmXJqIaWq0fZthzvgD4umk9K2v216GHK53
	 XH/R8zatL1oRpm6Lf0w0XE+q5BW874iXuKKwJt+OjLVyz2Fq1OfG/xYs00W5DHiWPF
	 i+izHWfcq0UoQ==
Received: from AMDDesktop.lan (p5dd1eaf2.dip0.t-ipconnect.de [93.209.234.242])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id BD91942254;
	Tue, 29 Sep 2026 03:18:57 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v14 00/14] ax88179_178a: Add support for
 AX88179A-based chips
Date: Tue, 29 Sep 2026 05:18:48 +0200
Message-Id: <20260929-ax88179a-v14-0-a1f2249e42ea@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABguu2oC/3XSTU7DMBAF4KugrAmaGf+z4h6IhWOP2wjUoiSKC
 lXvjpNNpxJeOo4+22/etZt5GnnuXp+u3cTrOI/nU12gfn7q0jGeDtyPuX7oCMiCVdDHi/foQuw
 jZh8KEzoFXf39e+IyXnbrvTvx0p/4snQfdec4zst5+tkPWXHf3zkHeOdW7KFHZb3JxTqD5m0Yp
 wNP/ed5+BqX35fMO7aSBLwAqALgAQrngRhtC1ACIC0AVYEhZ9YlgPFetQAtACWfoCtAqWBxOGD
 O1ALMHfBAAjAVyGmosUYdU9YtwErACsBWoGR2GrXFwM0MnABQDHV12w2iVQoDJqTQArwAHjLwG
 8A1wELMmpo3CHcgPGQQKuDZZucQIkVuAQhSkHOsD6qDNGyBU3Q2QJMQZQz4QGxtNBxdDGSGaHO
 TIEnIUeDWRwsJdAqBdGy2AUUhAzlJbI3UJSY7KAZF/2Zxu93+AA9UFXfHAwAA
X-Change-ID: 20260630-ax88179a-a1d89fe21730
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Birger Koblitz <mail@birger-koblitz.de>, Nicolai Buchwitz <nb@tipi-net.de>
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

Tested-by: Jianhui Xu <neuromoments@gmail.com>
Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
Changes in v14:
- Fix return value handling in VLAN offload functions
- Add explanatory comment for phylink_mac_interrupt()
- Link to v13: https://lore.kernel.org/r/20260927-ax88179a-v13-0-4fac6b3e032e@birger-koblitz.de

Changes in v13:
- Add MODULE_ALIAS to ax88179_178a
- Squashed commit adding netdev2data() into the first one needing it
- Add wrappers ax88179_write_u8/ax88179_write_u16
- Use FIELD_GET() FIELD_PREP() in fixups.
- Add guard for phydev->drv NULL in phy_ethtool_ksettings_set()
- Various endianess fixes in fixups
- Add error checking for too small packets in ax88179a_rx_fixup
- Typo fixed:  ax88179_read_cmd -> ax88179_write_cmd setting PHY power
- Changed call to usbnet_nway_reset by phy_ethtool_nway_reset
- ax88179a_bulkin_config() handles FS USB now for all chip versions
- Use phylink versions of calls for get/set_link_ksettings
- Add handling of return values of ax88179_read_cmd() in various places
- Removed usbnet_link_change(dev, 0, 0); at the end of ax88179a_reset().
- Add RTLN-lock to protect AX_MEDIUM_STATUS_MODE register,
  WRITE_ONCE/READONCE for rxctl.
- Changed to clearing AX_XGMII_EN for all speeds != SPEED_2500 independent
  of chip-id.
- Fix access to AX88179A_MAC_RX_DATA_CDC_CNT by using 2 1-byte writes.
- In ax88179a_mac_link_up initialize link_status.
- Added setting of AX_GPHY_EEE_CTRL to disabled in ax88179a_reset(),
  consistent with phylink default.
- Various commit messages fixed
- Conditionally set AX_VLAN_CONTROL_VFE after loop over the VLAN-entries
- Moved code in wrong commits to the right ones (2x).
- Fix races around rx_checksum flag setting.
- Suspend/resume fixes: correct sequence of WoL settings and usbnet/phylink
  suspend calls.
- Read revision number into the 4th field of software version
- Kconfig descriptiona and module description mention 2.5GBit
- Fix orphaned defconfigs
- Fix EEPROM access settings derived from chip versions
- Fix EEPROM read error checking
- Return value checking in asix_ax88279_read_status()
- Added clearing of ETHTOOL_LINK_MODE_2500baseT_Full_BIT in lp_advertising
  before modifying the bit.
- In asix_ax88279_read_status() add if (!phydev->link) guard
- Linkmode cleaning code shortened.
- Link to v12: https://lore.kernel.org/r/20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de

Changes in v12:
- Fix BCD ranges for USB device detection
- Free SKB in ax88179a_tx_fixup() when skb_linearize() fails
- Use phylink_mii_ioctl instead of usbnet_mii_ioctl
- Link to v11: https://lore.kernel.org/r/20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de

Changes in v11:
- Fix sparse warnings
- Link to v10: https://lore.kernel.org/r/20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de

Changes in v10:
- Fix missing variable declaration in ax88179a_status()
- Add reviewed-bys
- Link to v9: https://lore.kernel.org/r/20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de

Changes in v9:
- Fix ax88179a_status() to not call carrier-related netif or usbnet methods
- Use genphy_read_mmd_c45() and genphy_write_mmd_c45()
- Link to v8: https://lore.kernel.org/r/20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de

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
Birger Koblitz (14):
      phylink: Add phylink_mac_interrupt
      phylib: Add support for PHYs with broken forced mode
      ax88179_178a: Fix endianness of pause watermark register
      ax88179_178a: Split driver into library and device specific code
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

 MAINTAINERS                                 |    6 +
 arch/loongarch/configs/loongson32_defconfig |    2 +-
 arch/loongarch/configs/loongson64_defconfig |    2 +-
 drivers/net/phy/ax88796b.c                  |  167 ++++
 drivers/net/phy/phy.c                       |    4 +
 drivers/net/phy/phylink.c                   |   20 +
 drivers/net/usb/Kconfig                     |   10 +-
 drivers/net/usb/Makefile                    |    3 +-
 drivers/net/usb/ax88179_178a.c              |  665 +-------------
 drivers/net/usb/ax88179_lib.c               |  530 +++++++++++
 drivers/net/usb/ax88179_lib.h               |  359 ++++++++
 drivers/net/usb/ax88179a_devices.c          | 1285 +++++++++++++++++++++++++++
 include/linux/phy.h                         |    1 +
 include/linux/phylink.h                     |    1 +
 14 files changed, 2429 insertions(+), 626 deletions(-)
---
base-commit: f7f619ecda5761bd48578764ef5ff9e8fd97b916
change-id: 20260630-ax88179a-a1d89fe21730

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>

