Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5345E3BB137
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766476; cv=none; b=CkHpG2JlKazdDtQlAqm79fT/OsVeBfodYpZiwpjM1rmOpwyjjUPoga0q6Tzzhl8QO/Cw3Ev1L12efbql4BYiizq4EmauMCx99oaFvKd0LDVmPOz7WJHeAxHi8Oaoo1l/3QztWbbSwPjo3t7VWkulImGMdQnHSb1Io1NOJ3hyc5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766476; c=relaxed/simple;
	bh=+C7cPzjwGMWMdaEB6N7/7Fw5Ykm4MeNmkgQgkpbFji0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0D6ceeyev+GTjPLkOrIPk9/eonzWo2Swxuj7EotJjUjKOaTCj2KgTOxEC4RHabjKvDhCr1GO2i0pCrCMKKcUMIlGHaTnTIYT/QyR1gIivSkR1sHBpekUsFHTOQFxbo2DJ91nAhasScCrugsa+UV7XHR7ior3w8PdJzlbHaR6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxTK7Ye8; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxTK7Ye8"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15ee037bc0so252377466b.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766474; x=1784371274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KLch5rOjo1OUqV8WnEBuRJy4+y7CJW6bTYiu9b+/qjk=;
        b=CxTK7Ye8bgoIAYchoaLCcwAQPjqThiLIlfHMOxAgt8xCQz/w0jzYbw9022B9TpSZYn
         IzA2b/npV7plVnspn+iggNZO5A/W/3dVTu3p1JgiC9GwTNOHGx0ZBQG9aBsHRv/KoWBC
         l9ZTDC6uioB9z4DO2zH707crxYqiTqv2gBzpINYz+HzFv9cwcAdOmZtsTLcCRcg9cq5w
         kO719NzL8fa93T+JhHiMy/Ty+Hn86XafDQOg9wKJxL+n5X20fUD0fidS6fJOrVaBRN9R
         dc8UJnxKvBlH7Ccb7ATVArkDoIZ5A1XV2gXxLeyPHhEJy/YoEg8keBGIoyFcs/44NxNZ
         ucGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766474; x=1784371274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KLch5rOjo1OUqV8WnEBuRJy4+y7CJW6bTYiu9b+/qjk=;
        b=GFQ8Z+3zflzMZt8sCH5bGUcVaU9buGkskhHWt2YbUTCRI0djVkzSBtHMXwtWe1vLvG
         lV0QaZ/DKEQgThTxmkPvPCBnxAVXnvfixPql5HoN3Q3HYjKtTJSWtxZKJcgl57dOxv2L
         LUoOIbPsDZmKFqDTlerzYSaKgXqNmacaD+taQKnsSvPV7vGD1xTXcV2osE/VePLeeNtP
         iCSKORe6Cmy2mjGHAxJWPFDhwfrZ+MPrOgPw+UreX4NjQRd0jNmzTglcpw0rSNT3MW3v
         c2S0l0Xcx+PccN7oQtDtxkfb7nKcY02yOdFBCPG6usiyKALpr7/dEjt39GuAPvBZ8b6H
         23jA==
X-Forwarded-Encrypted: i=1; AHgh+RqJ4Bf47975inSgVsIzfI0XRq+D8HgGICfdjBgaCmACeRN4nDzNl2RUZo0yAmwSqvSo70KkDzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRgB8vsxiDpoEUdVc4NesnI2ek44z/J0mJp0G+wFlBhqXJk24g
	lKYJfpldvxDQ+ZrRsMhCZ7Vk580G5jp4rpsZy04997yy00owETylR7ToXLbNiQ==
