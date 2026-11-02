Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626163;
	b=tgAsOrLbJmNVmN1cD7UcLGF5AosRjFdg9sUtL5Q5ggaQmAdCm/mj8jabsaC9tC70QsJV
	 kGeMvQeiuC7aTeY1ObfHQeC4Cs4F9riODs70P8Mo6v4mTINl+H1o7nay6cGKyVjOELz6d
	 KrrALc/+2qplq8b+X4exmyIFT9zdTlqtrVSulsg3+sqn8URo8z59cgayXtQlDA5me94TP
	 NbZdwxCO1vZQvSqs4SYmBp3dpZgt1xX1FQ2e7udlzbRprKdLRskpDRUeQe18A5bTWbBu1
	 0pjbXzNjuGInI78W3ixM2djBDAK6nE8oAcjRmS+XXXqDrW5SW2npG4f7ckdd1Omeudw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ty31UixZMR0FOPCqD5p7Tp42Nj5uvmQqWeSDdyuvVR8=;
	b=CtdbW2QktCtlSkdKTF/cN/AeAIa16CgfUn69EEuNHSSryXLfQBr218mcne+PSIV1kJ8t
	 DFTidVfpH4HEABroLiBmSds6mKchmlx7Tc3bVPrcy1ApovZ45Hpx41QGGV1y0FuoUGU7i
	 EZyjrhPG/Hk4Mzct+Czfu6J/M2WPxVBrvEiPcAgz4glP3lrHEGJvCCx0wiJhR1M3/LFs7
	 EgQ1bsXgZrwr6jnpLz6jFz+gGODYOZ8Lg5to4l3yE3zYta164Zh0fOwd8Jy56c7N0/BYu
	 t1Ig3KlkUKKNV68bHYm18P0v0tqGrHCtWspdZ6CYG//9dMZRUXrdtmG7FfdM6S0FBfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ndpEhwdB;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03683606A33F
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 13:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03683606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ndpEhwdB
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3535a54bed9so4523207eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 05:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793626161; x=1794230961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ty31UixZMR0FOPCqD5p7Tp42Nj5uvmQqWeSDdyuvVR8=;
        b=ndpEhwdBXmtUGjuQLkcC3iwaf4xRR1PCLTmUssQjyIcMFCSIIvC3wmWF+y0P0TRAl9
         zTgMqhoqo3vzNcDTbpdWS9nu+wCxLecI/ouwzpv1aAX1W5qZ07sYUi/C8udcSTgdpgRb
         kWkoCPtSKa3/kqXmUaeqe1Jq9S/WQn/S99+9+LJGZWaCf48C0K9qPGhXFCnAH2Is4qrL
         jsOrQt0OVuyN3jyciRqpLFrebfqYVnN/fdOIBSpurBBWa2MjwNJJZw8V0XxRkYnGOo/F
         WLNol46b8fcaWjo4dgbRUH7VDcUGPz/bnHJK4ee4ne/B3D0ijcZcSTUYOAvKsVXBhr4O
         JP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793626161; x=1794230961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ty31UixZMR0FOPCqD5p7Tp42Nj5uvmQqWeSDdyuvVR8=;
        b=by56yN7lei1Cn36gb5bPnEviLZVx/TSreKsSmfbUb6TLP+kQhaSDP7CluvizJPrckD
         9/IC1nvjDlb76BZboLiOtzh8/FP5tqwA7kYk2VgLjAW/ce6VeabOXfJRmNCAjACUqN2+
         fwItUFieYiY3upoMPmpq7V3PuyTwPekO0/Rf4R2cS0WKnh9DQ4wWLzkLvwAeipwGave/
         sCD7qkBQkBSZTq1WXybGroxTr3BW+UQUvTUkwU2ijU9ST5qR5jYxIJzJG28lJMtElKlk
         BiQoss2LRJzGwMP89FgfQO1CHPP9xjKt/Ei5tICauaWyWIF5EVWmWoJCZzgWU04y9CwY
         6xlg==
X-Gm-Message-State: AFq9FYLnJKKYnjAxyNJk7qG8feAwjW+8U68CyUW3kCfmeUA8VdgrIvpC
	OiyCQGZBo6yZmhE0rznFRitYiioHJvt8IaeLO2S0Ef1zvkcLf5O0BGZurrFEi/qL
