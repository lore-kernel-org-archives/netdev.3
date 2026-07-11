Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2303BB9E3
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766447; cv=none; b=leJJkzn9Yct/0Y3PndoJ01ge+BNjuDbxb4qQb7fqXqCZMHjX+J+A1j6g9SIMt8//CqDJnz3NlEIILKWr690k6IhE1eGTVw0d4IrPOEpxZ+hOPpKCQuVpOXYTWc+G6HWhBhYPJaOKPHex6xAE/ekZiZethLgu6COiA7FV0DCA/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766447; c=relaxed/simple;
	bh=vXLXGlirW74iLjcp76e+jYwoFmdKKciWzpMx5TOLBD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNKwwLwzt60hUBkhjfIGfYnv4/WM/oSYIAhvt0+xTQ3k+8eGMOLKVAdg4k5yInAtMT+XwjacXKW+fAabHhOICW8KjXok4YKK7fIi5S9lCwnDQ0bWOQcyUUxnva02NtDbb40dBdL485VQp5vo2BMa2ZOPvYT/AWPlWES6TYx2m/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dk76b49m; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dk76b49m"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so209456466b.1
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766443; x=1784371243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JRXQoFwCCrM5mcf0PRKuJdMsq0ptHmdatjnuBeJf1+Q=;
        b=Dk76b49mhG2iga3Jl2URxqXdJWoPxasK8KME7MLv8WtCL3eWTMIhUIOJsuolaOlV7e
         K6TKA5Y6KGvY/Y08+PxkJWcZwbGscpYY5MPj+HfJg0GztvXgB1NjkXXtlc7Us8u+hcHb
         rG0XkyNiXg9qIL+BVwRG8ZfYej4XZBiKi9kTYcpfvUk8+Ms9cTt52VeqS/1AB2gVe4tu
         yO7yAxeLaAMJ92+DmWzRAKF90vAKMqEQq3krGbUSokC3YDVqSwHUQXaWrbQFgTNW6EBG
         /vHdoUPrcWHXfKtfPfJXRFvvvhRj1oKLIJQ0kKamIS3J+ZTKH16YYl/hbuGdbfI/FMaV
         J3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766443; x=1784371243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JRXQoFwCCrM5mcf0PRKuJdMsq0ptHmdatjnuBeJf1+Q=;
        b=cXHBaHZl0mFxhr5gdsWxSuEXfcp2VMaa705UIauVJV2/mzU9oKoV4xfVlF91/jSBjU
         G4ERiMrbZwHzVqWiqIqGOKIHON5k9mYvBFyumuKp425dVVN1H7jZwWcxmM3WbNKwH+yb
         Vu9YjVJJoVN9JI+su6t3BEkVc8y08Y0NowPVZYGNFOU4BiNalHZnICqnG93m7pwIIaEA
         1X0TeRLZRxEwqRItTqT+ItoHK7btswb3o0dcVKFyh1iosyn0Nyucjcpp2Ee3OYDi+8y5
         iOd8d3LJmX7cJy06I8Gn3aPeu3KQQFKOtniKOoMRbkIB4P2L4zAhwkZIm/8aqUb63UNO
         rewQ==
X-Forwarded-Encrypted: i=1; AHgh+RpKERKM/+mJZmll9e5oWkicCGyQ8WainFB0saS82kDDzHhIk/t0PTRKOfmhsejZJULtD9IaUpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtvVKUh5jMTlhIHyIjEvJX8Y18FZeqYyTdAYNHG7n7WCdQ9QT6
	Po6BX0lfkRVo80K4yFyQIOUIMglT76ms1me5igGavCPUfC7aXyG0q5MU
X-Gm-Gg: AfdE7ckLf2ndV1yD8Ry27TLM1NbyvbWnGWgk0oLd1ZiSNvgawBqG+/r7loxnUXjRQZx
	dQ5DjeKWQ/M/QOeQ/K3SoaupZyQmwUEPKQ3RyXvAGBEvVGMDqpBMVkDbd8JcW9YcudbUqcm1bGO
	iQR5cUQRATapjI9pPA3JToDULOpdMs6cRMD5nVYkXMooYvqkXr5UKi9aPH0J0sUN808CjbjBFFU
	QjnbUQHlk8TbtCNyngredWx5AI+BJHIjeuUQB7lwliXnD7emPhNHSILo1TBOBLGVPtxd1cdsw7X
	zJm5itV3BX1414/b3N9bybrnnhEv95g4Cuv9P1/aigyVMmw2qOuRLpeOf4aLTrfTtvMSNth6ozp
	wtTdiFoq8MEGUn8RmEnYaSmJnOQmIxZu/7nske3rTNcJVQyaczqPf3RkBN8br24K1QATVVzaDnV
	2xCDunw1jI4dPovDW19Sp39k+3Piq4wYksDxlMSWBsxmV51CyQCSGoeN00TUpy+5NfwbsWgbxm2
	4iZgl2wECw4ufCSJYMLct8cGj/tt6CPQY3sfitceEhCSe0Dig==
X-Received: by 2002:a17:906:f591:b0:c12:5d9b:6956 with SMTP id a640c23a62f3a-c161e530d9amr74677366b.9.1783766442893;
        Sat, 11 Jul 2026 03:40:42 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm483041566b.39.2026.07.11.03.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:40:41 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 05/17] io_uring/zcrx: coalesce same-niov RQEs on refill
Date: Sat, 11 Jul 2026 11:39:58 +0100
Message-ID: <267af1e26c3b17fd9fa9b56e4b2316d7412546db.1783616211.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783616211.git.asml.silence@gmail.com>
References: <cover.1783616211.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260711103958.hlViraouRVnJ-N4kcI0nW7GaFlVKC8n2OfnFCWmmM4s@z>

With large rx piages I often see >10 sequential RQEs referring to the
same niov. Instead of putting them one by one, count such RQEs during
parsing and batch refcounting for the niov.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 56 +++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 1b8d748b35e7..cb73dca3c1ee 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -359,16 +359,16 @@ static inline atomic_t *io_get_user_counter(struct net_iov *niov)
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
@@ -1401,7 +1417,7 @@ static void zcrx_return_buffers(netmem_ref *netmems, unsigned nr)
 		netmem_ref netmem = netmems[i];
 		struct net_iov *niov = netmem_to_net_iov(netmem);
 
-		if (!io_zcrx_put_niov_uref(niov))
+		if (!io_zcrx_put_niov_uref(niov, 1))
 			continue;
 		if (!page_pool_unref_and_test(netmem))
 			continue;
-- 
2.54.0

