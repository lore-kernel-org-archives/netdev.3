Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860648A2C7
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108791; cv=none; b=itDirTDf/9dqu9nFf4TtDl7+J6oOI95dfh/pa5QpjWd/CFTTEm+O3i3xzmAUDN0EsYQivEW5IzyjaL98TOqCfAR6eejMxcxNWOG9YOniOdekKnB5GE/WlQ4WC4ZGUHqP+T5Z6ZV6TAyz3nIyb6Ac6Eu3m260pPwc9kQs0jLlsQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108791; c=relaxed/simple;
	bh=skrg9soTb7Ie1llGMGoXq1o0FH0UgZqM1b7lpDH3lv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gi6jop9h9VknicQr6NhuLUFMtvJGfzoRhYaK45nhI7ZiDZPyaYS5CFg2/LdfIQTTVrycW8V9k3YZD+xdzbGD/9Ka8ZcVHNbNA5EIYIVB84Fs5qRQ0Go+NWhaFgKyXv2gmUTKSSkLh9rT8lgqnm+beY873qjDiQmIcRZiylu3Tdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sgoZEQu4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgoZEQu4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso21858495e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108782; x=1786713582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=52jlEQ5aipRQ5ONtSttLeog51aomCUmhXFJUhfIf/QI=;
        b=sgoZEQu4ZBluKnys81QbfAFR5jmjVOOUF9pWZ2WrMs7K91BkpghAREoXnizAkhdNYt
         N96ZMOKfLYMjVCueJjxDK5YfuHxWXJ9ROA/N0VMP9vM0P5/Wp+nvjWG4O29tqF+WiHAc
         NXV6e3CxjY8TmH1kjQV1isLcQV4CguoHaIUjPEHgMVo9E1lBHL2oVVD0Svv/LOV172Xr
         bZQfUhI9cclze5b90Tvxe6LljIBeqRXWEb4sjh5bzQ+evO4qFwMX/0TFMgmBoTwX/irW
         /7s2InFgsYR/ptfXTsnn4qmWCDxY1ARBcQbLKMJRAVNh4aaNa/iXBFFTUUvUPeYkRhwA
         l4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108782; x=1786713582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=52jlEQ5aipRQ5ONtSttLeog51aomCUmhXFJUhfIf/QI=;
        b=LP0xmILn5mlJn+wxHfRFeP0Q7/ZLbidsqoC/o4PStKIdUMWIrwF/Q+VAPFX4M5tuXV
         u25z4FgSyIELkfWNnYx+Q1DD62qLFFpOuUzEa8WP7J+siHNNeyVUI4JLwrdnyXEZNoCO
         WC8a0wJSBDqgNnO9DSVNiHwpzgAj696bzHj1kxNNhnIr/WD2tIWbZyby7bLPhG5LQMg/
         /u1LJmWT0MbcXU0IglIwBKA/NlNi19rS9Qn2MRuMSocYuEzX1uRgasplLoBPR+E+oIaO
         aMRapRrS+5b4E/WN+1khATFgRlGoGSdBbnN03an6ojuf/hD5SUtiVOUoVdCNi0Rjiddk
         w7dA==
X-Forwarded-Encrypted: i=1; AHgh+RrbBUFlG6NW85hOCTvY7qj9TsXItaOw3kQ5G3SckIhlBaTZlMWA11YmNB6OmKKypy0rQAYHJ0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0B/+/h1QcVuWtwJvWRyVNfMYcMT8Onn+8VJSvIhhyMIcxN1+p
	gau2VeNZb2dDIKrV9N2MeBqjjXFUMxxqqYIm7GCnNRXMf4lVouOv18nAHZLsEXQ7
