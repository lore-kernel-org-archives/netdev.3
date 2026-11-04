Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832332;
	b=ZdO0UwV2ImKI023i6Qn2y+iQiqEKVW2JFNx7OAmpCs7CO6HcnTiRfE0vHHIKF9htWGHd
	 X+Jd4qH8HCnXJ6LJ0I78TnTTwWjLUx2XOKziVLNzg+o+HNNHo4OuEgTFd29mCOm/sHKow
	 8HjreIuFqUET+tLWh41ie6oUlE4D0ZltLqyTTOhlIw5rJ+2jEsvnjkMCpzvtjwNrTDr0h
	 83bDPrTvbkp4f/v3sRpfnFwY5zRR9G8wInfoCG8VZN8MxpX5UVulFRjYqkU3Seuq+Tj/C
	 Sy8D3DOaPn0aGNojs7OmYweckTudBCip/n4v9LXeS0JC+dmXp86ZEx+H97o8LZrUmWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wf2ubSFtIAOEvUliBGy80qozrHe3VudvpTwZNlbcLds=;
	b=3phwcmgHkbnnxLieZSs+KU58HlUhfBetni/6kreR6gK2S19Y3mC2KznSinTYNetTGVzp
	 LZYoE10sked0anXjsIGNiashu8IqbdyLV6otC1xTd1SBkwLtV2y6fo35NK6ecN1NM0AUL
	 9fdkxqK5KtZg1xF2Ip7IT5HRaareWSfRI4FnbpRZWTkO90N1ejk9CAZTD9Ip5Un9oikgn
	 dDg9JlEjzLLqMVrlyqHgdaIJIrcyHFjv3xhQ7qnngK09dYnwWNlcx3GQn5e3jK1Q9A7JR
	 DMcLWQAJOKucNCR9LiJOYlo4jscWzPJoGjHti3ko9D2fOKFY5PA54jD5PW0tAsiC7PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fbQ+5xWE;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF026606D83B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 22:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF026606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fbQ+5xWE
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so13489775e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 14:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793832330; x=1794437130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wf2ubSFtIAOEvUliBGy80qozrHe3VudvpTwZNlbcLds=;
        b=fbQ+5xWE4q+wz9tYOxtT1ZfU/cvXoymYmamRl/lOJlIv+d93+GlStvc7tUtDFqLIGf
         e9efs2MMjau0tUK1sQ0vWKkDb1jZjeJHsL0yxLOx6hDcCMo7tvwsB3ubDxwkEbhhGw3f
         izWzigjRr5MYMG1+I/ynmHZsTM1exW4oKWwrUIu0v+6/du1SYhM7JE6+fammIEnl9JKX
         VDQt3/lDsaFyQ+rgDQKT5e21mB2EmAmu/H7GPtxPXk4S6+NA3kKkyoKn+w36NUa7UYU0
         7FqsHv7KKPLhVB8spg79yBCdRfLgjWPJiSUBYIHTWOyb52shcQ3Vwp5a4PbigMt0JHNc
         N7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793832330; x=1794437130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wf2ubSFtIAOEvUliBGy80qozrHe3VudvpTwZNlbcLds=;
        b=VpYe4hND8ZSCEgkIVVdyo69/Ot77fNeKhN4q0SWtOgw22t/gXq7qsHAPz0fMLf2wwY
         Fk6LCIbVzQ894J+B+yRPWmFkpoV2GvMID6501Ca69gg4TJt9fP9hOnIBNi9z/LoVP9od
         o43mrZS3GinaCqd1esT4jf5avcKU2JtXr1B0a7ISYXLb/qRJ9gvhqZ3VOkDYJtyo77Sa
         Et6notIAFGexhV3kRwNncNxCRxxGjDTNC/xku8VjgQf2+979Ajujvm05VXP1evzm6/mV
         4/P/2SCXNW8eHeMu+ZYUI/4jAgv1iOdsKnq9VVRZ1wZ5IX+hKlOBmoaMCnIQuupcMtXq
         QHaA==
X-Gm-Message-State: APuU4Z8wqL275F5GLVjXmLWgR9+WF0GZDbC/4PnR861189Hq8saZcBKx
	bkWE173+iED/fwJit5m1x19LAbsQcgjE80MDBC2dCPR+uTctZnuzasnuEIVzfnuX
