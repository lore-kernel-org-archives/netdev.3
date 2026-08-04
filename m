Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B97A41D21F;
	Tue,  4 Aug 2026 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813061; cv=none; b=QGaFF8dpXmwfiSsI5ZpAoAV9E+rTS3Gy4sXoiiaw7QVo8GMqbRkC9Hfg2zKh/ogXOSq2cms/4wTkBbK4DU6RtwhJkGQKPU2u7rdFbCtXw0XMJUdSBic8g58Exe4rTyLCAQ2eicvIqh9NCu3/W8LRKkhdjWatPPju3fL2d90t5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813061; c=relaxed/simple;
	bh=tX8MbX7a1nCwghjOyoElljxt29Um9JEC02OIIOUHF5k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdvgKecg3q2nT/OYYsIyzmH7BmLygD/KiSWg7wclKdS4x40HIJoRgYXeNor+zG0yzlEC8MYZkyDsGgsGmFZz68HLH6h2EeBIfj175LCs3YMQv3QNfwz2nupULwMB17ReNsOE/3r1OtuFieySVXSCp8DMbwVY6+IT2HVUfnGV4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wr5YH-0000000045u-3fjr;
	Tue, 04 Aug 2026 03:10:49 +0000
Date: Tue, 4 Aug 2026 04:10:46 +0100
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
Subject: [PATCH net v2 4/6] net: dsa: mt7530: check CORE_PLL_GROUP4 access in
 mt7531_setup()
Message-ID: <a7dfe3b66ea6ac1ae7915034de0527060e6ddcd4.1785811140.git.daniel@makrotopia.org>
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

mt7531_setup() reads CORE_PLL_GROUP4 through the MT7531 indirect c45
PHY access, modifies it and writes it back to enable the PHY core
PLL, but checks neither the read nor the write. Now that the indirect
access functions propagate command-write failures, a failed read
returns a negative errno that would be bit-modified and written back
into the PLL register, and a failed write-back would go unnoticed.
Check both and bail out. The adjacent EEE advertisement writes push a
constant value and cannot corrupt state, so they are left as is.

Fixes: c288575f7810 ("net: dsa: mt7530: Add the support of MT7531 switch")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: new patch

 drivers/net/dsa/mt7530.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 2a17696e6a45..69cee61564cb 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2781,14 +2781,20 @@ mt7531_setup(struct dsa_switch *ds)
 	 * phy_[read,write]_mmd_indirect is called, we provide our own
 	 * mt7531_ind_mmd_phy_[read,write] to complete this function.
 	 */
-	val = mt7531_ind_c45_phy_read(priv,
+	ret = mt7531_ind_c45_phy_read(priv,
 				      MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
 				      MDIO_MMD_VEND2, CORE_PLL_GROUP4);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
 	val |= MT7531_RG_SYSPLL_DMY2 | MT7531_PHY_PLL_BYPASS_MODE;
 	val &= ~MT7531_PHY_PLL_OFF;
-	mt7531_ind_c45_phy_write(priv,
-				 MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
-				 MDIO_MMD_VEND2, CORE_PLL_GROUP4, val);
+	ret = mt7531_ind_c45_phy_write(priv,
+				       MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
+				       MDIO_MMD_VEND2, CORE_PLL_GROUP4, val);
+	if (ret < 0)
+		return ret;
 
 	/* Disable EEE advertisement on the switch PHYs. */
 	for (i = MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr);
-- 
2.55.0
