Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBFF4A386D
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790457524; cv=none; b=EJh2sEfwkCWzo/8t1Jao3RNuafu1h56+RA5roWA0Uz6HvpY05fTQV/RBOhC+SqbEVY/fJtwm1A5Jd/mc1SlSAHgS54eTkdYhpsDhOTlQQSzUyrjoM3VM/xPsNHdQxvL0XagZgqwECloCZUJCiDYSc95ryuRPBJt8JgS1UJw2Fuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790457524; c=relaxed/simple;
	bh=c6ynQgqI01QLKzUN9Q+xyMXifY2us1lEGq+amPyM2JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KY/+9k2AuyNfmE534qX7pCs7mgOInqthrFNr4gU1dul0meCCp+TFvJz9QatqLHKwBgo0/EfsbA2mlh0pwcjQ5T6AmXogiJUcxNebKHp5nu3yz4no6n665yFcD6IjeFPMVajP0RPyGh6LTis6PJd386uMhglndQbOsGFT7VBaJE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebtmL0Y4; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebtmL0Y4"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc750a1482fso1050339a12.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 14:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790457522; x=1791062322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZoqF8v3bRZn4ho24ZZ7J7nacbWQOLu/eNegD7yMc+q8=;
        b=ebtmL0Y4zgCARrC3vjdiWzZhqZ/Xtqgf6HrZRd4fcSgEh/rbqmCy6pLpuL9yDo7aJ4
         ShdbJyflPE6CLn9w/ROSvwrW4G4RwTJ7T+Y4nLqhEeCbqnPT3j9O4VoGgFFrm1knpUdJ
         OqP/n8MW/+L64qPD3advVuVW1ToUTGC3GWRgo9oyKHDy5/+3RJfg/XwmxsvvHasraRRo
         spxIpv70zAiM3cZMz8rFtRy60M0QT2QmHChQNVXqzEoPCBuBhL66+tNfutNq3gUK/LUi
         UXcciuHI6Da8rpfTPdDwaWDU6GSxoGn/Kb1g8I6CKj5ddXttMzW6qyBKGSOOcpFhCkUm
         vspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790457522; x=1791062322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZoqF8v3bRZn4ho24ZZ7J7nacbWQOLu/eNegD7yMc+q8=;
        b=iQ07MJAlGxBVc2bMBy8n/dfuo8cfsJdSU/XV83OreOrdrnjUCI//t0W5GJOhh7cUev
         OcacyOWW4fSaID9uf5Wv2+3zE60gOZplCq6BJXSJuOEtOy50ZM9sAIXJneJmostcfAuD
         q45NDpWk+cmr5/5LqqcUDeAtFIJmPNjQpL3QV1aEVi0OW25mg7bX2jbBfd/ZSFg+zLHB
         aovJv9ko+ITDRZNYAbs8sY0KQA/87uuRWqMS+r1lyP1StBdrWTo1CVHYwVpr1f4/oSZ9
         gXRM00CID3Ch5iIfseiyjMhwWuAG9EYrWwdvSG1mDrrWFeNCxbeLDFzx7dgKLeti8XYT
         xn7A==
X-Gm-Message-State: AFq9FYLB8LSebd9xpmmvP8SbWzp4G3muHL/XcuXmuDsEcw8jtVbCuAef
	j6kQAKNW4gdjhNij3gie+rpF2EozB7kQUz6mzgf2xgLm3fsyqtiG1m1wTsKwLw==
