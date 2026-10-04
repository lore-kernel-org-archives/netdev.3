Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3872E480DED
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791146720; cv=none; b=e1TkBlELKFlD/uf0NIAWLxk0eEqFwtSyl1fHI2i45H6Q4thJiygwW7xLBre+dUypDmXTuj88bPjbAqgS4VxhSU03+ofZ3Z2HKCKtfZpyhnXxdrSII5bjNPedTNvpE+8IoQyD3Yd5sGnRte0Avy50/1DB2npt48uhjHlBv1J7zyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791146720; c=relaxed/simple;
	bh=xMoSp4FdgRy1bVhggGuIcX8pZXe1ZK1/2iziGVzC/54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQueLFNO4CUKkIdZ6TETf222mGhg+hsOyVH5chTTOxzuHGBwNzQjQPoC0LGdYI7PLcLCeu4YQutkCeKFDDyGasZprNa+C4ArnzRwFc54w1zVd3eRobq5PSSfiUooyyzN5pqMnSbnyYCjmouwSku/KEpA7Ukp0yXvN0oWpaY26eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjJW3LvZ; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjJW3LvZ"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24afso317882a91.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 13:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791146718; x=1791751518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/J6RbeRxty2BiTTIdArujRf0sFmvP2NG8OiyeIhsdc=;
        b=HjJW3LvZJD9dchZe7l+R5OKAnpVoMJdPMv4Abp79zyjgteX7pD1/CMm4zf2oorwVHm
         IJ3PG/IqfBuucTl2SBSNy+QDMjxihURo1KQ2vF+BPttykct8mJn1GabgHvJfN470/ZA2
         +84/RmvZOJYjU6mqQGcV1aj/hIMVWvVrExtmU8eHCekvHQv+HchQioZwttAENaiZ8lzA
         1bJxS269xdhDPBup0gTNIutPepbi0lCGF/YiirLx1Fsu/2GmhHtcGJ6xd9CUAoFg1XsV
         jc1Smd7g6ifNs9jlPaN1RrPiw7YSxFspx2/ryQFgD3KILBQVpoCHdMCk3uboR7p1AXBf
         OyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791146718; x=1791751518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/J6RbeRxty2BiTTIdArujRf0sFmvP2NG8OiyeIhsdc=;
        b=s3KqIb00zmUN2vS8vcowqdBaLkiyT+w1/su89mI9vIgEJQvqJMAsEBAtPJ2WOBm9OD
         DIwvQUQJIsLhoMELI8wGN2+9CcjxhPt20+cd/TQabg9q8l25Gcliwl/F94vphmmQKA2l
         azs3Fxi6DcXlT0AZNm0HgJfX2vHmE6+1vc641ByKWsYYMaSER8ifvDlTqaWkpkJQhWio
         JJt9XwYb6Jr4uraMIkMJ4YkELVKf90l9gzkY/PlpSx0gg32kdwTynIgDwdxpn+/44PER
         QbkKLaVrFO4nq5PzOWJKfFbxK/oCLCZ+hBftLNlW+WShOBi/Lgc4lQqZKDPs4zivHSux
         xoBA==
X-Gm-Message-State: AFq9FYJGnmXoF3OChbgObWsr4uKkfATlPee19OeVE4xGixWcSaszyz1h
	PmWMLVwQFTaR/UMhnZ4a+cHAMRfD0g63KwRl9mj40jTtKO0+LNx/3Ue893fqx2oN
