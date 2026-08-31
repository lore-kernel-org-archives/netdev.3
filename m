Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD92B53D0CE;
	Mon, 31 Aug 2026 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190736; cv=none; b=ZKgXeDoNJ+Jj+MmC7ja+4IhoM6Z+nuw2vBFflaMq5rM21Y22khsJIrKHftUdKiPswKoTAsrRT0tCLYHLlJrZ2DUpdE8Amho2LS4AKRPzG4JdA07bPMFqpx6lODz2egUtGOkN28bICXqqY/Xm7LtyqcCSxIkKcZWcJZ13nm8JSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190736; c=relaxed/simple;
	bh=5DoPt7myBAXZ6v+B/04JxEv2Zyns5dekvnqO+ZJ7+ak=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+lQE6EJs5DoN9G5z4tG9x2zu+Xv+LMJ8H4UvAWpHNOvVoyhb85EIpQ2iQDJVz/OoR+TKaM0ZaLExkh0py181eVlMZWcA93dm4o/tpWj+ixBStgFUvQops5GF9hbCWza5SMms185tdB3TIU7ME0Sy3hcD8sAi+C4iSRL7426PKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1x145x-000000007C7-2SVY;
	Mon, 31 Aug 2026 15:38:49 +0000
Date: Mon, 31 Aug 2026 16:38:46 +0100
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
Subject: [PATCH net-next v5 6/9] net: dsa: mt7530: drop the dummy poll
 machinery
Message-ID: <609dcd8dd0c335e36bbc8df41413da58af1dbfb4.1788190568.git.daniel@makrotopia.org>
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

Convert the two remaining switch reset polls to
regmap_read_poll_timeout() and remove struct mt7530_dummy_poll,
INIT_MT7530_DUMMY_POLL() and the mt7530_mii_poll() helper. As with the
command polls addressed by the preceding fixes, a failed read now
terminates the poll with an error instead of being fed to the loop
condition as a zero value.

Generated using the following semantic patch, plus removal of the two
now-unused definitions from mt7530.h:

// Poll the register through regmap so a failed read ends the poll.
@@
expression priv, reg;
identifier p, ret, val;
@@
-	INIT_MT7530_DUMMY_POLL(&p, priv, reg);
-	ret = readx_poll_timeout(mt7530_mii_poll, &p, val, val != 0,
-				 20, 1000000);
+	ret = regmap_read_poll_timeout(priv->regmap, reg, val, val != 0,
+				       20, 1000000);

@@
identifier p;
@@
- struct mt7530_dummy_poll p;
  ... when != p

@@
identifier p;
type T;
@@
-static T mt7530_mii_poll(struct mt7530_dummy_poll *p) { ... }

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v5: new patch
---
 drivers/net/dsa/mt7530.c | 22 ++++------------------
 drivers/net/dsa/mt7530.h | 12 ------------
 2 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 57f38d39058a..9a56b6875ad7 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -154,16 +154,6 @@ core_clear(struct mt7530_priv *priv, u32 reg, u32 val)
 	core_rmw(priv, reg, val, 0);
 }
 
-static u32
-mt7530_mii_poll(struct mt7530_dummy_poll *p)
-{
-	u32 val;
-
-	regmap_read(p->priv->regmap, p->reg, &val);
-
-	return val;
-}
-
 static int
 mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
 {
@@ -2379,7 +2369,6 @@ mt7530_setup(struct dsa_switch *ds)
 	struct device_node *dn = NULL;
 	struct device_node *phy_node;
 	struct device_node *mac_np;
-	struct mt7530_dummy_poll p;
 	phy_interface_t interface;
 	struct dsa_port *cpu_dp;
 	u32 id, val;
@@ -2440,9 +2429,8 @@ mt7530_setup(struct dsa_switch *ds)
 	}
 
 	/* Waiting for MT7530 got to stable */
-	INIT_MT7530_DUMMY_POLL(&p, priv, MT753X_TRAP);
-	ret = readx_poll_timeout(mt7530_mii_poll, &p, val, val != 0,
-				 20, 1000000);
+	ret = regmap_read_poll_timeout(priv->regmap, MT753X_TRAP, val,
+				       val != 0, 20, 1000000);
 	if (ret < 0) {
 		dev_err(priv->dev, "reset timeout\n");
 		return ret;
@@ -2665,7 +2653,6 @@ static int
 mt7531_setup(struct dsa_switch *ds)
 {
 	struct mt7530_priv *priv = ds->priv;
-	struct mt7530_dummy_poll p;
 	u32 val, id;
 	int ret, i;
 
@@ -2683,9 +2670,8 @@ mt7531_setup(struct dsa_switch *ds)
 	}
 
 	/* Waiting for MT7530 got to stable */
-	INIT_MT7530_DUMMY_POLL(&p, priv, MT753X_TRAP);
-	ret = readx_poll_timeout(mt7530_mii_poll, &p, val, val != 0,
-				 20, 1000000);
+	ret = regmap_read_poll_timeout(priv->regmap, MT753X_TRAP, val,
+				       val != 0, 20, 1000000);
 	if (ret < 0) {
 		dev_err(priv->dev, "reset timeout\n");
 		return ret;
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 5f1e841f42c0..ae93bb263249 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -933,18 +933,6 @@ struct mt7530_hw_stats {
 	u8		sizeof_stat;
 };
 
-struct mt7530_dummy_poll {
-	struct mt7530_priv *priv;
-	u32 reg;
-};
-
-static inline void INIT_MT7530_DUMMY_POLL(struct mt7530_dummy_poll *p,
-					  struct mt7530_priv *priv, u32 reg)
-{
-	p->priv = priv;
-	p->reg = reg;
-}
-
 int mt7530_probe_common(struct mt7530_priv *priv);
 void mt7530_remove_common(struct mt7530_priv *priv);
 
-- 
2.55.0
