Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8761836C0DA
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924751; cv=none; b=SGX4M2wC+NBsazwYlOlh0D3v1HFITXRb3x0jRM04XTTEwFp44BdqQY8xssTZBc6bg5OR0vk4Wy5mw8HIhMLQxlmMeEU4v2um6sVOqai3MgUMbbsEY649uaJjuhanyFiRFLIXEb9ozkD9DSVvqyn+Qa2nrdvUO/yn31JXpLO/WII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924751; c=relaxed/simple;
	bh=kYK6SZK/WNmdUxFBeEotcBGf1PSahyDBkSvij/yVIhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q2VGgUYH5r6nuadvFDaPAZBIYVPEf3Qw0sUkzzvF2rnUF9FMEsy1w2jgDZgpxAm7FFKeDRa3EmAETPMxEwJWizcUQ6cUJeQhCXKNVtRO6u3ZBFNFUDp8qFxaKqaMJo7wke77evkI8+j8L91ahdWidaSyRxcm1VH7Kg2LUrZQy50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=XW6Rfr1f; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="XW6Rfr1f"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA488A3F88;
	Tue, 24 Feb 2026 10:18:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771924740; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ihdBebgSYrU0CQ4pyfCLGaLrNqGLAzqUg7DtWwB4pIs=;
	b=XW6Rfr1fa4L4KL+vsATX8OP63NfJqBBntC1aseZYLR19ebc+lEnIgLrvc2JGekg9y6VKrg
	gBZ5u/J7oT05tjjDbhDXlkxIwtCYvTSXPOG8e1Wa0K1+PO2a7yXOXiZP/dYf5bsoLpdAfT
	MLVmL03niYFr0mLKd/JKUSLylTqZB4LzmP07XUhOYYBOa/HTKWeaHaobdGQoz90Ohk4rQW
	Ut6KiYcXw9FIzEaLovCHvzUF7SVZkLcV+MWNBzrd2H6sGOOUbkVK8f6QMXTSK4UqnF0u3e
	rjRVkOCrBuNFrpHEm8ylnilnFinto4h5QPuqgtHHyLjSONJMVLVGWzwoFIfHmQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v2 5/5] net: cadence: macb: enable EEE for Raspberry Pi RP1
Date: Tue, 24 Feb 2026 10:18:21 +0100
Message-Id: <20260224091821.47671-6-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260224091821.47671-1-nb@tipi-net.de>
References: <20260224091821.47671-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Enable IEEE 802.3az Energy Efficient Ethernet on the Raspberry Pi 5's
RP1 southbridge by adding MACB_CAPS_EEE to its platform config.

The RP1 contains a Cadence GEM_GXL MAC (revision 0x00070109) paired
with a Broadcom BCM54213PE PHY, both of which support EEE at
1000BASE-T and 100BASE-TX.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 87097100b88c..2bf27a266e16 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5516,7 +5516,8 @@ static const struct macb_config eyeq5_config = {
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

