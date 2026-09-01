Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8612D33F8B2
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264465; cv=none; b=XaCcsdv9ogRphBNHQ8S+N//OuxkSL6TOvAT5ERPP5exzZiB9OPVusQGivA6QT6jndKgLdAxjVXRUER9w+Pnih3I7bwcZZ+mTtHLmukFkDCinCyGTsc060UmrqskHAmNCli6HGUdvDNh8NIJJUnrlg/mMUzMmzAi1o65opFH1iUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264465; c=relaxed/simple;
	bh=tdJiRvngwBZJEFqckMVh5CbVJMAJJT/FEcsuLmpJ9ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKxBDag9lATgFGAlL6ws12rZE+Xd4C90afite1bov6MIcsg5BFpfEMC1w5d+LJSEXWpZKd1WGjpFh7JjL/MblbF0KYlUYiLNCQF7zxVOhLPw6kTER1EGVeaq4IRPlv2ygWCypcStaxm37oXywkNoKFNnNLrsIRjqSzNGcSUzDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ST3uQuzJ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ST3uQuzJ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-482fc3327fdso538455f8f.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264462; x=1788869262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HMMQOAlRYAextL0wqVjD4N5g4g594G9DLp/sV2LJqQE=;
        b=ST3uQuzJVIvCikCIqfHkjRxGsZq7uOUXWj/2V/S9yZoG3YUXxGNocEKc56kxtmX1yG
         14QubPtMn/Q08E0zu1fWlm/rz9m3CHoT+h/uvZHYKiDPgDWJ78LV7mQGWRSthV3zCy1l
         QfwloAKOXCVgefzjrJpKOpeOcwvJhZoPN0Ip+n0gDxbkP1EOdLOjp2hzl9w5NxsdAHqU
         lthz+EvCs0t/ChUgxElmoSZ7HKVBeeFoqgkHuLf4CTEWVLdqvbNmMN3fIxMNUH9EmjcW
         g8RGrGowMKrRjzTfcsZ0+y6r7Q+uScavmlxcJAEiyuBPV/khFRoBW7M3h97JNAFY+7ss
         Ql8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264462; x=1788869262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HMMQOAlRYAextL0wqVjD4N5g4g594G9DLp/sV2LJqQE=;
        b=PNFYlr/2sz8BLb/I+ipB6Ha2ovbpIGktG/IXCB0nq5WoIaldknuFH6NtVQN85sMVcF
         PD1L+uWMPY2MB8BFJoZA00ziVFp/0p6o7HHijviuVXPDcTmLh2uG8YClhXYliSGg9Hc+
         yv299gE7bmnqYXcal6NwlQgFTBRZe3I+a7N3gRH/wJM7pcRKcjlnm/lTwf22NAjUXA/x
         pJqINivj2CuspoDUAHHU1kZ9FBwO4DZLArSq2C+uWfUjMqFJoOpgufFniGp4b2zWwFwh
         ANSP5Nd2NHwBxQ5idndKtV9XBvzVmEGidKBTFeK8jvNdp+blGMqbLKlyPKOU35UuYxjZ
         OqZw==
X-Gm-Message-State: AFuF++n2TdvWei3BZ+jUxEjK6B14lHTDBHf7LEBcyQ30lQ9mpCnM5Iyp
	SqM0ZnFtXj4UE3fAk4BCa5r7lIxfYe1z99kBJFmX3JuavaN6NDrmY7WDhLGIhlXlP91OdnEx7m6
	hrFTfy1wUbg==