X-Gm-Gg: AYBFou019THqtANbjHHqMZvsmyV9IEVVULNmEB5tYWnlrCUTrlMGoFz45TozSOzkyC1
	nqh1L/pBMW9IpSDkWggDH31+WagwPYtud/iO9P3vyZ14AJ7V60ybMpmnK8NBVPsm8Py/+uPwFDj
	s8mlNPxBUU22vNkbCPE4+bc5ai7nSflmRfgJ7lju+0azOzi0ipaeAVCd6uxCy2BDAhoZInhfOuG
	VACR2ybG5VXr4a/H/mMYcS+RBb7mkCJP/fumUFUAxjf+OlXP9dlnzwGce4jlvfG7a1AX6jclZ0s
	/g9DY2rdGeLKthCHzFfWA07qyzK0Bi0gZt1trEPAiU6FijlsccLkNOmcYaTS+RM7Qv4HFx2WWso
	p76t6uY95IC8XTPH/Uu0dyvFayQHZl98toxmcIeAP4QyPNzWS5adAKbasK2DmGKr25ozf6+E9+D
	IAe/e0gScm5MkAabd1+kop41ShPdtgNF2pzP8ho8G8HPp739lmczT3NlXyWksor4NSxDcUA1//i
	LJ4YjIZF6feIcFANKTBveimKnk9f3gCfeO6xgkLfB8ETqlpkQDXpEm9FHfeCn/nRCe1hHriPAsQ
	6JxIfuS9Va/Jxyr7mMni8ojSRkvVrPRSOC0b0XY1gIaQBorwURr4El49AwAemNfrPkfF4DAaTx7
	6Lhna9NDyh1J1cF/tZvdjChpT
X-Received: by 2002:a05:701b:4502:10b0:163:fd28:5658 with SMTP id a92af1059eb24-1ac5b02289fmr15049596c88.22.1793626160847;
        Mon, 02 Nov 2026 05:29:20 -0800 (PST)