X-Gm-Gg: AYBFou2qYlQYcnJdPpMof7HJevgsnac7tF9V9v1RrsmXseIKPgTwYYdqVwIuRfzJXif
	MdhLOarpLlSYPD6GpFNWdZUlZo1Uv8hm4rrOcQLOKyKUY21HtkbDFkd6HvtsIv2Ch9B77x9AD94
	AZZauXyxXOMilattfnJiTZgpWOav6yrfBGaoN2RjjbM0PlV513nEOTbEXwP3VR0KPTmwPyXvcKn
	Q4PBzCYKI5Sf/YrBs8skZwP/RA3NKkaWFdbzTOohWrGaUrfKT5dOayoWf1JTEmBtXumQ7BecuXS
	4oYlyLLpkbzBkhOsjDodivuQKnve87xV2urAQlGi/JURRZvtGJW2AoMrTmVF/31/e9n76wpkBuz
	71alm722CfVx3l99eemB7Q1OtFCVO5I9U5ov9pwZU9ojuzDx2jAB1140f4jQWeeAcViiQfGBO/E
	gp+i4YRRroPqaxU6BfWfrzNaaCmpb3taSBPkSRHCzYOpqkanWeLwq7ZMgpOvFwCIp+Nwce5+Hak
	qafO4Yy2ZIG7j/YMibJ4hG7
X-Received: by 2002:a17:90a:d445:b0:3a0:f0a4:a2c7 with SMTP id 98e67ed59e1d1-3a0f0a4b04emr1317651a91.20.1790457521628;
        Sat, 26 Sep 2026 14:18:41 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c3f74e5bsm9473204a91.5.2026.09.26.14.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 14:18:41 -0700 (PDT)
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
Subject: [PATCH net-next 6/6] net: dsa: motorcomm: Add broadcast/multicast policers via tc police
Date: Sun, 27 Sep 2026 05:17:35 +0800
Message-ID: <20260926211813.935723-7-mmyangfl@gmail.com>
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

Recognize the following tc flower filters

    tc filter add dev lan1 ingress protocol all flower skip_sw \
        dst_mac ff:ff:ff:ff:ff:ff action police rate 8mbit burst 64k
    (and dst_mac 01:00:00:00:00:00/01:00:00:00:00:00)

and map it onto dedicated per-port storm control, following the sja1105
broadcast/multicast policer approach.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c |  11 ++
 drivers/net/dsa/motorcomm/chip.h |   9 ++
 drivers/net/dsa/motorcomm/tc.c   | 175 ++++++++++++++++++++++++++++++-
 drivers/net/dsa/motorcomm/tc.h   |  17 +++
 4 files changed, 209 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 0405f1441f2b..fb2514e01f91 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -2676,6 +2676,12 @@ static int yt921x_chip_setup_tc(struct yt921x_priv *priv)
 		return res;
 	priv->port_shape_slot_ns = ctrl * op_ns;
 
+	ctrl = YT921X_STORM_SLOT_DEF;
+	res = yt921x_reg_write(priv, YT921X_STORM_SLOT, ctrl);
+	if (res)
+		return res;
+	priv->storm_slot_ns = ctrl * 10 * NSEC_PER_USEC;
+
 	return 0;
 }
 
@@ -2781,6 +2787,11 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	if (res)
 		return res;
 
+	res = yt921x_reg_write(priv, YT921X_STORM_UNK_MCAST,
+			       YT921X_STORM_UNK_MCAST_PORTS_M);
+	if (res)
+		return res;
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index d7f2b22ae504..4b2a688663df 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -567,6 +567,12 @@ struct yt921x_mib {
 	u64 tx_oam;
 };
 
