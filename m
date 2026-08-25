Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4BC22FDE6;
	Tue, 25 Aug 2026 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787692688; cv=none; b=h2dfN2GmfExeFxWX8HPQZALWrQkcsu6m/MPT7nxqFmWAx0Op8diC/4MG2R2mrUemXhZUi4C881exKpudM9bozUVl9yO/aw7IjWDj4/5LEGtbocHFqDGh4qDdkPAT9hKLZhTa7vx2qn6kS4PLc8d0hUo+a5w5mUp2VUwsdbQQ+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787692688; c=relaxed/simple;
	bh=62UeTtH3azXNyttGN1ho5LDFsCIaK1FADd7/0qkVzW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b75zptD6CD7XxiVSQnuKhmUtsA7JEcuCFhaDmY6woB7uJYHDW8Nj0afaGHjxLpY9EMUTukct+fAu0Up6L20T1Dw+8ZSfrBIf2h2m+4hQm+UCe/o/w953w7UySEPI/rK7o7jVXkM7Q19Di1K8PvkC0FTOIQOiN4IqOdA9fZSnfJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=InTOlJtr; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="InTOlJtr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D2DCB1A1824;
	Tue, 25 Aug 2026 21:18:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8D35A604C4;
	Tue, 25 Aug 2026 21:18:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 590C511C7A346;
	Tue, 25 Aug 2026 23:17:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787692677; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=WEAPghw2V8FwZFDzIv86krQ5odb//lbOQ2ObiCLEC1A=;
	b=InTOlJtrPp/dS5U6KdgdcRJIjxmQ80uyE2tEVykWMb+uY2KzEEWzgtmV2E7mYouQ63g/eK
	fVK2j6w3P5+o9Qj8WQe+lrbxSyexGFtdBXVasRudU/K1BTI5aQqwBJp1bPMWO0dr3ld1x0
	3OkWL599vz7TCPejRGcotuObV5mHh2dllwInLasraiXcmo5WsGNShpyfSGHHYDxLMd5tp6
	vWxXt/963xV1p121WUQftbijMxQ8ja8VTHneC5WuBsRdjZItYHvrfOxcwXYAEUgRVeXx3j
	JayRQEFPOfglZpnLDRUlseAJJi5+YocCqZ2+Zex4MRAgBsRc4zW/9pQiKb29Pg==
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
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net v2] net: stmmac: selftests: Pass the IP proto mask in the TC selftest
Date: Tue, 25 Aug 2026 23:17:46 +0200
Message-ID: <20260825211748.360935-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The stmmac TC filtering rules have recently gained sanity checks to make
sure the passed keys and their respective masks are aligned with the HW
filtering abilities.

The stmmac selftests failed to pass the mask in the match data for L4
filtering tests, and are now failing consistently with -EINVAL :

$ ethtool -t eth1
[...]
23. L4 DA TCP Filtering          -22
24. L4 SA TCP Filtering          -22
25. L4 DA UDP Filtering          -22
26. L4 SA UDP Filtering          -22

Let's pass the ip_proto mask in the l4 filtering tests match data. Found
on imx8mp, which now have passing L4 tests :

$ ethtool -t eth1
[...]
23. L4 DA TCP Filtering          0
24. L4 SA TCP Filtering          0
25. L4 DA UDP Filtering          0
26. L4 SA UDP Filtering          0

While at it, initialize the masks and keys to avoid re-using whatever
was on the stack.

Fixes: 5536d7c84363 ("net: stmmac: fix l3l4 filter rejecting unsupported offload requests")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 1df26c217f9a..a2b917dd60e5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -1432,11 +1432,11 @@ static int __stmmac_test_l4filt(struct stmmac_priv *priv, u32 dst, u32 src,
 	struct {
 		struct flow_dissector_key_basic bkey;
 		struct flow_dissector_key_ports key;
-	} __aligned(BITS_PER_LONG / 8) keys;
+	} __aligned(BITS_PER_LONG / 8) keys = { };
 	struct {
 		struct flow_dissector_key_basic bmask;
 		struct flow_dissector_key_ports mask;
-	} __aligned(BITS_PER_LONG / 8) masks;
+	} __aligned(BITS_PER_LONG / 8) masks = { };
 	unsigned long dummy_cookie = 0xdeadbeef;
 	struct stmmac_packet_attrs attr = { };
 	struct flow_dissector *dissector;
@@ -1489,6 +1489,8 @@ static int __stmmac_test_l4filt(struct stmmac_priv *priv, u32 dst, u32 src,
 	keys.bkey.ip_proto = udp ? IPPROTO_UDP : IPPROTO_TCP;
 	keys.key.src = htons(src);
 	keys.key.dst = htons(dst);
+	/* Match the full IP proto field */
+	masks.bmask.ip_proto = 0xff;
 	masks.mask.src = src_mask;
 	masks.mask.dst = dst_mask;
 
-- 
2.55.0

