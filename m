Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231938;
	b=fTt+F85Qj2u68F6phRyLrY5PYUstPL+tuzvxXIYjICMn9hhK/eoNg8d1ZhyjvT1k/iIZ
	 11PgbNvaCO++mFzISHd7k2r7kOkqO1iJNTCOYbth6Uqo7k1JyueMOqX35p9sNa95RVhOG
	 v1ANwuC5rKWE7N+JSGuqXW704vSCupWhjW07oqado0+dqfZ01Spa+ixNNkdVQdsX5fDbL
	 qkvNTb4Jb7UCAN7M19Q9suatCfirbNGtOXGjUPpfpXROGf2yDNh8jRTeegrfFMLlTwksH
	 JbAFMJ4+tfxe/nq2eoSTr9KFLJD34oikzh6KT3T4kQ3vEKBA24h4IVQfnMr3nQ1lw5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wXHNHwyHqZyMWvC89h3xRMVsL0F7PlcQnNFtH9sdpDM=;
	b=HYIMhahrpu+8QdW+BkiJEd9O3GmmVsG8d0+b8VI6ZYBkslfHTOXGFDJXbsmDgxJYLcS3
	 GopGeglJWyJa3E9kUi+FUX7eKml0Hv+2KWMYwh1KQhyEZhr0Qp+mrz/d0cpV6++3zkNTC
	 nhBA8LY7zreN23yZW49r2kdKvUCvw4sog5gp9PvGFa4vQxY7a/M3eVzoa7qUJPFygZvbG
	 Zhjz8htEZsWAoYVqsd3rXnvEFH1sBTMuow93M+0JAiTbHj45Ijp4gNmWkztVVYU85tpua
	 +oCsVO5V/9KGFEXpQAz9L7PC2oClfISpyywZj6vMjks7J7JE3SFkQIDdHDFjZThTSXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ML8NWqVv;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37257606A330
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37257606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ML8NWqVv
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e96502e447so7258555ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 05:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794231936; x=1794836736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wXHNHwyHqZyMWvC89h3xRMVsL0F7PlcQnNFtH9sdpDM=;
        b=ML8NWqVvehIScf3YeJPDyqwR7Sq+DsRldBMwGKpOSjUFrkHlf0iAJuLc3ijanriryM
         EOFUr3tJvLiezYub615EhDjHVxG/uF0T0Ql42/VBcjraMQ44p0tXJAELx8HYcIw8SSIH
         bbq7bc5+d2/nxF3dC6owyoyZlzm52IdkwKJDrNW5Bnbm9LarPk5i+JjsybWa0nJho6aI
         wrl23jRwnx1I4xlcwMdra83YpSG6Ync5H0kZMykIXkbF+6RBmptts/d3CCBtIi897z1B
         VGgnM6JZ5JXqg9eT4PQliXY08YdM66zeO2SSKvBM4vNUEVmj7DA/GW7PtcYH9397yHyP
         houQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231936; x=1794836736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wXHNHwyHqZyMWvC89h3xRMVsL0F7PlcQnNFtH9sdpDM=;
        b=uNrbY5Fa80/emiEM/5mrbiLNRuyRWfqHuNiuv6mHPLA1+R0r5XsxIlfIEC7WcbkJwD
         RrpwTIKaJinGCVMWlbpGoA6CFJUGou4HsuY+djDrOu6afx/O2KK1CXMp8LCw5QWgCDEQ
         AEruyPqLMk0JegXr71Pr6pVR7ef3VGCOFmt3rgCKKmJDgNPkrxT9ExExdieQs3q2OdEN
         dliaBlKwg1cDcP23MEWZwyGcJnslEx7OHL6dEaIKXQpvPvK8hrDrtDBDe0XZbaTkj0Mf
         /KmBnwzlemTw4Kqr/97TLtclK7boLMVXl9m5ivSpaAHrpesc79Q/S30ZBbqFb/yHua9j
         v01A==
X-Forwarded-Encrypted: i=1; AL+hErEPFTeffsPbiJCWjusqwuwn3tkFMhSMgiLNJqoaC1bpSxpawJ8dA6fRZWuGGBiJ8K8Y2UIoKE0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TWiKIjOwdO+0VBcK15ihKrlC9gEk9L6YnIjNOhO46DAlFW1V5
	VSd4E/YXKtlOZilcpc+jUy8lk0EM88ugrtH7nwTJ3aJk+F5NPdn/f/yp
X-Gm-Gg: AYBFou0k0iA4GJraRBphFeFxdc3IxZJQ2AIGShVpKCLJgAI0LLIvdRaSpuaS8UthB9y
	a23pPVukBSQSeQ2lEy4/3wqkPr8QxDg2B751L1WiynfAhNKd2BfFMred1YPBtqwb9wrf0gQT+mN
	0ycCAaZ9vj4UbTEa+2u6zoWB8sMaaUlbUSE85k8CNd/T+Otfv/Ry9tkcPD/7PcQjXC2VjAuBkhM
	elAAxk3B0QyPNgySGs364ipYUaqAR7Pv6cAbIlRN3fk39zSrNvxOTQN7Da6C8BTylvGx5xqeZ+I
	ApYZyyiWstgH9lPhZqE7ERVSRSKnqhKRm1HSoUrmlfVcwIe5YWxEm/Z52ege/F1cLXs8cGYv0+z
	JLIP9bpW08nQdrscyYDOczSA2zZmF9qb+lv5EayjABcD64pI9eFbckhhq2FtnSDXQ+BwVrWmlZz
	qKeB9lbmwG6KwUo6y8CPLSfg5/zUK9UHiB7OVlbk459ZGCH40mpOWtZNIQmplpD49kK0+nZRnba
	m0JhjlXGlbdp2NGuVKdFpFXaeoIDphpc2aWSs8TPUpo02LoVqUrl31T21K80ZtfcjXGlTuL5yIi
	nnwJNZqxT3sR9I+qi3Y57NQAmCWh
X-Received: by 2002:a17:902:e949:b0:2dd:c100:a5df with SMTP id d9443c01a7336-2ed837a98a2mr40597565ad.51.1794231935615;
        Mon, 09 Nov 2026 05:45:35 -0800 (PST)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81727f9bsm11014285ad.57.2026.11.09.05.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:45:35 -0800 (PST)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	rohan.g.thomas@altera.com,
	rmk+kernel@armlinux.org.uk,
	o.rempel@pengutronix.de,
	wojciech.drewek@intel.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v10 2/3] net: stmmac: guard against a zero channel in the aux snapshot handler
Date: Mon,  9 Nov 2026 21:45:05 +0800
Message-Id: <20261109134506.2794160-3-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109134506.2794160-1-zxyan0222@gmail.com>
References: <20261109134506.2794160-1-zxyan0222@gmail.com>
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
index 870c740b4a50..fd1142344950 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -245,7 +245,10 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
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

