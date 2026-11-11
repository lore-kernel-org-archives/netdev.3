Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440635;
	b=CUNUTZWietdyB+NCKRhhm7scgweSbdr0w+EeQPmTk+1nYqqePFDfijREGIyKRJM2Vg8N
	 oelYRvVYbP+Kf6R4Szq/w7qBnkEttXNfd7Zg6EyZ+zZA9fCLYqVipL4rKdfV9sSRbzFu7
	 TISJuOoas0mStZO0DWVKYG2QrvejIrPHhDkKJvxq4iZgtR/Tc1X2f5/bWpFj52Vg6iFcn
	 NLZk84QKeZ9UKRnefvK2BMM57UkxyAWxIFrETUPGRnZVqUo6Q2OBbruHWtphmp4ahNZxr
	 +nkmqoO2ar82Tt4vCmSAcQ3gzGZY/5WTlKu/Q9HMZ5cD97GDx4DJyAoB/j/sba0Kmxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZJa3+c7lvB0GyH/4c7Bbh01U8Ethr6bq+o6IlSmjCFg=;
	b=Q6+HI5wn78348l4dSnhXI+IgnAE3tGKX7+beJEVm/+0qFL/iQKcAL0RaHPSZG4l3uzqg
	 5TVnw7FZ5jaNXNvDpljewNmoqngm1Qz4PWMAg8gc+ArJlJKvCiSEf23Lum4O8RSv2eTWp
	 A4pG6T0XK3Rets7EBLb7fVkMHDZ+9X+nrsrXZNY4o8Nrz+1D3kl0IrvezQmERba2nmPXS
	 cdNufTvFaZoOUhWFRIBAS8dXOJn/n6ScSG1b1CjfrFs3Cuiiv/lAhr2APM3V+5ZHvCVIP
	 FAo56hJm5mx5gnl6POb404pbuehPXRSofP+5pOTjKEUrgd/LO0JOfTv1cUr0/L3r7sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E3sFb9vy;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A0E606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2A0E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E3sFb9vy
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b6a88e4341so1706631b3a.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794440634; x=1795045434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZJa3+c7lvB0GyH/4c7Bbh01U8Ethr6bq+o6IlSmjCFg=;
        b=E3sFb9vywxekelTd16YxQPmFZDdFroKdTTK+rDlu4uqyhGfWrWUxM4Z4M8ejkvNYsK
         xht/H5ZY3RuQnWZqcz7xcRuueM9gt0eWLQoKNThblfCQ83rZi3+6I09YTDcvqsztxh2A
         PcVrizo4pAhRkPEoZpgW2GqxGPDbFBN2nqGIMHm3jBdR1etxiQ50/qMvGoABPMapBAP0
         ei1Vj40m7S+M4HKA3d1hDf81EWFVwRUZUpUX7FyhOFnKK6v8mib0QFDpLXLZ1ukOsfVP
         V31F2yBT6aVWRwMhKZZ2b/fyKYSyxNsGgb/nuJiURTJ6rErXSu2CEofbF9UFeua+Qwu4
         68DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794440634; x=1795045434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZJa3+c7lvB0GyH/4c7Bbh01U8Ethr6bq+o6IlSmjCFg=;
        b=YtTu6YEuSkyXW9rNKH0DWOWPUkaBCcuG78idWGj6eDobyy9TSznnDPoyV+DAexSYa9
         s8ifGFKlLw7JutdaqdPhBbWq//7dA2tmcW52tR/rvjuzKQebQXN7XAT3YFvau82HdKFX
         i+DelLuQvHftce3074Lx/30wbJT1ptoFNAZUFtSWAyxnCpynm3ThnogcuilwdvmofMWY
         m7QpFTfehYH8ogy/xQogXNspTivSsjXhPrHLi+JWOwmq0nk5zBsWOLLhCG2eAAGSrVJU
         D70gs9scH4acbY8GJAkxCKzGtQMYqvIq0vHrjXCNABMXJRo6Ys/rCytYMEdbplJzGHKo
         ho0w==
X-Gm-Message-State: APuU4Z8OWWAd02YwQRSVyK4RQ3StZ8ah83TAr6EIVBKv7SQ/PrP9i2Pj
	GNNIv+V/0523xo/Q38Giz9rW5po/rt+aiA1Q7URt8YGkGCCsC4sLdpSF71HFAg==
X-Gm-Gg: AYBFou3fQYyAFpjpDO4Kw6HATmwXJm1Bi0CEJC/zR2E+yGIFBK7VLrLtQkX/+YwCJTm
	lZ6EgJvSjUmAruU24lEncY1wihLXi/GF44Pn4LZb6RgvOgYojEo/18dnUDysYoyDvSToOmib71S
	4qT+f0KnJo98jtfuY9yoYEQElWuKbdwCi+bZgUGvI16I+cAuXNBIOnYsxk2/Lnlcam/X6bnFEdX
	p1IR3uJ4vzS4mmitGFpXG8M1p41wGpLnk00LfTQE0I7IJP4XNkD7wLQuVHXLCouIDWRx6KQsNRr
	V3lkuyMuNxltZYyqIQIqjEw6vdNXEj6NC0RRYj2JgXcXu14WQr4ZABQNMYsRxkKkwzwNhO6mlL7
	voC5iww+RGJvMDEAGBVTgDji5LqKoN/dK/Q7m3Rkr0JOkjegqufLnQgZPdM7ddRWTBQQVlabWrZ
	zlv4Z7wczoTrj7peO90H458FErxLM20xTy/wpCfHKtCiFrRxbmHd7gQQZonqnNrTtKAAL17OeYO
	Xd7NVapRdF23eA7JTI7A5iOiNr9O+6VLMdYIu7MkwrIpN1+KDsM+XNA7i9Sb/Nr9V6VErRKpCfy
	x7XZ8J2a6UJ4hCIx4FP0c9J8TNxHitrPJABxo+NUM+J/CTifiZApgA==
X-Received: by 2002:a17:90a:d643:b0:3ad:43c1:7d41 with SMTP id 98e67ed59e1d1-3b182fbe2e4mr3515536a91.33.1794440634111;
        Wed, 11 Nov 2026 15:43:54 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:6e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c74bf3sm1328794a91.10.2026.11.11.15.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 15:43:53 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] net: dsa: motorcomm: FDB fixup
Date: Thu, 12 Nov 2026 07:41:03 +0800
Message-ID: <20261111234110.1449602-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Various FDB defects. Assisted and verified on the hardware by LLM.

There are more gotcha about multi-bridge setup, but I'd leave that for
net-next since multi-bridge has always been tricky among DSA drivers.

David Yang (3):
  net: dsa: motorcomm: Do not inherit ports from dynamic FDB entries
  net: dsa: motorcomm: Rewrite FDB entry on port migration
  net: dsa: motorcomm: Use VID 0 as the unaware PVID

 drivers/net/dsa/motorcomm/chip.c | 111 +++++++++++++++----------------
 1 file changed, 52 insertions(+), 59 deletions(-)

-- 
2.53.0

