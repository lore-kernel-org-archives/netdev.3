Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794440905;
	b=TSK3SZpUypb8w1LYWxGot+Q7a6df+go9VGqwNjP/nWctk19up5JJ4ROTZtD5SgsGC14S
	 HVBnEnzp6wzncc2cBmY5fxz8SEsXzlUeyixpcbUCIrSRuVHK9Z7Yf/8nPlro6Vrc2rkkC
	 KCWVLeBjAzwFHBFGtJLC4WooyIQRRhnJF1ubtZQ86XIlLsidLZq86X+q6nl+9gQ2K4Yh4
	 ulxdppCE0B7U8WEs3/FedGMGkqQC0I8a7+CBB2T/3sgb+hi3wJH6tXg+1zwEd+nl/K+qd
	 mVsbI1RY1ERq2U4TnMcYO2XT2jyL1edRSkG+fjFIuU5IJv/VAS5vMeiG3faYvWLegqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440905;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AGLvQK6tvCZaiTfk1vGA7ZJL/VsUeeNkr1m3AQXKf9g=;
	b=C479+ILd0w/wX0cIH5JpYzyEs0YfhFJpq0PHqM+w5e4zzcgOsAt4TNAL4tYZhXXlLPLZ
	 VY9C/7zaSzOD4t3TiiqZxXQt2OTQUs61b560zfv2q4PkHGRUAZBUDObag0TQBacE32eJe
	 CL3afGNSXQlnOTYvuUuR9QAxY7he4I/7heJbIC31hC13PFgFyvEXcoFLb7m6srwbmKSKy
	 W+ct5LixiDeOpZnqTkBc5DpIJv+f+zcH+ErapY3Or5V/qkpjr5knYKOeRk7RL2hwZQJhx
	 Np/1f5O4sXjTavRLrVHOJepJGJQWeCK5MHOCDTp1nJL5gT3yPSAcjRy4cOds8AL1RXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5r16ifU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A6606A8A9;
	Wed, 11 Nov 2026 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5r16ifU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794440905;
	b=yls46nHX9E6cDCN7PUjm7ttkTjsbUeduioC5IXOAZ+LF5aynXrrLKDS3aCHWvjmV3BsS
	 9T1xOGZVgw8lWU9lWdHGDLsXt02qZKpltD6qGnzVz/U9qw3FaQexcSIi8ZfJ0eainj0Cg
	 IKQZricf4KxJM3FvLdyQ/W7hplWHK4JJ4aoaPN0MHRSX8uPp/sxJKkexwep3ZuwJGtzA2
	 mHF4ZInVy5m2TavzTs09/NAoCjbbJ8jBXgpwrnKkDk7uBWK/WbW2VtlgXr59vNWQsBGj9
	 G1liXfWWuM+N9cqUmEaJyBwnSPz54mZPzRbeohtn69YX57Dei13jQoVrZofY9DntfOg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794440905;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AGLvQK6tvCZaiTfk1vGA7ZJL/VsUeeNkr1m3AQXKf9g=;
	b=GsekOUprltWgiPUBx8xayglhe51eKaPI3gLZYYSjWZo6snMTx7Aqq0Z9Lwgk6Pp1PeRD
	 LLYlTrCfz+YFklWncOt/viX8BmlLmM7BvrlSSMba/r7/MwBMypTcDmbLFANW1mIcQz5ha
	 iwEFxeLudBTm+q7niB0K5fSsTNV1uGsdyjfKG1E/ex+RaLsvPtYD3L++LuSti211upsSU
	 txdnaR1B9pQLdOntDdsN97qz2VwZhYL6r1oswf8GaXctK8owi3uWIw2EX0LQVU3eF7q69
	 qV0qWmMDoDVdJ6IMvz8q25b82OIOyepncfGgRuTeuBmC8VDOl5WKrW5Gxe/cGBRb8EQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7BFBB1F00A06;
	Wed, 11 Nov 2026 23:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440905;
	bh=AGLvQK6tvCZaiTfk1vGA7ZJL/VsUeeNkr1m3AQXKf9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=g5r16ifUDDKngvIwuE+cvFzFRsQhbE59+Gl+KYAQl1OahUVZ/0C6ha8JIVR8URvCE
	 bLOKGzKzCPGCPxO5Y0S06cfVp123Yf4eYmr0V5GYfFdrrKlNJszV6ioMz9M7Hlx3O/
	 vZD0QbJ8or+u2QSocBVbam/qhCY8f3yp9Gp26cFaRHYT9NbkXMaPLjZyxuvWi1ILVX
	 TFn+doPqAx5xSP291Pcn1b0tkTRo1r8Kg89zZC/vMprO11JGbpHAxY8E0seGFio3hj
	 Fgnlr3FzH6WB5jxrY3t7xEfT7W1abhS9ZpqSfqjM144tTfAFpMlv860IkzfmvBfIE8
	 IQVmk2JMF9C2w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 030704917B;
	Wed, 11 Nov 2026 23:48:24 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Wed, 11 Nov 2026 23:48:19 +0000