Received: from ubuntu-22.. (36-229-14-41.dynamic-ip.hinet.net. [36.229.14.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcf67csm34357844c88.21.2026.11.02.05.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:29:19 -0800 (PST)
From: Tommy Shih <tommy.shih92@gmail.com>
To: netdev@vger.kernel.org
Cc: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Lucien . Jheng" <lucienzx159@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: air_an8801: add WAKE_PHY Wake-on-LAN support
Date: Mon,  2 Nov 2026 21:29:03 +0800
Message-Id: <20261102132903.713908-1-tommy.shih92@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AN8801R can wake up the system on a link change, but the driver
only supports WAKE_MAGIC and always masks the link change event on
suspend. Supporting WAKE_PHY allows the system to be woken up when
the cable is plugged in or unplugged.

Add WAKE_PHY support:
- Keep the link change interrupt enabled, and only disable it on
  suspend when the PHY is set to wake up by magic packet only.
- Report a wakeup event when a link change interrupt is seen with
  WAKE_PHY enabled.
- Enable device wakeup when either WAKE_MAGIC or WAKE_PHY is set.

Signed-off-by: Tommy Shih <tommy.shih92@gmail.com>
---

 drivers/net/phy/air_an8801.c | 38 +++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/air_an8801.c b/drivers/net/phy/air_an8801.c
index f97c78e43023..bf09c1fee398 100644
--- a/drivers/net/phy/air_an8801.c
+++ b/drivers/net/phy/air_an8801.c
@@ -560,7 +560,7 @@ static int an8801r_led_init(struct phy_device *phydev, u8 *led_cfg)
 	return ret;
 }
 
-static int an8801r_reset_wake(struct phy_device *phydev)
+static int an8801r_reset_wake(struct phy_device *phydev, bool suspend)
 {
 	struct an8801r_priv *priv = phydev->priv;
 	u32 reg_val = 0;
@@ -584,7 +584,10 @@ static int an8801r_reset_wake(struct phy_device *phydev)
 	if (priv->wake_magic_enabled)
 		reg_val |= AN8801_WOL_WAKE_MAGIC_EN;
 
-	if (priv->wake_lnkchg_enabled)
+	/* The link change event is needed for link state interrupts while
+	 * running, but must only wake the system up if WAKE_PHY is enabled.
+	 */
+	if (priv->wake_lnkchg_enabled || !suspend)
 		reg_val |= AN8801_WOL_WAKE_LNKCHG_EN;
 
 	ret = an8801_buckpbus_reg_write(phydev, AN8801_BPBUS_REG_WAKEUP_CTL1,
@@ -603,7 +606,7 @@ static int an8801r_ack_interrupt(struct phy_device *phydev)
 	int ret;
 
 	/* Reset wake status */
-	ret = an8801r_reset_wake(phydev);
+	ret = an8801r_reset_wake(phydev, phydev->suspended);
 	if (ret)
 		return ret;
 
@@ -651,6 +654,7 @@ static int an8801r_config_intr(struct phy_device *phydev)
 
 static irqreturn_t an8801r_handle_interrupt(struct phy_device *phydev)
 {
+	struct an8801r_priv *priv = phydev->priv;
 	u32 irq_status = 0;
 	bool irq_handled = false;
 	int ret;
@@ -670,6 +674,8 @@ static irqreturn_t an8801r_handle_interrupt(struct phy_device *phydev)
 	}
 
 	if (irq_status & AN8801_IRQ_WAKE_LNKCHG) {
+		if (priv->wake_lnkchg_enabled)
+			pm_wakeup_event(&phydev->mdio.dev, 0);
 		phy_trigger_machine(phydev);
 		irq_handled = true;
 	}
@@ -680,6 +686,7 @@ static irqreturn_t an8801r_handle_interrupt(struct phy_device *phydev)
 static void an8801r_get_wol(struct phy_device *phydev,
 			    struct ethtool_wolinfo *wol)
 {
+	struct an8801r_priv *priv = phydev->priv;
 	u32 reg_val;
 	int ret;
 
@@ -691,9 +698,12 @@ static void an8801r_get_wol(struct phy_device *phydev,
 		return;
 	}
 
-	wol->supported = WAKE_MAGIC;
+	wol->supported = WAKE_MAGIC | WAKE_PHY;
 	wol->wolopts = 0;
 
+	if (priv->wake_lnkchg_enabled)
+		wol->wolopts |= WAKE_PHY;
+
 	ret = an8801_buckpbus_reg_read(phydev, AN8801_BPBUS_REG_WAKEUP_CTL1,
 				       &reg_val);
 	if (ret)
@@ -717,7 +727,7 @@ static int an8801r_set_wol(struct phy_device *phydev,
 	if (!device_can_wakeup(&phydev->mdio.dev))
 		return -EOPNOTSUPP;
 
-	if (wol->wolopts & ~WAKE_MAGIC)
+	if (wol->wolopts & ~(WAKE_MAGIC | WAKE_PHY))
 		return -EINVAL;
 
 	if (wol->wolopts & WAKE_MAGIC) {
@@ -775,9 +785,11 @@ static int an8801r_set_wol(struct phy_device *phydev,
 	}
 
 	priv->wake_magic_enabled = !!(wol->wolopts & WAKE_MAGIC);
+	priv->wake_lnkchg_enabled = !!(wol->wolopts & WAKE_PHY);
 
 	return device_set_wakeup_enable(&phydev->mdio.dev,
-					priv->wake_magic_enabled);
+					priv->wake_magic_enabled ||
+					priv->wake_lnkchg_enabled);
 }
 
 static int an8801r_of_init_leds(struct phy_device *phydev, u8 *led_cfg)
@@ -1040,8 +1052,6 @@ static int an8801r_probe(struct phy_device *phydev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->wake_lnkchg_enabled = true;
-
 	phydev->priv = priv;
 
 	/* Mark this PHY as wakeup capable and register the interrupt as a
@@ -1063,12 +1073,11 @@ static int an8801r_suspend(struct phy_device *phydev)
 	int ret;
 
 	/* If the PHY may wake up by a Wake-on-LAN (WOL) event, disable the link
-	 * interrupt to only keep the WOL magic interrupt enabled
+	 * interrupt unless wake on link change (WAKE_PHY) is enabled
 	 */
 	if (device_may_wakeup(&phydev->mdio.dev)) {
-		priv->wake_lnkchg_enabled = false;
-
-		if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		if (!priv->wake_lnkchg_enabled &&
+		    phydev->interrupts == PHY_INTERRUPT_ENABLED) {
 			ret = an8801_buckpbus_reg_clear_bits(phydev,
 							     AN8801_BPBUS_REG_WAKE_IRQ_EN,
 							     AN8801_IRQ_WAKE_LNKCHG);
@@ -1077,7 +1086,7 @@ static int an8801r_suspend(struct phy_device *phydev)
 		}
 
 		/* Reset WOL status */
-		ret = an8801r_reset_wake(phydev);
+		ret = an8801r_reset_wake(phydev, true);
 		if (ret)
 			return ret;
 	}
@@ -1090,7 +1099,6 @@ static int an8801r_suspend(struct phy_device *phydev)
 
 static int an8801r_resume(struct phy_device *phydev)
 {
-	struct an8801r_priv *priv = phydev->priv;
 	int ret;
 
 	ret = genphy_resume(phydev);
@@ -1101,8 +1109,6 @@ static int an8801r_resume(struct phy_device *phydev)
 	 * state interrupts.
 	 */
 	if (device_may_wakeup(&phydev->mdio.dev)) {
-		priv->wake_lnkchg_enabled = true;
-
 		ret = an8801_buckpbus_reg_set_bits(phydev,
 						   AN8801_BPBUS_REG_WAKEUP_CTL1,
 						   AN8801_WOL_WAKE_LNKCHG_EN);
---
base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
branch: an8801-wake-phy

-- 
2.34.1

