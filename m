Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794604001;
	b=c1fY+bBJ8GWHw49MjMCEbBcBd0Ulp56iYukzn0aqsea9MVigYJymiz98l7fw4V+jgAlt
	 96n5fISL+BdJF1zn6hopzVwd/lP9I/OUFc5F9PblYRL1AgIUDV4xMRFBYlfH0QMytqn6E
	 qz4S+9poMHKqo43aLYmlq3AkTBCzsdCFeZrrNlaxi9DhR5tEbhIlkqr/jQgAeB64TgAKd
	 9i7V3sg2/3uQBEm/GtbXVY0xVXY4RAOi4mB0ydTZX3cC6c6tGow6bgVLLxhQtlCyarZ5r
	 qxruD84Vc+EzTfXeCpKF6J3j8ucTAAuH5UQexd5mA21RaCTVIl9en9LPGDuwH8YjYKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604001;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cwtYdg7Ff/aGghpLaQ6sVil8yrw30S9ZwzKbTVNyIbs=;
	b=PcwVoLuuRFdQW9cED7Veffi1u7N1Cp17z241tbQQnDd25sP4SniyqaHZfAvkJmQiHTDx
	 /igPBxjs8RdfHsgM1v+h1CZ2//WAG3BODwDeGekOqSB7j0QBfyXSgCdxyuyfDXdLoBMXV
	 7zdR+WEJ9xMCUQpJkVV1v+jRu6ToW20JJf0yuCR29/vXYAIE5nDpUvf8KFAcXkllSOGHq
	 Aqt2UpqiiadqmA2ig+50M9GVjO2/4IyH2cFafTVcb7l3Ks/0qt35KayoxKuCZ1EXtE7v2
	 QoLTA+3W0hSMfTv2+olOlskpk8eFBA02V/uvnAV3EgiERGMKjEoWBzvIsmqV+LqGCMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eM/dPPIn";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE57E606A339;
	Fri, 13 Nov 2026 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eM/dPPIn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794604001;
	b=DOR+awFf7FKsr0h9Gk2kR6Od+sh/zKgNiQ2BhxF0QiPA7DclN0HWMNASSPcJiyvpA6mW
	 YtSTS1LZiqAGULGZ0QrE29gKL2dz7TPpmD+U2yh4Mh0CQWxfntAgN5AacnXxeMMlDlgPf
	 RETg86GkYkCgwI9ZmC3zxHUxHBTnOTLkhMms6gdorQ/arDyCuFAZfCEYWrebUmlWklSTH
	 8ZE/IVArsP7XVgWz+T3Dq0GO3BhSXacW5kP7PIFJMtRpoI75Bs8S5aCwDvq9XTGjMP8rn
	 Xue3tXwlk+z6V8rfns5x0EG6SMtVv9u6LifIIC5IpM4bEqPkctbuamEEzPLwAbpyUwg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794604001;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cwtYdg7Ff/aGghpLaQ6sVil8yrw30S9ZwzKbTVNyIbs=;
	b=dbFHCMwUFmSf+6xlX79fiBbHd94GTCphchEU70I1/vgWte9bPgx2QB3rGqxVGpL4BMd9
	 nQd9IY3G8QQk0xlVg/qV8IEgrS77FSttohbnZ0lAhrcmASLjUHtrZrMO3CCJ395o1Jn1p
	 YdFzZO31imSOLrwnSsP27q075FcegBHZZgK9cpPYSBvd4eq8EKWZX6P7YFQfBgypk6ipY
	 5SaxHMAyz3QQ8YeUv6XOQfNMBLM/63/1Hh5H9oTUvQu7brLJ1OI4djvD2M1/E4XjXUjUZ
	 4NZH3LbFljH/JVZE+Uk4mNILgbmjWuSdnLOBa/5d7yNgBheL/wGOYeYZkV1ZyDkNQTw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B75B71F000C5;
	Fri, 13 Nov 2026 21:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604001;
	bh=cwtYdg7Ff/aGghpLaQ6sVil8yrw30S9ZwzKbTVNyIbs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=eM/dPPIn8tVA/KWZfJeZ9gMUtV5692qzXFom31dUMnjdFx3ek4nAzpkCLKdhzj5/t
	 a55lW6jRdXCB7IZNNx+MkHxUN54rB2O0rMLOdQkw/1247ScqWyq5SrHGzlpnlIVXZU
	 865x0tYGq2WIrTko9KMO7HnOE0egmya2sri8E3rNUKqukQmkd3O91yxo1ZvTP0xthz
	 vFZBcW7E9cVWxn1K5FbPSLAM5cuKikkApXwHik5s/BwLF3yDecvF6ixuj1i/bwFzoI
	 Np8Nsn8zV8v9Qvs7VYTA/N47NGHvULehiI7ajxOztry2fnfRUSzYkuBAnOWGJID1dJ
	 x91U3izj87NGQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 46C9849AEB;
	Fri, 13 Nov 2026 21:06:40 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Fri, 13 Nov 2026 21:06:35 +0000
Subject: [PATCH net v6 1/4] net: phy: move irq_suspended and irq_rerun out
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
Message-Id: <20261113-b4-phylib-mac-pm-irq-v3-v6-1-05af2503cb23@iav.lv>
References: <20261113-b4-phylib-mac-pm-irq-v3-v6-0-05af2503cb23@iav.lv>
In-Reply-To: <20261113-b4-phylib-mac-pm-irq-v3-v6-0-05af2503cb23@iav.lv>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3375; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=Qlv4+bRQfcVjpy/H1IULOONZkAOElJ21mxexa2OAmIQ=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFnfq+9G6Cyb7Dkx/cFsV3czU65VDc8+F22O1jlzPbZz3
 Vr2xOkqHaUsDGJcDLJiiiwTDmncylhy9a+/h/kDmDmsTCBDGLg4BWAiheUM/ywDLsffO64ScFhg
 h+G+qd+U5p7gOub8aa9di2/Gg51M3XYM/4tOV+zY02ou71z/bm5XSt/l79VaEnPWaPHNnNuskBe
 byQIA
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
 include/linux/phy.h          | 7 +++++--
 3 files changed, 9 insertions(+), 6 deletions(-)

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
index b39e945cebd7..1791d578f4dd 100644
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
index 21afc2082b17..59c75296d535 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -726,8 +726,11 @@ struct phy_device {
 
 	/* Interrupts are enabled */
 	unsigned interrupts:1;
-	unsigned irq_suspended:1;
-	unsigned irq_rerun:1;
+	/* Not bitfields: phy_interrupt() and the PM callbacks write them
+	 * without phydev->lock
+	 */
+	bool irq_suspended;
+	bool irq_rerun;
 
 	unsigned default_timestamp:1;
 

-- 
2.43.0


