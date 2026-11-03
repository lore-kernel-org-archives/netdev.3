Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748423;
	b=Pp+9fMk8z/kUtlUE6Bgzl/wTsHA8Fojszc7LinchlUI56HfCG7dGbWOFoV5SngrhdMZI
	 KF0NBLI3qLjnloiNYPDbgV+Y+fagNXwqafGMm5ucpYetzSHQczGoRxIV6akHmE6Fwkscd
	 QavJs+De2a4d2AOT9G2cHuXh/0sqXXzegwg0jbPmBqyxJAxDXvAv+EHsp5dLONhrdHt2h
	 0N1m3fu5z1gEJORTEJYPWdKNlCWIUM6nQGkSc3UdbNZq0nER9f5wEIQBLck7tQVs6tGxk
	 QJr15CqkIacRN+/VyY5U0n/m9HP+3OawYNDYxlbOriHCZPy5L24GQk5gSnhj5uhc32A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=KuNOUjrT0Ji+4e7P5P3kAfAGchqzwfm6lwHBl7AyDvc=;
	b=BC1/Ptla3KzmXW39C+PB8oKYyFsepfxbjtHG8kQ+9OAUUs7qk0OQiB/MkTM5qL+e7ASq
	 BnIerttTpmwSOk9/Nh1DatWoq98Rl0030HqVRFQ/pGOQGNKqdnrSQ/kGvbz7gSc7q3qzy
	 DLEsNZih8e1t8MZ+JuutFfgeWOe3QarCV3v8RGf3MQPekasvtN7rwoXw4MM7JWZoTdpaP
	 KWYxydRFB+5ggTyQYVQ5XGRizlBMWhITA5+bPDyCPMzpjNgp2kuYysQTnevYZJ6RdzlQt
	 /frmWJVQNgN2a4EbY+13OD8PwomzT+O0umg/zjZqPBaxgaxuVZdiV/ltX7BNkIVOyAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="L11/Ma7m";
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC9A606A336
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BC9A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L11/Ma7m
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso111618eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793748422; x=1794353222; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KuNOUjrT0Ji+4e7P5P3kAfAGchqzwfm6lwHBl7AyDvc=;
        b=L11/Ma7mlVPQmiF9RnJxvhAl+R6q45n3dr5j9X37b70Cfa0hij25Jx20J6xEHTuWEN
         GK/I66RKdAmXvJNzlsL+KklCLwbFkK++MFO7hlxSjEDRAcFb8BwXwN2pVOWtIRVAbOex
         TfAuWmywcsQ6ejwNpHRc+20miXSVppOWkd1IHiK1NwIt0ONaORp2YCm5gHz61V0Tqwzx
         mr32FXO8lUsumWuAhBHNxbBtdlYBM5j0u1L2uiA9Ba7Pr6zQ8LuGOJVGrB4VRiv5dham
         oZcds99mc2ZAhWK+kABqKxWxMI73VKNLNZf/xUxZGx091WwRSecltmoERHzbLRZURetF
         uDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793748422; x=1794353222;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KuNOUjrT0Ji+4e7P5P3kAfAGchqzwfm6lwHBl7AyDvc=;
        b=f/sxu917IlE7mRNWWmtgTw1bmXbSSdITkdrs4YVUo73hKPsVWJiCnaEShkZEl7bHdS
         1M8hoCqvfttb4IjjHpMwZmKfQzhLQx+E3e3PzS9uFCBRpTkAebxmzABN1TySu6XDI/2x
         puArTS7zY6hI32ig39wf7ndJNN8tUwKYfz2JJy4oorf1nEcJxc4aEY23GR/t5DRWskkf
         QXMs0PNE+t3ikCt6Xuo41RpEDWKhyk3y+9P5kupeKS0hftOWHDmryGC3+Zmf/iuY164J
         bRVl3Z2I95KSLNA4m6LhuFB+lkPP4N0opYw/Orf6IWTj0DyVLVM2AtvEMoM7VqXIpbjN
         gkgw==
X-Gm-Message-State: APuU4Z/eqaLWby1jRlzD3U/QRF4ageTYZkL23WsnH4hckarQ/ynwQ3HB
	Msi1T40UizU1iDugLcxu+V4YYnFWXwnZYp9hE7s7SZjjeKfJdtu1ynLvpoMlD8Sc1bYt76hXE0u
	GXF9DRJZetgURldefFS9k3i6+T7UndjJeJ/YCMXWze4zo24obAabtggrxyZHOYj/n7R24Y5vife
	vB3u7gb7ALRSNMCAIxSwlA+kLXSycLJ72aCHusWJJ8cj9jL4+wJu7J77krcCWcQjw=
X-Received: from dycnr12-n1.prod.google.com ([2002:a05:7300:e9cc:10b0:33e:5767:2163])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:87c6:10b0:367:5e31:ce29 with SMTP id 5a478bee46e88-36a42404ab3mr22807991eec.20.1793748421876;
 Tue, 03 Nov 2026 15:27:01 -0800 (PST)
Date: Tue,  3 Nov 2026 23:26:56 +0000
In-Reply-To: <20261103232659.1340283-1-almasrymina@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103232659.1340283-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103232659.1340283-2-almasrymina@google.com>
Subject: [PATCH net-next v1 1/4] net: devmem: pass net_device pointer to net_devmem_lock_dev()
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	David Wei <dw@davidwei.uk>
Content-Type: text/plain; charset="UTF-8"

Upcoming changes for leased queue support will track the physical DMA
device and the bound device in separate net_device pointers on struct
net_devmem_dmabuf_binding, with different teardown paths locking
different pointers.

