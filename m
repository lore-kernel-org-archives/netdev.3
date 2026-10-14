Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8739222B594
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 00:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791937540; cv=none; b=VJhAXe6IGP5qHvZvBRJp7l7Nono9adcf6tkekXLSBAa20GfbAtuBtR0EDg7/3IwnUGq5gFzqQpu1g54t4cuw/eF0AwtE0FS3mZj+iRABOhlNuIBgKJJZuf0c9FmmTReUy3W2LnOMgYSFEh7MmwTOYxIhVMTuHwt/VaVVxPF7Zag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791937540; c=relaxed/simple;
	bh=7TtvYdq9/TC1chudyLJHYpw3Uv7naWy8pFQg6rij4Do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lne8ZXF4iXO7CA9Azj8Pjg//VtlxvdcJH8mVECwI85UZfgh2w2vfsJewxhDsBu/GfBpX3lH/WXqKe9bEarB/ruVQwnKZ2H12Ot8sYrrGkBcphaHSbR9eHjPwyU6nLDTXwYB0V+3pB39DSabPDqx+pp0DRG0JeKdl/R6wN0mExdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rHmAofs5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHmAofs5"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-892734ce7e6so1393522b3a.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791937537; x=1792542337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lwAGilf8XPAN8IgKAoTZWrMVSJPekmcQlKbM/o+0xfU=;
        b=rHmAofs5wYOGLvdUG92qOgKUD2eE91jY1JywLgEE89bl8nsHPTbye46BPru5de9g56
         R6aQoVQWCOBiHBivsrqq5KcKg0ooHlBFq97llb1nxK4KFJlKfnpbiuHKzgmH2SFhYv7O
         caQjneH93/61X4TQx3w7GU2dkotS6oKLKFslJTPYZxeV89qDWB8Pa3SS39uR+RzCzae0
         PcGOCaDiZoFOgyJzlW6oADLafbykbxG+Z6eS5LqQgH8DG91/aa5U5jte/9e13Johxgzp
         lI4jm1JhMWfX9YEHvn5ZpC5zSbXpvrpPv116wj8vQ6RXNm42gIzsy2Yh6s9GDI1k4awW
         3E8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791937537; x=1792542337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lwAGilf8XPAN8IgKAoTZWrMVSJPekmcQlKbM/o+0xfU=;
        b=NY0Orxr7xo3IKqqKm4gLIf/va3QhikcNgI2RAxXJSVjBINmInyirY34ArWlWrcz5ZT
         qODlQcUkC2pysJoBsULaRlLhSM5iShD91YNsYnafBpfu4EGr7E/z3g1hpRnL2lNv+auZ
         t0dldlCizJqgd5JMSb8lGMPYYSmZZUzF3KpOWao9gK0Pnn1akXqiuibs3mDMGdIGexcf
         8GvJ1isdEGm9nWSeQito/Rv1h0GLPQtflLVHLn/xunp1vY7pNUkRcMkdbLSvHwouuMLV
         vIN6k7Q48RZmQQmNW6ps6zgNMZFgcfo+ebiCpqyuqBDQaNuwbmvaRFU/zfWb9AFzejYd
         1KpA==
X-Gm-Message-State: AFq9FYIS9ecSH+v4fsfHCeEPJaQwUd3Fy9FrShKAKDsAnC2bKoZSKafZ
	pcazCCz584aNORxkDjm6DFBQmDZHauN+99w/O7seQwtW68sG3f34yxo0BJ+CBXnD
X-Gm-Gg: AYBFou2wCU+lLZG2pFvJ5MK7SmZ3Z9YYzb5x49hfcjghgpou0OGA6yebfOxhHeeh27O
	VT+dNa+ANU5JvdCaGjOwJsFJWmW3p+vwUY0ngMQEoOH0Snb6Zh82MmFWbysbVCyYidwQCDAevdM
	ym4sJp1PzsL5ZIMPUgOyr2DI5bzV5Bc4p+Z8dRPk/pLgfVOfKrxt8j/c2P0/bw328L/FMEiaPOw
	mwEDmC7oDcqP46PjQtWzMOgXo2j4qi9dyKVT5Iqn2sJWRydJKRjywV0gjw8v3hegyn1HyeDFrlN
	oxdRMYjs25DSNXFOr5yaTUsPHyBWpPpCoMTyQqmld0VycaoPiGWLbxHw/wvAUoMxmAa/MYXOI81
	BJQqpbCSPrm3H+mbqWShbJUwFVhTVs3WljnP7Ii3ZYLkAU4umDxQZ6aIihhlHdmw0Xgsv3S3oFh
	DqmGWAl8BaIAyeNhHoeLFzDH0Zns9xAeyHKkFmGFfGMPCQz8tVDz9NVH0AUULv6BUXT07NG7cvw
	8D/lJdUo+1/xPaZG4X9FHi0qB8JczUxR69exab7sc43AP5QUkI735qAtkvDlujcfcLCyseI4aOI
	a5XOYmIeaRDuMsIB6eNAZnJqhDtoGm5/JtISAtUgi8hVi4Ub
