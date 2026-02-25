Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573C036D4E4;
	Wed, 25 Feb 2026 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010386; cv=none; b=FHkd78UjtcdAE/470t+/1+5hWfQ0zgIhmy4ddECG6VgfAo1WVvdBvWBJDtf5GzLNCJ+VThsnlMwseV7MrBBNd6iGkX4fFV4sljXpYU3UXULkVXh6IIZteZbXNQAV3Dv1vwHI/aXNkQoYL8N8hTkwrQS5d0C3dy+QYKKiKLyTwpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010386; c=relaxed/simple;
	bh=Ms5EvdSvw59+pigEbOTMZYJRJle67s3XN/MmS6G0DeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=G3g7cXKcYpAHILzEzD7Bu9ICsaEnvVcGx4+r2lDrK7r+NHl84S01pL7EKo4azglOyNYedfgdr06FyNqR3c50tZWrn2F+G6g/fh+NZiaR2xxfqECIjg4bS7OKgo49ia7VXAJNHW+F5c7xnu12cGho84xoJiYPwoTFtgdVboV1xHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lFpp0k4K; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lFpp0k4K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772010384; x=1803546384;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ms5EvdSvw59+pigEbOTMZYJRJle67s3XN/MmS6G0DeM=;
  b=lFpp0k4KQvdHwlO0f7ncNkg0ixmqqESgsmERVC/c/10Fa4wJheIiHtih
   H9if6dQFVsKTC8sfnNQjW9MVtS63cX39KyEj1lJS4iEq1/MnlBkFugDdr
   4GmTptgUmUYf4Wpe3PlRhHGSYdrI9zLu4X32q91dDbWMWwNtD30xGX3he
   WAeUvr1J+GzawqXwEOq6AQRFCilIWJNxZe6soDR9UHWcOWVPDIhxdC71t
   LmHt4KeXmVD1dETrF7Yq4LbG5JU4p6bg8gFm4a1xBhEomZN1ZS0G+as5O
   USoH85bXG1XzWpwxA3EtCASBqG+BhxWhb7GDJVnZA8gcnf0mVGk9nVUTO
   w==;
X-CSE-ConnectionGUID: GvK6L9OjSSuGPw39llTOAQ==
X-CSE-MsgGUID: wGZ5CqykQMGMVoCtVHo6Sg==
X-IronPort-AV: E=Sophos;i="6.21,310,1763449200"; 
   d="scan'208";a="61259299"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 02:06:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 25 Feb 2026 02:06:14 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 25 Feb 2026 02:06:12 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 25 Feb 2026 10:05:26 +0100
Subject: [PATCH net-next 3/7] net: sparx5: move VCAP initialization to
 probe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260225-sparx5-init-deinit-v1-3-97036580b9f0@microchip.com>
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

Move the VCAP initialization code from sparx5_start() to probe(). Add
proper error handling with a cleanup_vcap label and sparx5_vcap_deinit()
call.

Also, rename sparx5_vcap_destroy() to sparx5_vcap_deinit() to stay
consistent with the naming.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c      | 16 ++++++++++------
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h      |  2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 9887a260bafc..28ee45815c7f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -775,10 +775,6 @@ static int sparx5_start(struct sparx5 *sparx5)
 
 	sparx5_board_init(sparx5);
 
-	err = sparx5_vcap_init(sparx5);
-	if (err)
-		return err;
-
 	/* Start Frame DMA with fallback to register based INJ/XTR */
 	err = -ENXIO;
 	if (sparx5->fdma_irq >= 0) {
@@ -985,12 +981,18 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 		goto cleanup_ports;
 	}
 
+	err = sparx5_vcap_init(sparx5);
+	if (err) {
+		dev_err(sparx5->dev, "Failed to initialize VCAP\n");
+		goto cleanup_ptp;
+	}
+
 	INIT_LIST_HEAD(&sparx5->mall_entries);
 
 	err = sparx5_register_netdevs(sparx5);
 	if (err) {
 		dev_err(sparx5->dev, "Failed to register net devices\n");
-		goto cleanup_ptp;
+		goto cleanup_vcap;
 	}
 
 	err = sparx5_register_notifier_blocks(sparx5);
@@ -1014,6 +1016,8 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 	sparx5_unregister_notifier_blocks(sparx5);
 cleanup_netdevs:
 	sparx5_unregister_netdevs(sparx5);
+cleanup_vcap:
+	sparx5_vcap_deinit(sparx5);
 cleanup_ptp:
 	sparx5_ptp_deinit(sparx5);
 cleanup_ports:
@@ -1047,9 +1051,9 @@ static void mchp_sparx5_remove(struct platform_device *pdev)
 	}
 	sparx5_unregister_notifier_blocks(sparx5);
 	sparx5_unregister_netdevs(sparx5);
+	sparx5_vcap_deinit(sparx5);
 	sparx5_ptp_deinit(sparx5);
 	ops->fdma_deinit(sparx5);
-	sparx5_vcap_destroy(sparx5);
 	sparx5_destroy_netdevs(sparx5);
 	destroy_workqueue(sparx5->mact_queue);
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index fe7d8bcc0cd9..6a069434fca6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -563,7 +563,7 @@ void sparx5_get_hwtimestamp(struct sparx5 *sparx5,
 
 /* sparx5_vcap_impl.c */
 int sparx5_vcap_init(struct sparx5 *sparx5);
-void sparx5_vcap_destroy(struct sparx5 *sparx5);
+void sparx5_vcap_deinit(struct sparx5 *sparx5);
 
 /* sparx5_pgid.c */
 enum sparx5_pgid_type {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
index 25066ddb8d4d..9b4ea3e22ef8 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
@@ -2083,7 +2083,7 @@ int sparx5_vcap_init(struct sparx5 *sparx5)
 	return err;
 }
 
-void sparx5_vcap_destroy(struct sparx5 *sparx5)
+void sparx5_vcap_deinit(struct sparx5 *sparx5)
 {
 	struct vcap_control *ctrl = sparx5->vcap_ctrl;
 	struct vcap_admin *admin, *admin_next;

-- 
2.34.1

