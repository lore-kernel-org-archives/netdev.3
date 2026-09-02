Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A673C4AA004;
	Wed,  2 Sep 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368255; cv=none; b=Kktb62CYyzGu9onXNiNpFr3b2hsmfqEVMUf6xs7VACvA7d7ekmdCb/I6AjxhYncUhp42o71ehlvTnu/9yZjYVv+2YsCoQ6rSZINVYe3cONaeKJ03xLRVlfrkgYOBzAcYE0yLjpEwDBlogkVkTi1eKCimqDKXpIdK9RMm9Eu1hbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368255; c=relaxed/simple;
	bh=trqCRVbR1R5GkpUXSL1s3EHLdNgBDt9pcFpJ31cDa9U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LC/NvGHd6Svbivsx/ZbTHwqnhyCOA7VnPRizBL4tgkq//LfHdJwxaQV6j0jxkaEAo/ADcPmNIJPYEQ8qXYoYQEPdGrcZ2/XQ3ssF2UuHZJAcRED/S51NntR2MMgtM1L1FZna8MqPJdy7pkm6bMcu1eLr3F5a64l/zmcoRiuLLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=gUQOdFIq; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=1Vu2FdfW; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="gUQOdFIq";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="1Vu2FdfW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368244;
	bh=trqCRVbR1R5GkpUXSL1s3EHLdNgBDt9pcFpJ31cDa9U=;
	h=From:Subject:Date:To:Cc:From;
	b=gUQOdFIqTniCODuSJIVZwef3Q0USHtvQHWR7gW8M7NkttEzQOK7fTHyqBTkoEaBep
	 5O8OL9J8uvOOgkilrkOln3bjFzqXAKbpDE7Qyk0WmtSm+NJvzLlHtuEI9ea6QsFE80
	 8alLX4PMDrublkK3UsBZX2rHIB8Z4aFWexpr8nGSlX2aEbNie6T5nXKxG61PnESqBp
	 2E/zYCJY9o1fbHe/38kI8+UJO7Xo0u8AdPifSfStwo5GaGlPp4sWnWqFlhAS+C1GlT
	 AA0sT9PUNeXdnJyXfn7CZf+Ut7rCdANb3+pp709btMcLz1qRthMAMPWl0y7fm5QFp4
	 4C8Efp4w6VjsA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id D9DE83EF1D; Wed,  2 Sep 2026 16:57:24 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368243;
	bh=trqCRVbR1R5GkpUXSL1s3EHLdNgBDt9pcFpJ31cDa9U=;
	h=From:Subject:Date:To:Cc:From;
	b=1Vu2FdfWGHguczLDxATUZKNCe1TXAuODv+S9MJTmvSjzROe2XdMnGHhDkAOnjfz4t
	 brTAlVeDaWcLPzTMskIuk35tjxpFSUQUV5ng1okzoC5M1ouragtfsgF1TJ2bp+1EBp
	 5j7eznuAs+u9RuNtC9UDEucecK5ilz03MetI3GYxn3Hw3FCwuqf1zh6FuaUUaefEkA
	 a3sgoYOU71kirfJBd8NJxqI66q/lUQfNenyxivhi719CxDNF9HPvnbsioL1eFlA8nb
	 6ERY/93A6FgkjGtqrTVEDCC0SN2oBUOAyUxUXti26grOVvewjYo49wz1PfcWpiOO9R
	 Nx/bVJn2EKS0A==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:c4e4:2069:f0cb:22e2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0426F3EEF6;
	Wed,  2 Sep 2026 16:57:22 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v9 00/15] ax88179_178a: Add support for
 AX88179A-based chips
Date: Wed, 02 Sep 2026 18:57:14 +0200
Message-Id: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGpVmGoC/3XRzU7DMAwH8FeZciYodr458R6IQ9I4WwRqUVpVh
 WnvTtbLgkSPlq1f7H+ubKZaaGYvpyurtJa5TGMr/NOJDZcwnomX1GqGAo0wUvCwOQfWBx4gOZ8
 JwUrB2vhXpVy2nXpjIy18pG1h761zKfMy1e/9jRX2/s5ZAQ9uBS44SON0ysZq0K+x1DNV/jHFz
 7L8PCfasRV7wHUANkA4ITKliATmCJAdgKoDZANiSqSyF9o5eQSoDpD9CaoBOGTIFiKkhEeAfgB
 OYAfoBqQhtliDCkNSR4DpAdMBpgE5kVWgDHg6zMB2AHSfutr7BsFICR4GQH8EuA74k4G7A9QCz
 Eik8N8NbrfbL2G3TlR5AgAA
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
 drivers/net/usb/ax88179a_devices.c | 1210 ++++++++++++++++++++++++++++++++++++
 include/linux/phy.h                |    1 +
 include/linux/phylink.h            |    1 +
 12 files changed, 2316 insertions(+), 624 deletions(-)
---
base-commit: 1bb784eb6e38fd73143f021608e4ef3095d0c0d7
change-id: 20260630-ax88179a-a1d89fe21730

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>

