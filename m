Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E422E1746
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984905; cv=none; b=Ctekkoz99WmiDRHEqbyPqu+ywBdGSFTQF60UOADGhTdrpAr7Xrxdnn015iaqVeu1dHoC7yBaBiwwWSkclHUhCv7Y2tmfCOrvl7p0dQTkr66eRmUykeBaNva7vFLMbddTpahQh/RY4aOz5vS7tsGF+KNIk5T/U9hzQ5A2H72bGTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984905; c=relaxed/simple;
	bh=pWUQU4gBkpcdjn8VloPqdEJtf0RQKWxjc7/5KGircvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CXu1fhcp/gFDUN6uLhRhZw4eE5b8Cfw0v4jnjVRsPjYI8qt93A+nUmuHnqNKn7fMqROxmXfre/GLJQkDskngkuWuTlLVxmzCl5KKKhuRDAzsghSBicONKCVRF7BiKwpJDNYoBxAK5LPWfiSq5sQSmBsJdN9odeL3hk8hGIcxhwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BLgK3uzh; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BLgK3uzh"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9390a2c895bso210686085a.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789984903; x=1790589703; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cdTFuA7y9TUDjTF/xTxy/Fu+5PiDTS7fbknqdi8Ch0c=;
        b=BLgK3uzhQBgttELKt1/H00IMOtFlvz3i80ByoJMdvejsM/MHJL6jIygTsvA308oHDi
         eVIHYBCzW0eAKvHQHfJFf7Sug+bmd3X6f4tzklFShW6vIvfSIZWkaa4IXnxn2mTJ5+oK
         hK91vP2INuoVdzCxYra4oYLcefh8njOZLQMFMA7DXKxz3L/xa3+7440idIUabFpMa18o
         qn/tzisT/yLg9E+eZSB2PBviWDUHtC4MATpprEImLu6CX4n5bj6QsAddT0HUPlAg8P6i
         e5DQxL5hldswEq2lOo7qc1aLBfKcEvt9BM+UXEQ5ms3FWUDg5y7dLIvpNgtpl7WrDXKr
         xzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789984903; x=1790589703;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cdTFuA7y9TUDjTF/xTxy/Fu+5PiDTS7fbknqdi8Ch0c=;
        b=rrF0Yh7dCr94+dMiWzhAAkFlSoy+jvfqoVdFSx0mhBO7ruYpzMAJdrENXoAJjyuUof
         ByUefGsePxcpAdeMgFFLJn8spBNydVOqhHth6RoMtyrBaynSIxBM95m9FE6zzGPI/MsT
         kKHfAed2Xep04bDY2Y38+U451qQmFHpm2nPk2Q32Ea6saJOr1NofRcTmFL14iD1RNi85
         ZpNZagxfwtnzHoit1AGzzS6So/kBBV8362PGBiK40DUnRIsiSZBmPtQr6VypH1xx4pGQ
         qGy3rtFhQ/xOs8Lp/DRKConjWkwoOpKeWuFOxpb8xS5vmNd8ufsQmtKNOw0oJZTkqp0D
         oqZw==
X-Forwarded-Encrypted: i=1; AKwUvBz1bA+3u2FLCbPzBTxJJ3VS/Mm1AteBsv6sOO35FWc0opRbd685O94S3KUFwC7eZHK1X2fvVQc=@vger.kernel.org
X-Gm-Message-State: AFuF++ljO5f9W0IRvUjPkW5pC1EWJMg/A+lovlm8aIv3ORsbkVLOQNib
	/0Zsn65MvUyYzTFukFeEttEDOMCMPYiQbs+gXFVVRzCctPdA75nRNcpO/zZYkzz7gomuPrLIDxS
	AvxfVZPzywdgtHg==
X-Received: from qkg4.prod.google.com ([2002:a05:620a:9504:b0:93a:5ec:db55])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7013:b0:939:f4a1:baa6 with SMTP id af79cd13be357-93bf551c53dmr976402085a.15.1789984902434;
 Mon, 21 Sep 2026 03:01:42 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:01:32 +0000
In-Reply-To: <20260921100139.508191-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921100139.508191-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921100139.508191-2-edumazet@google.com>
Subject: [PATCH v5 net-next 1/8] vxlan: update default fdb entries when the
 lower device changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

vxlan_changelink() only refreshed the default fdb entries when the
remote IP changed, but vxlan_config_apply() also updates
default_dst.remote_ifindex when the lower device changes. A changelink
that only swaps the lower device therefore left the all zeros mac rdst
pointing at the old ifindex:

	ip link add vxlan0 type vxlan id 10 group 239.1.1.1 dev eth0
	ip link set dev vxlan0 type vxlan group 239.1.1.1 dev eth1

vxlan_xmit_one() uses rdst->remote_ifindex as the route oif, so traffic
kept leaving eth0.

