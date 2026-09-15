Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7CD43D4EC
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494912; cv=none; b=KCbD4+bJWccaGpaiyTuzFO7q2/2PALrU3qok2mKUEQYpw6RkVGw6O7K9cfCmrIFpQmx0QeKonN4Gfry226Gdjsffw6zeAJGYggLZmym8oTJLRRbuVpRTkuEcZqadCdNhp6eIm1ZkSxXL8wqGr4G3l9P0CJhb9ogu7luPKaj3mto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494912; c=relaxed/simple;
	bh=EGgUeexHL16pszCDKE3Adg0tEXxMHX/oXfoT4zBe1ZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kFMYjd6PD4OSonDGM+p4fmwBFKmcDp21xWFOKk0LV/yqZePH4Sjh7rRTZtbWvuV4f98hFKmhGlTRRX6SV+AOpvZ9UUkQfWWHCXHGdcfVMCJCpTbNwHKVb7qAoL+jribx5VNTW5TiF112Bp7Rh8zWJGbFeCEJodp1pHjZaF+IJ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XDtjSwGn; arc=none smtp.client-ip=209.85.219.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XDtjSwGn"
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90e80ce3597so116649576d6.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494907; x=1790099707; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=shJD9W7a7rr3/9VynwTawXVAOduz3/w6g0FvFnBmeFg=;
        b=XDtjSwGnEv/5kLrhEOpLgWVQ7WSkX1Ks1up+O9KDJ3frrctsBfqRBYrt/gSficuraK
         FjsxSqaQKkvRiGerKEHjQknGbPvIxb+PA2N7CfB7YWqD05Bd9Laj0oqJnUxKxBY1GvAE
         FY8mjiFeDvr72exj9tnFp/kg+IGzeUkga9DAzR8OH+dbAwiovfA7dWWC4RSYC7t20d6n
         yjSCoS1q2OhWnlZN2OdYyguCMPH1Fm6vVlV8OINXEhorWSEIL9MepKogazTEbddriVlY
         +zveptJvLCUN3Rt+Xw91gwRmT/iY6a/FrgYON+fPVh72lZMKqVfuw88CH0ruGa8G2lyY
         gvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494907; x=1790099707;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shJD9W7a7rr3/9VynwTawXVAOduz3/w6g0FvFnBmeFg=;
        b=ZZvW3DTZZUKhWRaEHSOcQC45KZ1KOS38HXRP3c65kwBZjqgodK4+hxM11M0nzTJlHb
         SNq3BClvJoDCz3M1XtN6kjgroW9gm0lYwlGukf0QDTNZE04WrqEOop2nK7m6rFVKF0UM
         JZuAFgEiPyk+2iWW8qkKJNGBeQnI+fPkxy4LOVV821vl3+RybKe2z9eXQyzbbEJz7Ete
         1e1hF5Fyji7qoj6ZifuCi3n8TttNOYRvRFsUyD95baT5aGmYKanAjVysUbUgwBGQURfj
         qvleElHGAfRJyIeas9oVTavKzMzb/zeQKuYaZ3DQJ7NxLuT+oexaekUs/WhFguNlxtcJ
         SHyA==
X-Forwarded-Encrypted: i=1; AKwUvBzonse4Mqa1l3oCya51EbWFrKRoPZeSsXBfPtQUwHCYcN7RKHdmGb4rPWZISgVro1wHUVcYwbw=@vger.kernel.org
X-Gm-Message-State: AFuF++kToABQ0k8X36uCQoAdbQ+NiLWTRSeYR6ZCO4TfJKUk4SUIDixs
	raD1X2bwT2MFYpNcp47l/8a+JYOb+rHZUatqDBd09QVjYbbi9KSHcLuuADE3lhKz2EXhzvXkmPm
	KLVp2egjVMAwcPg==
X-Received: from qvul6.prod.google.com ([2002:ad4:4526:0:b0:911:efc1:43ef])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4890:b0:90e:8356:9bd8 with SMTP id 6a1803df08f44-9123a480698mr32397096d6.11.1789494907226;
 Tue, 15 Sep 2026 10:55:07 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:54:56 +0000
In-Reply-To: <20260915175501.391567-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260915175501.391567-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915175501.391567-4-edumazet@google.com>
Subject: [PATCH v4 net-next 3/8] vxlan: vnifilter: signal interrupted
 RTM_GETTUNNEL dumps
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

vxlan_vnifilter_dump() walks all vxlan devices of a netns, and for each
one walks vg->vni_list. Both cursors are plain ordinals stored in
cb->args[0] and cb->args[1], and RTNL is released between dump skbs.

A concurrent __vxlan_vni_add_list(), which inserts sorted by VNI,
__vxlan_vni_del_list(), or an in-place group update in
vxlan_vni_update() (which splits or merges coalesced VNI ranges) shifts
the second cursor, duplicating or skipping entries. Unregistering a
vxlan device shifts the first one, and the partially dumped device is
then skipped altogether by the "if (idx < s_idx)" test, silently losing
the rest of its VNIs.

Add a per-netns generation counter, bumped whenever the set of vxlan
devices in the netns or any vni_list changes, and feed it to
nl_dump_check_consistent() so that user space gets NLM_F_DUMP_INTR and
can retry, as vxlan_mdb_dump() already does.

