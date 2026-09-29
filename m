Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C39C3A7F49
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667444; cv=none; b=sNUJQpEXQwNxUNZUEFCHMqLyVQZP0F8B9UElPlvk2hq7sTus/ByvsYolURQX0W0G1XRuDEPO9fCJ5BOsCTiQuAogAMh3GTX1UdvBIchi+62pBiBFCQf9Tyr4vYk1x0fEHAknOQi2Lqngs1L6xqMD6aqSybigTtP7iRlYbzv1qjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667444; c=relaxed/simple;
	bh=EXkfKCc9E5fuCQAQZZmlXL2AKxr+f04NqtE9A2Hapkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R3TXmCEmtFBA7DBLwC1SoksIeBeibFe/bGeKju45hHnIK+1sM0F30exfOQvgCgc4S6dmLiimGPZha3w36T/+kgCpKo0+6WWv8zhfn0oMxdRjWPbsBQ6zZ/LQ+vFjTqMCQzONVL+26Yj61S0MwpbsIlNqIXb9mvahM5ya6QpP/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BV94Sqpf; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV94Sqpf"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso2505299a91.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790667440; x=1791272240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+CAZYh8v0QDN7ZotKXM0PQZtaFfuu3vpY61Ne2zKy0=;
        b=BV94SqpfoBNPrGYpDRBiT6Zd2i3k/gllq2A/lk2cTRJsYrTQzB/ddH7SlUMsFbmWLI
         jcQ1KyCAdB4dHts7Kai/M4weJa8kCd3UKKKFzVQOJlkbWymB98ZnsFnCCQ6XQh79kHb4
         ufZ3+jb9jhb13PVVihZB5zmGAvXA11biMx00cEk+Lc0l1/IjWh8b/lbx3X+II+7Iypjm
         oTc8VGJjySUGwYadCdt2PHUclJCbZlBBV9l920NsZv98/VajzIm1IKKmuqPLQffmobnw
         fjeIHviM1SZhOLDGvKKByS+0wbdT+sQztxOMFF1CwhtmIELwojzzIZSv6bA/w/mlQZ2F
         f3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790667440; x=1791272240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p+CAZYh8v0QDN7ZotKXM0PQZtaFfuu3vpY61Ne2zKy0=;
        b=e84rszD+TWQM4QyoKLyVWgZTOwvmUW5iyawbjRpz4l/mhrnmd/23znI9f8JlanM9Sm
         magKvCnWLjeWeXTipsi2J/6nnfLtcBUe63Bv+IaeLQVpX3BGuX/d2mLVyOKCA2+FW0I4
         JczMsffX8HP1I01IVi39586qr7KXArG38z1T4YGprgGlvH02iT5TTs5b9EJJh9dH/cpX
         SaVJOAai7pB+UCjOh0pshXOC1twrB4ZiXLsIC8jPM0LxyMNQid1kNNMuKNQodFpAxfIV
         UVJUTaOTmK+MO64uh89LNlr2YEB7DueYGKLh56ciJBQaLMDh1vB+dk+l6+ZB192I/WuZ
         nDUA==
X-Forwarded-Encrypted: i=1; AKwUvBzu8xh/Np7X3TXNqM3f8pm3Tv5jrJhPICRt9wCZwJgL7psOYcME5LzzLLwMNBA+91C3wkwisnY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8BNeZeaPtlpSUhDyYxsbMNx/cm/xFeqX2y4gELJ1obxhsZS8H
	BAjSzjfy3q6Djj1m24VcxemIanhcktYrQf/6cuWfqZf41abXwwSHr5fa
X-Gm-Gg: AYBFou0hU6Cs/Vh5eWsqOWyI6jR71aCwbT4zRu7S6C8P2nT+4/j4VNrRgQjCqDWisUW
	+0K6PzRfqfqmKsBP6SbHEwV7BFvb3KDbcb4LLfNVOO3X4w8zM9RdFffMcpgeQCSstLIrucTl3We
	oiOUM4ILtkVJgibU2eIGif48KEvqlMk1PN+iT79SxCpIEaNdXdL4at3ULQIcAkiY8MMGeRyOQpQ
	bqbJibKEm2l/HVOHcYv3ab6wrxudGetAbzfcdikim75Nz4udMkgOLCWjSleF2pwqndZE63DyxNg
	So1xiHTLSYlIi6pKxiEoUhIT8/N72T2Y3mB+teZn1AeL23jOJYs6Hp+EMBHVJfQtSfDM3Dezzeq
	87u/2PkraxViuEIaP7hvzQ9vjUyZQT6oQdLsWppaCrJZyAjOINXUStiXLmtqHu/QCMvqtxoQvPr
	Q4d54b//KLNQvoHmBTsIHoqp5WDalKgy3DcYisuL9LwQds2rTA3wFpkGRLvctXWoAKbNE5ZQ==
X-Received: by 2002:a17:90b:164c:b0:39e:6d82:dca with SMTP id 98e67ed59e1d1-3a098df465emr13963048a91.30.1790667440494;
        Tue, 29 Sep 2026 00:37:20 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498ecc986sm1328708a91.3.2026.09.29.00.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:37:18 -0700 (PDT)
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
Subject: [PATCH net-next v6 2/3] net: stmmac: guard against a zero channel in the aux snapshot handler
Date: Tue, 29 Sep 2026 15:35:52 +0800
Message-Id: <20260929073553.4136336-3-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929073553.4136336-1-zxyan0222@gmail.com>
References: <20260929073553.4136336-1-zxyan0222@gmail.com>
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

