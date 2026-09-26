Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CF3A168B
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790457518; cv=none; b=EmwCxJlAmumCYGyc2ZKzX2/uuuJ8KEUmNhbvWOULilHCUZi2/KwPADjqZy7U3H9+mZdgfbYFO7CbrVrbD8Yfi5NVV+aYIoADkuFRZK8ZRaaC5GJ07fkxQqYc3fh9zoTbRM2a7JvQQbSCA9CdPG6MvvIY4gZI8FYCs9FwVJR+WGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790457518; c=relaxed/simple;
	bh=Accgco2mkZAx5P1tgNhGPvKyOEsEYm8tEufNPqr1RIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPOEAzbRYmCWCOD9Y+7xlYelk3h4gh/ZE36BjyglCGjJX6oDjqj/cdnjcK3lHaFZGdhGxTBGNxhecv2ebxk/TEKMbVaCAVJ/L1jz3Gb1zgwIRO0XX9VLQNDdASkzdTnxKmK1Gt18c3ZSzb0uC7VVTa8//70dDpJUDKW9CeirGFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/8/Iw5b; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/8/Iw5b"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso1449005a91.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 14:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790457515; x=1791062315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d8bpMCx4GRvINtrgXlvafjDKO/FNbBLvzSwE2nIsKuw=;
        b=p/8/Iw5bpswP+HZvxFLGeyNZbqvPfO0/ZIgt4AYNsgleFcR+759a2fUob/JY2HGUU3
         LCGvbWT3HkMKdwVcbrUItDfoNUl1TQMfanKjlmbj+RggxDtFaMQtCJEZl1VM18jKohxr
         /u/35+L8W/eBdwI1mTJSmctBuRz7VaCeJT8ay02ugxEj5XFDgWzAOCi8knAvgPHPMDuy
         15RT7+AeVK6TZD07W5NNoQPDTHsMAzJiP2piRD8j41kzTTnEkarRra9zJl8TZ/RryEDF
         l+CNoI2+E1IC+AQd6dulB3UqnCuyXb/g1Nmw1E36TRdr3Q7++e05GqioBoV+5Omstt8d
         EMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790457515; x=1791062315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d8bpMCx4GRvINtrgXlvafjDKO/FNbBLvzSwE2nIsKuw=;
        b=hyz8Z9AvPbDuxmpxqs8uCj/Bk5og/fj7hq52gLZu6ett6W2OTGsZ0uxLR/gta6U55/
         4qepJteyhoVJiT45fTuhFduLpcRF/8zeF4OCdYKYaEfyP8WQ4rKH2AuqFhJbBPsHMzm5
         6TkZuYFbJ6ZCWJTtjwl/mt6AGGwaL4i4Rx5QBesjFqMu7UxGlHOZO3Y4yYJzpN47MWxz
         H87XQ4HmghzYaJCozanExH6B6yuVps7WJOqQfItjOlP0xtRaHES9qdyOxsmrpktBjozu
         nFT1EisY7bgtRYKcWjf3vkrHgWAkmiq+JMW7nbFS4zSFCz8QPQczUqRCdN3SOiSegiTk
         yLIA==
X-Gm-Message-State: AFq9FYIcBRbaTgA1gzQgjtU2FpqWzxRemny/nRjJDCYi9FNFF2l+jfaw
	XGWCj2Q8RIp72WaTcUl8ifsBvPHikb9/GfL1e+cbxZEIBd4B/X6MtHapH+OwIA==
X-Gm-Gg: AYBFou16rEs0GGTqbMoI+vVX2DkwisBgUtftWRANNpseKRuEpPmzGaHsZa/WUvizi2y
	ZB18TvQ4Iy0yNJor30ytwh4IlhMEoqrKGvfmt5PmMFyPgtph1U3nI09L+XTtybrrVbiO2Ml7B/T
	aw3aw6CI7fw8EzbHIpxs/pWxfO9NHReokWxP2IPdVKkpIRYysSEMhXlliYBpb4Z/En1vYDNxqLy
	7WETp4h5FnFz1KUR705d5q0y7VqWHE5PhERGPX08nT/tGdu7NuHzLEyRH4LRvc1i9crXfqbcrxc
	btsl9qKt3fuTwi9jEdhe5DTlN05YRi6qtjf+ClgXRbN1aD27Bo3fCm6rrOZxeSx5MfGah9PADpc
	lZjLdsQBwvxlmCOImDqZYBr7EYYItJ9mXlUma4T/+qJBb/eecddCjUN5mkNsSFD+dNahNjTLg+q
	urBNEzNUi0tM1mfih22bnZKWx95d+0W0+EtPRyHIbK8UwTLamMTxmGWVhPhMLUMnIDbs9YKgBeZ
	3yu0wsIvP3llNh9lznkjplPikJRC8TRT24=
