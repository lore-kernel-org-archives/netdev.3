Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68874BA1DA
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161700; cv=none; b=aX1giI6+6C8Qf++FjuB0X8+ijVMyNjbnkBFsp5U8J8tl6phS5t1gTER8TEuI4lpCypzzOSrcabPCyGPkzwZQD9F0wlJS6VHQTfxuoXBJ6HsVbiLhzOKnbsNnrHmA1lfFzK10ZjCFMu7YRRl5M7H35G3pIEp5v1VB6yRpHZ5lirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161700; c=relaxed/simple;
	bh=w3vUhgx3u1w5w5lsNBe8uid6akfNeA658Av9oc09LCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtTF89CEObBhZ2ZBmvUm1azoKTzcYl1r0T+XNYA2hCx577iJvdJlsrjHjqP4hwll6tMSRUpIeHHVDWlxLudsZnKORPOvFRmXh6gaQSDM0gX2stJ5S3LBtOFfq5IArQ8nu09W3VrDBL7ZzKolnd8pZnBW+ZpsC9QHOlN9yNW/JZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e0oZoW/N; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e0oZoW/N"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 75CD64E40240;
	Fri, 11 Sep 2026 21:21:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4A7D7601A3;
	Fri, 11 Sep 2026 21:21:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 803A111C7AF95;
	Fri, 11 Sep 2026 23:21:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789161691; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=lVlFXXS0Y6100599x+SkiEbiGjCXQZYo+KZ+IT1mUds=;
	b=e0oZoW/NeajrzMZfAtHlmyRmvl8y+c82WNxSszyjf/Z9R8zzTU8zotCd+uuFOEsalNEnqT
	mgwFUFOgttZlV3H/Je6oYnrW8/LtkviIawv2b5BXDRb4MV+TkpbRC8QeHH61eH/F6n/Ahy
	H5VTdsHGHkI5UMod2Bi0gPrNh4aJybdYJ8WMVEzgYWwJ/ZzbYvBJCWNYAK7QHv74BhEACK
	HeXA9H4L82Zm9+JfZ1HNxlKLwfH6/rB5GMhlKCDSqnkFSsv6fgcuqKnkmOkRFx07iz6pWc
	9XvMDvDRjcskGPdZShfcpEFXfiCXbXH5QYEvPDi/PVQZcOx14AkEc3uLSp8aSw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Minda Chen <minda.chen@starfivetech.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Jose.Abreu@synopsys.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	PKneuper@dspace.de,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net v3 6/6] net: stmmac: selftests: Account for alignment shift on dwmac1000 for Jumbo test
Date: Fri, 11 Sep 2026 23:20:26 +0200
Message-ID: <20260911212028.1497613-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911212028.1497613-1-maxime.chevallier@bootlin.com>
References: <20260911212028.1497613-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On dwmac1000, we currently only support single-descriptor frames. The
Jumbo test started failing when NET_IP_ALIGN was added to align the IP
header, as this tests tries to send the biggest possible frame.

On dwmac1000 the DMA transfer is aligned on 4-bytes, so adding a 2-byte
shift at the start-of-buffer address means it takes a whole extra 4-byte
DMA burst to receive the Jumbo packet, causing it to spill over the next
descriptor.

This doesn't seem to happen on dwmac4 and xgmac that appear to correctly
handle unaligned xfers (only tested on dwmac4)

Let's account for that in the Jumbo test, reduce the size of our big
packet by the align size.

Fixes: 23680bf5f8c6 ("net: stmmac: restore NET_IP_ALIGN in the RX DMA offset")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 315c3cf82230..cd7dc99095a0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -1781,6 +1781,9 @@ static int __stmmac_test_jumbo(struct stmmac_priv *priv, u16 queue)
 	struct stmmac_packet_attrs attr = { };
 	int size = priv->dma_conf.dma_buf_sz;
 
+	if (!dwmac_is_xmac(priv->plat->core_type))
+		size -= NET_IP_ALIGN;
+
 	attr.dst = priv->dev->dev_addr;
 	attr.max_size = size - ETH_FCS_LEN;
 	attr.queue_mapping = queue;
-- 
2.55.0