X-Gm-Gg: AYBFou0CqfHoWfMzNGIxi8ZpapeCwXT6X0BtQdyvfl9i0dye7pPtejw8FKMluQ0vwai
	omFChHgsbhhZZ4wB6q32XTFR0PvNZlBMtF0Xi8qakywY7vmtkGVmjsvh2EmR8dOZF46sNuN0kz3
	ViGrZofVCDw03kIozuaG36MNVgcRQAlB4U8x8m9iJQfgd6la434ah+/FxGKI9Xp/akoNlt4XbMb
	R7cLGy7FoC98wI+drW9G5nekMN9eoQdpHv+6UpYBqDEYyGiDbFb3UTpNW0txffwv2ny30ggH1x2
	0qR/bAdJV6tiHbTDtP6R90GUYSZKYA4Ln6cBA0c85qPeIZfX7w/2bZBt38BiOd1/n421fYZfRlT
	yQWOHp7w3V8OkICXO3I3zMhmtd63xAG8Mc0Kr0Hra1MDgtgekP49JE8wMfnupUPElyt4bMUN4pj
	c6t3IgS9vyRlSn+PxeaL3PIM9w3kRiX/C+ah+aPbJiC28T2CZRrryM4TrpuuK43uNrq1b7RLd3R
	DLhECJw7zkm
X-Received: by 2002:a05:6000:4305:b0:47f:8ac0:ccb4 with SMTP id ffacd0b85a97d-4843faa7301mr15041009f8f.10.1788264461602;
        Tue, 01 Sep 2026 05:07:41 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d7e452sm4251154f8f.35.2026.09.01.05.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:40 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 4/9] net: bridge: vlan: annotate lockless vlan flags use
