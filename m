Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC6B3B4EA9;
	Thu,  6 Aug 2026 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044971; cv=none; b=Sk8VquD0+52l0QaTJZ8+H4neNzNNwE3IaQOA/zcpOFz5u6lQ3CO/MKw1bsC0Z7qvL9G8pklgY9gngpWBlhaQz0XCSrfQOube+k6zDwWj8EMnk5acFBcYzwrr1yoq2a+MXYHDHdYY1JAGyxqW2IHK3k4ZU14YAyN5/OsEX9/aEJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044971; c=relaxed/simple;
	bh=tLXk+LE7TZFj6BalJ17B/YE9Auh94CwR2jgNmBDgsig=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JB3hQ0fNLEsIUb7TrJBcZUCC6OXvl6uPWMA/XJQ+olGPCVud+JIYbuCKRFwnmzCu5RShDcQN4XhfzOHOwMXrC4i8H2tvfHhf+xQR7hRSv58a79Nts6qbqWUfgbS4U+DUCW1thoM3Br/WFZ8MZ1PzzQofc07xUZC2KuVi/zsiXm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Lv2htBoY; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=1wccliTf; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Lv2htBoY";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="1wccliTf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044968;
	bh=tLXk+LE7TZFj6BalJ17B/YE9Auh94CwR2jgNmBDgsig=;
	h=From:Subject:Date:To:Cc:From;
	b=Lv2htBoY6ka93po+RJY2qyEhWuN5N9Wk1BUwPPr8Vh2KGpKdfZhjCfC4XXUOv+ca4
	 jTlpc7kX/BDtsVuUS0iVReFeg2KtUlpxlLEFtuIUJFaGkuSBKnKJaeCTlDtY471vFT
	 PCPC09ekrM5Cqp3cc/i2jAJUH9FgPLLj8Uo670WlctPOtb902r6u2fmeYUa+tnF1qm
	 hq+YPkP3Gqbu6pCm4N2Crl73RZaMIFQlPL6Jcp8Ml7GNw0U/JMEEQPIyZ2Q3DVaGbw
	 lk9/45vfzsvXwwh8kStfZYbkoZo4NuyPMcVeFf4yZmYMipApLzmXbpqB/KWqWLE0cU
	 sCDrknYKz5JXQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 76CD5496FF; Thu,  6 Aug 2026 19:36:08 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044965;
	bh=tLXk+LE7TZFj6BalJ17B/YE9Auh94CwR2jgNmBDgsig=;
	h=From:Subject:Date:To:Cc:From;
	b=1wccliTf3y5zlvwaoQg0V2N75E2kGmK0b3BColDL2p8ieWmKv4+gwEfL1WkkdA909
	 UIh1PuaUTYLld8PT/8+E7AAyX++PPVEAbF68X5Y1NOmbNT0VAJ8ylhJfzoURIrY/xu
	 hA9k70R9DAzTdrks8YipDoe5MLgHtMrMaM5FL9jBfdtQ3UdjLTivdenoOKL4B3bs0Z
	 o1I5CUvB7stga+1o+P7sam7Bd4IT2Dedq10C+Weq8lP7EAmKBAD87LK18mZOquxlhk
	 cc5M9AnKdO/yF6vxkQOXcPJTjrAACHaqpchkQBmq38pktPPm3n2ULIGcvEUptZFTVa
	 b+wXB2QaEuc1g==
Received: from ThinkPadAMD.lan (unknown [213.80.50.14])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 78410496F2;
	Thu,  6 Aug 2026 19:36:05 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next v6 00/13] ax88179_178a: Add support for
 AX88179A-based chips
Date: Thu, 06 Aug 2026 21:35:58 +0200
Message-Id: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB7idGoC/3XQTWrEMAwF4KsMXtdF8l+crnqP0oUdyTOmJRmcE
 NIOuXtNNuNFs3w88QnpIWYumWfxdnmIwmue8zTW4F4uYriF8coyU81CgXLgNMiweY9dH2RA8n1
 ihZ0GUcfvhVPeDupDjLzIkbdFfNbmludlKj/HjhWP/uA6wCe3ogSJ2nlLyXUW7XvM5cpFfk3xO
 y+/r8QHtqoW8A2gKgAeIDFFxejOAN0AyjSArkAkYpN6sN7rM8A0gG5PMBVQQ8LUYUQidQbYJ+B
 BNYCtAA2xvjWYMJD5D9j3/Q/b77HFtgEAAA==
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
 drivers/net/usb/Kconfig            |   10 +-
 drivers/net/usb/Makefile           |    3 +-
 drivers/net/usb/ax88179_178a.c     |  664 ++------------------
 drivers/net/usb/ax88179_lib.c      |  515 ++++++++++++++++
 drivers/net/usb/ax88179_lib.h      |  358 +++++++++++
 drivers/net/usb/ax88179a_devices.c | 1201 ++++++++++++++++++++++++++++++++++++
 8 files changed, 2313 insertions(+), 624 deletions(-)
---
base-commit: 1a9edf8be190decb17227e3cba540513d93ebb85
change-id: 20260630-ax88179a-a1d89fe21730

Best regards,
-- 
Birger Koblitz <mail@birger-koblitz.de>

