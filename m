Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794117492;
	b=f9usBNE1ucv/H5Yya4vtXBAsLaVFrHhmkXioTcQuTVWxoTCEzv0jRdV3zgw9+GGMtCpD
	 +MLR1fiTFFH1/l1L19h8vZZ/yHgieeaLqRD0S+2iT8q8A3w79I2gF9zXIenyd2LdRwP6n
	 t5w9iZ43rg9XgbLzWbzIhyCotBucho4f9Cl6QXYXpBxRNFRP7mD2JYad3ccMaG0/7DrJV
	 OeXcSptsBVXHfE4ne2TJKj1YyCYRmSnT7V3QNAT3lVa9PnXPToSS3iCu1p2a2cQlPJoiB
	 rTvF6uL3HItilMSRk7jATzN4IhjiDH7rl7VC6kJKY5gF0LSm+V41COf+9NRGiFabWHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794117492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=u3RHHi7TQr+0R9mtfdFGqUwCh1WYEhpEvKebAIxrXYk=;
	b=t7fhycaY4MHNBZTBkXXHSoL4Y6i7q7jG/pf1Dhrova1mg/cVs8GPCi/WcC74iuyrcSeT
	 U+62pLwd5Q1wpuVdg0nUlaugRMRmJgrl1oKr5gWLVVw7uUuFeFY4ngiDVV4+S+1BIt+UV
	 FajtTTzg/26oEMoEaJ+8/6GKHL3vBjWOEcjYut7a93+wGfKGjxwteO2a8dS9wCnnSp5H0
	 0CYofaD9YXEu27aTfyZZSx5qo+P7ahbCqp0kWViNjkARBHbPMdOa14p+7ghTqYeCMS6nC
	 0sKrmm0SOTULfb/7SR3Fx9nmThFnaPJH4Wo0+FW7sT/Q+v1zvrs+ObbwokegQL2q9sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ioW9iYYW;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3EA606A326
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 05:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A3EA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ioW9iYYW
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso649714eec.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 21:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794117491; x=1794722291; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3RHHi7TQr+0R9mtfdFGqUwCh1WYEhpEvKebAIxrXYk=;
        b=ioW9iYYWMe5JoAQ+sUL6lY07mTIWSHoCgV1VCJTxQuUhJkaFRKjPAsztGrwOa0wp2C
         aTHRyeZbgp0UYd+2Z9OU2C8oN0UsWA0HFoGUl8zK8bFCDBIO7BWMkQf1/UV2cQCdSZV1
         xdAtuKP3D1j1OAifAhhAvpC4+7PDPRTl1HPoKnbIGXE8atEtnB6mlIGnZUJ3wYYI/t3l
         ntZVi/UW8aUNp8g78Gn6j+WXEKMDYu+m3U9bcQ+cxYveEwZlRomogDgzt4gHCaBJAaKl
         mjUNbHfZ+Z5Mqg5iir3jOdYMVxespOLfhgY1zGjJUkP9R3I6LdFMSnRYlTrztUWX/6P9
         UKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794117491; x=1794722291;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u3RHHi7TQr+0R9mtfdFGqUwCh1WYEhpEvKebAIxrXYk=;
        b=XwI2l6xQej4GRwfejgzPVbWBXLBbwQoYELpBVFWkFfNl61ZV7byf+7vK+4adzS8Im4
         HXLGp+zbMqwFHbTAH2hiGImcWhqbjbb8MDkfKmZ/v2zNx97qMk4wYHBkoRZ8XtD+WAlW
         n20Qi1BxmQtPz8e2zRBFMlAgii44dKMN5FTj2ph3Z6xUGYyqGG+En46OAaVm5eWbOreG
         jMQbxNBHz0yNeENY5j4kZoO3r617m45CaxHSxqHMDDdKw8R6vnEAP1GvTKQOcPCQRzN4
         HeePE3n/hZjXok5tP6Dr6pdxm4sH/7Be9cogm12FSV74TOiomrUQXPGH9L2xKcKsuL9m
         EE3Q==
X-Gm-Message-State: APuU4Z+fbdh4vSkRuf9VBDGTEZIoKtLfMkm2aVTNIbLWFFG0A016+FVn
	wsFDjpQJnkp8MAdd8XpYry43MwpsLV0UVcHzKQ5EW8u+H2y0xk/M9xbhDEYdtawak0DlbN/0Nug
	5g67t39sTtcrc+JFMt7QG94fe3ztpPoFjwSHCU6sGDA94GIqUqiMBufTNkkj0EFkJFiOzSdcyWm
	76PyxBYFiBekJSVJGJWoF30cf0tD9c/msVdEyy1RUFkyGb8cNZ/5ycrRPZskUhxSA=
X-Received: from dleg9.prod.google.com ([2002:a05:701b:4309:b0:1a3:1342:a32d])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:4247:10b0:1b2:6b1f:1d89 with SMTP id a92af1059eb24-1b39fec5b8bmr1093729c88.36.1794117490920;
 Sat, 07 Nov 2026 21:58:10 -0800 (PST)
Date: Sun,  8 Nov 2026 05:58:04 +0000
In-Reply-To: <20261108055809.2122934-1-almasrymina@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108055809.2122934-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108055809.2122934-2-almasrymina@google.com>
Subject: [PATCH net-next v2 1/6] net: devmem: pass net_device pointer to net_devmem_lock_dev()
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Upcoming changes for leased queue support will track the physical DMA
device and the bound device in separate net_device pointers on struct
net_devmem_dmabuf_binding, with different teardown paths locking
different pointers.

Generalize net_devmem_lock_dev() to take a struct net_device **dev_ptr
instead of struct net_devmem_dmabuf_binding *. No functional change.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
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
2.56.0.455.g6c5a503b38-goog

