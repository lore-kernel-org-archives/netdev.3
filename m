Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024703BE141
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 02:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791600937; cv=none; b=pOChDclRgaXP7EXpqhAtug/RZ2WJUYebB3CdobwXsMjh1eXSLcvNXkUtakwkBVIQAnlhnK0XNR/2XaaMfO8kPZlg+YErnYUPqF0adJUtrVoptm7Er9sgm2me7HBMVCxPYXCeVftZDNQrXTjgRYTPZFpBC4/VW1RHPtEheMvA5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791600937; c=relaxed/simple;
	bh=2y6NI7EUqJ+hcZcVtV22rapOiLANuA8VNaJVLpW5Bgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E4sYDz7R03xbvTibb0eZl8nbZTC35XuwUdQnIkacG42Lx8jO9deKsjUUpifpTsDaxyW5YOucG6EC5fqWyqd8/PazyygWPd/k/C9oax6YajYZJdztIKRrUYGVOC6CXOCyFaP1BVewBJ0Cwl3wlir0BLtyD4eEZDxU1RlD08ovW0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qzK2lcl1; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzK2lcl1"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3552883bd19so1325194eec.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 19:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791600935; x=1792205735; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BuyDELz7hhEuCW2YvtmlqnI82KO/2H6a0eJ5B6jjRa4=;
        b=qzK2lcl1bbvky3IyseZC+/uz3dS0wvMDdyDw5T3U+KXuMp+ImAWoDrZOhTCg8tN9UU
         al+WQyBcak5WIoIOgXY9IcA/MU+rAcuAJoNtKKB+G2jUJpeHBx6OEgrPLUTBqE95Xv9x
         QmtZNrmDelZu9zr4j0eviBgXVhzGI7ZDqFq7L69mHZg9//x11MRw+wwmZuhEworuCkQX
         TXlLKQF125fQRaRAYK4VHNv6tCFLvsODr/z7hSUmbSDTS+LdyY/b9Ks2ETGSFTYTVt/E
         Mpa3+pIF3UYI2aRsaC08iFivhgTuixsrX33wZ4z3XjeHBVO2JFTZt+q4A79r34MFuOg5
         BTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791600935; x=1792205735;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BuyDELz7hhEuCW2YvtmlqnI82KO/2H6a0eJ5B6jjRa4=;
        b=lDgd4iH8jd+evU3gxCEgALF7yn8WuFGkKm6s27QiQKqmcryfKht6N+oCHRm28agY9K
         2nsNeF8uUc7awKOkyuZ+1k4vgCIIzwk951WjAQLMs8oA/+GQmwMkg+1GtstPBdOahU1K
         sI2eerjgKBd/mZk0DvnHJUtYc2OKBm+JU1DoqhBrKT6lKF3ej8PPldShWba+ZS4aMaW/
         PZKZ3L3kJjnVr5m/HeNxROPmjj853F7DbhQoJ010RYbVzuVJZmEqYB768MivUvdm0Dmr
         jlUkHs0px5liygVbCBzAx+iQVkVLvmndRKAeBUGizYmyMbZx4RgK4FhTqUISfi3hb4Bt
         aKDw==
X-Forwarded-Encrypted: i=1; AKwUvBz/ugSZd/VzPUyyFoAlwcYq1wyeFIPioVm1C8Fg7VovzWGe32b/A/TUguBERLR9LHWasdPHPLY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5mvlwHGuXIz2nSHMPsTRrWLxnhJzI9RL5TH8rx5kiITEK5+PY
	nSh5k7HcJE3acBo1ru4yzx/d6oag7RLasM9NutqUjHPc2UVbgbVHvPBIaaUiEG5cMuKyTUT0UTz
	VIBQ39bLQJfjH/sO1WReczecYaA==
X-Received: from dyaz17-n2.prod.google.com ([2002:a05:693c:6391:20b0:34b:4d35:2884])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:78ca:b0:351:750d:dd3b with SMTP id 5a478bee46e88-3537dde75a7mr5327189eec.4.1791600934160;
 Fri, 09 Oct 2026 19:55:34 -0700 (PDT)
