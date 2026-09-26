Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615D44A2A7A
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790457521; cv=none; b=hCOyQi43NJrJiO6quPMkFHbGhRymHKllm5Ox6pCPv+5smbr0uvDku9PCya7UYUFVAgE/ktS3In79m+fFXmojsCE2PbYyur2aJBSnCjtE3Xc6Znd0RvJ2b8MR9p5jHHOtDm/GWd99H0ZMpqiytyLcPOgd5RcRZBeRk7iIyUpbfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790457521; c=relaxed/simple;
	bh=mwe2wMHXBASvQY6YTUcQ/+L5dxpaCbYYHMqsyuLfYwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGQrTG2jwwjSQeFcDnpwKXLqkPzkOfE8l0gG1mvms/2CWAgbKZwsi4pVOm0L3wjnyKfQQ9Ahbqu+5D/mp2VG6xopjgtmTybTu5QzcT1g6J0WAm228WdzKg5iUjtshXhUr2zxxlY21dtsUWye12amwtu38aEalBfRNkW8kAkeYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTmPzslo; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTmPzslo"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso1449013a91.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790457518; x=1791062318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZoB8QYSMFwEr8hls6TWpSx7USpe5qzGg15gNV1I4jzI=;
        b=bTmPzsloVIkMnBUzIpJIcOsimzQXNdYwMSF3qje1WLC/rWrUWhkZY2EbgOzarWF3kA
         SVvxyq/dkcTJYZU4AAiEMxGY4LFJtr63UNF+Y9/6kgqZ+Tj/dTTi5Ejp8eUEy+iN0YJD
         v1CrAeykFAHD4r6r/O35XLMpi+up9mR703h4CE3kgsUKw9f4Lbq1cmICuQz8epH3NLNo
         8sfAm01ffd6cuc9I48a9Ek+duKGaqgNYy2mhaU5M6gJmBasH8wpsl3jhc28rURgRXx7W
         k4oDm4VlhprJiser3mN6S/7aAVwqcvtRvO29T6Dc3/fh5b6EXR/+AjWp4EvNuk8fMpt4
         emLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790457518; x=1791062318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZoB8QYSMFwEr8hls6TWpSx7USpe5qzGg15gNV1I4jzI=;
        b=L+iQYwabPuwVg5qTiB9091Z028GPZzX88uCsvZosMIHB5O0Myjy2LdFROsXwMorPtp
         pMGfunIFZ4woUYw84tQa0Vru2rjpkaHLs6MKT1VRPoMGgUh+RFSuPFRzTWdU2+76dUc5
         jVRFEBjPjenDOqrEMf/dUFlG54VzEDZSJsFEE+T6v6BoZIVaXBjAPdtoaZ8+llwIuRAe
         Pgmq4EeKiufh8cB+11qwjTQTrGIKSPHHucHvI8iseAhZiWVH5mIrlEQ1sUolEo5z11Ai
         m3Em99muZduVr3JYd6L76MGdnYj/iWfm47RAdXW8ADwkzdR0dYNJd7Q1Qzv4Io6svq5Y
         zdWQ==
X-Gm-Message-State: AFq9FYL0I5rb/aeJbVq8hALa5yYmLF6Ftz5e8BTTSp9IEgUs7S0dM1Iq
	ioENI4SjSI2JCgmNXsJUr6UN+KNQpE7svUCGHt97HwDB3Z9UVfTnCoJl2wT6Xg==
X-Gm-Gg: AYBFou2YUuVBd5FmI7z32lqIdpQaUyhbd0LPhrhm5EBU3cCFcvVpeDViCJGgvS727SU
	alh/g8m2DWnrnQjOfrv5+iSpj2PRg3J65CN3KTEcmRYDqXZ9eVOGoka2itO+JTd6aaslpbxuxqI
	LOFxndcjBgLmL4qCM5imimTheLtHX1hsXDInRbq0fpZQzowL0GVDMubhEe5J6i9y8/DONx3pxxP
	hAVibxL4wIqTH9NXFQ0ZwyectZJJZhYi9+59nehuvTyTc3MzxjKkwugowU34UycLNJhXHJcZQ12
	83so9feKsJFiMsmWyaxVvekfzzIVg9Sb4r2D5b1jK5HJma5HIycCUL/+DWsWlOUX6kRSLsL0w9a
	TktRi6oG7U+d+gm2JmuuxxkGZcbq6w7IceDy4u+aiKv0DECkheqyLW3akkI9fpgii2/KtPBD/th
	kvDE6+Fcb1DKJA+l5RLYCdppHz3TChEcxxEwIAaGmZokQySEW01huE7gZ1EIPiedZv8aJferoL+
	0uTm6jVszEHEAjMYYCHPrYf
