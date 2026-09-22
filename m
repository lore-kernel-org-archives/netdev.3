Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E54B485CC7
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100672; cv=none; b=e7AZms1py6z8vAvjBVAHYf7KxHbPTWYGY9nvsN7DcHJ3E61v0MDmdQb/NWNufXVn7IhD5Aay+kw6uGdhddGpY9icPp3m66CBDtC70MuhnOgyiAgcaEm3R77pT/zvS4Re7mnq94wAFkCXIhc6VSvmxgUw+RxX+L7c8DVxV9ObreI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100672; c=relaxed/simple;
	bh=0kRjc6FxBaMLFdUDaQJFvGB9Pdpr2qQgo7MZeVPgnKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SsD5swD1xpbiWXrHkmtpBk8p5RxbbHg9wGdM6cwKuUZ7LNSij1VKG9o6wHE1MsQAg2S1Fghj3Tw6+RDQPnQzf5LvN3uHUN6008FdRN56Bx0soD+eJuqFi6fnlQZf53/Q15FxdQNMmXhsZwYX/J7sx5Yjjcv4nruc7U4kzHoS9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecfnp9MY; arc=none smtp.client-ip=209.85.221.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecfnp9MY"
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c7d2076f8aso1220694e0c.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790100669; x=1790705469; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fl22tpr9lCZ2+WzvZBQPRpAX9qFZvrcUB4NAOb1j2+4=;
        b=ecfnp9MYlnezBOCEKm8cUPpm08HC1wfLXBvzoACPxSt1zbqn8fde0A8a7RSCgKaUFz
         9vl/ZR3RHwj0mOaIo6BPmYZ1qyTO1VU4aItNIJUcnSIbwQgcbtJEJ0LKlDzdp0I1i58s
         olNhqoZJvQ1a8JUbV+5ujgQNzhZhpQdNbCHcCTn4I4Umwy+t22QiTsTmC7RUqyykDy8b
         c1xEuRGh2uc5/0rWuPEyAhb1V/evurllv5Qu0iraifhanqWnEZucUrLr7jaVMz+zSzBQ
         hglV0wEP43X+6KMkDOEfNUbcuk+C3cfLMzGR45kzxGMmj8+bbOVOUAp4S24SRnjcjJCA
         dJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790100669; x=1790705469;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fl22tpr9lCZ2+WzvZBQPRpAX9qFZvrcUB4NAOb1j2+4=;
        b=spfcWyzSvC20s2oUR20G9fyq7KyRLWd4m4AmxeEUkaQqQGrjAQwGSTO2HO4/PnfAcN
         tERGXPJJST7SD9t9VLfCS21AYd/HkD6JZAv2kdIutvfIKGNhZ/7wKcZFwcE+gplKM7n2
         ZEeQY5N778OPniWKyAS92gj7lA0FHf028r9OVrd9DxvRu4+WsW/ay0t7bs+XkCncVpBV
         8nxxZST8v05JVQjauje1NXwUWiPChDPetkAFi5V/SFOZpqLzWayvHo66nXy7MuIp3iA+
         d3uctcHaSo0JSc8LGSNrbFPdgghc7jPgueAyvstJ9QqWFsOaOggzsDqSUqj+9c/aK6qd
         oPgw==
X-Forwarded-Encrypted: i=1; AKwUvBwQjJshU0WNjtnlt0xD8w8xq8QSyDq5TMRtKT09gDD69g8u3JIuoYcZWaR7eAck9zwcWKI8KdQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nMECsc1w6nsYxST8Aao5eiBqxDqNXMMqlNT57Eu0uuixPoxJmZ
	lSzqo2LUEHmxsio9ur8XNRrw66vBctKE1k7h/3AtTyJhqmKqCnfloAMKVyn6H+tQC51bseM3FcL
	5dZxlPqzOlMmhOQ==
X-Received: from qto14.prod.google.com ([2002:a05:622a:a6ce:b0:532:9655:50be])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6122:120e:b0:5c9:a5b6:27b5 with SMTP id 71dfb90a1353d-5c9e368b4eemr3099558e0c.18.1790100668764;
 Tue, 22 Sep 2026 11:11:08 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:10:57 +0000
In-Reply-To: <20260922181102.3989489-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922181102.3989489-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922181102.3989489-4-edumazet@google.com>
Subject: [PATCH v6 net-next 3/8] vxlan: vnifilter: signal interrupted
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
index a2cede8b082ab90519c029c52e3cff9e018c2418..93a38e1b609a87bfc94865a462d5d5370fc02914 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4771,6 +4771,10 @@ static int vxlan_netdevice_event(struct notifier_block *unused,
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
index 0a04e8875f7dc4da66a01de8d0e99f82c75c1fdd..181a7614be5cdba41ac4281cebb17b93d99d15df 100644
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
@@ -571,8 +587,11 @@ static int vxlan_vni_update_group(struct vxlan_dev *vxlan,
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
@@ -719,7 +738,8 @@ static int vxlan_vni_update(struct vxlan_dev *vxlan,
 	return 0;
 }
 
-static void __vxlan_vni_add_list(struct vxlan_vni_group *vg,
+static void __vxlan_vni_add_list(struct vxlan_dev *vxlan,
+				 struct vxlan_vni_group *vg,
 				 struct vxlan_vni_node *v)
 {
 	struct list_head *headp, *hpos;
@@ -735,13 +755,16 @@ static void __vxlan_vni_add_list(struct vxlan_vni_group *vg,
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
@@ -803,7 +826,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 		return err;
 	}
 
-	__vxlan_vni_add_list(vg, vninode);
+	__vxlan_vni_add_list(vxlan, vg, vninode);
 
 	if (vxlan->dev->flags & IFF_UP)
 		vxlan_vs_add_del_vninode(vxlan, vninode, false);
@@ -849,7 +872,7 @@ static int vxlan_vni_del(struct vxlan_dev *vxlan,
 	if (err)
 		goto out;
 
-	__vxlan_vni_del_list(vg, vninode);
+	__vxlan_vni_del_list(vxlan, vg, vninode);
 
 	vxlan_vnifilter_notify(vxlan, vninode, RTM_DELTUNNEL);
 
@@ -963,7 +986,7 @@ void vxlan_vnigroup_uninit(struct vxlan_dev *vxlan)
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

