Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496093A6F07
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621702; cv=none; b=agcOwArXFu3oRd+fxjIw6xODMcV/9zOwT844fwvF+x4Pm1p+Rovaa/BrQxype9+ScGXVQNXRf83NIZ3fFg7Pyz5CmgpC+slgQRjIb07VvW0gqC5dtRtNB00c6Va3iEfgGmJ3Hn8u8BlFbTevwHmASMK9jbeb2Ckx+rFjzK0w8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621702; c=relaxed/simple;
	bh=s2sMlXCo09q0wnNPoYMRu6IYT7j/QPtOWVpGKp2cJKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZ5C6mBmT10c2PfetqJVVLL96KUhmGg0TrljK1b37ze3k7jFDKkcaN30BAB/unGVlmURgvBK+26zk3+ZN97x7lIyoRRompU6wcBErsY0bbw3a76M4F/le2zqPXIF2xedgBQjs69k1Fq8SvEYJ5ii+nRokLb7cRfCQskeadHL2Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=VU+Zajno; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="VU+Zajno"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 293EEA5614;
	Wed,  4 Mar 2026 11:54:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772621698; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Tt3o0l0xlwVxpNes4Rnb5PwdXYOdDusGhM53d+eKqpY=;
	b=VU+ZajnodlcxoNHkzq+C3EwEw3ZGDMuFgV03aXn4A6KtgXiQZQp9/slHjHqMaUadBwXEMD
	ynxvUiTUTUEhupPK/GCfM56gP5j3r7gXwzh5JJqLJZk2emtZWjYmcbPZCaawHcUUb93lK9
	xkHJ28vCYFinePAvV4HSNFJ1bgYxEFllC2nI5dmyR9VEX7mMs7wu9B4i0gDG0Mjd2U/2G6
	8xeS35Cu3NrJ77G96+LqycY0OneMf4WuEuppfw+xqs8kdeyIl59iWyX4Xz6mK9YCVmSZdD
	QueifliEDHjJ0Mji6fy/jMcvjDAZP+6vKhByR9avLI9AIONFjQ71EdzkgzmCrg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v6 4/5] net: cadence: macb: enable EEE for Raspberry Pi RP1
Date: Wed,  4 Mar 2026 11:54:31 +0100
Message-ID: <20260304105432.631186-5-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304105432.631186-1-nb@tipi-net.de>
References: <20260304105432.631186-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Set MACB_CAPS_EEE for the Raspberry Pi 5 RP1 southbridge
(Cadence GEM_GXL rev 0x00070109 paired with BCM54213PE PHY).

EEE has been verified on RP1 hardware: the LPI counter registers
at 0x270-0x27c return valid data, the TXLPIEN bit in NCR (bit 19)
controls LPI transmission correctly, and ethtool --show-eee reports
the negotiated state after link-up.

Other GEM variants that share the same LPI register layout (SAMA5D2,
SAME70, PIC32CZ) can be enabled by adding MACB_CAPS_EEE to their
respective config entries once tested.

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f01366394cff..5933a5042bc8 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5537,7 +5537,8 @@ static const struct macb_config eyeq5_config = {
 static const struct macb_config raspberrypi_rp1_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
 		MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_EEE,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-- 
2.51.0

