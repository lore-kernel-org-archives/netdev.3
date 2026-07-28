Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C871E5B68;
	Tue, 28 Jul 2026 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785214366; cv=none; b=VlC60MWtiaCkoJMnx/6YnuPYz8VC7r8WOro0OtZ1FP6cQ2fH0ZEBtpATdc1lYvKQf8ihTARc2/GqYvUmZdoUuWbNexAiOwvFyT5pzm7R1TY578DSgmFmHDaaEeW3MHFgywqRrLgeucVqEUV5/Z1IxQ1FGHKmC0cMe3/F9PUpXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785214366; c=relaxed/simple;
	bh=bh/9yJ3ep9h60S5JaBbz+KzkUmPGGRLOLIQFG4GoUGY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ivgp4XWEd0kRddtMNC5LUotICKGgpILnvYiboV2R9lHnRgoeBsJaJkXa0ZJ876oA8fyl0+Vu6VCA5UIyCvQltbsPiFRuglHKItlIqwuNjSpV3N9lndBKTLyUe9TBlX4VlGO5nt8skqnsyBfT+9HhxllSEs8jYP9yQky/AGErb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1woZns-000000004xS-1W8y;
	Tue, 28 Jul 2026 04:52:32 +0000
Date: Tue, 28 Jul 2026 05:52:29 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net 3/3] net: dsa: mt7530: error out on failed reads in
 MT7531 PHY polling
Message-ID: <79e85d68d210cc37342978171aa6432aa2954333.1785213071.git.daniel@makrotopia.org>
References: <cover.1785213071.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785213071.git.daniel@makrotopia.org>

The MT7531 indirect PHY access functions poll MT7531_PHY_IAC through
a helper which returns 0 when the underlying read fails, so a failed
bus transaction clears MT7531_PHY_ACS_ST and the access carries on,
returning garbage PHY register data to phylib.

Poll using regmap_read_poll_timeout(), which stops on read errors and
propagates them. These functions hold the MDIO bus lock across the
whole sequence, so the unlocked regmap accesses remain correct. Remove
the now-unused _mt7530_unlocked_read().

Fixes: c288575f7810 ("net: dsa: mt7530: Add the support of MT7531 switch")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mt7530.c | 58 ++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 38 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 51555060b5eb..55131bfd11f6 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -191,12 +191,6 @@ mt7530_write(struct mt7530_priv *priv, u32 reg, u32 val)
 	mt7530_mutex_unlock(priv);
 }
 
