Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA1AEEC0
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115581; cv=none; b=OjuoQAgaP0zXlNmOvu04uRKFUQXe6DL4nh5GC3MoFKwe4/6MnUBuudrrYMxS4v/UjoFeYDysT57KJgIv8SsO+EVkVzsn3gtU6hMy/Px1l6TxaICbhQUc39MsZamtDoHd+U+cR47rdbw1viZQrw3wVgWg5bB9kVNROfAY0UGuSjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115581; c=relaxed/simple;
	bh=EXkfKCc9E5fuCQAQZZmlXL2AKxr+f04NqtE9A2Hapkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hPRTLMznsyL/A4xZphHS0ulgcceKq6XcfqqT/XHpuc+PhgWinQFcylXQiAO8lFWSfUmOX5IvfkDpT601/RDIugYVNaBGnxi4HgKzBm1Gv0FXTFyEWpdGJTVaHuGn9RadyffQSJYE6Gd4inMiWBuspRI8ln5/vNMVR1BDMaLRhTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDQZgkj+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDQZgkj+"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a7d283e017so208524a91.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 05:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791115577; x=1791720377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+CAZYh8v0QDN7ZotKXM0PQZtaFfuu3vpY61Ne2zKy0=;
        b=GDQZgkj+6AQIC6aZYBN8Fkl7y/Se0CnxciQLujOMZd4c5WC6YWA1iMu5gExDfJGn9Q
         NCCuC8zmZVfqzWUdIx80B2PjVlp6HSt7TJG72Hczrj+qcS28iig3+k2r27KSckCHdX9V
         4KKtNdMw3IhRsB42ZG8XGG1FkidMTqWLPLlJ95ULsP9jyiPcmDNKS85Am+mT2XCECR5/
         r0gL42Ud4rttBZ+9GKBlZ7MnxzvDPUTqBui1uoXw3EkR36ONQQmupE+euIMG/j1lrxS0
         q9r2P5e4H5ernNZasHytIJsgkX82QMDb3VXBS1reYJUa1ildUgikG6/qgimf1L/MOiQq
         1Esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791115577; x=1791720377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p+CAZYh8v0QDN7ZotKXM0PQZtaFfuu3vpY61Ne2zKy0=;
        b=hBNw2Uxy1BKllp2AR6INKdPlUA3FfdvjgtgidQiWH8VBLyZsc6zaruBLT+mZIWLzc/
         bsPxLxth0GVKhOMj5+whJcSDvKeSI8GEhserdP9WR7R+GsQpNoiyFYEQa1nkCpkO+G2t
         n1o+arYZUSL4MlyByzAqF3RB4hZpxuPFith8Wlw+bv4Q2XKd30sxrwWVdzY2b/2SXVpu
         aXEwfr1wonguSqy302PS/umZy0PMi7SMu2+SQuLwQOEOFU4nB8hutheESJDm5CrajdFf
         fJlz5khS9FYzcT0bGuHtc31Uog9gkOZu0aOeZeqLM1qnU2M3htMMI01EdXt9Fp51ivKP
         q6lA==
X-Forwarded-Encrypted: i=1; AKwUvBz9oZRjguEth2x1IGFqVsrqf1rdcpVxBXMkS4fiPzK0/UdiyHyc2BVnhSO1bN0C7wgd/1Xotg8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3vFpcakYEUsNz4Vmgbee4CC2DfjArH2h9/BqZcVkVl8J2tV6D
	GHAkC3rSqXQb9vdkdRTpSAfVETJeZ1bjbSWHMMXiSOcM9ipJj14gcgVH
X-Gm-Gg: AYBFou1+d1b83FHABvEHBLP59Cd5eD6goZNHB7VRI+7o94mhO+GdKm65dkX1usaZ5SZ
	TXFZzf0VridyZUy0F0Pf54hL2AsCZvpl2VWXJ8Gm2EcC7iCtdkuRCZmSteH+KXeuHu4RDsI3S+S
	VhVUDQm92F+UySA9KN8alYXmwaUV7NInD0q2Sp4O8/WbB4/EEgzVvG9+IrdAjTo8qKzNQ4nK6+r
	t1oX7XufzV9nIbT01KeiGKbp13BCbM0mERAJt5TOskml62c5J2gfr8JDhqIMInXulql2Y1rjDKB
	uY1frTkK3MgVi5V2NuM4+90WZHavQkua5mI54XBS06HUmFwbIuvB1PYb+bP4uIuad6RKQUE4Ypq
	YhFQVu/CwCOU7KtUdp757mA1q5+iEUNDAEA1Ua8YfZzfk3Ai5Mfn/5Xqg28HU4+o9Kmm9Vg6OiO
	PtVYtYAHf5ev45TzNQW9983Cr+QcKmOnjKs62xBxEBePzIJOGKEfc0otcqZggD8J4blcwZ0Q==
X-Received: by 2002:a17:90a:d60e:b0:3a7:f4d:b23d with SMTP id 98e67ed59e1d1-3a7875265bemr3132986a91.52.1791115576910;
        Sun, 04 Oct 2026 05:06:16 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a79e7c243csm2603661a91.0.2026.10.04.05.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 05:06:16 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	maxime.chevallier@bootlin.com,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	rohan.g.thomas@altera.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v7 2/3] net: stmmac: guard against a zero channel in the aux snapshot handler
Date: Sun,  4 Oct 2026 20:05:25 +0800
Message-Id: <20261004120526.2728564-3-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261004120526.2728564-1-zxyan0222@gmail.com>
References: <20261004120526.2728564-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic timestamp_interrupt() handler derives the EXTTS channel
index with ilog2() applied directly to the PTP_ACR channel mask, with
no check for a zero mask.  ilog2(0) yields -1, which ends up in
event.index as 0xffffffff, and ptp_clock_event() uses that index in
test_bit() against a PTP_MAX_CHANNELS bitmap without range validation,
reading far past the allocation from hard IRQ context.

The zero-mask window is reachable: stmmac_enable() sets
STMMAC_FLAG_EXT_SNAPSHOT_EN before it programs PTP_ACR, so an EXTTS
interrupt arriving in between passes the flag check while the mask is
still clear (snapshots can also linger in the FIFO from a previous
enable, as only PTP_ACR_ATSFC clears them).

Check the mask before applying the ilog2().

Fixes: 8851346912a1 ("net: stmmac: Assign configured channel value to EXTTS event")
Cc: stable@vger.kernel.org
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index b9a985fa772c..2a076e228e9a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -242,7 +242,10 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
 		       GMAC_TIMESTAMP_ATSNS_SHIFT;
 
 	acr_value = readl(priv->ptpaddr + PTP_ACR);
-	channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
+	channel = FIELD_GET(PTP_ACR_MASK, acr_value);
+	if (!channel)
+		return;
+	channel = ilog2(channel);
 
 	for (i = 0; i < num_snapshot; i++) {
 		read_lock_irqsave(&priv->ptp_lock, flags);
-- 
2.34.1