X-Received: by 2002:a17:90b:1350:b0:39e:6c6a:656d with SMTP id 98e67ed59e1d1-3a0bb630128mr4630598a91.48.1790457518515;
        Sat, 26 Sep 2026 14:18:38 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c3f74e5bsm9473204a91.5.2026.09.26.14.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 14:18:37 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/6] net: dsa: motorcomm: Add limited ACL flow statistics support
Date: Sun, 27 Sep 2026 05:17:34 +0800
Message-ID: <20260926211813.935723-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926211813.935723-1-mmyangfl@gmail.com>
References: <20260926211813.935723-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The yt921x supports flow statistics, which might be used to implement
.cls_flower_stats(). However, the number of flow counter are limited,
and you must choose between byte mode or packet mode. As there is no
interface for statistics preference for now, we pick one on our own
initiative.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c |   1 +
 drivers/net/dsa/motorcomm/chip.h |   3 +
 drivers/net/dsa/motorcomm/smi.c  |  33 ++++++++++
 drivers/net/dsa/motorcomm/smi.h  |   2 +
 drivers/net/dsa/motorcomm/tc.c   | 110 +++++++++++++++++++++++++++++--
 drivers/net/dsa/motorcomm/tc.h   |  18 ++++-
 6 files changed, 161 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index be48ecc3e3df..0405f1441f2b 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -2886,6 +2886,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.port_policer_add	= yt921x_dsa_port_policer_add,
 	.port_setup_tc		= yt921x_dsa_port_setup_tc,
 	/* acl */
+	.cls_flower_stats	= yt921x_dsa_cls_flower_stats,
 	.cls_flower_del		= yt921x_dsa_cls_flower_del,
 	.cls_flower_add		= yt921x_dsa_cls_flower_add,
 	/* hsr */
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index c191cec94d59..d7f2b22ae504 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -486,6 +486,8 @@ enum yt921x_fdb_entry_status {
 
 #define YT921X_METER_NUM	64
 
+#define YT921X_FLOWSTAT_NUM	64
+
 #define YT921X_LAG_NUM		2
 #define YT921X_LAG_PORT_NUM	4
 
@@ -641,6 +643,7 @@ struct yt921x_priv {
 	u16 eee_ports_mask;
 
 	DECLARE_BITMAP(meters_map, YT921X_METER_NUM);
+	DECLARE_BITMAP(flowstats_map, YT921X_FLOWSTAT_NUM);
 
 	u8 acl_masks[YT921X_ACL_BLK_NUM];
 	struct yt921x_acl_blk *acl_blks[YT921X_ACL_BLK_NUM];
diff --git a/drivers/net/dsa/motorcomm/smi.c b/drivers/net/dsa/motorcomm/smi.c
index bf3adfd64165..c50d66b2ada7 100644
--- a/drivers/net/dsa/motorcomm/smi.c
+++ b/drivers/net/dsa/motorcomm/smi.c
@@ -63,6 +63,39 @@ int yt921x_reg_update_bits(struct yt921x_priv *priv, u32 reg, u32 mask, u32 val)
 	return yt921x_reg_write(priv, reg, u);
 }
 
+/* Reliably read a 64bit counter */
+int yt921x_counter_read(struct yt921x_priv *priv, u32 reg, u64 *valp)
+{
+	u32 old_lo;
+	int res;
+	u32 hi;
+	u32 lo;
+
+	res = yt921x_reg_read(priv, reg, &old_lo);
+	if (res)
+		return res;
+
+	/* Actually, it is expected finished in two round; anything else is an
+	 * indication of a bug. Still we play safe here.
+	 */
+	for (int i = 0; i < 4; i++) {
+		res = yt921x_reg_read(priv, reg + 4, &hi);
+		if (res)
+			return res;
+		res = yt921x_reg_read(priv, reg, &lo);
+		if (res)
+			return res;
+
+		if (lo >= old_lo) {
+			*valp = ((u64)hi << 32) | lo;
+			return 0;
+		}
+		old_lo = lo;
+	}
+
+	return -ETIMEDOUT;
+}
+
 static int
 yt921x_regs_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
 		 unsigned int num_regs)