X-Gm-Gg: AYBFou3OFV0u+RDbsrqljeMgQ/jIb2Dqt/jw6ubts4voQUrryGil78GiJ9OJMDVK8cE
	MjVjQ9nnoiFqVjp1K70+W40S+4AIWCwf0ZoYA+VZZKokSZVHEZMIPo2Yj3Vp6bDszDiHEiVBWXW
	z5E0pEobrWaoKbu17YcQBbUipT96aULvFxbdNYEu33f7eUsK/Lu4lMhjxIeHHOR/EkzjpnC5kCz
	R4ps3mOvxYoYX/oxL44QUM/qTXr7+5x43CDssbNDkGHB3ddvd2shHPNH5yA4cfZTGvoNG+AHfvx
	w+4+iJQiH9UB1PVrL6ZCxQG+i02MNXaLxlymuNhmLT1pgtgyx9veC9MCIsPkT2ggjplAllE6tUe
	T59TU3y3WDDhlpTEX4rnPPLLJvnjSuuLNh40WZR6K+JrEd8mL+YdTVd0YldAbdFCt4T1pf8RuWN
	BdNDLF2YDpRH8wMHCUIiYe5Ddbr2bDvHEbnHRD27j5wNr9qXjg3AOer4bKZWnsx+qOI13W7244l
	A6cjNbv/6dDeQKzRJFyrKxNisdZ1F/oJZw/g0QSKU1hsBdhD2xhINq5eOnzu2G+XAknzZUPs6OI
	EllhjzuU2aF1qDnWAxVKc2m3wt/R7xwyxP34oidX/djjgmNglMRZOV2kKiOkHBf8UP/f9I5Acs3
	me1TYfsdM81t/UAH/HP/STTdGLJJqW/FMg8tGYA9Cw0zoURZU2tecV7lERRrWEUnyAAWSccfOe3
	HVIf9wrYVX7BQOUr/xk6x5cT+TS4G5jhkOeMUjKGSxY9hyN+XMTGsExA==
X-Received: by 2002:a05:600c:848c:b0:4a1:d087:f6ab with SMTP id 5b1f17b1804b1-4ac17d19e0amr385497385e9.18.1793832330287;
        Wed, 04 Nov 2026 14:45:30 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-947d-5f15-1dc3-a8b4.ipv6.o2.cz. [2a00:1028:8388:a84e:947d:5f15:1dc3:a8b4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4320efc7csm36604235e9.2.2026.11.04.14.45.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 14:45:29 -0800 (PST)
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
Subject: [PATCH net v3 4/5] net: mvneta: keep the TX rate limits across open and MTU change
Date: Wed,  4 Nov 2026 23:45:17 +0100
Message-ID: <20261104224518.66487-5-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104224518.66487-1-pepe.schlehofer@gmail.com>
References: <20261104224518.66487-1-pepe.schlehofer@gmail.com>
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
 drivers/net/ethernet/marvell/mvneta.c | 31 ++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 171111d7fe57..2f8c134a921e 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -683,6 +683,9 @@ struct mvneta_tx_queue {
 
 	u32 done_pkts_coal;
 
+	/* Bucket refill of the mqprio rate limit, 0 when not limited */
+	u32 bucket_refill;
+
 	/* Virtual address of the TX DMA descriptors array */
 	struct mvneta_tx_desc *descs;
 
@@ -3752,6 +3755,8 @@ static int mvneta_config_interface(struct mvneta_port *pp,
 	return ret;
 }
 
+static void mvneta_restore_per_queue_rate_limit(struct mvneta_port *pp);
+
 static void mvneta_start_dev(struct mvneta_port *pp)
 {
 	int cpu;
@@ -3760,6 +3765,7 @@ static void mvneta_start_dev(struct mvneta_port *pp)
 
 	mvneta_max_rx_size_set(pp, pp->pkt_size);
 	mvneta_txq_max_tx_size_set(pp, pp->pkt_size);
+	mvneta_restore_per_queue_rate_limit(pp);
 
 	/* start the Rx/Tx activity */
 	mvneta_port_enable(pp);
@@ -5212,8 +5218,10 @@ static void mvneta_disable_per_queue_rate_limit(struct mvneta_port *pp)
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
@@ -5239,11 +5247,32 @@ static int mvneta_setup_queue_rates(struct mvneta_port *pp, int queue,
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
+	for (queue = 0; queue < txq_number; queue++) {
+		if (pp->txqs[queue].bucket_refill)
+			break;
+	}
+
+	if (queue == txq_number || mvneta_enable_per_queue_rate_limit(pp))
+		return;
+
+	for (; queue < txq_number; queue++) {
+		if (pp->txqs[queue].bucket_refill)
+			mvreg_write(pp, MVNETA_TXQ_BUCKET_REFILL_REG(queue),
+				    pp->txqs[queue].bucket_refill);
+	}
+}
+
 static int mvneta_setup_mqprio(struct net_device *dev,
 			       struct tc_mqprio_qopt_offload *mqprio)
 {
-- 
2.54.0 (Apple Git-157)