X-Gm-Gg: AfdE7ckvDiSP4eTBizDrX+dAEuv+KdwZLaPqH54D2q/ZIHzEgd7AvljNdCUGvOWzZwy
	EHNsrW6GtEOy/ErOQQ1s3OZMEnIpzpYKij4t7sGFTXEg1LqcRj6M8brIbS34u9RdQbo/E/RhvqQ
	/hMl8WWyqxJRFZ660sZx4kk3sUMQG6nqlsYq1tovLEKo0oHmh6gwAPs898LhrLY5EaHnlxX3oAS
	rdqODsUesM3akTMg8C3kFGKIC5fnFBXcH6Q5xpf4y+QYUS3eIN1sJXibyAxPeWoh3ueWS25S0yF
	csYEw6P5R1qKU4HM+iAmDIrxOBY2EcWExf33tehfcBOidOWE/Pmx3Sfa/ztoqNu7qh5vrHuHFSI
	2jZOr9NLa8G40e2FZz88+inrdvZKkB9/CO5okSx/dce57NaCWHFVplhGOE5RyNKoF3OnVIGdRCL
	XoofPxJXIrPsOFBr8TZkeO3aj/ExbtjeT49Q+XAZsKE0s4c1M241xm3bVaApEEn0kQGXNNjkg6Y
	8/7hLydNKUsC1KL5c14+aahL9HGL9uvuNyHHHcI2qwKI+syvQ==
X-Received: by 2002:a17:907:742c:b0:c05:a987:6818 with SMTP id a640c23a62f3a-c161f359e0dmr64588366b.45.1783766473643;
        Sat, 11 Jul 2026 03:41:13 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm483041566b.39.2026.07.11.03.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:41:10 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 14/17] io_uring/zcrx: pass area_id to __zcrx_create_area()
Date: Sat, 11 Jul 2026 11:40:07 +0100
Message-ID: <d40ecb7a6e912bd32ece44a9e4c001c9de05d832.1783616211.git.asml.silence@gmail.com>
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
Message-ID: <20260711104007.WxqXcZhm6htBngsgBrJJTGs9ksyCOlnqWpnEklku68E@z>

Instead of generating an area id inside of __zcrx_create_area(), let the
caller to pass it. It needs the id to derive the user token, and we
might need to know it before creating and publishing the area.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 474ffc217b0b..3f61f942c393 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -44,6 +44,11 @@ static inline u64 zcrx_area_id_to_token(u32 area_id)
 	return (u64)area_id << IORING_ZCRX_AREA_SHIFT;
 }
 
+static inline u32 zcrx_next_area_id(struct io_zcrx_ifq *zcrx)
+{
+	return zcrx->nr_areas;
+}
+
 static inline struct io_zcrx_ifq *io_pp_to_ifq(struct page_pool *pp)
 {
 	return pp->mp_priv;
@@ -472,6 +477,8 @@ static int io_zcrx_append_area(struct io_zcrx_ifq *ifq,
 
 	if (WARN_ON_ONCE(ifq->kern_readable != kern_readable))
 		return -EINVAL;
+	if (WARN_ON_ONCE(area->area_id != zcrx_next_area_id(ifq)))
+		return -EINVAL;
 
 	old_areas = ifq->areas;
 	old_nr = ifq->nr_areas;
@@ -494,9 +501,10 @@ static int io_zcrx_append_area(struct io_zcrx_ifq *ifq,
 }
 
 static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
-			       struct io_uring_zcrx_area_reg *area_reg,
+			       const struct io_uring_zcrx_area_reg *area_reg,
 			       struct io_zcrx_area **res_area,
-			       u32 rx_buf_len)
+			       u32 rx_buf_len,
+			       u32 area_id)
 {
 	int buf_size_shift = PAGE_SHIFT;
 	struct io_zcrx_area *area;
@@ -565,9 +573,7 @@ static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 	}
 
 	area->free_count = nr_iovs;
-	/* we're only supporting one area per ifq for now */
-	area->area_id = 0;
-	area_reg->rq_area_token = zcrx_area_id_to_token(area->area_id);
+	area->area_id = area_id;
 	*res_area = area;
 	return 0;
 err:
@@ -583,9 +589,12 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 			       struct io_uring_zcrx_ifq_reg *reg)
 {
 	struct io_zcrx_area *area;
+	u32 id = zcrx_next_area_id(ifq);
 	int ret;
 
-	ret = __zcrx_create_area(ifq, area_reg, &area, reg->rx_buf_len);
+	area_reg->rq_area_token = zcrx_area_id_to_token(id);
+
+	ret = __zcrx_create_area(ifq, area_reg, &area, reg->rx_buf_len, id);
 	if (ret)
 		return ret;
 
-- 
2.54.0

