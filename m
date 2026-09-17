Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792014FD26E
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668684; cv=none; b=WViKEFLqnKLrd+Duldu9f6/nl+EyYnC/o2nng/+gPb9kXct5W4bJBB9IQqKBK5pHxxgJdchbt+Xoqvgh5/Vrv1aUmyaGL0P3zDoc7Vjg3+ymrG4wIPrw0FHd++czwHAREBbWkEUky440DfKkJwC1D/jWCcf9EMe1irMuC3xJRUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668684; c=relaxed/simple;
	bh=sOv9MrPuMkxhkcI5OSCAWCad/gcsIcyR0kbOkg9j3E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjyTinEDZHMixCJwk2yBx/xMDdVcwDcyOEVBp0EB9RRnDigAlJgRkb8rP3G69CWyDuQghPNVEEy/63yRB9clh/SzaxRHdSvCSwKVZY/g7obrxG+5E06Nq54qwXdvKk6Cg+ct4AXUXEmanfL1UV1BTcKJIRxlB4bxBZQzp1ATilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnEOWWpb; arc=none smtp.client-ip=74.125.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnEOWWpb"
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cc150711112so155508a12.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789668680; x=1790273480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9MPaV07+oksypE3IXx8WkM76dXMLUQTsKgP+7C1tfNM=;
        b=FnEOWWpb0MWL2Yn4HxqdNuCy5vkfBT0V6t2RdHHdU3Oy/JSZNgGhKdEEvTw8Dpy7eo
         ox3zrXeSgf3m+suHMh6J+GJ/b704pBebS4nLA5QLm4ft+1DgcnE6kxecDsGQm0STb9FX
         sX6FORCFU1ui22rBDRUj2Oh1hYZVLFl4BejgaAwjr4FCb5/7VsAhcUuEp3uycTaJuMOe
         oV8JFR7G8p9y11HCiPto5/n2WCEcIPKYOFYNOgupQnuYc18nwQHUsQlYuXVJ9Aw47vyP
         7IT3cYjAygUUnnjfAdOxGe/BDF45xVszifBHFPBe0l/3WUDn7k888SR22RYM/NWnMPHP
         zOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789668680; x=1790273480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9MPaV07+oksypE3IXx8WkM76dXMLUQTsKgP+7C1tfNM=;
        b=fNPRtgAAu7KHAsKjnfRdmGJcJW0PnaNS9045EB5O3oUoLFna8foLKnVPGV9LoCjpvH
         PtKSDH/32UlrHctupHuKnhhX+nFG7Ffd5/kjD5DLhL8QqqIxtqPyJMLRFo6gaonfkZWY
         6kYR62jaEIFLiaZEcymBZ8vah8E4Pf/7DeGgZJT36V31V+fAw3EeO3vXch7rnOOiMyWe
         6fsgdhq28KOs07FV5w2mzTrqansz9A1Ia1YRiRJe6Z8pIwe0u/rIz8h1pCK/pYhD39Xx
         y/57hEjknXKNw0gEtkrZ4I1qrcS3KqohAGCy/cthjJHTkW4t6SUht57EVFFJ19SpklfR
         aHBw==
X-Gm-Message-State: AFuF++mqKJx2aCV9RVsLm2kKMh4ZG2qMb9CBrrvh6diMsi8k2vGbHXrB
	aF54yLyvSsIYs8Pi8do1x9kUOxxv/VPbk/m96TxMKjuesp9x8yuwUm5m42W31Yr8
X-Gm-Gg: AYBFou2OghLV6QifyK+ier8Ok293KUzAKEBQAz9JX/sXDZtn7EVd1O1Zcbe8sTDr9/2
	/YZQmttg49MbZMjmJglht8/CMR/BOoZQRDKaajejtOeuIzBgyTXTJDjCtTviycQW11+f2b4LdQ+
	W3cBca6Uz+U6STlRW0jYLSPgcs7bAELSKRp0dvF8TzmdhCn/8UoL3S9cBzZu9I27dNLe6ojRrQv
	H5dQ+Ml4zp7zdAYBaUkGTItRPZfCYCB9VWXiypQ4PWqqoK/f0p4zUFJXjE2QqOHdC6Bv24OcUyt
	XWSgq7u/Qxr0HTxqZo6fxsA0zBlzxwgWkE/TlU0skp4AlcSFAYhIwkbV6pzY2JlRrwsXSl35xCe
	tvUiwQ9yRzMjQuqLuHPjk3b940bjbmkCfu41l7/r4c7l225eHScn6N7TdIw/RU6YxqdHHSTJR1Y
	Qz+lKzCAj9/8nv0344UXjBWg5S5pkgdCcmcBq03oAx2cAESfI620ekrVwHT7gAkcA=
