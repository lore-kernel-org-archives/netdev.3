Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C23B0598
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234253; cv=none; b=Iw/m3dGEDxJoVG25AjjeqAl/mOpQD2ubFtwt88u8RCRiit9jrOcwHLQDGApIi6B1yl2dr13nBlClExhQMcI0WSVk6JiNAK6p2Nf01ooP2kj80TjmV/2SjY5FWZUhvwPnbleNdvpRgDthgSo598bi9oZUugU/Hqp2Kx96V4oLy6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234253; c=relaxed/simple;
	bh=TmqEykrRbiCeVgmK3AIV82QcHK8mCtpYZEu6FYVJNtU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=msGP5YxCNY+0rU3ccSkWCxIW7ulfoKJcvwtDi9xkAuzWTOQtckjG7IcBjg1wjJcFt5LUluQAre9uUfsqs+qee535gVJgJTf6OE+f4aQQ2uGHDScNbycrFp30NZ77rGXRRXMGvhD3/LXnz8HyjUk4M52T422tZjx9g+C+2I0MMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaifengw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Plo3XmAR; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaifengw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Plo3XmAR"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so5373748eec.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791234251; x=1791839051; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KI04OHVNMk1iREh5Vcyr0z3kyY0Bw6/QOTWCwAjjS5Q=;
        b=Plo3XmAR6IOMiP0lTk5KvpNlKyZWqwB19e54yf4iL6tFOKMsUlyEuBOCfNvutzyZbn
         dLRBEsPWkFe9ezeGyKWscIlqW/+pdIt4gsnHbOXHlG1nOg+08uT6sLSirL4dHG/jMOyV
         eHVU4QF0dfuIOVdrU2dghkwPZaxJE3Pb+Gya2YyTNlrrpQczEfBIlVMmmR2T4u/+E4YA
         diCLDL0Nzr93yS/vTEehkdYhyyedpi3+cQf1J5HpQanM7QYKG/27zzYyrKwBdqTzif1N
         oyNEbvKFq3qT7NxI3aZQGic/NaS9G8wBZmclffubhTVnjeu9Jx/8qej8cX5lVcnMRjwl
         /W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791234251; x=1791839051;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KI04OHVNMk1iREh5Vcyr0z3kyY0Bw6/QOTWCwAjjS5Q=;
        b=R8Lq4SWsgjoIsyF4xeEr9tLuKBwY6XJDQsl/nK7Og5b5ddqwKEF5A0iSucbpUjopd2
         JsS2I4JrGo5SrwSokl5mjAAI2ECwO+oMl2wAXch9zJ7oRDQtG+KHMW7Kd48YKm6QiYKg
         XI1H80k46Vc/SVezFDdAH+sS0mxaafP+nQnMXfXW0nLcJZV35kYM25XhMUfyiavai79a
         03IpkfO2g0ObFcS+6rjCm8yrbPOXa3EGjgAcH1/Gl9rN3wnWHA5M+qmoH6vLnItpOQ4a
         eqF6nOEBIB4HQbBg/u8yBxZavEyjsxRruQoroKiwPtDrqCKe4+Ug0jj+OsDh5M+HLNg+
         zgTQ==
X-Gm-Message-State: AFuF++kWgkpg7CS/4vQ6VVJzGCE/2uEaG2WfFwzUxVy1NkLyCKrxYpg3
	z0YB5YGZ2qQZATGQkmI+yjXb/Zg30MFUk8FlvnnU30nazZffNZv8GUOlEQ6HvnZm3D5vFiAVvSR
	ghCaqMXRFdL7tnYDTJ8/C1EWynO6i8MCqolMJcUB/sEzyEm0YNpxWi3E78rxXCIHH9M6+wQIJP1
	cF4t4DObYz3JqJtPrbZXuaFYK/+ACuyhpekcv6ZWPqy5r2jA8=
