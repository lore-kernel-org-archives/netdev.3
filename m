Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274460;
	b=1Rc4rzOruX8SYnZCh1yc7vHkxs4l3dzXhS43b7/mSW99uWIFfK8hqINw3jGZkNYZKsde
	 uw8wr6SRQRq5hghDyqXSVFnc5RXg5YveqxrB8FHH0qiwBKWrs1teM3LQpw51gAmqaluvD
	 GTBGg6joyNM0VsTOooc0A4Mghnjghg7PfscjT9EGZMH9fkt+ZFVU5ahXUKwx8JdqBrggO
	 R3uB2vJSSW/Oko/D5WvCGJPZysWwrLWVkMzwkA7d+9KMCaAagmUhQjDrt6N9/+06dNuOh
	 nZD7+Wsn7haeVvs2/WKpn4WggCH97jLTowcnfWMHre1bcsounY6AJrGS4AAJE9LdmLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274460;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=C00EHIZ1CDh5ShQ8Yw8kqsywXTekDWMtUV8SESTMzJU=;
	b=pECw+V+fOAlTKdUwtY0gR0WPdEfyVlAgMy17DpaAP/hkFHSUjn0IB/o5yHPrsl18cj6B
	 EYJx984adXjvscdgwFDu6WM5XSxHA62QHJsLOFTbPZSGk1XrQyhGv6IPMAMqMaDfV+bzK
	 lsDX4/ggvCwbIQNt+zSAbNvSyTnDfdp3L8VD8a0PmRe/h4HGRbUDvWOq2vsTrQj5WU82x
	 o75QeaG91a4ijK23oKbQF7RgKurNlH7sgyByLLT9dv5v8aDEU817m66We0t0+dLkJYfRb
	 zEQgBnyck2jNBTm2ejMZa+P58kcYSNrohGyu7euqlxPkomIT7vgiYUaYPaau3VMxlbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=YyACqit+;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E7606A31A;
	Thu, 29 Oct 2026 11:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 817E7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=YyACqit+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793274458; x=1824810458;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=nx29DMuQUiHHnh5RPaqd96ft0Fo4lC2P/JFa50Bq190=;
  b=YyACqit+xVfB3kxbTqk3R/kSMlx4Rqn2XVK8S5ppBx0X/KFYaQzdGRLd
   NpSoacKg8dKpmEPmUbuiALwbSNxN6aQZ2Z0s3/oU3REBc4INrXMoMtJqF
   kYHD/yaY9EGW5KrBwVlxrYIKVyhq1VyOiPpNof0unLp3ZpmDOhD85AZs9
   hpzMIuZWoPrfClCRh4pMz71bJl6yJ4RcdK4rJYMCddbcD7f4C3a+DtYQ0
   rd1U4FIrcSR5DpfRejUkb6nkk7QtYURhrzYXLaHemZd2jPrt4uZbPGN9d
   jGsRaSMNJIrZAO4Ocmt2/dybviQITzeJmvew04Ppo4ceXI3EDwajWZyTa
   Q==;
X-CSE-ConnectionGUID: pSqz9MD3T8OoFe0b7L1Xsw==
X-CSE-MsgGUID: CygL1EdST7Cu9jBPt1rFng==
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="76265637"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:47:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 04:47:32 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 29 Oct 2026 04:47:30 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 29 Oct 2026 12:47:21 +0100
Subject: [PATCH net] net: lan966x: save the RX state after quiescing the
 NAPI in a reload
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
Message-ID: <20261029-lan966x-fdma-reload-quiesce-v1-1-daaeda5ca3aa@microchip.com>
X-B4-Tracking: v=1; b=H4sIAEgy42oC/x3MQQ6CMBAF0KuQWTsJTLQUrmJc1PZXJoGirRoSw
 t1tXL7N26kgKwqNzU4ZXy26poru1JCfXHqANVSTtGK6VizPLg3GbBzD4jhjXl3g16cWHmzj/eK
 l7yH2THV4ZkTd/vuVEt50O44fEbaTHXIAAAA=
X-Change-ID: 20261028-lan966x-fdma-reload-quiesce-8fb5c277e284
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Carlier
	<devnexen@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

lan966x_fdma_reload() replaces the RX ring when the MTU or the XDP
program changes. It copies rx->page[] and the RX FDMA state, allocates
the new ring, and on success returns the old pages to the old page pool.
If the allocation fails, it restores the old state instead.

Before this patch, the copies are taken before the NAPI is disabled. A
poll still running at that point refills the ring and advances the DCB
index and the last DCB pointer after the copy. The success path then
returns a page that the stack still owns to the old pool and never
returns the page that replaced it, and the restore path puts back a
stale DCB index and last DCB pointer.

Disable the NAPI and stop the queues before taking the copies. The copy
of rx->page[] is still allocated first, so a failed allocation returns
before anything has to be undone.

Found by an AI code review agent. The race was not reproduced, as its
window is narrow. The reworked reload was tested on a lan9668 board with
repeated MTU and XDP program changes under RX traffic, with no page pool
or UAF splat.

Fixes: 59c3d55a946c ("net: lan966x: fix use-after-free and leak in lan966x_fdma_reload()")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 21668bbcc9063..2dbc25c098fec 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -819,21 +819,21 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 	int page_order, max_mtu;
 	int err, i, j;
 
-	old_pages = kmemdup(lan966x->rx.page, sizeof(lan966x->rx.page),
-			   GFP_KERNEL);
+	old_pages = kmalloc_objs(*lan966x->rx.page, FDMA_DCB_MAX);
 	if (!old_pages)
 		return -ENOMEM;
 
+	napi_synchronize(&lan966x->napi);
+	napi_disable(&lan966x->napi);
+	lan966x_fdma_stop_netdev(lan966x);
+
 	/* Store these for later to free them */
+	memcpy(old_pages, lan966x->rx.page, sizeof(lan966x->rx.page));
 	memcpy(&fdma_rx_old, &lan966x->rx.fdma, sizeof(struct fdma));
 	page_pool = lan966x->rx.page_pool;
 	page_order = lan966x->rx.page_order;
 	max_mtu = lan966x->rx.max_mtu;
 
-	napi_synchronize(&lan966x->napi);
-	napi_disable(&lan966x->napi);
-	lan966x_fdma_stop_netdev(lan966x);
-
 	lan966x_fdma_rx_disable(&lan966x->rx);
 	lan966x->rx.page_order = round_up(new_mtu, PAGE_SIZE) / PAGE_SIZE - 1;
 	lan966x->rx.max_mtu = new_mtu;

---
base-commit: 829a09df899dcce860dcf5f70e09c1b2d7d425ab
change-id: 20261028-lan966x-fdma-reload-quiesce-8fb5c277e284

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

