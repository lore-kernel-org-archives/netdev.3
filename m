Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8262D501F5F;
	Fri,  4 Sep 2026 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542927; cv=none; b=dGnSwgiFPTFPJFRV/k7gUon0FPdZoxHkRedayTg9BTqWq4bBYzjAciWGpuxEBqBVPDy/3Wy1XiDJfQQXG9ujDJ6tIohNryn+i37uFEtpb/6k3xHEI6KVIav3ptKQF5CplO2EN3QslMQYRSotLMZ+wnLHBswwcL4IrR+GLyM8xkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542927; c=relaxed/simple;
	bh=2nuDVzgoNNpL9cgWFFhxwaET4toIfeE2hiRK76SeKpA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sz6SFOcNQn/kW1nCk1Y4PWfG0bUexfDtnsUp9ZIsRxzDH+RdF8zzYQzVzXIntRn1VA9ZHBTc3Fw2Yg3rC9rvqLhNJAC3h7ZrGJpqasvi4dOYicWCYEjsRc6mNs8mVdZI2XtOmB4OJstg2jw18az3SlOim5izOoCX1Q/a5TeY/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=v734jhwD; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=uLQhmDIl; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="v734jhwD";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="uLQhmDIl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542914;
	bh=2nuDVzgoNNpL9cgWFFhxwaET4toIfeE2hiRK76SeKpA=;
	h=From:Subject:Date:To:Cc:From;
	b=v734jhwDbHL5Evz74/VQzJPxIt/x40eLLBD2FfpQCvglXGPWpzlh/+G+TDUjUlg0s
	 KrXqTwwkEy91h7h1EcSLpxsHVhCJ3Y7+Hnehy2zC2Y1WfV/WlBJ7RM3nF8GumlQwbx
	 R2wYn5BsaevhsVdN/Tx6fkpdqtGIAv7/W2MBe5qMnPgXO97MNK4mlb8FxfHH3GBiaX
	 xPksOTcQR0Y25m9CLo5CpGsTJDW00dxUn7ELlPFxnbjpi3Lyp83E5hUHelaeNOqY/E
	 RLomeoQ9JTbuYGd0iBlE3C18BtjZz2GmAFo/Yoi4hrBbJfZs1xWYVLvN+zis6Vwq7w
	 L14RGebV23rvg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 7AFE13F0E8; Fri,  4 Sep 2026 17:28:34 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542913;
	bh=2nuDVzgoNNpL9cgWFFhxwaET4toIfeE2hiRK76SeKpA=;
	h=From:Subject:Date:To:Cc:From;
	b=uLQhmDIldDirwTwqaQQqevy31BQ9JXACoZEfmOLZzHWVmoQMvbvs/yXKOxa/nuZAi
	 k5d53JAkCfas15VtlTjhmHBOguglrnWFS59YDG7nu6jlSSfUTqPMAzHMMF86bpGjlL
	 zI/CUoDlXxArTnA+nqK+LXUSP2hBDujg/E+UBxEaWG1du24eGNdukyZOe7ze6fH1OD
	 QxNCtYAjiCIZfmxkaHIJC6D82ZGMCXjcIn3rF8mKmXG8d+ePWUaUR9LlWqwLWierq8
	 Qp01vX8tMh3aBYSMgGnu432oDvYrS3z71WVu3esxDRA6xa3J9VKrSlSImlLGETmLri
	 2V0heq57Vs6ow==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id A34523F0BE;
	Fri,  4 Sep 2026 17:28:32 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v10 00/15] ax88179_178a: Add support for
 AX88179A-based chips
Date: Fri, 04 Sep 2026 19:28:25 +0200
Message-Id: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALn/mmoC/3XRzW7DIAwH8FepOI/JNoSPnfYe0w4kmBZtSqoki
 rpVfffRXEqlccRGP8zfV7HwnHkRb4ermHnLS57GckB4OYjhFMYjyxxLQRCQAaNAhotzaH2QAaP
 ziQmtAlGun2dO+bJbH2LkVY58WcVn6Zzysk7zz/7Ihnt/5yzgg9tQgkRlXBeTsR12732ejzzLr
 6n/zuvva+Qd26gGXAVQAcABJI49MZoWoCqAdAWoAvQxsk4eOudUC9AVoOov6ALQkDBZ7DFGagH
 dA3BAFdAVIA59iTXoMETdAkwNmAowBUiRrUZt0HMzA1sBWC11s/cJglEKPQ5IvgW4CnjKwN0BL
 gEmYtbUnMA/AP+UgS+AYxOtRQgU+D/gdrv9AbwQXme7AgAA
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
 drivers/net/phy/ax88796b.c         |  161 +++++
 drivers/net/phy/phy.c              |    4 +
 drivers/net/phy/phylink.c          |   16 +
 drivers/net/usb/Kconfig            |   10 +-
 drivers/net/usb/Makefile           |    3 +-
 drivers/net/usb/ax88179_178a.c     |  664 ++------------------
 drivers/net/usb/ax88179_lib.c      |  506 +++++++++++++++
 drivers/net/usb/ax88179_lib.h      |  358 +++++++++++
 drivers/net/usb/ax88179a_devices.c | 1212 ++++++++++++++++++++++++++++++++++++
 include/linux/phy.h                |    1 +
 include/linux/phylink.h            |    1 +
 12 files changed, 2318 insertions(+), 624 deletions(-)
---
base-commit: 1bb784eb6e38fd73143f021608e4ef3095d0c0d7
change-id: 20260630-ax88179a-a1d89fe21730

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>