-static u32
-_mt7530_unlocked_read(struct mt7530_dummy_poll *p)
-{
-	return mt7530_mii_read(p->priv, p->reg);
-}
-
 static u32
 _mt7530_read(struct mt7530_dummy_poll *p)
 {
@@ -553,16 +547,13 @@ static int
 mt7531_ind_c45_phy_read(struct mt7530_priv *priv, int port, int devad,
 			int regnum)
 {
-	struct mt7530_dummy_poll p;
 	u32 reg, val;
 	int ret;
 
-	INIT_MT7530_DUMMY_POLL(&p, priv, MT7531_PHY_IAC);
-
 	mt7530_mutex_lock(priv);
 
-	ret = readx_poll_timeout(_mt7530_unlocked_read, &p, val,
-				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
+	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
+				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
 	if (ret < 0) {
 		dev_err(priv->dev, "poll timeout\n");
 		goto out;
@@ -572,8 +563,8 @@ mt7531_ind_c45_phy_read(struct mt7530_priv *priv, int port, int devad,
 	      MT7531_MDIO_DEV_ADDR(devad) | regnum;
 	mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
 
-	ret = readx_poll_timeout(_mt7530_unlocked_read, &p, val,
-				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
+	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
+				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
 	if (ret < 0) {
 		dev_err(priv->dev, "poll timeout\n");
 		goto out;
@@ -583,8 +574,8 @@ mt7531_ind_c45_phy_read(struct mt7530_priv *priv, int port, int devad,
 	      MT7531_MDIO_DEV_ADDR(devad);
 	mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
 
-	ret = readx_poll_timeout(_mt7530_unlocked_read, &p, val,
-				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
+	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
+				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
 	if (ret < 0) {
 		dev_err(priv->dev, "poll timeout\n");
 		goto out;
@@ -601,16 +592,13 @@ static int
 mt7531_ind_c45_phy_write(struct mt7530_priv *priv, int port, int devad,
 			 int regnum, u16 data)
 {
-	struct mt7530_dummy_poll p;
 	u32 val, reg;
 	int ret;
 
-	INIT_MT7530_DUMMY_POLL(&p, priv, MT7531_PHY_IAC);
-
 	mt7530_mutex_lock(priv);
 
-	ret = readx_poll_timeout(_mt7530_unlocked_read, &p, val,
-				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
+	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
+				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
 	if (ret < 0) {
 		dev_err(priv->dev, "poll timeout\n");
 		goto out;
@@ -620,8 +608,8 @@ mt7531_ind_c45_phy_write(struct mt7530_priv *priv, int port, int devad,
 	      MT7531_MDIO_DEV_ADDR(devad) | regnum;
 	mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
 
-	ret = readx_poll_timeout(_mt7530_unlocked_read, &p, val,
-				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
+	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
+				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
 	if (ret < 0) {
 		dev_err(priv->dev, "poll timeout\n");
 		goto out;
@@ -631,8 +619,8 @@ mt7531_ind_c45_phy_write(struct mt7530_priv *priv, int port, int devad,
 	      MT7531_MDIO_DEV_ADDR(devad) | data;
 	mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
 
-	ret = readx_poll_timeout(_mt7530_unlocked_read, &p, val,
-				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
+	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
+				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
 	if (ret < 0) {
 		dev_err(priv->dev, "poll timeout\n");
 		goto out;
@@ -647,16 +635,13 @@ mt7531_ind_c45_phy_write(struct mt7530_priv *priv, int port, int devad,
 static int
 mt7531_ind_c22_phy_read(struct mt7530_priv *priv, int port, int regnum)
 {
-	struct mt7530_dummy_poll p;
 	int ret;
 	u32 val;
 
-	INIT_MT7530_DUMMY_POLL(&p, priv, MT7531_PHY_IAC);
-
 	mt7530_mutex_lock(priv);
 
-	ret = readx_poll_timeout(_mt7530_unlocked_read, &p, val,
-				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
+	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
+				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
 	if (ret < 0) {
 		dev_err(priv->dev, "poll timeout\n");
 		goto out;
@@ -667,8 +652,8 @@ mt7531_ind_c22_phy_read(struct mt7530_priv *priv, int port, int regnum)
 
 	mt7530_mii_write(priv, MT7531_PHY_IAC, val | MT7531_PHY_ACS_ST);
 
-	ret = readx_poll_timeout(_mt7530_unlocked_read, &p, val,
-				 !(val & MT7531_PHY_ACS_ST), 20, 100000);
+	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
+				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
 	if (ret < 0) {
 		dev_err(priv->dev, "poll timeout\n");
 		goto out;
@@ -685,16 +670,13 @@ static int
 mt7531_ind_c22_phy_write(struct mt7530_priv *priv, int port, int regnum,
 			 u16 data)
 {
-	struct mt7530_dummy_poll p;
 	int ret;
 	u32 reg;
 
-	INIT_MT7530_DUMMY_POLL(&p, priv, MT7531_PHY_IAC);
-
 	mt7530_mutex_lock(priv);
 
-	ret = readx_poll_timeout(_mt7530_unlocked_read, &p, reg,
-				 !(reg & MT7531_PHY_ACS_ST), 20, 100000);
+	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, reg,
+				       !(reg & MT7531_PHY_ACS_ST), 20, 100000);
 	if (ret < 0) {
 		dev_err(priv->dev, "poll timeout\n");
 		goto out;
@@ -705,8 +687,8 @@ mt7531_ind_c22_phy_write(struct mt7530_priv *priv, int port, int regnum,
 
 	mt7530_mii_write(priv, MT7531_PHY_IAC, reg | MT7531_PHY_ACS_ST);
 
-	ret = readx_poll_timeout(_mt7530_unlocked_read, &p, reg,
-				 !(reg & MT7531_PHY_ACS_ST), 20, 100000);
+	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, reg,
+				       !(reg & MT7531_PHY_ACS_ST), 20, 100000);
 	if (ret < 0) {
 		dev_err(priv->dev, "poll timeout\n");
 		goto out;
-- 
2.55.0
