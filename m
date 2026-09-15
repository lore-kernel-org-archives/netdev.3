Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F410D43DEC1
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494908; cv=none; b=t0dp1c/VqaogZguBiPc53fyKhgLnZ95jSsLLVuSxi8xS0rfzZ0Jsd/pv2eV315eVHhV7W5wbvwJ00zeRYE3SWY3ID9TfQMZxxv2AdvuaQ2+mxFBomlWnbRBpG92NheGIe2dJGRpV74IicnvKWOMqnXOLlLUfGikGcrHmY7c7Wx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494908; c=relaxed/simple;
	bh=06uVqdRb1DGrbnSNdoCydDSvUM/eLNCG2fo4TP7EkMA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XZb2Cb+sH+wNOwJL2PZnGn3byUggbx79JZwzt0jkBb1l4cEUlPVo9q8Qe+DZvAjSOFyvalW2s87cBY17XFCmVQwIBVf/mFGJv4K/TzO0uaiM2fXAzvKALAEa5hC+Ap7qiO9pf3Ho2HrZvj8vPpaW0GjDLVMbjZkoBAN5ZBsc9j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pU/idNgf; arc=none smtp.client-ip=209.85.219.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pU/idNgf"
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91235881828so21711296d6.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494904; x=1790099704; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RbPuT5v2TMkVOlwtfou1rnICTfVPKhze/wiQj5pWL44=;
        b=pU/idNgf3C52pgfFXKT8p5vbKvz3wQQFDh3ofs/ToE/MnXEtqBVthh/hN0VNMzgBiH
         FcSSIMM4nPrsL5YyTLrr1QHh1+ETDG/UTh8p06wD0GSrWMOAgplJqYRh8COuf1VLvr/d
         x8uSz5+S1NEi1xdxCXPTRUO08s6RXcLpwU9UHxMd2FtgTLecNj4NF/Unhj/BuWYYlRlD
         w0C7uv+xznSr5pzjdVNlSdjAbzYXuH18T+mQGT3gRpkY3K1PVrUerRm7fF/0HVV/pTt4
         BR0mNp8P0sLQlynd1ilsGBWXgNeIkSzUBmdRhlQg8m8xjDX7lMRscegTlkqccDc/AYPc
         Prkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494904; x=1790099704;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RbPuT5v2TMkVOlwtfou1rnICTfVPKhze/wiQj5pWL44=;
        b=maLCgthya34b2qhEL13D7v4ophLuTWmxkvyXZSPXt6e6LF++ONkudu1/sfP07J6XAg
         ADDHaXsY2OGvf4UIIJBhJJKGUbGKsMvXLj0DT6jD6HN4kf+V2vJkI27P/7r01ctobFMN
         o8rpupXQkBo9rfJM5dABkrHtnxaqeMwJYbYfsVxGdpWkZ1fej0YOUtmx/yzdzNVvVlbZ
         +ROj/rI5TiAk6N6OUlX/z2LmrQKDhpuWUyp3n0MsLBUZY87hJf8Hy9TTeY/sjFlYk8JH
         gECpWgjj9fMKs02NymbKrB0uTNbstgzm0I/hQp4Li723tx1I0tzjKj+sEjSAAnVZeMRV
         QrLg==
X-Forwarded-Encrypted: i=1; AKwUvBxA0kwnR2VX/7NK+v3hcenCgbi0pT4MBZNccuOMzGW0oex3y17hcsA3NqNweAmGEYoxvICSVvc=@vger.kernel.org
X-Gm-Message-State: AFuF++lUCteFIPM0+/mv9m3Ex3vKBdfVDHOR/sEAqku50w6PQq3yl4fb
	Wx6Wc12/QuPfiBYFCoyUdd9f62sfOrsTvpoJ9KJSu4aYPIuz4t9mNl51u0RtqwxTLNmTdb/bTMD
	MFfvegb6YlwaHng==
X-Received: from qvbfn3.prod.google.com ([2002:ad4:5d63:0:b0:912:221b:2512])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3d01:b0:910:3ddb:d2b9 with SMTP id 6a1803df08f44-9122e55ce78mr139952336d6.19.1789494904381;
 Tue, 15 Sep 2026 10:55:04 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:54:54 +0000
In-Reply-To: <20260915175501.391567-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260915175501.391567-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915175501.391567-2-edumazet@google.com>
Subject: [PATCH v4 net-next 1/8] vxlan: update default fdb entries when the
 lower device changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
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
only those inheriting the device group.

The new ifindex is the one vxlan_config_apply() will commit, which is
the current one when lowerdev is NULL, so that default_dst and the fdb
entries can not diverge.

Fixes: 8bcdc4f3a20b ("vxlan: add changelink support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c      | 18 +++++++++-----
 drivers/net/vxlan/vxlan_private.h   |  1 +
 drivers/net/vxlan/vxlan_vnifilter.c | 37 ++++++++++++++++++++++-------
 3 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 347245cc1de4ea44f723176312b0b53869a1641c..259f0f07a53582ed72411ed22df562c41856a56b 100644
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
@@ -4509,12 +4513,14 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
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
 				netdev_adjacent_change_abort(dst->remote_dev,
 							     lowerdev, dev);
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index b1eec221636088aa1c1674221d5ef0f13698b53f..e9448dbe5f1fc88c2b04a37432ee48066de58a63 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -216,6 +216,7 @@ void vxlan_vs_del_vnigrp(struct vxlan_dev *vxlan);
 int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
 			       union vxlan_addr *old_remote_ip,
 			       union vxlan_addr *new_remote_ip,
+			       u32 old_ifindex, u32 new_ifindex,
 			       struct netlink_ext_ack *extack);
 
 
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index dd94085e088656d27b62420a5c8c95c609510a4c..e433e66f6d4d3b57807c8de3f07b5310f0ded200 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -473,11 +473,16 @@ static const struct nla_policy vni_filter_policy[VXLAN_VNIFILTER_MAX + 1] = {
 static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 					  union vxlan_addr *old_remote_ip,
 					  union vxlan_addr *remote_ip,
+					  u32 old_ifindex, u32 new_ifindex,
 					  struct netlink_ext_ack *extack)
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
@@ -595,14 +604,24 @@ int vxlan_vnilist_update_group(struct vxlan_dev *vxlan,
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
+			return ret;
 	}
 
 	return 0;
-- 
2.55.0.1032.g73a4cd73de-goog

