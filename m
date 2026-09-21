Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8A445D5C0
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984908; cv=none; b=aru6Os5nZEAoR5PZTeYpzNTx9lZkN9vafLfRDna26KQ/GuRg8/uEIkJ9tcvHuJTI4imz6CP5divdS5sfWqlz2aFwRFD13X6/ChNr9OHzLejejlJFxpkpVwPETaV34s0/F+ugxzRh2AiFDTU1zzEQw93f/iGlTHqmXFKkIkgAqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984908; c=relaxed/simple;
	bh=7+PDdazJGpn8nK9H3AAo2jsd6ZwDrWdLr1bpVAzIsYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qz7Td1+VTaDNUuUTRp5yuFCuAmtnumKQIFCYCxR2R3RVsPV3tNBcW/UB4FPBjwKMY4OYxn1AHnjUjhb624o4Q3jJBi20lkkdUzl2A4Dcjq1kFJPRqhu8zMBWquuQRVWk0QIN1APa13OSJG4wsCi/F5X83ed4ELpQLviXgGP1YYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o5ioGzPM; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5ioGzPM"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a1e564fd5so479287485a.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789984905; x=1790589705; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iYAU3l9E8lTg0E9jS6OXBwYFbe8bAsXlh0rN6uSxQkY=;
        b=o5ioGzPMOg5s+MPF9WuLbAtXLJJ8ZJ6+X3FWYLhIhYAduJr3w+joXJ4lCtGXUUMk4c
         WHVNJxM5RSzV6Sf0GN7q3bM2wAI9UuF1RWu+152Sc5a0p34X+22atsHF2T/f5jmk6tkN
         hMYn7HhxxIS1pAOF9Y/B4PdpUg7ziUzOwWcC4t8+tjdd2ZRnt5vFf7L5RQeOA5aGJHjF
         58rNXw2KsHbOOecg5vHgzLwqJhjb9QABc5V1i4deVpEN7F7XZUyPpWk0W4RwZjfP19+P
         r2sK5YCmNMi1OeDN1IOQR3iRjpJ1v/STpr8Aflsv4sBwTO/Vv9jshr9VlMOi4RW794tP
         D32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789984905; x=1790589705;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iYAU3l9E8lTg0E9jS6OXBwYFbe8bAsXlh0rN6uSxQkY=;
        b=pYM8heos9+J5aFciOU9MECsiFIFydNIrmMVz6dbtTVngteVEem0kHI+ZGk2tFZqDpQ
         QTA4F3ziwuKxI0uA92lugBJfHDuZE75AOzx7dQ5BRBBlJyfkT0MgYFVLOowJ3NkcvbbB
         Km5JteX4gb7NG2TC8nEfkgGvQD1kYqnXFtdy1ufB8v6cWYWWG/D9lgl84uKl2GpM+GUC
         HxF1/sIK3P8X8kezECWy31/JkIq4feb8bvaQ0qhcjwXb5nUK8swf22xmxHGrtVFZ/ygL
         I+WpkCM/45UuAa1tzPVawa6JvkWDyz2O92832mTEW8r+mcAssiF7l+0YbbrexUhuHhi1
         kgJw==
X-Forwarded-Encrypted: i=1; AKwUvBwbRAaWc3wcExZXN87f8zJr16zJgeC0Z5gr3T6PmcWZifIHvFKoVaMdyoS+2zQlaSA/UakeJwo=@vger.kernel.org
X-Gm-Message-State: AFuF++mIVGyu4UzDOI0XqIeEIOlmVrMfm+SuB39iJ2azgh4RuOnv9yno
	4rjiNXoI4Ahk0bEh/ScXvZSHzYc0Me6LhoyP8dsIVfmfWr0jKDsaiiBbrRyuazJwg4pQxZBjbVN
	7j/t9eoPQRFPZiw==
X-Received: from qkau16.prod.google.com ([2002:a05:620a:a1d0:b0:93a:2075:18f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6509:b0:93b:c3d1:ff8a with SMTP id af79cd13be357-93bf56f5325mr901808685a.39.1789984905143;
 Mon, 21 Sep 2026 03:01:45 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:01:34 +0000
In-Reply-To: <20260921100139.508191-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921100139.508191-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921100139.508191-4-edumazet@google.com>
Subject: [PATCH v5 net-next 3/8] vxlan: vnifilter: signal interrupted
 RTM_GETTUNNEL dumps
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
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
 drivers/net/vxlan/vxlan_vnifilter.c | 35 ++++++++++++++++++++++++-----
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index c4e3e8e8eef57196c3b7120ff4b8ce71207f3bf8..03272fe95fa66d535094adf4b4df92da53d5c417 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4767,6 +4767,10 @@ static int vxlan_netdevice_event(struct notifier_block *unused,
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
index e4ceca925bde7bea909bd691fa0f4ebfebdefbd3..74d713717cd5da267fc0aef9812593b5ed3ef37e 100644
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
index fad7c76418e929866c5c48431b08d179909f5931..93fca54749e76da8ae1ad1c15c0461a35d0ee194 100644
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
@@ -570,8 +586,11 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
 	if (ret)
 		goto out;
 
-	if (group)
+	if (group) {
 		memcpy(&vninode->remote_ip, group, sizeof(vninode->remote_ip));
+		if (!create)
+			vxlan_vnifilter_seq_inc(dev_net(vxlan->dev));
+	}
 
 	if (vxlan->dev->flags & IFF_UP) {
 		if (vxlan_addr_multicast(&old_remote_ip) &&
@@ -716,7 +735,8 @@ static int vxlan_vni_update(struct vxlan_dev *vxlan,
 	return 0;
 }
 
-static void __vxlan_vni_add_list(struct vxlan_vni_group *vg,
+static void __vxlan_vni_add_list(struct vxlan_dev *vxlan,
+				 struct vxlan_vni_group *vg,
 				 struct vxlan_vni_node *v)
 {
 	struct list_head *headp, *hpos;
@@ -732,13 +752,16 @@ static void __vxlan_vni_add_list(struct vxlan_vni_group *vg,
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
@@ -800,7 +823,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 		return err;
 	}
 
-	__vxlan_vni_add_list(vg, vninode);
+	__vxlan_vni_add_list(vxlan, vg, vninode);
 
 	if (vxlan->dev->flags & IFF_UP)
 		vxlan_vs_add_del_vninode(vxlan, vninode, false);
@@ -846,7 +869,7 @@ static int vxlan_vni_del(struct vxlan_dev *vxlan,
 	if (err)
 		goto out;
 
-	__vxlan_vni_del_list(vg, vninode);
+	__vxlan_vni_del_list(vxlan, vg, vninode);
 
 	vxlan_vnifilter_notify(vxlan, vninode, RTM_DELTUNNEL);
 
@@ -960,7 +983,7 @@ void vxlan_vnigroup_uninit(struct vxlan_dev *vxlan)
 #if IS_ENABLED(CONFIG_IPV6)
 		hlist_del_init_rcu(&v->hlist6.hlist);
 #endif
-		__vxlan_vni_del_list(vg, v);
+		__vxlan_vni_del_list(vxlan, vg, v);
 		vxlan_vnifilter_notify(vxlan, v, RTM_DELTUNNEL);
 		call_rcu(&v->rcu, vxlan_vni_node_rcu_free);
 	}
-- 
2.55.0.1082.g2b9226bbc0-goog

