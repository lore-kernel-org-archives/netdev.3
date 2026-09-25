Received: from mail-qk2-f6.google.com (mail-qk2-f6.google.com [74.125.230.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6AA396585
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367332; cv=none; b=Qzks5bGUNoMrYOylysQehoaNxOvId6WfFzRNz207VWdzQn3aYaup55VkI2GXPiDRW/8dQnajFWG287x2dF3RVdUvmPJDIH+1+7WYVxcX3/qT9VGJmSqUK1FSY9kwXG8z8hVoQMY/s+bCXF0B9yDhA56ehKPKpfxkWTgPIAOdKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367332; c=relaxed/simple;
	bh=GxxPmTBlqbkJEX3Y0QUdmhQk9+36K3g7N4gwnnbIfmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B37XVlxOVi2Ec3IVJTmV19HsAHyb9/2fKQiwVuJcLo72oKy6J/1Q8eRprs6DYIKhWcFA3yv9mwBj2ipZmoibQjzJxZ26JmZBrmxostYRKa1yqz8YGM9hJl/JrtPf9vEZBOCPFCqRXI+QpVkFwVPQzZfPc7cYUZWrZf9N3XtvUj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5fNlO80; arc=none smtp.client-ip=74.125.230.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5fNlO80"
Received: by mail-qk2-f6.google.com with SMTP id af79cd13be357-938feece332so73546785a.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790367327; x=1790972127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDsxnmMFwcqjzQxUG7fH5CvkUKPGejMwFETw/62JdIo=;
        b=d5fNlO80abGLIVpMN28Tvib4WM6M/O8gYyGtbqMeFnPdXGB0PaRhKfbd9pQudW9uWu
         IkPlMuzXOanYFtLfkxGXC0GwIAiNvO+Lz9dkSpw6Ry1n871YPOaaaV++fbgOuy3rxzd7
         FfVJhcZDCyGJC2SlbW4KqjeVCGpI/q79R6sVCz41aRDzGq340ZJt3elxj6DdJJI2Rbij
         tcUYQo9HAzG6zhFJsepfCblwTrSZuBi3EXYuZwuUUDidlu20fqkE9YCLkJnWAAk1Ij1q
         ZcEa9XDEroFY9ABYxsyuboRvmG7zzFLYnJNtfsZDrFQcSZ2BL99eku85ZmwzZfOvFD28
         YBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790367327; x=1790972127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vDsxnmMFwcqjzQxUG7fH5CvkUKPGejMwFETw/62JdIo=;
        b=dhIfQHi8Ewallaod3pnSKETmZ9dB2/ftDa4U1MlsI9rAQQkU+BcwbiFbfsIv8uezR+
         6VTWPjSTTkhFf4Q7wG0L4uFsHHvCjH6hX/Mp3ZqUn5iRIBZ8lZfM9JP9OuVcoKdNmhH2
         JTr3ceCQzZ0Q0akHJI4cdAVQ/p9J8SBRg2sITtJE7Fkh9mUtp3wjmrgwoiKfaOIEli8E
         t//6yRv3ZDY+5ApTbvKKC8GBHoWPUkBXB/GSQLdg/IBKBHfAtRYxU2E87WD/hxigChIw
         QyMHGpbareNaf/TLqKzRIij8Sy+8sN48nud3DLLekzwYUNYQvAhT6Tth2Y8SkRai3Ava
         NDwQ==
X-Gm-Message-State: AFuF++n7ttfq11+OCVumxWmjM6WLmaIOYAA5FYIudXT+ic81CPiTlpWh
	Gc3LtWvKn3VpdVn3EBRQVawe4vL226P0hjLfeKNC7dr6xa/ntbvO+4G3APRpDuyr
X-Gm-Gg: AYBFou1WK2hbmzhfHEDpaXMoAHsI7FAksplJGQlLMykpnwcO5gN1UZHc613KZjQkULx
	NDrFBqD4tkyDnDGPJ8a6EuQQyZwX9Hy93SQC9HMAKjgoXPUDmLkGtF1olMoxJ+A3ZkHwh5gwFhx
	9Wt2dDUUvqpPJpJH9qgqMDmA1X9ODoQcuqRBLPKDmMaRInMBOkJ4JIH7QgGptLWg1fSo804e+oR
	wGGSR67MGgH82Hh7+Xb/sE0xJGxEmxEPs+jgJcuT9O5UlC3Un7jo6+gYnllS3uqZ9ycsrutu1i/
	GRy9ZRCHYQbfWYzzkZ30olEaFmKNgBnOszHAO1R9nrFoFJeb413C3tfcUucNmYDng8RHogWDLlC
	GY+6rtLLcjEJP2PZQMVE8idSrQzT56DjGM3+zyNXA+UKynsIYMqcfHoj+tERXr1molBsT2HI/0B
	3IpzUDcefOXVXx3MgMTQxxopUm2Qkxu5YsRcZBG5IU/qMnzvvbql/1HyHS29xJIIUwxQ==
X-Received: by 2002:a05:620a:3190:b0:93b:d79e:18fa with SMTP id af79cd13be357-93c43d34755mr660573485a.61.1790367327532;
        Fri, 25 Sep 2026 13:15:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c448adc24sm263441885a.8.2026.09.25.13.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:15:27 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/3] net: devmem: use memory provider helpers for net_iovs
Date: Fri, 25 Sep 2026 13:15:21 -0700
Message-ID: <20260925201522.254717-3-sdf@fomichev.me>
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

Use public memory-provider helpers for DMA address storage and page-pool
association instead of open-coding page_pool state and accounting.

Zero the net_iov array because net_mp_niov_set_page_pool() ORs
PP_SIGNATURE into pp_magic. Reject DMA addresses that cannot be
represented in net_iov metadata.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/devmem.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 704d02bd8bc8..71c83730d73d 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -17,11 +17,9 @@
 #include <net/page_pool/memory_provider.h>
 #include <net/sock.h>
 #include <net/tcp.h>
-#include <trace/events/page_pool.h>
 
 #include "devmem.h"
 #include "mp_dmabuf_devmem.h"
-#include "page_pool_priv.h"
 
 /* Device memory support */
 
@@ -273,7 +271,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 			goto err_unmap;
 		}
 	}
