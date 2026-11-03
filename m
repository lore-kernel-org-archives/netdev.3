Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748426;
	b=UvV5+afRNRlHRsFrlTO9I08PQLtwi2pYLl57HNwFWZXA1LtMntV1VA/kbJPPsfR01WNS
	 eeSBsfje1GZdJwfR/TA8Z0LwBgHkwU9GRC9qucOfclhj2NNOrslEhDdepKVEKNfg4BdC2
	 q68l4Pn2F/Ye7xKFxrq784bhyOL+d031PUWe+PkZFgBdalkW8v/gw4ZjCog1FEwNC10z4
	 crZKTiDlcq05/bpeN8z27NayCmjmwHikvlYgQ83sLmTmh48iHl2WtW8UW1AHISEjOt78K
	 lS2oV3qRTzEwkAZaUIOEj9aTw3kpQjKOIKaLdlIlCkUqwbASGi+os4ZsTHRyBqyNbUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=67qlPsTo4dWGVmCkvUefy90uCuvvs541Z4IOqgSTuFE=;
	b=yNmlHHoAzo72MTlwoTQTAsWRlZYkFAtOMU1dPObMW+1qOUl4FEy2oLAR6QZ8iG+owyNg
	 Iz0prnMbyFJtwYMIngKszRqs54C3uwLanCxnI0y0bpyVNsQcYtunIFURhqKPIWMK0AIv0
	 lOAblijwHtHo0BJ0kGKVE/I6aP4SsqJwHxdxmhVj3OwLCK5U5rwFmSX0lhD2IPQFUfS0W
	 bsdW2zxsTMdDNTyXDs01CwhLGmM16RZMjMDzHXe7oNHRNpiP+6peEOwU8lb10qSWkeTK+
	 f+zCIVIuHygW83DU+c6nbM8V9gl+rf3qJaZ/80POH7Cg4C/XtxTagH/qClraNPKJQzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bKS6PFVU;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FD9606D802
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69FD9606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bKS6PFVU
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1acbaf81bebso206469c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793748425; x=1794353225; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67qlPsTo4dWGVmCkvUefy90uCuvvs541Z4IOqgSTuFE=;
        b=bKS6PFVU+KOZmDnGkwyVy04kNa6bnan7HKH6gdujHOaAfjnRIFAFx5tItW0YENf6RX
         owUwQ4tKZ+CAMQHs8sd3abNDNK4IT0N7UArIzshZ7fhR50Aw+QO23wR8rbOcHkBLFdak
         DD1ibcYn/2SnnDrO9i8dYvMyvdlkb2z6BketA1ToNWGxkQM9aMQCEnKF4ulDgLwJqyrl
         C2aq1t3mvz5Cu+7NiXROmYamwE3izjho+Hh6WSlf67QJ0PAoiaa3jEsN0SoM5c8w3xKn
         2Xaabge3v1Tl+UoNnuFOg/ccd/tDJZ8opsGWiB2PKMeGp+XN4Lgqj8Os9dM7NkU6jb9y
         db2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793748425; x=1794353225;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=67qlPsTo4dWGVmCkvUefy90uCuvvs541Z4IOqgSTuFE=;
        b=W9D4pj4Uua+xj7tPkCXPS4swXaK/akg3d8Mu9ryT0IxHDXnVbWxQLcjHH5MPmP9tVx
         tWw2fHtpcL5f13wjs4oeWJfqnwkUEFhOkYQdAt3HEcYl0wEExRYPsgjuvDX/C0Ihu28Q
         mSezSNbna1vX7BNNo/9ikGwzDUH1rV2nu53IPz8AXv35vuDWYUtYgbcUvSIPSICILpiG
         m7b4kaYPCZr8dR8tKQGvEfVIDxBT+y9j64duB5ddQH+SoDHPHXf+owS9AbIV4ybMabXx
         Sar/ha2fujSMQ3vcmEfhN6s3O1Yc3ljz5VDKKbtQ0S+I2xgK31G3MweXakY3G1vQfKIB
         oOTA==