X-Received: from dycpr6.prod.google.com ([2002:a05:7301:fd86:b0:347:7fea:9fec])
 (user=kaifengw job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:4208:b0:351:1e3f:812d with SMTP id 5a478bee46e88-3511e3f8878mr8117223eec.36.1791234250456;
 Mon, 05 Oct 2026 14:04:10 -0700 (PDT)
Date: Mon,  5 Oct 2026 21:04:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005210403.3206872-1-kaifengw@google.com>
Subject: [PATCH net] net: devmem: check uid and netns in net_devmem_get_binding()
From: Kaifeng Wang <kaifengw@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, edumazet@google.com, pabeni@redhat.com, 
	willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org, 
	sdf@fomichev.me, bobbyeshleman@meta.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"

NETDEV_CMD_BIND_TX is unprivileged, and dmabuf binding IDs are allocated
from a single global xarray. Currently net_devmem_get_binding() looks up
the binding by ID without checking whether the sending socket belongs to
the same user or network namespace that created the binding.

Record the creating netlink socket's network namespace and UID on the
binding, and verify both in net_devmem_get_binding() before checking the
route destination device. Return -EINVAL on mismatch so callers cannot
distinguish non-existent IDs from bindings owned by other users.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Signed-off-by: Kaifeng Wang <kaifengw@google.com>
---
 net/core/devmem.c      | 7 ++++++-
 net/core/devmem.h      | 5 +++++
 net/core/netdev-genl.c | 5 +++--
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index f4d60654ce7f..9a773b1ce92d 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -191,6 +191,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd, unsigned int niov_shift,
 		       struct netdev_nl_sock *priv,
+		       const struct sock *nl_sk,
 		       struct netlink_ext_ack *extack)
 {
 	struct net_devmem_dmabuf_binding *binding;
@@ -220,6 +221,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 
 	binding->dev = dev;
 	binding->vdev = vdev;
+	write_pnet(&binding->net, sock_net(nl_sk));
+	binding->uid = sk_uid(nl_sk);
 	binding->niov_shift = niov_shift;
 	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
 
@@ -390,7 +393,9 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	int err = 0;
 
 	binding = net_devmem_lookup_dmabuf(dmabuf_id);
-	if (!binding || !binding->tx_vec) {
+	if (!binding || !binding->tx_vec ||
+	    !net_eq(sock_net(sk), read_pnet(&binding->net)) ||
+	    !uid_eq(sk_uid(sk), binding->uid)) {
 		err = -EINVAL;
 		goto out_err;
 	}
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 4a293a7d1149..7b9d3e04367c 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -10,6 +10,7 @@
 #ifndef _NET_DEVMEM_H
 #define _NET_DEVMEM_H
 
+#include <net/net_namespace.h>
 #include <net/netmem.h>
 #include <net/netdev_netlink.h>
 
@@ -26,6 +27,8 @@ struct net_devmem_dmabuf_binding {
 	 * dereferenced.
 	 */
 	void *vdev;
+	possible_net_t net;
+	kuid_t uid;
 	struct gen_pool *chunk_pool;
 	/* Protect dev */
 	struct mutex lock;
@@ -97,6 +100,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd, unsigned int niov_shift,
 		       struct netdev_nl_sock *priv,
+		       const struct sock *nl_sk,
 		       struct netlink_ext_ack *extack);
 struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
@@ -181,6 +185,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       unsigned int dmabuf_fd,
 		       unsigned int niov_shift,
 		       struct netdev_nl_sock *priv,
+		       const struct sock *nl_sk,
 		       struct netlink_ext_ack *extack)
 {
 	return ERR_PTR(-EOPNOTSUPP);
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 33b9f4eb9565..847814e3df3f 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1094,7 +1094,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 
 	binding = net_devmem_bind_dmabuf(netdev, NULL, dma_dev, DMA_FROM_DEVICE,
 					 dmabuf_fd, niov_shift, priv,
-					 info->extack);
+					 NETLINK_CB(skb).sk, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_rxq_bitmap;
@@ -1243,7 +1243,8 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 	binding = net_devmem_bind_dmabuf(bind_dev,
 					 bind_dev != netdev ? netdev : NULL,
 					 dma_dev, DMA_TO_DEVICE, dmabuf_fd,
-					 PAGE_SHIFT, priv, info->extack);
+					 PAGE_SHIFT, priv, NETLINK_CB(skb).sk,
+					 info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock_bind_dev;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