-	binding->area.niovs = kvmalloc_objs(*binding->area.niovs,
+	binding->area.niovs = kvzalloc_objs(*binding->area.niovs,
 					    binding->area.num_niovs);
 	if (!binding->area.niovs) {
 		err = -ENOMEM;
@@ -300,8 +298,12 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		for (i = 0; i < nr_niovs; i++, niov_idx++) {
 			niov = &binding->area.niovs[niov_idx];
 			net_iov_init(niov, &binding->area, NET_IOV_DMABUF);
-			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
-						      dma_addr);
+			if (net_mp_niov_set_dma_addr(niov, dma_addr)) {
+				err = -EFAULT;
+				NL_SET_ERR_MSG(extack,
+					       "dmabuf DMA address cannot be represented");
+				goto err_free_niovs;
+			}
 			if (direction == DMA_TO_DEVICE)
 				binding->tx_vec[niov_idx] = niov;
 			else
@@ -467,19 +469,9 @@ netmem_ref mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 	if (unlikely(!allocated))
 		return 0;
 
-	for (i = 0; i < allocated; i++) {
-		struct net_iov *niov = netmem_to_net_iov(netmems[i]);
-
-		niov->desc.pp_magic = 0;
-		niov->desc.pp = NULL;
-		atomic_long_set(&niov->desc.pp_ref_count, 0);
-
-		page_pool_set_pp_info(pool, netmems[i]);
-
-		pool->pages_state_hold_cnt++;
-		trace_page_pool_state_hold(pool, netmems[i],
-					   pool->pages_state_hold_cnt);
-	}
+	for (i = 0; i < allocated; i++)
+		net_mp_niov_set_page_pool(pool,
+					  netmem_to_net_iov(netmems[i]));
 
 	/* Return the last one, the rest stay in the page_pool cache. */
 	allocated--;
@@ -504,8 +496,7 @@ bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
 	if (WARN_ON_ONCE(refcount != 1))
 		return false;
 
-	page_pool_clear_pp_info(netmem);
-
+	net_mp_niov_clear_page_pool(netmem_to_net_iov(netmem));
 	net_devmem_free_dmabuf(netmem_to_net_iov(netmem));
 
 	/* We don't want the page pool put_page()ing our net_iovs. */
-- 
2.53.0-Meta

