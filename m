Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65203B5854
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942230; cv=none; b=K4jJvfS6EAH1SMLujyA6SK3GqofhQftN7RlPGyp//AK7+TVTzxk8mGuqH3GjVl43TyeHIGwp76zhb+UYvE4LG/tFO9bZLCM3vg8TFdrhsuojDvUd8UKjDhNiqrxH5OrTffhECPABqXAW+p/NXWt0UvDcYw2ZZwzlGd1zrPwtjGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942230; c=relaxed/simple;
	bh=O/kDYBX4hwxPfnqXPuuVIyu3fN1YOOFmpR95YLyF0rs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RC678UeQ25oIs4DLOBQfd5e/eW85DDjpRZWnFooNlJpDqI94K54mH/Qrb/bth4LmN+TMLHaiJ6mtaY1NxCCQJnqiSz+8p4ihhbak/5VvuRcY6fdxfK9vptt/Deypvm99JA9GOiwARMzgfkE8nbXtjrlMSoaHkW2mquE4NpjgJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtwkVH3/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtwkVH3/"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c82843005eso14868195ad.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942228; x=1783547028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BXRrqIrrIJVBrBWa0Ccyc+qAlQpIKuEVIV9AmMqga8c=;
        b=dtwkVH3/jx5Kdkb+HX80maKQhq9b2A4gexpBaRw2d3U+dcZr2FR5XYTVFMxIMIcFho
         szhns5EQgGi25Mza8xQH4yWPbuW9uZINgsMJKdOhcMJ33X391+OwYsUN2L/a9LnHh2Sw
         x2o7VCduZUJ/Pz+LouLNkx/PlxN0ijNoLKTyFGnJtoMU8lS7M3WjBD4q8u1lGdW/Urmf
         vZa0WycIGWSPxgFY6QykQcUu/DqR2OJKb1hXkSC7OHiz1mTSNm0kuJjDtu2XokYcdCzm
         OoZuZdUvU+LwkMmxaq8HV/6oHY+CGjxFODr9zvWiDbicotZ0p11HggUWNYYSbRDR8yB2
         3jbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942228; x=1783547028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXRrqIrrIJVBrBWa0Ccyc+qAlQpIKuEVIV9AmMqga8c=;
        b=F/DbwPYXOsQdmRbXoDY8FqjsWDfT9Ryd09u1YFjOP4QsIR+AOixGZHOyfWi8bb4VHl
         heWDsuywW1WG+kVlPo4wfGW3KFfpT6PFs3mq3u6p8kAaX9Vd7QYDS3uKnqbo1GqR/kEi
         CzFN3K5PkGrxkOpM6mv2E89mgTHSJEvGL6AG7+dKKf91H7DQpcYOjQNs2J5yKtblvwGg
         7yAva5Fd1dZm1668jM8fRpnUnxv26MWnDAxYlymCADLaFnIpwwHpNysyx43iPLtBJnnj
         qe4+cLFVaU1lEkHkWJSYiR0TOcP0FVv7MqpjmUoOgy8fSXiscA74blmLqmGL08/lonKT
         /a+w==
X-Forwarded-Encrypted: i=1; AHgh+Ro+2IP82o/87ZkYet2wDFAc4dPwRYAsxCMNAJCIlaf0+319Ltr2fZV5JkrPqFjfPMkSXsf/VL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlVd/mGfod6M6lVA6Y9VJut/dd7ZPu50hCQoPBVKxt+m8zvuae
	oDJWP3LydRXP/ZB92+II2mjS2ipXZkiki1eVMZyiEQqCc4I1SjLHxkCA0twPQtLDMfocCnJA3ag
	ykBAhzQ==
X-Received: from plbjg6.prod.google.com ([2002:a17:903:26c6:b0:2c7:e8d4:d218])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5ca:b0:2c9:97a9:209b
 with SMTP id d9443c01a7336-2ca91242f83mr20972465ad.47.1782942227859; Wed, 01
 Jul 2026 14:43:47 -0700 (PDT)
Date: Wed,  1 Jul 2026 21:41:44 +0000
In-Reply-To: <20260701214334.266991-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701214334.266991-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701214334.266991-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 06/14] net: Add per-netns netdev unregistration infra.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When we need to unregister a netdev in a different netns, we will
delegate its unregistration to per-netns work.

