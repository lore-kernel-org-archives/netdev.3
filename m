Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E4D1B4F09;
	Thu, 30 Jul 2026 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370502; cv=none; b=diITGTuG5xP/HkDDNpIFWl1+XjYUIVXqiXogwERINBZHWwA/wD2Y3KFc6/+vhD9k4TtPP4/PeA67kvbBT4aPqviaUOwGNV+3fO925BD/w/FWle0pY4h8ffCV2VdGJYYqBFCP+6NdibTfUA5471R0o/4aryF0sNDbuS1EEQ5veck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370502; c=relaxed/simple;
	bh=yWRWko7MppgFDoU+FbLOboA8Xzh6tym5SMEq6SERbTI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPtlLP8BAgaMKHcT/AZIfO9rECt3y343Okw9gKKiY1vS50Y+O2NQViZmfZjaP3m0QQlsg5Ka+kayYRNGxCrVHrPSRSwdluLrQj+6UELFTS5tRznfiUWdXrr9j34gHelA3+5p9KumKz8kkO+nPd2wESy7zUzQX7A/ffTh/Krtfx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wpEQC-000000002f9-2oqg;
	Thu, 30 Jul 2026 00:14:48 +0000
Date: Thu, 30 Jul 2026 01:14:45 +0100
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
	Florian Fainelli <f.fainelli@gmail.com>,
	Landen Chao <Landen.Chao@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 2/5] net: dsa: mt7530: check bus->read() errors in the
 MDIO regmap backend
Message-ID: <cead5b47a21b7aeb8fc869f072ba981fc93aa6f0.1785368701.git.daniel@makrotopia.org>
References: <cover.1785368701.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785368701.git.daniel@makrotopia.org>

bus->read() returns a negative errno on failure, but
mt7530_regmap_read() assigns it to a u16, truncating e.g. -ETIMEDOUT
into 0xff92, and returns success. The garbage word is then consumed as
register data, and read-modify-write cycles write it back to the
switch. Check both reads and propagate their errors.

The same defect existed in mt7530_mii_read() since the driver was
introduced and moved into the regmap backend unchanged. core_rmw(),
which accesses the MMD core registers directly rather than through the
regmap, has the identical unchecked bus->read(); fix it the same way.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2:
 * also check the identical unchecked bus->read() in core_rmw()
   (found by Sashiko AI review)
 * split the mtk_pcs_lynxi_get_state() fix into its own patch

 drivers/net/dsa/mt7530-mdio.c | 11 +++++++++--
 drivers/net/dsa/mt7530.c      |  6 +++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 11ea924a9f35..784dd58a7158 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -55,8 +55,15 @@ mt7530_regmap_read(void *context, unsigned int reg, unsigned int *val)
 	if (ret < 0)
 		return ret;
 
-	lo = bus->read(bus, priv->mdiodev->addr, r);
-	hi = bus->read(bus, priv->mdiodev->addr, 0x10);
+	ret = bus->read(bus, priv->mdiodev->addr, r);
+	if (ret < 0)
+		return ret;
+	lo = ret;
+
+	ret = bus->read(bus, priv->mdiodev->addr, 0x10);
+	if (ret < 0)
+		return ret;
+	hi = ret;
 
 	*val = (hi << 16) | (lo & 0xffff);
 
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 3c2a3029b10c..f349b54c2d9e 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -124,8 +124,12 @@ core_rmw(struct mt7530_priv *priv, u32 reg, u32 mask, u32 set)
 		goto err;
 
 	/* Read the content of the MMD's selected register */
-	val = bus->read(bus, MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
+	ret = bus->read(bus, MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
 			MII_MMD_DATA);
+	if (ret < 0)
+		goto err;
+	val = ret;
+
 	val &= ~mask;
 	val |= set;
 	/* Write the data into MMD's selected register */
-- 
2.55.0
