Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2021AAE28
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 02:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792204305; cv=none; b=iNoA/r1oFbu8KcdN6LcgnINM1TIUk0bBZnMgGhYI4MyVwue0mk4TGEhBb+FydjUcU3ELo0cM/kj3BvqdBwongpnizMuEX7fOpeCpmNSeIR0Dch21OLiDFyy2sHDZvLu8n1GgeyjaGDh6tWi/6NxzYWlFuucu1EohASGfbFz1bXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792204305; c=relaxed/simple;
	bh=r2rgRMSxOCwYCvb2cyG+bi9NBz53dSLQ691q9KtiQVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUUcOZLtUteSXdlVwEywcPke/kQ6/hbL2hHrGkFL5no7C6gwVt1q5chGcq9xGk2D11Jb7msgjF/L4fh7wf3QayB7euYlZSyUm+sX3YhxJfBtmCIZiXMDuAQvoSPtKjnslLaTWivhUVOlQunnIs+hI1bQri3PkezUlwLOHAWqrx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DS6WFQ+X; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS6WFQ+X"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc50ad2d650so364168a12.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 19:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792204303; x=1792809103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qf0+8yxTfLNhsB75ahQTgX/QAqjUGdC45aMQHpNb6bE=;
        b=DS6WFQ+X7WcuAh8Tf4RZE50jqL3v66EzsY95BHHWp7kmOEloH3K0lQEdVwikXqsAwn
         Dja/rshAPNEkEw1L8e1IA6iWHnhTtHHdkhpWaBtn9VSu9Gy5Ze5t7WnxgT8825wVDv+g
         +Tt5QNVDrIbJnHGyqZpTJBgUlmwgI6bVilvQ9//6iHjT/8JG1OammtS1SEdW/VJwv+/j
         OyCrBZGdHbUuhhzHaQ4mEAy6488kVK8GpyG/QTuIXdqM51UZi+wBGR2Fx9WqsZVFHNq5
         Cl6xJB58BpiA3e3PNSfYl90lADER8Kqzpnm/GEuoBJiN/hLroP6doDSyX+5DidIwl0YV
         QQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792204303; x=1792809103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qf0+8yxTfLNhsB75ahQTgX/QAqjUGdC45aMQHpNb6bE=;
        b=0jeAgaQGoPSxAichwkOHKGUA4k2/Uf0phfLOw6ReV81UHL+2sverX+O3MlNFa5qV3h
         46ydZBI3AD7fgT7q3MFwbMHSkCAO2SLG2Mbn46qWj/RLmwLmOb56hRZdVv9HJ/0XrC58
         RIZNbtsBULR6O5IEQNxfih1HlY7+04ySvEAt+ieSKr9pjmtwl6ecWUxjkfwdL0SLwojI
         ZJpzMNGcrozFR9hCSSS6R0ym3bXJniRQnE6k1w54DGAr+kAY6OFXpxgSdg8pRtVTnJT2
         M98Hl8AdNV6JLUxvlcK0Gvu0Bd+ffaKO8yT/9tSELm5qrZK83P/XOnKKt7lDtANrYgFa
         jJQQ==
X-Gm-Message-State: AFq9FYLM/m8kKGlNKCIqqPN4pv/ayC5Jh+mupV6kmy6M6HpGdCgqe94K
	cZPfhpBoYYc+iqGuutggYgB2ahEN/+82cuoezUBhFmXIKWPyeHiWvAfnl7YjWuZmGZ0=