X-Received: by 2002:a05:6a00:a112:b0:84c:5b65:ef86 with SMTP id d2e1a72fcca58-87238f87793mr13313083b3a.17.1789668680213;
        Thu, 17 Sep 2026 11:11:20 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50c24487bsm3366301a12.12.2026.09.17.11.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:11:19 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	bobbyeshleman@meta.com,
	almasrymina@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/3] net: devmem: batch net_iov allocations into the page_pool cache
Date: Thu, 17 Sep 2026 11:11:16 -0700
Message-ID: <20260917181116.3319017-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917181116.3319017-1-sdf@fomichev.me>
References: <20260917181116.3319017-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename net_devmem_alloc_dmabuf() into net_devmem_alloc_dmabuf_bulk() and
make it refill page pool with up to PP_ALLOC_CACHE_REFILL NIOVs,
similar to io_pp_zc_alloc_netmems(). That should amortize recently
introduced freelist_lock.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/devmem.c | 57 ++++++++++++++++++++++++++++++-----------------
 net/core/devmem.h |  8 -------
 2 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 7cac0dab8ea8..a9d86b5a5588 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -59,24 +59,24 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 	kfree(binding);
 }
 
-struct net_iov *
-net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
+static unsigned int
+net_devmem_alloc_dmabuf_bulk(struct net_devmem_dmabuf_binding *binding,
+			     netmem_ref *netmems, unsigned int count)
 {
-	struct net_iov *niov;
+	unsigned int i;
+
 	spin_lock_bh(&binding->freelist_lock);
-	if (unlikely(!binding->free_count)) {
-		spin_unlock_bh(&binding->freelist_lock);
-		return NULL;
+
+	count = min_t(size_t, count, binding->free_count);
+	for (i = 0; i < count; i++) {
+		struct net_iov *niov = binding->freelist[--binding->free_count];
+
+		netmems[i] = net_iov_to_netmem(niov);
 	}
 
-	niov = binding->freelist[--binding->free_count];
 	spin_unlock_bh(&binding->freelist_lock);
 
-	niov->desc.pp_magic = 0;
-	niov->desc.pp = NULL;
-	atomic_long_set(&niov->desc.pp_ref_count, 0);
-
-	return niov;
+	return count;
 }
 
 void net_devmem_free_dmabuf(struct net_iov *niov)
@@ -428,20 +428,35 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
 netmem_ref mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 {
 	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
-	struct net_iov *niov;
-	netmem_ref netmem;
+	netmem_ref *netmems = pool->alloc.cache;
+	unsigned int allocated, i;
+
+	if (WARN_ON_ONCE(pool->alloc.count))
+		return 0;
 
-	niov = net_devmem_alloc_dmabuf(binding);
-	if (!niov)
+	allocated = net_devmem_alloc_dmabuf_bulk(binding, netmems,
+						 PP_ALLOC_CACHE_REFILL);
+	if (unlikely(!allocated))
 		return 0;
 
-	netmem = net_iov_to_netmem(niov);
+	for (i = 0; i < allocated; i++) {
+		struct net_iov *niov = netmem_to_net_iov(netmems[i]);
 
-	page_pool_set_pp_info(pool, netmem);
+		niov->desc.pp_magic = 0;
+		niov->desc.pp = NULL;
+		atomic_long_set(&niov->desc.pp_ref_count, 0);
+
+		page_pool_set_pp_info(pool, netmems[i]);
+
+		pool->pages_state_hold_cnt++;
+		trace_page_pool_state_hold(pool, netmems[i],
+					   pool->pages_state_hold_cnt);
+	}
 
-	pool->pages_state_hold_cnt++;
-	trace_page_pool_state_hold(pool, netmem, pool->pages_state_hold_cnt);
-	return netmem;
+	/* Return the last one, the rest stay in the page_pool cache. */
+	allocated--;
+	pool->alloc.count = allocated;
+	return netmems[allocated];
 }
 
 void mp_dmabuf_devmem_destroy(struct page_pool *pool)
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 6ed16b4b4687..f71d9a2bcb3d 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -131,8 +131,6 @@ net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
 void net_devmem_get_net_iov(struct net_iov *niov);
 void net_devmem_put_net_iov(struct net_iov *niov);
 
-struct net_iov *
-net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
 void net_devmem_free_dmabuf(struct net_iov *ppiov);
 
 
@@ -189,12 +187,6 @@ net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	return -EOPNOTSUPP;
 }
 
-static inline struct net_iov *
-net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
-{
-	return NULL;
-}
-
 static inline void net_devmem_free_dmabuf(struct net_iov *ppiov)
 {
 }
-- 
2.53.0-Meta