There are three types of such cross-netns devices:

  1. Paired devices (e.g., netkit, veth, vxcan)
     -> Unregistering one device also deletes its peer, which
        may reside in another netns.

  2. Tunnel devices (e.g., bareudp, geneve, etc)
     -> Destroying a netns removes devices in another netns if
        their backend sockets reside in the dying netns

  3. Stacked devices (e.g., ipvlan, macvlan, etc)
     -> Removing the lower device also removes multiple upper
        devices, each of which may reside in different namespaces.

In these cases, we will use unregister_netdevice_queue_net() to
queue such potential cross-netns devices for destruction.

unregister_netdevice_queue_net() takes net and dev.  If dev resides
in the net, it simply calls unregister_netdevice_queue().

If dev_net(dev) is different from the net, it enqueues the device
to dev_net(dev)->dev_unreg_head and schedules the per-netns work.

When __rtnl_net_unlock() is called from the per-netns work (or another
thread already holding the lock), unregister_netdevice_many_net()
collects the queued devices and calls unregister_netdevice_many()
to perform the actual unregistration.

During netns dismantle, rtnl_net_flush_workqueue() is called at the
end of default_device_exit_batch() to ensure that cross-netns
devices in the other alive netns are unregistered.

Once RTNL is removed, a device could be moved to another netns while
being queued to net->dev_unreg_head.

__dev_change_net_namespace() handles this race by acquiring
net->dev_unreg_lock of both the old and new netns after dev_set_net()
and moving the device between their dev_unreg_head lists.

Since dev_set_net() and unregister_netdevice_queue_net() are
synchronised by netdev_lock(), the device is either queued to the
old netns's dev_unreg_head and then moved, or queued directly to
the new netns.

