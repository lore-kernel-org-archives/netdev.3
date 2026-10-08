Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBD33AA4E4;
	Thu,  8 Oct 2026 03:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431479; cv=none; b=gj8c+N1KyLG81eb9QP8gKM8k1CxFl2U21uvZyeqTXeOO2SWmOBOuOzakBCJbkoRnYhmqBl8DydT4VmQcGBenbHIWP7Px4BrAKzOKjDLavLB+mMmpeDULebfxMcwRaits/TiMMEFS8bTI6TAq11JSgo9QrxFyxP2sNO2PdZYq+DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431479; c=relaxed/simple;
	bh=C5L67fIlh6JeT0NaT+5esEh3SVPknlwtOSPZCB8Ld/k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M60MHxkLqUbST0b/n6rPu22dpgg3zlb9dUqxhcosRcX8A5A4dDqB5z7714zqdbN+GX3Xnn4f/3XTEm2Yapp6ENm5rU9GP7NXmVwZOn4pp4vYdkEDg9aDkAZbldmqmCCge7/84JDw701wOcrDxW4GDsl8k6VCA36PIwQQ904obZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=2pj9yJba; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=r/Yf8OVu; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="2pj9yJba";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="r/Yf8OVu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791431476;
	bh=C5L67fIlh6JeT0NaT+5esEh3SVPknlwtOSPZCB8Ld/k=;
	h=From:Subject:Date:To:Cc:From;
	b=2pj9yJbaJKMWJqK6lKZYbwC15Da5Ww6lStWLRYx+Pl360WnQ8aFb8ZWYtqF/WgBEn
	 C3dG0FCy+P0RImcJIApzC+Jy0e/KzVEj+vabqqKo2qiF04THAF6EYXBHUoy57ikTk+
	 LfF2AV0qXlSpkyY/yK6bRxj40zvHIIcAs9XPjAf0AhA+TuV1DVYufqcW7RU4TPsNW0
	 X07z4fS5YpOMHpCuv1NZFM1mXQeYJeksGqmwdqptrQWQea1YLNnpu8cdwbqjtkryOO
	 +0Ist9AC9Tvv3zXv3vXdOUmdaAGXTstjnRLWAfQLIO70ZjWIAehC0q+jAdaQX+QLN+
	 A6XEf9a+c1/sg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 5FEAD4719A; Thu,  8 Oct 2026 03:51:16 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791431474;
	bh=C5L67fIlh6JeT0NaT+5esEh3SVPknlwtOSPZCB8Ld/k=;
	h=From:Subject:Date:To:Cc:From;
	b=r/Yf8OVuyOGB6p7lpEVrjP07QIBCge+6cCeOvkqBNTEFmas8I7nrrTceIAmhguTOK
	 ON01Ur0lAOPNKGClU3troY0taCr6Sra5Gq0uT+wkhv7YqcA+Wqx5jATQ2LT+O+Di+r
	 8dkv3NwyfegOub3NHorKVkhlaOMO7WTvrGGB74X1iMVJxHOMqxfWgj0qvHv0oyJ2WP
	 ofNLj5yyqQFh6WX0rqRpNT3x0tXE8CNegGkOubTYl46q0vi4W06Zi2gBGtSaJof8+f
	 tWS7/erC8opgRIGDyOvCFuIw/7yCKDG9cgyZhw7vp+TnUA6NEJP0PlqCr09GWHDC4h
	 i+vqiZFZqnxmQ==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id D4F1841186;
	Thu,  8 Oct 2026 03:51:13 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v18 00/13] ax88179_178a: Add support for
 AX88179A-based chips
