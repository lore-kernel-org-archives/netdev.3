Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F5F48382C
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108793; cv=none; b=XRk7dmxwAGFwsjR9+4HtkIX7Pq4s699uwt1bcCYNCXJM6WVHtvYta9TkkFKSoi13HQatOlKY329m3MpU3wDVUf+u5Nd8nViu6FuK3VMFCH5lq2NVCbO9dnBQzr9/7cLhqDp0HAtlUB6wfOF+yBZ8J5g5UZX34LUSWTfvqlh17V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108793; c=relaxed/simple;
	bh=YNIFov40hUqp9gsMSanjwzWLmxPgbJVXr8zcl2rCwnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPjvhKMHV+nCWl1PnxwALDHT149Ms/EQMBIyHFIgaiJolUxhqx7IsYHEN92efJbjsYugalklci/7NWwxWOW6/bIcS37OiV9ONgmIFXxLoaYY1BxDHQ0lS+LzNdfHWol1UdBtaFj3GiokzDTISDquk9x8NdUNEzuduhQjJcsnXTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf+Ous6C; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf+Ous6C"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso18476055e9.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108786; x=1786713586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0tnRR6giXSXeDlizNazE8Bh3pgEh9TxQ82fEMXsiuAY=;
        b=Yf+Ous6CytLBER12J9l/IHYVu5HKj+vPmdYMp/LBzx20Ai+OLtKeToqQQf1nw/o7xF
         F5uFurUuSQsaFq1tJavPF+9dSlS3kanZBq67jyQsY3Fpfqdj0IoC3jpwvvVTxO22upia
         YQ28CK8/UgIOrfeyO3niPeXdDKfMgHMfDXy2S/YmLfpqt6qu1qKHFBnsfYMp9C5WpsgS
         9kPRBYbI5oe2mPDLNBhCmA2aWW5B1+4MmIJlc5R76rrGq4S37ig7+oXqHXTxbv36AvAx
         H6/wA3VhGOwyQ8u7wLT9IPwPkyOgus90yDhyrGEbmKwDX9rplaE/RomZ0t2ETtWA29Ki
         yjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108786; x=1786713586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0tnRR6giXSXeDlizNazE8Bh3pgEh9TxQ82fEMXsiuAY=;
        b=WUPtL7quds8mEfum/pirIUdq/YGM5kfey+gyjzTnvBJkKs4p+4UeLc/u50yJPRqwMO
         p5RiRnit3c9fZ8qhdp/ohkVYLGc6ulycfLZahhdGOHZcsHCzAFHj4oBlkzOWMCuEsKpO
         a68ikqtJvnKB8P/ssD03xnPevUGTeqyNLrORsYEnw39ECKVXqAm9wxFzbj1UR7ehZdFd
         jBB0BBMWsjS8T3abEV9aST6En0x7LPUZQOZeV14jB9SgpUxghcC20yMaDAZuTdJqZ6ah
         9OLfzJi99eyvk+RdofYByqjc7QxufgJw1SgCL10jK5axkWFtVsAXJgTkWVq0jArMxb5h
         1Aiw==
X-Forwarded-Encrypted: i=1; AHgh+RrtaAkUw5OhslxsQDXUKgyEO1FCVuCwG/sZhY9T3sMT1/6YMu5Hhj5Kid/+z2ZO7I56x2WY0uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcbyYUGsxDA/iHhZaRqYeiQ5gzdVvbkKYKaINlSVpYw6XvDiS4
	dxvVFA60i05jOjoLVgggECEaxu5iNXb3LN3D+327t4gZo/h1dtBXgsMR
X-Gm-Gg: AR+sD137wJUuiZ8OBZjTEWDtuInioRPG2bhNopYI8mvomvlTjbEvRZEpKFPIe5XEH2H
	hVocIGzePPFQ6yLkiyhNAMeFUZEidvTjdNPeUidYF3D3zyBIH62Ab37y1DAs2C7e8biQvc7FIoF
	pFP4Gi4VKovndIi1RUdTRMybrDOTP6nI870acm9GU9yc+XjID3uU5iqKI1kEaJUUiQ9HMlQEt4f
	1lTPnSawjTlqOs3q3EiDH5kYNmTFRfKC6k2TwONh6FyeicYvEa9ioTAU/CY4uDS3dB3pTDDYXOn
	ppdK+u01xwFmsrQE6IekUBO5lKeggJ3uLUjNdLGgjiK9flshMBzwMuJaEkwaxZtE3hrE2pYeFqg
	mILr+rbtUqpUJufiKxBGCQClZrgOQDRZK4HB9VzLpUtrjsuTyBPMLDKM2Uv1C3Dx9a9sAvo9iTo
	8eHwtX24VRGJY2B8FfS/fPrjo90wNH4Fpzr71BmCRLqJONnOGOdwXOWsikmni7V0PLVuFZJi8SN
	jujeFhE9INZfmvjZk9IGdbn5khWBme5HHMC33qGRrDcnQhQdTNdaVS5AECOsNl+QQ==
