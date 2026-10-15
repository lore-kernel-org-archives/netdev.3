Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D783E073E
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082378; cv=none; b=IrlysEn7UiOgvxuuDa99iWagfIXK0Ro4sNuE5RZKCkG/AfnPwps2hKGX/Pt+0INucF8cTYQ3Os7mg3qCZwDR1t0O8L9l185QcfJPoGSsqbI79ByEQUYR1X0k4zaLZ4FZDnx8wrkPoweY5hCC9wK8FYjljYp7NHkPXBED7EC6w8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082378; c=relaxed/simple;
	bh=Txx+SO8uwxuJ3Ktm0Hsppbh1+qsaoXJIVwNfp/iA60c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IVGfw4vVG8LCB703/NYHOxVyUfcW/ff5VSN52paZZdChFAz8obqye33oUqdFp9VO549gaJYElIPtnMZn4cJk/PbZtBkutQpeh2PY8su7Hgvb7ZvK+e5Ea8WV9m7Js0IUBkVg1+4hC8GbxtPSHoGtFzTHh3RImHkVrSFKfQODE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W15QR3pD; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W15QR3pD"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35a4d2e39acso3684571eec.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792082361; x=1792687161; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7vrwp4HC01Z0kE3Wy37HFrMt6VtKQXq+YFsCUGH+2uM=;
        b=W15QR3pDYkVbv8JSaOxkvJovbfCLWc0EGZOvJyEC03mFyEs4Gn+F1idBhDt0HCfxif
         r4oTGn/da9s/CYrP+kDgy0xEUG9Kfzv1v20vxHMW8McLepuMP/UOwq2jO+N9gYJSQrBO
         lnWTmomqD6s1IMoXx2M52lA2EymvN5TT+uUDyYIpH77L6wCoGS9JVdT2S6XZQWZnYc1e
         BCTJQorglTk8OAho8ay4aOQFqWMvadiFUvJ8N68Rc7QuxczfUGW+Vw06SS4HPrPLNJbi
         v6N3oVl7SPAAdiKKesarWnuHAta+L4pSINpVqe4QGbyZEUskrzB9x2ANFAkqG47gEQet
         3+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792082361; x=1792687161;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7vrwp4HC01Z0kE3Wy37HFrMt6VtKQXq+YFsCUGH+2uM=;
        b=Sbl/4aTPLMiTNggSLOimCz+kr6xVPuCkHe8xnJMmqgMeS5tJDEp5fL9YMuVUGTs9A/
         HYpGOPirtRjo95utEvgnfaRkax9gcw9apV4APNVJZgfJ9+9TAx7yDsKIz86wLrrjrp5e
         1HN5LZgdel6IyQo8qiccXRJfAOdgiEG5gMLsHGPQ89IbjJFl2wBLpxM356axI0EOqeN4
         YzCu2d1Y03li9fdXJnmSOntjna7fnRtuRGjouYn53+2TlMCWe7W4pnSZiOrt05cy3W7h
         h+wjA4tBqMCpjQoyrmx2ZtGe8igws5ylm8t/0NzceTCnqq5BzrIv3SZiVBteq4CmyBvs
         J3nw==
X-Forwarded-Encrypted: i=1; AKwUvBzLTFMeEQpdt7FHvkEl7GYXAxISLk3uZKWwlcMVr9wpXgsoKnpPv6MEsxpAyMSHB4jNzBXlTvs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEuVVCv6EYAfMeWvmgSFp7OEnGrGp65Ue8vbippqS5V7YgUYqu
	t95LMFpalN83HgdQUvm/r1uYV9xgUCe882VxzTE6vHmTRkCX8Nwo3MW/hfpFPzYB6OPuFJjW6bd
	VUFIB7hixaTc0EJwUa3V6zOrbtQ==
X-Received: from dybtm1.prod.google.com ([2002:a05:7300:f0c1:b0:358:cd5e:4e5c])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:e002:b0:35d:5a2c:2321 with SMTP id 5a478bee46e88-35d5a2c2980mr8679042eec.20.1792082358745;
 Thu, 15 Oct 2026 09:39:18 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:39:13 +0000
In-Reply-To: <20261015163915.1166043-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015163915.1166043-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261015163915.1166043-3-almasrymina@google.com>
Subject: [PATCH net v4 2/4] net: devmem: detach TX bindings on NETDEV_UNREGISTER
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Stanislav Fomichev <sdf@fomichev.me>, Taehee Yoo <ap420073@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Tariq Toukan <tariqt@nvidia.com>, Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"

TX devmem bindings (NETDEV_CMD_BIND_TX) have no bound RX queues, so
mp_dmabuf_devmem_uninstall() never runs when binding->dev or
binding->vdev unregisters. As a result, binding->dev and binding->vdev
dangle pointing to freed struct net_device memory, and the dma_buf
remains attached and mapped after device removal.

