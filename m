Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398186;
	b=U01BHNvRPEEd00zrXSB/IRoUU9AsaQ3nbNzyVxFU3EniYMsEfrflnAZikAqnyHu+XffJ
	 HKFGuLRZVd/IPwjWE9A1V14evLb6kkHl6NrrS9p4/L2ZV4BmaQhr3IcXXg2JkfL6G9Bri
	 bXZcr6m2e+eKXjA83feP9z8YQ8lFniCklyemWHKQFCvn5spjzOk3zsAEPU7yTunTmmbc8
	 kd3XWuZHJaRsSqIAWP7HGxFhTbETBsNY5L9Fdu7lTQ1q3puAD9TkQC2P+vVfDEMXtPq4T
	 B9Z5Lu9prxoZGdmrYwxPoMz+SxiA1PLzgGUcOZxlmQFzE+SKj699OKZje6Ic4M+tXvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398186;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=8SfbOoc5GgUY4qQ6MHsBh7nTts0Qb+czz/4jv6s46Qc=;
	b=QxKzY3/ZxFTXYnvKLq+LsH3npm1vu/cF560cYjZmzITc/DxOduvItfTOwTQ+2o6QOArD
	 4zc5GmKo4ABiQ2kwE9QiLbrniimOCpP30yA2G4hmTPPAtKJ+Wb4LPzGRLOxssFdDGH2Tb
	 MkRPEYAoprhtfY+1w46svZskicPDaPuGxwBz2D4XhaY4HxBMLHZLMVKuyYiWfKFHA8QcN
	 LFSrgfyGtf8tcPHVoyALPG6SeXOVLjZO8Pz71mVaDRgtLJaGcjnNc+L+c9vqEH4wm/F34
	 rmf+/xWW88XqxIfg0D8mjkjbEj/DwY5t1FPi4xcSH4ZbhV+Ya97EAlxoENsHUivBYWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=kptBhtzZ;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76C606A88B;
	Wed, 11 Nov 2026 11:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC76C606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=kptBhtzZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794398186; x=1825934186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cbB9ppCfJ4JPhiiXg5+JirD8QyiTkRHLmvM+DOrf6ZI=;
  b=kptBhtzZSP0PzBlRnzvU3JUhgMp2nHVCGg0lS8sYXJNy62rFvXMIxpUE
   wYzfagBGxsTDlFjyEs4cgAAgB3FgZGIvZfDXnuYxp+mZmeilayF+Mzoo6
   9TBgwbcyloozHqKjNpUpR9iAuCnaGeiXa8ATe7ICvFb84jOYvY4dI1Obz
   3HFJW/pu3YG10EOEXbRKPCsg4EiSTiux7HNYIctdx6so54PK3NInXvyyv
   ijrGMfwlvox26zBnxqoTdUaia8p0Mywt4/fnxSijf0/ec4Xi1bg5xMfHe
   Rj/jiK3cFuZJiI13uYNL52OlZloSFiFP9zLTV2CWGAZiMkhie7eixDo1k
   Q==;
X-CSE-ConnectionGUID: fahtkvVtS06HBrtIclWMCQ==
X-CSE-MsgGUID: 3D21lF3IQoq+2K8Iyi+68A==
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="66592258"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 04:56:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 11 Nov 2026 04:56:24 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 11 Nov 2026 04:56:15 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <arnd@arndb.de>,
	<linusw@kernel.org>, <enelsonmoore@gmail.com>, <aaro.koskinen@iki.fi>,
	<pengpeng@iscas.ac.cn>, <mathieu.dubois-briand@bootlin.com>,
	<gregkh@linuxfoundation.org>, <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v10 3/8] nvmem: core: take a reference on dev.of_node in nvmem_register()
Date: Wed, 11 Nov 2026 17:25:35 +0530
Message-ID: <2bc9cde2ff5bfa2bc55bf12407bfc08f6a467bb6.1794391660.git.manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794391660.git.manikandan.m@microchip.com>
References: <cover.1794391660.git.manikandan.m@microchip.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
index 7d4cce8e2742..2e07f95de7ff 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -571,6 +571,7 @@ static void nvmem_release(struct device *dev)
 	nvmem_device_remove_all_cells(nvmem);
 	ida_free(&nvmem_ida, nvmem->id);
 	cleanup_srcu_struct(&nvmem->srcu);
+	of_node_put(nvmem->dev.of_node);
 	kfree(nvmem);
 }
 
@@ -973,9 +974,9 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
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

