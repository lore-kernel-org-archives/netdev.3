Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72F43637C
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100669; cv=none; b=HahzueYqi00qk1oddvJPDvqX0NMRbmOS31BPcn44butXn0BsCgcvIEt/P0nu7KoN27rdFH0GaDkQsIkRm8Wjv3ChAVLW+utivBSVaYIELMyUEseF1Z/e0Icd7ZjM/5wF4lsbTUVW9qb5wOvYXWVQtPqRBiYpUFZD69KXavK60eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100669; c=relaxed/simple;
	bh=r/2Z9wTHGZ3wr/3aHvir0FsRYgjcDxVFleYRNOaJYcw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bBglRYhUYjPbalQa95Lem7V3z/FTpYEW0RV2OeKlxuIR50ylOOe1jO0UvHNj5a7XkEAfrf2YSBq+Kwb+mXf4O7TyZBBu3/SaaruB9gThzFp+i7kg2WVvWuoiy7rMlvo9FccbHHjzW306H5hv4lQY5tkAQ0PsukVBDYSsMr5gecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o9h3dQBl; arc=none smtp.client-ip=209.85.219.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9h3dQBl"
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90e8341cfb4so2712746d6.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790100666; x=1790705466; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NihwOWwYLUP6lruz/7zOaj9Uv0M525ud9a544iScYLk=;
        b=o9h3dQBlpymQZDDyBcEI1G/0chet6JGNXmATGjjrPkmaiPLiNtBwMv0FUEiCMVhzeC
         C06DY04LJwzHmi3gznrA/u3/S9n3NcTZ5NtW6qDgdowCswWOWXsuaJWNPJRX74Bo59Cv
         5cL5Dvh7SGrP5NLkm11drIztHhi4Ksbbu7yfjpPmKtFVcfJuJFjmIYqfScnF5VSmGDhY
         9xGz1td1DlkTzmRsqSKAIbtEtz5gBaFlVm2FFKBZVVbZjkYgF1bGhyGMXKwbc/xnIC9N
         +Oon1y/BY1MJnn+0BZFpdKvasUFcM5Wvped+qeIOc0uetvfGPBvltBFpP5mh1uB3hRom
         9SnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790100666; x=1790705466;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NihwOWwYLUP6lruz/7zOaj9Uv0M525ud9a544iScYLk=;
        b=toeVecpprPnEF6y9r/15BDHkoLGNSjTZAuaCXoUITKJmm0m9BkUr7El/9hsYZf1iIL
         GZtYmttKLdGvsShUOBvaEiII0T2ZHhCGJCL2EOpzURtVdaZxLVsBX4Xgt7hFw26zYAFb
         gCfin4aSonpKD0yIa7uO6q3RbkSTkSGc+nrrgEcX/fWRyeVqUhMX/+eBwC2BkpUnAtSy
         AYfnihpkl8qsE7l6RpnNp/mTDdQVmbqmTjlSXnocEX2H5PeyV6AfHqyau/v91ItqBuUt
         cPCPUqcLImjapDWplC5BQcef8Z+v4GeeqoF/jobc8oLkN9BDGjGJUjnc4waUg17448Qj
         hl4A==
X-Forwarded-Encrypted: i=1; AKwUvBynX6Dhj1ucFUzeV5rHxKof4l9uYANPd2QazDpLoZuvFXt+Sk/IIYsrU8keogQDPbIGcWmfOXk=@vger.kernel.org
X-Gm-Message-State: AFuF++mdfAznK1AuSQDsRUu7t4KUA5kRNDiLHaCs22pdYJPmK1PrPJ+p
	2Yw59ViMLuX4k9HDGZY9dUB7SkT2QCyEDjbijQU0MguHn/9YClpxkLxlvqEMa7K9l5ubZseuePK
	TaahwEnLv15OV0w==
X-Received: from qtpg22.prod.google.com ([2002:ac8:70d6:0:b0:531:e52:3160])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5882:0:b0:531:3f6e:68fb with SMTP id d75a77b69052e-532eae32956mr5249761cf.58.1790100665686;
 Tue, 22 Sep 2026 11:11:05 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:10:55 +0000
In-Reply-To: <20260922181102.3989489-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922181102.3989489-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922181102.3989489-2-edumazet@google.com>
Subject: [PATCH v6 net-next 1/8] vxlan: update default fdb entries when the
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

Likewise, in vxlan_vni_update_group(), oldrip was only set when newrip
was NULL, so changing an existing VNI's group appended the new rdst
without deleting the old one. Set oldrip to the previous effective
remote IP whenever updating an existing VNI (!create).

Pass the old and new ifindex down to vxlan_update_default_fdb_entry()
so the append targets the new lower device and the delete still matches
the entry created for the old one, and refresh every vni rather than
only those inheriting the device group. If updating the vni list fails
partway through, unwind the already updated fdb entries (still deleting
the new rdst even if re-adding the old one fails) so default_dst and
the fdb entries do not diverge.

Also run vxlan_multicast_leave() and vxlan_multicast_join() when
VXLAN_F_VNIFILTER is set so per-VNI multicast memberships are migrated
even when the device default remote_ip is not multicast, and make
vxlan_multicast_leave_vnigrp() skip the default group and ignore
-EADDRNOTAVAIL when multiple VNIs share a multicast group.