diff --git a/drivers/net/dsa/motorcomm/smi.h b/drivers/net/dsa/motorcomm/smi.h
index 212e20f71d80..d34240548af7 100644
--- a/drivers/net/dsa/motorcomm/smi.h
+++ b/drivers/net/dsa/motorcomm/smi.h
@@ -35,6 +35,8 @@ yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
 	return yt921x_reg_update_bits(priv, reg, mask, !set ? 0 : mask);
 }
 
+int yt921x_counter_read(struct yt921x_priv *priv, u32 reg, u64 *valp);
+
 /* Some multi-word registers, like VLANn_CTRL, should be treated as a single
  * long register. More specifically, writes to parts of its words won't become
  * visible, until the last word is written.
diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index d919743d89c1..05d4a5957af9 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -1070,6 +1070,9 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
 	yt921x_acl_rule_set_ports(&ruleext->r, prio, BIT(port));
 	ruleext->r.tag = cls->cookie;
 	ruleext->r.type = TC_SETUP_CLSFLOWER;
+	/* Align with sja1105 */
+	ruleext->r.stat_pkt_mode = true;
+	ruleext->r.laststat = 0;
 	return 0;
 }
 
@@ -1138,6 +1141,45 @@ yt921x_acl_reserve(struct yt921x_priv *priv, unsigned int entscnt,
 	return UINT_MAX;
 }
 
