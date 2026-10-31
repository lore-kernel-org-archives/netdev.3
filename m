Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793433679;
	b=VvzoQPjTGcrMOpJ4LN/xxcMu2ANfk3KY5sVaNj++M9ld7ttuMuv65q4XuVLoSGV5KDYG
	 mSD9snkeVCQuoJvsaUhnBBvTzAtU6N5pMt15WKBSOk5D0BPaDwInZP8h0vHTCh10yvdTS
	 qc8XNt1EYtBEBp8EHl0bcpEC890gtsvYGjYXOrveqvAF/fcJyPgbjhPGbVPsyTJBPU6Cj
	 3dj+TM3O5yrPVxsbJTs9FR/DdGx5rSrFa20OYs6jXp+EygNd4CwYJNnek4lZN25h72NEu
	 9Z3i0scqPl8jIpl3uDnm4aiS+0kkWuWUmLWT2vJgYuICMYpm/mMrWSdxIDTNByuRUjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433679;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0shUdWLrlfl3zsB5DqFVB9CKTz8Sw4TtsJF/Thx/CBc=;
	b=iQgMnwGgtiWHBHariHCFTGl+AM60CVsWG/fexr7TxdpS7I5o6WZ9oNBFrFqIdDPcTJ0L
	 Un7PyOuggKyRGKCX5jLtbhsVZmHreHebXt5TQ2ynhGKqtRtfnQuml65lOUFUQjD2fRoVV
	 T3OTOAx5D77A0hcDYSrP52gySoC3JeyS1e0Ko0N7tOrJkXxdD0ZtSijo+gIBNwASI+FsU
	 m7aMNbOaFpTtjZpXijekvyMJO4qG566VxMOPh+Zt2Ym6ZseMoFtJRNRH/GAAuQCJWFZp8
	 VAmycr3+SYOov7mjZKJO90wEEsc+CUcGHFP0VjNZHPU/VgGFgJYjq7J02YdrDwnYSoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2tGt5RE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427D606A320;
	Sat, 31 Oct 2026 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2tGt5RE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793433679;
	b=g5rrDo14Vjb+FWbS50S5ZWgxxWdX90Ox+xx1fuJG+nPSDv7O4iLSPd9yQ+JtvoYNu1si
	 6Go79s4/00UhWGill2VyZbuJHHRBvaNC4altAjqfGJyf/Hz7yV3AbB0nuz2EOaDvr6EW1
	 Rl87NKmoSt3fVdDmmjk8h34g4P6MCz1fF12Pn+J/J5d3neQlaaue5L+zKpX0EnDRkW6qk
	 el5bydVuL7MgXtgPIoWQ01Ho8wLXTtlPV+4JBVil+CTlkGHXs4lzVauslXYrWMDlWqbJB
	 g+Rvq2I+hmYQ3Tr5S8T30gFGD9d+fP8huxqtzDjo4CeUIaOpp8XSXEHGQUF4JcHBh6w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793433679;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0shUdWLrlfl3zsB5DqFVB9CKTz8Sw4TtsJF/Thx/CBc=;
	b=R6CkR0B3sdVS2AK2ElpAqmbzXA+2MR/Mwy05gZdExR+dGRU/LB+pvymNVAlHqbSkRZ7K
	 cRvaSCcxChfyEW5VrQ7Lt3CLINUII0tzbTsxpvYOACtJZGf3qCriv8qsVoTdcBQUPbPqM
	 5AAN7+I9TMC2lz7ygcsinl07z6RjB1V8TbAv8mjK19kam8XDzgtetYB+msTylzist35Jl
	 uuuMCyf5wzIr5wk3cFTD6LVB/Sd8e5SOGVULdLcWs455je9HRt9ZZ8UTIqkmaiDZDr8Fy
	 Lu+vIPjDFdtlj/DCTBGOXlPPRvY4QoYe4Va8KNwf1l5jI8Y0z+Bpm6myteH8GKjCcfQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DFBB21F00919;
	Sat, 31 Oct 2026 08:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793433679;
	bh=0shUdWLrlfl3zsB5DqFVB9CKTz8Sw4TtsJF/Thx/CBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=W2tGt5RE+iuUs1Iei3StAM3EUFgcJfviBBt+1Vc+lTBlJFMLn/bhMJYiQbl4gtW8g
	 kpgAbWeuokSlp5EOCLe6dm9FSSLuoyghqxFdiAwXn2rh+bKDrznTYNzwtLNPF4RraB
	 baYgRE4U0LgMEJlOr3VvXRz8XAjETtnb0Bsam3sdFavJK2wLqICGwCUCEN0Od0Tf09
	 tMDCYoMl7vggW9i7VXGoVX/W+fYZzGalowjin0fpteQzrf8YJQYrlhMTLg3gChU7dV
	 NpxR96glXQkkSizYaApYJcSyi/eK42QvKKLPjpIEji18Q8BW5Wz8zrdc2fZI+TR0d7
	 X48UBAVEcgoqg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 59DB345E4A;
	Sat, 31 Oct 2026 08:01:17 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sat, 31 Oct 2026 08:01:12 +0000
Subject: [PATCH net v4 1/5] net: phy: move irq_suspended and irq_rerun out
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
Message-Id: <20261031-b4-phylib-mac-pm-irq-v3-v4-1-5ba23b3ff9a4@iav.lv>
References: <20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4@iav.lv>
In-Reply-To: <20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4@iav.lv>
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
 Shenwei Wang <shenwei.wang@nxp.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3270; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=KGtMCy0MgMn0SEvbNWCC+6Y82DmP1gBxDIHvvGFg2dU=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFlPF3hpPV8vX/h24owjK2RVF2uzyosfcw3gmSlbpyf1m
 F1mnVNYRykLgxgXg6yYIsuEQxq3MpZc/evvYf4AZg4rE8gQBi5OAZjITEtGhkWPM0TW8YVFyLNv
 fGd0VsVz/b9n+fqrTvyT37LzUWaMy3SGf8bWnQF5e5Ss3D93L1iatStQdNGypJNa/74HM1mYLDi
 lxAEA
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
index 5d4508bcfbe9..79dba43d703a 100644
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