Subject: [PATCH net v5 1/4] net: phy: move irq_suspended and irq_rerun out
 of the bitfield
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-b4-phylib-mac-pm-irq-v3-v5-1-bbfdb5afb7d3@iav.lv>
References: <20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3@iav.lv>
In-Reply-To: <20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Lukas Wunner <lukas@wunner.de>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Wei Fang <wei.fang@nxp.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Paul Barker <paul@pbarker.dev>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, 
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
 Shenwei Wang <shenwei.wang@nxp.com>, 
 Haoning Cheng <Haoning.CHENG@cn.bosch.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3325; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=C1KVbRUMobYSuANnRWhwFrVPRFRtgoiw1HCAab+6xfo=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFlf/h0VFfU2MMy68VQi8q4Jx/X4zBmnPe8GiMWLpbjty
 DMIU9jdUcrCIMbFICumyDLhkMatjCVX//p7mD+AmcPKBDKEgYtTACbiuZ6RYV7hGc2Dm7orj94t
 XMEvlOz/4EKP8y2FtTEXTqk+19s61YPhn9qyjcnXzGN0dzxlef9++ZKyvUzihR2NH7+2/npx0GD
 SXxYA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

irq_suspended and irq_rerun share a word with link, autoneg_complete
and interrupts. phy_interrupt() sets irq_rerun from the IRQ thread
without phydev->lock, while the state machine writes link and
autoneg_complete under it and phy_request_interrupt()/
phy_free_interrupt() write interrupts, so one read-modify-write can
undo another. A lost irq_rerun leaves the PHY interrupt disabled after
resume, as phy_interrupt() has already disabled the line.

The last patch of this series sets irq_suspended for PHYs whose MAC
driver manages PHY PM; with stmmac that happens before the MAC stops
the PHY, which widens the window.

Taking phydev->lock in phy_interrupt() alone does not close it:
phy_suspend() stores suspended in the same word and cannot hold the
lock across phy_may_wakeup(), which may take it, and phy_init_hw() and
mdio_bus_phy_suspend() write the word unlocked too. Locking every
writer, MAC drivers included, is a wide audit, and one missed now or
added later reopens the race.

Make both flags bools.

Fixes: 1758bde2e4aa ("net: phy: Don't trigger state machine while in suspend")
Tested-by: Haoning Cheng <Haoning.CHENG@cn.bosch.com>
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/net/phy/phy.c        | 2 +-
 drivers/net/phy/phy_device.c | 6 +++---
 include/linux/phy.h          | 5 +++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fce9bc7be330..9af303d60bd6 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1430,7 +1430,7 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 				pm_wakeup_dev_event(parent, 0, true);
 		}
 
-		phydev->irq_rerun = 1;
+		phydev->irq_rerun = true;
 		disable_irq_nosync(irq);
 		return IRQ_HANDLED;
 	}
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 06c5a8c8cc2a..f00086d72771 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -344,7 +344,7 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	 * has resumed. Wait for concurrent interrupt handler to complete.
 	 */
 	if (phy_interrupt_is_valid(phydev)) {
-		phydev->irq_suspended = 1;
+		phydev->irq_suspended = true;
 		synchronize_irq(phydev->irq);
 	}
 
@@ -394,14 +394,14 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 		return ret;
 no_resume:
 	if (phy_interrupt_is_valid(phydev)) {
-		phydev->irq_suspended = 0;
+		phydev->irq_suspended = false;
 		synchronize_irq(phydev->irq);
 
 		/* Rerun interrupts which were postponed by phy_interrupt()
 		 * because they occurred during the system sleep transition.
 		 */
 		if (phydev->irq_rerun) {
-			phydev->irq_rerun = 0;
+			phydev->irq_rerun = false;
 			enable_irq(phydev->irq);
 			irq_wake_thread(phydev->irq, phydev);
 		}
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 21afc2082b17..bbe28ff97e51 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -726,8 +726,9 @@ struct phy_device {
 
 	/* Interrupts are enabled */
 	unsigned interrupts:1;
-	unsigned irq_suspended:1;
-	unsigned irq_rerun:1;
+	/* Written without phydev->lock, so not bitfields */
+	bool irq_suspended;
+	bool irq_rerun;
 
 	unsigned default_timestamp:1;
 

-- 
2.43.0


