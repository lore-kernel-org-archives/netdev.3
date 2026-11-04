Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832326;
	b=uFHpt6b/SAs+Z+VNoSHodm+4bFXaRMg4bhTGu7RscYsR6rRJmagACsePboxhkXCIDPRU
	 mIvC75lxPpZ7dWH7yLzGpuzxEcOhmi8mjS6/48DnGkDKZsvPw/ArAaNhu4qasaLu4WSeq
	 wPTHanmN4BzevO424SMyHpH/79DkwufGDSYbliU6LqJc0bzhGGsOw/6VNCDQwWtsWIVZT
	 BPiU8sHPyPPx9lFmSR+VdhZAFwacRYYD/pvQ71WGZP0rhtkGlN2AnZmCHb1YQr6BvRlKh
	 W4FmKsUz2mMUUKx0lGcPzwNWnBnfl4+2eqHu+pIuQi3vEbymSSyNpFwcTQvO7hcQSDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dKvbUwWZ9bjs+rv3bgan5D2HrfRSnQNu5fDFTDBMNpE=;
	b=j4xI2dQwfcqfrsEDCgK+PXGQdItg8i9VdiMoQtk3h8PHS8sdMYyJt6lcb/aQFP/TVALE
	 VcnqrNf8h2T5YyePwbZUJMZSLYCbojKa0P9ryjKwHN3achi//wuE4ibPDJRO1XxrGMYWX
	 1p5FMjgqYXSjl6yCxCJBs8Yc5oY7W5pGRg4ndQ9lYFV9SMki7DteSXJV2Cs0ycEJW3ONO
	 NPBPpUAFWZwNEEgyxhjdj4sEiQu56nctr6nACuPWpQEP90OMFp8yXQXKqLk8gyolnWZcU
	 eB1ueDEqiFFkjf/wpmxmC8P8j4hb+LqS/d+Vv/KnxYIN3W8i+7jcb+hu4a1gjAnC99w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TUESKkci;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB0606A33D
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 22:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FDB0606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TUESKkci
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a208d93758so13851375e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 14:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793832325; x=1794437125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dKvbUwWZ9bjs+rv3bgan5D2HrfRSnQNu5fDFTDBMNpE=;
        b=TUESKkcihhHdMZw6nXxR79lG9KQghqkHAdh/7XlWk0qxd2lkBwOnJxcgLFYt7Qfkj+
         CqO8F22K9Fgm3xiQnMRVuwZGvRCUdvk3FUeghsl/Jfpq5CW9C8QZzV1X+U3cefLHOwn+
         +XnBBZY7/fy92/7NAs4PDGvh0qJPF4ObcPrREb4A2/tOOs4SkGpLf8fm/kw4Glw6XQlm
         ME5yrhT8SPrCm23wq72uLEHUIqBoTQZOl5l156xlTH+6M6LrQh12Hy9zy+T74BWrWUpq
         q2+l6S07vJOqabMoSP8ld0fSy1unv5iwM43bdMgwf5n0U8jj6SFRfoeqaKikLY2aFoEz
         PesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793832325; x=1794437125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dKvbUwWZ9bjs+rv3bgan5D2HrfRSnQNu5fDFTDBMNpE=;
        b=QCNe0RStZxlqksiyB0XKqo5mXsGVs6lhdYaqNkyg8SMYEG9JB6r4MklxP0DZrism70
         4Ms4+F9ttJrvKMCeTtxc1CJ/DBijAk24cAG1gMTpSR4f/2UZtWueuIJzCi0/QzU2WhbB
         UKaQnhngqW46ezxNHB6iRxeoTvtgBGGpF9BC+si9ezkW0l2xJYCRgFy6i5+P5StuGJOt
         JGl3OwM0R54enyCEqKthtj5bO7QWqfwzDdeiGvQeSlYy0m6Poct69hMQGJAImnzJRTjG
         cx6Mxyg/mPzq52IKkxePfLEGqiMVNsNq2Kll8v3TK5Ul+3Oofcw89yOTWU0tTs4bz1pd
         TKxQ==
X-Gm-Message-State: APuU4Z9/G0AedEl6x0AC1egnFWOer3VZ6RP9VauVy348ItjgESn7YGLl
	DQ7P/OlPjKDxCs3PZdc1i617ZSembEp4fgjK+pFdWGp1GGVyqokrBnPnVcrFVffw
X-Gm-Gg: AYBFou3R9pyZWmj/gl1dVn+5sWN0m4tGlCB7vN/U1OODgMCJDqGstFe4zh+Lc2htKe7
	UBt/8J9TG621inV309LBy/fk1GDKYikLIamVSIx4PM0xukqp5WXlqJVWMcs4wgdnP4I30oeRGx8
	ALuIMt+TlSAL+AyJ7gJfZRfxicsM2GhnonPTpkneQnkPUEm3/QYV8FooYoCYGuf3Op4j532mNkJ
	1aGwwx++U8eHEyScLL4re0ZDndqUbeECfDT9IsCwQwxgGSaGgIzBLASJQBhlcZP/xXQ0A/zGmM6
	xHo15HauK6n4enUnbUhFD1ykYTSpqQoqx/Bon7zDB7DAQYUaOpx0Uh4WXmD+vJwn39nfY65z2Y/
	jVvtSShrc34vo2/WUHxjSBnOtxG5DLzTjhBtPyTa6n+SJDi0/M82qPIpitDzg6ZdE2XCH+uUS86
	Il7ZhUtyO98C0iEbDY2elZQf0qJnes3ADsPMEkKw7oDQO2tWQNl3GC1/ocOnrm+yIzqEHAEECEk
	JA5LLbQZ3MXGQgUw+Nww1aKuysQ7h4oRFh/orAgWdBVOoZq9O/YVjkx03RvKJ8I5J2+IOFqA1TE
	u+UhcuayZhRgHqYRz7K2v3lQEcPpIJ8hE5w6Gpklrx5GnrczH07xjg84dBgqaLFU9WMnO7egHZC
	yWfWhnr5fLJN6mUZmVjHf01nO9VoOFFjVvoq3Sax6MHnB5+CXI3Rac0ag3SWob4guKpLrR5dIPB
	nrrF5UIURqPsRNK3535P19P/j6ziQ4XrjV3JAGyoOki8Q9KZ8pH4zz2w==
X-Received: by 2002:a05:600c:5397:b0:4a4:4d57:8462 with SMTP id 5b1f17b1804b1-4ac18b7e65bmr382188585e9.24.1793832324746;
        Wed, 04 Nov 2026 14:45:24 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-947d-5f15-1dc3-a8b4.ipv6.o2.cz. [2a00:1028:8388:a84e:947d:5f15:1dc3:a8b4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4320efc7csm36604235e9.2.2026.11.04.14.45.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 14:45:24 -0800 (PST)
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
Subject: [PATCH net v3 1/5] net: mvneta: lift the per-queue TX rate limits
Date: Wed,  4 Nov 2026 23:45:14 +0100
Message-ID: <20261104224518.66487-2-pepe.schlehofer@gmail.com>
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
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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

