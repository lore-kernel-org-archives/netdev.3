Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB51F09A5;
	Sat, 13 Jun 2026 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781313106; cv=none; b=AY/Xsz9MYZGs+o4iDFhcLrHcgQSQKfwxJu0pfQ6WN9lZSMvAiTSczdQQnFTUPTcK5V7lsV0irCsgvNRYtCIhFA+pcipZW0issu7tewcGdP/lg7exlW7FRQ9Q8gU4FSkE7ggJFNCb4Ac+ysX6SToDkmZAzVuXH+Y3Xzfb1Fbd4iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781313106; c=relaxed/simple;
	bh=PXSFaymElcWSmEj5++KPYqi2Sqj3lztzLsMq2OjhCqU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3Cjb5JVj57Yw9nXnJXplDmZ6CvhvJzFhVpBWylu8Ia9OwpQn6SibpORlUiwqbxCeeG96IBMli/jt9oc/9uNonKQn8d++PhW9hUkDVbIC7tZ/yRA1/i0hOQa8KICJfWno5X1FKWMx5cbf7qzyUIk4vSPHloqv7S/l0HPYR+2Wl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wYCuR-000000007Me-3loy;
	Sat, 13 Jun 2026 01:11:40 +0000
Date: Sat, 13 Jun 2026 02:11:36 +0100
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
Subject: [PATCH net-next v2 7/8] net: dsa: mt7530: implement port_fast_age
Message-ID: <e6cdb705f0ec142283071e1966000d3a76f71a16.1781312667.git.daniel@makrotopia.org>
References: <cover.1781312667.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781312667.git.daniel@makrotopia.org>

Implement the .port_fast_age DSA operation by flushing all non-static
(dynamically learned) MAC address entries from the address table.

The switch does not offer a combined "non-static AND per-port" match
mode, so flush all dynamic entries globally. This is consistent with
what other DSA drivers do (b53, realtek) and relearning is fast.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: no changes

 drivers/net/dsa/mt7530.c | 16 ++++++++++++++++
 drivers/net/dsa/mt7530.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index dcf72ab0cd66..c96420c291d5 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -193,6 +193,21 @@ mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
 	return 0;
 }
 
+static void mt7530_port_fast_age(struct dsa_switch *ds, int port)
+{
+	struct mt7530_priv *priv = ds->priv;
+	struct mt7530_dummy_poll p;
+	u32 val;
+
+	/* Flush all non-static MAC address entries */
+	val = ATC_BUSY | ATC_MAT_NON_STATIC_MAC | MT7530_FDB_FLUSH;
+	regmap_write(priv->regmap, MT7530_ATC, val);
+
+	INIT_MT7530_DUMMY_POLL(&p, priv, MT7530_ATC);
+	readx_poll_timeout(mt7530_mii_poll, &p, val,
+			   !(val & ATC_BUSY), 20, 20000);
+}
+
 static void
 mt7530_fdb_read(struct mt7530_priv *priv, struct mt7530_fdb *fdb)
 {
@@ -3319,6 +3334,7 @@ static const struct dsa_switch_ops mt7530_switch_ops = {
 	.port_bridge_flags	= mt7530_port_bridge_flags,
 	.port_bridge_join	= mt7530_port_bridge_join,
 	.port_bridge_leave	= mt7530_port_bridge_leave,
+	.port_fast_age		= mt7530_port_fast_age,
 	.port_fdb_add		= mt7530_port_fdb_add,
 	.port_fdb_del		= mt7530_port_fdb_del,
 	.port_fdb_dump		= mt7530_port_fdb_dump,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index abf19aa69520..decad7a93dbd 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -165,6 +165,7 @@ enum mt753x_to_cpu_fw {
 #define  ATC_MAT_MASK			GENMASK(11, 8)
 #define  ATC_MAT(x)			FIELD_PREP(ATC_MAT_MASK, x)
 #define  ATC_MAT_MACTAB			ATC_MAT(0)
+#define  ATC_MAT_NON_STATIC_MAC	ATC_MAT(4)
 
 enum mt7530_fdb_cmd {
 	MT7530_FDB_READ	= 0,
-- 
2.54.0
