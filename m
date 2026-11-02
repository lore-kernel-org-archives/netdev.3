Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635130;
	b=bPo6JzWCwYaSaFR3VUTTzdU9f4l5h2UIZPIEWM8V6e0Jyxf+a8Sf1jP5nmg6xaF0zD5v
	 MPpX9LviBX016tcDC1K//Kv5yGtVZkw4UFt1L+DMU6I5hZvw07HbUyc36NZHTl9W3CDVF
	 P4MCA2SVCiNiNkYiOqKMACEAXZmhVku3PguGLkk6Drt8rJCK1Oh1PzaIHC8FPg+sjcrdE
	 02xN9WlvLA/jsCL91gkNba4nhvgFZEP7ewvLrL7BXWGj/vrrjtPqQhHIrKHuQQ8Q6VJNn
	 bz1dao+8tdnkx3BQkJTNb8dLO6FpGVT1mm/aLkyUPHUq6uGCGeSYeAtiM83eLCD3pTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ldogGG0L2r7e8E8bTIXHYR/XI5wbEyYJRYKnBDo3pKE=;
	b=SzXyseooJO8HdZHlK5bcnLditPZgENC0LRidYTVQWjmv2XDfhbFcGACunE9Q9fQ7dwLg
	 1GVxi8Cy+c18efn/MDfrHiTVi861UnUabJdicq6GD4c3oBeKNWCNW5ooF3aGZAGsmxgVX
	 Gj1QJ+U5eo7LzxYF2Kap+JGXFokdDQ3/6OoEbKcvXatigVapE0CGrn1fWpvJ3D6CT7WnF
	 W5Li7YLr9J/zxzJn/6H42hJdfZsNo3PBGJd+xyrCsTChczRcCjPdzpKoG3h71TGKYqBGa
	 Y9KUfVgNn+uDHWP4V2fOnaoBWaSJ6pJzrBk3DR0lYajVll1scer0h2twPQYqA+iDmtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ml45T0Ke;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491BA60BA926
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 491BA60BA926
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ml45T0Ke
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso2571119a91.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793635130; x=1794239930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ldogGG0L2r7e8E8bTIXHYR/XI5wbEyYJRYKnBDo3pKE=;
        b=Ml45T0Kefu+066yyNasDniLIxiqDfek1/nxcxm2q4L8QhwL8FMzgRM4zwKURFL1s0U
         D7sIQug4/Xj6vti6htj+d0lh1m6/98EPuZKYKWpaB47T4xkiKvC9DCQe56feqJOnneLg
         IyRzUV5V4TRKHS//oFpIdqrBkOYaqMTYPbJgb7mJObAb7UaeYkG+gRFj2VzJQAgxzcdq
         sl8TI1LgJcQi75sTCD8JvU5Myy/UHpGW8QJ3No936ysg6u94tOf/MeXQ8KvcIHOFEqhC
         HH5e8eWcMd1zxEUrf5BJE1u2AKqGnGRIPx98wxW49LES+s39CSRhv6P3RyTaW0yv+9x4
         WbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635130; x=1794239930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ldogGG0L2r7e8E8bTIXHYR/XI5wbEyYJRYKnBDo3pKE=;
        b=siArTmRrGMd17Er+Z8Ov8d5UV1zYqyVCtvGInPiJQWmcLo+HdjJTxYaHWif062S9ni
         pBqvHgyEXw1dYcXMM6iPyolpfczNkGWHCqq+AMUKqXcC8h2QNHucrMTP2S4yPpCsIqzk
         55bzWWql22NFQKqSwFdb7rQRNpne3Kw77juM0UkraqLmrqtDPQuua+qBLvb294906zCK
         RMjJgNzIDyOZ1WMgTwseXGgCmt6an1SalmHvwcWpnrymEnTd2pySbM25U+/Az7Muc9TP
         JrVPVTFO7WQ+f0XcLQGMms1rWwTUJwBpKlp/XCQ+6Y44P7jBJj8Z7Qo9Fhc+kOPWcqb+
         JjBQ==
X-Gm-Message-State: APuU4Z9uoZzrSR44xzw5VgbILavjmNk6K320nww40W5UeLC2A+Uxfs7y
	ZCgeV/Jb+XvCRLQsiStC4OcfI2x29cTlOMbzBuTrYNQexx9f+qJPikfBsxFgFQ==
