Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C654734CA
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108797; cv=none; b=eqB9YDcodkYN3/YZLSjMk1p8cfCwtPfoe6Q3knTSa46+OMobknjQmE9GyBSU3johzFq3KTJPLdBkXML5h8hDtA7z/Jsb3+QvRBJGtsZMvH6jhzAIFVYkhY8SyBZQTUn7rmjedw5+YQOyb8cRb0J5s0EpN9Qltetv358QTHvakwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108797; c=relaxed/simple;
	bh=4YjmpMBph23jpmNi5pIu1lAttkg50B5OhEcnauebiG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlrU8IrKgcAh3WLHpF/KxUIIEYFLp1VPMqoWbsFzJXpPvsSrGMP/wAecYKAGzfoPpBuHtgyDNSNfAMF69GhG+2uacxgJfDWeR5px+TvdCbPZRqrk7WkFRmgFmti5LE0TKq/I24MOWwmFw1eObZ4hejhFhZtkvfTIIsNGjLDaA9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF/NP7Tq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF/NP7Tq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4956869750eso24850415e9.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108788; x=1786713588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dtLOE6UfRc4choy+RqQ8hJ7IRsUIafze2ylP3yt/xGE=;
        b=OF/NP7TqcupYoMjWDdtfeDzBL/kKlmB16dd/X8u7tAPGiPzoBGW7nvnuYdznbJmncB
         5Bw7GawwpvQkTZXNWqf45cY5q0gEBUmuHEzZKUfPTCHa7MpS3cgPDSp/g/wAte5ISDTM
         QjSszaG0ZAv56UGRsssd/iP/MH9YKZEbw9wkgZ21KrgcTTBXOm+Ogb6Ho4g9sRz0D/CQ
         yG5+bmWxHeCei4r/DrqyK+y3YgA3xSr9+zVQ4andYKFvlooc8Cgv+EnhJwim5JIU42oe
         OWRya76lCQ5r1cVDnQkYo2mSlL+5rNJufzh7daJbb1lp5BN6iMYVa0gVYpk28Xqkl2Im
         /zDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108788; x=1786713588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dtLOE6UfRc4choy+RqQ8hJ7IRsUIafze2ylP3yt/xGE=;
        b=tJRKcotgxwwfUkXbQc99+rK8IFkGCfHfqkz9YXU0Urf6s2PHLuRm/8BQ82S2MTgidP
         3TX/xu9qTfnDRqn4z96piA3dmY9u+xTLzxzhcOBKnKCj7P/8iNvZaV1drQL5zRR41ZVI
         hpjv7MgxBmPEIyKQuyx7P8WHTR+nkVzvlJILMLkejWJeYUPjwttjcQOR6EtVd+Plfka/
         njONoaQMKdu/LR+j6INmfHLtkxyu5AXGbyttYwRncUwq7snRpPNeSo6veexlVDBfgQdR
         OHYRyQWtWRAIkMheKYsjZMF1X11JlhB6A/V5zhelOxf5jlr/t8fFaVBXIFDL7gY6TEKn
         ArWQ==
X-Forwarded-Encrypted: i=1; AHgh+RrARSZepplo3/a/EZ28O9EgcZ9HLhUaS+NYQSbVU11N/jGKlzWu2ushPbvgkJLgvFTPZULQCL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGCV/DAGCRVnaze+/6umpwag1TUmJ8NbvLZ+h26W7SXzboDwp
	rjEe0DA6vc9qtNy6NjE7Ys4npJ97Mwpk4Iyp0maXI1r76HF1wGMIaXxqWc5dIsk0
X-Gm-Gg: AR+sD12XTKNf2TfuT+u+jgtkVlGPF4NU3G1hzdgQuzFntzyU++lVcWmiVb0DZQskJAw
	DWq4P+IDP1DYa5wrSVe35b+IAQ7CG3VjUWcKMq1uamrGe98V6mozG8CUXBCGfg78N1MzzEB4Jod
	eVg59r1EPBKBzEODJm5uPejdN6GyYhm5rWIwbwKweKQzLqXtItyYS5yejoLfqhWJ/WWSnIdh52c
	uZbRCkRBz4KvbexFREfvVG8ufJJgnxNd2f54xJENM3Vd6+E20gkSg6GK70A4y1qqIljJRusv9qT
	p3H/giblnix7uh8TvBVy9ZuRTo1TVo+OtJ2aQv+GKDCjPfUw+FmFRZObD1VpDLYlVLe3q9vMbdX
	oY/f4w4WJSIGFvsgjbGT7z+U0hRolKKrhXcnYz9jD+vhmpJPiNwaoyO/53btZ/CDusI6sPQfchU
	73sV/sH+m9IzQmOv4PArdQtGFuM2N06w+ng15MuHN7kKaBdT2h/AAe7wNA/LIFyDaUhbwdBJq+v
	/MHimtsnMjdX/OKoz09RBIMP6oAmkDJP05guTudYhxf3Sjf/Vh9bO5iaSDLkIPCaA==
