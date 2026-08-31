Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D0471402;
	Mon, 31 Aug 2026 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190763; cv=none; b=IoTdJdb4c2mVLOrKTPND1cdUfOO/Cl3NBQNpVlO/4AOFJmitdLidgjqb9xuLvhBVLke1pUsJ+GfLHmL0ppm0xe/8NCI2N3Gqwv1QQePZuvvRAjldZGkfSdpmPxCPJriaXZLXUE0vQEwUCaqI3eC9i9lop9dLyPei+cRaeKLg/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190763; c=relaxed/simple;
	bh=77160b1NKDDcIuV0gULE/FmnwELWE51bTnvgVU5WUKw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDQrGJn9FX14aLZl8sOWVtTSNwCGf2CCFCofugP6yXI1TGah7etAFARr8jySdMMj6L7O+ksjnrOrx9DqWYg6tj3L8TEtXU6o3FeeroTsKfVwZECUXiJ/aRNdmQyghTi58czVgMRBv/SjOZqSa28sA+kvJJtPpsfpPu0aocpxi/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1x146O-000000007DC-1v6P;
	Mon, 31 Aug 2026 15:39:16 +0000
Date: Mon, 31 Aug 2026 16:39:13 +0100
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
Subject: [PATCH net-next v5 8/9] net: dsa: mt7530: implement port_fast_age
Message-ID: <60f83ade0e371dfe2d974d5d192056935c3ab5c9.1788190568.git.daniel@makrotopia.org>
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
write-then-poll command sequence, and log a message should the command
fail.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v5:
 * poll via regmap_read_poll_timeout()
 * check the ATC command write like the other command sequences do,
   and report the error code
v3:
 * take reg_mutex around the ATC flush and log on timeout
 * align the ATC_MAT_NON_STATIC_MAC define
 * correct the commit message which wrongly claimed per-port parity
   with b53/realtek
v2: no changes
---
 drivers/net/dsa/mt7530.c | 21 +++++++++++++++++++++
 drivers/net/dsa/mt7530.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 4edb57676143..84e0e888f2d0 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -188,6 +188,26 @@ mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
 	return 0;
 }
 
+static void mt7530_port_fast_age(struct dsa_switch *ds, int port)
+{
+	struct mt7530_priv *priv = ds->priv;
+	u32 val;
+	int ret;
+
+	mutex_lock(&priv->reg_mutex);
+
+	/* Flush all non-static MAC address entries */
+	val = ATC_BUSY | ATC_MAT_NON_STATIC_MAC | MT7530_FDB_FLUSH;
+	ret = regmap_write(priv->regmap, MT7530_ATC, val);
+	if (!ret)
+		ret = regmap_read_poll_timeout(priv->regmap, MT7530_ATC, val,
+					       !(val & ATC_BUSY), 20, 20000);
+	if (ret < 0)
+		dev_err(priv->dev, "fast age failed: %d\n", ret);
+
+	mutex_unlock(&priv->reg_mutex);
+}
+
 static void
 mt7530_fdb_read(struct mt7530_priv *priv, struct mt7530_fdb *fdb)
 {
@@ -3358,6 +3378,7 @@ static const struct dsa_switch_ops mt7530_switch_ops = {
 	.port_bridge_flags	= mt7530_port_bridge_flags,
 	.port_bridge_join	= mt7530_port_bridge_join,
 	.port_bridge_leave	= mt7530_port_bridge_leave,
+	.port_fast_age		= mt7530_port_fast_age,
 	.port_fdb_add		= mt7530_port_fdb_add,
 	.port_fdb_del		= mt7530_port_fdb_del,
 	.port_fdb_dump		= mt7530_port_fdb_dump,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 6a148938c60f..2bbbe617b52e 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -166,6 +166,7 @@ enum mt753x_to_cpu_fw {
 #define  ATC_MAT_MASK			GENMASK(11, 8)
 #define  ATC_MAT(x)			FIELD_PREP(ATC_MAT_MASK, x)
 #define  ATC_MAT_MACTAB			ATC_MAT(0)
+#define  ATC_MAT_NON_STATIC_MAC		ATC_MAT(4)
 
 enum mt7530_fdb_cmd {
 	MT7530_FDB_READ	= 0,
-- 
2.55.0