X-Gm-Gg: AYBFou1w7hP8+VlPJuJ7s3sdsN7V3H6D8SqbFjAUtJUlVwd12BfWMlXGRPa23JuMLDi
	oLW6OQiEvzx8ZnUZdMlofEZXzirDJa7ENruZAkyGCgLWRwSDdyHD4N8pXEGiUE1MR0gKaDlOkch
	npsy8HcKXloXW1I9kNGM8Bg6Dz6yIRKzIF4jsEUFE+WHJx+2/Ajpxel5QM1DuBiN5G/t22/HxHC
	ibiYnPsQqb1ADgrIJ+J1LHq6Ds4ciXsnT9RNgQXAFuORoaiKD57O1igcepzVukYeLHv+nUs6HXp
	hjOq6kI7TmQFgPpL3bA6xbNP0YMHWo1wOwsNq/2gVO0CC+p+FwWPkkqoObQkr7z+/p1Cd+WNUC8
	hLikeTcyPIL41GMSAdNxyrQ9dVOvFownwlRD7zyIiKLfrR04zVRYrwpAfa56bYBmztX2EzyUs3R
	ge8jIuXsWes46/bfowl30ou+h5/oqboI30nInGtBqfc+daWuZkc2tw2SsL4jmntUgVit0EZmrb/
	+4HO6aPrAWys0hdLGPZQmyusFnmIIYRaj0HN0N6uDGgiWsuwNWg7TlIVCtHMMCMWMO2FRdm3ehK
	rjZ3JNgOUEB54K8I4QTa7CUYSPGJhEzBdOMN9VqwbnPmD8j+
X-Received: by 2002:a17:90b:3846:b0:3a0:c276:1ec2 with SMTP id 98e67ed59e1d1-3a6ce6af085mr3796668a91.19.1791146718441;
        Sun, 04 Oct 2026 13:45:18 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4262bcsm7753671a91.5.2026.10.04.13.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 13:45:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Stapelberg <michael@stapelberg.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net: phy: marvell: keep WOL_EIE across interrupt reconfiguration
Date: Sun,  4 Oct 2026 13:45:16 -0700
Message-ID: <20261004204516.281201-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

marvell_config_intr() rewrote the whole register, so the config_intr
call from phy_init_hw() on resume silently cleared WOL_EIE on polled
PHYs: m88e1318_get_wol() still reported WAKE_MAGIC, but a matched magic
packet was no longer routed to INTn and the board did not wake.

Give these two PHYs a dedicated config_intr that sets WOL_EIE from the
driver's own WoL state rather than from the hardware, so a bit left
armed by the bootloader or a previous kernel is cleared at probe. On the
disable path the bit is only kept for polled PHYs; with a PHY interrupt
the handler is about to be freed or not yet requested, and a latched
WoL event would be left with nobody to clear it. The enable path re-arms
it. Add a handle_interrupt that also claims the WoL event mirrored in
the interrupt status register. m88e1318_set_wol() now also clears WOL_EIE
when WoL is fully disabled, so "wol d" disarms it immediately.

Fixes: 3871c3876f80 ("mv643xx_eth with 88E1318S: support Wake on LAN")
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: resolved review warnings, including wol d.
 drivers/net/phy/marvell.c | 106 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index f71cffa88406..46527abab6af 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -354,6 +354,7 @@ struct marvell_priv {
 	u32 step;
 	s8 pair;
 	u8 vct_phase;
+	bool wol_armed;
 };
 
 static int marvell_read_page(struct phy_device *phydev)