+enum yt921x_storm_type {
+	YT921X_STORM_BCAST,
+	YT921X_STORM_MCAST,
+	YT921X_STORM_NUM
+};
+
 struct yt921x_port {
 	unsigned char index;
 
@@ -586,6 +592,8 @@ struct yt921x_port {
 
 	unsigned short acl_cnt;
 
+	unsigned long storm_tags[YT921X_STORM_NUM];
+
 #if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
 	unsigned char led_duty;
 	unsigned short led_cycle;
@@ -625,6 +633,7 @@ struct yt921x_priv {
 	const struct yt921x_info *info;
 	unsigned int meter_slot_ns;
 	unsigned int port_shape_slot_ns;
+	unsigned int storm_slot_ns;
 	/* cache of dsa_cpu_ports(ds) */
 	u16 cpu_ports_mask;
 	unsigned char cycle_ns;
diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
index 05d4a5957af9..3a0c6e0fbc52 100644
--- a/drivers/net/dsa/motorcomm/tc.c
+++ b/drivers/net/dsa/motorcomm/tc.c
@@ -182,6 +182,41 @@ yt921x_marker_tfm_shape(struct yt921x_marker *marker, u64 rate, u64 burst,
 				 priv, port, extack);
 }
 
+static int
+yt921x_marker_tfm_storm(struct yt921x_marker *marker,
+			const struct flow_action_police *police,
+			struct yt921x_priv *priv, int port)
+{
+	unsigned int slot_ns = priv->storm_slot_ns;
+	bool pkt_mode = !!police->rate_pkt_ps;
+	u64 burst;
+	u64 rate;
+	u32 cbs;
+	u32 cir;
+
+	rate = pkt_mode ? police->rate_pkt_ps : police->rate_bytes_ps;
+	burst = pkt_mode ? police->burst_pkt : police->burst;
+	if (pkt_mode) {
+		rate *= 1024;
+		burst *= 1024;
+	}
+
+	/* 1 token = 1 rate */
+	cir = div_u64(slot_ns * rate, NSEC_PER_SEC);
+	if (cir > YT921X_STORM_CIR_MAX)
+		return -ERANGE;
+	cbs = div_u64(slot_ns * burst, NSEC_PER_SEC);
+	if (cbs > YT921X_STORM_CBS_MAX)
+		return -ERANGE;
+
+	*marker = (typeof(*marker)){
+		.cir = cir,
+		.cbs = cbs,
+		.pkt_mode = pkt_mode,
+	};
+	return 0;
+}
+
 static int
 yt921x_police_validate(const struct flow_action_police *police,
 		       const struct flow_action *action,
@@ -550,6 +585,12 @@ struct yt921x_acl_rule_ext {
 	struct yt921x_acl_rule r;
 
 	struct yt921x_marker marker;
+	struct yt921x_marker marker_storm;
+
+	bool non_storm:1;
+	bool marker_storm_set:1;
+	bool storm_type_set:1;
+	unsigned char storm_type;
 };
 
 static int
@@ -597,6 +638,8 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 
 			entry->key[0] |= ntohl(match.key->dst);
 			entry->mask[0] |= ntohl(match.mask->dst);
+
+			ruleext->non_storm = true;
 		}
 
 		if (match.mask->src) {
@@ -607,6 +650,8 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 
 			entry->key[0] |= ntohl(match.key->src);
 			entry->mask[0] |= ntohl(match.mask->src);
+
+			ruleext->non_storm = true;
 		}
 	}
 
@@ -626,6 +671,8 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 
 			entry->key[0] |= ntohl(match.key->dst.s6_addr32[i]);
 			entry->mask[0] |= ntohl(match.mask->dst.s6_addr32[i]);
+
+			ruleext->non_storm = true;
 		}
 
 		for (unsigned int i = 0; i < 4; i++) {
@@ -639,6 +686,8 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 
 			entry->key[0] |= ntohl(match.key->src.s6_addr32[i]);
 			entry->mask[0] |= ntohl(match.mask->src.s6_addr32[i]);
+
+			ruleext->non_storm = true;
 		}
 	}
 
@@ -661,6 +710,8 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 				 ntohs(match.key->src);
 		entry->mask[0] |= (ntohs(match.mask->dst) << 16) |
 				  ntohs(match.mask->src);
