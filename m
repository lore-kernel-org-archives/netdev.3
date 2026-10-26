Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022393;
	b=c9f30q+J3TsVHXHpdVE6W0ivCZUDbVYqC3G4ssHYTocWs5PZ6b71PBjPoQ0w7T33Q6Cf
	 zJXmwurFr7YMMP83+18AvYL+kbOSsk4qqpXlgzFVL7x5oYSzkMle1ONKexhT6Ord9oPjk
	 xxAW3mnwaRwNLaqGwCT1Yd9u2KI8HEknqXlHiJj2LQ4NaDDZRo7to7D/LY95rJSk0NOK8
	 h6pcMDwrymOsRsIhbSX/aL0W2pj8xhXMaL3CeovuAGLGCtnJNHJRFjhBg/lam2HUZY/6r
	 5Gh5Tp0eA+XLOH82JjXcVTs7hz8uBvgnk5YQSPE7K9VmH40uMyx9L2YKb9SIma3126Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022393;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=T+3Lb6cby07OnpDKBHMKv+MMcvaLRlaQBJKyfAPq/Fo=;
	b=y5Zerq/KMd6GTNzXZ9TRE/tpOafLuYklzKMWnBUyQYaA4CMJJcbzNXsRaL23xakQzUve
	 ir58HSkrh55ir3w2mTZTbGJEMQ818tSS9FoReLSQ+wehpRSbx/J3fGA8bstPu1vQZyqHI
	 GWPKrJhwrkC8FgoI4SLvSuhW6gtpXM1xLjy2gOMWdj723vLzD48p6SYjV8Ym0sPjVy0MC
	 DopkGM09ShQ6kJhvuASC7Wy9jYL2h5ty4QU6bmlqU+MH1STXGTRVksfR3+ZrSNxMSPTFz
	 0beExTP9e63Wofbd1YVFoyvDBw6g+N6bauXJE6fv6kr1PaJZNzwJflt4e2bi6DNJPMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=iDqHhkSI;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E96E606A322;
	Mon, 26 Oct 2026 13:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E96E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=iDqHhkSI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793022394; x=1824558394;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=GOyp9LAFyJz05NRldtWeKBZCh84fsw0CGTo/agqK830=;
  b=iDqHhkSIJIDuS6fWMpbWCO8SMLg1MrqmRjjzir/BwnClWXPYE7pPNe5U
   IySZaT1sSpx2ypH33DH/8BhY9jzptYlp81Yto+8LWDd+oLeKBzE95vN+h
   +bnV5HUn4rSzvLNZeVbsGVeBl66CVH1I+cAeOxyppu+HxeIHfCYNvG493
   LUiJ0qj72k7/aUV3cqhRf1Gc76eldNzfNnkZ6f/rWJYUjgvIxOKkFAjnw
   VbZOxpWj1wLZ5w04JC5q13W2v8FCdtEfKrweNOs/bgAOtRSl4v0Ipi19C
   e8P1L9E64B8zDvgK94zJ3qbCfpjMrapMFFrUVsBFSFV0+26yl2nqpRLpe
   w==;
X-CSE-ConnectionGUID: ALQcOA33QIa5h7vcdTKKxg==
X-CSE-MsgGUID: ErcTE0odR5WsavhnZfy3NQ==
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="65554864"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2026 06:46:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 26 Oct 2026 06:46:32 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 26 Oct 2026 06:46:30 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 26 Oct 2026 14:46:28 +0100
Subject: [PATCH net] net: lan966x: do not warn on MAC entries that are not
 port destined
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
Content-Transfer-Encoding: 7bit
Message-ID: <20261026-lan966x-mac-warn-v1-1-9c885f9cbda9@microchip.com>
X-B4-Tracking: v=1; b=H4sIALNZ32oC/x3MQQqDQAxG4atI1g3oVEf0KsVF0F8NtFFmxAri3
 R1cfov3TooIikhtdlLArlEXSyheGfWz2ATWIZlc7nyRuzd/xRrvD/5Jz38JxqWvynqEONSglK0
 Box7P8kOGjbrrugFO2LNZZwAAAA==
X-Change-ID: 20261023-lan966x-mac-warn-46547fea2e7e
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

lan966x_mac_irq_handler() scans the rows of the MAC table that the
analyzer reports as changed, reads back all four columns of each row and
treats ANA_MACACCESS.DEST_IDX as a port number.

Before this patch, a destination index above num_phys_ports hits a
WARN_ON(). The driver installs such entries itself:
lan966x_mac_cpu_learn() uses PGID_CPU, and L2 multicast entries use a
general-purpose PGID. A row holding one of them is read back whenever
another entry in the same row is learned or aged out, so the scan warns
in normal operation, repeatedly once the MAC table is busy.

Skipping such a column is already the right behaviour. Drop the
WARN_ON() and keep the bounds check as a plain filter.

Found by an AI code review agent. Reproduced on a lan9668 board by
bridging two ports with a 10 s ageing time and sending three rounds of
2048 new source MACs: the base kernel warned 42 times from
lan966x_mac_irq_process(), the fixed kernel did not warn.

Fixes: 5ccd66e01cbe ("net: lan966x: add support for interrupts from analyzer")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_mac.c b/drivers/net/ethernet/microchip/lan966x/lan966x_mac.c
index 7a2294a0d099e..986c60ac23432 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_mac.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_mac.c
@@ -447,7 +447,7 @@ static void lan966x_mac_irq_process(struct lan966x *lan966x, u32 row,
 
 			lan966x_mac_process_raw_entry(&raw_entries[column],
 						      mac, &vid, &dest_idx);
-			if (WARN_ON(dest_idx >= lan966x->num_phys_ports))
+			if (dest_idx >= lan966x->num_phys_ports)
 				continue;
 
 			/* If the entry in SW is found, then there is nothing
@@ -501,7 +501,7 @@ static void lan966x_mac_irq_process(struct lan966x *lan966x, u32 row,
 
 		lan966x_mac_process_raw_entry(&raw_entries[column],
 					      mac, &vid, &dest_idx);
-		if (WARN_ON(dest_idx >= lan966x->num_phys_ports))
+		if (dest_idx >= lan966x->num_phys_ports)
 			continue;
 
 		spin_lock(&lan966x->mac_lock);

---
base-commit: 6430fb7f1cc4e329e386521b7b208df443de92f2
change-id: 20261023-lan966x-mac-warn-46547fea2e7e

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

