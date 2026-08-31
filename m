Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CF9469850;
	Mon, 31 Aug 2026 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190697; cv=none; b=YDZx59QN8XtJ00q4FpqO3I0a3eNOq8OxqGZKoefD20jsWwJjUkZw2NqK45HoFUAOOro3RH/g5xVXFvt1Lu6xxVhufZJGIcSo06QaHdJpqoXxtHVGUo6QbDvdrjfjsqHH6wNKiIDfGjGYYHdUt1DyJGxEnqq9elKHLLwA493QJn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190697; c=relaxed/simple;
	bh=SZm4gI1arKUo6bRwEjFOMmgVelAD//tDmZCOzo0Ec7c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPHczsWgLrrTLbQw3PXQqfhvKup1CKSTPc0O8OI7C5oeyTFgO/sdzrdQRH5VZd2EHZ395pA7SAm8GER/SB9Epq4XKHcN3VWjHhYvwiz7QAkJgf/Zzfu1SBvwNf5DH7P5hRqEPubF/e+nWeR1JqrA3KfAHH918LxoUvKI7CGD2yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1x145J-0000000079c-23xo;
	Mon, 31 Aug 2026 15:38:09 +0000
Date: Mon, 31 Aug 2026 16:38:06 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v5 2/9] net: dsa: mt7530: fold mt7530_mii_write/read
 into mt7530_write/read
Message-ID: <591c4e7ff5b1b6d39aac7f0f04eb67f36f40d8a2.1788190568.git.daniel@makrotopia.org>
References: <cover.1788190568.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1788190568.git.daniel@makrotopia.org>

With the lock wrappers removed in the previous commit, mt7530_write()
was a trivial wrapper around mt7530_mii_write(), and mt7530_read()
around mt7530_mii_read() via _mt7530_read(). Fold the function bodies
and eliminate the intermediate functions.

The _mt7530_read() poll helper for readx_poll_timeout() is renamed to
mt7530_mii_poll() and calls mt7530_read().

Callers are updated using the following semantic patch:

@@
expression E1, E2, E3;
@@
-mt7530_mii_write(E1, E2, E3)
+mt7530_write(E1, E2, E3)

@@
expression E1, E2;
@@
-mt7530_mii_read(E1, E2)
+mt7530_read(E1, E2)

@@
expression list args;
@@
-readx_poll_timeout(_mt7530_read, args)
+readx_poll_timeout(mt7530_mii_poll, args)

The two readx_poll_timeout() call sites keep their original line
wrapping, which spatch reflows for the longer helper name.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v5: mt7530_write() keeps returning int, folding in the error
    propagation from mt7530_mii_write(), instead of becoming void, and
    _mt7530_read() is the only remaining poll helper to rename
v4: no changes
v3: no changes
v2: no changes
---
 drivers/net/dsa/mt7530.c | 43 +++++++++++++---------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index dbf70e5dd55f..3f36a2a9f665 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -155,7 +155,7 @@ core_clear(struct mt7530_priv *priv, u32 reg, u32 val)
 }
 
 static int
-mt7530_mii_write(struct mt7530_priv *priv, u32 reg, u32 val)
+mt7530_write(struct mt7530_priv *priv, u32 reg, u32 val)
 {
 	int ret;
 
@@ -169,7 +169,7 @@ mt7530_mii_write(struct mt7530_priv *priv, u32 reg, u32 val)
 }
 
 static u32
-mt7530_mii_read(struct mt7530_priv *priv, u32 reg)
+mt7530_read(struct mt7530_priv *priv, u32 reg)
 {
 	int ret;
 	u32 val;
@@ -185,25 +185,10 @@ mt7530_mii_read(struct mt7530_priv *priv, u32 reg)
 	return val;
 }
 
-static int
-mt7530_write(struct mt7530_priv *priv, u32 reg, u32 val)
-{
-	return mt7530_mii_write(priv, reg, val);
-}
-
 static u32
-_mt7530_read(struct mt7530_dummy_poll *p)
+mt7530_mii_poll(struct mt7530_dummy_poll *p)
 {
-	return mt7530_mii_read(p->priv, p->reg);
-}
-
-static u32
-mt7530_read(struct mt7530_priv *priv, u32 reg)
-{
-	struct mt7530_dummy_poll p;
-
-	INIT_MT7530_DUMMY_POLL(&p, priv, reg);
-	return _mt7530_read(&p);
+	return mt7530_read(p->priv, p->reg);
 }
 
 static void
