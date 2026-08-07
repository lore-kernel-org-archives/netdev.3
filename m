Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572DB476043
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108791; cv=none; b=Pz88GLSW1NEdIPO06gya91sXtvsvaU566JD4Wx6MmSi4JynM6pZN3woVlkVknKfjd5cJY7DtU0QaV0jUBYYrTZlHpqP+qqSA5rliXUofVRTqWrgneWMa9yGBMBq/k1sov9RXQDFSdImWz9TQYs6HQUStUKEl2jlTRpSyfceMfsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108791; c=relaxed/simple;
	bh=ZgqnKArZCI2EXH82gGXSW7OXUUPOI1Y3jnknJv3XLXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VR71iV6+XOFtGIxj6oL4Nt/dYTtGVX1vW9j6T3KdKar+M9BOMKnQWfXBwEn6ask6OwjVSBtTOdGA0X0hPKxd9s4xF5Swz/RqwhBe5a+6il1wO4InGEoBlVibb92c+z1CIZq5OMWdyb31eBylgR5okBUZaxGeecFoySh6YuGd7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKIqsu60; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKIqsu60"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4994c49f588so20309185e9.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108783; x=1786713583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=04ukqcX/ZygaPdAqIVl2q03Si6kBkAxVKqngIh5MFOs=;
        b=HKIqsu60Bh+3o4Uu+M6eb+u9MlWyyGmHnSdTRHoT4nXS5yM/9AbUwNJ8r6Tx+0G2PV
         cBnzYSBPsAVMlBmf3SKeFlKIFIr8uyDNKPexvoLd70xK9w55iH6wTdwMAVP1dV4slN9W
         1pYnmlJK7JaKbeySGyqwIGaPqnsVQdrzMV0kHY/3K2KR36rc5sVoAwtAtOR06dlokBwN
         f1fZnLea0OU5VDpMtBsLVf5Y++kucZh+wsQWa79cT55KCRqANZEu/IutbmSOwrxxMOB2
         2VROoYoVPpnPg/ikJVboUE94kiSOWofD7VRvy7stz8K+nJI8OuB6EtXQEYT9AfQo+g5m
         A4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108783; x=1786713583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=04ukqcX/ZygaPdAqIVl2q03Si6kBkAxVKqngIh5MFOs=;
        b=L8bU+sBZrrRexs96qsd0arGjUFIfpGvk63hbhmaLEOX1pqjZzRWkmxBGB5bYUHk9K1
         Vronga0qTtiW2IyLGsu/ymliqe4sNrlXUKjLdJdAIckpdPwxQfefmcEehxUbHKjVyw5i
         mRTYzinmy/9iRjJapCss8b3zdi7bDZd/EMe2Qrl8QiDnC7MCWvLCkonF8jQpgRmhJBE7
         IAIoLw/+UynHO2oOoPyaROfcZF/LCyTfg77TXnRTs1LPmAep42WOHcvFuYkHaMcs1Gzq
         bk4AsFu2EqfrqeAWW6+2owbcVmaj6qE/WsIbdY4evWdEVjwXJJ1xIa5QkgGYoVAiUr8Q
         mgtQ==
X-Forwarded-Encrypted: i=1; AHgh+RprzU6K/TcVgsVuKX0Dluzabvpd1Pka5X8BSMR8zUPCfiADVobAM9mEi6K2eayLmspvvGbvxFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0VKbMcgkawUWidGbubrJ0iXECqyZ6sxUidGYsrJkYyYArUiSj
	9QGXoYkLj6e5hTgaENfFnWMWRdmgjsF56l+gbP0xO6jDtr/HhJjXxghnXg3alA9I