+
+		ruleext->non_storm = true;
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS_RANGE)) {
@@ -684,21 +735,40 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 			entry->key[0] |= ntohs(match.key->tp_min.dst) << 16;
 			entry->key[1] |= YT921X_ACL_KEYb_L4_DPORT_RANGE_EN;
 			entry->mask[0] |= ntohs(match.key->tp_max.dst) << 16;
+
+			ruleext->non_storm = true;
 		}
 
 		if (match.mask->tp.src) {
 			entry->key[0] |= ntohs(match.key->tp_min.src);
 			entry->key[1] |= YT921X_ACL_KEYb_L4_SPORT_RANGE_EN;
 			entry->mask[0] |= ntohs(match.key->tp_max.src);
+
+			ruleext->non_storm = true;
 		}
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
+		static const u8 mcast_addr[ETH_ALEN] = {0x01};
 		struct flow_match_eth_addrs match;
 		u32 mask;
 
 		flow_rule_match_eth_addrs(rule, &match);
 
+		if (!ruleext->non_storm) {
+			if (is_broadcast_ether_addr(match.mask->dst) &&
+			    is_broadcast_ether_addr(match.key->dst)) {
+				ruleext->storm_type = YT921X_STORM_BCAST;
+				ruleext->storm_type_set = true;
+			} else if (ether_addr_equal(match.mask->dst, mcast_addr) &&
+				   is_multicast_ether_addr(match.key->dst)) {
+				ruleext->storm_type = YT921X_STORM_MCAST;
+				ruleext->storm_type_set = true;
+			} else {
+				ruleext->non_storm = true;
+			}
+		}
+
 		mask = ethaddr_hi4_to_u32(match.mask->dst);
 		if (mask) {
 			entry = yt921x_acl_entries_new(entries, &size,
@@ -781,6 +851,8 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 				entry->key[0] |= ntohs(match.key->n_proto);
 				entry->mask[0] |= ntohs(match.mask->n_proto);
 			}
+
+			ruleext->non_storm = true;
 		}
 
 		if (match.mask->ip_proto) {
@@ -820,6 +892,8 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 				entry->key[0] |= YT921X_ACL_BINa_MISC_IP_PROTO(match.key->ip_proto);
 				entry->mask[0] |= YT921X_ACL_BINa_MISC_IP_PROTO(match.mask->ip_proto);
 			}
+
+			ruleext->non_storm = true;
 		}
 	}
 
@@ -839,6 +913,8 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 								  set);
 			if (!size)
 				goto err;
+
+			ruleext->non_storm = true;
 		}
 		if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
 			bool set = match.key->flags & FLOW_DIS_FIRST_FRAG;
@@ -847,6 +923,8 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 								 set);
 			if (!size)
 				goto err;
+
+			ruleext->non_storm = true;
 		}
 	}
 
@@ -869,6 +947,8 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 
 			entry->key[0] |= YT921X_ACL_BINa_MISC_TOS(match.key->tos);
 			entry->mask[0] |= YT921X_ACL_BINa_MISC_TOS(match.mask->tos);
+
+			ruleext->non_storm = true;
 		}
 	}
 
@@ -889,6 +969,8 @@ yt921x_acl_rule_ext_parse_flow_entries(struct yt921x_acl_rule_ext *ruleext,
 
 			entry->key[0] |= YT921X_ACL_BINa_MISC_TCP_FLAGS(ntohs(match.key->flags));
 			entry->mask[0] |= YT921X_ACL_BINa_MISC_TCP_FLAGS(ntohs(match.mask->flags));
+
+			ruleext->non_storm = true;
 		}
 	}
 
@@ -923,7 +1005,10 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
 	int res;
 
 	memset(action, 0, 3 * sizeof(*action));
-	flow_action_for_each(i, act, flow_action)
+	flow_action_for_each(i, act, flow_action) {
+		if (act->id != FLOW_ACTION_POLICE)
+			ruleext->non_storm = true;
+
 		switch (act->id) {
 		case FLOW_ACTION_ACCEPT:
 		case FLOW_ACTION_DROP:
@@ -996,6 +1081,16 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
 			if (res)
 				return res;
 
+			if (!ruleext->non_storm) {
+				res = yt921x_marker_tfm_storm(&ruleext->marker_storm,
+							      police, priv,
+							      port);
+				if (!res)
+					ruleext->marker_storm_set = true;
+				else
+					ruleext->non_storm = true;
+			}
+
 			res = yt921x_marker_tfm_police(&ruleext->marker, police,
 						       0, priv, port, extack);
 			if (res)
@@ -1022,6 +1117,7 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,
 				     YT921X_ACL_ACTc_FWD_TRAP;
 			break;
 		}
+	}
 
 	ruleext->r.sw_assisted = !cls->common.skip_sw;
 	return 0;