Date: Sat, 10 Oct 2026 02:55:13 +0000
In-Reply-To: <20261010025532.839559-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261010025532.839559-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261010025532.839559-2-almasrymina@google.com>
Subject: [PATCH net v1 1/4] net: devmem: unmap dma_buf synchronously on queue uninstall
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Taehee Yoo <ap420073@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"

When a bound net_device is unregistered while userspace still holds a
netlink or TCP socket reference on a devmem binding,
mp_dmabuf_devmem_uninstall() clears binding->dev to NULL so
netdev_nl_sock_priv_destroy() will not touch the unregistered
net_device, but leaves the dma_buf attachment mapped until
__net_devmem_dmabuf_binding_free() runs later on socket close.

Because dma_buf_attach() does not take a reference on dma_dev, device
removal frees dma_dev while the attachment is still mapped. Closing the
netlink socket afterwards triggers a slab use-after-free in
dma_unmap_sg_attrs():

  BUG: KASAN: slab-use-after-free in dma_unmap_sg_attrs+0x76/0x2b0
  Read of size 8 at addr ffff88810fae64b0 by task kworker/3:1/53
  Workqueue: events __net_devmem_dmabuf_binding_free
  Call Trace:
   dma_unmap_sg_attrs+0x76/0x2b0
   unmap_udmabuf+0x8e/0x100
   dma_buf_unmap_attachment+0x145/0x330
   dma_buf_unmap_attachment_unlocked+0x96/0x130
   __net_devmem_dmabuf_binding_free+0x156/0x2e0
  Freed by task 9:
   kfree+0x1b8/0x550
   nsim_bus_dev_release+0xe/0x60
   device_release+0xcf/0x250

Add net_devmem_dmabuf_binding_unmap() serialized under binding->lock
and null out binding->sgt and binding->attachment after unmapping so
unmapping is idempotent across queue uninstall and deferred binding
destruction. Call it synchronously when the last bound RX queue is
uninstalled in mp_dmabuf_devmem_uninstall().

Fixes: f8350a4358fc ("net: page_pool: add a mp hook to unregister_netdevice*")
Fixes: 0afc44d8cdf6 ("net: devmem: fix kernel panic when netlink socket close after module unload")
Cc: Taehee Yoo <ap420073@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/devmem.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index f4d60654ce7fd..5e4070b82df44 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -58,6 +58,21 @@ static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
 	schedule_work(&binding->unbind_w);
 }
 
+static void
+net_devmem_dmabuf_binding_unmap(struct net_devmem_dmabuf_binding *binding)
+{
+	lockdep_assert_held(&binding->lock);
+
+	if (!binding->sgt)
+		return;
+
+	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
+					  binding->direction);
+	dma_buf_detach(binding->dmabuf, binding->attachment);
+	binding->sgt = NULL;
+	binding->attachment = NULL;
+}
+
 void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 {
 	struct net_devmem_dmabuf_binding *binding = container_of(wq, typeof(*binding), unbind_w);
@@ -74,9 +89,10 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 		  size, avail))
 		gen_pool_destroy(binding->chunk_pool);
 
-	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
-					  binding->direction);
-	dma_buf_detach(binding->dmabuf, binding->attachment);
+	mutex_lock(&binding->lock);
+	net_devmem_dmabuf_binding_unmap(binding);
+	mutex_unlock(&binding->lock);
+
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
 	percpu_ref_exit(&binding->ref);
@@ -535,6 +551,7 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
 				mutex_lock(&binding->lock);
 				ASSERT_EXCLUSIVE_WRITER(binding->dev);
 				WRITE_ONCE(binding->dev, NULL);
+				net_devmem_dmabuf_binding_unmap(binding);
 				mutex_unlock(&binding->lock);
 			}
 			break;
-- 
2.56.0.385.gd3acb90ef8-goog