X-Gm-Gg: AYBFou0jLvXsd2QIKpnV76MXsXSb1ZOWNKJ1OpeDZJToPoGWZMjvEa4j8Tw8gNmln6e
	JxBqAUwD59eFbsEnvlnyGiWHqmeG9HikGRwmuNyZvkF654ED2IhLjEibDhIu3IuWMpem5xQ7OUW
	SRCdepuVcyEHWwzDoc03fnogj5xkcRV8/n6MQ6UHPQhcBpeZk/33CYYV5tPQZYGc+Ss8GdZEDXM
	cjG5JBKqcz5nH6HQkRBk/3QfxSpY39+MBZxW9mw5aE9XQuZ5qO+qJ5+1AVjyFBQ3xx16qrduQS4
	/ymH6QM5BvbYFaZ+AVOhJd/ceNkkeq8UVBlkOMLYvPuGF6RS4ZrSdDVwBA3N4TFCxpzGUB3hecw
	TGZ1dmzCIzxMsugSY4ZLGaiYmD9nbC+HmOUfludo3QOQft8254eFLcEL5SVr4va2bdu17YrWVKq
	7lEOk8blXmyKOaITclQFedF3ZNLTytj7hlZOZJluetLwcmnvBiMS9L5kkLaPEZ1TKo+uwykIkhw
	7Cf/pds0loXd11S83fYRJ0AiOdxAsWBT6ZiujscoxyQ7KCarpvwYGFzOrDjM72D8dp9+NHFiu4C
	HFUGbtdc0NLxtXw1zIx3qxw1PGYWud4C4jRgOGD+iqwAj+o9klnG
X-Received: by 2002:a17:90b:2f0f:b0:3a7:9ec3:ea0e with SMTP id 98e67ed59e1d1-3ae8974a292mr6451704a91.22.1793635129672;
        Mon, 02 Nov 2026 07:58:49 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d429fsm19183949a91.2.2026.11.02.07.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:58:49 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/6] net: dsa: motorcomm: Add BR_PORT_LOCKED and BR_PORT_MAB support
Date: Mon,  2 Nov 2026 23:56:38 +0800
Message-ID: <20261102155641.3682626-7-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102155641.3682626-1-mmyangfl@gmail.com>
References: <20261102155641.3682626-1-mmyangfl@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Program the per-port learn register to implement BR_PORT_LOCKED and
BR_PORT_MAB offload.

Learn-suspended FDB entries (status pending) created by locked ports
are never aged by the hardware. Add a delayed work to remove all pending
entries if any locked port exists.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 161 ++++++++++++++++++++++++++++---
 drivers/net/dsa/motorcomm/chip.h |   9 ++
 2 files changed, 158 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 447736854870..43e001da634e 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -822,6 +822,109 @@ yt921x_fdb_join(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
 	return yt921x_fdb_add_index_in12(priv, index, ctrl1, ctrl2);
 }
 
