Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01D48D86C
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108811; cv=none; b=UwKmvoP6ltS+/JaMx9FEcUsPnz09ZZCDilwaSu8E7nfrbE5jYScw5tHrhwujTtw9EqBoLh3Cm0r9PkCCAdVuo6OGrQzrBIomoiAlf1wyaUEMfdZzYMv3IcDGSwyvq4p4LBx7UmIiTqwMWSuPT7x13G0o1k+6C5stppZLX4Ory/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108811; c=relaxed/simple;
	bh=/3HagUJ4Pybmqpr0Qi/Ixj0J+wo2YovCsMOIKJULDxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3hHY2JHZpNjDUCZzGmWuQGNBfxE1WrAHtl39/kB+OCYWmPGgQH1QYWHTbaQ/2YEMGFmJs1/Qc+NDXF1wvbONG91sYboMnUfU4QQJorJToWC6G/5V57552YKtqPDfY36Jj9rIvf6w0SlEnivPBNr8W4KiMJ4pWMCXfjsTfmAI9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N15rTKf+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N15rTKf+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49800c6a846so27564495e9.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108803; x=1786713603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PppqanDeaBzdghzKyGwgkSIodmXbiybUfG6LdKWWozc=;
        b=N15rTKf+Opc3GNev0KZaSii55J/QSzjMUbEgk8FX4D90Dk6FDekVNRloxjOf+R+6uN
         7GcRuU/zos/h9lZXAIcoz+c3HwRVsKGvfVKXAlXE7hlkSOvy1kEod0kIkP8YIyiWOH5i
         ipeESqzUWo1nXUAL+hICuR92EHl92CQDx+2EFw+Hq1/9JysbzfY8K7mtTAI3mWNnt0m7
         8G3OB9gmsCwEr2d0p4NE7x9uvrR+vXO9vxVqpyak/2c9a6oDcwFH2sdHOeZrpmU9FivB
         5TiIqjC8z8Ur8orBHtufl8zOz9jrkazk7qKN7A3isEMS4UuNTps5fgprT+axJziv2wvN
         PcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108803; x=1786713603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PppqanDeaBzdghzKyGwgkSIodmXbiybUfG6LdKWWozc=;
        b=kSwN54qplIh1IxEMK1i+41mznQDwJ4QOWrgB4+fLu/wmppubVoaKIPWAOodUkX3sfK
         3C5Xo1YqNE5wytFe10k5NPtikyNHX5Li+J2pD/2GLuUtCd3lkXuPMkCTvG/R2YlgxT4J
         PrM/uBM8Y4qkjEGCM7tzVk3YewfIFVhPAlh6FFZtS7rUlZ7k5I6jNQ2OsNUcnyJXb5wR
         OyOt/fiaphHNnu6+OqYwxOZUkYvLUIEK5ujMlEBZUq/zbnGDrG60VBJr8ki9H2vIU8Wy
         riFV9FirdkdF0oles/2p1ZCcBnXk5PFOkvqwrJVs5TQE7vt/WQV55LyQny3g8q9vNUk1
         YioA==
X-Forwarded-Encrypted: i=1; AHgh+RrDtQU2mFvbui2KxqbRlwS2r3oyefmIPnpqBTRX5Q7HU/eZFCRXXWT8hrbQHmg8TuGmShfQ2Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3BwrZCTXjcwJum7g4T2NWGz6taGgnV0aX8VWuYn0grwPTDMOU
	4SyhvIZQVi/4GyiJtfwVk89IZ8J+DEwMTNvqsiKfsPHA4/sM/DQ5IoiT
X-Gm-Gg: AR+sD10MchLKWgmzDfd8l51LW4e10qqm0/lTAc7U4q6OVGC7g4iZOIzmDlmRA+HmvCD
	YxDVJOdWU9R8EXBs87OeCPKqtudLP55fejRwPBXuQvMQf2txrZKpl+6IZMyMIdB76n7ebBlmGCD
	g1s/K3HqAaB36NUCfoeBBrrWdCIL976nAp1qMe9h36CsfHWFBiJhvcIjpogNFdWry4tdydAyxJj
	UKYPCSP2GrHT314X3Ziry4F8XNWlnbacyQTdyS+vpTMboLanwiZEVmyzGiOV8OKhjjWRbv+c9B1
	0ZGSHJbROX5Lw/cU5HddPufnQhb704B99KHEZ91G2t7T9po/J+w8gjo3bfVrzdkJ6bCzUUEY3S2
	2aVMZR20FwvSutqwP3nmm59Yv6MslWGmiparUK9ynQbJxxE8PCg8wPRYwfYkHDvLP1Mk7z5rvQr
	xeDNF34AlpYKfqfsCZNZbL7xy4/aHeP+04dqwDKGEfb39B1CVbsy/d4pJszdEHDD3Aj4zejSrwt
	fsnyznFNkHlkuFy+C63mTyFVlTT/YMdNT5yPMVnDDBth8XevPkykmeBfeS6a4/nXLg=
