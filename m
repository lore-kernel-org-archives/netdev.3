Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794290616;
	b=ObO38VmPTDfESekpEZFPtc79keAlRj881UXlwXym1PV5w5pZBx1EXLTwuAYGCeHM4fCi
	 8gD6Vm+OAOTSXiDTF/QN3yx5d/KCpWP6lTRaWnNqexVHUhJGZ4W/qPjdJ4fehHLdOOkpk
	 Fiz+Mpb2Iq9OaC5XhqixDcnASXjoaNBz1WtlbzY79IN1ZTfEIvYkU95PzVyq/4OIDTcDm
	 /KFgFEalz3eTYea4gBR8NPH8d80wmRIcRm2eH7OOyqlkiMg3GV0HmjXy47KdE6ZxSjYKV
	 EciLh/1DdOsB3FhR+ETLed1osVAX//bdKqFRwBh+IAaWy7gyp0RMoDTKWD7lf5sz83w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290616;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5YtuvWKDSb9pFGs1NpK0eERYNZuHxWBhMhLJZ+qgF6c=;
	b=AbrsPKL+oXeWRR3xwHc4sbXugB5355/nd5Z1/lg3p7HvGNIruZDzwHLXrxtc+0x6VODL
	 yTd1Ge0ycP2wxS+vCrCPH+gHtIpW5FesWVdyifdpj7/jmAVeEq2/makYWFRPL3D4H5Y+R
	 XeN4rBQML17xOfiLXpv3Wsw76zG627dMb9l2Na04VScUH5jO05IV78i+m7rVd/ywn20yg
	 HPJ5gvGSi2YSxyxf4fi3ZKA66iXEVPNWlAcQJuVrkmT3VXljtrKtq5mkVS268Fp1yzS18
	 VNGIaffF8UziYiWa2nnKevWC/f5xJcKq2pIrGsP5tiqRkhg1nJcBKwX7C9qXM/Xz2fQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NV+ECQsy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75759606A325;
	Tue, 10 Nov 2026 06:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NV+ECQsy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794290616;
	b=reS/2YyC1TDhT78PNwQgP4/vtNrW+7JLBo07gF/cVyOisl1daIGOs0RfoBOd8kcy+U48
	 Zrv8cBdO2WjDJL8mlHn1eugLcHWJ4yDYeEf1N5fYhEx4K/r+zxwiqEIsgOYDudHr46LGr
	 MZiiVToI9CDkkr4lCQibq8sr3geUJTJfqzoqre2Vl+32cQUu8hJub00qlgXKk+u4CngNl
	 NR9hPALfCc4JBlFSppzmnhR+jFtCCRDC2pj3gRT1mV24WBBQcDGZRFkZ5ZSMk2+cBWbK+
	 +3Tr/4wlpFCA04a8ViY9FR1ZVE/SjWm/8/F56pg2bgTut0RIjEo7MxSt5PDPCQyRF4g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794290616;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5YtuvWKDSb9pFGs1NpK0eERYNZuHxWBhMhLJZ+qgF6c=;
	b=tAPrmvs9+bsFaj/rT6dsZRLfJBQHsJs5+wSaxGZakTEnU1qcytW+q6DydwwWcQ5RYWFw
	 5UlyYX383rNVj5humFrK7LBUFIP6RcYhPGGDzMV6HGTJ5b7l3Fkw0OS391rU3GJtIfB7D
	 LhAPKXMOocU5sVS+RtU3io69V38JQFhjElwUlkchRRK7eiDwpe270bs0Mu6W4K36DPEgz
	 McuHh7wriuUD5pkKeNuwgDkscizTw/q7RvzOp1AWLFYlk4yPMR9M+EKdaxnRcFYIziqvw
	 hc9FX+jwV+HCqQcFE/0DDI6ujeQXXWIhutYc0js8BUtNdT69KRI0BCLpXXUwxM53utg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8AB7F1F008A1;
	Tue, 10 Nov 2026 06:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794290616;
	bh=5YtuvWKDSb9pFGs1NpK0eERYNZuHxWBhMhLJZ+qgF6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NV+ECQsy/IqPXpreuVGwouPsa9+YE581yGlo/oGumPA65jhFlV9jo0rBnb1IlHYj/
	 MErS2dSuR3JtMZa1HTH+/3joSaIiUiWqsYZyjrYo0BaIvXS+8JUzQHhxZcetNZrCZE
	 9FIKG9YplDerVOmmuNFnqfGfG50/QShaUpz7SC6EG9oYdYlw8S1xPSYgYvdruG1Uam
	 /VYDr7SykVnNZUbxmWyI1+Se0aZt4KAmIii/v410q9PR/CG3G6j/8zc4KXM9ZFvcTH
	 wkoXc+OJkwGLt3cy/QZUaDxRwSq6ZyBaCikBkt6xFUnbJ+KAQnn3tIj83T2PL8t8E5
	 gQ/244VkH93tw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1B4C9488D4;
	Tue, 10 Nov 2026 06:03:35 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 06:03:35 +0000
Subject: [PATCH net-next 1/2] net: stmmac: dwmac-sun8i: Fix the RX_TH
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
Message-Id: <20261110-sun8i-emac-jumbo-v1-1-84bf00e9ffa3@gmail.com>
References: <20261110-sun8i-emac-jumbo-v1-0-84bf00e9ffa3@gmail.com>
In-Reply-To: <20261110-sun8i-emac-jumbo-v1-0-84bf00e9ffa3@gmail.com>
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
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794290614; l=1310;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=mcrcgOa3opg1b6qCwzfWbgeFogC4AhlPlSr0iRc035U=;
 b=6QCx5JzkZ326YxqrGgQVsLb08hT7kMMlWAxIs4HcUY6fXDSajV2tGzNT9PK2uh1mhv6d8mX2/
 fqtVlM1UG7vCTm7qx1DC+rjhXgqcQCxAAQrGSj+1CKjIC93ITni48uH
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

The values are only used in RX threshold mode, which dwmac-sun8i never
selects while RX checksum offload is on, so no current configuration is
affected.

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