The counter is keyed on dev_net(vxlan->dev) rather than vxlan->net,
because the dump enumerates devices with for_each_netdev_rcu() in the
netns the netdevice lives in, which differs from the packet i/o netns
when the device was created with a separate link netns.

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c      |  4 ++++
 drivers/net/vxlan/vxlan_private.h   |  9 ++++++++
 drivers/net/vxlan/vxlan_vnifilter.c | 34 ++++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 259f0f07a53582ed72411ed22df562c41856a56b..a693e189cf9a87d2c8215252c1e45d7794f3cade 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4758,6 +4758,10 @@ static int vxlan_netdevice_event(struct notifier_block *unused,
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct vxlan_net *vn = net_generic(dev_net(dev), vxlan_net_id);
 
+	if ((event == NETDEV_REGISTER || event == NETDEV_UNREGISTER) &&
+	    netif_is_vxlan(dev))
+		vxlan_vnifilter_seq_inc(dev_net(dev));
+
 	if (event == NETDEV_UNREGISTER)
 		vxlan_handle_lowerdev_unregister(vn, dev);
 	else if (event == NETDEV_UDP_TUNNEL_PUSH_INFO)
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index e9448dbe5f1fc88c2b04a37432ee48066de58a63..5796cf0487ba0550705099e64c1b7fcdce23dab9 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -22,6 +22,8 @@ struct vxlan_net {
 	/* sock_list is protected by rtnl lock */
 	struct hlist_head sock_list[PORT_HASH_SIZE];
 	struct notifier_block nexthop_notifier_block;
+	/* Generation counter for RTM_GETTUNNEL dumps */
+	atomic_t vnifilter_seq;
 };
 
 struct vxlan_fdb_key {
@@ -177,6 +179,13 @@ vxlan_vnifilter_lookup(struct vxlan_dev *vxlan, __be32 vni)
 				      vxlan_vni_rht_params);
 }
 
+static inline void vxlan_vnifilter_seq_inc(const struct net *net)
+{
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+
+	atomic_inc(&vn->vnifilter_seq);
+}
+
 /* vxlan_core.c */
 int vxlan_fdb_create(struct vxlan_dev *vxlan,
 		     const u8 *mac, union vxlan_addr *ip,
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 4404b912a74275cd199951bb254e7180d39edf3c..ce986a00a05c9b14d3e901a90508192c4ca30258 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -410,9 +410,22 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 
 	nlmsg_end(skb, nlh);
 
+	nl_dump_check_consistent(cb, nlh);
+
 	return err;
 }
 
+static u32 vxlan_vnifilter_base_seq(const struct net *net)
+{
+	const struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+	u32 res = atomic_read(&vn->vnifilter_seq);
+
+	/* Must not return 0 (see nl_dump_check_consistent()) */
+	if (!res)
+		res = 0x80000000;
+	return res;
+}
+
 static int vxlan_vnifilter_dump(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	int idx = 0, err = 0, s_idx = cb->args[0];
@@ -432,6 +445,9 @@ static int vxlan_vnifilter_dump(struct sk_buff *skb, struct netlink_callback *cb
 	}
 
 	rcu_read_lock();
+
+	cb->seq = vxlan_vnifilter_base_seq(net);
+
 	if (tmsg->ifindex) {
 		dev = dev_get_by_index_rcu(net, tmsg->ifindex);
 		if (!dev) {
@@ -691,13 +707,16 @@ static int vxlan_vni_update(struct vxlan_dev *vxlan,
 	if (ret)
 		return ret;
 
-	if (*changed)
+	if (*changed) {
+		vxlan_vnifilter_seq_inc(dev_net(vxlan->dev));
 		vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);
+	}
 
 	return 0;
 }
 
-static void __vxlan_vni_add_list(struct vxlan_vni_group *vg,
+static void __vxlan_vni_add_list(struct vxlan_dev *vxlan,
+				 struct vxlan_vni_group *vg,
 				 struct vxlan_vni_node *v)
 {
 	struct list_head *headp, *hpos;
@@ -713,13 +732,16 @@ static void __vxlan_vni_add_list(struct vxlan_vni_group *vg,
 	}
 	list_add_rcu(&v->vlist, hpos);
 	vg->num_vnis++;
+	vxlan_vnifilter_seq_inc(dev_net(vxlan->dev));
 }
 
-static void __vxlan_vni_del_list(struct vxlan_vni_group *vg,
+static void __vxlan_vni_del_list(struct vxlan_dev *vxlan,
+				 struct vxlan_vni_group *vg,
 				 struct vxlan_vni_node *v)
 {
 	list_del_rcu(&v->vlist);
 	vg->num_vnis--;
+	vxlan_vnifilter_seq_inc(dev_net(vxlan->dev));
 }
 
 static struct vxlan_vni_node *vxlan_vni_alloc(struct vxlan_dev *vxlan,
@@ -781,7 +803,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 		return err;
 	}
 
-	__vxlan_vni_add_list(vg, vninode);
+	__vxlan_vni_add_list(vxlan, vg, vninode);
 
 	if (vxlan->dev->flags & IFF_UP)
 		vxlan_vs_add_del_vninode(vxlan, vninode, false);
@@ -827,7 +849,7 @@ static int vxlan_vni_del(struct vxlan_dev *vxlan,
 	if (err)
 		goto out;
 
-	__vxlan_vni_del_list(vg, vninode);
+	__vxlan_vni_del_list(vxlan, vg, vninode);
 
 	vxlan_vnifilter_notify(vxlan, vninode, RTM_DELTUNNEL);
 
@@ -941,7 +963,7 @@ void vxlan_vnigroup_uninit(struct vxlan_dev *vxlan)
 #if IS_ENABLED(CONFIG_IPV6)
 		hlist_del_init_rcu(&v->hlist6.hlist);
 #endif
-		__vxlan_vni_del_list(vg, v);
+		__vxlan_vni_del_list(vxlan, vg, v);
 		vxlan_vnifilter_notify(vxlan, v, RTM_DELTUNNEL);
 		call_rcu(&v->rcu, vxlan_vni_node_rcu_free);
 	}
-- 
2.55.0.1032.g73a4cd73de-goog

