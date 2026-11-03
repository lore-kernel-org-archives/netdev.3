Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710231;
	b=W2stPfKBTxyHFOLVfrqety08MgRBc0Jp/EqEhGDzyU6S6Q8wLcMj7YKw1XLayBGvwFqS
	 Yzlfig9gGjlw05C+S7idtIuYiMJTZZouBbsVPWlE1ARz1JNDmN5RZT168ihO3XpWIxNJE
	 nA1Q9YMm4IhWQWbbbRniUk+2MjFQoX38xnyIB6JsMY2yq2NXsf4YwEpYxQa9hoenlWsLs
	 af9sbV9PwDZHcdXOAny/sEUGGPmMOmfcMUO55st6XkenVHwjTdpKbJbBmJP4Fq9rB37jt
	 1QvvnxOZH3yobECZ2LoR01hC9Vl5VyYq1CKme/Dn1zZwZMiAnEbyI0PFt868pXicsbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qS8ztVVMIjwfG7AlBvbmWvP1WuCvhnu2ikDFy5AVT94=;
	b=L2OTQj0QFpByx/aZtrnlnA5ivLABoP8bke/xyViMA3H8uDuMFeJZ1VEN4iFaLPxTzPLt
	 Swfrql7o5o01whF5n2Zm3GWybIyFiMvG7twFNsvFE0EktI0gKVUHcT1XLvj+dQlXAyUoM
	 GOYN+YuRHazc7w4+IkOZ5HgY/zR3tso42dqEAGDJOuoLLvmVn7ftKUfmtU5KmYSbw8qDZ
	 bbUej9lDrwMrdepi8wRirdcztIqc0hs0gCScPQ7h01B28uvcPZUMEy+75H+AeqvUtHZ/j
	 Sd1tFk+NqSFuECAzU6QImZ6flW4SnbEss5Vv0rx0QazvGg1j9whY9AGvxaDG8HqCGDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wb8cxiZd;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF36606A335
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF36606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wb8cxiZd
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so27999575e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793710229; x=1794315029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qS8ztVVMIjwfG7AlBvbmWvP1WuCvhnu2ikDFy5AVT94=;
        b=Wb8cxiZdnUZ9Ddj1KcznRD60LPv1ZcjSK1WUp5d0qJJwqyVRu6WXtBE9dETR/tCQuT
         Q3Hjk/eQGTx4nZqIF28pb59MtYmEE4QO18Wr2FxBVmrczg05gS6ewrOr9hWg6aakCNjy
         dafunkpbiNLdInz/1nj4dbk2l2+M6jXj8yhbw1KxTeP5IcexXiREofeCuzPMR2g0X5en
         aeeH8FywHTRdyxaUXMeyalaAWk6AaGfFje/d9oPXac390wLtfUqBBtUmxnbZ+oYuu2zs
         PMG+e1rbnnynGujTdEjMhGX9ymJJYiBhfePDJnJeCB2a2gG4xl0+qskOnNmiKSv48+Fz
         GD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793710229; x=1794315029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qS8ztVVMIjwfG7AlBvbmWvP1WuCvhnu2ikDFy5AVT94=;
        b=p9p43XXHE9HZ+w2eLHj/0QItmO+gHBCP1m+7SM0BkrjWaRLiNCJt8jDwmjnhWV0cjK
         6JgGSvIwYumtG8CPy+J70eEH/Xq5YM/U9GPO0J0ADlmXRbhKnpeVLlLBx4iYQ9KU1L9G
         s7PKV8nyAwprnHId2ENFvMeiQDoI6s1UNSnWkgsUBzmc0Gzu/a4C2JChvEDs0d2+Gm0a
         nEzS7yKPDvc/aK/uFKUStSnh/YrTb79cdrnV1BRcOAvPjzZJJv7ZS8HtGUKRS5qg+OQw
         c9aY9H467muLlHK+yYAR2G7RzSKIF1II1XQc1cigomFAvJ9OvyGHwWDBSrURIXKYBQ3w
         n4Fw==
X-Gm-Message-State: APuU4Z8zLQg3IhtQQ5yfY3O41gnU1nanFO1T+xO7iswdjlHIjdd6kbfr
	28IxfNGlJbvO2wAnwhL270y1QaqrA65919Wj/XJbzGp8ETepnryIadxPZ7K4/wse
