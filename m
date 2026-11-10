Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314417;
	b=qP2+7rLe+DTwHU1K0AgR4GiK3doRzzthz723pGFQKxyerfrIkQNlNwt43hdv0mtHJqpK
	 8uLLjgYzHTQJo2vyen5mK/p72Abe0kDSsDUAYMiDvHUqGcR8lxCs3XnvBgpkQm1Ag+2Sz
	 sATElsYBQKFQVtG9IoaQqkEkpkToS/hYyIVpESsLE6rd26Hmrn+6LYNrM6y9MBXYPl9aX
	 qoPFvfDKFONYN7P/hlsOtvumn0843HMhkZIil/hjtYvmbXdRh4E3s00XPnz58R+Jku+aB
	 XmEFCxp9zOH4ELD4XZBPiiLdkzcGNA/nEaunyN+TBAaikYRMF28NTZkdBXyhBCS2bWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314417;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=hHa7gwovaGq2qPsePHSwgyJGObUXffBdX43HsZeVkrU=;
	b=FGvNaqOpxiEBz9WivSo5U/5kHOjaaGV5KhkA1gTWBSl7NpG3X24gNzbVcl8C5NqQcQjS
	 tNKhfR1ONMeabCj5FXUVFW5oeNaHnepdkCq2zIrA4CehuFdxs7XkGvxy5X8k61IokUdOW
	 2IEtk3cSbP+YrWqbE4E7DsO2MOOpTR+FFqRB/b31bbK7gY6VZkVRGFEvGyIj5vGNaNcrz
	 /7WjjZptGDjNYttLpmUo4/6XloS0MSyaArJsF1VN+vu2NR8dO4ibXH7xjbkgRVjR1GBsy
	 MIQ5Le5AJGzvBO7vphQxpRAJwDPH+DMtnnYgNl7u02k5Nd2mmkDaWJ59/IPMILFWAQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jwdQWqJr;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54221606A326;
	Tue, 10 Nov 2026 12:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54221606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jwdQWqJr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hH
	a7gwovaGq2qPsePHSwgyJGObUXffBdX43HsZeVkrU=; b=jwdQWqJrJIKtW4LYjd
	3HO+pT0Kwiu5/N8Ruc0jpvsj46StrVcexE74fsq11aeJUxSMYLpkWDnKY/dxbpRE
	JncPQ4FxxvVXURoFsW9NPFNpk+hzAB6xtTlsRJVumtuBe/jrqTDAONsgICBdyyM0
	FFhBQsKaszvDfI4ClZTsToGJs=
Received: from 4CV529F122.company.local (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3X4hjEPNqevk+Eg--.59821S3;
	Tue, 10 Nov 2026 20:39:12 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org (open list:STMMAC ETHERNET DRIVER),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: dinghui@lixiang.com,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com,
	liuxuanjun@lixiang.com
Subject: [PATCH net v6 1/4] net: stmmac: honor allocation flags when initializing RX buffers
Date: Tue, 10 Nov 2026 20:38:52 +0800
Message-Id: <278074f91b9c11ed8a6517e2d400fb199ac2bd71.1794311618.git.dinghui@lixiang.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794311618.git.dinghui@lixiang.com>
References: <cover.1794311618.git.dinghui@lixiang.com>
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
X-CM-TRANSID:PCgvCgD3X4hjEPNqevk+Eg--.59821S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw4Dtw1rZrWxWr17WrWxWFg_yoW8GrWfpa
	9rAa409r1kXr17Jw4DGw4xZFW3Ka4UKFWUuw4xGrW3ZF4xKF9IqryaqFy5Zr1xCr48ZFWS
	qr1jk3s8uF1DAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jQUUUUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC0RG342rzEHFNBwAA3m

From: Ding Hui <dinghui@lixiang.com>

stmmac_init_rx_buffers() accepts allocation flags but stopped using them
when RX buffers were converted to page_pool. As a result, callers passing
GFP_KERNEL still allocate with GFP_ATOMIC | __GFP_NOWARN and cannot use
reclaim to satisfy an allocation.

Use the supplied flags while retaining GFP_DMA32 for hardware without
64-bit DMA addressing. This also allows the resume path to allocate
missing RX pages with GFP_KERNEL.

Fixes: 2af6106ae949 ("net: stmmac: Introducing support for Page Pool")
Signed-off-by: Ding Hui <dinghui@lixiang.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b20e5038eead..f5ae12208e85 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1688,7 +1688,7 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
 {
 	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
 	struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
-	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
+	gfp_t gfp = flags;
 
 	if (priv->dma_cap.host_dma_width <= 32)
 		gfp |= GFP_DMA32;
-- 
2.34.1