Date: Thu, 08 Oct 2026 05:51:06 +0200
Message-Id: <20261008-ax88179a-v18-0-6fa1d4c40422@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACoTx2oC/3XTwW7kIAwG4Fepct6ssAGDe+p7rHogYNqoq5kqM
 4pmW827L8llHKkcE9AX+P3ne7jIMstleH76HhZZ58t8PrUHiL+ehvyeTm8yzqW9GNAgGbJmTLc
 YIXAaE5TIVRCCNUPb/rlInW+79Wc4yXU8ye06vLaV9/lyPS//9o+ssK/vXDDw4FYYzQiWoi+Vg
 gf/Ms3Lmyzjx3n6O1+/fhfZsRU1EBWADTDRmCplQgHqAVYB6BRgGzCVIq6y8THaHuAUYPUVXAM
 wV6gBJigFe4B/ANGgAnwDSp5arMmlXFwPIA2QAqgBtUhw4AhYuhkEBYAa6hq2EySyFhgyIPeAq
 IBDBnEDpAVYUcRh9wT8APiQATcgCpUQwCRM0gPAaEHPsV2oDdILGckpEJsuocrIcCC2NnpJITH
 6KVHpEqgJPQrY+kgmG5eZ0aVuG0AVkjFoYmukqynTZMVY7GfhNMGa2DqZoCI6buOQ1CUepQRzG
 Aj4/c+Ewhip5hK6BGniEOfWS0ycxAnFGqYuETRxiHNrJnqM4KpY//NF7vf7f30P5unTBAAA
X-Change-ID: 20260630-ax88179a-a1d89fe21730
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
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
Changes in v18:
- Add also check for PHY_BROKEN_FORCED in phy_mii_ioctl() to prevent
  users to circumvent check via ioctl.
- Do not unconditionally dereference phydev->drv when it might be NULL
  in phy_ethtool_ksettings_set()
- Fix RTNL deadlock accessing mtu-settings by using dedicated lock for mtu access
- Use get_unaligned_le64() instead of le64_to_cpup() to
  support older architectures
- Add check for skb_cloned() before buffer resize
- Add explicit handling of disabling of NETIF_F_HW_VLAN_CTAG_FILTER
- Fix clobbering of AX_VLAN_CONTROL_VFE bit when setting AX_VLAN_CONTROL_WE
- Do no longer use XOR to change AX_VLAN_CONTROL_VFE by conditional clear/set
  of bit in if/else block to prevent theoretical de-synching of bit and OS state
- Make sure interface is enabled when resuming phylink in suspend error-path
- Fix leaking in_pm / unbalanced suspend_count in suspend error-path
- Add pm_runtime_put_noidle() to unbind()
- Reorder setting MII_ADVERTISE and genphy_config_aneg()
- Remove possible 1000M-bits reported by AX88772D when reading MII_ESTATUS
- Link to v17: https://lore.kernel.org/r/20261006-ax88179a-v17-0-252814fe35ea@birger-koblitz.de

Changes in v17:
- Fix clang warnings from kernel-robot
- Link to v16: https://lore.kernel.org/r/20261004-ax88179a-v16-0-2a9ae4e68f7b@birger-koblitz.de

Changes in v16:
- Fix error-checking in VLAN-offload code
  as Suggested-by: Jianhui Xu <neuromoments@gmail.com>
- Link to v15: https://lore.kernel.org/r/20261002-ax88179a-v15-0-131d9286fcd7@birger-koblitz.de

Changes in v15:
- Removed already committed patch fixing pause watermark register
  endianess
- Rebased
- Link to v14: https://lore.kernel.org/r/20260929-ax88179a-v14-0-a1f2249e42ea@birger-koblitz.de

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
Birger Koblitz (13):
      phylink: Add phylink_mac_interrupt
      phylib: Add support for PHYs with broken forced mode
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
 drivers/net/phy/ax88796b.c                  |  165 ++++
 drivers/net/phy/phy.c                       |    7 +
 drivers/net/phy/phylink.c                   |   20 +
 drivers/net/usb/Kconfig                     |   10 +-
 drivers/net/usb/Makefile                    |    3 +-
 drivers/net/usb/ax88179_178a.c              |  661 +-------------
 drivers/net/usb/ax88179_lib.c               |  544 +++++++++++
 drivers/net/usb/ax88179_lib.h               |  360 ++++++++
 drivers/net/usb/ax88179a_devices.c          | 1298 +++++++++++++++++++++++++++
 include/linux/phy.h                         |    1 +
 include/linux/phylink.h                     |    1 +
 14 files changed, 2457 insertions(+), 623 deletions(-)
---
base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
change-id: 20260630-ax88179a-a1d89fe21730

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>