Closing the netlink socket after netdev unregistration dereferences the
freed struct net_device in netdev_nl_sock_priv_destroy():

  BUG: unable to handle page fault for address: ffff88824ca9b000
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:netdev_nl_sock_priv_destroy+0xbd/0x1e0
  Call Trace:
   genl_release+0xf5/0x190
   netlink_release+0xd01/0x18d0
   __sock_release+0xb0/0x270
   sock_close+0x18/0x20

Extend net_devmem_dev_unregister() to TX bindings, including ones
whose netlink socket is already closed but which TCP retransmits keep
alive:
- When binding->dev (the physical DMA-capable device) unregisters,
  clear the binding's NET_DEVMEM_BINDING_LIVE mark and both
  binding->dev and binding->vdev, and unmap the dma_buf under
  binding->lock. No grace period is needed: the device is already
  closed, so nothing hands the DMA addresses to the hardware anymore,
  and concurrent senders only compare against binding->dev.
- When only binding->vdev (virtual device) unregisters while
  binding->dev lives, only clear binding->vdev so no new TX sends match
  the virtual device while allowing in-flight TX packets on binding->dev
  to finish DMA safely.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Fixes: 1abe839b34ae ("net: devmem: support TX over NETMEM_TX_NO_DMA devices")
Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
Cc: Kaiyuan Zhang <kaiyuanz@google.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>
Assisted-by: LLM
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
v4:
- Detach and unmap TX bindings directly from the xarray walk, without a
  grace period or a second pass (Stanislav).

v3:
- Detach all matching TX bindings first, then call synchronize_net()
  once before unmapping them, instead of once per binding. Don't wait
  for a grace period when only binding->vdev is cleared, since vdev is
  never dereferenced (Sashiko).
- Don't detach TX bindings when the device only moves to another netns
  (Sashiko).

v2:
- Build on the net_devmem_dev_unregister() walk from the previous patch,
  so unbound TX bindings are also detached (Sashiko). Clear the
  binding's LIVE mark instead of erasing its ID.
- The walk holds net_devmem_lock, which the final free also takes
  before erasing the binding, instead of using RCU and
  percpu_ref_tryget(), so it no longer takes a binding reference
  (Stanislav).
---
 net/core/devmem.c | 22 +++++++++++++++++++++-
 net/core/devmem.h |  3 ++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 20d95b24d5951..d33a092c6e4bb 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -207,11 +207,30 @@ net_devmem_dev_unregister_rx(struct net_devmem_dmabuf_binding *binding,
 			    NET_DEVMEM_BINDING_LIVE);
 }
 
+static bool
+net_devmem_dev_unregister_tx(struct net_devmem_dmabuf_binding *binding,
+			     unsigned long xa_idx, struct net_device *dev)
+{
+	if (binding->direction != DMA_TO_DEVICE)
+		return false;
+
+	if (READ_ONCE(binding->vdev) == dev)
+		WRITE_ONCE(binding->vdev, NULL);
+
+	if (READ_ONCE(binding->dev) != dev)
+		return false;
+
+	__xa_clear_mark(&net_devmem_dmabuf_bindings, xa_idx,
+			NET_DEVMEM_BINDING_LIVE);
+	return true;
+}
+
 static void net_devmem_dev_detach(struct net_devmem_dmabuf_binding *binding,
 				  struct net_device *dev)
 {
 	mutex_lock(&binding->lock);
 	WRITE_ONCE(binding->dev, NULL);
+	WRITE_ONCE(binding->vdev, NULL);
 	if (!netif_is_queue_leasee(dev))
 		net_devmem_dmabuf_binding_unmap(binding);
 	mutex_unlock(&binding->lock);
@@ -229,7 +248,8 @@ void net_devmem_dev_unregister(struct net_device *dev)
 
 	xa_lock(&net_devmem_dmabuf_bindings);
 	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
-		if (!net_devmem_dev_unregister_rx(binding, xa_idx, dev))
+		if (!net_devmem_dev_unregister_rx(binding, xa_idx, dev) &&
+		    !net_devmem_dev_unregister_tx(binding, xa_idx, dev))
 			continue;
 
 		xa_unlock(&net_devmem_dmabuf_bindings);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index a834e0f698c7e..ce069e1736416 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -39,7 +39,8 @@ struct net_devmem_dmabuf_binding {
 	 * The binding undos itself and unmaps the underlying dmabuf once all
 	 * those refs are dropped and the binding is no longer desired or in
 	 * use. RX bindings are unmapped earlier, once they are no longer
-	 * installed on any queue.
+	 * installed on any queue. TX bindings are unmapped earlier if their
+	 * device is unregistered.
 	 *
 	 * net_devmem_get_net_iov() on dmabuf net_iovs will increment this
 	 * reference, making sure that the binding remains alive until all the
-- 
2.56.0.176.g3575e65682-goog

