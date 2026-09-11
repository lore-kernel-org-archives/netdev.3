Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7524BA1C3
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161697; cv=none; b=oJ41Pd+0uTLHlYEeT+xotg0x4Q66U9lCl7I6cKwoZMAk8MYj0HAkY1xIyemPoItzqZGP/w3AOOYQfoJleWgQSNZQEKXcDEYZzBPd8Gly6WDLDEcIdvfgPtiGTskCagSg854aUcXMi+Nudl3+uq6wg4V+GJ4pkf4gtbX9HzLevlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161697; c=relaxed/simple;
	bh=CjVuknf9p5QVjP83fJ9wEyCm8dX+C+ZG7ZpVXaER/SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqcW8BaTJ3rVJcQ2uhzF0OAd35AW4EUGsuxRUCAgJdYwcMlZc723H5u+3Lp8bIULZxdW/lUJREMMjo2h7k8/XngICcWmq14ZokOx4WfHwYZo/5sXeTZZck/xsdWR4GHL80+kbGumDVVSQXE6Q/8J7U9Zpk9UGHylYRnWEr36yKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nJpDo/Ij; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nJpDo/Ij"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5D0E7C63A10;
	Fri, 11 Sep 2026 21:22:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6BDF3601A3;
	Fri, 11 Sep 2026 21:21:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A39011C7A9DC;
	Fri, 11 Sep 2026 23:21:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789161684; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=XNIT1uyOzSSofYvR/lzX3M0WT4Kg9DVts0sXrRa7wIE=;
	b=nJpDo/Ij//aHoqMb2+TXo+G/sM6hgTk0OWJkGa6OIKynij06LDIOet7Stc3VoD00hhPXcq
	yoF1KpJ3YgXYrVVVhVSfpTXu+QwNF+tLYnqKB8zaS0DPATkkQzrkT9LEtZ1AurBXyJUQRa
	oJxz8REdubsEFcAZ8O0ihMixfOguVnouNaKjM2gcw23zkiRFKhqbt5zDkzY4KLq3Y9CZI0
	N6UhWtSm39Ef9/1Q5To0xzpLcvTgm4qIGnoUKCtj7BQZLlepeBds3pw5av526apJi1n8Y4
	DC4gAZ0p8WCPwia58ey63LnZ76XstJMA41Qby48PBdgEgVFnEW3nKs2cRqkjtw==
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
Subject: [PATCH net v3 5/6] net: stmmac: size the RX buffers from the frame length, not the MTU
Date: Fri, 11 Sep 2026 23:20:25 +0200
Message-ID: <20260911212028.1497613-6-maxime.chevallier@bootlin.com>
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

When picking the buffsize to use based on the MTU, we shouldn't check
only the MTU value, but also :
 - ETH_HLEN for the L2 header,
 - up to 2 VLAN tags,
 - the FCS,
 - the NET_IP_ALIGN

The default bufsize is 1536 bytes, which is enough to contain all the
above so this hasn't surfaced before, but the addition of NET_IP_ALIGN
to the start of buffer address tripped the Jumbo selftest, leading to
this discovery.

With that, we don't need the '>=' checks on the buffer len, we can use
more consistent comparison operators in stmmac_set_bfsize.

Fixes: 286a83721720 ("stmmac: add CHAINED descriptor mode support (V4)")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 62c3441911e7..29b970574a38 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1536,17 +1536,17 @@ static unsigned int stmmac_rx_offset(struct stmmac_priv *priv)
 	return NET_SKB_PAD + NET_IP_ALIGN;
 }
 
-static int stmmac_set_bfsize(int mtu)
+static int stmmac_set_bfsize(int len)
 {
 	int ret;
 
-	if (mtu >= BUF_SIZE_8KiB)
+	if (len > BUF_SIZE_8KiB)
 		ret = BUF_SIZE_16KiB;
-	else if (mtu >= BUF_SIZE_4KiB)
+	else if (len > BUF_SIZE_4KiB)
 		ret = BUF_SIZE_8KiB;
-	else if (mtu >= BUF_SIZE_2KiB)
+	else if (len > BUF_SIZE_2KiB)
 		ret = BUF_SIZE_4KiB;
-	else if (mtu > DEFAULT_BUFSIZE)
+	else if (len > DEFAULT_BUFSIZE)
 		ret = BUF_SIZE_2KiB;
 	else
 		ret = DEFAULT_BUFSIZE;
@@ -4063,7 +4063,7 @@ static struct stmmac_dma_conf *
 stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
 {
 	struct stmmac_dma_conf *dma_conf;
-	int bfsize, ret;
+	int bfsize, len, ret;
 	u8 chan;
 
 	dma_conf = kzalloc_obj(*dma_conf);
@@ -4073,13 +4073,15 @@ stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* Returns 0 or BUF_SIZE_16KiB if mtu > 8KiB and dwmac4 or ring mode */
-	bfsize = stmmac_set_16kib_bfsize(priv, mtu);
+	len = mtu + ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
+
+	/* Returns 0 or BUF_SIZE_16KiB if len > 8KiB and dwmac4 or ring mode */
+	bfsize = stmmac_set_16kib_bfsize(priv, len);
 	if (bfsize < 0)
 		bfsize = 0;
 
 	if (bfsize < BUF_SIZE_16KiB)
-		bfsize = stmmac_set_bfsize(mtu);
+		bfsize = stmmac_set_bfsize(len);
 
 	dma_conf->dma_buf_sz = bfsize;
 	/* Chose the tx/rx size from the already defined one in the
-- 
2.55.0