VNI filter entries have the same problem, and are worse: their fdb
entries are keyed on the device remote_ifindex even when the vni
carries its own group, but vxlan_vnilist_update_group() only visited
the vnis without one. vxlan_vni_delete_group() later looks an entry up
with the current remote_ifindex, and vxlan_fdb_find_rdst() requires an
exact match, so the lookup failed and the entry survived the delete.
Re-adding the same vni then appended a second rdst, duplicating
transmitted BUM traffic.

Pass the old and new ifindex down to vxlan_update_default_fdb_entry()
so the append targets the new lower device and the delete still matches
the entry created for the old one, and refresh every vni rather than
only those inheriting the device group. If updating the vni list fails
partway through, unwind the already updated fdb entries so default_dst
and the fdb entries do not diverge.

Also run vxlan_multicast_leave() and vxlan_multicast_join() when
VXLAN_F_VNIFILTER is set so per-VNI multicast memberships are migrated
even when the device default remote_ip is not multicast.

The new ifindex is the one vxlan_config_apply() will commit, which is
the current one when lowerdev is NULL, so that default_dst and the fdb
entries can not diverge.

Fixes: 8bcdc4f3a20b ("vxlan: add changelink support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c      | 31 ++++++++++----
 drivers/net/vxlan/vxlan_private.h   |  6 +++
 drivers/net/vxlan/vxlan_vnifilter.c | 64 +++++++++++++++++++++++------
 3 files changed, 80 insertions(+), 21 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 347245cc1de4ea44f723176312b0b53869a1641c..c4e3e8e8eef57196c3b7120ff4b8ce71207f3bf8 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4452,6 +4452,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct net_device *lowerdev;
 	struct vxlan_config conf;
 	struct vxlan_rdst *dst;
+	u32 new_ifindex;
 	int err;
 
 	if (!rtnl_dev_link_net_capable(dev, vxlan->net))
@@ -4475,13 +4476,16 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (err)
 		return err;
 
+	/* vxlan_config_apply() only commits remote_ifindex if lowerdev is set */
+	new_ifindex = lowerdev ? conf.remote_ifindex : dst->remote_ifindex;
+
 	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip);
 	change_igmp = vxlan->dev->flags & IFF_UP &&
 		      (rem_ip_changed ||
-		       dst->remote_ifindex != conf.remote_ifindex);
+		       dst->remote_ifindex != new_ifindex);
 
 	/* handle default dst entry */
-	if (rem_ip_changed) {
+	if (rem_ip_changed || dst->remote_ifindex != new_ifindex) {
 		spin_lock_bh(&vxlan->hash_lock);
 		if (!vxlan_addr_any(&conf.remote_ip)) {
 			err = vxlan_fdb_update(vxlan, all_zeros_mac,
@@ -4490,7 +4494,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 					       NLM_F_APPEND | NLM_F_CREATE,
 					       vxlan->cfg.dst_port,
 					       conf.vni, conf.vni,
-					       conf.remote_ifindex,
+					       new_ifindex,
 					       NTF_SELF, 0, true, extack);
 			if (err) {
 				spin_unlock_bh(&vxlan->hash_lock);
@@ -4509,13 +4513,21 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 					   true);
 		spin_unlock_bh(&vxlan->hash_lock);
 
-		/* If vni filtering device, also update fdb entries of
-		 * all vnis that were using default remote ip
+		/* If vni filtering device, also update default fdb entries of
+		 * all vnis
 		 */
 		if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
 			err = vxlan_vnilist_update_group(vxlan, &dst->remote_ip,
-							 &conf.remote_ip, extack);
+							 &conf.remote_ip,
+							 dst->remote_ifindex,
+							 new_ifindex, extack);
 			if (err) {
+				vxlan_update_default_fdb_entry(vxlan, conf.vni,
+							       &conf.remote_ip,
+							       &dst->remote_ip,
+							       new_ifindex,
+							       dst->remote_ifindex,
+							       NULL);
 				netdev_adjacent_change_abort(dst->remote_dev,
 							     lowerdev, dev);
 				return err;
@@ -4523,7 +4535,9 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 		}
 	}
 
-	if (change_igmp && vxlan_addr_multicast(&dst->remote_ip))
+	if (change_igmp &&
+	    (vxlan_addr_multicast(&dst->remote_ip) ||
+	     (vxlan->cfg.flags & VXLAN_F_VNIFILTER)))
 		err = vxlan_multicast_leave(vxlan);
 
 	if (netif_running(dev) && conf.age_interval != vxlan->cfg.age_interval)
@@ -4535,7 +4549,8 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	vxlan_config_apply(dev, &conf, lowerdev, vxlan->net, true);
 
 	if (!err && change_igmp &&
-	    vxlan_addr_multicast(&dst->remote_ip))
+	    (vxlan_addr_multicast(&dst->remote_ip) ||
+	     (vxlan->cfg.flags & VXLAN_F_VNIFILTER)))
 		err = vxlan_multicast_join(vxlan);
 
 	return err;
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index b1eec221636088aa1c1674221d5ef0f13698b53f..e4ceca925bde7bea909bd691fa0f4ebfebdefbd3 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -213,9 +213,15 @@ void vxlan_vs_add_vnigrp(struct vxlan_dev *vxlan,
 			 struct vxlan_sock *vs,
 			 bool ipv6);
 void vxlan_vs_del_vnigrp(struct vxlan_dev *vxlan);
