Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6339A078
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345085; cv=none; b=U2oXrXll9kEquSl9YjtpU7UON7jeSifjswAtAiRWpc3tm1VFMa/WcWz6KlJ7YneEF7INOpGMPSdZV1GmQ4SCzqNIU9jLodZlgOxNzZ1hFwnhIeHwDaDBilFd3WiC1iYbzEDDCBBRkma8lzKdKgQjMMh4LKtCSwELqY/rCd5vYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345085; c=relaxed/simple;
	bh=zcK/CtUFnpS0k20y6oRda6La7dWyLcqSsoUQS0OjXyM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oTIBEV1an+rIlfCixjioSLbXTUdGXYbFuxkoHcjamPw//eArZrbUDGjE0y3Oe63ZkwB9SdBr2oi8SZy+LUJmTgoUVKD5DFAfrUH3VVK5h1b5cZZ8e2fKVI9WqpbPHxQMZEvMXo7rRGWk6t04sZiWtRY21uYShmdz3A7gQg1J9PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rn3cKNUR; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rn3cKNUR"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso1978302a91.3
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 23:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786345084; x=1786949884; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l3VRlw1pks8LWzs6IX7SIYNDXvrFG8BZNOogDxjD1Xc=;
        b=Rn3cKNUR2O567j6pvGaGNKsbdvlxjkKt+jkmHEdRaZeuSSyM7WBj233CoMeagnuF4g
         h0NLEQEs9zDudrKHtTRAmI0KA66++OzU9EBVntUXHGErchSb+0xMXQlRX7YAXZJr3Ke4
         mXpNlnQdcQ1wnVM0x31GLn64MjQ1xtIHjqMrH7oWfkSIwZ53YNK6b+J/lQSNRMJe+9Pp
         WOre5opf7sL0C8mvtzfHf8MgxFJxUTQRRzZNiSe9eqHMJFBwsyh2Q0KYDvCVmSBrn0D3
         ihUf4kGmGiQyCD/yc/75xpASMP2ddR8U4y550UaXn9kek4XbDqwPRFMK+4rAj7xYsw4S
         D+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786345084; x=1786949884;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l3VRlw1pks8LWzs6IX7SIYNDXvrFG8BZNOogDxjD1Xc=;
        b=rhPAOVLCxuGii8DryUQ8yLVPBRvkkiPAC0EAKu2F7xDBt64axajW+87y+fUbwd2bTe
         4qHuTV6DY+mhppPO7r80xrep7a639qrPD5UgVa5MHvqblj2jXIb+qj64PaKmrbjjmHG/
         Z9S4R6pgzwf2BjgltdurU+AfNQfmqQcwJ77dYIlhuSsKX+urdfw1SqsmOWq3zrmbRNyJ
         TUuYBCnJQ5Oz3tIJim2wfiV+Eg8Ep0qu/ksz/5fI/35H+SLkDLZM3qrlD0EzAb5qOYu6
         NjoDWtnEs2xx4mQoNZuOxBwBz7XV4Ms0cglUfd7ztj4LiQWl54WBNr7lhSBjAj/EGzjF
         L2zw==
X-Gm-Message-State: AOJu0YwZcGy/1sDlQT7UqrouC681D71/nk5LHQfjJ6NzFbzJX70u8XlZ
	JWhiJsJCVydBGvULdeFmNABiOCAjMGZk0xPIc4+4YS+/wB35L3jJlpMRnNEDQsbDNMvAaHy9LmP
	yiwT6yLgoCAfILbKny9tjOQNM/kKk7HNvAankh0KNdaS68e8ChXWSSx2UjBAngRJo87tvlc/GyP
	+22EjZWoksC5DXHQGmZyc2EX+6XKNByFEuLYJYqlNi4djHvGAxwX2moX9x8TdbLRE=
X-Received: from pjor3.prod.google.com ([2002:a17:90a:9403:b0:38e:afc7:ab5b])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:35c8:b0:38d:adae:4866 with SMTP id 98e67ed59e1d1-39282494777mr18798614a91.21.1786345083325;
 Sun, 09 Aug 2026 23:58:03 -0700 (PDT)
Date: Mon, 10 Aug 2026 06:57:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810065759.3735934-1-shivajikant@google.com>
Subject: [PATCH] net: convert netdev_nl_sock bindings list to xarray
From: Shivaji Kant <shivajikant@google.com>
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Cc: praan@google.com, Shivaji Kant <shivajikant@google.com>, 
	Mina Almasry <almasrymina@google.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Kees Cook <kees@kernel.org>, 
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
 include/net/netdev_netlink.h |  5 ++---
 net/core/devmem.c            | 13 ++++++++++---
 net/core/devmem.h            |  4 ++--
 net/core/netdev-genl.c       | 25 ++++++-------------------
 4 files changed, 20 insertions(+), 27 deletions(-)

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
index 957d6b96216b..52fda18b80ef 100644
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
@@ -325,7 +326,13 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 	if (err < 0)
 		goto err_free_chunks;
 
-	list_add(&binding->list, &priv->bindings);
+	binding->sock_priv = priv;
+	res = xa_store(&priv->bindings, binding->id, binding, GFP_KERNEL);
+	if (xa_is_err(res)) {
+		err = xa_err(res);
+		xa_erase(&net_devmem_dmabuf_bindings, binding->id);
+		goto err_free_chunks;
+	}
 
 	return binding;
 
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

