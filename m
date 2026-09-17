Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE54A92EC;
	Thu, 17 Sep 2026 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682079; cv=none; b=P/TbM5VOG1axy+h3nuUNrXQiqf86o5JURSYAp5dHOIZTgX4rnxNjLKeKNAQCM5qytCBrAk/X8Mki+ZYEOdwXgcy7THuSJdTZg3UB18I6vP1twvcYZpP3+V7s3MPNKEZ362qGW1ShJEDUBjTQjLwpR7JYcXNfNakUJh50iUUuJ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682079; c=relaxed/simple;
	bh=8J1+LdHkXr+CXGkVzPtjWIRfXQKURvWN0pO35srGIFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOEAmKRxJDipMZytSneuL7lbJP7tdVDUg3d7CTRG7VWnbteupOfoyFB0A+B43GwANYqGKf1zvoNNmFAtHvAfHNehMl1q71E3vQxmH7slNz54s1wqVOOpYOrmkwbeGT4yhTkXTbG7vReVQ4OjTaQ5/om0HprXKn/YukpR/QifNwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XjFmlySW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XjFmlySW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D7FD91A094C;
	Thu, 17 Sep 2026 21:54:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AB4345FF03;
	Thu, 17 Sep 2026 21:54:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B136311C7B08A;
	Thu, 17 Sep 2026 23:54:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789682073; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=cZzyzrfpRknId9EVwZC5AhWVhuoRzTCf4ta8yZE40JI=;
	b=XjFmlySWpOe0fLB5f4Pv9/SrlLbnqTp6Wr9Y1ciUVS9G01rwLJX2XPpExO4QWah++PV4CN
	ijCn4QvURzx3wIFgxpLL9YCImvo5zBvPWPjJJ92dsYUzuKp9guQQ75cBzGTeLKq1GSZ8RD
	s/VleuA+lUSc8fwSYyMz9qSwaPQvmPsTJdQuNx2aiRswo5EXJuDKyy9zIqFurswT2uYEu/
	bIAGSkNmbP2sRghDkNDrn5Qhi80BvM7iffLl4KYJ8bMUf6CH3dHNUn5inqCNDOycSnk+y0
	aT10lCw11il5nbsSLd/6nREF+8b+aUCiL3t1KrxOjLBmOFi/A11B/NIsPFv4NQ==
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
Subject: [PATCH net v4 7/7] net: stmmac: selftests: Account for alignment shift on dwmac1000 for Jumbo test
Date: Thu, 17 Sep 2026 23:53:38 +0200
Message-ID: <20260917215339.2022523-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
References: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
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
index 43b8411c5112..c25dc9f89270 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -1789,6 +1789,9 @@ static int __stmmac_test_jumbo(struct stmmac_priv *priv, u16 queue)
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