X-Gm-Gg: AR+sD110Gj4XZwjjy45Lias6LsaDGoEu0j5U44XICCYkHUZJlvBMlkblXdiCUQ4ilGd
	+GO/YsYFcE57KXXCA1gA4dwP02GNAnekUvBmUozCnJ6+jh8KDBC+vCm/vmP7cX49w1WGGmj5C7I
	PGivONVuWtXPb/OqoSmgW0iZq6rp4tN+4EJCvuoUk/WsrPv/pWx+QzLVAnM0jDbZtnw0Lh628Ki
	g5TnleEmMA27LXuaMZ9IizCe/yr7Unvf5v1+sfvlVPoESd+sbwVxA2sjBFUFkA2U6ruEGmM4HDP
	iwhvAMHNGKxRbClVvXrYPJBb2EilwiwUrBDSLaEMcAY/465Ghj00HVrEdcqDiPw6ihB+Mh8HzoY
	z6r7q5Cs6dWa+fgpBmzF2/FwbiLn1rwj3QeA8LssgWOTTsUV44hAXwG99XIJMalM6hUVXdA2z0D
	5dC9kzEcWOU6hPOP3FO/F1vymlKERY0dEuhhqov7t+P+E1STrxEuz4HnNxvVsWKsUZF5nnPWx7A
	raTX1MrZfMZm5i32KkxKmpO4tsh7WNzvadMyP8qFpVQhCES29WlY6DWUYDPVZ40pg==
X-Received: by 2002:a05:600c:a48:b0:495:69eb:27d3 with SMTP id 5b1f17b1804b1-499553f4c4cmr145986005e9.8.1786108783336;
        Fri, 07 Aug 2026 06:19:43 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm144125015e9.10.2026.08.07.06.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:19:42 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 02/16] io_uring/zcrx: move RQ head/tail to separate cache lines
Date: Fri,  7 Aug 2026 14:19:20 +0100
Message-ID: <f769116a3f5267f06cb9a9a819d482ddea2e0852.1786108672.git.asml.silence@gmail.com>
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

RQ head and tail are currently put into the same cache line, which can
cause false sharing problems when refill is run on another CPU. Put them
into separate cache lines.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/query.c | 2 +-
 io_uring/zcrx.c  | 8 ++++----
 io_uring/zcrx.h  | 7 ++++++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/io_uring/query.c b/io_uring/query.c
index 88a325736992..4321f0b94b4b 100644
--- a/io_uring/query.c
+++ b/io_uring/query.c
@@ -38,7 +38,7 @@ static ssize_t io_query_zcrx(union io_query_data *data)
 	e->register_flags = ZCRX_SUPPORTED_REG_FLAGS;
 	e->area_flags = IORING_ZCRX_AREA_DMABUF;
 	e->nr_ctrl_opcodes = __ZCRX_CTRL_LAST;
-	e->rq_hdr_size = sizeof(struct io_uring);
+	e->rq_hdr_size = sizeof(struct zcrx_rq_hdr);
 	e->rq_hdr_alignment = L1_CACHE_BYTES;
 	e->features = ZCRX_FEATURES;
 	e->__resv2 = 0;
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index a096d44f7b52..fbc190075e2f 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -379,9 +379,9 @@ static void io_zcrx_get_niov_uref(struct net_iov *niov)
 
 static void io_fill_zcrx_offsets(struct io_uring_zcrx_offsets *offsets)
 {
-	offsets->head = offsetof(struct io_uring, head);
-	offsets->tail = offsetof(struct io_uring, tail);
-	offsets->rqes = ALIGN(sizeof(struct io_uring), L1_CACHE_BYTES);
+	offsets->head = offsetof(struct zcrx_rq_hdr, head);
+	offsets->tail = offsetof(struct zcrx_rq_hdr, tail);
+	offsets->rqes = ALIGN(sizeof(struct zcrx_rq_hdr), L1_CACHE_BYTES);
 }
 
 static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
@@ -409,7 +409,7 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 		return ret;
 
 	ptr = io_region_get_ptr(&ifq->rq_region);
-	ifq->rq.ring = (struct io_uring *)ptr;
+	ifq->rq.ring = (struct zcrx_rq_hdr *)ptr;
 	ifq->rq.rqes = (struct io_uring_zcrx_rqe *)(ptr + off);
 
 	memset(ifq->rq.ring, 0, sizeof(*ifq->rq.ring));
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index c1005f23caff..9ae0bf1c632f 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -44,9 +44,14 @@ struct io_zcrx_area {
 	struct io_zcrx_mem	mem;
 };
 
+struct zcrx_rq_hdr {
+	u32		head ____cacheline_aligned_in_smp;
+	u32		tail ____cacheline_aligned_in_smp;
+};
+
 struct zcrx_rq {
 	spinlock_t			lock;
-	struct io_uring			*ring;
+	struct zcrx_rq_hdr		*ring;
 	struct io_uring_zcrx_rqe	*rqes;
 	u32				cached_head;
 	u32				nr_entries;
-- 
2.54.0

