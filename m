Received: from mail-qv2-f1.google.com (mail-qv2-f1.google.com [74.125.230.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A484DAFA3
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367333; cv=none; b=JIKNYOfKjBLO7Z8T31hB/2+7SP4w8JXtY8GxF778QXu50ZbpaxsTVFB1IOdCbwtbnuzMfOX/9b8J5L9Iqj507apVaBN468WE7VQQVw6fXy7k39wjDV4J0ZN5Hw6J3YVAJs3eybjJTo6NcOmjzqbeLJaXOMM6YapzTuaMRuXI4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367333; c=relaxed/simple;
	bh=LBPXCy6dH+fqzzFIsS9FOhAhSt858iFjS4KU71/3Rp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m26yQZcF68BsQYQa5Pn/FjA/5U7+5CsMG9VAvCA5clxggfxp3AIh8QkMM3jIAF1JGaU4oFU4HU/qqwwxaIzwbwm70OaZiOC9VJvv7swLLaNNNIj1SfohzeO0KGm1OsAHcwqDunmAKCdjkxAP0qblsInSMN2+CQdT6ctbvsafSWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+MQDYdh; arc=none smtp.client-ip=74.125.230.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+MQDYdh"
Received: by mail-qv2-f1.google.com with SMTP id 6a1803df08f44-8eeebcdbfa1so2248646d6.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790367327; x=1790972127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4CRGKZpLbXRrZjQJEFM+sdus8B1lSLVuEaUmy1jCajU=;
        b=L+MQDYdh/Kn/Jx1ccelR1tRVJcQQoRMxIKRufonMJG2jTCoNASQ9z/6yzRVLUPEIcC
         9ceFisvfIpUN9KhVKA6pscB8zyB6CrMax/+/Dn0KzoZkvKZ6H+Wxf6rNmbDNkvUVGHvm
         jzryVHdNRBMQY7rAiInuagECAtrxMQ7FYtdlFFoNewYNXlXo+q5Zrq6SKfUDVxfUyW0B
         R2kZU6GIbETXB9GgDkcWuWA/qYEMh6gJciSPRmCLKUw7fbGW6nJYh12Svpjntv7Jg3eM
         j7oZqszoPLtAz5ZQjmITy9XBE3gzNnF+Pui3VBXPSbvjywgMULcuTVUE9Y9wMrhFadtf
         5k2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790367327; x=1790972127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4CRGKZpLbXRrZjQJEFM+sdus8B1lSLVuEaUmy1jCajU=;
        b=gc5fac1jfj3+vrgmQfrku0h5ffgvhDCCPh9KanJFtsYNhVJn7+rwqq3kg1Tmw4UPUI
         B0Q+27nSZZS9FGRVVjtz50sZ506ICO6AH0jfySmV5iMLLBrgDpu6D04QIjDKntNTgyjH
         xmJ8mTwcbsNSkeG89UAcyhGzHXeLG5p02EDuLMLoSVf9nsAD1gK+GFPgohiv2XeBnMS+
         O/xxGGwFUbXspG7spEtLKhFfWvbRWVvi+Ed5v4NODv2Vh+3UmOWk9WAZvcb2eCjkVXH/
         PBLkZzAghyLNn61jmdgUUxT5/mc0dP+3CkXOpaHHUCCK2ksH9sOPrupC5IgDBJHLpD6d
         Kr3g==
X-Gm-Message-State: AFuF++n0kuRGD/ShNLq8BC8jo3Hv2qMcLzlWJgNhOaz7bGyDOqwOwhUR
	+ebSs8ZaHeJR1zp8JsAZr+hTLf4vL+xC+aRX4F0PjxIPIcF6tWzkkJr/Bl5pzBH3
X-Gm-Gg: AYBFou0gGMxN2Fxu2TMP21NwDmFOy4JbGZIEXs+Lg5oBJkO/OmcloTmtBx9GtpZG6mY
	N+KwqTNXfv2Q8GH9dkEK7QzesCjMhEJMQuZgdZq2PrzBJGrfF54u0liN3AAi5mDdmn3V6uX5yyt
	lh3DNt8RzKxzHOSczGpH293ci2XQe86HADd5nj5tlAQjC5RocWfthB6Ncoome3AEm5EX6ZIrMGd
	Pab4i4JmlSpSHwP+PbNdgfPBCbPn6cMOm7Yjbn3m3AUxSbH+Jfc0ZQ1k3BcbBf1iem5c9x6JOzx
	TWZLxdHsI1apa6/pEr3CtGKI84Mo8idz/1IW+zomnqZhEi/q5n5p+k9mhIlYQeEmYqG6+ZjjaE5
	4JqfciLg4LxFrK+tlKi3zGg4yiXM+CpO/2dbQdAIN/VMYi1Qufp0EsEU/VErC3OvGIJ8f9tsOUw
	xc7DkuThBBADqCYAcqRDbbMwDsW/82esM+IAUcQptVrgSBK3ol/4CaCAMFxUiionVK
X-Received: by 2002:ad4:596c:0:b0:912:422a:e7bb with SMTP id 6a1803df08f44-9142f73b539mr67414676d6.14.1790367325925;
        Fri, 25 Sep 2026 13:15:25 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430ecf80csm24412026d6.49.2026.09.25.13.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:15:25 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	sdf@fomichev.me,
	bobbyeshleman@meta.com,
	almasrymina@google.com,
	kaiyuanz@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: netmem: move to index based freelist
Date: Fri, 25 Sep 2026 13:15:20 -0700
Message-ID: <20260925201522.254717-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925201522.254717-1-sdf@fomichev.me>
References: <20260925201522.254717-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move devmem's freelist to an index-based approach similar to io_uring.
This halves the memory requirements for the freelist.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/devmem.c | 50 ++++++++++++++++++++++++++++++++++++-----------
 net/core/devmem.h |  4 ++--
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index a9d86b5a5588..704d02bd8bc8 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -29,6 +29,29 @@ static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
 static const struct memory_provider_ops dmabuf_devmem_ops;
 
+static struct net_iov *net_iov_free_pop(struct net_iov_area *area,
+					u32 *freelist, u32 *free_count)
+{
+	u32 idx;
+
+	if (unlikely(!*free_count))
+		return NULL;
+
+	idx = freelist[--(*free_count)];
+	return &area->niovs[idx];
+}
+
+static void net_iov_free_push(struct net_iov_area *area,
+			      u32 *freelist, u32 *free_count,
+			      struct net_iov *niov)
+{
+	if (WARN_ON_ONCE(net_iov_owner(niov) != area ||
+			 *free_count >= area->num_niovs))
+		return;
+
+	freelist[(*free_count)++] = net_iov_idx(niov);
+}
+
 static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
 {
 	struct net_devmem_dmabuf_binding *binding =
@@ -44,7 +67,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 
 	if (binding->freelist)
 		WARN(binding->free_count != binding->area.num_niovs,
-		     "destroying dmabuf binding with outstanding net_iovs: total=%zu, free=%zu",
+		     "destroying dmabuf binding with outstanding net_iovs: total=%zu, free=%u",
 		     binding->area.num_niovs, binding->free_count);
 
 	kvfree(binding->area.niovs);
@@ -63,14 +86,15 @@ static unsigned int
 net_devmem_alloc_dmabuf_bulk(struct net_devmem_dmabuf_binding *binding,
 			     netmem_ref *netmems, unsigned int count)
 {
+	struct net_iov *niov;
 	unsigned int i;
 
 	spin_lock_bh(&binding->freelist_lock);
 
-	count = min_t(size_t, count, binding->free_count);
+	count = min(count, binding->free_count);
 	for (i = 0; i < count; i++) {
-		struct net_iov *niov = binding->freelist[--binding->free_count];
-
+		niov = net_iov_free_pop(&binding->area, binding->freelist,
+					&binding->free_count);
 		netmems[i] = net_iov_to_netmem(niov);
 	}
 
@@ -84,12 +108,8 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
 	struct net_devmem_dmabuf_binding *binding = net_devmem_iov_binding(niov);
 
 	spin_lock_bh(&binding->freelist_lock);
-	if (WARN_ON_ONCE(binding->free_count >= binding->area.num_niovs)) {
-		spin_unlock_bh(&binding->freelist_lock);
-		return;
-	}
-
-	binding->freelist[binding->free_count++] = niov;
+	net_iov_free_push(&binding->area, binding->freelist,
+			  &binding->free_count, niov);
 	spin_unlock_bh(&binding->freelist_lock);
 }
 
@@ -228,6 +248,12 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		goto err_unmap;
 	}
 
+	if ((dmabuf->size >> niov_shift) > U32_MAX) {
+		err = -E2BIG;
+		NL_SET_ERR_MSG(extack, "dmabuf contains too many net_iovs");
+		goto err_unmap;
+	}
+
 	binding->area.base_virtual = 0;
 	binding->area.num_niovs = dmabuf->size >> niov_shift;
 	if (direction == DMA_TO_DEVICE) {
@@ -279,7 +305,9 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 			if (direction == DMA_TO_DEVICE)
 				binding->tx_vec[niov_idx] = niov;
 			else
-				binding->freelist[binding->free_count++] = niov;
+				net_iov_free_push(&binding->area,
+						  binding->freelist,
+						  &binding->free_count, niov);
 			dma_addr += niov_size;
 		}
 	}
diff --git a/net/core/devmem.h b/net/core/devmem.h
index f71d9a2bcb3d..28d6fa7bcb57 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -58,8 +58,8 @@ struct net_devmem_dmabuf_binding {
 	struct xarray bound_rxqs;
 
 	spinlock_t freelist_lock ____cacheline_aligned_in_smp;
-	size_t free_count;
-	struct net_iov **freelist;
+	u32 free_count;
+	u32 *freelist;
 
 	/* ID of this binding. Globally unique to all bindings currently
 	 * active.
-- 
2.53.0-Meta