+/* Learn-suspended entries are never aged by the hardware, clean them up before
+ * the FDB fills up.
+ */
+static int yt921x_fdb_clean(struct yt921x_priv *priv)
+{
+	u8 status;
+	u16 index;
+	u32 ctrl;
+	u32 val;
+	int res;
+
+	ctrl = YT921X_FDB_OP_INDEX(0) | YT921X_FDB_OP_MODE_INDEX |
+	       YT921X_FDB_OP_OP_GET_ONE | YT921X_FDB_OP_START;
+	res = yt921x_reg_write(priv, YT921X_FDB_OP, ctrl);
+	if (res)
+		return res;
+
+	res = yt921x_fdb_wait(priv, &val);
+	if (res)
+		return res;
+
+	status = YT921X_FDB_ENTRY_STATUS_INVALID;
+	if (!(val & YT921X_FDB_RESULT_NOTFOUND)) {
+		res = yt921x_reg_read(priv, YT921X_FDB_OUT1, &val);
+		if (res)
+			return res;
+		status = FIELD_GET(YT921X_FDB_IO1_STATUS_M, val);
+	}
+
+	index = 0;
+	while (1) {
+		if (status == YT921X_FDB_ENTRY_STATUS_PENDING) {
+			ctrl = YT921X_FDB_OP_INDEX(index) |
+			       YT921X_FDB_OP_MODE_INDEX | YT921X_FDB_OP_OP_DEL |
+			       YT921X_FDB_OP_START;
+			res = yt921x_reg_write(priv, YT921X_FDB_OP, ctrl);
+			if (res)
+				return res;
+
+			res = yt921x_fdb_wait(priv, &val);
+			if (res)
+				return res;
+		}
+
+		/* Never call GET_NEXT with 4095, otherwise it will hang
+		 * forever until a reset!
+		 */
+		if (index >= YT921X_FDB_NUM - 1)
+			break;
+
+		ctrl = YT921X_FDB_OP_INDEX(index) | YT921X_FDB_OP_MODE_INDEX |
+		       YT921X_FDB_OP_NEXT_TYPE_UCAST |
+		       YT921X_FDB_OP_OP_GET_NEXT | YT921X_FDB_OP_START;
+		res = yt921x_reg_write(priv, YT921X_FDB_OP, ctrl);
+		if (res)
+			return res;
+
+		res = yt921x_fdb_wait(priv, &val);
+		if (res)
+			return res;
+		if (val & YT921X_FDB_RESULT_NOTFOUND)
+			break;
+		index = FIELD_GET(YT921X_FDB_RESULT_INDEX_M, val);
+
+		res = yt921x_reg_read(priv, YT921X_FDB_OUT1, &val);
+		if (res)
+			return res;
+		status = FIELD_GET(YT921X_FDB_IO1_STATUS_M, val);
+		if (status == YT921X_FDB_ENTRY_STATUS_INVALID)
+			break;
+	}
+
+	return 0;
+}
+
+static void yt921x_fdb_clean_work(struct work_struct *work)
+{
+	struct yt921x_priv *priv = container_of_const(work, struct yt921x_priv,
+						      fdb_clean.work);
+	struct device *dev = to_device(priv);
+	bool has_locked = false;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+
+	res = yt921x_fdb_clean(priv);
+
+	for (int port = 0; port < YT921X_PORT_NUM; port++)
+		if (priv->ports[port].locked) {
+			has_locked = true;
+			break;
+		}
+
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		dev_err(dev, "Failed to clean pending FDB entries: %i\n", res);
+
+	if (has_locked)
+		schedule_delayed_work(&priv->fdb_clean,
+				      priv->fdb_clean_interval);
+}
+
 static int
 yt921x_dsa_port_fdb_dump(struct dsa_switch *ds, int port,
 			 dsa_fdb_dump_cb_t *cb, void *data)
@@ -1412,6 +1515,30 @@ static int yt921x_bridge_join(struct yt921x_priv *priv, int port)
 	return 0;
 }
 
+static int yt921x_port_learn_cfg(struct yt921x_priv *priv, int port)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+	u32 ctrl;
+	u32 mask;
+
+	mask = YT921X_PORT_LEARN_MODE_M | YT921X_PORT_LEARN_DIS |
+	       YT921X_PORT_LEARN_SUSPEND_DROP_EN |
+	       YT921X_PORT_LEARN_SUSPEND_COPY_EN;
+	if (pp->locked) {
+		ctrl = YT921X_PORT_LEARN_MODE_CPU_CONTROL;
+		if (pp->mab)
+			ctrl |= YT921X_PORT_LEARN_SUSPEND_COPY_EN;
+		else
+			ctrl |= YT921X_PORT_LEARN_SUSPEND_DROP_EN;
+	} else if (pp->learning) {
+		ctrl = 0;
+	} else {
+		ctrl = YT921X_PORT_LEARN_DIS;
+	}
+	return yt921x_reg_update_bits(priv, YT921X_PORTn_LEARN(port), mask,
+				      ctrl);
+}
+
 static int
 yt921x_bridge_flags(struct yt921x_priv *priv, int port,
 		    struct switchdev_brport_flags flags)
