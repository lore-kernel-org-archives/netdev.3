Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5C446C1E
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458607; cv=none; b=Cx+FMIyEqt6Kobq1feszi0KIqLmU5VIsuqm4gz/STUiQElLY7dOQFbO2d9JZlFOg3NqVHemjzT7rjQ/amYJEN7wpXvWH7DemgPwoO+tk7Vo9VhZ7ATwPuYwnxkt5nLiha/f5QKjUvclCLJLKMvxr5WSYVGGpcmXM+kF2V9qWG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458607; c=relaxed/simple;
	bh=evjzPgUl5w+OYjZN80TUm9Di/FIQZfsvHFyZ3Izkkto=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=brHYDmDUSB3zhHT05oMkk03+sPHEWU5kk2XhALWEQEn8f6nf92RaV0wOevhRRdueiJDU9DfXssD7FDBJ1VmxHM1Xf3SHsQe7Ayl1hkVYWF8zeUDAJTp2gAVhkx6W7q2++5K3PPSf49TOkXg6f0IFQga6P7/7jTVsubLJHw3rPyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUW4Gnl7; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUW4Gnl7"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e048a801dso4446108b3a.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786458604; x=1787063404; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BKH+or6+JglRsvM43xQne0nZWJ1wnvkcrm15aO08CF8=;
        b=iUW4Gnl7Xmv9R+V14VlM0BnAom9qgpLIY4x08HlRHWAdcpWNjDI3iVt0TBMlxKVskT
         cvI7Lg7vl7Q2sBVVNlWrFAi5HpXoKqZh2yC95hj0S2mji0i9YYqJ0piD3xncZE3dt3E2
         GsIG5Jq7LRHmVnIDFZxVIdl6fIFQfa7/iRUzpPWBCFLNYYhbKMeg11FpbNilbjetFdj9
         r5knv3uLRw5ZSveaXd3bOvzeJVEeLzYwnXqNtNigRxpeGT6LhUETZFhyxEnf2+Ss/HdZ
         Pb4wrdz1IM3VmPGPzlyGwTprEeKPGN5woSNaHxu6Lp1XDfmEaCcyA/IvfLBmY54awmzb
         cSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458604; x=1787063404;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BKH+or6+JglRsvM43xQne0nZWJ1wnvkcrm15aO08CF8=;
        b=KFpa37LAsXea6Zmi7jvVZmzlLZ5DM+3FQ/6p18HHx6HNf6GVlAvOgTptqaVtCB/HAX
         0vwPuCtPXEBo7aU5O19Ml7JDqrzz8312gF54/yNmASW88QWBIH+y+lZmB7cGxDBX4B+J
         ED4BLzwXWXozvG88JqveoRrHWpFgY4CThkhK9BFj+WsRfYGl/6UeSa8LZ6cezf+BwjpO
         ABuVEqEu9eOcWxMqtiYxT36Lg4xqLbmxi8h8xFjTyeGwkurY5eoHkmeSU1aB8WsaLuQA
         2xu/bprBlS8IPb+zhwh7SspuDTpHvzDo71kxmlj9Qb/iHssAptMA0zA6ef8tU6J5U9Ll
         9TuA==
X-Gm-Message-State: AOJu0YwAKLn3miy53GD+sHEYoPegCzSWjAOGgt2xVTLTcFQSqrA9C32N
	fCezM5Qo7H4hMRznFl00ENEydu4/BaKzVgQEqynxPQlLXrsWJ85T+5wJVsc/Kj4N3amVXXwIS0e
	SONpJbjdVJjB/SjX1chuAsPLTgcPZjtalhaGnhKupLr2YUYjehzf0HLmb/xEib3ZOhVFmeV95kG
	2aNG9y6OcaMIjgmerGXgesI8vPGuGGdL+qO9ZPiv3eB1SRt5nWGboaXWWi3lxkP94=
X-Received: from pgwb15.prod.google.com ([2002:a65:668f:0:b0:c9e:a22d:15e8])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3a26:b0:848:4859:a45 with SMTP id d2e1a72fcca58-84fa866cfb8mr2856776b3a.2.1786458603096;
 Tue, 11 Aug 2026 07:30:03 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:29:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811142958.160088-1-shivajikant@google.com>
Subject: [PATCH net-next v2] net: convert netdev_nl_sock bindings list to xarray
From: Shivaji Kant <shivajikant@google.com>
To: netdev@vger.kernel.org
Cc: praan@google.com, Shivaji Kant <shivajikant@google.com>, 
	Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Dragos Tatulea <dtatulea@nvidia.com>, Kees Cook <kees@kernel.org>, 
	David Carlier <devnexen@gmail.com>, Yue Haibing <yuehaibing@huawei.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Maoyi Xie <maoyixie.tju@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

netdev_nl_sock previously used a struct list_head bindings to keep
track of active netdev netlink bindings, protected by a per-socket
struct mutex lock (priv->lock).

Since list modifications and iterations are not concurrency-safe,
priv->lock was introduced to serialize operations on priv->bindings.
However, xarray manages its own internal locking (xa_lock) for store,
erase, and iteration operations.

Convert bindings in struct netdev_nl_sock from struct list_head to
struct xarray and remove priv->lock. This simplifies the code by
removing explicit mutex locking in netdev_nl_bind_rx_doit(),
netdev_nl_bind_tx_doit(), and socket initialization/teardown functions.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Shivaji Kant <shivajikant@google.com>
---
v1 -> v2:
  - Add explicit err_erase_dmabuf_bindings err label in net_devmem_bind_dmabuf()
    to align cleanup paths with the rest of the function (feedback from reviewer).