X-Gm-Message-State: APuU4Z9M04Vwaxel9jgQg0GmlNQVg0nMJd8fbcyqYxphW/gTJduRlOlj
	CuNxEV+4B6+3o8GeAGB/AysNga6wiPf4Yi6Zq/iUDRYjR1WoWmA9LAyNO/4JVBx4UpFn5lgDovy
	Gi8aZ+aFa0iVNutd5KMLPaHYo+igfuBTcISgenc9C3iDtgwV4t01Gjlzj7bZgm6ogcsMJlxJP5T
	MSAfJPSYOL38USuOnMGmZpT1BVqohJ0WHmItQs5Eypg4fU0C2e9yV20J2C6wHmeSQ=
X-Received: from dlbps12.prod.google.com ([2002:a05:7023:88c:b0:19b:58fb:b643])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:b059:20b0:1ad:3402:733f with SMTP id a92af1059eb24-1ad3420f9a1mr21152960c88.44.1793748424117;
 Tue, 03 Nov 2026 15:27:04 -0800 (PST)
Date: Tue,  3 Nov 2026 23:26:58 +0000
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
Message-ID: <20261103232659.1340283-4-almasrymina@google.com>
Subject: [PATCH net-next v1 3/4] net: devmem: support leased queues on netdev unregister
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

Previously, bind_dev was only populated when bind-tx was called on a
virtual netdev (where map_dev != netdev), and leased RX bindings stored
the virtual netdev in map_dev without tracking the physical backing
netdev at all. Unregistering either the virtual device or the physical
backing device while a leased RX or TX devmem binding was active failed
to detach the dma-buf cleanly.

Always populate both device pointers on struct
net_devmem_dmabuf_binding:
- map_dev: the physical net_device whose dma_dev holds the DMA mapping
  (resolved from leased RX queues in netdev_nl_get_dma_dev(), with its
  netdev_lock held across net_devmem_bind_dmabuf()).
- bind_dev: the net_device the user called bind-rx or bind-tx on (equal
  to map_dev for direct bindings, or the virtual device for leased
  bindings).

With both pointers tracked on all bindings, handle socket teardown,
queue uninstall, and netdev unregistration in either order (bind_dev
first or map_dev first):
- Lock &binding->bind_dev during socket teardown in
  netdev_nl_sock_priv_destroy(), close and erase bound_rxqs via
  binding->bind_dev in net_devmem_unbind_dmabuf(), and require
  binding->map_dev to remain non-NULL in net_devmem_get_binding().
- Clear binding->bind_dev in mp_dmabuf_devmem_uninstall() once
  bound_rxqs is empty, leaving unleased bindings mapped until the
  binding is freed or map_dev is unregistered.
- In net_devmem_dev_unregister(dev), if binding->bind_dev == dev, clear
  NET_DEVMEM_BINDING_LIVE and clear binding->bind_dev if bound_rxqs is
  empty or dev is not a queue leasee; if binding->map_dev == dev, clear
  NET_DEVMEM_BINDING_LIVE, unmap the dmabuf, and clear binding->map_dev.
