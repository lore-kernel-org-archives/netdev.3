Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A748CD75
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108808; cv=none; b=ILgRBpDY99m4mIVM2RHmhOfRJcY7bUDaZgop99bUmq2WeW/OwH7v9qdsLGpRF7YKRTU7NypVOAHU3lzOs6mwgDdV9QwPj8bhsWdjQA5fd2dhGd4bs02uYU8Cx6F/brzRv1FS3w8dYOuryILrCOdTQWjC6x3e/SvDZ0mAbw6vJQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108808; c=relaxed/simple;
	bh=whO3+w/ZTNGenAN5nZvoSYf9oSxjpzGFNNUFQZP8NFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHTv8d5WQBixmirtM2QdUTB8ElZrQhlV2a+qjGbi+x1BT6oI2ZODSImPbwcrcKPMsEtv4hyGy50nsHsDkSUX8qJHHtLh0am/Qo/Gf9FlqXRmwXOS6s0SRw2m+r3liDQicD4eYTTOQmqLSCrDy2XhUWPV9puSIk8mz2Kb4omt7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9CG6Hmh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9CG6Hmh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so17818315e9.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108801; x=1786713601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cqYb2eoQn70P2RDf/h3UF8nL8mb6Z4ebRKt/6kWIC1M=;
        b=L9CG6HmhmReO1NS5PcFpylqrPF3kOBEkLpWMJhGdx8PD3qM0Y+DmhdiwSwyzf7ezTH
         hk5u89n912eki59N6apo6NlsXscb4TD5FOzKBAE2vHa8VykyOj23evQS4214T2tEANXr
         gES6rwhPfuMlReqXURcsjSkfEwG72hx9fk8UCp+fvBEekjdy4ecnsqamq3QV899412MA
         WVr1KKaSR3TpSgWYkt0Snp8ZYm6P53E9BgrpZcjiFfPI3JvVf1B4hY6i/di3xljuovR2
         NKBa/02bMAfMnjKRKgAr+ol944dbsPDyjWtLR4IYZ2LcSW3igCvjDqCINVyBqhOybSnf
         ZvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108801; x=1786713601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cqYb2eoQn70P2RDf/h3UF8nL8mb6Z4ebRKt/6kWIC1M=;
        b=Y0NEpGSoOI9qSaSCFGnptnkquBKAhuU6s5VEiPsDc1gU212JVnPJXlH0bbo4llXYl1
         MHByMu9902oG25AyUivBgKa2z76MLkaXMGNyHA0vOg5RyFwaK8KLELb8kznSMpxNKocB
         K5eHs8fIVzat2t3aLcqoucpjB/jTid3RxHjcN88czjobW91kSoXuAAYOD2c2Kh+CXu9W
         txDp7OP9ZyPpS+tBsJd3mfoNwTBlQMZlWDv+zNRmrS58AqspX1MWeD+O9c+AD+Y7igoY
         UrWClwDbrsgX3LpmVtP6RlFsyTrZtIaPnoQl4KeTkFO2Qw+QhAGC7mXDQQl7br7jTkwR
         Vs1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqRKBllemwP1TNi9nPRxYkNskmT9cXt9SP0cJjpHxsWcbaC+OiMtrcrQLyTUvamQiw2uoeoxuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhsWq3rKrf1wuXMY9KUYH/elXHbvRwMT1Z1qLtJaDghkfjCoOM
	Yy1JNlmwScL9M8AszMIrHJ7j3IPIB4ek3wqWgKRVjja2Qx6gRa/+0FFdReSCCmoZ
X-Gm-Gg: AR+sD12Guvf9T3o24c1r7NGXxEweRv+lncQwSdI/jXn21xExqxmJjTwqUQHx6PEopM5
	WtALEtahVBrA0ae3lIxbMurZ/wfiihUWl1rXoItj/JcrNIM8BqCBdo4eOfktiruevMSJohjaM1J
	1I4lQnf9tOvPB2023snMgviVNIjjuzUoBdyDpwqXcVIWX/g9aegCHo55ZwE0ZEXbCaEtg/zobVU
	2NLqsjemGQP27MairIxPDLl4utRvp0RwyvPr/atWBPAJpxMijVPWSrDFjpkP9mGz0QssS8ztzua
	aQhcIOlVy1jFXWpmCrX9gpiWZkeZIcBXWN7a7lnr2nOK1yhdumqJ2HfRalJ2AvbrQXtQZCo0pgW
	uf5BFRyKzcls8M5iSjnn8X2krnk/BodY8cYqEEMtglgiuQ+4dwkv6C1dsHShrOXixSthyDJZGdc
	1br1QvQR8YH/0nVsis5mH8CB2AD6lGC6Xd9D2DVsXgKR5Q3EXUFt2zhyPiD0i+nVKmYE5Ruu26E
	LGpd8oX9iJ7Jf6CC9pZ1MGwZVTWgJU6zmyTMKXk4oIsEnxBojQ4tfM8FzqtMcHeaA==
X-Received: by 2002:a05:600c:1d24:b0:496:c9cd:e7ab with SMTP id 5b1f17b1804b1-4995e08452bmr52792775e9.5.1786108800794;
        Fri, 07 Aug 2026 06:20:00 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm144125015e9.10.2026.08.07.06.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:20:00 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 15/16] io_uring/zcrx: lock area creation with pp_lock
Date: Fri,  7 Aug 2026 14:19:33 +0100
Message-ID: <a667399971120227a28d54ebabc50e707f717bf3.1786108672.git.asml.silence@gmail.com>
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

Protect __zcrx_create_area() with pp_lock. It's not needed for now,
nobody can take the lock in parallel, but we'll need it for dynamic area
creation for avoiding races with the device dying.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 8de142856795..fe36520994e7 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -330,13 +330,6 @@ static void __io_zcrx_unmap_area(struct io_zcrx_ifq *ifq,
 	}
 }
 
-static void io_zcrx_unmap_area(struct io_zcrx_ifq *ifq,
-				struct io_zcrx_area *area)
-{
-	guard(mutex)(&ifq->pp_lock);
-	__io_zcrx_unmap_area(ifq, area);
-}
-
 static void io_zcrx_unmap_areas(struct io_zcrx_ifq *ifq)
 {
 	unsigned area_idx;
@@ -508,6 +501,8 @@ static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 	unsigned nr_iovs;
 	int i, ret;
 
+	lockdep_assert_held(&ifq->pp_lock);
+
 	if (rx_buf_len) {
 		if (!is_power_of_2(rx_buf_len) || rx_buf_len < PAGE_SIZE)
 			return -EINVAL;
@@ -579,7 +574,7 @@ static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 		return 0;
 err:
 	if (area) {
-		io_zcrx_unmap_area(ifq, area);
+		__io_zcrx_unmap_area(ifq, area);
 		io_zcrx_free_area(ifq, area);
 	}
 	return ret;
@@ -589,6 +584,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 			       struct io_uring_zcrx_area_reg *area_reg,
 			       struct io_uring_zcrx_ifq_reg *reg)
 {
+	guard(mutex)(&ifq->pp_lock);
 	return __zcrx_create_area(ifq, area_reg, reg->rx_buf_len);
 }
 
-- 
2.54.0

