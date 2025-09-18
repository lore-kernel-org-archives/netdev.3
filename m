Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FCA22FE0E
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197499; cv=none; b=jEHqo7nuXmUN1hGZTREbs6FL66zGufctc91hTPwQYs/7dHbR3py0PHhlwF2DEt6Q3QZG91dsvlaEYoTm7BfFE1V7IDR59T6iuXezcQMPZyl9T3GRCaoJZou+0/EwOCCigxC36wm1NpkAWs4zwqWefT+mokbaBMhI9GyxFcRyPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197499; c=relaxed/simple;
	bh=pM/QS29tKZw2LpLFbZO+mNiT8s/PArRVEDjFQoj0pLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkjpRa2ig+FK3EP3qpQ2/buK1hw6fDWLd1r9PBBynjcRnv++bsdDzXGafb3SjEGEbSSqYwgmGyI1S5y70J4WrfLonv8a09/9m+Ajp60dM6Wvpv/seSDrKH7Nx8A7R9fFnoRU+8ZUnP0vKh+XbMZjQYCFWjI6pAAM9pAmaeJ5SLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpGC0pIE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpGC0pIE"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2445826fd9dso10376695ad.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758197497; x=1758802297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GAoC+ZaDxdXo+spV/LmE7DgvWELZkUtLA5pPamornbw=;
        b=dpGC0pIE6D80o2+1xZ03B2s4M5CQMCovQlNBxkkTLeVVTZlUOW6vF8HHrbhYZ7w5q+
         9YMKROhaTqK6d9xosoZGYaZlYW3Saeh2qFMdnYBYpZDLVnl9BgRlivkFAFKlUiAzul+x
         x6fSN3AKGgwsVan2jOE/vIKiwHXqHb6o4pcCRhQZQ1k44kKfgig+XUfeG99vGmsZqMR3
         HYaapBuYbtcwEbnrwcn2+xqxqotKYWzcxb42aIscncFp2KvdICzyEZalPcaxj+KNAIft
         yUFihf8afoynZkBe8rXIAuj+YhNdfFHLuvDmKRMr0MiXyQxeqAgsfts3lDGh+iCS+v2m
         L7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758197497; x=1758802297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAoC+ZaDxdXo+spV/LmE7DgvWELZkUtLA5pPamornbw=;
        b=Atw2GCMgiqswTWvM+ApO4MsJiq0UYw76k9TO0natXQ4bnK4IXMED98lAP0tSCaAcig
         TFrGPwqkyBC5O4yeIvIz1VBZ85yBq9hMzBzCmOrGcZb+Zr3B9esmKJ+SGLIkzGT5iWzc
         wTeLgnJzjvnabqC9q7wOJ9l0K528MpL54DEfTFFXI5g8yvkTVdOp7N9f6c0L7cYfANGN
         ARc8nsXfVuYjmkfOEFmY2NGjZAR3YLuPH4L7o41qnY2sNfK63KJcilOCWhUl9XRhnOyT
         iPrMD99QW1hSRXTIBoNPKo2wcWj7g5d5QoOXLl5X4E4ZwBmJf8yYeNf0IsPzLfjo/7BW
         Nfig==
X-Forwarded-Encrypted: i=1; AJvYcCVfj+Ad41vUCGgviuhSfcZXCoCC9r+znGuqRlB/Ultkcmw0a8jXGfmmKAuXNkTo2sNXeaNAJuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8V8p5Ferl4sbeVNndUHXl9oe3t9zYKh9+UtniMAjPqk//07j6
	tPY/JYNPLVWZ+wrB+PxrqQSpOFzYWQSgshtsXGFmuO4829mEeV2gtLrUKgkDwTYfHBM=
X-Gm-Gg: ASbGncvzSvbNzXm1s+KvnMWZu6FppDs+qRl6VlsTTZVwCMk1vXzNPdx3cf7eFLOaSzO
	fuoLZiWWbckfIkmwrw1zLhtbOXdHC+tjF3yu4/jlekC0H47YpmQOmMVyW8uZpuP2NrzYjLc+ola
	PXFVXGmLm69DZW8vL721xnQBu6cCkl1KcI3noY3i80tRcwl7iEvBjjjs0T8hRixdR9w4RLBpg8A
	dMZ+ZboQPMSftCB6O/VSDeguFwe5Ah71ObPUlFrjwl1XTb3/Dq9ZRy2q9CXDu7WsyPb6Wn7F7qJ
	Twj3r+UBjcYspUB8y1Ps19qzLqZ4jTdVVFbj3bMcLWsLw5LPbE5E/5sTfVerxgDzITmKBSbr0VA
	YYNQY2FkGoRV45sDCmSmar9MJIRJ1MkuATGBqXOk=
X-Google-Smtp-Source: AGHT+IG0U3CDVX4gT2JNVdHXAgEHkLdFsWTYpr4SHEqTj4aBiuSHXKemrWgFeH7m9flFwFyjVfVlIA==
X-Received: by 2002:a17:903:37ce:b0:264:ee2:c40f with SMTP id d9443c01a7336-26813cfb8famr72310705ad.52.1758197497020;
        Thu, 18 Sep 2025 05:11:37 -0700 (PDT)
Received: from lgs.. ([223.80.110.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800529cdsm24686835ad.22.2025.09.18.05.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:11:36 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jeff Garzik <jeff@garzik.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] net: ethernet: broadcom: sb1250-mac: Add checks for kcalloc() in sbdma_initctx()
Date: Thu, 18 Sep 2025 20:10:51 +0800
Message-ID: <20250918121051.3504490-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two kcalloc() allocations (descriptor table and context table) can fail
and are used unconditionally afterwards (ALIGN()/phys conversion and
dereferences), leading to potential NULL pointer dereference.

Check both allocations and bail out early; on the second failure, free
the first allocation to avoid a leak. Do not emit extra OOM logs.

Fixes: 73d739698017 ("sb1250-mac.c: De-typedef, de-volatile, de-etc...")
Fixes: c477f3348abb ("drivers/net/sb1250-mac.c: kmalloc + memset conversion to kcalloc")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/broadcom/sb1250-mac.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
index 30865fe03eeb..e16a49e22488 100644
--- a/drivers/net/ethernet/broadcom/sb1250-mac.c
+++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
@@ -625,6 +625,8 @@ static void sbdma_initctx(struct sbmacdma *d, struct sbmac_softc *s, int chan,
 	d->sbdma_dscrtable_unaligned = kcalloc(d->sbdma_maxdescr + 1,
 					       sizeof(*d->sbdma_dscrtable),
 					       GFP_KERNEL);
+	if (!d->sbdma_dscrtable_unaligned)
+		return;		/* avoid NULL deref in ALIGN/phys conversion */
 
 	/*
 	 * The descriptor table must be aligned to at least 16 bytes or the
@@ -644,7 +646,11 @@ static void sbdma_initctx(struct sbmacdma *d, struct sbmac_softc *s, int chan,
 
 	d->sbdma_ctxtable = kcalloc(d->sbdma_maxdescr,
 				    sizeof(*d->sbdma_ctxtable), GFP_KERNEL);
-
+	if (!d->sbdma_ctxtable) {
+		kfree(d->sbdma_dscrtable_unaligned);
+		d->sbdma_dscrtable_unaligned = NULL;
+		return;
+	}
 #ifdef CONFIG_SBMAC_COALESCE
 	/*
 	 * Setup Rx/Tx DMA coalescing defaults
-- 
2.43.0