- Reject new bindings and RX queue opens in net_devmem_bind_dmabuf() and
  __netif_mp_open_rxq() if bind_dev or map_dev is no longer
  NETREG_REGISTERED.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/devmem.c          | 85 +++++++++++++++++++++-----------------
 net/core/devmem.h          |  8 ++--
 net/core/netdev-genl.c     | 33 ++++++++++-----
 net/core/netdev_rx_queue.c |  5 +++
 4 files changed, 79 insertions(+), 52 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6446355e787d4..1d6b89f196e02 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -86,7 +86,7 @@ net_devmem_dmabuf_binding_unmap(struct net_devmem_dmabuf_binding *binding)
 
 /**
  * net_devmem_lock_dev() - lock a binding's net_device pointer if still alive
- * @dev_ptr:		pointer to the net_device field on a devmem binding
+ * @dev_ptr:		pointer to &binding->map_dev or &binding->bind_dev
  * @dev_tracker:	reftracker for the held net_device reference
  *
  * Safely dereference @dev_ptr, acquire netdev_lock() on the device, and
@@ -95,17 +95,18 @@ net_devmem_dmabuf_binding_unmap(struct net_devmem_dmabuf_binding *binding)
  * Invariant: *@dev_ptr is set once at bind time and is only ever cleared to
  * NULL while holding netdev_lock() on that device (in
  * mp_dmabuf_devmem_uninstall(), net_devmem_unbind_dmabuf(), or
- * net_devmem_dev_unregister() during NETDEV_UNREGISTER before
- * synchronize_net() and netdev_run_todo() free the net_device).
+ * net_devmem_dev_unregister(), all before synchronize_net() and
+ * netdev_run_todo() free the net_device).
  *
  * Taking rcu_read_lock() guarantees that a non-NULL device read from
  * *@dev_ptr has not yet completed unregister_netdevice_many_notify()
  * (which waits for an RCU grace period via synchronize_net() after
- * NETDEV_UNREGISTER before freeing the net_device), so netdev_hold() can
- * safely acquire a reference before sleeping on netdev_lock(). Once
- * netdev_lock() is held, re-checking that READ_ONCE(*dev_ptr) == dev
- * guarantees that the device has not yet been detached from the binding and
- * cannot finish unregistering until net_devmem_unlock_dev().
+ * NETDEV_UNREGISTER and ndo_uninit before freeing the net_device), so
+ * netdev_hold() can safely acquire a reference before sleeping on
+ * netdev_lock(). Once netdev_lock() is held, re-checking that
+ * READ_ONCE(*dev_ptr) == dev guarantees that the device has not yet been
+ * detached from the binding and cannot finish unregistering until
+ * net_devmem_unlock_dev().
  *
  * Return: The locked and held net_device if *@dev_ptr is still non-NULL,
  * or NULL if already cleared.
@@ -219,22 +220,24 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	if (binding->list.next)
 		list_del(&binding->list);
 
-	xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
-		const struct pp_memory_provider_params mp_params = {
-			.mp_priv	= binding,
-			.mp_ops		= &dmabuf_devmem_ops,
-		};
+	if (binding->bind_dev) {
+		xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
+			const struct pp_memory_provider_params mp_params = {
+				.mp_priv	= binding,
+				.mp_ops		= &dmabuf_devmem_ops,
+			};
 
-		rxq_idx = get_netdev_rx_queue_index(rxq);
+			xa_erase(&binding->bound_rxqs, xa_idx);
+			rxq_idx = get_netdev_rx_queue_index(rxq);
 
-		if (netif_mp_close_rxq(binding->map_dev, rxq_idx, &mp_params))
-			busy = true;
-	}
+			if (netif_mp_close_rxq(binding->bind_dev, rxq_idx,
+					       &mp_params))
+				busy = true;
+		}
 
-	if (binding->direction == DMA_FROM_DEVICE && binding->map_dev &&
-	    !busy) {
-		net_devmem_dmabuf_binding_unmap(binding);
-		WRITE_ONCE(binding->map_dev, NULL);
+		if (binding->direction == DMA_FROM_DEVICE && !busy)
+			net_devmem_dmabuf_binding_unmap(binding);
+		WRITE_ONCE(binding->bind_dev, NULL);
 	}
 
 	percpu_ref_kill(&binding->ref);
@@ -252,24 +255,20 @@ void net_devmem_dev_unregister(struct net_device *dev)
 
 	xa_lock(&net_devmem_dmabuf_bindings);
 	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
-		if (binding->direction == DMA_FROM_DEVICE) {
-			if (READ_ONCE(binding->map_dev) != dev ||
-			    xa_get_mark(&net_devmem_dmabuf_bindings, xa_idx,
-					NET_DEVMEM_BINDING_LIVE))
-				continue;
-		} else {
-			if (READ_ONCE(binding->bind_dev) == dev)
-				WRITE_ONCE(binding->bind_dev, NULL);
-			if (READ_ONCE(binding->map_dev) != dev)
-				continue;
-			WRITE_ONCE(binding->bind_dev, NULL);
+		if (READ_ONCE(binding->bind_dev) == dev) {
 			__xa_clear_mark(&net_devmem_dmabuf_bindings, xa_idx,
 					NET_DEVMEM_BINDING_LIVE);
+			if (xa_empty(&binding->bound_rxqs) ||
+			    !netif_is_queue_leasee(dev))
+				WRITE_ONCE(binding->bind_dev, NULL);
 		}
+		if (READ_ONCE(binding->map_dev) != dev)
+			continue;
 
+		__xa_clear_mark(&net_devmem_dmabuf_bindings, xa_idx,
+				NET_DEVMEM_BINDING_LIVE);
 		xa_unlock(&net_devmem_dmabuf_bindings);
-		if (!netif_is_queue_leasee(dev))
-			net_devmem_dmabuf_binding_unmap(binding);
+		net_devmem_dmabuf_binding_unmap(binding);
 		xa_lock(&net_devmem_dmabuf_bindings);
 		WRITE_ONCE(binding->map_dev, NULL);
 	}
@@ -324,6 +323,15 @@ net_devmem_bind_dmabuf(struct net_device *map_dev,
 	size_t i;
 	long err;
 
+	netdev_assert_locked(bind_dev);
+	netdev_assert_locked(map_dev);
+
+	if (bind_dev->reg_state != NETREG_REGISTERED ||
+	    map_dev->reg_state != NETREG_REGISTERED) {
+		NL_SET_ERR_MSG(extack, "Device is being unregistered");
+		return ERR_PTR(-ENODEV);
+	}
+
 	if (!dma_dev) {
 		NL_SET_ERR_MSG(extack, "Device doesn't support DMA");
 		return ERR_PTR(-EOPNOTSUPP);
@@ -560,9 +568,9 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	 * net_device.
 	 */
 	dst_dev = dst_dev_rcu(dst);