X-Gm-Gg: AYBFou3pmKzVpzaCDVXHV2fhdM/iJ0/Ei/oBCmB2SWNSxiYUEfotXMdUqyAMwwaZ9pN
	53SirAxRsA48gltfCdQ22ORXQ6QsqqojK/hbdRTpb8OdEEJPOKCrvvNw4iSgGxo9di71BExc2Ii
	E1jI4AeQwGOhiDVTntl/Rx3WH6qr90Pcnks6KWvASZ730xbFbX95z3pWHUqyCALGTCR0JpoOQyZ
	kcJzFtXtQS2PJNd1dvhshut0qxMQEr2/vfeIyL+B5yHW1Jc7H55rKB+cvumUixo+d0AE4mpp8pB
	rdxozHlh+h86yvTSuGmviwNfm8UNxE5FDTXqWQ4yVMspMvQ9uyIqZLcKQOmBzYqeMnD9zJeZa5w
	YJNtgsXoos06zQXtA1WGxOtUjbPn7K2vDd78rH0UixyLiSAU8dkYld7JsBKNLrRhcP7TCm0TQ6x
	uNBWBL06h9QRsJ/GXKYxRjPsAP3xhb35fs27IMyxIa9TfQwBZJ7hInNexlIJaf7jkPzSnv36yA9
	d/k5niIro1OwGyEtWvF6EgGwlQ=
X-Received: by 2002:a17:90b:45:b0:3a4:b061:2765 with SMTP id 98e67ed59e1d1-3aceeb9272dmr1441087a91.15.1792204303254;
        Fri, 16 Oct 2026 19:31:43 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661b:1250::1d3:d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd9c4b4eesm4189707a91.2.2026.10.16.19.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 19:31:42 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: motorcomm: Extend ACL with UDF
Date: Sat, 17 Oct 2026 10:31:32 +0800
Message-ID: <20261017023136.2961543-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The native ACL key set cannot express IP TTL or ICMP type/code. Use the
User Defined Filter windows to match them in the tc flower offload.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.h |   2 +-
 drivers/net/dsa/motorcomm/tc.c   | 140 +++++++++++++++++++++++++++++--
 drivers/net/dsa/motorcomm/tc.h   |  12 ++-
 3 files changed, 144 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 7047ad98f431..fc315f1d8f87 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -440,7 +440,7 @@ enum yt921x_fdb_entry_status {
 #define YT921X_TAG_LEN	8
 
 #define YT921X_ACL_BLK_NUM	48
-#define YT921X_UDF_NUM		8
+#define YT921X_UDF_NUM		16
 
 #define YT921X_LED_GROUP_NUM	3
 #define YT921X_LED_PORT_NUM	10
diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 3e0f80500f41..9dbd61e48fee 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -543,6 +543,24 @@ yt921x_acl_rule_set_ports(struct yt921x_acl_rule *aclrule, u16 ord,
 	}
 }
 
+struct yt921x_udf_entry {
+	unsigned char type;
+	unsigned char offset;
+	u8 key;
+	u8 mask;
+};
+
+struct yt921x_udf_map {
+	unsigned char type;
+	unsigned char offset;
+};
+
+/* UDF windows are preselected - that's enough for now. */
+static struct yt921x_udf_map yt921x_udf_maps[] = {
+	{YT921X_UDF_TYPE_L3, 7},
+	{YT921X_UDF_TYPE_L4, 0},
+};
+
 struct yt921x_acl_rule_ext {
 	struct yt921x_acl_rule r;
 
@@ -556,9 +574,13 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 	const struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
 	struct yt921x_acl_entry *entries = ruleext->r.entries;
 	struct netlink_ext_ack *extack = cls->common.extack;
+	struct yt921x_udf_entry udfs[YT921X_UDF_NUM];
 	const struct flow_dissector *dissector;
 	struct yt921x_acl_entry *entry;
+	unsigned int udfs_cnt = 0;
 	unsigned int size = 0;
+	__be16 n_proto = 0;
+	u8 ip_proto = 0;
 	bool use_dport;
 	bool use_sport;
 
@@ -575,7 +597,8 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS_RANGE) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_IP) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_TCP))) {
+	      BIT_ULL(FLOW_DISSECTOR_KEY_TCP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ICMP))) {
 		NL_SET_ERR_MSG_MOD(extack, "Unsupported keys used");
 		return -EOPNOTSUPP;
 	}
