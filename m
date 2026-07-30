Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5023825333F;
	Thu, 30 Jul 2026 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370502; cv=none; b=tRQrZ2jiliHRe3Pb7mO0xOPjrSPC7vlilsR4NpfrY03aCqyKKYAuSOOOFN+V/JYqXIQkNeT+TfBTW2osoO9NlnFJznc6yoSO4MChHBkPxwnK/0UriHDkAMMqqqo604uwg3b47NeuBYUP5h7tM0TdksPTtwmfgH5ocGhxhsoR344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370502; c=relaxed/simple;
	bh=gdIojHk9aA7OJR46q2meOjy6rukyYmCRxhwevMQxrCE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccONf89qRbPJlZyQPqj/xlJN3S5hkgMt1pOzWuTtk/57x7E3GdzIy34ewXW9mdf+4KcQe6Dmbt/Eu/0N69er16raxslo3+OaXZP0keExNE4EpFWXr8t+l1PT08UEow2iXE56QNQRrlUq1pAYpg/V51m0rbZj8np7PpdMwOi9Ueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wpEQJ-000000002fc-1daf;
	Thu, 30 Jul 2026 00:14:55 +0000
Date: Thu, 30 Jul 2026 01:14:52 +0100
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
Subject: [PATCH net v2 3/5] net: dsa: mt7530: error out on failed reads in
 ATC/VTCR command polling
Message-ID: <b3158e751c5e8e3a36cd3bbb6b1c6f4ac9c17afd.1785368701.git.daniel@makrotopia.org>
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

mt7530_fdb_cmd() and mt7530_vlan_cmd() poll the command register
through a helper which returns 0 when the underlying read fails. A
failed bus transaction thus clears ATC_BUSY/VTCR_BUSY and is treated
as successful command completion, and the subsequent ATC_INVALID and
VTCR_INVALID checks are defeated the same way.

Poll using regmap_read_poll_timeout(), which stops on read errors and
propagates them, and use the register value it already read back
instead of re-reading it. Take the MDIO bus lock across the sequence
as the switch regmap is set up with locking disabled.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Fixes: 83163f7dca56 ("net: dsa: mediatek: add VLAN support for MT7530")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2:
 * drop the extra regmap_read() after regmap_read_poll_timeout(); the
   macro already leaves the polled value in val (found by Sashiko AI
   review)
 * print ret in the error messages and stop mislabeling propagated bus
   errors as "reset timeout"/"poll timeout"

 drivers/net/dsa/mt7530.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index f349b54c2d9e..aab26970f39b 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -252,24 +252,26 @@ mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
 {
 	u32 val;
 	int ret;
-	struct mt7530_dummy_poll p;
 
 	/* Set the command operating upon the MAC address entries */
 	val = ATC_BUSY | ATC_MAT(0) | cmd;
 	mt7530_write(priv, MT7530_ATC, val);
 
-	INIT_MT7530_DUMMY_POLL(&p, priv, MT7530_ATC);
-	ret = readx_poll_timeout(_mt7530_read, &p, val,
-				 !(val & ATC_BUSY), 20, 20000);
+	mt7530_mutex_lock(priv);
+
+	ret = regmap_read_poll_timeout(priv->regmap, MT7530_ATC, val,
+				       !(val & ATC_BUSY), 20, 20000);
+
+	mt7530_mutex_unlock(priv);
+
 	if (ret < 0) {
-		dev_err(priv->dev, "reset timeout\n");
+		dev_err(priv->dev, "ATC poll failed: %d\n", ret);
 		return ret;
 	}
 
 	/* Additional sanity for read command if the specified
 	 * entry is invalid
 	 */
-	val = mt7530_read(priv, MT7530_ATC);
 	if ((cmd == MT7530_FDB_READ) && (val & ATC_INVALID))
 		return -EINVAL;
 
@@ -1630,22 +1632,24 @@ mt7530_port_bridge_join(struct dsa_switch *ds, int port,
 static int
 mt7530_vlan_cmd(struct mt7530_priv *priv, enum mt7530_vlan_cmd cmd, u16 vid)
 {
-	struct mt7530_dummy_poll p;
 	u32 val;
 	int ret;
 
 	val = VTCR_BUSY | VTCR_FUNC(cmd) | vid;
 	mt7530_write(priv, MT7530_VTCR, val);
 
-	INIT_MT7530_DUMMY_POLL(&p, priv, MT7530_VTCR);
-	ret = readx_poll_timeout(_mt7530_read, &p, val,
-				 !(val & VTCR_BUSY), 20, 20000);
+	mt7530_mutex_lock(priv);
+
+	ret = regmap_read_poll_timeout(priv->regmap, MT7530_VTCR, val,
+				       !(val & VTCR_BUSY), 20, 20000);
+
+	mt7530_mutex_unlock(priv);
+
 	if (ret < 0) {
-		dev_err(priv->dev, "poll timeout\n");
+		dev_err(priv->dev, "VTCR poll failed: %d\n", ret);
 		return ret;
 	}
 
-	val = mt7530_read(priv, MT7530_VTCR);
 	if (val & VTCR_INVALID) {
 		dev_err(priv->dev, "read VTCR invalid\n");
 		return -EINVAL;
-- 
2.55.0