@@ -425,6 +426,83 @@ static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
+/*
+ * On the 88E1318S/88E1510, copper page register 0x12 serves two
+ * masters: it is the MII_M1011_IMASK interrupt mask for the generic
+ * Marvell interrupt handling, and m88e1318_set_wol() sets the WoL
+ * interrupt enable bit (MII_88E1318S_PHY_CSIER_WOL_EIE) in it.
+ *
+ * config_intr runs from phy_probe(), from phy_init_hw() on attach and
+ * on resume, and from phy_request_interrupt()/phy_free_interrupt() on
+ * ifup/ifdown. Each of these rewrites the register, so the routines
+ * below re-arm WOL_EIE while WoL is set up; otherwise a resume would
+ * silently disarm Wake-on-LAN for the next suspend.
+ *
+ * WOL_EIE is derived from the driver's own WoL state rather than read
+ * back from the PHY, so a bit left armed by the bootloader or a
+ * previous kernel is cleared at probe/init instead of carried over.
+ */
+static int m88e1318_config_intr(struct phy_device *phydev)
+{
+	struct marvell_priv *priv = phydev->priv;
+	u16 wol_eie = 0;
+	int err;
+
+	if (priv->wol_armed)
+		wol_eie = MII_88E1318S_PHY_CSIER_WOL_EIE;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		err = marvell_ack_interrupt(phydev);
+		if (err < 0)
+			return err;
+
+		err = phy_write(phydev, MII_88E1318S_PHY_CSIER,
+				MII_M1011_IMASK_INIT | wol_eie);
+	} else {
+		/* On a polled PHY, keep WOL_EIE so an armed WoL event
+		 * still asserts INTn across phy_init_hw() on resume.
+		 *
+		 * With a PHY interrupt, being disabled means the handler
+		 * is not requested yet or is about to be freed, and
+		 * nobody would clear a latched WoL event; a shared line
+		 * would then be disabled as "nobody cared". Drop WOL_EIE
+		 * here, the enable path re-arms it.
+		 */
+		if (phy_interrupt_is_valid(phydev))
+			wol_eie = 0;
+
+		err = phy_write(phydev, MII_88E1318S_PHY_CSIER, wol_eie);
+		if (err < 0)
+			return err;
+
+		err = marvell_ack_interrupt(phydev);
+	}
+
+	return err;
+}
+
+static irqreturn_t m88e1318_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status;
+
+	irq_status = phy_read(phydev, MII_M1011_IEVENT);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	/* Claim events from the IMASK_INIT set as well as the WoL event
+	 * mirrored from WOL_EIE in the enable register.
+	 */
+	if (!(irq_status & (MII_M1011_IMASK_INIT |
+			    MII_88E1318S_PHY_CSIER_WOL_EIE)))
+		return IRQ_NONE;
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
 static int marvell_set_polarity(struct phy_device *phydev, int polarity)
 {
 	u16 val;
@@ -1969,6 +2047,7 @@ static void m88e1318_get_wol(struct phy_device *phydev,
 static int m88e1318_set_wol(struct phy_device *phydev,
 			    struct ethtool_wolinfo *wol)
 {
+	struct marvell_priv *priv = phydev->priv;
 	int err = 0, oldpage;
 
 	oldpage = phy_save_page(phydev);
@@ -2074,6 +2153,25 @@ static int m88e1318_set_wol(struct phy_device *phydev,
 			goto error;
 	}
 
+	if (!(wol->wolopts & (WAKE_MAGIC | WAKE_PHY))) {
+		/* Fully disabled: drop the WoL interrupt enable now
+		 * instead of waiting for the next config_intr call.
+		 */
+		err = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
+		if (err < 0)
+			goto error;
+
+		err = __phy_clear_bits(phydev, MII_88E1318S_PHY_CSIER,
+				       MII_88E1318S_PHY_CSIER_WOL_EIE);
+		if (err < 0)
+			goto error;
+	}
+
+	/* Let m88e1318_config_intr() re-arm CSIER.WOL_EIE, or keep it
+	 * cleared once WoL is disabled.
+	 */
+	priv->wol_armed = !!(wol->wolopts & (WAKE_MAGIC | WAKE_PHY));
+
 error:
 	return phy_restore_page(phydev, oldpage, err);
 }
@@ -3817,8 +3915,8 @@ static struct phy_driver marvell_drivers[] = {
 		.config_init = m88e1318_config_init,
 		.config_aneg = m88e1318_config_aneg,
 		.read_status = marvell_read_status,
-		.config_intr = marvell_config_intr,
-		.handle_interrupt = marvell_handle_interrupt,
+		.config_intr = m88e1318_config_intr,
+		.handle_interrupt = m88e1318_handle_interrupt,
 		.get_wol = m88e1318_get_wol,
 		.set_wol = m88e1318_set_wol,
 		.resume = genphy_resume,
@@ -3925,8 +4023,8 @@ static struct phy_driver marvell_drivers[] = {
 		.config_init = m88e1510_config_init,
 		.config_aneg = m88e1510_config_aneg,
 		.read_status = marvell_read_status,
-		.config_intr = marvell_config_intr,
-		.handle_interrupt = marvell_handle_interrupt,
+		.config_intr = m88e1318_config_intr,
+		.handle_interrupt = m88e1318_handle_interrupt,
 		.get_wol = m88e1318_get_wol,
 		.set_wol = m88e1318_set_wol,
 		.resume = m88e1510_resume,
-- 
2.56.0