X-Received: by 2002:a05:6a00:428b:b0:89c:6036:c63 with SMTP id d2e1a72fcca58-89c6036151fmr4301555b3a.32.1791937536539;
        Tue, 13 Oct 2026 17:25:36 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d802a4b80sm454684b3a.15.2026.10.13.17.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 17:25:35 -0700 (PDT)
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
Subject: [PATCH net v5] net: phy: marvell: keep WOL_EIE across interrupt reconfiguration
Date: Tue, 13 Oct 2026 17:25:34 -0700
Message-ID: <20261014002534.149200-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

marvell_config_intr() rewrites the whole interrupt enable register, so
the config_intr call from phy_init_hw() on resume silently cleared
WOL_EIE on the 88E1318S and 88E1510: m88e1318_get_wol() still reported
WAKE_MAGIC, but a matched magic packet was no longer routed to INTn and
the board did not wake.

Bit 7 of that register is WOL_EIE only on these two PHYs; on others,
such as the 88E1111, it enables a FIFO error interrupt. So give the
88E1318S and 88E1510 their own config_intr and handle_interrupt, and
leave the shared callbacks unchanged.

m88e1318_set_wol() now records whether WoL is enabled, and both it and
the new config_intr derive WOL_EIE from that state under the MDIO bus
lock. WOL_EIE stays set across config_intr while WoL is enabled, except
when the PHY has an interrupt line and interrupts are being disabled,
as in phy_free_interrupt(): INTn is then the PHY IRQ, and nothing would
read IEVENT after free_irq() to release it. The bit is set again once
interrupts are re-enabled. phy_probe() still clears a WOL_EIE left by a
previous boot, since WoL starts out disabled. The new handler also
claims WoL events, so they do not go unacknowledged when the PHY IRQ is
in use.

Helios4 (Armada 388, 88E1512), 7.2.9. With this patch WOL_EIE stays set
over 3 link down/up cycles, "wol d" clears it, and a magic packet on a
running board is a handled interrupt. Without it, WOL_EIE is lost on the
first down/up, survives "wol d", and the magic packet is an unhandled
interrupt.

Fixes: 3871c3876f80 ("mv643xx_eth with 88E1318S: support Wake on LAN")
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Tested-by: Igor Velkov <iav@iav.lv>
---
 drivers/net/phy/marvell.c | 97 ++++++++++++++++++++++++++++++---------
 1 file changed, 75 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index f71cffa88406..94e8dbe9a859 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -55,6 +55,8 @@
 #define MII_M1011_IMASK			0x12
 #define MII_M1011_IMASK_INIT		0x6400
 #define MII_M1011_IMASK_CLEAR		0x0000
+/* WOL Event Interrupt Enable, 88E1318S and 88E1510 only */
+#define MII_M1011_IMASK_WOL		BIT(7)
 
 #define MII_M1011_PHY_SCR			0x10
 #define MII_M1011_PHY_SCR_DOWNSHIFT_EN		BIT(11)
@@ -139,11 +141,6 @@
 #define MII_88E1318S_PHY_MSCR1_REG	16
 #define MII_88E1318S_PHY_MSCR1_PAD_ODD	BIT(6)
 
-/* Copper Specific Interrupt Enable Register */
-#define MII_88E1318S_PHY_CSIER				0x12
-/* WOL Event Interrupt Enable */
-#define MII_88E1318S_PHY_CSIER_WOL_EIE			BIT(7)
-
 #define MII_88E1318S_PHY_LED_FUNC		0x10
 #define MII_88E1318S_PHY_LED_FUNC_OFF		(0x8)
 #define MII_88E1318S_PHY_LED_FUNC_ON		(0x9)
@@ -354,6 +351,7 @@ struct marvell_priv {
 	u32 step;
 	s8 pair;
 	u8 vct_phase;
+	bool wol_enabled;
 };
 
 static int marvell_read_page(struct phy_device *phydev)
@@ -407,7 +405,8 @@ static int marvell_config_intr(struct phy_device *phydev)
 	return err;
 }
 
