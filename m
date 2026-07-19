Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C09E3AEF3E;
	Sun, 19 Jul 2026 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784483659; cv=none; b=QtghoFyMPuVth7QPjBfOoyQv7WGkM9S3E3W/kn+LMfIREzGxsVHal2Xq/6h/Z914QSiabukjz4yhYFRqsZcE884cHdxOLizcFtOKhVVrNPPuT6zSb9zkwh1ISxM6QaeQHAsK4g6zt8IwmtKHiP414qakrH1Lz2fPUZVSPFZBjpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784483659; c=relaxed/simple;
	bh=qAXuoxppnwgZjx/dLmpT/zRN8BRzJGKWNSyM6QItJKE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HB0QvwMwgOZ1nvaOWVJzXht32VSUT0HGWl7oP8jnusvsQvWr7cgD4mN6mhYrcv2dLUJWA9D4UaMJ45D6MUnGcS2KzBOAvYX8WEdP17oh6+YyC1w4Y/7+BpsZjVc1aEZDqKPuMnAvTxoaqTMekk2uMTTUxARHc2LbIn3F0W5gsnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wlViO-000000004rM-2rDC;
	Sun, 19 Jul 2026 17:54:12 +0000
Date: Sun, 19 Jul 2026 18:54:09 +0100
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
Subject: [PATCH net-next v4 7/8] net: dsa: mt7530: implement port_fast_age
Message-ID: <4bcaca9dd85905630ba7393d6e4073c7e10a9500.1784481922.git.daniel@makrotopia.org>
References: <cover.1784481922.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784481922.git.daniel@makrotopia.org>

Implement the .port_fast_age DSA operation by flushing all non-static
(dynamically learned) MAC address entries from the address table.

The switch does not offer a combined "non-static AND per-port" match
mode, so the flush is global and the port argument is not used. Unlike
b53 and realtek, which flush the dynamic entries of the affected port
only, an STP topology change on one port therefore also flushes the
dynamically learned entries of the other ports; they are quickly
relearned.

Access the address table control register under priv->reg_mutex, as done
by all other ATC users (FDB and MDB add/del/dump), to serialise the
write-then-poll command sequence, and log a message should the flush
time out.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>

---
v3:
 * take reg_mutex around the ATC flush and log on timeout
 * align the ATC_MAT_NON_STATIC_MAC define
 * correct the commit message which wrongly claimed per-port parity
   with b53/realtek
---
 drivers/net/dsa/mt7530.c | 23 +++++++++++++++++++++++
 drivers/net/dsa/mt7530.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index f7643b86f3c4..52b549d7ee22 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -193,6 +193,28 @@ mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
 	return 0;
 }
 
+static void mt7530_port_fast_age(struct dsa_switch *ds, int port)
+{
+	struct mt7530_priv *priv = ds->priv;
+	struct mt7530_dummy_poll p;
+	u32 val;
+	int ret;
+
+	mutex_lock(&priv->reg_mutex);
+
+	/* Flush all non-static MAC address entries */
+	val = ATC_BUSY | ATC_MAT_NON_STATIC_MAC | MT7530_FDB_FLUSH;
+	regmap_write(priv->regmap, MT7530_ATC, val);
+
+	INIT_MT7530_DUMMY_POLL(&p, priv, MT7530_ATC);
+	ret = readx_poll_timeout(mt7530_mii_poll, &p, val,
+				 !(val & ATC_BUSY), 20, 20000);
+	if (ret < 0)
+		dev_err(priv->dev, "fast age timeout\n");
+
+	mutex_unlock(&priv->reg_mutex);
+}
+
 static void
 mt7530_fdb_read(struct mt7530_priv *priv, struct mt7530_fdb *fdb)
 {
@@ -3319,6 +3341,7 @@ static const struct dsa_switch_ops mt7530_switch_ops = {
 	.port_bridge_flags	= mt7530_port_bridge_flags,
 	.port_bridge_join	= mt7530_port_bridge_join,
 	.port_bridge_leave	= mt7530_port_bridge_leave,
+	.port_fast_age		= mt7530_port_fast_age,
 	.port_fdb_add		= mt7530_port_fdb_add,
 	.port_fdb_del		= mt7530_port_fdb_del,
 	.port_fdb_dump		= mt7530_port_fdb_dump,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 804c2e0991a0..241e3d460357 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -165,6 +165,7 @@ enum mt753x_to_cpu_fw {
 #define  ATC_MAT_MASK			GENMASK(11, 8)
 #define  ATC_MAT(x)			FIELD_PREP(ATC_MAT_MASK, x)
 #define  ATC_MAT_MACTAB			ATC_MAT(0)
+#define  ATC_MAT_NON_STATIC_MAC		ATC_MAT(4)
 
 enum mt7530_fdb_cmd {
 	MT7530_FDB_READ	= 0,
-- 
2.55.0