@@ -1420,17 +1547,23 @@ yt921x_bridge_flags(struct yt921x_priv *priv, int port,
 	bool change_isolated;
 	bool change_flood;
 	u32 ports_mask;
-	u32 mask;
 	int res;
 
-	if (flags.mask & BR_LEARNING) {
-		bool learning = flags.val & BR_LEARNING;
+	if (flags.mask & (BR_LEARNING | BR_PORT_LOCKED | BR_PORT_MAB)) {
+		if (flags.mask & BR_LEARNING)
+			pp->learning = flags.val & BR_LEARNING;
+		if (flags.mask & BR_PORT_LOCKED)
+			pp->locked = flags.val & BR_PORT_LOCKED;
+		if (flags.mask & BR_PORT_MAB)
+			pp->mab = flags.val & BR_PORT_MAB;
 
-		mask = YT921X_PORT_LEARN_DIS;
-		res = yt921x_reg_toggle_bits(priv, YT921X_PORTn_LEARN(port),
-					     mask, !learning);
+		res = yt921x_port_learn_cfg(priv, port);
 		if (res)
 			return res;
+
+		if ((flags.mask & BR_PORT_LOCKED) && pp->locked)
+			schedule_delayed_work(&priv->fdb_clean,
+					      priv->fdb_clean_interval);
 	}
 
 	/* BR_BCAST_FLOOD: we can filter bcast, but cannot trap them */
@@ -1482,7 +1615,8 @@ yt921x_dsa_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 				 struct netlink_ext_ack *extack)
 {
 	if (flags.mask & ~(BR_HAIRPIN_MODE | BR_LEARNING | BR_FLOOD |
-			   BR_MCAST_FLOOD | BR_ISOLATED))
+			   BR_MCAST_FLOOD | BR_ISOLATED | BR_PORT_LOCKED |
+			   BR_PORT_MAB))
 		return -EINVAL;
 	return 0;
 }
@@ -1610,6 +1744,7 @@ yt921x_dsa_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct device *dev = yt921x_priv_to_device(priv);
 	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct yt921x_port *pp = &priv->ports[port];
 	bool learning;
 	u32 mask;
 	u32 ctrl;
@@ -1644,10 +1779,8 @@ yt921x_dsa_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 		if (res)
 			break;
 
-		mask = YT921X_PORT_LEARN_DIS;
-		ctrl = !learning ? YT921X_PORT_LEARN_DIS : 0;
-		res = yt921x_reg_update_bits(priv, YT921X_PORTn_LEARN(port),
-					     mask, ctrl);
+		pp->learning = learning;
+		res = yt921x_port_learn_cfg(priv, port);
 	} while (0);
 	mutex_unlock(&priv->reg_lock);
 
@@ -2242,9 +2375,11 @@ static int yt921x_edata_read(struct yt921x_priv *priv, u8 addr, u8 *valp)
 
 static void yt921x_dsa_teardown(struct dsa_switch *ds)
 {
-#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 
+	cancel_delayed_work_sync(&priv->fdb_clean);
+
+#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
 	yt921x_leds_remove(priv);
 #endif
 }
@@ -2723,6 +2858,8 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 	mdio->switchid = 0;
 
 	mutex_init(&priv->reg_lock);
+	INIT_DELAYED_WORK(&priv->fdb_clean, yt921x_fdb_clean_work);
+	priv->fdb_clean_interval = 61 * HZ;
 
 	priv->reg_ops = &yt921x_reg_ops_mdio;
 	priv->reg_ctx = mdio;
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 842fd8f83903..81d2e75fe207 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -465,6 +465,12 @@ struct yt921x_port {
 	bool flood:1;
 	/* BR_MCAST_FLOOD */
 	bool mcast_flood:1;
+	/* BR_PORT_LOCKED */
+	bool locked:1;
+	/* BR_PORT_MAB */
+	bool mab:1;
+	/* BR_LEARNING */
+	bool learning:1;
 
 	unsigned short acl_cnt;
 
@@ -526,6 +532,9 @@ struct yt921x_priv {
 	struct mii_bus *mbus_int;
 	struct mii_bus *mbus_ext;
 
+	struct delayed_work fdb_clean;
+	unsigned int fdb_clean_interval;
+
 	struct yt921x_port ports[YT921X_PORT_NUM];
 
 	u16 eee_ports_mask;
-- 
2.53.0

