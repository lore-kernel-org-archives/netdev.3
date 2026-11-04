Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805570;
	b=JoO/LTbyok3hieAarskxOiNTyEM/ECJ/Fcdrr411zoqB8ZW6dL19CQmizKPj41pXjIWH
	 YfkA2B7YxZ0hcAtQ4KsCQLc+BDg439hxsYHANKf1EuSvnnCtQKgzqN8suEAiGcMLh/vDN
	 r3B9TgoZgF0FHD27XYjxjkPsMFM0IhVmI9TloZtJvIXdOIxlQsZ343SIVR8OX8QZ77XnD
	 /pE4Q4EJnAPp4NmDU8InwMFnZwIl8+3vDPRyWORUA8mC1Ws59NdiXnfEtUq/JSaxzoVCq
	 +QajeUSgeH7mc+zvkFdbx4DVUx+L/O7ZKAJ14lCWggP1B1g+kulXhJ2oGsoWJZO7sWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805570;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1kasbafd3T9Fhrw7R0Nr/dFHUF4ChKeJYhTGf2AiF+Y=;
	b=AtJuZkFecG9kWG8+ZOmF6UfbtWtrHu4Y8KhYbR1KtWt+Q96Pn49L/Ke8Jr5BM+RwdTTI
	 ZbbJkH3vkCb7SexWF+Y6j3k6Ws40TVx2AvvVFVEyFpE0NHP8kl0uM+oy9LmsfY2+vvgbR
	 OHL8q3fkCbnmAeF7BpgGcGYazE2mtKfqcepesGD6sBaDIKRfnib/h33Vk2EjwBLcO4soL
	 TRBums5/w4LnJYSiDxj8KgJYnX4ImwEnG6XZa1HhUpo1SYRbP23ABxmpOKQAuUaZugsTV
	 e/dk/THl4O6k49U++pyYK+8HYBEwNSnzubDIcngHABT7RnEOI8bBSMvC7C83xrClOiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C74606EE97
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91C74606EE97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490d59c3edaso163396f8f.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 07:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793805568; x=1794410368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1kasbafd3T9Fhrw7R0Nr/dFHUF4ChKeJYhTGf2AiF+Y=;
        b=MVSPEx8C59McAvxTXGyQWBOJZ2k6Fnsy6GU8PaHmto1sQ/LsyUhpFa5hBzdD0fxCqR
         QnD/iP/6UfYx6HP4UQ3iRbYv0PwY2xygDDFhWiLWWV/mNyoZrCP0v7DK252jKws2jzvq
         UjG7rgm8Utk2qAbJqzHf5lXzlO25Cks5iXY4I8r/hGW15iMNvzZTHMnN4nJcb8FJ3yId
         HVn56h7wyg+wRrBzleg+MGr1eaKU5qExT9DhMNZx4YcLuyvrSNrlY0DJ7sYYulmAy3j5
         CRb0/XExyBacATnvHvWh4oJHXZY1rgV5RDeAIiPuEgc8xcA/3ivY5t+QMihAKYO+Jr66
         8NdQ==
X-Gm-Message-State: APuU4Z8250IWWp6LkD3Hxx5Nv2fEhPldZfpqbAUVKsbFopBNp5rYefz+
	617XK7xOFTCusJZimlEq6ZnJliUkkLzWTVsZhwKH5l2K97r1BlJF32yR2ClsSe6eEP32d8RFvis
	DC7VpbWSiJcGa
X-Gm-Gg: AYBFou3f5gl3MdJ5bgKF49O/WTbIpVBsnWzgqAmvB6H80lBx9Zq2PK4whnlsYu+pYQ5
	wmre4tGaHuIzFDp1TVZx0XuAV2b+IU9+382kYMB8ONWmWzyDwBmrrAxWB4PuBV9SfybvmhL+P3a
	KZvvOIGfFsy1E2h4WRRjcmtXWHXXGg7OEIGv2y1BPt02ZEVJg3MAH9yrjDAEjunht5dsg/WFtP0
	X5L+Y3/ZiupxxmyYVx+AuzuO0Y+y7VY/PvIHjgP4ZuVP5BgKmrUPDmI8fgyz67ae9sKlDTwL33l
	uM8UXqaS9NIxNzJMikslOYKdNbT24azYQhm2K6XVecNQ+VsyXSYJWseUsFlRekJq3y01YWeBMnv
	RivMu8lwvQGF4O21gLlf6lPzYGBSjA5Jy1+IoHUWP0qVn1nt2fUrbExd0ryOGjrwdVVK36p+RR9
	N56/vZfuf3yLGmz0e1SsbnrQTorfbK87hUEC5YXmK4LCE9TXOWRvCtpEtbaecDX/spa9s4lOJPi
	8kNiIFFIIciYXIdqzs+gIHaL7NvFbTIjPWTvtFcwn1e9kS5EufNa9tTv8DIWCnPyAl5AO3SvcO4
	f5CbZhQihDCoXGwiqyJud/+AQw==
X-Received: by 2002:adf:e18c:0:b0:48e:eb:56c5 with SMTP id ffacd0b85a97d-48e6e2c1d83mr40340920f8f.8.1793805567922;
        Wed, 04 Nov 2026 07:19:27 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:4366:70cb:bf82:f8ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8e29sm4639812f8f.19.2026.11.04.07.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:19:26 -0800 (PST)
From: Christian Schmidbauer <opensource@grische.xyz>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Christian Schmidbauer <opensource@grische.xyz>,
	stable@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v2 1/3] net: stmmac: honour Rx checksum errors in the AF_XDP zero-copy path
Date: Wed,  4 Nov 2026 16:19:11 +0100
Message-ID: <20261104151914.2651241-2-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104151914.2651241-1-opensource@grische.xyz>
References: <20261104151914.2651241-1-opensource@grische.xyz>
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

Commit ee0aace5f844 ("net: stmmac: Correctly handle Rx checksum offload
errors") taught stmmac_rx() to honour the csum_none status, but
stmmac_dispatch_skb_zc() still ignores it and sets CHECKSUM_UNNECESSARY
for every IP frame whenever the checksum offload engine (CoE) is
enabled.

Since commit fe4042797651 ("net: stmmac: dwmac4: stop hardware from
dropping checksum-error packets") dwmac4 delivers such frames instead of
dropping them, so this path receives them.

Mark the skb CHECKSUM_NONE when csum_none is set, as stmmac_rx() does.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Cc: <stable@vger.kernel.org>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Schmidbauer <opensource@grische.xyz>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7ffed295eb14..3e5803db19b4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5547,7 +5547,7 @@ static struct sk_buff *stmmac_construct_skb_zc(struct stmmac_channel *ch,
 
 static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 				   struct dma_desc *p, struct dma_desc *np,
-				   struct xdp_buff *xdp)
+				   struct xdp_buff *xdp, int status)
 {
 	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
@@ -5575,7 +5575,8 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
-	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
+	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
+	    (status & csum_none))
 		skb_checksum_none_assert(skb);
 	else
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -5789,7 +5790,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 
 		switch (res) {
 		case STMMAC_XDP_PASS:
-			stmmac_dispatch_skb_zc(priv, queue, p, np, buf->xdp);
+			stmmac_dispatch_skb_zc(priv, queue, p, np, buf->xdp,
+					       status);
 			xsk_buff_free(buf->xdp);
 			break;
 		case STMMAC_XDP_CONSUMED:
-- 
2.54.0

