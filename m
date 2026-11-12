Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472909;
	b=PrXZd50Dtd7pyMpeZV9GPSNadZanVNv9/0ahcX3f2y3v+jb2f8y7FlZYYAiuT0HYQOhC
	 fTeRSKyZ5cc0jBeT9mtEQoShDAK72h8rhRz3FjqVXv55uRNmUAssITTqjAvZwETTEhlyo
	 OE4u4UQ+vBbiMBy8wXc7sPWcaKz0AXtXUatdUtddkRgvCHaVZOaZW+8CzD8Il+EMEhxUy
	 MgUJ/zU0dKe0tCdzWEGcmvdUHUHs6OTSSmfWPeMU669jKe/oVch7NJssbm+w16qDHTiZe
	 U0CeAmfiyiupDFXaQfMrXzKrlzLeRmywt7FFKPYgC9qFwh51Dl/4PyibiMKsIGLGjaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472909;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wniR0PNwavTac3Vf1JqJ3ldcwoXmEwIh94D0StzA16s=;
	b=hVFTnAIB9mKSlvYjA+wBql9Ydc7LxQc6XMaoSdoK6RnR0dgA87FGt8wrw0d2tpC0BFXs
	 AGFBpTKqdbly3cXtcOKN0jyIvJ5ljEz1pgt2SaY5MWY/2hZRD/O5RvjTTJ2DCCFZE3EmT
	 yMA9KEqjaRS+Jy/GNKBDNlZt/qhKaz53qb/EFoutnMFu+20Fd1KsSOiPNVVmEO/fG9iJ6
	 cd68reOYF2vxhigQLf/0BzsrUyylsDkC1qEXudDd48YKz1lVrWLeN6KDnnFhmNtbhR7dC
	 sAAh7lCotxyJHjBB3XvdtzdriguSUlQ5DaDHWYREudlvLSWP5c2GTblG+MqiPXSk88A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHPwlUvl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B0D606C837;
	Thu, 12 Nov 2026 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHPwlUvl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794472908;
	b=3RUzXUoVC2tTVBo7pOENFTAmmFO0fkqAsnK+jXhSo1NaNWzmoVoSS2P/ehVdukOcOUHz
	 5caNVuuspGXYQSHtKfFbKZWcEbOqWoLKhhuJ6t1dh5WEtf4VhjwFamYKtOEnyOUqeVMqt
	 PNfp0808X2vQFZaQBCm96Z3OEt/iS9hdive7SP3QN66z0Z3EhQsBgDViNP/C9pKI224MT
	 qVk82IUbmu/XAStPwH2e9dk1/PTC5om6oSy5TK4HDa0+PmoUvtEt53nYQ9tpKjvzXMH4F
	 uKwcvS9KxSjVP7By4KhJxUExvLjowpEL9VO2N0hlWqbEL/qt3O2oNsjk7pc1pdjdQOA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472908;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wniR0PNwavTac3Vf1JqJ3ldcwoXmEwIh94D0StzA16s=;
	b=aIevw5BUBpFxTZV2AFlqLslnojaR5ppLY3+l6Tq/TbPZ2KWWERCLdDnjn5HzvsHgEiUO
	 5jvi11999/JBkQSq7Mt29VxNkN9YxPoziMf2uIT33xs8LENzRa6M4swaB7yD6p3lIgQNl
	 tGrGDh3ME0C5DR0RLp5Hoowr11FF9OiLEax/6ErAfpFL4J3KsY7mbsqHtHIKm0hJr2r4z
	 JMTygp84UFdquN1I6ehVCaul3SVaxuukV5Me6JoHLc5ej8cYsoY5+KJZwXjj8gZN4N8V7
	 jsaWA7rs6NYAQYkiwniFow35V8NBT00NJLtdQQVvIlkyqbGod5WDY3NWomgSKCKtVcQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B1AAA1F00A09;
	Thu, 12 Nov 2026 08:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472908;
	bh=wniR0PNwavTac3Vf1JqJ3ldcwoXmEwIh94D0StzA16s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mHPwlUvlhKrYelGAvGkAghDW/0usmERGOrwNJ5wYOtpAlaK1B0o79DSnfd9z+bLmi
	 vV60YfkMbI+wzPzYL29VK9/ei3NueWU6qly1jQxNKwcSlGd4BS/bi8IAlHeE0pbmE7
	 BIBlp8D1hjyjkUlWsnK0rvNsX/0snCMZ6ZH+lNWkoZXzsvECEllQq04vknZwzX40qI
	 TWgVE4HVZNj2P6gCWZP2UP47zhVKoyDGRDTFukzX9CqDtVPJwOgQzTjueUxZL7ufZb
	 sbE9P3/grAuiXQJgV5yx8rJyOl135xXxCeY797wvL4eGRRHYG3ppNW2Ke3E0CUlEjY
	 0xUJetCV+1f/w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 29C35493D1;
	Thu, 12 Nov 2026 08:41:47 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:41:47 +0000
Subject: [PATCH net-next v2 1/2] net: stmmac: dwmac-sun8i: Fix the RX_TH
 threshold encoding
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-sun8i-emac-jumbo-v2-1-aca0cf23cf17@gmail.com>
References: <20261112-sun8i-emac-jumbo-v2-0-aca0cf23cf17@gmail.com>
In-Reply-To: <20261112-sun8i-emac-jumbo-v2-0-aca0cf23cf17@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
 linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472906; l=1409;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=kKoyz2jSo9MVW4lEE52oWjQ6i8jVq1b7o2hmZSQuCoE=;
 b=g8/W7nlPeZfYmpu56asT03d91iiJSKK5MO6rRapGGZ4M0mZcYBIwI++ufmrkm7msjELJkc4ZP
 xOnoSwueTxHDS9gfJKD91a9yncVGseAqgU+tyhpEWbNQMSzzSsbFplb
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The EMAC RX_CTL1 RX_TH field (bits 5:4) encodes 00 = 64 bytes and
01 = 32 bytes (H616 user manual v1.0, 6.5.10; 10 = 96 and 11 = 128 bytes
as in the driver). The driver has the first two swapped.

The values are only used in RX threshold mode, which stmmac selects only
when the snps,force_thresh_dma_mode property is set. No Allwinner device
tree sets it, so no in-tree board is affected.

Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 47954537b29e..0c82662fbe6e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -198,8 +198,9 @@ static const struct emac_variant emac_variant_h616_emac1 = {
 /* Used in RX_CTL1*/
 #define EMAC_RX_MD              BIT(1)
 #define EMAC_RX_TH_MASK		GENMASK(5, 4)
-#define EMAC_RX_TH_32		0
-#define EMAC_RX_TH_64		(0x1 << 4)
+/* RX_CTL1 RX_TH encoding (H616 UM 6.5.10): 00 = 64, 01 = 32 bytes */
+#define EMAC_RX_TH_32		(0x1 << 4)
+#define EMAC_RX_TH_64		0
 #define EMAC_RX_TH_96		(0x2 << 4)
 #define EMAC_RX_TH_128		(0x3 << 4)
 #define EMAC_RX_DMA_EN  BIT(30)

-- 
2.55.0


