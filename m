Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFFF5372FD
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169923; cv=none; b=hD0DFqnMdViIwzsx9TVW7tOrauzNbHZwdrohIWrG6593vWSUbuYuwdJFM2WPEj22Ifg98Gn8AGebuGD799cMALYIhaDgJsUpm3plGNspiT0gIl1BxqSDMT623qga4UwYqlCYAg5Wu6wDRiF5q/Nhri2YCZCwENlfS8nm9+7/syE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169923; c=relaxed/simple;
	bh=TcewcdlfgPShkiU59a5lrsVAfbnME1/z13BUy+2XrJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sAa4wwv0GHRixgs6tOk5rP2unpb5W161iW/VulQbnBcybmpDPyGAfJRem2f/1h9NJ+f6A2wsRnFgUZDWCzgOgCvVlUsLIhQSgWU6g+UHgqPLpL9wesQ4rBgWMJoeK2zchspqNm5AeJplD59RecQwQedTzjMjOQ6HIXMACBu6eyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A1FOPS8q; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A1FOPS8q"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 42F671A1253;
	Fri, 16 Oct 2026 16:58:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 17BB46075D;
	Fri, 16 Oct 2026 16:58:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 571A910328720;
	Fri, 16 Oct 2026 18:58:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792169907; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pW73Ulzl/GTKczuDx8qsDiu98xxU89BMQuPeNAG8o40=;
	b=A1FOPS8qX8lVTAR8lOHXTloh999sKkuC/FCXg7qxj6A/LMOxMNJU0bvS1ntwSZMb/Tg7be
	1/ZrZdsVlgb7S2AC9xenDgiCjrJRYeXOVeKYm4SVYmQD2EjU6vaMIQ96jQYQFUWKaRJ0gU
	NqP3OEHEd2JFhYNZUE8CsmZ/ApipHAEnTnsugBD0ZH/3GXnYH7FA6kyMywo04uEvOSXa6R
	C0H8G7zWrIRzW6CDv9AmQwlTqXpHXDKQrP+/RglWiGkWWFLqrtPvTGBeARLQXqroOpoQ3Y
	nIBBUAUXEprrAmts1PlCtakkLqNbFz2AHjrOopfi0Y2EBVkK3nwvFcgVaQ8QnA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 16 Oct 2026 18:58:15 +0200
Subject: [PATCH net-next v5 1/3] net: macb: add QUEUE_DISABLE capability to
 3 compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261016-macb-set-channels-v5-1-90ce0c0b8e75@bootlin.com>
References: <20261016-macb-set-channels-v5-0-90ce0c0b8e75@bootlin.com>
In-Reply-To: <20261016-macb-set-channels-v5-0-90ce0c0b8e75@bootlin.com>
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
X-Mailer: b4 0.15-dev
X-Last-TLS-Session-Version: TLSv1.3

From datasheets, we know those 3 IP versions support Tx and Rx queue
disabling, ie bit 0 in RBQP and TBQP registers.

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
index 020a47353d01..625171fd3f9b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5743,7 +5743,7 @@ static const struct macb_config sama5d2_config = {
 
 static const struct macb_config sama5d29_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_GEM_HAS_PTP |
-		MACB_CAPS_USRIO_HAS_MII,
+		MACB_CAPS_USRIO_HAS_MII | MACB_CAPS_QUEUE_DISABLE,
 	.dma_burst_length = 16,
 	.usrio = &at91_default_usrio,
 };
@@ -5799,7 +5799,8 @@ static const struct macb_config mpfs_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
 		MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP |
-		MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE,
+		MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE |
+		MACB_CAPS_QUEUE_DISABLE,
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
 	.usrio = &mpfs_usrio,
@@ -5812,7 +5813,7 @@ static const struct macb_config sama7g5_gem_config = {
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