-	if (unlikely(!dst_dev) ||
-	    unlikely(dst_dev != READ_ONCE(binding->map_dev) &&
-		     dst_dev != READ_ONCE(binding->bind_dev))) {
+	if (unlikely(!dst_dev || !READ_ONCE(binding->map_dev) ||
+		     (dst_dev != READ_ONCE(binding->map_dev) &&
+		      dst_dev != READ_ONCE(binding->bind_dev)))) {
 		err = -ENODEV;
 		goto out_unlock;
 	}
@@ -686,8 +694,7 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
 		if (xa_empty(&binding->bound_rxqs)) {
 			if (!rxq->lease)
 				net_devmem_dmabuf_binding_unmap(binding);
-			ASSERT_EXCLUSIVE_WRITER(binding->map_dev);
-			WRITE_ONCE(binding->map_dev, NULL);
+			WRITE_ONCE(binding->bind_dev, NULL);
 		}
 		break;
 	}
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 9dcb629e10bfd..ff431e5e398e0 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -25,8 +25,10 @@ struct net_devmem_dmabuf_binding {
 	 * time and cleared to NULL under netdev_lock(map_dev).
 	 */
 	struct net_device *map_dev;
-	/* Device the user called bind-rx or bind-tx on. Set at bind time and
-	 * cleared to NULL on unregistration.
+	/* Device the user called bind-rx or bind-tx on. Equal to map_dev for
+	 * direct bindings, or the virtual device (e.g. netkit) for leased
+	 * bindings. Set at bind time and cleared to NULL under
+	 * netdev_lock(bind_dev).
 	 */
 	struct net_device *bind_dev;
 	possible_net_t net;
@@ -44,7 +46,7 @@ struct net_devmem_dmabuf_binding {
 	 * those refs are dropped and the binding is no longer desired or in
 	 * use. RX bindings are unmapped earlier when their queues are closed or
 	 * uninstalled, unless a leased or busy queue may still use the binding.
-	 * TX bindings are also unmapped earlier if their device is
+	 * Both RX and TX bindings are also unmapped earlier if map_dev is
 	 * unregistered.
 	 *
 	 * net_devmem_net_iov_inc_ref() on dmabuf net_iovs will increment this
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 962d7a8c75e9a..442362f23fe88 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1005,12 +1005,15 @@ static int netdev_nl_read_rxq_bitmap(struct genl_info *info,
 
 static struct device *
 netdev_nl_get_dma_dev(struct net_device *netdev, unsigned long *rxq_bitmap,
+		      struct net_device **map_dev,
 		      struct netlink_ext_ack *extack)
 {
 	struct device *dma_dev = NULL;
 	u32 rxq_idx, prev_rxq_idx;
 
+	*map_dev = netdev;
 	for_each_set_bit(rxq_idx, rxq_bitmap, netdev->real_num_rx_queues) {
+		struct netdev_rx_queue *rxq;
 		struct device *rxq_dma_dev;
 
 		rxq_dma_dev = netdev_queue_get_dma_dev(netdev, rxq_idx,
@@ -1023,6 +1026,11 @@ netdev_nl_get_dma_dev(struct net_device *netdev, unsigned long *rxq_bitmap,
 
 		dma_dev = rxq_dma_dev;
 		prev_rxq_idx = rxq_idx;
+		if (netif_rxq_is_leased(netdev, rxq_idx) &&
+		    netif_is_queue_leasee(netdev)) {
+			rxq = __netif_get_rx_queue(netdev, rxq_idx);
+			*map_dev = rxq->lease->dev;
+		}
 	}
 
 	return dma_dev;
@@ -1032,9 +1040,9 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net_devmem_dmabuf_binding *binding;
 	unsigned int niov_shift = PAGE_SHIFT;
+	struct net_device *netdev, *map_dev;
 	u32 ifindex, dmabuf_fd, rxq_idx;
 	struct netdev_nl_sock *priv;
-	struct net_device *netdev;
 	unsigned long *rxq_bitmap;
 	struct device *dma_dev;
 	struct sk_buff *rsp;
@@ -1104,15 +1112,21 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto err_rxq_bitmap;
 
-	dma_dev = netdev_nl_get_dma_dev(netdev, rxq_bitmap, info->extack);
+	dma_dev = netdev_nl_get_dma_dev(netdev, rxq_bitmap, &map_dev,
+					info->extack);
 	if (IS_ERR(dma_dev)) {
 		err = PTR_ERR(dma_dev);
 		goto err_rxq_bitmap;
 	}
 
-	binding = net_devmem_bind_dmabuf(netdev, NULL, dma_dev, DMA_FROM_DEVICE,
-					 dmabuf_fd, niov_shift, priv,
-					 NETLINK_CB(skb).sk, info->extack);
+	if (map_dev != netdev)
+		netdev_lock(map_dev);
+	binding = net_devmem_bind_dmabuf(map_dev, netdev, dma_dev,
+					 DMA_FROM_DEVICE, dmabuf_fd,
+					 niov_shift, priv, NETLINK_CB(skb).sk,
+					 info->extack);
+	if (map_dev != netdev)
+		netdev_unlock(map_dev);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_rxq_bitmap;
@@ -1257,10 +1271,9 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 
 	dma_dev = netdev_queue_get_dma_dev(map_dev, 0, NETDEV_QUEUE_TYPE_TX);
 
-	binding = net_devmem_bind_dmabuf(map_dev,
-					 map_dev != netdev ? netdev : NULL,
-					 dma_dev, DMA_TO_DEVICE, dmabuf_fd,
-					 PAGE_SHIFT, priv, NETLINK_CB(skb).sk,
+	binding = net_devmem_bind_dmabuf(map_dev, netdev, dma_dev,
+					 DMA_TO_DEVICE, dmabuf_fd, PAGE_SHIFT,
+					 priv, NETLINK_CB(skb).sk,
 					 info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
@@ -1475,7 +1488,7 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
 
 	mutex_lock(&priv->lock);
 	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
-		dev = net_devmem_lock_dev(&binding->map_dev, &dev_tracker);
+		dev = net_devmem_lock_dev(&binding->bind_dev, &dev_tracker);
 		net_devmem_unbind_dmabuf(binding);
 		net_devmem_unlock_dev(dev, &dev_tracker);
 	}
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index a7261fedd5e76..5f65b9bbfc369 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -193,6 +193,11 @@ static int __netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 	struct netdev_rx_queue *rxq;
 	int ret;
 
+	if (dev->reg_state != NETREG_REGISTERED) {
+		NL_SET_ERR_MSG(extack, "Device is being unregistered");
+		return -ENODEV;
+	}
+
 	if (!qops)
 		return -EOPNOTSUPP;
 
-- 
2.56.0.385.gac671c819a-goog