v1: https://lore.kernel.org/all/20260810065759.3735934-1-shivajikant@google.com/

 include/net/netdev_netlink.h |  5 ++---
 net/core/devmem.c            | 14 +++++++++++---
 net/core/devmem.h            |  4 ++--
 net/core/netdev-genl.c       | 25 ++++++-------------------
 4 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/include/net/netdev_netlink.h b/include/net/netdev_netlink.h
index 075962dbe743..45a4a482d42e 100644
--- a/include/net/netdev_netlink.h
+++ b/include/net/netdev_netlink.h
@@ -2,11 +2,10 @@
 #ifndef __NET_NETDEV_NETLINK_H
 #define __NET_NETDEV_NETLINK_H
 
-#include <linux/list.h>
+#include <linux/xarray.h>
 
 struct netdev_nl_sock {
-	struct mutex lock;
-	struct list_head bindings;
+	struct xarray bindings;
 };
 
 #endif	/* __NET_NETDEV_NETLINK_H */
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 957d6b96216b..bdf8a0799a42 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -134,8 +134,8 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	 */
 	synchronize_net();
 
-	if (binding->list.next)
-		list_del(&binding->list);
+	if (binding->sock_priv)
+		xa_erase(&binding->sock_priv->bindings, binding->id);
 
 	xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
 		const struct pp_memory_provider_params mp_params = {
@@ -193,6 +193,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 	struct dma_buf *dmabuf;
 	unsigned int sg_idx, i;
 	unsigned long virtual;
+	void *res;
 	int err;
 
 	if (!dma_dev) {
@@ -325,10 +326,17 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 	if (err < 0)
 		goto err_free_chunks;
 
-	list_add(&binding->list, &priv->bindings);
+	binding->sock_priv = priv;
+	res = xa_store(&priv->bindings, binding->id, binding, GFP_KERNEL);
+	if (xa_is_err(res)) {
+		err = xa_err(res);
+		goto err_erase_dmabuf_bindings;
+	}
 
 	return binding;
 
+err_erase_dmabuf_bindings:
+	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
 err_free_chunks:
 	gen_pool_for_each_chunk(binding->chunk_pool,
 				net_devmem_dmabuf_free_chunk_owner, NULL);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 3852a56036cb..bf77e5a9a8fe 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -49,10 +49,10 @@ struct net_devmem_dmabuf_binding {
 	 */
 	struct percpu_ref ref;
 
-	/* The list of bindings currently active. Used for netlink to notify us
+	/* The socket priv this binding belongs to. Used for netlink to notify us
 	 * of the user dropping the bind.
 	 */
-	struct list_head list;
+	struct netdev_nl_sock *sock_priv;
 
 	/* rxq's this binding is active on. */
 	struct xarray bound_rxqs;
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index c15d8d4ca1f8..d3f3a91a6d93 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1044,13 +1044,11 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_genlmsg_free;
 	}
 
-	mutex_lock(&priv->lock);
-
 	err = 0;
 	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
 	if (!netdev) {
 		err = -ENODEV;
-		goto err_unlock_sock;
+		goto err_genlmsg_free;
 	}
 	if (!netif_device_present(netdev))
 		err = -ENODEV;
@@ -1102,8 +1100,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 
 	netdev_unlock(netdev);
 
-	mutex_unlock(&priv->lock);
-
 	return err < 0 ? err : 0;
 
 err_unbind:
@@ -1112,8 +1108,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	bitmap_free(rxq_bitmap);
 err_unlock:
 	netdev_unlock(netdev);
-err_unlock_sock:
-	mutex_unlock(&priv->lock);
 err_genlmsg_free:
 	nlmsg_free(rsp);
 	return err;
@@ -1185,12 +1179,10 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_genlmsg_free;
 	}
 
-	mutex_lock(&priv->lock);
-
 	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
 	if (!netdev) {
 		err = -ENODEV;
-		goto err_unlock_sock;
+		goto err_genlmsg_free;
 	}
 
 	if (!netif_device_present(netdev)) {
@@ -1233,7 +1225,6 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 	if (bind_dev != netdev)
 		netdev_unlock(bind_dev);
 	netdev_unlock(netdev);
-	mutex_unlock(&priv->lock);
 
 	return genlmsg_reply(rsp, info);
 
@@ -1242,8 +1233,6 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		netdev_unlock(bind_dev);
 err_unlock_netdev:
 	netdev_unlock(netdev);
-err_unlock_sock:
-	mutex_unlock(&priv->lock);
 err_genlmsg_free:
 	nlmsg_free(rsp);
 	return err;
@@ -1418,19 +1407,17 @@ int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
 {
-	INIT_LIST_HEAD(&priv->bindings);
-	mutex_init(&priv->lock);
+	xa_init(&priv->bindings);
 }
 
 void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
 {
 	struct net_devmem_dmabuf_binding *binding;
-	struct net_devmem_dmabuf_binding *temp;
 	netdevice_tracker dev_tracker;
 	struct net_device *dev;
+	unsigned long xa_idx;
 
-	mutex_lock(&priv->lock);
-	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
+	xa_for_each(&priv->bindings, xa_idx, binding) {
 		mutex_lock(&binding->lock);
 		dev = binding->dev;
 		if (!dev) {
@@ -1446,7 +1433,7 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
 		netdev_unlock(dev);
 		netdev_put(dev, &dev_tracker);
 	}
-	mutex_unlock(&priv->lock);
+	xa_destroy(&priv->bindings);
 }
 
 static int netdev_genl_netdevice_event(struct notifier_block *nb,
-- 
2.55.0.654.g21b8a5bc05-goog

