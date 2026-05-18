Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC743E2773;
	Mon, 18 May 2026 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092608; cv=none; b=pSt0rQ6bD7K9UW9VzAqtWBJ28U1RkFxf8sbwTTi9zgMJd6tdKMgPe8F2I9bxK9bhLgzVoRYM8rophvx2UEgQ+groxjiW5p8/QERoT+1AIp66CWQBwGSmSfep3zETH9RZN6zqDMcEcWPVzH4Gv3Uk7q+c5JCFEaA7plpBy7saKSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092608; c=relaxed/simple;
	bh=jgcVJB0EgP1hDWQahFq0aOB9HcugnopXHvHUTQ18Dqg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KzyHwRv+edbHzSpLIINUv+YkROJ5Ezb/MPULRK7qXuacDs1fzPaUq6oZeUnnrnagihyFzCKdbMpzCtJ0e/D4kV8PrlLsIilJo+SwC7TaCYxX+mh1Yr4v8C0SBBfbO2lEveWubsNfLs/2xgxpOxIYew7iek7R2k/ArHKLtINVGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=AiBMlCCG; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="AiBMlCCG"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A588EA4F73;
	Mon, 18 May 2026 10:23:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779092595; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=CjWmsPSS4ORwpSMmy+dUdT/5+PBgbOXPEVIPfdPtfVE=;
	b=AiBMlCCG1WOOpGv0g4do7ZdCHTvWnk2x5U5nSzlJlqDRIqAwFXd8t18RzEXrsMyHz7GJq2
	SHo/o+Fj+DqDF2aJCiPq6Uzn8A5ZE+dbo02zA6fpjYVQyfBh3xUM5LIvLlXaLs66Rfqhot
	fMoxCm8BfRsWp/VXSHOzxQf+coSx+p4yE9Ft29Mjo+0D7bZ/YgIoijznDIIFG5BglIWU27
	a0CDcCCTaWqzeRjfopqZjHzTUP1JtzRphf0KCCZk/SMUn3ONeSTXkdVXwKZ8aJ55sI9/xC
	5fG2RyywyCBgTRtlGIGIos2sMcXnyRLQLI7ZF+PUEbZldW0hI00BeYWuZlIVDw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net v2 0/2] net: phy: honor eee_disabled_modes when
 advertising EEE
Date: Mon, 18 May 2026 10:23:08 +0200
Message-Id: <20260518-devel-phy-support-eee-fix-v2-0-05b52626fa68@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGzMCmoC/42NQQqDMBREryJ/3V9+pLHYVe9RXFgz1g9FQ5KGi
 nj3Bk/Q5bxh3mwUERSRbtVGAVmjLnMJ9amiYernF1hdyVRL3Yg1DTtkvNlPK8eP90tIDIBH/bJ
 rh1Eu0jfWXqnsfUDBh/tBMxJ1BU4a0xLW4y+bo/pDnQ0btq3DcxCB6+We1CsX6dmBun3ffzZUd
 GnJAAAA
X-Change-ID: 20260516-devel-phy-support-eee-fix-d9cf040a6557
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

While debugging why ethtool --show-eee reports "not supported" on a
Raspberry Pi CM4 with eee-broken-1000t / eee-broken-100tx set on the
PHY node, I noticed two phylib helpers copy phydev->supported_eee
into phydev->advertising_eee without applying
phydev->eee_disabled_modes: phy_support_eee() and
phy_advertise_eee_all(). That undoes the filtering phy_probe() set
up after of_set_phy_eee_broken(), so the PHY ends up advertising EEE
for modes that were marked broken in DT (or by the driver via
eee_disabled_modes).

The visible effect on MAC drivers that call phy_support_eee() after
probe (bcmgenet, fec, lan743x, lan78xx, r8169) is that ethtool on the
local interface reports "not supported" (because supported is masked
by eee_disabled_modes and ends up empty), while the link partner
happily sees EEE negotiated and active.

Patch 1 fixes phy_support_eee(). Patch 2 fixes phy_advertise_eee_all(),
which is also reached from genphy_c45_ethtool_set_eee() when user
space passes an empty advertisement.

I went through the other users of supported_eee as suggested by Andrew
and they look fine:

  - phy_probe() already masks via eee_disabled_modes after
    of_set_phy_eee_broken().
  - genphy_c45_ethtool_get_eee() masks supported_eee with
    eee_disabled_modes when reporting to user space.
  - genphy_c45_ethtool_set_eee() masks user-supplied adv against
    eee_disabled_modes, and the empty-adv path is now covered by
    patch 2.
  - genphy_c45_read_eee_abilities(), read_eee_cap1/cap2 populate
    supported_eee from PHY registers (source of truth).
  - genphy_c45_read_eee_adv(), read_eee_lpa() and write_eee_adv() use
    supported_eee only to gate which MMD registers to access, not to
    construct an advertisement.

Changes since v1:
  - Add patch 2 fixing phy_advertise_eee_all() (Andrew Lunn)

Previous version:

v1: https://lore.kernel.org/netdev/20260516-devel-phy-support-eee-fix-v1-1-59debc00eda0@tipi-net.de/
---
Nicolai Buchwitz (2):
      net: phy: honor eee_disabled_modes in phy_support_eee()
      net: phy: honor eee_disabled_modes in phy_advertise_eee_all()

 drivers/net/phy/phy_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---
base-commit: aaec7096f9961eb223b5b149abe9495525c205d9
change-id: 20260516-devel-phy-support-eee-fix-d9cf040a6557

Best regards,
-- 
Nicolai Buchwitz <nb@tipi-net.de>

