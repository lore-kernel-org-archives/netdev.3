Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2F48AE0F
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108802; cv=none; b=s9/JdEiJQuFW4d4YSfR0c/UI5Ob0ezAMT/PBtmX2HlH2Zkuu5QtoMS/RnQ8VrDEsZx1CZRMW0gRRTx8e5MUUzGfXbr3AigDMC79+du4pMvvmZsABtlL+HlfKzloYaSrXtODvhpHEtCxCmpu4Rzqy6AcQOCn+9zUgCqOpP8yAh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108802; c=relaxed/simple;
	bh=5pu06JvHixiAVT0qs4ZaZ8MfmBkOaDyNJb1uYUHpmRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQgm7szy8uWFco+Fgu7oWzHxwtuv0dmXRpgukNjV8A1ashrUEV+7JwB5oGG7+PZFn+xJSTyojkoz1lSWqbj0hYU2xUg/El7xJEHoX9WbYi2E2qRmXjyodh2QQk6tPsc5zMAj0KpkSSRa+4qlCdYpP5u6ktyuFVpzMUzxEPaKXf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uq2go7lM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq2go7lM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-495437bb891so18534725e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108794; x=1786713594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EDQ+BBm7w3Gy/ahKim7uXbGBp319WtMN7ZYZ7TfHqOY=;
        b=Uq2go7lMFyf6S+SxwhtWi4RMozGrmKaMYvx56nmwHIZjCsnq09FvFBDwRuhZG+PiqL
         0GIM3s83jWp5qIShVG7Ljy47HAZ38FOIcnfzSv7whF9Hr9F5pJUXUzhbHx6MMLn4j0O2
         aNWMRwA+Xnsge80FMKo/9wJVpAUtwj8rh3K//1z17xpdd3yKJrKq3GiJYedcTWSiWpEr
         kB8Qot7W1Wew6GzZeC8Hznw56fMwuylw7cbRNYV7uJ2KUBaHdCn6d9v2gvptImuc7j/Z
         a0FLzDwuhly/+E9xfiQMqwys0o+QC51GpjgdrSQtQIcmXvOPI3vcgRw3025dtcbKANz6
         c/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108794; x=1786713594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EDQ+BBm7w3Gy/ahKim7uXbGBp319WtMN7ZYZ7TfHqOY=;
        b=EhQhpnrHQYHqZVgA9qV/AvpCXyHvNlWvoVkHUBC7oaF/lzN76rl+3HNUPIVT/cNTaw
         GejkzLallQJ4mJlo3I+MQBTAgXHGxlu7Dee+/mUyI3GsayuD1IHGK19STbf5RbD/cnyh
         7XoIeBBPbNrlzyRarrm4Bs7IU/DNnBx7bY2LaFvnS/DhD3Uz+5RAxUJ/wHY25Lc/Pwgl
         RURhH0UBhBShgvnUX2DwMDwTNjXqsY8ncri9ttJe1aKLQLRNEp4UUnhGy5JkR1zAralo
         eZjNi4isccEUjcsRK15dM/iD6lLpXeL7H0yaPon+5G180v5Yw8yXc3PkgbT0HeUcQXH4
         Id6A==
X-Forwarded-Encrypted: i=1; AHgh+RqPg8Yd6qGGPGRFSiaC7N6c6eXZWKMMNfxJ2LTwL9zjR1je8Uelxz2ScA7jOcMYsAmrdJKthvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3LFIkcF52IDcD2zAIZ2bKS2EtZ9/VH2GMuNF5249Fp//ae1At
	MhZVs51E7OQ5DQUaB3bOhak7cfnQDs3smuO1w1hO1Dp7EpNHtf9mkz5G0CUSOfBu
X-Gm-Gg: AR+sD12e5KAA3SqgJW/4YXW1/bqdfkcAE9wjXTDuRiqgWaCvAfSnz7rSnXOyyQ/Am1Z
	ci/uVhgfkcO1Ilyq4W0YwdIRBmglIDFgC7KoA1ApyDzvePs2KbJct7r6H7e4VAnIgy59ZKMbCqQ
	ONAFtR4Xh8nHVrwh18s7GPYnhIDZWz/+/18YgsuKwXvphWT69kD5uf9/Bs4Ng9H4qosn48X76np
	xO0LoTCklq6ALr90sLGgxVyw5TduYVQ9BY7NWTyfjvgQ4a33yiGOs9FXxigMFLqGuiQwX/TYffX
	ElTO6roXbGBoyVjd+H8qbooZfUXMnUzM1EQ2tJidH42CItdI139g0MmdN0pF1ezwyx6XT57MPHI
	XjEQFFErFZvDciIRoLLJ7VTR7P215pYhAvMmBj72sJg0bMmMF1tT6dzEAW4xG6CXPE/Ii7cfA7z
	02WlJTclAVEQk2l/g9hmtqcraRP9YZNKOT5AmA6XY5EZ76Aj1PNsYg1c4t6/UenhXhnPtacBG12
	vMOsY1W+h2mksOqAvSbqqCj9pHxSnwHhPR8Lf7mZEcYXpQDzKSCanCI7ngz9s5VQw==
X-Received: by 2002:a05:600c:4fc5:b0:497:ff5a:38b9 with SMTP id 5b1f17b1804b1-499553f8440mr116495595e9.9.1786108793196;
        Fri, 07 Aug 2026 06:19:53 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm144125015e9.10.2026.08.07.06.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:19:52 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 09/16] io_uring/zcrx: add helper for deriving area token
Date: Fri,  7 Aug 2026 14:19:27 +0100
Message-ID: <c7752161065a1f7273ce3de9683804dd105c6d53.1786108672.git.asml.silence@gmail.com>
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

Add zcrx_area_id_to_token() to deduplicate the way the area token is
calculated out of the area index.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index bea606beaf4f..5b46e1335079 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -39,6 +39,11 @@
 
 #define IO_DMA_ATTR (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
 
+static inline u64 zcrx_area_id_to_token(u32 area_id)
+{
+	return (u64)area_id << IORING_ZCRX_AREA_SHIFT;
+}
+
 static inline struct io_zcrx_ifq *io_pp_to_ifq(struct page_pool *pp)
 {
 	return pp->mp_priv;
@@ -526,7 +531,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 	area->free_count = nr_iovs;
 	/* we're only supporting one area per ifq for now */
 	area->area_id = 0;
-	area_reg->rq_area_token = (u64)area->area_id << IORING_ZCRX_AREA_SHIFT;
+	area_reg->rq_area_token = zcrx_area_id_to_token(area->area_id);
 	spin_lock_init(&area->freelist_lock);
 
 	ret = io_zcrx_append_area(ifq, area);
@@ -1533,7 +1538,7 @@ static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
 	area = io_zcrx_iov_to_area(niov);
 	offset = off + (net_iov_idx(niov) << ifq->niov_shift);
 	rcqe = (struct io_uring_zcrx_cqe *)(cqe + 1);
-	rcqe->off = offset + ((u64)area->area_id << IORING_ZCRX_AREA_SHIFT);
+	rcqe->off = offset + zcrx_area_id_to_token(area->area_id);
 	rcqe->__pad = 0;
 	return true;
 }
-- 
2.54.0