+int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
+				   union vxlan_addr *old_remote_ip,
+				   union vxlan_addr *remote_ip,
+				   u32 old_ifindex, u32 new_ifindex,
+				   struct netlink_ext_ack *extack);
 int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
 			       union vxlan_addr *old_remote_ip,
 			       union vxlan_addr *new_remote_ip,
+			       u32 old_ifindex, u32 new_ifindex,
 			       struct netlink_ext_ack *extack);
 
 
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index dd94085e088656d27b62420a5c8c95c609510a4c..12fa11a31818456232682edb1c79042478832836 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -470,14 +470,19 @@ static const struct nla_policy vni_filter_policy[VXLAN_VNIFILTER_MAX + 1] = {
 	[VXLAN_VNIFILTER_ENTRY] = { .type = NLA_NESTED },
 };
 
-static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
-					  union vxlan_addr *old_remote_ip,
-					  union vxlan_addr *remote_ip,
-					  struct netlink_ext_ack *extack)
+int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
+				   union vxlan_addr *old_remote_ip,
+				   union vxlan_addr *remote_ip,
+				   u32 old_ifindex, u32 new_ifindex,
+				   struct netlink_ext_ack *extack)
 {
-	struct vxlan_rdst *dst = &vxlan->default_dst;
 	int err = 0;
 
+	if (old_remote_ip && remote_ip &&
+	    vxlan_addr_equal(old_remote_ip, remote_ip) &&
+	    old_ifindex == new_ifindex)
+		return 0;
+
 	spin_lock_bh(&vxlan->hash_lock);
 	if (remote_ip && !vxlan_addr_any(remote_ip)) {
 		err = vxlan_fdb_update(vxlan, all_zeros_mac,
@@ -487,7 +492,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				       vxlan->cfg.dst_port,
 				       vni,
 				       vni,
-				       dst->remote_ifindex,
+				       new_ifindex,
 				       NTF_SELF, 0, true, extack);
 		if (err) {
 			spin_unlock_bh(&vxlan->hash_lock);
@@ -500,7 +505,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				   *old_remote_ip,
 				   vxlan->cfg.dst_port,
 				   vni, vni,
-				   dst->remote_ifindex,
+				   old_ifindex,
 				   true);
 	}
 	spin_unlock_bh(&vxlan->hash_lock);
@@ -546,6 +551,8 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 
 	ret = vxlan_update_default_fdb_entry(vxlan, vninode->vni,
 					     oldrip, newrip,
+					     dst->remote_ifindex,
+					     dst->remote_ifindex,
 					     extack);
 	if (ret)
 		goto out;
@@ -583,8 +590,10 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
 			       union vxlan_addr *old_remote_ip,
 			       union vxlan_addr *new_remote_ip,
+			       u32 old_ifindex, u32 new_ifindex,
 			       struct netlink_ext_ack *extack)
 {
+	union vxlan_addr *oldrip, *newrip;
 	struct list_head *headp, *hpos;
 	struct vxlan_vni_group *vg;
 	struct vxlan_vni_node *vent;
@@ -595,17 +604,46 @@ int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
 	headp = &vg->vni_list;
 	list_for_each_prev(hpos, headp) {
 		vent = list_entry(hpos, struct vxlan_vni_node, vlist);
+
 		if (vxlan_addr_any(&vent->remote_ip)) {
-			ret = vxlan_update_default_fdb_entry(vxlan, vent->vni,
-							     old_remote_ip,
-							     new_remote_ip,
-							     extack);
-			if (ret)
-				return ret;
+			oldrip = old_remote_ip;
+			newrip = new_remote_ip;
+		} else {
+			/* A vni with its own group keeps it, but its fdb entry
+			 * is still keyed on the device remote_ifindex.
+			 */
+			oldrip = &vent->remote_ip;
+			newrip = &vent->remote_ip;
 		}
+
+		ret = vxlan_update_default_fdb_entry(vxlan, vent->vni,
+						     oldrip, newrip,
+						     old_ifindex, new_ifindex,
+						     extack);
+		if (ret)
+			goto err_unwind;
 	}
 
 	return 0;
+
+err_unwind:
+	list_for_each_continue(hpos, headp) {
+		vent = list_entry(hpos, struct vxlan_vni_node, vlist);
+
+		if (vxlan_addr_any(&vent->remote_ip)) {
+			oldrip = old_remote_ip;
+			newrip = new_remote_ip;
+		} else {
+			oldrip = &vent->remote_ip;
+			newrip = &vent->remote_ip;
+		}
+
+		vxlan_update_default_fdb_entry(vxlan, vent->vni,
+					       newrip, oldrip,
+					       new_ifindex, old_ifindex,
+					       NULL);
+	}
+	return ret;
 }
 
 static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
-- 
2.55.0.1082.g2b9226bbc0-goog