X-Received: by 2002:a05:600c:6b4e:b0:496:bbcb:b0bb with SMTP id 5b1f17b1804b1-4994e7e863amr244964415e9.18.1786108787583;
        Fri, 07 Aug 2026 06:19:47 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm144125015e9.10.2026.08.07.06.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:19:46 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 05/16] io_uring/zcrx: coalesce same-niov RQEs on refill
Date: Fri,  7 Aug 2026 14:19:23 +0100
Message-ID: <71f11d5de47553f187737e0e892ab783b03f53b1.1786108672.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786108672.git.asml.silence@gmail.com>
References: <cover.1786108672.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With large rx piages I often see >10 sequential RQEs referring to the
same niov. Instead of putting them one by one, count such RQEs during
parsing and batch refcounting for the niov.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 56 +++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 38557a9194ef..691206a7721b 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -358,16 +358,16 @@ static inline atomic_t *io_get_user_counter(struct net_iov *niov)
 	return &area->user_refs[net_iov_idx(niov)];
 }
 
-static bool io_zcrx_put_niov_uref(struct net_iov *niov)
+static bool io_zcrx_put_niov_uref(struct net_iov *niov, unsigned refs)
 {
 	atomic_t *uref = io_get_user_counter(niov);
 	int old;
 
 	old = atomic_read(uref);
 	do {
-		if (unlikely(old == 0))
+		if (unlikely(old < refs))
 			return false;
-	} while (!atomic_try_cmpxchg(uref, &old, old - 1));
+	} while (!atomic_try_cmpxchg(uref, &old, old - refs));
 
 	return true;
 }
@@ -1163,6 +1163,22 @@ static inline bool io_parse_rqe(struct io_uring_zcrx_rqe *rqe,
 	return true;
 }
 
+static bool zcrx_put_refill_niov(struct net_iov *niov, struct page_pool *pp,
+				 unsigned refs)
+{
+	netmem_ref netmem = net_iov_to_netmem(niov);
+
+	if (!io_zcrx_put_niov_uref(niov, refs))
+		return false;
+	if (page_pool_unref_netmem(netmem, refs) != 0)
+		return false;
+	if (unlikely(niov->desc.pp != pp)) {
+		io_zcrx_return_niov(niov);
+		return false;
+	}
+	return true;
+}
+
 static unsigned io_zcrx_ring_refill(struct page_pool *pp,
 				    struct io_zcrx_ifq *ifq,
 				    netmem_ref *netmems, unsigned to_alloc)
@@ -1170,34 +1186,34 @@ static unsigned io_zcrx_ring_refill(struct page_pool *pp,
 	struct zcrx_rq *rq = &ifq->rq;
 	struct io_uring_zcrx_rqe *rqe;
 	struct zcrx_rq_iter it;
+	struct net_iov *niov = NULL;
+	unsigned niov_refs = 0;
 	unsigned allocated = 0;
 
 	guard(spinlock_bh)(&rq->lock);
 
 	zcrx_rq_iter_init(&it, rq);
 
-	while (zcrx_rq_iter_next(&it, rq, &rqe)) {
-		struct net_iov *niov;
-		netmem_ref netmem;
+	while (allocated < to_alloc - 1 && zcrx_rq_iter_next(&it, rq, &rqe)) {
+		struct net_iov *next_niov;
 
-		if (!io_parse_rqe(rqe, ifq, &niov))
-			continue;
-		if (!io_zcrx_put_niov_uref(niov))
+		if (!io_parse_rqe(rqe, ifq, &next_niov))
 			continue;
-
-		netmem = net_iov_to_netmem(niov);
-		if (!page_pool_unref_and_test(netmem))
-			continue;
-
-		if (unlikely(niov->desc.pp != pp)) {
-			io_zcrx_return_niov(niov);
+		if (niov == next_niov) {
+			niov_refs++;
 			continue;
 		}
+		if (niov && zcrx_put_refill_niov(niov, pp, niov_refs)) {
+			netmems[allocated] = net_iov_to_netmem(niov);
+			allocated++;
+		}
+		niov = next_niov;
+		niov_refs = 1;
+	}
 
-		netmems[allocated] = netmem;
+	if (niov && zcrx_put_refill_niov(niov, pp, niov_refs)) {
+		netmems[allocated] = net_iov_to_netmem(niov);
 		allocated++;
-		if (allocated >= to_alloc)
-			break;
 	}
 
 	smp_store_release(&rq->ring->head, rq->cached_head);
@@ -1409,7 +1425,7 @@ static void zcrx_return_buffers(netmem_ref *netmems, unsigned nr)
 		netmem_ref netmem = netmems[i];
 		struct net_iov *niov = netmem_to_net_iov(netmem);
 
-		if (!io_zcrx_put_niov_uref(niov))
+		if (!io_zcrx_put_niov_uref(niov, 1))
 			continue;
 		if (!page_pool_unref_and_test(netmem))
 			continue;
-- 
2.54.0

