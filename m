Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585578;
	b=yQ4CPej4Yb8W/yVv+RJhXhTMtJVEQb04AF0c4qHoJ1P9C3nwzOcmSDv1T+EjKXE5afoi
	 H+4u4RwVooTTkPSXfERlDuCuDnSSQnId1GyN60pSBPmR9hAdKs8Edl+D5J/ZCR+JSnh8E
	 MbTQ6pSNL3XJFpe2XccRe5NQ3lMZLEcJpT10NaCxsnMIqkwdycnlpKojfHuAGRLb457xR
	 3xUzoHDEFVCt6cc7M5yrziLvTJRL6sOuCKpmHfrZsod+UPleMtKVXt+FzFCD548ZaO1F6
	 jrqAE56Ynic3xQzMltjMqoYz2ww60ggmdV3O1Dvaj2hqno7uauX7OS2Astk8e9Q+kcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585578;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=oo9UYgPOjF0N34lF88gj4yV0SP/cw34rfqJYzNb62Qc=;
	b=qnY3CQyvzafydedGa40HZrFVkPG6DpQzeZrfKR0f3bdZitUrwlNXFZ8zlGNCWQkZkqx/
	 IfL5Fu5Tqufvb0Wwo+apMybd6T9md/PphF4NcOLDTcHwJn3uauh+lRPYQqjg5n+YHXDQ8
	 5S60cwoiOPsUWZSSrA8DnETgD/ENts/pGDCAbxaVkxVbIXHKuz0ryAYwwfuAuEHI6InTA
	 XU9O9elp8HMwUK2MAa8+UlSWP/j/YCEBqvCrvFY5b6Q5xTU2HXRI1wYufJ/09gIZvYAkh
	 kEE6gsxQu4o4pqwwFGuIfSBsmn2SaUZTGITGuPzhj4iQMK/dwIZP/xToARbQwB7p8xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fpF2KGgj;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A276070204
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24A276070204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fpF2KGgj
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 75C65C4F757
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:59:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C289E60015;
	Fri, 13 Nov 2026 15:59:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A190B11BC04A2;
	Fri, 13 Nov 2026 16:59:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794585575; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oo9UYgPOjF0N34lF88gj4yV0SP/cw34rfqJYzNb62Qc=;
	b=fpF2KGgjXJnJ72X2+h106DmxF3l7Z/3z1JtgcTec+XRl1/kWwE0pavjJz2Ebdtwgoknpj5
	Wt7bqQ5Z5kX+dD0TNFeuXoCNhwBTLGD+VS3Yh+yKsT3AX855AiIsQGR5RfhHeeAFmoNC7Q
	aTRxwFXpnUZ3wlDjsIWJn0Zpfx4eEujuGDJPoB0RfyNtQ/65Eckenb3l9OfePAvZQS9mKw
	HUcJLYcmNvDsVej/IeZqtdu6iKfOq0HYU6SyuQ/JvhqyLAOMnyCQNhYZ8/3VPB/wMNoD+k
	MR3ceNg2HRJIDrdJn9xtcX6zdVK+D8aYn7jq6Cxco/YfiykIvO+js2ZR+C1A9g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 13 Nov 2026 16:59:28 +0100
Subject: [PATCH net-next 1/2] net: macb: add QUEUE_DISABLE capability to 3
 compatibles
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-macb-caps-v1-1-42e0984b2f09@bootlin.com>
References: <20261113-macb-caps-v1-0-42e0984b2f09@bootlin.com>
In-Reply-To: <20261113-macb-caps-v1-0-42e0984b2f09@bootlin.com>
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, Paolo Valerio <pvalerio@redhat.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

According to datasheets, we know those 3 IP versions support Tx and Rx
queue disabling, ie bit 0 in RBQP and TBQP registers.

All revisions I've seen either support it on both Tx & Rx or don't
support it at all.

Sources:

   Compatible            | Match data         | Datasheet
   ----------------------|--------------------|-------------------------
   atmel,sama5d29-gem    | sama5d29_config    | DS60001764 [0]
   microchip,mpfs-macb   | mpfs_config        | header files [1]
   microchip,sama7g5-gem | sama7g5_gem_config | DS60001765 [2]

To contrast, check out the SAM9X60 DS60001579C datasheet [3] that does
not document bit 0 as anything special on page 1041 and page 1042.

This makes a big chance for those platforms when doing suspend WoL!
Instead of using a tieoff descriptor, they rely on hardware
capabilities of disabling queues.

[0]:
https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA5D29-Data-Sheet-ds60001764.pdf

[1]:
https://github.com/polarfire-soc/polarfire-soc-bare-metal-library/blob/614a67ab/src/platform/drivers/mss/mss_ethernet_mac/mss_ethernet_mac_regs.h#L200-L207

[2]:
https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA7G5-Series-Data-Sheet-DS60001765.pdf

[3]:
https://ww1.microchip.com/downloads/en/DeviceDoc/SAM9X60-Data-Sheet-DS60001579C.pdf

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5bd299fc85a9..25d098a46965 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -6078,7 +6078,7 @@ static const struct macb_config sama5d2_config = {
 
 static const struct macb_config sama5d29_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_GEM_HAS_PTP |
-		MACB_CAPS_USRIO_HAS_MII,
+		MACB_CAPS_USRIO_HAS_MII | MACB_CAPS_QUEUE_DISABLE,
 	.dma_burst_length = 16,
 	.usrio = &at91_default_usrio,
 };
@@ -6134,7 +6134,8 @@ static const struct macb_config mpfs_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
 		MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP |
-		MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE,
+		MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE |
+		MACB_CAPS_QUEUE_DISABLE,
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
 	.usrio = &mpfs_usrio,
@@ -6147,7 +6148,7 @@ static const struct macb_config sama7g5_gem_config = {
 		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
 		MACB_CAPS_USRIO_HAS_REFCLK_SOURCE |
 		MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP |
-		MACB_CAPS_USRIO_HAS_MII,
+		MACB_CAPS_USRIO_HAS_MII | MACB_CAPS_QUEUE_DISABLE,
 	.dma_burst_length = 16,
 	.usrio = &sama7g5_gem_usrio,
 };

-- 
2.56.0