Date: Tue,  1 Sep 2026 15:07:16 +0300
Message-ID: <20260901120721.747908-5-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901120721.747908-1-razor@blackwall.org>
References: <20260901120721.747908-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vlan flags data races, they can be read lockless.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_multicast.c |  2 +-
 net/bridge/br_netlink.c   |  6 +++---
 net/bridge/br_private.h   |  4 ++--
 net/bridge/br_vlan.c      | 19 +++++++++++--------
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3ef5d8bbf552..bbcaedf15ca1 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -912,7 +912,7 @@ static void __br_multicast_query_handle_vlan(struct net_bridge_mcast *brmctx,
 	else if (br_multicast_ctx_is_vlan(brmctx))
 		vlan = brmctx->vlan;
 
-	if (vlan && !(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED)) {
+	if (vlan && !(READ_ONCE(vlan->flags) & BRIDGE_VLAN_INFO_UNTAGGED)) {
 		u16 vlan_proto;
 
 		if (br_vlan_get_proto(brmctx->br->dev, &vlan_proto) != 0)
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index b2cd4e39326d..62ce96d9ba32 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -41,7 +41,7 @@ static int __get_num_vlan_infos(struct net_bridge_vlan_group *vg,
 		if (v->vid == pvid)
 			flags |= BRIDGE_VLAN_INFO_PVID;
 
-		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
+		if (READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_UNTAGGED)
 			flags |= BRIDGE_VLAN_INFO_UNTAGGED;
 
 		if (vid_range_start == 0) {
@@ -385,7 +385,7 @@ static int br_fill_ifvlaninfo_compressed(struct sk_buff *skb,
 		if (v->vid == pvid)
 			flags |= BRIDGE_VLAN_INFO_PVID;
 
-		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
+		if (READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_UNTAGGED)
 			flags |= BRIDGE_VLAN_INFO_UNTAGGED;
 
 		if (vid_range_start == 0) {
@@ -437,7 +437,7 @@ static int br_fill_ifvlaninfo(struct sk_buff *skb,
 		if (v->vid == pvid)
 			vinfo.flags |= BRIDGE_VLAN_INFO_PVID;
 
-		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
+		if (READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_UNTAGGED)
 			vinfo.flags |= BRIDGE_VLAN_INFO_UNTAGGED;
 
 		if (nla_put(skb, IFLA_BRIDGE_VLAN_INFO,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 0efd2e79e255..96554d293d22 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -665,13 +665,13 @@ static inline int br_is_root_bridge(const struct net_bridge *br)
 /* check if a VLAN entry is global */
 static inline bool br_vlan_is_master(const struct net_bridge_vlan *v)
 {
-	return v->flags & BRIDGE_VLAN_INFO_MASTER;
+	return READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_MASTER;
 }
 
 /* check if a VLAN entry is used by the bridge */
 static inline bool br_vlan_is_brentry(const struct net_bridge_vlan *v)
 {
-	return v->flags & BRIDGE_VLAN_INFO_BRENTRY;
+	return READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_BRENTRY;
 }
 
 /* check if we should use the vlan entry, returns false if it's only context */
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index a53054fcc093..c8b2e3bfd42d 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -60,6 +60,7 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 				bool commit)
 {
 	struct net_bridge_vlan_group *vg;
+	u16 vlan_flags;
 	bool change;
 
 	if (br_vlan_is_master(v))
@@ -68,8 +69,9 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 		vg = nbp_vlan_group(v->port);
 
 	/* check if anything would be changed on commit */
+	vlan_flags = v->flags;
 	change = !!(flags & BRIDGE_VLAN_INFO_PVID) == !!(vg->pvid != v->vid) ||
-		 ((flags ^ v->flags) & BRIDGE_VLAN_INFO_UNTAGGED);
+		 ((flags ^ vlan_flags) & BRIDGE_VLAN_INFO_UNTAGGED);
 
 	if (!commit)
 		goto out;
@@ -80,9 +82,10 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 		__vlan_delete_pvid(vg, v->vid);
 
 	if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
-		v->flags |= BRIDGE_VLAN_INFO_UNTAGGED;
+		vlan_flags |= BRIDGE_VLAN_INFO_UNTAGGED;
 	else
-		v->flags &= ~BRIDGE_VLAN_INFO_UNTAGGED;
+		vlan_flags &= ~BRIDGE_VLAN_INFO_UNTAGGED;
+	WRITE_ONCE(v->flags, vlan_flags);
 
 out:
 	return change;
@@ -413,7 +416,7 @@ static int __vlan_del(struct net_bridge_vlan *v)
 	}
 
 	if (br_vlan_should_use(v)) {
-		v->flags &= ~BRIDGE_VLAN_INFO_BRENTRY;
+		WRITE_ONCE(v->flags, v->flags & ~BRIDGE_VLAN_INFO_BRENTRY);
 		vg->num_vlans--;
 	}
 
@@ -522,7 +525,7 @@ struct sk_buff *br_handle_vlan(struct net_bridge *br,
 	 * hardware on each egress port as appropriate. So only strip the VLAN
 	 * header if forwarding offload is not being used.
 	 */
-	if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED &&
+	if (READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_UNTAGGED &&
 	    !br_switchdev_frame_uses_tx_fwd_offload(skb))
 		__vlan_hwaccel_clear_tag(skb);
 
@@ -753,7 +756,7 @@ static int br_vlan_add_existing(struct net_bridge *br,
 		}
 
 		refcount_inc(&vlan->refcnt);
-		vlan->flags |= BRIDGE_VLAN_INFO_BRENTRY;
+		WRITE_ONCE(vlan->flags, vlan->flags | BRIDGE_VLAN_INFO_BRENTRY);
 		vg->num_vlans++;
 		*changed = true;
 		br_multicast_toggle_one_vlan(vlan, true);
@@ -1489,7 +1492,7 @@ int br_vlan_fill_forward_path_mode(struct net_bridge *br,
 	if (!v || !br_vlan_should_use(v))
 		return -EINVAL;
 
-	if (!(v->flags & BRIDGE_VLAN_INFO_UNTAGGED))
+	if (!(READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_UNTAGGED))
 		return 0;
 
 	if (path->bridge.vlan_mode == DEV_PATH_BR_VLAN_TAG)
@@ -1550,7 +1553,7 @@ int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 		return -ENOENT;
 
 	p_vinfo->vid = vid;
-	p_vinfo->flags = v->flags;
+	p_vinfo->flags = READ_ONCE(v->flags);
 	if (vid == br_get_pvid(vg))
 		p_vinfo->flags |= BRIDGE_VLAN_INFO_PVID;
 	return 0;
-- 
2.47.3