X-Received: by 2002:a05:600c:4f4a:b0:499:51f0:a9b2 with SMTP id 5b1f17b1804b1-49959e0179bmr112603675e9.1.1786108798795;
        Fri, 07 Aug 2026 06:19:58 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm144125015e9.10.2026.08.07.06.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:19:57 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 13/16] io_uring/zcrx: move freelist lock to struct zcrx
Date: Fri,  7 Aug 2026 14:19:31 +0100
Message-ID: <be7feadff1e210861433f99fe44170aa27ec5b33.1786108672.git.asml.silence@gmail.com>
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

freelist_lock, which protects slow path allocations, is currently stored
in struct io_zcrx_area. Once we add support for multiple queues, we'll
need a lock in the zcrx ctx, move it there.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 14 +++++++-------
 io_uring/zcrx.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index be3560739bbc..3cf5e456990a 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -542,7 +542,6 @@ static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 	/* we're only supporting one area per ifq for now */
 	area->area_id = 0;
 	area_reg->rq_area_token = zcrx_area_id_to_token(area->area_id);
-	spin_lock_init(&area->freelist_lock);
 
 	ret = io_zcrx_append_area(ifq, area);
 	if (!ret)
@@ -573,6 +572,7 @@ static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 	ifq->if_rxq = -1;
 	spin_lock_init(&ifq->ctx_lock);
 	spin_lock_init(&ifq->rq.lock);
+	spin_lock_init(&ifq->alloc_lock);
 	mutex_init(&ifq->pp_lock);
 	refcount_set(&ifq->refs, 1);
 	refcount_set(&ifq->user_refs, 1);
@@ -647,8 +647,9 @@ static void io_put_zcrx_ifq(struct io_zcrx_ifq *ifq)
 static void io_zcrx_return_niov_freelist(struct net_iov *niov)
 {
 	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
+	struct io_zcrx_ifq *ifq = area->ifq;
 
-	guard(spinlock_bh)(&area->freelist_lock);
+	guard(spinlock_bh)(&ifq->alloc_lock);
 	if (WARN_ON_ONCE(area->free_count >= area->nia.num_niovs))
 		return;
 	area->freelist[area->free_count++] = net_iov_idx(niov);
@@ -658,7 +659,7 @@ static struct net_iov *zcrx_get_free_niov(struct io_zcrx_area *area)
 {
 	unsigned niov_idx;
 
-	lockdep_assert_held(&area->freelist_lock);
+	lockdep_assert_held(&area->ifq->alloc_lock);
 
 	if (unlikely(!area->free_count))
 		return NULL;
@@ -1251,7 +1252,7 @@ static unsigned io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *if
 	struct io_zcrx_area *area = ifq->area;
 	unsigned allocated = 0;
 
-	guard(spinlock_bh)(&area->freelist_lock);
+	guard(spinlock_bh)(&ifq->alloc_lock);
 
 	for (allocated = 0; allocated < to_alloc; allocated++) {
 		struct net_iov *niov = zcrx_get_free_niov(area);
@@ -1564,14 +1565,13 @@ static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
 
 static struct net_iov *io_alloc_fallback_niov(struct io_zcrx_ifq *ifq)
 {
-	struct io_zcrx_area *area = ifq->area;
 	struct net_iov *niov = NULL;
 
 	if (!ifq->kern_readable)
 		return NULL;
 
-	scoped_guard(spinlock_bh, &area->freelist_lock)
-		niov = zcrx_get_free_niov(area);
+	scoped_guard(spinlock_bh, &ifq->alloc_lock)
+		niov = zcrx_get_free_niov(ifq->area);
 
 	if (niov)
 		page_pool_fragment_netmem(net_iov_to_netmem(niov), 1);
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 4f8428db4aa4..18de02716453 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -37,7 +37,6 @@ struct io_zcrx_area {
 	u16			area_id;
 
 	/* freelist */
-	spinlock_t		freelist_lock ____cacheline_aligned_in_smp;
 	u32			free_count;
 	u32			*freelist;
 
@@ -66,6 +65,7 @@ struct io_zcrx_ifq {
 	bool				kern_readable;
 
 	struct zcrx_rq			rq ____cacheline_aligned_in_smp;
+	spinlock_t			alloc_lock ____cacheline_aligned_in_smp;
 
 	u32				if_rxq;
 	struct device			*dev;
-- 
2.54.0