The new ifindex is the one vxlan_config_apply() will commit, which is
the current one when lowerdev is NULL, so that default_dst and the fdb
entries can not diverge.

Fixes: 8bcdc4f3a20b ("vxlan: add changelink support")
Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c      | 39 ++++++++++----
 drivers/net/vxlan/vxlan_multicast.c | 13 ++++-
 drivers/net/vxlan/vxlan_private.h   |  6 +++
 drivers/net/vxlan/vxlan_vnifilter.c | 79 ++++++++++++++++++++++-------
 4 files changed, 106 insertions(+), 31 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 347245cc1de4ea44f723176312b0b53869a1641c..a2cede8b082ab90519c029c52e3cff9e018c2418 100644
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
@@ -4534,9 +4548,14 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 		dst->remote_dev = lowerdev;
 	vxlan_config_apply(dev, &conf, lowerdev, vxlan->net, true);
 
-	if (!err && change_igmp &&
-	    vxlan_addr_multicast(&dst->remote_ip))
-		err = vxlan_multicast_join(vxlan);
+	if (change_igmp &&
+	    (vxlan_addr_multicast(&dst->remote_ip) ||
+	     (vxlan->cfg.flags & VXLAN_F_VNIFILTER))) {
+		int join_err = vxlan_multicast_join(vxlan);
+
+		if (join_err)
+			err = join_err;
+	}
 
 	return err;
 }
diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
index 3b75b48dc726df40cebb233095a8a046ee274c30..b85283605aafa32017301d580cbbce089ab97d48 100644
--- a/drivers/net/vxlan/vxlan_multicast.c
+++ b/drivers/net/vxlan/vxlan_multicast.c
@@ -219,10 +219,17 @@ static int vxlan_multicast_leave_vnigrp(struct vxlan_dev *vxlan)
 	int last_err = 0, ret;
 
 	list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
-		if (vxlan_addr_multicast(&v->remote_ip) &&
-		    !vxlan_group_used(vn, vxlan, v->vni, &v->remote_ip,
+		if (!vxlan_addr_multicast(&v->remote_ip))
+			continue;
+		/* skip if address is same as default address */
+		if (vxlan_addr_equal(&v->remote_ip,
+				     &vxlan->default_dst.remote_ip))
+			continue;
+		if (!vxlan_group_used(vn, vxlan, v->vni, &v->remote_ip,
 				      0)) {
 			ret = vxlan_igmp_leave(vxlan, &v->remote_ip, 0);
+			if (ret == -EADDRNOTAVAIL)
+				ret = 0;
 			if (ret)
 				last_err = ret;
 		}
@@ -259,6 +266,8 @@ int vxlan_multicast_leave(struct vxlan_dev *vxlan)
 	    !vxlan_group_used(vn, vxlan, 0, NULL, 0)) {
 		ret = vxlan_igmp_leave(vxlan, &vxlan->default_dst.remote_ip,
 				       vxlan->default_dst.remote_ifindex);
+		if (ret == -EADDRNOTAVAIL)
+			ret = 0;
 		if (ret)
 			return ret;
 	}
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
index dd94085e088656d27b62420a5c8c95c609510a4c..336e8128be480a544caf0115bfb5b9254fe12eb3 100644
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
@@ -487,9 +492,9 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				       vxlan->cfg.dst_port,
 				       vni,
 				       vni,
-				       dst->remote_ifindex,
+				       new_ifindex,
 				       NTF_SELF, 0, true, extack);
-		if (err) {
+		if (err && extack) {
 			spin_unlock_bh(&vxlan->hash_lock);
 			return err;
 		}
@@ -500,7 +505,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				   *old_remote_ip,
 				   vxlan->cfg.dst_port,
 				   vni, vni,
-				   dst->remote_ifindex,
+				   old_ifindex,
 				   true);
 	}
 	spin_unlock_bh(&vxlan->hash_lock);
@@ -532,11 +537,12 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 			newrip = &dst->remote_ip;
 	}
 
-	/* if old rip exists, and no newrip,
-	 * explicitly delete old rip
-	 */
-	if (!newrip && !vxlan_addr_any(&old_remote_ip))
-		oldrip = &old_remote_ip;
+	if (!create) {
+		if (!vxlan_addr_any(&old_remote_ip))
+			oldrip = &old_remote_ip;
+		else if (!vxlan_addr_any(&dst->remote_ip))
+			oldrip = &dst->remote_ip;
+	}
 
 	if (!newrip && !oldrip)
 		return 0;
@@ -546,6 +552,8 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 
 	ret = vxlan_update_default_fdb_entry(vxlan, vninode->vni,
 					     oldrip, newrip,
+					     dst->remote_ifindex,
+					     dst->remote_ifindex,
 					     extack);
 	if (ret)
 		goto out;
@@ -560,6 +568,8 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 				      vxlan->default_dst.remote_ifindex)) {
 			ret = vxlan_igmp_leave(vxlan, &old_remote_ip,
 					       0);
+			if (ret == -EADDRNOTAVAIL)
+				ret = 0;
 			if (ret)
 				goto out;
 		}
@@ -583,8 +593,10 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
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
@@ -595,17 +607,46 @@ int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
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

