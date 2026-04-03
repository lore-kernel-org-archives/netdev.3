Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00753019C8
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207278; cv=none; b=RtgZbjvUX5ekZ9zOdujBGKbrVhCZISffQoSJtItW/8B8RWXQHvMAVDp1N54gbYDDT+RuErLnFais76lDzqLVcpEOtBJAAlVlZ9GDyONAhH5xY/Re/mpOOoLOkf3dLoWccrTtuRqOYe5UTrmW8UXD8gSAixxDTGKVkEj8wTezFVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207278; c=relaxed/simple;
	bh=nFUtTxq3fc8Oihv8f7ZfNtEVneLNEQOaOVD8Oxiem7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gwpq3dqcf+iL5eZbugYDeucvGJaKrUlJjdwfPHNC/xKeNiTaIbgg3Ykda2LAhUZWxvgl7Tv+sLmcf6Kraz5S2tpqojrHe1JBKaJ++8i2zc7xgwR7o527GvFemwPPPB5ooRgIUSDp790KLLbXdG3TK2vrQom2tVVWg7vw88YJ5C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=g+aNMFyd; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="g+aNMFyd"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 59272A587B;
	Fri,  3 Apr 2026 11:07:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775207253; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=jdRS1z504heA2CIiGPHsb37aXBB+fOgruNm848vdgYs=;
	b=g+aNMFyd+Usx3ch0sJ39Y2GOb0IikWO3mXlAVUaWr/22nvmVbACKA8c6QFtApeZbO6fOfE
	ED193ZGm7r3VwcBLZwVXcr9Qw7p66OhZ/IIT6yOTebbItbOlLya/s2ST00qU60mogqcYmn
	7IAX6P8BlUd/hmBpIrx25B0bLpJ784O6yeWhvil8rj+LTZJj/Fcycl1GTOQDWX372cCLhN
	jDuvVOTCfemwoGhtYHY0aX1JWZXESw4g4xYzoJ4w47IATLyrOmB8bzeZqgFP0eyTMN7gGr
	u40kASuKM4u3+oH4DIdR0RHBN9OhPRb9SY3v3LA+OpeGg8BW76ZhhD6jOOOMqA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [RFC PATCH net-next 0/3] net: phy: add support for disabling autonomous EEE
Date: Fri,  3 Apr 2026 11:06:50 +0200
Message-ID: <20260403090656.733985-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Some PHYs implement autonomous EEE where the PHY manages LPI signaling
without forwarding it to the MAC. This conflicts with MACs that
implement their own LPI control via phylink's mac_enable_tx_lpi /
mac_disable_tx_lpi callbacks.

This series adds a .disable_autonomous_eee callback to struct phy_driver
and calls it from phy_support_eee(). When a MAC indicates it supports
EEE, the PHY's autonomous EEE is automatically disabled so the MAC can
manage LPI entry/exit. The setting is persisted across suspend/resume
by re-applying it in phy_init_hw() after soft reset, following the same
pattern suggested by Russell King for PHY tunables [1].

Patch 1 adds the phylib infrastructure.
Patch 2 implements it for Broadcom BCM54xx (AutogrEEEn).
Patch 3 converts the Realtek RTL8211F, which previously unconditionally
  disabled PHY-mode EEE in config_init.

This came up while adding EEE support to the Cadence macb driver (used
on Raspberry Pi 5 with a BCM54210PE PHY). The PHY's AutogrEEEn mode
prevented the MAC from tracking LPI state. The Realtek RTL8211F has
the same pattern, unconditionally disabling PHY-mode EEE with the
comment "Disable PHY-mode EEE so LPI is passed to the MAC".

Other BCM54xx PHYs likely have the same AutogrEEEn register layout,
but I only have access to the BCM54210PE/BCM54213PE datasheets. It
would be appreciated if Florian or others could confirm which other
BCM54xx variants share this register so we can wire them up too.

Tested on Raspberry Pi CM4 (bcmgenet + BCM54210PE),
Raspberry Pi CM5 (Cadence GEM + BCM54210PE) and
Raspberry Pi 5 (Cadence GEM + BCM54213PE).

[1] https://lore.kernel.org/netdev/acuwvoydmJusuj9x@shell.armlinux.org.uk/

Previous discussion:
  https://lore.kernel.org/netdev/d86c53213a6328b701b8aabbde5d1c83@tipi-net.de/

Nicolai Buchwitz (3):
  net: phy: add support for disabling PHY-autonomous EEE
  net: phy: broadcom: implement .disable_autonomous_eee for BCM54xx
  net: phy: realtek: convert RTL8211F to .disable_autonomous_eee

 drivers/net/phy/broadcom.c             |  7 +++++++
 drivers/net/phy/phy_device.c           | 22 ++++++++++++++++++++++
 drivers/net/phy/realtek/realtek_main.c |  7 ++++---
 include/linux/brcmphy.h                |  3 +++
 include/linux/phy.h                    | 18 ++++++++++++++++++
 5 files changed, 54 insertions(+), 3 deletions(-)

-- 
2.51.0