@@ -741,7 +764,9 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 		if (match.mask->n_proto) {
 			enum yt921x_l3_type l3type = YT921X_L3_TYPE_OTHER;
 
-			if (match.mask->n_proto == htons(~0))
+			if (match.mask->n_proto == htons(~0)) {
+				n_proto = match.key->n_proto;
+
 				switch (match.key->n_proto) {
 				case htons(ETH_P_IP):
 					l3type = YT921X_L3_TYPE_IPV4;
@@ -762,6 +787,7 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 					l3type = YT921X_L3_TYPE_ERP;
 					break;
 				}
+			}
 
 			if (l3type != YT921X_L3_TYPE_OTHER) {
 				size = yt921x_acl_entries_set_l3_type(entries,
@@ -783,7 +809,9 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 		if (match.mask->ip_proto) {
 			enum yt921x_l4_type l4type = YT921X_L4_TYPE_OTHER;
 
-			if (match.mask->ip_proto == (u8)~0)
+			if (match.mask->ip_proto == (u8)~0) {
+				ip_proto = match.key->ip_proto;
+
 				switch (match.key->ip_proto) {
 				case IPPROTO_TCP:
 					l4type = YT921X_L4_TYPE_TCP;
@@ -801,6 +829,7 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 					l4type = YT921X_L4_TYPE_IGMP;
 					break;
 				}
+			}
 
 			if (l4type != YT921X_L4_TYPE_OTHER) {
 				size = yt921x_acl_entries_set_l4_type(entries,
@@ -852,10 +881,25 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 		struct flow_match_ip match;
 
 		flow_rule_match_ip(rule, &match);
+
 		if (match.mask->ttl) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Matching on TTL not supported");
-			return -EOPNOTSUPP;
+			if (n_proto != htons(ETH_P_IP) &&
+			    n_proto != htons(ETH_P_IPV6)) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Matching on TTL requires protocol ip or ipv6");
+				return -EOPNOTSUPP;
+			}
+
+			if (udfs_cnt >= YT921X_UDF_NUM)
+				goto err;
+
+			udfs[udfs_cnt] = (struct yt921x_udf_entry){
+				.type = YT921X_UDF_TYPE_L3,
+				.offset = n_proto == htons(ETH_P_IP) ? 8 : 7,
+				.key = match.key->ttl,
+				.mask = match.mask->ttl,
+			};
+			udfs_cnt++;
 		}
 
 		if (match.mask->tos) {
@@ -889,6 +933,82 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 		}
 	}
 
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ICMP)) {
+		struct flow_match_icmp match;
+
+		flow_rule_match_icmp(rule, &match);
+
+		if (match.mask->type || match.mask->code) {
+			if (ip_proto != IPPROTO_ICMP &&
+			    ip_proto != IPPROTO_ICMPV6) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Matching on ICMP type/code requires ip_proto icmp or icmpv6");
+				return -EOPNOTSUPP;
+			}
+
+			if (match.mask->type) {
+				if (udfs_cnt >= YT921X_UDF_NUM)
+					goto err;
+
+				udfs[udfs_cnt] = (struct yt921x_udf_entry){
+					.type = YT921X_UDF_TYPE_L4,
+					.offset = 0,
+					.key = match.key->type,
+					.mask = match.mask->type,
+				};
+				udfs_cnt++;
+			}
+
+			if (match.mask->code) {
+				if (udfs_cnt >= YT921X_UDF_NUM)
+					goto err;
+
+				udfs[udfs_cnt] = (struct yt921x_udf_entry){
+					.type = YT921X_UDF_TYPE_L4,
+					.offset = 1,
+					.key = match.key->code,
+					.mask = match.mask->code,
+				};
+				udfs_cnt++;
+			}
+		}
+	}
+
+	/* Compile UDFs */
+	for (unsigned int i = 0; i < udfs_cnt; i++) {
+		unsigned int o;
+		u32 mask;
+		u32 key;
+
+		for (o = 0; o < ARRAY_SIZE(yt921x_udf_maps); o++)
+			if (udfs[i].type == yt921x_udf_maps[o].type &&
+			    (udfs[i].offset == yt921x_udf_maps[o].offset ||
+			     udfs[i].offset == yt921x_udf_maps[o].offset + 1))
+				break;
+
+		if (WARN_ON(o == ARRAY_SIZE(yt921x_udf_maps)))
+			return -EOPNOTSUPP;
+
+		entry = yt921x_acl_entries_find(entries, &size,
+						YT921X_ACL_TYPE_UDF0 + o / 2);
+		if (!entry)
+			goto err;
+
+		key = udfs[i].key;
+		mask = udfs[i].mask;
+		if (udfs[i].offset == yt921x_udf_maps[o].offset) {
+			key <<= 8;
+			mask <<= 8;
+		}
+		if (!(o % 2)) {
+			key <<= 16;
+			mask <<= 16;
+		}
+
+		entry->key[0] |= key;
+		entry->mask[0] |= mask;
+	}
+
 	if (!size) {
 		NL_SET_ERR_MSG_MOD(extack, "Empty rule generated, this should not happen");
 		return -EOPNOTSUPP;
@@ -1579,5 +1699,13 @@ int yt921x_chip_setup_acl(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
+	for (unsigned int o = 0; o < ARRAY_SIZE(yt921x_udf_maps); o++) {
+		ctrl = YT921X_UDF_CTRL_UDF_OFFSET(yt921x_udf_maps[o].offset) |
+		       YT921X_UDF_CTRL_UDF_TYPE(yt921x_udf_maps[o].type);
+		res = yt921x_reg_write(priv, YT921X_UDFn_CTRL(o), ctrl);
+		if (res)
+			return res;
+	}
+
 	return 0;
 }
diff --git a/drivers/net/dsa/motorcomm/tc.h b/drivers/net/dsa/motorcomm/tc.h
index f11136a1c5e2..cc53f148d690 100644
--- a/drivers/net/dsa/motorcomm/tc.h
+++ b/drivers/net/dsa/motorcomm/tc.h
@@ -118,6 +118,9 @@ enum yt921x_acl_type {
 	YT921X_ACL_TYPE_IPV6_SA3,
 	YT921X_ACL_TYPE_MISC,
 	YT921X_ACL_TYPE_L4,
+	/* Each User Defined Filter entry contains 2 UDF windows (UDF_CTRL 2i
+	 * and 2i+1)
+	 */
 	YT921X_ACL_TYPE_UDF0,
 	YT921X_ACL_TYPE_UDF1,
 	YT921X_ACL_TYPE_UDF2,
@@ -255,12 +258,15 @@ enum yt921x_l4_type {
 #define YT921X_UDFn_CTRL(x)		(0x210094 + 4 * (x))
 #define  YT921X_UDF_CTRL_UDF_TYPE_M		GENMASK(8, 7)
 #define   YT921X_UDF_CTRL_UDF_TYPE(x)			FIELD_PREP(YT921X_UDF_CTRL_UDF_TYPE_M, (x))
-#define   YT921X_UDF_CTRL_UDF_TYPE_ETH			YT921X_UDF_CTRL_UDF_TYPE(0)
-#define   YT921X_UDF_CTRL_UDF_TYPE_L3			YT921X_UDF_CTRL_UDF_TYPE(1)
-#define   YT921X_UDF_CTRL_UDF_TYPE_L4			YT921X_UDF_CTRL_UDF_TYPE(2)
 #define  YT921X_UDF_CTRL_UDF_OFFSET_M		GENMASK(6, 0)
 #define   YT921X_UDF_CTRL_UDF_OFFSET(x)			FIELD_PREP(YT921X_UDF_CTRL_UDF_OFFSET_M, (x))
 
+enum yt921x_udf_type {
+	YT921X_UDF_TYPE_L2,
+	YT921X_UDF_TYPE_L3,
+	YT921X_UDF_TYPE_L4,
+};
+
 #define YT921X_PORTn_RATE(port)		(0x220000 + 4 * (port))
 #define  YT921X_PORT_RATE_GAP_VALUE		GENMASK(4, 0)	/* default 20 */
 #define YT921X_METER_SLOT		0x220104
-- 
2.53.0

