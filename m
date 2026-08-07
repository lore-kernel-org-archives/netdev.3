Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E8477999
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108800; cv=none; b=Mc6q8sXbqYkVYKk3MOmcWivzwQUzFUh3L6HEo4MB07DTCeBXNYrklKMp62Pn3mZ2JuAA95aA97r2XeZY/TkPKlya7he5maShS+ySS5OFQp0qNw+bm9VHrK0EGfCzHIxvyOXnamBtQG8qtWEidjiAnxrKPBmegqfF73bZUQtoUsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108800; c=relaxed/simple;
	bh=bbVIDvh1oGtEEOuyXNjF7TvjE9GXDKiu6D1WxNZBb4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8SAqfi2bj+SyELCS4Iqd9U2LN6wQWNgr0wE6HXZkSl9qcmGgSqEwvyrnhoE4UIixk54SC3KryHiAdWhdrBjJxisBASwm2ouQ4tKPfHRD0wf48Vom3WPe3HY8YqcH9XdNP4x9mnnmpb6thgpaNiyt0ba7tZ8pw1NnoEseHZgu8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg7sODxg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg7sODxg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49557167508so30317005e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108790; x=1786713590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BLXaDYdquGFLQWQJeG2i6v+WQDg9xvWrv08HTjfrVw0=;
        b=Sg7sODxgOKNtIOJTTQXI8kMm/AkfaqRGws9fCao75p3t9p3oJxBV5OXedOeUmOhu4g
         eU+qLPzgyKGzghD8jMQ8J2txkdpU9hWSEov6LPFje6zwumVTA7m4M1LhNLsCYDdjGM4S
         sNmpBvozj0wa+r7kgsnAphLfTdTMBfA5C3LDk9XK70pxTVggVZJLusC01+0uHKTcuVGT
         sa19KQiZGuuSDkPoedFOk0pcLGTz6NpkYd1RcD+9FvWlpb3OW5NfyXimXypRLTgRt8Pv
         vNOSDpx/GCO4s3fmPAZzZj4Gf6TeXm7vqeISyfl4udFJZiWcxee6ZjLIXOv6PQLu94AX
         Nw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108790; x=1786713590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BLXaDYdquGFLQWQJeG2i6v+WQDg9xvWrv08HTjfrVw0=;
        b=CuC6k65VOhba0pnVdoEELYwIGHlF82+CxB9mni9RmJ7wVyEpR6ipqtg+n5Ioor5mm9
         9pMgwVdroZpzsEFsHw1iZ0VWkpF3YLuHqVJG49RqVAnTFcDImf/5pTneenAtOR8JBejZ
         8xfZvKCsW6IkY8VjWwH1PrgXSOsV4fRRNlbXbv1Ty6URe+IAZ/33SdILNOzrnXy0BELX
         i/FFqpqQzWJmUzcRB6x7TPctWcwE7k5MtBNwJXTKDzd+BruL9Vj3P2gwQ+aiOVOgjxng
         iDdBi/Tl6/5iMudG+c1OOiwIQ4zqUUkMxEyph+KK/NQp/k1MPWPQqx3zFDnqfrbKUb8m
         rw8g==
X-Forwarded-Encrypted: i=1; AHgh+RqExdntUnWAsKo/xewp0djLzPqAQuI5PizOIJKY4qETD6k5P2dGZtWeXJ4s1rqzBZUXKFQ0rHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR9cSaoJnhyS7T/ac0Ki4MQRqJ92otMkdwElZ4//CDVYY2zqER
	B/yeBon1sLhs/IJM4pWhfl4xsHCxUyUqZyttXDucaRPXt8bVLK8wGVlB
