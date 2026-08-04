Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41DB2E738F;
	Tue,  4 Aug 2026 03:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813050; cv=none; b=S1Ow8OdwW90jbP5EuQqh3sdztVAZkOc3blj3sMOcgV+R67b5g08m1FamBRnUmzwCkWOM1hoXMEkIh8b2Z6Dg525KTjCd+yafUFvdv4Wdarkmw8j7sQ8jNsWbfs21CdZUw4rTOev/NqQgfV0cw9u1ZuXA/24d1gN7H2539+C7OkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813050; c=relaxed/simple;
	bh=LaB2HzoBoW6c2aVohdkBdN0RbmtCp5y0fZ7MdYfXKKE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9c3NIW1I7XxKoagCQOzn0finGpzOb7/kKr0iaqmRthCKfTyO9EDzGYFwnmBR1pE70Bh6RhdBT15qT9Aowp7AuDu0wcEyavnKrT5jJyspygBWgmbC8xG8n3X/pwecm5PQj5KYreqqcslKhwIZU4N4Zmgjd84wzzVWS+JtkHxx7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wr5YB-0000000045K-150F;
	Tue, 04 Aug 2026 03:10:43 +0000
Date: Tue, 4 Aug 2026 04:10:40 +0100
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
	Sean Wang <sean.wang@mediatek.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 3/6] net: dsa: mt7530: error out on failed PHY_IAC
 command writes
Message-ID: <c34602e63a20ebbfb97babd145c82832d7a0b523.1785811140.git.daniel@makrotopia.org>
References: <cover.1785811140.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785811140.git.daniel@makrotopia.org>

MT7531_PHY_ACS_ST is only ever set by the command write that precedes
each poll in the MT7531 indirect PHY access functions, and that
write's return value is discarded. A failed write leaves ACS_ST at 0
from the previous access, so the poll succeeds on its first iteration
and the functions return stale IAC contents as if they were fresh PHY
data. Check the writes and bail out before polling.

Fixes: c288575f7810 ("net: dsa: mt7530: Add the support of MT7531 switch")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2: no changes

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