X-Received: by 2002:a17:90b:384c:b0:39e:5acb:2849 with SMTP id 98e67ed59e1d1-3a0bb576e5cmr5272843a91.17.1790457515431;
        Sat, 26 Sep 2026 14:18:35 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c3f74e5bsm9473204a91.5.2026.09.26.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 14:18:35 -0700 (PDT)
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
Subject: [PATCH net-next 4/6] net: dsa: motorcomm: Add TC prio support
Date: Sun, 27 Sep 2026 05:17:33 +0800
Message-ID: <20260926211813.935723-5-mmyangfl@gmail.com>
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

The HW supports fewer ACL priorities than TC does. Notice the default
priority for flower is 49152 and catchall filter has priority 65535, so
scale the priority accordingly and reject the ones that do not map onto
a hardware priority. Also adjust the register field name.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/tc.c | 21 ++++++++++++++++++---
 drivers/net/dsa/motorcomm/tc.h |  5 +++--
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 0f6d7a4675fc..d919743d89c1 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -535,14 +535,14 @@ yt921x_acl_entries_find(struct yt921x_acl_entry *entries, unsigned int *sizep,
 }
 
 static void
-yt921x_acl_rule_set_ports(struct yt921x_acl_rule *aclrule, u16 ord,
+yt921x_acl_rule_set_ports(struct yt921x_acl_rule *aclrule, u16 prio,
 			  u16 ports_mask)
 {
 	struct yt921x_acl_entry *entries = aclrule->entries;
 
 	for (unsigned int i = 0; i < hweight8(aclrule->mask); i++) {
 		entries[i].key[1] |= YT921X_ACL_KEYb_SPORTS(ports_mask) |
-				     YT921X_ACL_KEYb_ORD(ord);
+				     YT921X_ACL_KEYb_PRIO(prio);
 	}
 }
 
@@ -1032,7 +1032,9 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
 			       const struct flow_cls_offload *cls, bool ingress,
 			       struct yt921x_priv *priv)
 {
+	const unsigned int scale = (U16_MAX + 1) / YT921X_ACL_PRIO_NUM;
 	struct netlink_ext_ack *extack = cls->common.extack;
+	u32 prio = cls->common.prio;
 	int res;
 
 	if (!ingress) {
@@ -1045,6 +1047,15 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
 		return -EOPNOTSUPP;
 	}
 
+	if (prio == U16_MAX) {
+		prio++;
+	} else if (prio % scale) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Invalid priority %u, must be a multiple of %u",
+				       prio, scale);
+		return -EOPNOTSUPP;
+	}
+
 	res = yt921x_acl_rule_ext_parse_flow_action(ruleext, cls, priv, port);
 	if (res)
 		return res;
@@ -1052,7 +1063,11 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
 	if (res)
 		return res;
 
-	yt921x_acl_rule_set_ports(&ruleext->r, 0, BIT(port));
+	/* TC prio can't be 0 & TC lowest first -> HW highest first
+	 * map 1...ACL_PRIO_NUM to (ACL_PRIO_NUM - 1)...0
+	 */
+	prio = YT921X_ACL_PRIO_NUM - prio / scale;
+	yt921x_acl_rule_set_ports(&ruleext->r, prio, BIT(port));
 	ruleext->r.tag = cls->cookie;
 	ruleext->r.type = TC_SETUP_CLSFLOWER;
 	return 0;
diff --git a/drivers/net/dsa/motorcomm/tc.h b/drivers/net/dsa/motorcomm/tc.h
index 3d4a8a24f8a8..0eee2e3808c5 100644
--- a/drivers/net/dsa/motorcomm/tc.h
+++ b/drivers/net/dsa/motorcomm/tc.h
@@ -88,8 +88,8 @@
 #define   YT921X_ACL_ENTRY_GRPIDm(bin, x)		((x) << (4 * (bin) + 1))
 #define  YT921X_ACL_ENTRY_ENm(bin)		BIT(4 * (bin))
 #define YT921X_ACLn_KEYm(blk, bin)	(0x204000 + 0x200 * (bin) + 8 * (blk))
-#define  YT921X_ACL_KEYb_ORD_M			GENMASK(29, 21)
-#define   YT921X_ACL_KEYb_ORD(x)			FIELD_PREP(YT921X_ACL_KEYb_ORD_M, (x))
+#define  YT921X_ACL_KEYb_PRIO_M			GENMASK(29, 21)	/* highest first */
+#define   YT921X_ACL_KEYb_PRIO(x)			FIELD_PREP(YT921X_ACL_KEYb_PRIO_M, (x))
 #define  YT921X_ACL_KEYb_SPORTS_M		GENMASK(20, 10)
 #define   YT921X_ACL_KEYb_SPORTS(x)			FIELD_PREP(YT921X_ACL_KEYb_SPORTS_M, (x))
 #define  YT921X_ACL_KEYb_SPORTn(port)		BIT((port) + 10)
@@ -330,6 +330,7 @@ enum yt921x_l4_type {
 #define YT921X_SHAPE_CIR_MAX	((1 << 18) - 1)
 #define YT921X_SHAPE_CBS_MAX	((1 << 14) - 1)
 
+#define YT921X_ACL_PRIO_NUM	512
 #define YT921X_UDF_NUM		8
 
 struct yt921x_acl_entry {
-- 
2.53.0

