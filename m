Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6143876D5;
	Thu, 30 Jul 2026 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427422; cv=none; b=KGEPK0hAQtMSmFBJq4DDqkBeBJ18TNsvZFsJwmNMq+U2WClqhhIkyTemFvKR/wB4QkWv6q3LG9QqcQuC6qO2zkmDCR0kxie9jHzaTDGiquEeHk211ZIF4nGneqaesxskfynCKrCxc3IqaRHdFHjC0feD8i0vyvKvB9Yyf4htkcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427422; c=relaxed/simple;
	bh=KXliLWw/7uPWOxOFtYB2m0wZD5Bh+Pv04zt7pJA8XP8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4elSi1InBZYswKW/XrulqM48CBsFpHhwHhD7+mxZLUxK7LRaYD9YIFq1cO0GKnPrbIHU/rMuXeHYIBlOa656L2NN96B38uY5gA0vrKkEGzEfE/uEeQMbfh3jlbOhGT03HzjfdD0/ttFu3ubrnFImOBCkPuJ7TRyNcCEbld8epg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wpTEL-000000007XC-00gx;
	Thu, 30 Jul 2026 16:03:33 +0000
Date: Thu, 30 Jul 2026 17:03:29 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net 3/4] net: dsa: mt7530: error out on failed PHY_IAC
 command writes
Message-ID: <2c0409afcdbd795fbc15b0cd3c9018474c272883.1785427248.git.daniel@makrotopia.org>
References: <cover.1785427248.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785427248.git.daniel@makrotopia.org>

MT7531_PHY_ACS_ST is only ever set by the command write that precedes
each poll in the MT7531 indirect PHY access functions, and that
write's return value is discarded. A failed write leaves ACS_ST at 0
from the previous access, so the poll succeeds on its first iteration
and the functions return stale IAC contents as if they were fresh PHY
data. Check the writes and bail out before polling.

Fixes: c288575f7810 ("net: dsa: mt7530: Add the support of MT7531 switch")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mt7530.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 9be6fb63c311..2a17696e6a45 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -565,7 +565,9 @@ mt7531_ind_c45_phy_read(struct mt7530_priv *priv, int port, int devad,
 
 	reg = MT7531_MDIO_CL45_ADDR | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_DEV_ADDR(devad) | regnum;
-	mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	ret = mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	if (ret < 0)
+		goto out;
 
 	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
 				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -576,7 +578,9 @@ mt7531_ind_c45_phy_read(struct mt7530_priv *priv, int port, int devad,
 
 	reg = MT7531_MDIO_CL45_READ | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_DEV_ADDR(devad);
-	mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	ret = mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	if (ret < 0)
+		goto out;
 
 	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
 				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -610,7 +614,9 @@ mt7531_ind_c45_phy_write(struct mt7530_priv *priv, int port, int devad,
 
 	reg = MT7531_MDIO_CL45_ADDR | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_DEV_ADDR(devad) | regnum;
-	mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	ret = mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	if (ret < 0)
+		goto out;
 
 	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
 				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -621,7 +627,9 @@ mt7531_ind_c45_phy_write(struct mt7530_priv *priv, int port, int devad,
 
 	reg = MT7531_MDIO_CL45_WRITE | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_DEV_ADDR(devad) | data;
-	mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	ret = mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	if (ret < 0)
+		goto out;
 
 	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
 				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -654,7 +662,9 @@ mt7531_ind_c22_phy_read(struct mt7530_priv *priv, int port, int regnum)
 	val = MT7531_MDIO_CL22_READ | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_REG_ADDR(regnum);
 
-	mt7530_mii_write(priv, MT7531_PHY_IAC, val | MT7531_PHY_ACS_ST);
+	ret = mt7530_mii_write(priv, MT7531_PHY_IAC, val | MT7531_PHY_ACS_ST);
+	if (ret < 0)
+		goto out;
 
 	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
 				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -689,7 +699,9 @@ mt7531_ind_c22_phy_write(struct mt7530_priv *priv, int port, int regnum,
 	reg = MT7531_MDIO_CL22_WRITE | MT7531_MDIO_PHY_ADDR(port) |
 	      MT7531_MDIO_REG_ADDR(regnum) | data;
 
-	mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	ret = mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
+	if (ret < 0)
+		goto out;
 
 	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, reg,
 				       !(reg & MT7531_PHY_ACS_ST), 20, 100000);
-- 
2.55.0