Note that unregister_netdevice_move_net() does not need to call
rtnl_net_queue_work() because __dev_change_net_namespace() is
(supposed to be) called with rtnl_net_lock().  (Not all callers
hold it yet, but the race does not happen until all callers
are converted and RTNL is removed.)

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/netdevice.h   | 16 +++++++
 include/net/net_namespace.h |  2 +
 net/core/dev.c              | 85 +++++++++++++++++++++++++++++++++++++
 net/core/net_namespace.c    |  2 +
 net/core/rtnetlink.c        |  4 ++
 5 files changed, 109 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b5..53454db3611a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2241,6 +2241,9 @@ struct net_device {
 	struct list_head	dev_list;
 	struct list_head	napi_list;
 	struct list_head	unreg_list;
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+	struct list_head	unreg_list_net;
+#endif
 	struct list_head	close_list;
 	struct list_head	ptype_all;
 
@@ -3472,6 +3475,19 @@ static inline void unregister_netdevice(struct net_device *dev)
 	unregister_netdevice_queue(dev, NULL);
 }
 
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+void unregister_netdevice_queue_net(struct net *net, struct net_device *dev,
+				    struct list_head *head);
+void unregister_netdevice_many_net(struct net *net);
+#else
+static inline void unregister_netdevice_queue_net(struct net *net,
+						  struct net_device *dev,
+						  struct list_head *head)
+{
+	unregister_netdevice_queue(dev, head);
+}
+#endif
+
 int netdev_refcnt_read(const struct net_device *dev);
 void free_netdev(struct net_device *dev);
 
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index a989019af5f7..501af1999fe8 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -198,6 +198,8 @@ struct net {
 	/* Move to a better place when the config guard is removed. */
 	struct mutex		rtnl_mutex;
 	struct work_struct	rtnl_work;
+	struct list_head	dev_unreg_head;
+	spinlock_t		dev_unreg_lock;
 #endif
 #if IS_ENABLED(CONFIG_VSOCKETS)
 	struct netns_vsock	vsock;
diff --git a/net/core/dev.c b/net/core/dev.c
index 48818a194fa5..0f0bf65f5bf9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12092,6 +12092,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 
 	INIT_LIST_HEAD(&dev->napi_list);
 	INIT_LIST_HEAD(&dev->unreg_list);
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+	INIT_LIST_HEAD(&dev->unreg_list_net);
+#endif
 	INIT_LIST_HEAD(&dev->close_list);
 	INIT_LIST_HEAD(&dev->link_watch_list);
 	INIT_LIST_HEAD(&dev->adj_list.upper);
@@ -12485,6 +12488,16 @@ void unregister_netdevice_many_notify(struct list_head *head,
 	synchronize_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+		struct net *net = dev_net(dev);
+
+		/* spin_lock() can be moved outside of the loop
+		 * once the per-netns RTNL conversion completes.
+		 */
+		spin_lock(&net->dev_unreg_lock);
+		list_del(&dev->unreg_list_net);
+		spin_unlock(&net->dev_unreg_lock);
+#endif
 		netdev_put(dev, &dev->dev_registered_tracker);
 		net_set_todo(dev);
 		cnt++;
@@ -12507,6 +12520,72 @@ void unregister_netdevice_many(struct list_head *head)
 }
 EXPORT_SYMBOL(unregister_netdevice_many);
 
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+void unregister_netdevice_queue_net(struct net *net, struct net_device *dev,
+				    struct list_head *head)
+{
+	netdev_lock(dev);
+
+	if (net_eq(dev_net(dev), net)) {
+		netdev_unlock(dev);
+		unregister_netdevice_queue(dev, head);
+		return;
+	}
+
+	net = dev_net(dev);
+
+	spin_lock(&net->dev_unreg_lock);
+
+	DEBUG_NET_WARN_ON_ONCE(!list_empty(&dev->unreg_list_net));
+	list_add_tail(&dev->unreg_list_net, &net->dev_unreg_head);
+	rtnl_net_queue_work(net);
+
+	spin_unlock(&net->dev_unreg_lock);
+
+	netdev_unlock(dev);
+}
+EXPORT_SYMBOL(unregister_netdevice_queue_net);
+
+static void unregister_netdevice_move_net(struct net *net_old,
+					  struct net *net,
+					  struct net_device *dev)
+{
+	if (net_old > net) {
+		spin_lock(&net->dev_unreg_lock);
+		spin_lock(&net_old->dev_unreg_lock);
+	} else {
+		spin_lock(&net_old->dev_unreg_lock);
+		spin_lock(&net->dev_unreg_lock);
+	}
+
+	if (!list_empty(&dev->unreg_list_net)) {
+		list_del(&dev->unreg_list_net);
+		list_add_tail(&dev->unreg_list_net, &net->dev_unreg_head);
+	}
+
+	spin_unlock(&net_old->dev_unreg_lock);
+	spin_unlock(&net->dev_unreg_lock);
+}
+
+void unregister_netdevice_many_net(struct net *net)
+{
+	struct net_device *dev, *tmp;
+	LIST_HEAD(unreg_head_net);
+	LIST_HEAD(unreg_head);
+
+	spin_lock(&net->dev_unreg_lock);
+	list_splice_init(&net->dev_unreg_head, &unreg_head_net);
+	spin_unlock(&net->dev_unreg_lock);
+
+	list_for_each_entry_safe(dev, tmp, &unreg_head_net, unreg_list_net) {
+		list_del_init(&dev->unreg_list_net);
+		list_add_tail(&dev->unreg_list, &unreg_head);
+	}
+
+	unregister_netdevice_many(&unreg_head);
+}
+#endif
+
 /**
  *	unregister_netdev - remove device from the kernel
  *	@dev: device
@@ -12663,6 +12742,10 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	netdev_unlock(dev);
 	dev->ifindex = new_ifindex;
 
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+	unregister_netdevice_move_net(net_old, net, dev);
+#endif
+
 	if (new_name[0]) {
 		/* Rename the netdev to prepared name */
 		write_seqlock_bh(&netdev_rename_lock);
@@ -13105,6 +13188,8 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	}
 	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
+
+	rtnl_net_flush_workqueue();
 }
 
 static struct pernet_operations __net_initdata default_device_ops = {
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index d1aeff9de580..578b48cf5318 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -423,6 +423,8 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
 	mutex_init(&net->rtnl_mutex);
 	lock_set_cmp_fn(&net->rtnl_mutex, rtnl_net_lock_cmp_fn, NULL);
 	INIT_WORK(&net->rtnl_work, rtnl_net_work_func);
+	INIT_LIST_HEAD(&net->dev_unreg_head);
+	spin_lock_init(&net->dev_unreg_lock);
 #endif
 
 	INIT_LIST_HEAD(&net->ptype_all);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7959519e7375..544498d3c325 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -197,6 +197,7 @@ void __rtnl_net_unlock(struct net *net)
 {
 	ASSERT_RTNL();
 
+	unregister_netdevice_many_net(net);
 	mutex_unlock(&net->rtnl_mutex);
 }
 EXPORT_SYMBOL(__rtnl_net_unlock);
@@ -290,6 +291,9 @@ void rtnl_net_work_func(struct work_struct *work)
 {
 	struct net *net = container_of(work, struct net, rtnl_work);
 
+	if (list_empty(&net->dev_unreg_head))
+		return;
+
 	rtnl_net_lock(net);
 	rtnl_net_unlock(net);
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog

