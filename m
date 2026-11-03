Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710239;
	b=J2j0T2K6MrrFh5c0JCmtXRM2GUD2SHrq9ueFQi1Hgv7uQxs3WeRQimlKCJQYj3mhbvZM
	 d7+6SH+Fz+uXyNbBTGGO+8oBe1En2cEE0uCH3x/L0qPqyuKqN6Ssab/+aLeRjQlh+L2IF
	 N/eUKFRApjF9KFNh+SQ2KginqPAG8UbQh2BM2usJ280wzrwLWNUA5xwjJ5FwVEJm6awwW
	 e5RHf1P0jUnbuPxgs/h7pIkfTOs0mQEFOpJHkRM1DvWU0ZBg+R0RDK8t9Fm6GNyR654a4
	 mhyZgEWL3VDtj6WxYIZo0UKvKFNw7yRcLJ6oHV0QZMZJp9TgupCWgm9byiGaIaJU0mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jVrnVM5pKch8ALP4Sr423DqQ71KjBHkeHchxHqx7jqY=;
	b=Gn8i/Fucd8w+PZeAFaI3kssCPEbxm46+KGRSBoioqUGJ99bDkowQI65dWI7Qm6O/ATO8
	 1oEehgcZEIjvv/+w8ILvDR0oV779dquseN77s1tPJgSUtHp5/VefJaIvLpy05NSPFNqAW
	 NwXobLE/RPSzXgqXvdEFgcB9DUuOGQBMHjbIZw2z2VhjzSAJR78/11Xn/z9Sf4i1Ukhec
	 cdixTPMTBW6z6P+/eMoncQCNzY3xJRF+ZJSLg/kol/vtNpiL5s95yToqR6CHsPcRVfRKL
	 +ixRJmWdo1HQhWj6/KkaaZN2SewhzhIWPLjTbO+XTvbPAdMddSw5fX6miMNbN0eN9VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J45r0QLa;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53013606EE9B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53013606EE9B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J45r0QLa
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso33735885e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793710238; x=1794315038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jVrnVM5pKch8ALP4Sr423DqQ71KjBHkeHchxHqx7jqY=;
        b=J45r0QLaMhUFKKwtwI6bskQVY90x7FdFASF5uISpHDP6V6oS6KTPJ1UO92kskRsrd3
         oR1hkNSxY3Oa+FwxaYvqgK0zYH0pJ/AfhbrMbSBKZI2jOBwyxuVln+6Z5gt78z7xBjaI
         GUK8QXt7jQw0jFepYcYUzPv4uznWDH813mz4UCJWMHnNcwx6cvB9bjfT5UUubGOBsAGZ
         08+Is6PyHe7nyoS+tS6DOP1ZscTEkuG9/mNxNuirIIoNhVW5host1JJ2KVqgvpygV4dJ
         W5eRsPe6GCLs2GmPu0ln/oemZd7U/L9hgviRqhmB0QXfHZj54koh7zHfPQMrOdHLXiNW
         BAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793710238; x=1794315038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jVrnVM5pKch8ALP4Sr423DqQ71KjBHkeHchxHqx7jqY=;
        b=h1cEkgUZfnwqBtelN95WupRBlHjZ3uk4Ox3qUZJBrAmvBt1L/I8KhYWY7A3ts2+lef
         xioUywD5jXOPazGFMeVQFfxMhQwj747GxuGNjcLIiSSrifIxAqs8IU51V3zf77a9m8iD
         aafwvSS2HOCISV1warOJJsZAZJ8WsJXFhr+rcL7pYQ7XS9Z9puvvbbBL2YpJAvNi59Sn
         bo0gcK3JGbjUy+hkBd5mCbL6CyOC+pJ4GVml1fUO00ht/q+B/IdMohtmBUyIhjeXfl45
         M/KnVdxFTOK+gnyBMnDcBgueLVkUec9kU6UcrkOWiCXMLe6/9gB615yJHCKGhFa3ESRi
         ptbw==
X-Gm-Message-State: APuU4Z+wPcZ0Ole54XBzTERgDW+fn6yz3H7xUn6o8yT+otoGa/1cq0VU
	KM+Zd3MXbXNqM9K8iVyrmqsa2trACw+A360PuSahOw60EvWEx8F1bPXn2A0TjCT1
X-Gm-Gg: AYBFou0slAJ35LoPckMSZKJssDM6jX7cBju1a/vdUpVdms6b52vGkj1VRpQ8k7trBaG
	HrbjVk++wMObZtRAn7KDP3wM3J3Um7XPA3pLjjL2Rk3nKDx5lIFqdNchwnaXt9Bhmq/hLTa3ZNu
	X1oYXyuJtaX5Ew+INXtcM3Pu+G4ksfGIxQW/9j8qldNPh33xwt4y/5TP2h5CTawXTXEKAczISJu
	jrkAXtwWK4JrNJOp3r19iNZBT66C7PEeZx0bw63fBeNizJkzJWJTvamQEXp22wb94RNSUJEJM+W
	djyXe/aRpzF2d32juW+S5xxiuMqqZJZAPXrWJfhkPWV8WuS9ahTuaF3sNcraN8UqEigfo3a0XAw
	klqyBug0MiU9v8Z1iUr09Xej633/Eh3XseOhbex2a0wOXe3PruJU1SM6LoI7Wp1Rc/Q0WRzDepc
	tT96zkqfsZ5xbqFJuH7Rp5PKcZE3h3ekd5SV703ia1EHBYqGoxzSdcJGXWG5I3XEcFfmQQ50GGC
	DW6ky7oxgQ954/x62d96XjQu1ISDmVDWYmBEGM+Lw4NDeivN7oyR9DJw8WF20V1JoxRYRpBtQWu
	3+86w4EtIkCSah/uW//b0x1avONrCdKYNSm/pn+zmd7yGJaZ+oX7e3+piZ5syiQPMJ9d8ZF2wQf
	grxB6tW5Pz87hW24NFLcHJ5/L1ZE8hYhj3sOpenecsObHZ0KKnykR1h4cn89ROw==