+static int
+yt921x_acl_stat(struct yt921x_priv *priv, enum tc_setup_type type,
+		unsigned long tag, struct flow_stats *stats)
+{
+	struct yt921x_acl_rule *aclrule;
+	const struct yt921x_acl_blk *aclblk;
+	unsigned int statid;
+	unsigned int binid;
+	unsigned int blkid;
+	unsigned int entid;
+	u64 diff;
+	u64 stat;
+	int res;
+
+	entid = yt921x_acl_find(priv, type, tag);
+	if (entid == UINT_MAX)
+		return -ENOENT;
+
+	blkid = entid / YT921X_ACL_ENT_PER_BLK;
+	binid = entid % YT921X_ACL_ENT_PER_BLK;
+	aclblk = priv->acl_blks[blkid];
+	aclrule = aclblk->rules[binid];
+
+	if (!(aclrule->action[0] & YT921X_ACL_ACTa_FLOWSTAT_EN))
+		return -EOPNOTSUPP;
+
+	statid = FIELD_GET(YT921X_ACL_ACTa_FLOWSTAT_ID_M, aclrule->action[0]);
+	res = yt921x_counter_read(priv, YT921X_FLOWSTATn_STAT(statid), &stat);
+	if (res)
+		return res;
+
+	diff = stat - aclrule->laststat;
+	aclrule->laststat = stat;
+	flow_stats_update(stats, aclrule->stat_pkt_mode ? 0 : diff,
+			  !aclrule->stat_pkt_mode ? 0 : diff, 0,
+			  jiffies, FLOW_ACTION_HW_STATS_IMMEDIATE);
+	return 0;
+}
+
 static int
 yt921x_acl_commit(struct yt921x_priv *priv, unsigned int entid, u8 entsmask)
 {
@@ -1270,9 +1312,13 @@ yt921x_acl_del(struct yt921x_priv *priv, enum tc_setup_type type,
 	}
 
 	if (aclrule->action[0] & YT921X_ACL_ACTa_METER_EN)
-		clear_bit(FIELD_GET(YT921X_ACL_ACTa_METER_ID_M,
-				    aclrule->action[0]),
-			  priv->meters_map);
+		__clear_bit(FIELD_GET(YT921X_ACL_ACTa_METER_ID_M,
+				      aclrule->action[0]),
+			    priv->meters_map);
+	if (aclrule->action[0] & YT921X_ACL_ACTa_FLOWSTAT_EN)
+		__clear_bit(FIELD_GET(YT921X_ACL_ACTa_FLOWSTAT_ID_M,
+				      aclrule->action[0]),
+			    priv->flowstats_map);
 	priv->acl_masks[blkid] &= ~aclrule->mask;
 	kvfree(aclrule);
 	if (!priv->acl_masks[blkid]) {
@@ -1290,13 +1336,14 @@ yt921x_acl_add(struct yt921x_priv *priv,
 	unsigned int entscnt = hweight8(ruleext->r.mask);
 	struct yt921x_acl_rule *aclrule;
 	struct yt921x_acl_blk *aclblk;
-	bool use_trap = false;
 	unsigned int meterid;
+	unsigned int statid;
 	unsigned int binid;
 	unsigned int blkid;
 	unsigned int entid;
 	unsigned long m;
 	unsigned int o;
+	bool use_trap;
 	u32 ctrl;
 	int res;
 
@@ -1305,6 +1352,10 @@ yt921x_acl_add(struct yt921x_priv *priv,
 	if (entid == UINT_MAX)
 		return -EOPNOTSUPP;
 
+	use_trap = (ruleext->r.action[2] & YT921X_ACL_ACTc_FWD_EN) &&
+		   (FIELD_GET(YT921X_ACL_ACTc_FWD_M,
+			      ruleext->r.action[2]) == YT921X_ACL_ACTc_FWD_TRAP);
+
 	if (!(ruleext->r.action[0] & YT921X_ACL_ACTa_METER_EN)) {
 		meterid = YT921X_METER_NUM;
 	} else {
@@ -1336,6 +1387,35 @@ yt921x_acl_add(struct yt921x_priv *priv,
 			return res;
 	}
 
+	if (ruleext->r.sw_assisted && use_trap) {
+		statid = YT921X_FLOWSTAT_NUM;
+	} else {
+		statid = find_first_zero_bit(priv->flowstats_map,
+					     YT921X_FLOWSTAT_NUM);
+		if (statid >= YT921X_FLOWSTAT_NUM) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "No more flowstats, HW stats disabled");
+		} else {
+			u32 zeros[2] = {};
+
+			ctrl = YT921X_FLOWSTAT_CTRL_TYPE_FLOW |
+			       YT921X_FLOWSTAT_CTRL_EN;
+			if (ruleext->r.stat_pkt_mode)
+				ctrl |= YT921X_FLOWSTAT_CTRL_PKT_MODE;
+			res = yt921x_reg_write(priv,
+					       YT921X_FLOWSTATn_CTRL(statid),
+					       ctrl);
+			if (res)
+				return res;
+
+			res = yt921x_reg64_write(priv,
+						 YT921X_FLOWSTATn_STAT(statid),
+						 zeros);
+			if (res)
+				return res;
+		}
+	}
+
 	/* Prepare acl block ctrlblk */
 	blkid = entid / YT921X_ACL_ENT_PER_BLK;
 	binid = entid % YT921X_ACL_ENT_PER_BLK;
@@ -1376,6 +1456,9 @@ yt921x_acl_add(struct yt921x_priv *priv,
 		aclrule->action[0] |= YT921X_ACL_ACTa_METER_ID(meterid);
 	else
 		aclrule->action[0] &= ~YT921X_ACL_ACTa_METER_EN;
+	if (statid < YT921X_FLOWSTAT_NUM)
+		aclrule->action[0] |= YT921X_ACL_ACTa_FLOWSTAT_EN |
+				      YT921X_ACL_ACTa_FLOWSTAT_ID(statid);
 
 	/* Write rules */
 	aclblk->rules[binid] = aclrule;
@@ -1391,7 +1474,9 @@ yt921x_acl_add(struct yt921x_priv *priv,
 		priv->ports[o].acl_cnt++;
 
 	if (meterid < YT921X_METER_NUM)
-		set_bit(meterid, priv->meters_map);
+		__set_bit(meterid, priv->meters_map);
+	if (statid < YT921X_FLOWSTAT_NUM)
+		__set_bit(statid, priv->flowstats_map);
 	priv->acl_masks[blkid] |= aclrule->mask;
 	return 0;
 
@@ -1403,6 +1488,21 @@ yt921x_acl_add(struct yt921x_priv *priv,
 	return res;
 }
 
+int
+yt921x_dsa_cls_flower_stats(struct dsa_switch *ds, int port,
+			    struct flow_cls_offload *cls, bool ingress)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_acl_stat(priv, TC_SETUP_CLSFLOWER, cls->cookie,
+			      &cls->stats);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
 int
 yt921x_dsa_cls_flower_del(struct dsa_switch *ds, int port,
 			  struct flow_cls_offload *cls, bool ingress)
diff --git a/drivers/net/dsa/motorcomm/tc.h b/drivers/net/dsa/motorcomm/tc.h
index 0eee2e3808c5..f2ea0ac32f7e 100644
--- a/drivers/net/dsa/motorcomm/tc.h
+++ b/drivers/net/dsa/motorcomm/tc.h
@@ -293,6 +293,16 @@ enum yt921x_l4_type {
 #define  YT921X_METER_CTRLa_EIR_M		GENMASK(17, 0)
 #define   YT921X_METER_CTRLa_EIR(x)			FIELD_PREP(YT921X_METER_CTRLa_EIR_M, (x))
 #define YT921X_METERn_STAT(x)		(0x221000 + 8 * (x))
+#define YT921X_FLOWSTATn_STAT(x)	(0x221400 + 8 * (x))
+#define YT921X_FLOWSTATn_CTRL(x)	(0x221c00 + 4 * (x))
+#define  YT921X_FLOWSTAT_CTRL_EN		BIT(3)
+#define  YT921X_FLOWSTAT_CTRL_PKT_MODE		BIT(2)	/* 0: byte mode */
+#define  YT921X_FLOWSTAT_CTRL_TYPE_M		GENMASK(1, 0)
+#define   YT921X_FLOWSTAT_CTRL_TYPE(x)			FIELD_PREP(YT921X_FLOWSTAT_CTRL_TYPE_M, (x))
+#define   YT921X_FLOWSTAT_CTRL_TYPE_FLOW		YT921X_FLOWSTAT_CTRL_TYPE(0)
+#define   YT921X_FLOWSTAT_CTRL_TYPE_CPU_CODE		YT921X_FLOWSTAT_CTRL_TYPE(1)
+#define   YT921X_FLOWSTAT_CTRL_TYPE_DROP_CODE		YT921X_FLOWSTAT_CTRL_TYPE(2)
+#define   YT921X_FLOWSTAT_CTRL_TYPE_PORT		YT921X_FLOWSTAT_CTRL_TYPE(3)
 
 #define YT921X_MIRROR			0x300300
 #define  YT921X_MIRROR_IGR_PORTS_M		GENMASK(26, 16)
@@ -343,7 +353,10 @@ struct yt921x_acl_rule {
 	enum tc_setup_type type;
 
 	u32 action[3];
-	bool sw_assisted;
+	u64 laststat;
+
+	bool sw_assisted:1;
+	bool stat_pkt_mode:1;
 
 	u8 mask;
 	struct yt921x_acl_entry entries[YT921X_ACL_ENT_PER_BLK];
@@ -365,6 +378,9 @@ int
 yt921x_dsa_port_setup_tc(struct dsa_switch *ds, int port,
 			 enum tc_setup_type type, void *type_data);
 int
+yt921x_dsa_cls_flower_stats(struct dsa_switch *ds, int port,
+			    struct flow_cls_offload *cls, bool ingress);
+int
 yt921x_dsa_cls_flower_del(struct dsa_switch *ds, int port,
 			  struct flow_cls_offload *cls, bool ingress);
 int
-- 
2.53.0

