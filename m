Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA88455611;
	Wed, 14 Oct 2026 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960074; cv=none; b=dpVzUzYGMTQBe8mdpBiZRKE4PEbB2/bpv6DmJK9PuxfA0mfQe0pmlMJfiTNeVtGvqSjTAji2PyWpUcCM83vmxBqe8UjgQuT5WtWarPhKq9JGpYfRiiShXD9NzCMwho2LE8Qbje1R5eCD3qjb4n1vJbVCGZIr/F8pvJCmj8UJg8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960074; c=relaxed/simple;
	bh=Q9/ya7Cp/pR0bMBDAFcDQYvx7wa+ikPL68tMqKSWrKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIDQFm927Eeg4m5Z7lXN7/R0KpibFzNYj7slH7oHsBV/RjCdnaVLyy3LeTAHqEJeh127nJEF2ry1izt9k9o35Oufz0hVliQU9KQpD4NwvxQjJZYkfyNPq9I5p0ncxeYrHJAlq0GI675i9GJDaOUbbK6El2HP58FgXsDs5/Ek13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LeS3Vv1+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LeS3Vv1+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791960073; x=1823496073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q9/ya7Cp/pR0bMBDAFcDQYvx7wa+ikPL68tMqKSWrKM=;
  b=LeS3Vv1+h2aWvjJ0zanzgISiS8uGWLouw4B/knXKQUv7KXQFwX7WW3jz
   04uVXdVKCrI6dfonlgjRlo9F1+Y5jbqMNi8kUkgk/+Z4J1YHRLzb2CJct
   lI48exp4NpYvEn92eg/D9Si254vAKcpwNYv27pDjOKyw6L0sNkdzZtdfd
   hYt9ZKJE6udmTJck65fR0FbVcowJj3Tqa9oz0En5eLCV6nH27Yore84nY
   rSSnBGIUbAhCW/kDIbb3Hl1yQCVGGi4JHYXNLIYyt47oMBEYo3a4bzCVg
   APp5H2b74Rm97R3wM4vc+8BwSgV4sgqyf+L8CZKOe8E2eTMzLcOKPi2GW
   g==;
X-CSE-ConnectionGUID: myGUAlddTGWwRb/Llrhaag==
X-CSE-MsgGUID: FGSH6KCCSnioZPvoXyCOEw==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="65288668"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 23:41:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 13 Oct 2026 23:41:11 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 13 Oct 2026 23:41:03 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
	<arnd@arndb.de>, <aaro.koskinen@iki.fi>, <gregkh@linuxfoundation.org>,
	<mathieu.dubois-briand@bootlin.com>, <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v8 3/8] nvmem: core: take a reference on dev.of_node in nvmem_register()
Date: Wed, 14 Oct 2026 12:10:07 +0530
Message-ID: <2e21cc4b871da8764e3a12d0ebdcf7cb799149ab.1790847519.git.manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790847519.git.manikandan.m@microchip.com>
References: <cover.1790847519.git.manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

nvmem_register() stores config->of_node (or config->dev->of_node)
into nvmem->dev.of_node without taking its own reference. Callers
that get the node via of_get_compatible_child() etc. and drop their
reference right after registering leave nvmem->dev.of_node backed by
no reference at all.

Take an of_node_get() when assigning nvmem->dev.of_node and release
it in nvmem_release(). Existing callers that hold their own get/put
pair around the registration call need no changes, since get/put on
a device_node is per-holder and independent of core now also holding
one.

Suggested-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/nvmem/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 0556d140170a..98192597b935 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -541,6 +541,7 @@ static void nvmem_release(struct device *dev)
 
 	ida_free(&nvmem_ida, nvmem->id);
 	gpiod_put(nvmem->wp_gpio);
+	of_node_put(nvmem->dev.of_node);
 	kfree(nvmem->ops);
 	kfree(nvmem);
 }
@@ -950,9 +951,9 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->keepout = config->keepout;
 	nvmem->nkeepout = config->nkeepout;
 	if (config->of_node)
-		nvmem->dev.of_node = config->of_node;
+		nvmem->dev.of_node = of_node_get(config->of_node);
 	else
-		nvmem->dev.of_node = config->dev->of_node;
+		nvmem->dev.of_node = of_node_get(config->dev->of_node);
 
 	switch (config->id) {
 	case NVMEM_DEVID_NONE:
-- 
2.43.0