X-Received: by 2002:a05:600c:19d2:b0:4a4:4d57:8487 with SMTP id 5b1f17b1804b1-4ac1737c51dmr287915995e9.5.1793710237655;
        Tue, 03 Nov 2026 04:50:37 -0800 (PST)
Received: from localhost.localdomain ([2a00:102a:403b:96a2:e8a9:f4a7:ed37:36a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a5372d8bsm61406425e9.0.2026.11.03.04.50.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 04:50:37 -0800 (PST)
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
Subject: [PATCH net v2 5/5] net: mvneta: keep the TX rate limits across open and MTU change
Date: Tue,  3 Nov 2026 13:50:21 +0100
Message-ID: <20261103125021.70845-6-pepe.schlehofer@gmail.com>
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

After the interface is brought up again or its MTU is changed, every
per-queue rate limit set by mqprio runs at 10.23 Mbit/s, whatever rate
was configured. tc still shows the configured rates.

mvneta_txq_hw_init() writes the token configuration of the legacy rate
limiter for each TX queue. This also sets the refill value of the
queue's token bucket to 1023, which is 10.23 Mbit/s at the refill
period that mqprio uses.

Remember the refill of each rate limited queue and program the rate
limits again when the port is started. Resume also starts the port
with mvneta_start_dev().

Tested on a Turris Omnia (Armada 385) with 1 Mbit/s limits on a
100 Mbit/s link. After the link was set down and up, or the MTU was
changed, each busy TX queue carried about 10 Mbit/s. With this patch it
stays at about 1 Mbit/s.

Fixes: 2551dc9e398c ("net: mvneta: Add TC traffic shaping offload")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 29 ++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index d3a6bf8f383e..92a2ea930002 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -686,6 +686,9 @@ struct mvneta_tx_queue {
 
 	u32 done_pkts_coal;
 
+	/* Bucket refill of the mqprio rate limit, 0 when not limited */
+	u32 bucket_refill;
+
 	/* Virtual address of the TX DMA descriptors array */
 	struct mvneta_tx_desc *descs;
 
@@ -3773,6 +3776,8 @@ static int mvneta_config_interface(struct mvneta_port *pp,
 	return ret;
 }
 
+static void mvneta_restore_per_queue_rate_limit(struct mvneta_port *pp);
+
 static void mvneta_start_dev(struct mvneta_port *pp)
 {
 	int cpu;
@@ -3782,6 +3787,7 @@ static void mvneta_start_dev(struct mvneta_port *pp)
 	mvneta_max_rx_size_set(pp, pp->pkt_size);
 	mvneta_txq_max_tx_size_set(pp, pp->pkt_size);
 	mvneta_txq_wrr_set(pp, pp->pkt_size);
+	mvneta_restore_per_queue_rate_limit(pp);
 
 	/* start the Rx/Tx activity */
 	mvneta_port_enable(pp);
@@ -5234,8 +5240,10 @@ static void mvneta_disable_per_queue_rate_limit(struct mvneta_port *pp)
 	/* The token buckets still limit the queues, refill them at full rate */
 	val = (1 << MVNETA_TXQ_BUCKET_REFILL_PERIOD_SHIFT) |
 	      MVNETA_TXQ_BUCKET_REFILL_VALUE_MAX;
-	for (queue = 0; queue < txq_number; queue++)
+	for (queue = 0; queue < txq_number; queue++) {
+		pp->txqs[queue].bucket_refill = 0;
 		mvreg_write(pp, MVNETA_TXQ_BUCKET_REFILL_REG(queue), val);
+	}
 }
 
 static int mvneta_setup_queue_rates(struct mvneta_port *pp, int queue,
@@ -5261,11 +5269,30 @@ static int mvneta_setup_queue_rates(struct mvneta_port *pp, int queue,
 	val |= (MVNETA_TXQ_BUCKET_REFILL_PERIOD <<
 		MVNETA_TXQ_BUCKET_REFILL_PERIOD_SHIFT);
 
+	pp->txqs[queue].bucket_refill = val;
 	mvreg_write(pp, MVNETA_TXQ_BUCKET_REFILL_REG(queue), val);
 
 	return 0;
 }
 
+/* The TX queue setup overwrites the rate limits, program them again */
+static void mvneta_restore_per_queue_rate_limit(struct mvneta_port *pp)
+{
+	int queue;
+
+	for (queue = 0; queue < txq_number; queue++)
+		if (pp->txqs[queue].bucket_refill)
+			break;
+
+	if (queue == txq_number || mvneta_enable_per_queue_rate_limit(pp))
+		return;
+
+	for (; queue < txq_number; queue++)
+		if (pp->txqs[queue].bucket_refill)
+			mvreg_write(pp, MVNETA_TXQ_BUCKET_REFILL_REG(queue),
+				    pp->txqs[queue].bucket_refill);
+}
+
 static int mvneta_setup_mqprio(struct net_device *dev,
 			       struct tc_mqprio_qopt_offload *mqprio)
 {
-- 
2.54.0 (Apple Git-157)

