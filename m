Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618903;
	b=KrbMsmToDQ1o0INuui3rkMAf9zWIGAjzBThaGf+Shkd638viv7EHMHEM+68zfBLnAzIg
	 WNkq0ovQPg33AklLQhERsHg9+OOCI6/yo8AoWaVDRowmDpIMH5Rvk+Oz6Z8EIEaCL5cdq
	 MqqYqMh9ZW+6pBry2eo4ER2Rc28lx/v+FCOQvyDe0RhY7y5jQQ4TpJqAH9QTR5AJx55cp
	 fRNveV7FmpzjfJiEipkuD+OfWbAU9RaRMYYIFpC9oX9OCKMlSHgPQmmaWGiqivwDpbeDk
	 tbg+CBm1LTy5xb12RqfBcr87eg76aZyRPd4hBrZoGt1+JQJDnA/aPwZOC+yXzMQ/m0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hRF/O+HDztPNhQ+cHx55rMvIzqXoQlmaSvpEgSUWVkY=;
	b=TB8cY5h0EyyrJ7vLzZ1qNTNictcO6IwUd/9iprZ0kbcM0kTiFLRaH3QbRJ5d9WlUYe5E
	 rKJVT/IsqHrs2RbcZKHYPPjXB3f9MMaqfnTP2wENHMCFOwfzWk4CVhJ9RUZWxyKdY3lCk
	 iDgrOe//PcR1pDj+KfAHLFVaXOY3o9l4UV6jEgsDxcSfQeggXqpv1W2dwqz40iACUxJuB
	 cCm2ltG3PIcbr5e/bAlJi3YmF4H8xnvJofuwjvOj+artbDhYojfOxAkVcu2hNms8sayMa
	 anngqBp29Phr1pwgxR+HFPML6VSHvEe2p4kmtcoT+SM53Q2esoBny96vSbp71DP5yRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IhtuID7y;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D221160A2621
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D221160A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IhtuID7y
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so18444865e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 03:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793618901; x=1794223701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hRF/O+HDztPNhQ+cHx55rMvIzqXoQlmaSvpEgSUWVkY=;
        b=IhtuID7ySkIXo4Hk9MeFfA6vlePzqJmOzJUJEnLzMrG6bvadSvIlRxxnMAqBnGupC/
         SOAL3Di3s+QkKmeoJRXnGdPTNLOdJm9PqvPUYMlRU4hADJNFlTA8jTAn3ZsVoZduKkqp
         srCWnJ2DH0udYfv3spRh7hj1K0FkJzkoYEeUtoNo9iLU8dcocoWdx6PSptdc5nzS6VZC
         Z2qZDl4jgWX7rkaNoRqzqiv5e0rlfWwubo1SSgTJ6w5Y4KCZspsgOooDJ/PpnnkS/6/8
         ZnsY8XNECzBlHthEpS8uhvGsMTHLfYuiELnKUZGjdB6JBqw59dAX5h/H4x+7EoWxnS9b
         yeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618901; x=1794223701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hRF/O+HDztPNhQ+cHx55rMvIzqXoQlmaSvpEgSUWVkY=;
        b=z+tuahBEhzV9QyPnfERKGVCSe/A4zB70crYJwIUMcvwAj4ovjdxj8oXS2lzER3bIcZ
         +aZWxQNx5plkzXOlYPEdFcgb3B5G54ZtYPGiwkIZy30tEbaZ9q5SxIm0kVLIareuVGuz
         IVT7RhTT6X4h+8sTxF/+HQlPuyHcWxf3DruYWhoflEmPjb5wyi61hKh5i/6nYmSH14wn
         UNhiGxYMDXNxM/M5CC79WOqHMXo4Z9jO+DcRztYXjqY8M2IsvNMjW588xV2S9ov/L6rI
         w2VdJKMePHljHoLdPtbxlVSshOQGvJv66g8ukdaBlEKyNz0NADyusRY2kB9eY68BYMwB
         jiFg==
X-Gm-Message-State: AFq9FYLH1yDeZhDZGZTNIBDFINOy4eosrw3ICqPT3PiKpe7it+yGzLRo
	A54wIeCOk1Sj+Nt12hzXcCJZDocg7ytxXB+fuXCIb9U0fTHi7wXxWLugvz5M34DV
X-Gm-Gg: AYBFou3vRfeInXp6eBFQ2FJyYgD7VlxmErWq5Siia8oIiI+lS09H6hYWjd+Hde3DuUK
	g1YSd2SS2bF3WBhpiKCBwRs61sZeithprRlyM4Qd0DXXKQQs18LnAJzfa5LIhVVjnzUVOA7HCMg
	4c0LPXwjgKezEPPiDli8Fqj3Gg7VDPQBnMB462tj+tCVECxu4AuZ4haZOvxmQIGHapuBOIhGxcL
	CtKb31RkhusSkKkWJsVRkk52Kr2nWO6MnHWtfZ0XHV1Pw9QYkmEPuSJZSwxqJBjpa5dnMMH9334
	Z3YwMS4H7GvZnJ1t3UF2PP28iNbR06W5viyDbyq2/M3OWb1oFxbWR0hiZtmQOOJnU7uLl3IlsX0
	Y0KdxXT5JdLRvvAoFG3jJE+iE81mOgYXAbjkwvozQ2KImw/49WyKjBc8lFHRvzQlqaHr41Z6fiN
	HcKLVVLFt9eN1DaikPWHTnAARHlZMLeZm8JwJLPJ7QB4lXgjAnPb/fbVZVR2bd0Fhq2QgurnuYT
	4gQsgd/Ch36+4wJByw0WbYevQUPIfngG/jPkQrY9begUPWwJHzHEHn1LwY3kqmr2nGZbQK5JN5L
	G7td10Vlcw3Gck5/qQo/QU+ilQyi7S5HN+y2qisAv28KL1NOy2WXqpi5OafRbc/YfHB8058//1o
	zl2KnNVqoSv8NMVv7hpvpE1LKPSn38NyotBuFZMoujsnYkHj/kdETYQaGSGxAViRKVoRm0sb0Ah
	C2w8MG+FqHUEL21g39pzJJ9ZeCHYHWcwInw1j+zrP1K1SkA5JhoraU7g==
X-Received: by 2002:a05:600c:e558:10b0:4b0:a307:46f8 with SMTP id 5b1f17b1804b1-4b0a3074938mr46301055e9.10.1793618901203;
        Mon, 02 Nov 2026 03:28:21 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-f91d-46ab-c9c7-94fc.ipv6.o2.cz. [2a00:1028:8388:a84e:f91d:46ab:c9c7:94fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab61d8b9f4sm311382215e9.12.2026.11.02.03.28.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 03:28:20 -0800 (PST)
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
Subject: [PATCH net 1/3] net: mvneta: lift the per-queue TX rate limits
Date: Mon,  2 Nov 2026 12:28:14 +0100
Message-ID: <20261102112816.12322-2-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102112816.12322-1-pepe.schlehofer@gmail.com>
References: <20261102112816.12322-1-pepe.schlehofer@gmail.com>
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
limit is disabled.

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

