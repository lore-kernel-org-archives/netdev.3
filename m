Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB4348BD24
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108800; cv=none; b=Zo4meYqomqIYQFbbZ5yyuwH32c5iXf15koEuXZO06cz8TI+fR0o+trIhcvKyoAHEB/Ye9os1N/8UhDhCa+UL9PmKwR5hxaws0yQ1USZrMK2za5nfXsrc8/i5Eml34MZIGqEdj7+NHUiX8hGCHcau5tRamJ60FP3YtPGfWSTnwjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108800; c=relaxed/simple;
	bh=1H5deh0Reijn8Kox+Uf/v8W/YmDbXdVXJU4Zg/Zcunc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmO/BcOtHuTPtZOUXibtghlK+FOiSn1NzKk9bBoBA0TQS0+4NTV1W9ll4ZTvfTowe8Rr0QI1Jc3Get/5njjUmr+7ns+YQLV38N73A3Q5dTjCS1Pq6zSaSPpwVaz28b8IHUrRAnDNK5ZVO9AW8ooEvaZZkjtkps5o+UkDpNgEAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bq7Q73fz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq7Q73fz"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49954b88fffso17197525e9.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108792; x=1786713592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZJaZJRWy/IKZEWjx0ShchG6wpjaMI3hEZM40yrtEelk=;
        b=bq7Q73fzjF4hxOChDEjK9iqJF+l8PkNI66enRFM3LAXwHIi7hD13y53rgPuRFx2tQZ
         cXqNiZAMqgkEVpLs+Jpyi2OWYudmApdYnRvv1h8s5yuigtQHox1Xn75y43+VZWmTJfz0
         IzroxxatvSlow1hUlDerzL2fjglIwFOeo3nBTJeS0fewINcb9/n9VGmNJZJaF0d4H/Xa
         QJ+i42xDWlLpEBSsObIzhHaOwvuv1VLUfbwsEz3E6q6ImRCHond7BCTfli4z0uzioliE
         lb2HF9lBD0aS5CH1sEDzHmU+VqFv5HJ0634QRvsVpHG3mXbPohQirP4ApFbFur4PK/mJ
         qfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108792; x=1786713592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZJaZJRWy/IKZEWjx0ShchG6wpjaMI3hEZM40yrtEelk=;
        b=Y+gMsMnmHj+PKEW1/QMc6ACVHST9ImTYUNv8d8djZ/wOgvKZHeCE5FPu5MD4VE7AnI
         oVg2f8VSiWBNoVUWoi7zIrr/ZSEvEjvFJc/jwMYTrn3uNMHehbkCuCYUhjtIGJgan6VF
         nLOj5VCuAYnWC03zIp/aR21ue4u2L+M/WyvcgF/MzjD2HAaf9rBGijpjNkUgqG1v2rcn
         XUxtse90ZndkSg1pj8ELKPpAnOvL4tFGDVdHILeP9Jv1Wvzn8kElXBouk78F97nttAXX
         AZFeKqTeNU3bc7fl1djVM75QNsIIuUdJSuYuSpzTOhrlqgVHhATViFhIyztfg+WZ9VXW
         7/FA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0ltXXytZtPfKNuuBmjQzOBDK5JX2Y4dQnHJCjAQ8Z1/h5yo/sinsamjG/ef64ZhsWYQIvEDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsWNLZCEzgBKvPUbcx6qbwlNLpvgEEWwGgy+OKUa/DZPzANHH
	jfv+XOBjtUcC6Cf/1KfxRatY2WuL2x2gKE7nBNKg1k+q+D72m6WL1AUR1IPKFi+y
X-Gm-Gg: AR+sD111URh6VV2aXNaRM1qlvggW0nnscwynzrdBe730gbyDqwec+/8U2HQ51kqqC9X
	BIqm5AIhMiswXq/AYiMqIqRnzf3GREuAVlAD3n6lqi/y1u63ZOidU5jSKhrn9evkLXZU4djJUfv
	KyCzw/2xnqiKa6mfhBylHxh/GUIhCwG3HGQrga2ynIC0rEpEa7+BjceKauNQcnX2FF7R14ZoyxV
	P0Bv4HaOjAqkeNRPvpIkLGAfY9pEFe1FWBJ7eOkGnshDK5hSkog7wkBnLFDeDV2THkPzIV0w03p
	Z53DVEFqI5tqMh8WTH6btFray84m44MHPZQ4QTp3WoWtt0Qmt77o8gWK26kDPNMSCuswsSWRvsn
	ETIBjULGZvMKRES6MZrEJtp0n7/EHE9XIr3Xe6nX0L2e8LP1ox+Zgmr3tzq3IK3oy/MbCFpHgHd
	A/wlfIFogNbJ9nM+pFjArD1WZ60jGH4TK10vYQ0eZBRZCXem3VCnyRTrF8kwl9SV/4XVDxMZa8v
	2F2BZGanXcKb3nABfk3ieAZfVA1hgZFjkMxWaQF4zMWvXpuWPZ9LNdGWcBDWKHZHfW4gFPPie3K
X-Received: by 2002:a05:600c:6d03:b0:498:2b1f:e0c6 with SMTP id 5b1f17b1804b1-4994e7d9949mr265695965e9.18.1786108791778;
        Fri, 07 Aug 2026 06:19:51 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm144125015e9.10.2026.08.07.06.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:19:50 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH io_uring 08/16] io_uring/zcrx: don't reload skb_shinfo
Date: Fri,  7 Aug 2026 14:19:26 +0100
Message-ID: <1e4c864a5ea639803c866aea70b8d5bf558f189f.1786108672.git.asml.silence@gmail.com>
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

Keep skb_shinfo in a local variable so that it doesn't reload it on
every iteration of the loop.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 2ea1e79ca8a2..bea606beaf4f 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1693,6 +1693,7 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 	struct io_kiocb *req = args->req;
 	struct sk_buff *frag_iter;
 	unsigned start, start_off = offset;
+	struct skb_shared_info *shi;
 	int i, ret = 0;
 
 	len = min_t(size_t, len, desc->count);
@@ -1728,17 +1729,15 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 	}
 
 	start = skb_headlen(skb);
+	shi = skb_shinfo(skb);
 
-	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
-		const skb_frag_t *frag;
-		unsigned frag_end;
+	for (i = 0; i < shi->nr_frags; i++) {
+		const skb_frag_t *frag = &shi->frags[i];
+		unsigned frag_end = start + skb_frag_size(frag);
 
 		if (WARN_ON(start > offset + len))
 			return -EFAULT;
 
-		frag = &skb_shinfo(skb)->frags[i];
-		frag_end = start + skb_frag_size(frag);
-
 		if (offset < frag_end) {
 			unsigned copy = min(frag_end - offset, len);
 			unsigned frag_off = offset - start;
-- 
2.54.0

