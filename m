Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595A37107B;
	Wed, 25 Feb 2026 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010415; cv=none; b=nCkUHQ/CpomqBcRQVnnTmvjWUDWOovLQ6Rc71XduN6SKjNCLYLdcCWBaUTdUnCn0QOtikuKFk86lNlQvsjodooWCWUk4df0pdBfwiCfZWOevawPJ7XBH1gA7piECQGUP5g1U+S6oi0J1oMmKDaHvEWHNJNkc6opiDwTtnuQQ2lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010415; c=relaxed/simple;
	bh=tM4XdMCygnhhnecObA64rz3/1LPZ7QdO3ptWuL+K8Dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OM/et8LMjDStWpm7mC4qs/7rL5iVl5kEquucToQ6TB2R6dyOthp2ExQA//nj7tBbKOnQP6ibcm5Ky2rymtGGED7PkQIxDj6sIpeORp0I6Kv/oyU6aTwcYlphrADT73ULTB0smt4t9jM4ZwXVmCZ6DSKD2826yhNmw7fyKNymD/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SzyTkc61; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SzyTkc61"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772010410; x=1803546410;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=tM4XdMCygnhhnecObA64rz3/1LPZ7QdO3ptWuL+K8Dc=;
  b=SzyTkc61tkWWzPicsnZ7r3j70eQpfdgCowrnldE/fckjeXpclzmMu/cu
   6brzQMTC0CxtDUoVzcY6k16mP0cCKMbjMKyX3T3H9GOcRrVULfeQfCht+
   4khIiqODurUtMXXM1dYdaIujGmjDhuqFiizbZyM5ZUrw6QX80NUT6bzB4
   XSUeSoNsyIL2VAEDwG+PCrYOq5lE0RJXEC4YbQc5Q0V8Egm4bbt45OxmI
   4G/eMyzcRfYbEdBoHpaz2Rlg5aXUfw/SiqLxenwRUS1uXRF7JlnjB9I+l
   T3N7GyxnHLmo6V9lfJOzcdXiLzuncIqocgXAT/3SXI+cNbQ4gbR5M7Wkh
   Q==;
X-CSE-ConnectionGUID: BbhGCtIlQZOkUhkWOAVukw==
X-CSE-MsgGUID: tjMTnoSvSBiVsapcaAugRw==
X-IronPort-AV: E=Sophos;i="6.21,310,1763449200"; 
   d="scan'208";a="221112786"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Feb 2026 02:06:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 25 Feb 2026 02:06:12 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 25 Feb 2026 02:06:10 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 25 Feb 2026 10:05:25 +0100
Subject: [PATCH net-next 2/7] net: sparx5: move netdev and notifier block
 registration to probe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260225-sparx5-init-deinit-v1-2-97036580b9f0@microchip.com>
References: <20260225-sparx5-init-deinit-v1-0-97036580b9f0@microchip.com>
In-Reply-To: <20260225-sparx5-init-deinit-v1-0-97036580b9f0@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

Move netdev registration and notifier block registration from
sparx5_start() to probe(). This allows proper cleanup via goto-based
error labels in probe().

Also, remove the sparx5_cleanup_ports() helper as its functionality is now
split between sparx5_unregister_netdevs() and sparx5_destroy_netdevs()
called at appropriate points.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 43 +++++++++++-----------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index d7e823fe4ab9..9887a260bafc 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -773,20 +773,11 @@ static int sparx5_start(struct sparx5 *sparx5)
 	mutex_init(&sparx5->mdb_lock);
 	INIT_LIST_HEAD(&sparx5->mdb_entries);
 
-	err = sparx5_register_netdevs(sparx5);
-	if (err)
-		return err;
-
 	sparx5_board_init(sparx5);
-	err = sparx5_register_notifier_blocks(sparx5);
-	if (err)
-		return err;
 
 	err = sparx5_vcap_init(sparx5);
-	if (err) {
-		sparx5_unregister_notifier_blocks(sparx5);
+	if (err)
 		return err;
-	}
 
 	/* Start Frame DMA with fallback to register based INJ/XTR */
 	err = -ENXIO;
@@ -823,12 +814,6 @@ static int sparx5_start(struct sparx5 *sparx5)
 	return err;
 }
 
-static void sparx5_cleanup_ports(struct sparx5 *sparx5)
-{
-	sparx5_unregister_netdevs(sparx5);
-	sparx5_destroy_netdevs(sparx5);
-}
-
 static int mchp_sparx5_probe(struct platform_device *pdev)
 {
 	struct initial_port_config *configs, *config;
@@ -1002,21 +987,37 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&sparx5->mall_entries);
 
+	err = sparx5_register_netdevs(sparx5);
+	if (err) {
+		dev_err(sparx5->dev, "Failed to register net devices\n");
+		goto cleanup_ptp;
+	}
+
+	err = sparx5_register_notifier_blocks(sparx5);
+	if (err) {
+		dev_err(sparx5->dev, "Failed to register notifier blocks\n");
+		goto cleanup_netdevs;
+	}
+
 	/* Start the rest of the initialization and enable interrupts. Must be
 	 * called last, after all subsystems are initialized.
 	 */
 	err = sparx5_start(sparx5);
 	if (err) {
 		dev_err(sparx5->dev, "Start failed\n");
-		goto cleanup_ptp;
+		goto cleanup_notifiers;
 	}
 
 	goto cleanup_config;
 
+cleanup_notifiers:
+	sparx5_unregister_notifier_blocks(sparx5);
+cleanup_netdevs:
+	sparx5_unregister_netdevs(sparx5);
 cleanup_ptp:
 	sparx5_ptp_deinit(sparx5);
 cleanup_ports:
-	sparx5_cleanup_ports(sparx5);
+	sparx5_destroy_netdevs(sparx5);
 	if (sparx5->mact_queue)
 		destroy_workqueue(sparx5->mact_queue);
 cleanup_config:
@@ -1044,12 +1045,12 @@ static void mchp_sparx5_remove(struct platform_device *pdev)
 		disable_irq(sparx5->ptp_irq);
 		sparx5->ptp_irq = -ENXIO;
 	}
+	sparx5_unregister_notifier_blocks(sparx5);
+	sparx5_unregister_netdevs(sparx5);
 	sparx5_ptp_deinit(sparx5);
 	ops->fdma_deinit(sparx5);
-	sparx5_cleanup_ports(sparx5);
 	sparx5_vcap_destroy(sparx5);
-	/* Unregister netdevs */
-	sparx5_unregister_notifier_blocks(sparx5);
+	sparx5_destroy_netdevs(sparx5);
 	destroy_workqueue(sparx5->mact_queue);
 }
 

-- 
2.34.1