X-Received: by 2002:a05:600c:1f96:b0:493:e365:7630 with SMTP id 5b1f17b1804b1-4994e7cbc2fmr244215145e9.14.1786108786137;
        Fri, 07 Aug 2026 06:19:46 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm144125015e9.10.2026.08.07.06.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:19:44 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 04/16] io_uring/zcrx: cache RQ tail
Date: Fri,  7 Aug 2026 14:19:22 +0100
Message-ID: <b42d2ed8b0e697110b646573b5da2a5f8e85f92e.1786108672.git.asml.silence@gmail.com>
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

The RQ tail is updated by the user space. Cache it to reduce cache line
bouncing. Refilling now tries to exhaust the previous batch of rqes, but
since it could be too low, the iterator is allowed to recalculate the
rqes to process once after synching the tail value.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 27 +++++++++++++++++++++------
 io_uring/zcrx.h |  1 +
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 805424fdd573..38557a9194ef 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1090,16 +1090,22 @@ void io_unregister_zcrx(struct io_ring_ctx *ctx)
 
 struct zcrx_rq_iter {
 	int rqes_left;
+	bool flushed;
 };
 
-static inline u32 zcrx_rq_entries(struct zcrx_rq *rq)
+static inline u32 __zcrx_rq_entries(struct zcrx_rq *rq)
 {
-	u32 entries;
+	u32 entries = rq->cached_tail - rq->cached_head;
 
-	entries = smp_load_acquire(&rq->ring->tail) - rq->cached_head;
 	return min(entries, rq->nr_entries);
 }
 
+static inline u32 zcrx_rq_entries(struct zcrx_rq *rq)
+{
+	rq->cached_tail = smp_load_acquire(&rq->ring->tail);
+	return __zcrx_rq_entries(rq);
+}
+
 static struct io_uring_zcrx_rqe *zcrx_next_rqe(struct zcrx_rq *rq, unsigned mask)
 {
 	unsigned int idx = rq->cached_head++ & mask;
@@ -1110,7 +1116,8 @@ static struct io_uring_zcrx_rqe *zcrx_next_rqe(struct zcrx_rq *rq, unsigned mask
 static inline void zcrx_rq_iter_init(struct zcrx_rq_iter *it,
 				     struct zcrx_rq *rq)
 {
-	it->rqes_left = min_t(unsigned, zcrx_rq_entries(rq), ZCRX_REFILL_CAP);
+	it->rqes_left = min_t(unsigned, __zcrx_rq_entries(rq), ZCRX_REFILL_CAP);
+	it->flushed = false;
 }
 
 static inline bool zcrx_rq_iter_next(struct zcrx_rq_iter *it,
@@ -1118,8 +1125,16 @@ static inline bool zcrx_rq_iter_next(struct zcrx_rq_iter *it,
 				     struct io_uring_zcrx_rqe **rqe)
 {
 	it->rqes_left--;
-	if (unlikely(it->rqes_left < 0))
-		return false;
+	if (unlikely(it->rqes_left < 0)) {
+		if (it->flushed)
+			return false;
+		rq->cached_tail = smp_load_acquire(&rq->ring->tail);
+		it->rqes_left = min_t(unsigned, __zcrx_rq_entries(rq),
+				      ZCRX_REFILL_CAP);
+		it->flushed = true;
+		if (--it->rqes_left < 0)
+			return false;
+	}
 
 	*rqe = zcrx_next_rqe(rq, rq->nr_entries - 1);
 	return true;
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 9ae0bf1c632f..4f8428db4aa4 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -54,6 +54,7 @@ struct zcrx_rq {
 	struct zcrx_rq_hdr		*ring;
 	struct io_uring_zcrx_rqe	*rqes;
 	u32				cached_head;
+	u32				cached_tail;
 	u32				nr_entries;
 };
 
-- 
2.54.0

