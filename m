Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890047A0A6;
	Fri, 16 Oct 2026 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147173; cv=none; b=RPKgZcZrlMmqwVW4QEdJh0AWuN0S18wJDTf1bMunPu+5BpdOcw5YbHEdLZn6dDXVCt1ToRmElZr2m1Gy69qoaQ/igtd1xCyydARDncnOguceK1hBO3jPNNVxjVSLpbJXuB6B937TeVxeOpz7LYVeuRFEGOCQpRamqGNrwLXwxMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147173; c=relaxed/simple;
	bh=1m8TfpAordahvGweBMHxBLczxZN/hAYq4RiqsECh8pg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxGm2Ycd/da3fMvwDIsLGllqdFYMrxvj1C8FwV2wcfCsvpM2Zo2r6W5xkvJXeFYScTlaKGS1xkWn5sg4zwBPQe4W1eswKevnIAI7lt2xI1jpcdA29QqLJDevUHY8PP9QvvK24HpIHzhwnFqsz4QXV3zI1RNr9R6QI/CvNjkHdGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pliL4VnT; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pliL4VnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792147169; x=1823683169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1m8TfpAordahvGweBMHxBLczxZN/hAYq4RiqsECh8pg=;
  b=pliL4VnTR9/cqRpdYcfQxstE+QKYie3J2YMoIgVNcjvgbZWjF+X1EkFK
   MuxAGha23ORrOGVkSMCREiMBWbcbDK0qhElMLWz9bgCECBPiZrYOM3vdj
   e9Y/nU/JpgKmehaobABkzTydPU6K+iO4l+ghZqAWb2m4lInvl2+NG3JE+
   R0X+jaWN9a8kfCL+84m8DJITM6Ioi9B8Rbd69/PYZBIimA19BEFHJ65h8
   O4Dy8iw/c/uvC8KiW2cj0C0U9czuaZdYWBB7C1LtV7JAxa0OWFJNW6OvB
   2HHalHjTwOdRJIbPfZnmZ2UXlZ7IKmubRs+wIQ4lJHov4sARmHigj1ddF
   g==;
X-CSE-ConnectionGUID: ZuX1AaxIT82Eu3ye1DUdUQ==
X-CSE-MsgGUID: lGZ1v2CjQb2vxMNkPFhVsg==
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="65140395"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2026 03:39:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 16 Oct 2026 03:39:26 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 16 Oct 2026 03:39:17 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
	<arnd@arndb.de>, <pengpeng@iscas.ac.cn>, <gregkh@linuxfoundation.org>,
	<mathieu.dubois-briand@bootlin.com>, <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v9 3/8] nvmem: core: take a reference on dev.of_node in nvmem_register()
Date: Fri, 16 Oct 2026 16:08:31 +0530
Message-ID: <d86398370f0593e4fdcfd60c4678563df995404e.1792145382.git.manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792145382.git.manikandan.m@microchip.com>
References: <cover.1792145382.git.manikandan.m@microchip.com>
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

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Michael Walle <mwalle@kernel.org>
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

