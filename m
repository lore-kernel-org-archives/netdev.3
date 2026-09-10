Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0864AB1C3
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053297; cv=none; b=qirB6OkTvVMtlCTsNcEXl1waje3+XbXkBt3N80LWauMUwLqGyc4+Fk9R1i0KYYGeQ8GTCnTrfZivV+n9KlQx+Fnt1phkWGGDdDVYa7Ur3tgNIxzFVOnjdcaFzpacMIAGDbsnjsgZ6ZJ3lJMTAtI2jwWWEd7yfJ3Eh3/OakckeCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053297; c=relaxed/simple;
	bh=0lVp4AjJ0cED1bbit+uYOsbChUQdrS+rWhX4sd/7pk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQYCvSsGvUcdexpTAa9oY1lMbpoki2MwjGxmmSLAejl7Xhiye+KqD62B1pQ0iNd9BG7zebBzNL2Ds+I4IF4f3ywasRLBAq/edyQhkD7GgyjpsRv9O/PAcNFINy/+0iIXx8EG9FcXWleOJVkdg1WltSu5uT5a96gnpJ8EMhfdp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ejt7K3Of; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ejt7K3Of"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2290D1A0115;
	Thu, 10 Sep 2026 15:14:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E9C425FA2F;
	Thu, 10 Sep 2026 15:14:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD77D11C7926E;
	Thu, 10 Sep 2026 17:14:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789053287; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=yAsi3cGu3TI2BDEMG0McW5k+U5cb9+s/V5vDEJqx/gQ=;
	b=Ejt7K3OfGInw+hfhX6r+/ekZZwYvgCR7ywEG9UdyAexrsSGT3SFgn0qpvOrlv1cpOE6Xx5
	PXA9EOZCiVipYDw6OUmhBZSbf9KfuahmG0Qrw2I6ukfaZ4IEs/sI6rE8AM7/ddlQSoCx7b
	1Bua3KlVnCTwNF/DzAJo0QMGUML4zaSkBtBhtu2Ww0FfYw98GLFGuMcgtsI0FC5GysxLTo
	Vq5q/oIrh4VR95gU+jgw7IGtUPLL5yaxJ7eCsBwhFl4EodqdT54NQ8zixsqmX6m2bq1XFC
	uJc/+vtjhgbjk2Y6QsqQUKZMP/qqJ/ciMiSlC91Q1L7XgKSpluH8yo64pmJtEQ==
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
Subject: [PATCH net v2 6/6] net: stmmac: selftests: Account for alignment shift on dwmac1000 for Jumbo test
Date: Thu, 10 Sep 2026 17:14:03 +0200
Message-ID: <20260910151404.976753-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910151404.976753-1-maxime.chevallier@bootlin.com>
References: <20260910151404.976753-1-maxime.chevallier@bootlin.com>
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
index ec56ee0031ab..fc8d69260f43 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -1776,6 +1776,9 @@ static int __stmmac_test_jumbo(struct stmmac_priv *priv, u16 queue)
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

