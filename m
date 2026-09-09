Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890C938E8D0
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940101; cv=none; b=hxoy5EI/UjihwwhcIuEbB/GZqG2YBt3PX+eSVqhDR/xaHXzptimquG7S7FysWRlmZ2oMS+ulZQQ8zKdtNrubWpimj1grdCIXvR3sy/DbzhdcPxUi0I6gD10OJwDiPr0xncIhgeSErcW/7PQ+HI/+/80dlHPmkk6/gdsffJdKNuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940101; c=relaxed/simple;
	bh=TrkuluP5P0hsHSCuiA3vpvv1iEMs1+ocpB+H02WT470=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7wqUbTvLo9fSyFqoe/yde9OO1kJLSuZC2K2QRva9IsP+VzKGdKe+7QXN9lKuD6PuBnxNyYRGZfCb0kenk/TkMyNMcJfxegwyrmyuwRV3mCBe9DgULgJwEm2I5ci8CztKg08Ld3dxW7TcZy55stC2FPntgdZC6zCp6rUYHgSlLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xpEPJXvs; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xpEPJXvs"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E9CB64E415AD;
	Wed,  9 Sep 2026 07:48:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BBBB560448;
	Wed,  9 Sep 2026 07:48:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16FA611C7AF65;
	Wed,  9 Sep 2026 09:48:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788940096; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=LNfPfVxE7TyoGk4owPMHBVxj0S8J8FrPyxLkQ78bxNY=;
	b=xpEPJXvsrZtm58HaHjF/2UmevoVvxuSrtclLVRnua6XHwvqdSuZYhPiTU2423gaScnaUYH
	fUBMgyz5d+kvFTs7OfHPQlLXHe4Pe/4fjJNcWUpS9+tg8KiPpAq+U0bmt6aGa876emyR10
	BPHhFSs57IsYxbKT7A70Rx+LLqruZVlPHgDqmfNeCAvHmosySxcXh0Xr51OYH9WZTWeqQz
	qPh9VDO7iZHCHJWYxaSjVh6cbiCw4dYkK5DN7z6ZNCQJgzgUL42NTufgjwSnj7f6OGCK57
	RX5yx6sO4xlVzBdtBkLgLpnZJVTB30+qVVf1M+gn1VOEkiF0daF7MktQt0WrSw==
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
	Jose.Abreu@synopsys.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	PKneuper@dspace.de,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net 6/6] net: stmmac: selftests: Account for alignment shift on dwmac1000 for Jumbo test
Date: Wed,  9 Sep 2026 09:47:39 +0200
Message-ID: <20260909074740.1247762-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909074740.1247762-1-maxime.chevallier@bootlin.com>
References: <20260909074740.1247762-1-maxime.chevallier@bootlin.com>
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
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 2fc0badb65a7..ffc58c210d0d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -1768,6 +1768,9 @@ static int __stmmac_test_jumbo(struct stmmac_priv *priv, u16 queue)
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