-static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
+static irqreturn_t __marvell_handle_interrupt(struct phy_device *phydev,
+					      u16 mask)
 {
 	int irq_status;
 
@@ -417,7 +416,7 @@ static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
 		return IRQ_NONE;
 	}
 
-	if (!(irq_status & MII_M1011_IMASK_INIT))
+	if (!(irq_status & mask))
 		return IRQ_NONE;
 
 	phy_trigger_machine(phydev);
@@ -425,6 +424,57 @@ static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
+{
+	return __marvell_handle_interrupt(phydev, MII_M1011_IMASK_INIT);
+}
+
+/* WOL_EIE also routes WoL events to INTn. Keep it set while WoL is enabled,
+ * unless INTn is the PHY interrupt and that interrupt is being disabled:
+ * nothing would read IEVENT after free_irq() to release the line.
+ */
+static u16 m88e1318_wol_imask(struct phy_device *phydev)
+{
+	struct marvell_priv *priv = phydev->priv;
+
+	if (priv->wol_enabled &&
+	    (phydev->interrupts == PHY_INTERRUPT_ENABLED ||
+	     !phy_interrupt_is_valid(phydev)))
+		return MII_M1011_IMASK_WOL;
+
+	return 0;
+}
+
+static int m88e1318_config_intr(struct phy_device *phydev)
+{
+	bool enable = phydev->interrupts == PHY_INTERRUPT_ENABLED;
+	u16 imask;
+	int err;
+
+	if (enable) {
+		err = marvell_ack_interrupt(phydev);
+		if (err)
+			return err;
+	}
+
+	/* Serialise against m88e1318_set_wol() updating wol_enabled */
+	phy_lock_mdio_bus(phydev);
+	imask = enable ? MII_M1011_IMASK_INIT : MII_M1011_IMASK_CLEAR;
+	imask |= m88e1318_wol_imask(phydev);
+	err = __phy_write(phydev, MII_M1011_IMASK, imask);
+	phy_unlock_mdio_bus(phydev);
+	if (err || enable)
+		return err;
+
+	return marvell_ack_interrupt(phydev);
+}
+
+static irqreturn_t m88e1318_handle_interrupt(struct phy_device *phydev)
+{
+	return __marvell_handle_interrupt(phydev, MII_M1011_IMASK_INIT |
+					  MII_M1011_IMASK_WOL);
+}
+
 static int marvell_set_polarity(struct phy_device *phydev, int polarity)
 {
 	u16 val;
@@ -1969,18 +2019,27 @@ static void m88e1318_get_wol(struct phy_device *phydev,
 static int m88e1318_set_wol(struct phy_device *phydev,
 			    struct ethtool_wolinfo *wol)
 {
+	struct marvell_priv *priv = phydev->priv;
 	int err = 0, oldpage;
 
 	oldpage = phy_save_page(phydev);
 	if (oldpage < 0)
 		goto error;
 
-	if (wol->wolopts & (WAKE_MAGIC | WAKE_PHY)) {
-		/* Explicitly switch to page 0x00, just to be sure */
-		err = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
-		if (err < 0)
-			goto error;
+	priv->wol_enabled = !!(wol->wolopts & (WAKE_MAGIC | WAKE_PHY));
 
+	/* Explicitly switch to page 0x00, just to be sure */
+	err = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
+	if (err < 0)
+		goto error;
+
+	/* Update the WOL interrupt enable */
+	err = __phy_modify(phydev, MII_M1011_IMASK, MII_M1011_IMASK_WOL,
+			   m88e1318_wol_imask(phydev));
+	if (err < 0)
+		goto error;
+
+	if (priv->wol_enabled) {
 		/* If WOL event happened once, the LED[2] interrupt pin
 		 * will not be cleared unless we reading the interrupt status
 		 * register. If interrupts are in use, the normal interrupt
@@ -1990,12 +2049,6 @@ static int m88e1318_set_wol(struct phy_device *phydev,
 		if (!phy_interrupt_is_valid(phydev))
 			__phy_read(phydev, MII_M1011_IEVENT);
 
-		/* Enable the WOL interrupt */
-		err = __phy_set_bits(phydev, MII_88E1318S_PHY_CSIER,
-				     MII_88E1318S_PHY_CSIER_WOL_EIE);
-		if (err < 0)
-			goto error;
-
 		err = marvell_write_page(phydev, MII_MARVELL_LED_PAGE);
 		if (err < 0)
 			goto error;
@@ -3817,8 +3870,8 @@ static struct phy_driver marvell_drivers[] = {
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
@@ -3925,8 +3978,8 @@ static struct phy_driver marvell_drivers[] = {
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