X-Gm-Gg: AYBFou3U6j/spXVn3oP+ZUMrsrWUU5+3BAK33KWF77TMUNap/lmo4kX7UAVtdQ+60nO
	ohrWkFRUEhhNE7DncWXkPaM6UdvJgfAnBqrXOAH4ubW27L5PKo4zLpasuCNb7Aavzx+CXrqGwUm
	felGs1Xx4Iqi2PqyeN9kfjnrJrryldAoIV1yqe2cTDBx4K+Z9mE7ElSI0IlI9LLw0tO6H+9jBrS
	tLQEbR3rbOsqXKOSHIpWldDl3Q0pd9iCQSXbOA3aIb4QkDZf71ukDaVIIcVC5tJoNR/ZC6VKt/q
	bGl/B78ICAz2zy1EVF08liSuoHggDOIsSYxgsVl4PlyHb1dc4Gx2N+0UgGVis4hRCvAdpwFc6dd
	ABy27dvhpF2b/CZ09FYlnPeLMMJxnZm7mR8ZbS7U8e+r+vrb/XZzY3g3qdifXynOhCqt/0Z9zr2
	P+cP969hYz5/QLCSfCa/sDR/571FAZd+cLvInhVwL/K0exvui+zUbFfNgnaky57qG20cmAAgCtk
	Ka4DyP9UGkwXrjyQ6OPagUl3TDia7a9HbmPAEVX+8DWdhf4hKDZkJZawXuBknINIjux9BvB1A2c
	P5ViLTGSnFVjYAiEJutXxPrGYn2uzxrCsBPTnCcUEr6QHrkgo70WXA5PSj4QlOSXgp5VefyO+oA
	TvuMdaNcvd/dzvfZqILBzwcp/oLeNqfPY7oNA3c15/AkuoI4fOmkIfLNygHxOBmU=
X-Received: by 2002:a05:600c:6285:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4ac182dc8f6mr294558275e9.34.1793710229187;
        Tue, 03 Nov 2026 04:50:29 -0800 (PST)
Received: from localhost.localdomain ([2a00:102a:403b:96a2:e8a9:f4a7:ed37:36a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a5372d8bsm61406425e9.0.2026.11.03.04.50.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 04:50:28 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: netdev@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	w@1wt.eu,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/5] net: mvneta: lift the per-queue TX rate limits
Date: Tue,  3 Nov 2026 13:50:17 +0100
Message-ID: <20261103125021.70845-2-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103125021.70845-1-pepe.schlehofer@gmail.com>
References: <20261103125021.70845-1-pepe.schlehofer@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-queue rate limits set by mqprio stay in effect after the
shaper is turned off.

mvneta_disable_per_queue_rate_limit() only changes the mode bits in
MVNETA_TXQ_CMD1_REG. The token buckets keep limiting the TX queues
with that mode as well, and their refill rate still holds the old
limit.

Refill the token buckets of all TX queues at full rate when the rate
limit is disabled. Deleting the qdisc reaches this code only with the
next patch.

Tested on a Turris Omnia (Armada 385) with 10 Mbit/s limits on a
100 Mbit/s link. When mqprio was set up again without a shaper, each
TX queue stayed at 10 Mbit/s. With this patch the link reaches
94 Mbit/s.

Fixes: 2551dc9e398c ("net: mvneta: Add TC traffic shaping offload")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index ea755cf05b9e..9b9efac2846e 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5204,9 +5204,16 @@ static int mvneta_enable_per_queue_rate_limit(struct mvneta_port *pp)
 static void mvneta_disable_per_queue_rate_limit(struct mvneta_port *pp)
 {
 	u32 val = mvreg_read(pp, MVNETA_TXQ_CMD1_REG);
+	int queue;
 
 	val |= (MVNETA_TXQ_CMD1_BW_LIM_SEL_V1 | MVNETA_TXQ_CMD1_BW_LIM_EN);
 	mvreg_write(pp, MVNETA_TXQ_CMD1_REG, val);
+
+	/* The token buckets still limit the queues, refill them at full rate */
+	val = (1 << MVNETA_TXQ_BUCKET_REFILL_PERIOD_SHIFT) |
+	      MVNETA_TXQ_BUCKET_REFILL_VALUE_MAX;
+	for (queue = 0; queue < txq_number; queue++)
+		mvreg_write(pp, MVNETA_TXQ_BUCKET_REFILL_REG(queue), val);
 }
 
 static int mvneta_setup_queue_rates(struct mvneta_port *pp, int queue,
-- 
2.54.0 (Apple Git-157)