X-Gm-Gg: AR+sD12bnFje/nX2P25+//s5je9bFZdQnvUzD+wUbFrhcc71fs3fOTQ/mW+hObt4EfG
	zL2aOk3OHos3OsCKYnK3SG/DEclMjD0Aym4ypnZ9REFLr4CRjp1QDeY9H8igoB/v/uUkCOBrOY0
	/gKs3dArcWacF1DHxnOFiDB6O5kCZAcl2ai2mb/hE8VFu4MMr9TFss8G3UnBoJC4mw2EXGCt3Ga
	L5lURuk3c8Q2kjr/K/fTobdtIpng5Ugrry49k9zBxjZ2BFIZqV5/Z/Ve6qeQWUo/F/PB3psy46e
	866jd6zzIfAQovuqgZmk6HhgncPYB3cHuXUN88ZixZQV0dNQswpiAUtHLQOi7nr9aKzXy5oQNsu
	nkagSnyxa0ERDiY/YWGuhmA8RaWpHeuWKm5FS9YVkPptvR//U1ydU7idMGWCNaOHhUtv8aZ5G1Y
	wPVu/QCdoWoFJxZ2vr4gAmgUJ2vjptozRf+DfZ6OxjF+WgKb8wfHrWmw0ySuR1Ke0T6bqMOrZiD
	YYQUYpRV4YH1WnBaRdCfG3Sw6+tafMZC2HeMZD1WklsAXEqKeTrn/zEF1lEJbuEU0QWaEZYcljt
	kA==
X-Received: by 2002:a05:600c:4454:b0:497:fecd:5b00 with SMTP id 5b1f17b1804b1-4994e7c0377mr312582735e9.9.1786108782213;
        Fri, 07 Aug 2026 06:19:42 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm144125015e9.10.2026.08.07.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:19:41 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 01/16] io_uring/zcrx: scale refilling with large pages
Date: Fri,  7 Aug 2026 14:19:19 +0100
Message-ID: <143cf439299728759eb0a840c866363fe99293f0.1786108672.git.asml.silence@gmail.com>
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

io_zcrx_ring_refill() caps the loop by mixing the max number of
allocated netmems and the number of available RQEs together, which
caps the number of entries to process the pp cache size. As a result,
when niovs are heavily fragmented, the refilling logic allocates only a
small number of niovs per call on average and sometimes even none.

Keep a separate counter for the number of processed RQ entries, which is
capped by a roughly calculated from the page size value to keep the
cache full. And separately break if it allocates enough niovs.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index f1464ea8ca64..a096d44f7b52 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -28,6 +28,13 @@
 #include "zcrx.h"
 #include "rsrc.h"
 
+#define ZCRX_MAX_FRAGS_PER_PAGE MAX(PAGE_SIZE / 1024, 1)
+/*
+ * We need a reasonable limit to be able to fill in 64 entries on average
+ * for 1500 byte MTU. Over-estimate it to keep it pow2.
+ */
+#define ZCRX_REFILL_CAP MIN(64 * ZCRX_MAX_FRAGS_PER_PAGE, 1024)
+
 #define IO_ZCRX_AREA_SUPPORTED_FLAGS	(IORING_ZCRX_AREA_DMABUF)
 
 #define IO_DMA_ATTR (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
@@ -1125,17 +1132,15 @@ static unsigned io_zcrx_ring_refill(struct page_pool *pp,
 {
 	struct zcrx_rq *rq = &ifq->rq;
 	unsigned int mask = rq->nr_entries - 1;
-	unsigned int entries;
+	unsigned int rqes_left;
 	unsigned allocated = 0;
 
 	guard(spinlock_bh)(&rq->lock);
 
-	entries = zcrx_rq_entries(rq);
-	entries = min_t(unsigned, entries, to_alloc);
-	if (unlikely(!entries))
-		return 0;
+	rqes_left = zcrx_rq_entries(rq);
+	rqes_left = min_t(unsigned, rqes_left, ZCRX_REFILL_CAP);
 
-	do {
+	for (; rqes_left; rqes_left--) {
 		struct io_uring_zcrx_rqe *rqe = zcrx_next_rqe(rq, mask);
 		struct net_iov *niov;
 		netmem_ref netmem;
@@ -1156,7 +1161,9 @@ static unsigned io_zcrx_ring_refill(struct page_pool *pp,
 
 		netmems[allocated] = netmem;
 		allocated++;
-	} while (--entries);
+		if (allocated >= to_alloc)
+			break;
+	}
 
 	smp_store_release(&rq->ring->head, rq->cached_head);
 	return allocated;
-- 
2.54.0

