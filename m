Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F723BBA18
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766483; cv=none; b=GQ5UXCL6qcsxyY5V88oeH2xodAQUtVqRQK5g8H51WnJhrtNC7TLYUys7Uuuz2cgWb13j2c+6ftg/tkeLjVKvGv8VgpRSdLv7Iv7H0l4YkD62itozE7XhnAV/m/SumEYLD27cJRhHIfJHhkMbyOLKvsz5PF3WfhaPeYFqzR/cX18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766483; c=relaxed/simple;
	bh=3C5ZHtmURh7dwurigU+mzj8rTDm7QKCNJ6nCU+yuRWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAFqGt/T98rhC5gW394J6RdEzuwQDLy3Q1SLl+YHIIy6SfzPYmPoFXp75iXL5AbPmDIA35Su1/x9J0fnvQpjVCIOFNFEsZ2ibX3AFuMf4qWyoz6gezEnFFDTCZBnVn6z4MV6E8vPe1dmqyUHGWN6mPFJxC/Q31eUGxLMmYrL1fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0nbvqu+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0nbvqu+"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69a50b818c8so2904070a12.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766480; x=1784371280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YzxgLXuoC3y9XYCE+1b8RBAVVFev+ejEK09g/vo1UEs=;
        b=H0nbvqu+fPC8w5bfHmfEl/v5wPLcbO8aITWDR2aLRh6TY2UIvEcJFID5mF7Lqma4uo
         JkMHZWwfu0so+xZnuLyNRJ7bADe+/PhyvEF2NIK3lVgXy5WG0MB/k7CE6ZwgbQpA8CLI
         dE6VDu7vQg9ekIHAr7nwqftgRIMlKUWlB37mA06M1NVQVVehGjaDYE+I0cjW8wcIr12j
         aK6GrVAnANAdR1+5zrnRD2fY/6OPd29QZ2Xa9Rs6QAfln7EAz0CQp0NrsKCXsgXbhdHj
         2U26h+Nc+eglkxfr7vp/M1it2Iu/qs3Ynehaf2FUa8ZKjPwIY+GVZdNkcXAk14sJwJyE
         RJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766480; x=1784371280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YzxgLXuoC3y9XYCE+1b8RBAVVFev+ejEK09g/vo1UEs=;
        b=qPa+lbEZ3+tvWwaUkWB2Cl+NBDpU31TzX/tNuLyREcmtUM56SlegNsbN7lkZe6mivA
         td+3zZrknOiyIgYqdxrGpbe0RZPW2vYH3sAkMTNMcUwHm26T94fFBUiTmC4cN3kvG9FC
         qVxyK1gT+cKoj0WWrGdQAfFnK5NcnNFfDRzUhoZhYEA2Tqpq91KhkxKV3Vl59ENgnavY
         5RI25DziwtrxqD92Aa2WL8ufCuBcvlKHsRoknwMAa0X9j5iJ2HI3oEboZdPYbwgGUT0Z
         YwTWBb2DnBykvg9n3L6Ail1rhcUaX7G2JjU+h3txbzpabT0BVVSfAA+6mn6Wk/FTXXFY
         G0/w==
X-Forwarded-Encrypted: i=1; AHgh+Rqt7ctAG60AYpMrl4Ykt+Nx33/xYt8/xYneWvYWtBjOyDoqr0R+9UCs/fFlJmI/lID8y4O6YHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+m5zw5BKXo6bxmoskKwQShiSad4nvS8m0SbcZHN0DhoRK59fS
	00VtXnDGY0BD2myMdJIH2LGPxfRdPrxnvWedvKk5Rf2SU/p/HShWWwYD
X-Gm-Gg: AfdE7cnNkY47Od47Dkm9PyHeCncXcrLtuUi52g/6NFZa/k0amtfKUAVg3syu6K3u/At
	MALx4qE7nkZ4hTTMM8CAY1dmQh0cgPyZCAeo+TgIiK9Dee1GDScOicAakZ0KC+56fV6Q4/pHD7A
	dYgb6+fv1n8md3Z/HQrDeBTzSQHUukDK0nJYaPkOZ4Qd3ePWQ7VChKKIeZyDlKgnqsBKIwJre0b
	F1gvHISmjgtmZmYumYJiOWWNWhbkNLVVkt11AQcQ9hmh/Mp5GgjdnlXNJD7ylM01anOB2Nb0lL2
	mDGi/lCJFZr1SFEwEWfkSaMveMXrMHiH5YFkIxaZDlhsxdpj7KFXaWfAuXMtIOcDuDCHo+74O4a
	vzuR7cHXeqOZdEns65wREbGgAv4Mbk8cETdxuNW9aGLoU/Gam+4+kVK0cDTz2SMJzVBZMHuSRPi
	ggJ35Axt/xvxoLM4wThDwq66FGuWiQs8t2A/+KR8gEN85v7sIXG+BPCckQUj0b64ETGi2DvHEtV
	0qBU5zIBb9iSXaMlGNQwCJ20ZvAMENbVxl94+Fw0En6/T5dlTnwrwdv3QqW
X-Received: by 2002:a17:907:6e89:b0:c11:ff2c:4f33 with SMTP id a640c23a62f3a-c161f3886bdmr89040966b.45.1783766480430;
        Sat, 11 Jul 2026 03:41:20 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm483041566b.39.2026.07.11.03.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:41:19 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 16/17] io_urint/zcrx: narrow var scope in io_zcrx_recv_skb()
Date: Sat, 11 Jul 2026 11:40:09 +0100
Message-ID: <87e57608b1525ebcf4cb1cf29b00ca76ba3b982b.1783616211.git.asml.silence@gmail.com>
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
Message-ID: <20260711104009.ThVCITYD0AkRBJbtNCNXSVb1QNcu_6eHOzF4E1e-iLs@z>

A preparation patch that limits scopes of a couple variables in
io_zcrx_recv_skb() and rename them, it makes it easier to reason about
the code.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index f7592a3c058d..74046a09911a 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1836,8 +1836,7 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 	struct io_kiocb *req = args->req;
 	struct sk_buff *frag_iter;
 	unsigned start, start_off = offset;
-	int i, copy, end, off;
-	int ret = 0;
+	int i, ret = 0;
 
 	len = min_t(size_t, len, desc->count);
 	/*
@@ -1875,20 +1874,19 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 
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
 
@@ -1897,24 +1895,23 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
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
@@ -1924,7 +1921,7 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 			if (len == 0 || ret != copy)
 				goto out;
 		}
-		start = end;
+		start = frag_end;
 	}
 
 out:
-- 
2.54.0