@@ -1056,6 +1152,9 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
 		return -EOPNOTSUPP;
 	}
 
+	ruleext->non_storm = false;
+	ruleext->marker_storm_set = false;
+	ruleext->storm_type_set = false;
 	res = yt921x_acl_rule_ext_parse_flow_action(ruleext, cls, priv, port);
 	if (res)
 		return res;
@@ -1488,6 +1587,76 @@ yt921x_acl_add(struct yt921x_priv *priv,
 	return res;
 }
 
+static int
+yt921x_storm_del(struct yt921x_priv *priv, int port, unsigned int type)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+	int res;
+
+	res = yt921x_reg_write(priv, YT921X_STORM_CTRLnm(type, port), 0);
+	/* the kernel never rolls back on failure */
+
+	pp->storm_tags[type] = 0;
+
+	return res;
+}
+
+static int
+yt921x_storm_add(struct yt921x_priv *priv, int port, unsigned long cookie,
+		 unsigned int type, const struct yt921x_marker *marker,
+		 struct netlink_ext_ack *extack)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+	u32 ctrl;
+	int res;
+
+	if (pp->storm_tags[type])
+		return -ENOSPC;
+
+	ctrl = YT921X_STORM_CTRL_EN | YT921X_STORM_CTRL_CBS(marker->cbs) |
+	       YT921X_STORM_CTRL_CIR(marker->cir);
+	if (marker->pkt_mode)
+		ctrl |= YT921X_STORM_CTRL_PKT_MODE;
+	res = yt921x_reg_write(priv, YT921X_STORM_CTRLnm(type, port), ctrl);
+	if (res)
+		return res;
+
+	pp->storm_tags[type] = cookie;
+	return 0;
+}
+
+static int
+yt921x_flower_del(struct yt921x_priv *priv, int port, unsigned long cookie)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+
+	for (unsigned int type = YT921X_STORM_BCAST; type < YT921X_STORM_NUM;
+	     type++)
+		if (pp->storm_tags[type] == cookie)
+			return yt921x_storm_del(priv, port, type);
+
+	return yt921x_acl_del(priv, TC_SETUP_CLSFLOWER, cookie);
+}
+
+static int
+yt921x_flower_add(struct yt921x_priv *priv, int port,
+		  const struct yt921x_acl_rule_ext *ruleext,
+		  struct netlink_ext_ack *extack)
+{
+	int res;
+
+	if (!ruleext->non_storm && ruleext->marker_storm_set &&
+	    ruleext->storm_type_set) {
+		res = yt921x_storm_add(priv, port, ruleext->r.tag,
+				       ruleext->storm_type,
+				       &ruleext->marker_storm, extack);
+		if (res != -ENOSPC)
+			return res;
+	}
+
+	return yt921x_acl_add(priv, ruleext, extack);
+}
+
 int
 yt921x_dsa_cls_flower_stats(struct dsa_switch *ds, int port,
 			    struct flow_cls_offload *cls, bool ingress)