@@ -547,7 +532,7 @@ mt7531_ind_c45_phy_read(struct mt7530_priv *priv, int port, int devad,
 
 	reg = MT7531_MDIO_CL45_ADDR | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_DEV_ADDR(devad) | regnum;
-	ret = mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	ret = mt7530_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
 	if (ret < 0)
 		goto out;
 
@@ -560,7 +545,7 @@ mt7531_ind_c45_phy_read(struct mt7530_priv *priv, int port, int devad,
 
 	reg = MT7531_MDIO_CL45_READ | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_DEV_ADDR(devad);
-	ret = mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	ret = mt7530_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
 	if (ret < 0)
 		goto out;
 
@@ -596,7 +581,7 @@ mt7531_ind_c45_phy_write(struct mt7530_priv *priv, int port, int devad,
 
 	reg = MT7531_MDIO_CL45_ADDR | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_DEV_ADDR(devad) | regnum;
-	ret = mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	ret = mt7530_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
 	if (ret < 0)
 		goto out;
 
@@ -609,7 +594,7 @@ mt7531_ind_c45_phy_write(struct mt7530_priv *priv, int port, int devad,
 
 	reg = MT7531_MDIO_CL45_WRITE | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_DEV_ADDR(devad) | data;
-	ret = mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	ret = mt7530_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
 	if (ret < 0)
 		goto out;
 
@@ -644,7 +629,7 @@ mt7531_ind_c22_phy_read(struct mt7530_priv *priv, int port, int regnum)
 	val = MT7531_MDIO_CL22_READ | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_REG_ADDR(regnum);
 
-	ret = mt7530_mii_write(priv, MT7531_PHY_IAC, val | MT7531_PHY_ACS_ST);
+	ret = mt7530_write(priv, MT7531_PHY_IAC, val | MT7531_PHY_ACS_ST);
 	if (ret < 0)
 		goto out;
 
@@ -681,7 +666,7 @@ mt7531_ind_c22_phy_write(struct mt7530_priv *priv, int port, int regnum,
 	reg = MT7531_MDIO_CL22_WRITE | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_REG_ADDR(regnum) | data;
 
-	ret = mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	ret = mt7530_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
 	if (ret < 0)
 		goto out;
 
@@ -1428,7 +1413,7 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	if (!dsa_is_cpu_port(ds, port))
 		return 0;
 
-	val = mt7530_mii_read(priv, MT7530_GMACCR);
+	val = mt7530_read(priv, MT7530_GMACCR);
 	val &= ~MAX_RX_PKT_LEN_MASK;
 
 	/* RX length also includes Ethernet header, MTK tag, and FCS length */
@@ -1445,7 +1430,7 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 		val |= MAX_RX_PKT_LEN_JUMBO;
 	}
 
-	mt7530_mii_write(priv, MT7530_GMACCR, val);
+	mt7530_write(priv, MT7530_GMACCR, val);
 
 	return 0;
 }
@@ -2467,7 +2452,7 @@ mt7530_setup(struct dsa_switch *ds)
 
 	/* Waiting for MT7530 got to stable */
 	INIT_MT7530_DUMMY_POLL(&p, priv, MT753X_TRAP);
-	ret = readx_poll_timeout(_mt7530_read, &p, val, val != 0,
+	ret = readx_poll_timeout(mt7530_mii_poll, &p, val, val != 0,
 				 20, 1000000);
 	if (ret < 0) {
 		dev_err(priv->dev, "reset timeout\n");
@@ -2708,7 +2693,7 @@ mt7531_setup(struct dsa_switch *ds)
 
 	/* Waiting for MT7530 got to stable */
 	INIT_MT7530_DUMMY_POLL(&p, priv, MT753X_TRAP);
-	ret = readx_poll_timeout(_mt7530_read, &p, val, val != 0,
+	ret = readx_poll_timeout(mt7530_mii_poll, &p, val, val != 0,
 				 20, 1000000);
 	if (ret < 0) {
 		dev_err(priv->dev, "reset timeout\n");
-- 
2.55.0
