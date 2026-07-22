Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EC23B635A
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717946; cv=none; b=lIfj2uml8pGlmoowKjPoZyvO8z487V4paaP56YUwjQEXPjO3BfKY43niH/tlByX1JYKl52PVVzAOqUNiSy/cywDLbeB75oyVdZAdTEAQotAA+4uY+l3GqRKa94PIAPW1+t0nlzxDJxMLMvnLNtCO//cRYt3/RybRRPuAOyQWlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717946; c=relaxed/simple;
	bh=Y+2m3Cjh0GZM/8zl4hLbwnGe4heKADGoIn1TXLHDkoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fkk7woygekvGacjcIlmXh8xhvH31Bwg1t6QrNGmjrnam2ZzusEv7tS3DT5THQWciSwkiYeRfDDAJL/JaWgVvoFjFkmSxSGYZC1rXfqguqA5TjfDtF4jvVSB9rl8kgBnJuWk4Obq2p0+YTr0kIzhq1quChl+L3vnbQIKUzraX7uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGkL05by; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGkL05by"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4956242332dso25751365e9.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 03:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784717943; x=1785322743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xny6B5zm6/K02I4EsBQXeZiOMwF3w9XbaVxfsmCd+TY=;
        b=LGkL05byUnDVwggyGeOWFDcGFPSRTgRaJnX395gNm1KzDzyvxQVtDt4vQzzAkU/RUm
         isvdtUds/Am6L3fLE8blNUKwiZzWkidfDiFIBX2zIV0X4NrPbya4zbGOqeH3Xx8AOg1N
         lfoZ7KJpL6xtw4nH3lRF6tg4NkHGdCKO0iVdZ2bQ1VLBEsVNHAdsL+faTTxRLPmApcbV
         0oJ7b+oahi3cWR0PzPhhA7uDN4BHrWlZ+fYkgcDtGf4Tirxdr9RA4zcg2K95qX4nkB4S
         GyIWCZ9Wv4kLgNCVRvjGEdIBN+rpekj9yYJjrVMazq4pm4oyoC8He5+OE4yGyWtdfqMB
         +Kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784717943; x=1785322743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xny6B5zm6/K02I4EsBQXeZiOMwF3w9XbaVxfsmCd+TY=;
        b=QCkatjqEf9vFrKvd2leX2nUpfNirkhYTpNLbMaJfzX3RfVxn7+avTsC6/NHp48tQ+6
         b7tPaeRo/9CxEt1x/59R/TYaXh2K2yi62xyG4ry1OtulU0DaivGl6eJaHzDJAQJBONnM
         rLHZSmu4qiKjCeh4UVacW3+S1m2UsH4doDJ2/F8w5VsawIuT2kQxRblzHLExs5cZ9OfH
         WjsBD9vIP9hKcS5drQ63NJ04Tz4x8W09sFm1o3v5lNpxxm4bGSvJsXJB5GsOTdbTgTzx
         4FWVkf0771naX/1lgx8Z5Sb0Qgmxkqy/zGOfy00sojWzT7/HZnSoxbDMnxF3lHbUbb3s
         JJSQ==
X-Forwarded-Encrypted: i=1; AHgh+RoazZ941qweXdKIv3HtoKoLQu08fYumvvHO6BHYObz6yMqUZir+qYyBRTCG1gfNP3zAe9tbgAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGIK6xTTQGvJg7+S3XTMg3bk58C0ToPxEgQSYROiT8PbtGJ5jj
	QZERcRngabQdPEndEdtQMyweOq+Nv+pGluD02eKEfSB5oNsxZHnp8mcQ
X-Gm-Gg: AR+sD13xDsCmgCVVrhd3aJSOeULCIxarwZ4ry6U88M5smUZzaVEPGnmbn7Qn1TmGjYL
	yB2LhsNZ7MgZ3eXwGszVX9t/am6iEdz82sbbgKxHtd71bJcis1Tz1ekjXzBiY8mG0V0f+vZEapf
	sel8kybAP1syRfkAK5HURuAFEUAnzOK1wy+vR92zYxQJV0ZZhi36qReG6m/B4h7xvv4CQy23VdN
	5bsPcQmzFTMXR+DR7QE9KH3dUvgzJAiy04H4knpkhITSRCpoH7nqUfW8WDiarrer/mt3gJNdIeO
	e6U3O4+Th3wgYHX1rcew+xjI46Ce6dolfpgYjJhyuByxdxfdAnzfpFycge0GQq4dSZ+HYLtIKap
	YY7FD1J4PhrYo/iGakrPscBULEJyp5oFUgWyxVZGiHPYW2jQfYcaESFGWUnji+/0Qlv0/a+wypF
	cpB/N6p4tXT2FYdzjJByTBd6xrrsi2wy8a+rw6g4WUnuR5lagCtlyodbas6JRd
X-Received: by 2002:a05:600c:8712:b0:495:689a:b3ff with SMTP id 5b1f17b1804b1-495689ab749mr65432675e9.8.1784717942943;
        Wed, 22 Jul 2026 03:59:02 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:6708])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a6354a3sm97635085e9.10.2026.07.22.03.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:59:02 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net 1/1] net: devmem: prevent net-iov / page mixing
Date: Wed, 22 Jul 2026 11:58:46 +0100
Message-ID: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should either have net_iov or page backed frags in a single skb,
otherwise it blows up down the stack. Don't allow mixing in
zerocopy_fill_skb_from_devmem().

Fixes: bd61848900bff ("net: devmem: Implement TX path")
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/datagram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index c285c6465923..35febc1c25fa 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -712,6 +712,9 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
 	size_t virt_addr, size, off;
 	struct net_iov *niov;
 
+	if (i && skb_frags_readable(skb))
+		return -EEXIST;
+
 	/* Devmem filling works by taking an IOVEC from the user where the
 	 * iov_addrs are interpreted as an offset in bytes into the dma-buf to
 	 * send from. We do not support other iter types.
-- 
2.54.0