X-Gm-Gg: AR+sD10GaZsSm6xBQvxKSSEw0PKYfkhhVdl/YCcNRHsxjrgRJdlwIRxS6Bx9Nsz4UQU
	dTeuZEgqJtBf4JgbxPKua43phWGHOtj5DKV+Ts6bFNEAryM6nm3Z5J1S/6RckQwQktYjMR6qd64
	BwZga7sAChrjLrTVUpJdirixavd5y1tED16/L/a00aYIGSx+NVZLNV1H6uaAX2pCRYc6HRPKiLz
	+HKSopBXhyf0YGdc3V6oaOVZYvtETxqvVpTn3JhiLJ90isTc22XPg7RJpOpcieAiFZk15LfL9Q7
	NDVooOsQ85rL03ipq9HWAkj7vQ+NK/vb9WOPjLwIE1iixqpUZJZYyLC8e2qjO/7bLLksBoLGM6U
	qxiLU2jfa2m1m1yVme5Q3QexkrS6a32dJI7pL/AJ45J5JYDEn0JtLx0OkEkyDyeaQOZBowBEaFj
	CUYE8lfNFocUDhSJaZWZSya5Y8ad/ge//EWqmjVyjfk3yTLcwqAXp9OJNGDe0IJXCGMfg4KsQuc
	MCftc4Dipp4BQ3+VdNaHCMVQ6oibOW0dbEh0cFEnKp0OUmTNCGtOzBV3TxqW6vAa1w=
X-Received: by 2002:a05:600c:630c:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-4994e71c87bmr245553965e9.7.1786108790041;
        Fri, 07 Aug 2026 06:19:50 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm144125015e9.10.2026.08.07.06.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:19:49 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 07/16] io_urint/zcrx: narrow var scope in io_zcrx_recv_skb()
Date: Fri,  7 Aug 2026 14:19:25 +0100
Message-ID: <182c140502e7be534caf10360714a4d78f2ce5f4.1786108672.git.asml.silence@gmail.com>
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

A preparation patch that limits scopes of a couple variables in
io_zcrx_recv_skb() and rename them, it makes it easier to reason about
the code.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 50d075fb3825..2ea1e79ca8a2 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1693,8 +1693,7 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 	struct io_kiocb *req = args->req;
 	struct sk_buff *frag_iter;
 	unsigned start, start_off = offset;
-	int i, copy, end, off;
-	int ret = 0;
+	int i, ret = 0;
 
 	len = min_t(size_t, len, desc->count);
 	/*
@@ -1732,20 +1731,19 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		const skb_frag_t *frag;
+		unsigned frag_end;
 
 		if (WARN_ON(start > offset + len))
 			return -EFAULT;
 
 		frag = &skb_shinfo(skb)->frags[i];
-		end = start + skb_frag_size(frag);
+		frag_end = start + skb_frag_size(frag);
 
-		if (offset < end) {
-			copy = end - offset;
-			if (copy > len)
-				copy = len;
+		if (offset < frag_end) {
+			unsigned copy = min(frag_end - offset, len);
+			unsigned frag_off = offset - start;
 
-			off = offset - start;
-			ret = io_zcrx_recv_frag(req, ifq, frag, off, copy);
+			ret = io_zcrx_recv_frag(req, ifq, frag, frag_off, copy);
 			if (ret < 0)
 				goto out;
 
@@ -1754,24 +1752,23 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 			if (len == 0 || ret != copy)
 				goto out;
 		}
-		start = end;
+		start = frag_end;
 	}
 
 	skb_walk_frags(skb, frag_iter) {
+		unsigned frag_end;
+
 		if (WARN_ON(start > offset + len))
 			return -EFAULT;
 
-		end = start + frag_iter->len;
-		if (offset < end) {
+		frag_end = start + frag_iter->len;
+		if (offset < frag_end) {
+			unsigned copy = min(frag_end - offset, len);
+			unsigned frag_off = offset - start;
 			size_t count;
 
-			copy = end - offset;
-			if (copy > len)
-				copy = len;
-
-			off = offset - start;
 			count = desc->count;
-			ret = io_zcrx_recv_skb(desc, frag_iter, off, copy);
+			ret = io_zcrx_recv_skb(desc, frag_iter, frag_off, copy);
 			desc->count = count;
 			if (ret < 0)
 				goto out;
@@ -1781,7 +1778,7 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 			if (len == 0 || ret != copy)
 				goto out;
 		}
-		start = end;
+		start = frag_end;
 	}
 
 out:
-- 
2.54.0