Generalize net_devmem_lock_dev() to take a struct net_device **dev_ptr
instead of struct net_devmem_dmabuf_binding *. No functional change.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/devmem.c      | 36 ++++++++++++++++++------------------
 net/core/devmem.h      |  4 ++--
 net/core/netdev-genl.c |  2 +-
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 5c7d9640e9d14..f164c90e90b3b 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -85,39 +85,39 @@ net_devmem_dmabuf_binding_unmap(struct net_devmem_dmabuf_binding *binding)
 }
 
 /**
- * net_devmem_lock_dev() - lock a binding's net_device if still alive
- * @binding:		devmem binding whose @dev pointer to lock
+ * net_devmem_lock_dev() - lock a binding's net_device pointer if still alive
+ * @dev_ptr:		pointer to the net_device field on a devmem binding
  * @dev_tracker:	reftracker for the held net_device reference
  *
- * Safely dereference @binding->dev, acquire netdev_lock() on the device, and
- * verify that @binding->dev has not been cleared while waiting for the lock.
+ * Safely dereference @dev_ptr, acquire netdev_lock() on the device, and
+ * verify that *@dev_ptr has not been cleared while waiting for the lock.
  *
- * Invariant: @binding->dev is set once at bind time and is only ever cleared to
- * NULL while holding netdev_lock(dev) (in mp_dmabuf_devmem_uninstall(),
- * net_devmem_unbind_dmabuf(), or net_devmem_dev_unregister() during
- * NETDEV_UNREGISTER before synchronize_net() and netdev_run_todo() free the
- * net_device).
+ * Invariant: *@dev_ptr is set once at bind time and is only ever cleared to
+ * NULL while holding netdev_lock() on that device (in
+ * mp_dmabuf_devmem_uninstall(), net_devmem_unbind_dmabuf(), or
+ * net_devmem_dev_unregister() during NETDEV_UNREGISTER before
+ * synchronize_net() and netdev_run_todo() free the net_device).
  *
- * Taking rcu_read_lock() guarantees that a non-NULL @dev read from
- * @binding->dev has not yet completed unregister_netdevice_many_notify()
+ * Taking rcu_read_lock() guarantees that a non-NULL device read from
+ * *@dev_ptr has not yet completed unregister_netdevice_many_notify()
  * (which waits for an RCU grace period via synchronize_net() after
  * NETDEV_UNREGISTER before freeing the net_device), so netdev_hold() can
  * safely acquire a reference before sleeping on netdev_lock(). Once
- * netdev_lock(dev) is held, re-checking that READ_ONCE(binding->dev) == dev
- * guarantees that the device has not yet been detached from @binding and
+ * netdev_lock() is held, re-checking that READ_ONCE(*dev_ptr) == dev
+ * guarantees that the device has not yet been detached from the binding and
  * cannot finish unregistering until net_devmem_unlock_dev().
  *
- * Return: The locked and held net_device if @binding->dev is still non-NULL,
+ * Return: The locked and held net_device if *@dev_ptr is still non-NULL,
  * or NULL if already cleared.
  */
 struct net_device *
-net_devmem_lock_dev(struct net_devmem_dmabuf_binding *binding,
+net_devmem_lock_dev(struct net_device **dev_ptr,
 		    netdevice_tracker *dev_tracker)
 {
 	struct net_device *dev;
 
 	rcu_read_lock();
-	dev = READ_ONCE(binding->dev);
+	dev = READ_ONCE(*dev_ptr);
 	if (!dev) {
 		rcu_read_unlock();
 		return NULL;
@@ -126,7 +126,7 @@ net_devmem_lock_dev(struct net_devmem_dmabuf_binding *binding,
 	rcu_read_unlock();
 
 	netdev_lock(dev);
-	if (READ_ONCE(binding->dev) != dev) {
+	if (READ_ONCE(*dev_ptr) != dev) {
 		netdev_unlock(dev);
 		netdev_put(dev, dev_tracker);
 		return NULL;
@@ -157,7 +157,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 		     binding->area.num_niovs, binding->free_count);
 
 	kvfree(binding->area.niovs);
-	dev = net_devmem_lock_dev(binding, &dev_tracker);
+	dev = net_devmem_lock_dev(&binding->dev, &dev_tracker);
 	net_devmem_dmabuf_binding_unmap(binding);
 	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
 	net_devmem_unlock_dev(dev, &dev_tracker);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index c4f476947dfaa..c0aaba0041ff6 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -100,7 +100,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       struct netlink_ext_ack *extack);
 struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
 struct net_device *
-net_devmem_lock_dev(struct net_devmem_dmabuf_binding *binding,
+net_devmem_lock_dev(struct net_device **dev_ptr,
 		    netdevice_tracker *dev_tracker);
 void net_devmem_unlock_dev(struct net_device *dev,
 			   netdevice_tracker *dev_tracker);
@@ -189,7 +189,7 @@ static inline struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id)
 }
 
 static inline struct net_device *
-net_devmem_lock_dev(struct net_devmem_dmabuf_binding *binding,
+net_devmem_lock_dev(struct net_device **dev_ptr,
 		    netdevice_tracker *dev_tracker)
 {
 	return NULL;
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 9c5bf17b04e57..2826f7e328340 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1476,7 +1476,7 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
 
 	mutex_lock(&priv->lock);
 	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
-		dev = net_devmem_lock_dev(binding, &dev_tracker);
+		dev = net_devmem_lock_dev(&binding->dev, &dev_tracker);
 		net_devmem_unbind_dmabuf(binding);
 		net_devmem_unlock_dev(dev, &dev_tracker);
 	}
-- 
2.56.0.385.gac671c819a-goog

