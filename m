Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D612931C7
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211221; cv=none; b=cjRLeu/DB+ghv69Z+arVLC9jOlDqLR6AuCgoAnLs3/HJivkfcwiT6IEiynkBO4JAPDMDa/VKpULNfndRt2w8bw/4xsvoNC02U/XY6EaK9J8CVcTY2sYFOA4AYiTqTEjbeZLJg7eTJ5qfem1TL/QjfE5YENY7tIZoCFYuj80ZCUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211221; c=relaxed/simple;
	bh=tiMGbl7YiySDDxaT7mP39g7i86oEja0S83IXc1lcNX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0hpCDiZdsnZNFEbgXXaTSPbm+T7nMEkmAtW1Op4Ccu/n7kndl4iCN5NVaB3Iro8pnpK86sX9+fCV0ca554mcTCTri1qvKqeVr0t73Z/ZtgzHlSqPXuuSE5tG/sNAkAsvb3EbYkL2eOwUQIH1Y7vqhPUC7m36q8tQfZot6Vm/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=QlK3hWew; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="QlK3hWew"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-48c54d65743so1128385f8f.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 07:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791211199; x=1791815999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b6deinWBLjHPGJwkUzGgA8QKl3at9nB5CJnJYmjFnTs=;
        b=QlK3hWewaL/qg7gwSsm5KGMjPczaaFz4Twoj62rv8bmdqJ5Ul3l5Y8yE3kBQBznZTx
         SXMbXnLASxtqvzw2jSzJ9kEYXBBfXPgbITZVugBo/kdTn97uF/pfZcjYo9dr9SUxe+GB
         v6dccsCOjc6w/MRRQ1p6WmNtbv0QLX89sgYn3mqFbXr2rmIaUwpn5qnEcK32/Lmehbxi
         zxhM+FF2ftdCGxv3f5eQEty60ssA6DqXk0Cb46FZbXZw1ZV6cPzPfTYclZzckOulgOA3
         zGB3Ct6nzhfG32Hze/g+MjsseSYKhGrhWq7lE4tM6L7d1fb54ZJaKByA30dFud5Yr26J
         1gNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211199; x=1791815999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b6deinWBLjHPGJwkUzGgA8QKl3at9nB5CJnJYmjFnTs=;
        b=NBWjrc6qRj2vXhCUYkAALX3cOPz1gZsUx95MUdnuqjw7kVluSDroFqNWwmYMYXaJab
         X8VEJ16MhXpr8KykW0allahhlfWGyc2qPu4zqIcBzQHlOPvvAEBNbNRPhq3USGYq2H/T
         SRsYHQPXqjutj93Fi3mpM3hiWXHUvdnEqDez2DWXwFQ/SgwQ62LVrGipv77F3AllRi4Q
         mBYthi0wOSOTFkK1yjJGPMBbF6AatCxhdOFkobOCvnFjn9Idhpx9zutgJggnUG2s576U
         ehoDdmyNVVQ/St7f1kKCHz5TwZVQC7TrNiI9bNDb0/6MLWakOoOhQ6sXRkHSzOc4jkPw
         FB8g==
X-Gm-Message-State: AFq9FYLU3rwceZkI2I50RwqCtKiEqA3XKHOu3oZ2/8+LZQg5EDWSQKlj
	s31kNz2LoEOH9Y5pj347plcveBweVa382tP0hdv2IDx9UMrrvLJqIRPjrlvguf/A54/pNX1jqxt
	qdwLw
X-Gm-Gg: AYBFou0xBIA39LRuv7Jg+yY1OeC6kKjA81lQyFUja209KRtW+4xBQj/9rQ8XFzABHIc
	dPPDkbp+2CxzZjJShRvCRf2JwpS2khwdOI09/uJHj2a9H37vl7c5wid3Ho0w3Vzjs54Un3cME2O
	p1whozvK7A2xM0i4vs9SdixffWnFM4Fc+PNNKMIOLVl5t8yfxYwneKL8PnXZTOeKbv9M0kjUljC
	AJFihDxeR/pEktdQy+sbCKV7dOMjpuNMz8e0PZ2NHOUe7l+FWQNg20x3iE6EHzN3aDeiduH1LtC
	X8Qstugl2aaaKX50u3dK4GYoacJFdhjrpEMsHeJLrqWNNu5sypKZ4Fefk4JmgsZTTQ6hsbG5CIp
	c2tBEGKYFnGid3WtYZvg/fvqK3xMPFsQWAwHfSkm8SzWy3672oqZ8WQzpjkgU0U33cdn9X24VuY
	gew8CYJLgxr7KH4IF7SMsXMUNAhlO53p595N+No6qejt4mbLDDeAbAYE3NR9T+g84fV+bP83e+o
	xVplNbAgJEG9ancI0IN
X-Received: by 2002:a05:6000:4b04:b0:48a:f36d:fb57 with SMTP id ffacd0b85a97d-48b1270af7dmr21384724f8f.18.1791211198767;
        Mon, 05 Oct 2026 07:39:58 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48c622ad9afsm4259504f8f.39.2026.10.05.07.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:39:58 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 4/6] net: bridge: vlan: inline pvid pointer updates
Date: Mon,  5 Oct 2026 17:39:35 +0300
Message-ID: <20261005143937.877466-5-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005143937.877466-1-razor@blackwall.org>
References: <20261005143937.877466-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After caching the pvid VLAN entry directly, the add and delete helpers
only check and update the pointer. So inline them both and clear pvid
directly in __vlan_flush before walking the VLAN entries.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_vlan.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index dcf783e1a440..c4e7e03e0969 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -34,24 +34,6 @@ static struct net_bridge_vlan *br_vlan_lookup(struct rhashtable *tbl, u16 vid)
 	return rhashtable_lookup_fast(tbl, &vid, br_vlan_rht_params);
 }
 
-static void __vlan_add_pvid(struct net_bridge_vlan_group *vg,
-			    struct net_bridge_vlan *v)
-{
-	if (rcu_access_pointer(vg->pvid) == v)
-		return;
-
-	RCU_INIT_POINTER(vg->pvid, v);
-}
-
-static void __vlan_delete_pvid(struct net_bridge_vlan_group *vg,
-			       struct net_bridge_vlan *v)
-{
-	if (rcu_access_pointer(vg->pvid) != v)
-		return;
-
-	RCU_INIT_POINTER(vg->pvid, NULL);
-}
-
 /* Update the BRIDGE_VLAN_INFO_PVID and BRIDGE_VLAN_INFO_UNTAGGED flags of @v.
  * If @commit is false, return just whether the BRIDGE_VLAN_INFO_PVID and
  * BRIDGE_VLAN_INFO_UNTAGGED bits of @flags would produce any change onto @v.
@@ -78,10 +60,12 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 	if (!commit)
 		goto out;
 
-	if (flags & BRIDGE_VLAN_INFO_PVID)
-		__vlan_add_pvid(vg, v);
-	else
-		__vlan_delete_pvid(vg, v);
+	if (flags & BRIDGE_VLAN_INFO_PVID) {
+		if (pvid != v)
+			RCU_INIT_POINTER(vg->pvid, v);
+	} else if (pvid == v) {
+		RCU_INIT_POINTER(vg->pvid, NULL);
+	}
 
 	if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
 		vlan_flags |= BRIDGE_VLAN_INFO_UNTAGGED;
@@ -432,7 +416,8 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 static void __vlan_unpublish(struct net_bridge_vlan_group *vg,
 			     struct net_bridge_vlan *v)
 {
-	__vlan_delete_pvid(vg, v);
+	if (rcu_access_pointer(vg->pvid) == v)
+		RCU_INIT_POINTER(vg->pvid, NULL);
 	if (!br_vlan_is_master(v)) {
 		struct net_bridge_vlan *masterv = v->brvlan;
 
@@ -503,7 +488,7 @@ static void __vlan_flush(const struct net_bridge *br,
 	struct net_bridge_vlan *vlan, *tmp;
 	u16 v_start = 0, v_end = 0;
 
-	__vlan_delete_pvid(vg, rtnl_dereference(vg->pvid));
+	RCU_INIT_POINTER(vg->pvid, NULL);
 	list_for_each_entry_safe(vlan, tmp, &vg->vlan_list, vlist) {
 		/* take care of disjoint ranges */
 		if (!v_start) {
-- 
2.47.3