@@ -1511,7 +1680,7 @@ yt921x_dsa_cls_flower_del(struct dsa_switch *ds, int port,
 	int res;
 
 	mutex_lock(&priv->reg_lock);
-	res = yt921x_acl_del(priv, TC_SETUP_CLSFLOWER, cls->cookie);
+	res = yt921x_flower_del(priv, port, cls->cookie);
 	mutex_unlock(&priv->reg_lock);
 
 	return res;
@@ -1532,7 +1701,7 @@ yt921x_dsa_cls_flower_add(struct dsa_switch *ds, int port,
 		return res;
 
 	mutex_lock(&priv->reg_lock);
-	res = yt921x_acl_add(priv, &ruleext, extack);
+	res = yt921x_flower_add(priv, port, &ruleext, extack);
 	mutex_unlock(&priv->reg_lock);
 
 	return res;
diff --git a/drivers/net/dsa/motorcomm/tc.h b/drivers/net/dsa/motorcomm/tc.h
index f2ea0ac32f7e..a9107f97a1b9 100644
--- a/drivers/net/dsa/motorcomm/tc.h
+++ b/drivers/net/dsa/motorcomm/tc.h
@@ -263,12 +263,26 @@ enum yt921x_l4_type {
 
 #define YT921X_PORTn_RATE(port)		(0x220000 + 4 * (port))
 #define  YT921X_PORT_RATE_GAP_VALUE		GENMASK(4, 0)	/* default 20 */
+#define YT921X_STORM_SLOT		0x220100
+#define  YT921X_STORM_SLOT_SLOT_M		GENMASK(11, 0)
 #define YT921X_METER_SLOT		0x220104
 #define  YT921X_METER_SLOT_SLOT_M		GENMASK(11, 0)
 #define YT921X_PORTn_METER(port)	(0x220108 + 4 * (port))
 #define  YT921X_PORT_METER_EN			BIT(4)
 #define  YT921X_PORT_METER_ID_M			GENMASK(3, 0)
 #define   YT921X_PORT_METER_ID(x)			FIELD_PREP(YT921X_PORT_METER_ID_M, (x))
+#define YT921X_STORM_UNK_MCAST		0x220140
+#define  YT921X_STORM_UNK_MCAST_PORTS_M		GENMASK(10, 0)
+#define  YT921X_STORM_UNK_MCAST_PORT(x)		BIT(x)
+#define YT921X_STORM_CTRLnm(type, port)	(0x220200 + 4 * (11 * (type) + (port)))
+#define  YT921X_STORM_CTRL_CIR_M		GENMASK(31, 13)
+#define   YT921X_STORM_CTRL_CIR(x)			FIELD_PREP(YT921X_STORM_CTRL_CIR_M, (x))
+#define  YT921X_STORM_CTRL_CBS_M		GENMASK(12, 3)
+#define   YT921X_STORM_CTRL_CBS(x)			FIELD_PREP(YT921X_STORM_CTRL_CBS_M, (x))
+#define  YT921X_STORM_CTRL_BYTE_MODE_INCLUDE_GAP	BIT(2)	/* +GAP_VALUE bytes each packet */
+#define  YT921X_STORM_CTRL_PKT_MODE		BIT(1)	/* 0: byte rate mode */
+#define  YT921X_STORM_CTRL_EN			BIT(0)
+#define YT921X_STORM_STATnm(type, port)	(0x220400 + 4 * (11 * (type) + (port)))
 #define YT921X_METERn_CTRL(x)		(0x220800 + 0x10 * (x))
 #define  YT921X_METER_CTRLc_METER_EN		BIT(14)
 #define  YT921X_METER_CTRLc_TOKEN_OVERFLOW_EN	BIT(13)	/* RFC4115: yellow use unused green bw */
@@ -339,6 +353,9 @@ enum yt921x_l4_type {
 #define YT921X_SHAPE_UNIT_MAX	((1 << 3) - 1)
 #define YT921X_SHAPE_CIR_MAX	((1 << 18) - 1)
 #define YT921X_SHAPE_CBS_MAX	((1 << 14) - 1)
+#define YT921X_STORM_SLOT_DEF	100
+#define YT921X_STORM_CIR_MAX	((1 << 19) - 1)
+#define YT921X_STORM_CBS_MAX	((1 << 10) - 1)
 
 #define YT921X_ACL_PRIO_NUM	512
 #define YT921X_UDF_NUM		8
-- 
2.53.0

