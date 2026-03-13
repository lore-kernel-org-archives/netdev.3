Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84D372ED0
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436638; cv=none; b=snB0/oq2CJ/Mzqko7dlr1DHk328OEfhwZA+qy5iFsEubDHQcSOsx9B29yfBHfAWYCJ3BbmG0StX0btxCPOJKiy8iCcOGGuhJ2r+9tJp0elZqXCzCBXohA9H9Fivs8UVzB/SenyIedCQKE0a4llZG7LJM9jIz6fJYMbg3uV5Xo8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436638; c=relaxed/simple;
	bh=/bOLMfPL2Zm5NgiaIDMmMNvL8a6uqwzRFMGPHgiIj/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTY/FV1wtpZzaJ9kXhbUXyrU5ne3wTMpoyA6hrLmdezFrK7u9MwKIwrxrAJqUVHz90jZpG/AUsTVDYW1FTfRMm52JQAPvwMPWal4QR6z6XuC00ULCNy0l/avnwlxrzr5KyWW6pI8ooDys/fg3kyMjlO0dB+HiyCECyqvg2jxWyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=h5eVu/+A; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="h5eVu/+A"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae82df847bso20897795ad.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773436637; x=1774041437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDcdCUs+vjQGYVGoS9eiR5d8YYA/kqPZtrFyFXUh6c0=;
        b=h5eVu/+ABiVLB/65u5eRP5/FrZWVZcbcBPg6+d1m1qGg+J1t+2hKLqV99gsRzhORdM
         FjAhUDH8+gF/zBzbxFEE8g/6/PWeb303BFpPuhDz0c9nn4H1i1lhnVyspZhiKY/Aw2/w
         5VfffouPIE/FjGuwiotMMQqSJ/z3HF4LuuK2JGR4if6vb38WlnJRuLapVQ3Xga0EnfcI
         GzuQBJtuW6rod2JDp0idwiUxq+uV8uEL8xk3JwKJkRZIISocp6/lM5UwvhOloQ2QtB/t
         /Wc0T65fLpSNPYqVKjHROJuq775bGjBRv2dpurb9ESVs8C9Dzlmp2dHR+F/aTFKNpiuE
         APPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436637; x=1774041437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rDcdCUs+vjQGYVGoS9eiR5d8YYA/kqPZtrFyFXUh6c0=;
        b=LFmk+fFdVvFMfhlifI2tsCI5R08g6MQe2nGZ+nzrHHdOIH8sglsGi7eC6s+5w/ZFzE
         r3lLjePyUq6T8gWUCjIWUZJbB1m+Xq1nSlfk+xZwUmXH3umSfV3aPnt0HrlLelTYN75K
         iGjJd/M6Ks8mBdHWE9ICJ1UmyYp3YLUQR1VWBTeM8dR0a/Rf2wdBfrhedt9VtMD/aujf
         axz4SEyH2gtHzz4dQJVDOdTYJ1K4EfA2tKGD7AER0/sSRlXHFWL3qznIheKQQwGIcCOv
         /YTurU6K3LhrmbIau/HbFLZusr4m//fAovDk/AIqUP31y2LNYi0h0GBsJZ35a9Judzur
         64Tg==
X-Gm-Message-State: AOJu0YzmFcqv64odzLcEjYmiMQOI3lcqToPMhMVOgHSl81TdH3g5rPV6
	FD+bPKf2tak952YgW+8LvWMalRc0I4ZG79Z1660Eqf4KTu1Vzl9V6CvNT7SiWdGMW+5QA285Aen
	wWC7rziM=
X-Gm-Gg: ATEYQzybDoZioadlpPZRrwrPiMGbVLUgl1IOtm5nmqwdxarMxOut+IjV6eOS+PNHjUj
	hFWdWbmn0xXAAJXqxnZz9o3flQ/73G7u7ScQedvy00Hw72xxCR9QuVV5hX7cLrd2j4alpkv0v0A
	f3g27Ag9cxt/u4kBtVUf3chqMDZ4b88kts/gJr9slltr2Wdu8EYF9ZjgIWHF5WwlulP0hhlyYLJ
	KdxHCngPMrxXYCRSO5YByxOPoiRHKmIrwLH+gNNuCGjs4QnTaejYWGvcdOmRgH20aMOkfiMu5wS
	4o8O0fsXTkmq0ZfRTmntmlCTKAx2/4IRR25fXjOcvnSlmiFbhn9cQey+kq7yLrTsbMw8TSY49n1
	ET0p/dtebA9ufQ9h4U+FMAunDUUdV1RmXWHvqvsJbVxxc13m3S3WPWvB/OLQnBdAR43jYEif2e5
	JaiCPLnlLjPlvuv0Rh0G8WFR+Sss3id4mp
X-Received: by 2002:a17:902:d505:b0:2a9:616c:1711 with SMTP id d9443c01a7336-2aecac683c1mr47974905ad.42.1773436636823;
        Fri, 13 Mar 2026 14:17:16 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81afccsm31204195ad.68.2026.03.13.14.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:17:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 08/12] net/sched: netem: null-terminate tfifo linear queue tail
Date: Fri, 13 Mar 2026 14:15:08 -0700
Message-ID: <20260313211646.12549-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313211646.12549-1-stephen@networkplumber.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tfifo_enqueue() appends a packet to the linear queue tail,
nskb->next is never set to NULL. The list terminates correctly
only by accident if the skb arrived with next already NULL.

Explicitly null-terminate the tail to prevent list corruption.

Fixes: d66280b12bd7 ("net: netem: use a list in addition to rbtree")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index df9049816623..0f6817a472e6 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -408,6 +408,7 @@ static void tfifo_enqueue(struct sk_buff *nskb, struct Qdisc *sch)
 			q->t_tail->next = nskb;
 		else
 			q->t_head = nskb;
+		nskb->next = NULL;
 		q->t_tail = nskb;
 	} else {
 		struct rb_node **p = &q->t_root.rb_node, *parent = NULL;
-- 
2.51.0

