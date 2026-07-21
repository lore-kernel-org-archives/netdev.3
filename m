Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7948A35F609;
	Tue, 21 Jul 2026 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611806; cv=none; b=SjiZrjh6YCjELrq2GDdPBBtec8n0/yiZEfd0L/Xd/dADh0+N8vwFLQb4LBLRHx605vIVRx/lGvM7CfNwOjvcZ6wXKoTlUuLA+vxfOyOvMolbtqMrpGTpkSHM3ZXIhaFrpc9P8foGwNLcrquUJfTpsbDcLMXqBKrUiioF6nRRfuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611806; c=relaxed/simple;
	bh=U6+vQcPNtOv7hr1iaRTwprg4+yDTG6L5wbZnlafW3Vw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJSNODL+U6+Gz8qCZZznF9HJltluk8RBodX980Y+Qaj9RDBm9ZJ6ZPCTw31PQR/FU99+euTmFZPtYqJIw8dIQJpsjmNJgVttQDmwzsDTkvYLSBCLwGTWn75JQUUB/xMYtyYhvxB4SFNFDBMgmx3Sry4kQTZdLymA6neTyUTu63A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=StxpvurY; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="StxpvurY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784611804; x=1816147804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U6+vQcPNtOv7hr1iaRTwprg4+yDTG6L5wbZnlafW3Vw=;
  b=StxpvurYNTTe6CzSS0tGFVbJ8SB1LkqWQRKoILw5JrWHTK9YFC3odyV8
   ZuVF+CUDSrW0878tmnrZuHVq+sk7O3zsjTUdiscepHp7Z5fzL1bDkYrGS
   0fSdgyD0F7LmMUA1aW6wx7tQJFZtTQB9Tp7lgCaYXyBYQ1BUnS+PZV+rn
   e1TX2pUJiN8jCt9POAPdxMdgRVSIbN7iN1AKmNHVN6yuGBlPhrHf9vICb
   XLSfJNRGWD4i/GblcfX13oaKNbWSzgbeZBCQw5apuAI964uHhYFyhUc7+
   p4xc5wua43fbj2eCTRhOtGBsRA7Cg5kZRMdfokMz17s7J957/Xi/cXdcc
   g==;
X-CSE-ConnectionGUID: dCQ5BIDbQQee5nQAsAC7Hg==
X-CSE-MsgGUID: LfxyubazSkuxGoCBj2b4cQ==
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="228074678"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 22:29:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Mon, 20 Jul 2026 22:29:57 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 20 Jul 2026 22:29:48 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
	<arnd@arndb.de>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC: Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH v5 3/7] mtd: spi-nor: sfdp: expose the SFDP as a read-only NVMEM device
Date: Tue, 21 Jul 2026 10:58:55 +0530
Message-ID: <20260721052859.171341-4-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721052859.171341-1-manikandan.m@microchip.com>
References: <20260721052859.171341-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The SPI NOR core already reads the SFDP tables during enumeration and
caches them in nor->sfdp->dwords (see spi_nor_parse_sfdp()). Re-expose
that cached data as a read-only NVMEM device, in on-flash byte order,
rooted at the flash's SFDP child node (compatible "jedec,sfdp").

This lets NVMEM cells reference any SFDP data: a fixed-layout for
parameters at a known offset, or an nvmem-layout parser for vendor data
whose location must be discovered at runtime.The device is only registered
when an "sfdp" node is present in the device tree.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/mtd/spi-nor/core.c |  8 ++++
 drivers/mtd/spi-nor/core.h |  1 +
 drivers/mtd/spi-nor/sfdp.c | 86 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ccf4396cdcd0..b833d8ec2d65 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3204,6 +3204,14 @@ static int spi_nor_init_params(struct spi_nor *nor)
 		spi_nor_init_params_deprecated(nor);
 	}
 
+	/*
+	 * Expose the SFDP table as an NVMEM device only when
+	 * the flash actually provides one
+	 */
+	ret = spi_nor_register_sfdp_nvmem(nor);
+	if (ret)
+		return ret;
+
 	ret = spi_nor_late_init_params(nor);
 	if (ret)
 		return ret;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index ba2d1a862c9d..0a6484298c5c 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -698,6 +698,7 @@ int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8 opcode,
 
 int spi_nor_check_sfdp_signature(struct spi_nor *nor);
 int spi_nor_parse_sfdp(struct spi_nor *nor);
+int spi_nor_register_sfdp_nvmem(struct spi_nor *nor);
 
 static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
 {
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 4600983cb579..704799fe92ae 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -6,6 +6,8 @@
 
 #include <linux/bitfield.h>
 #include <linux/mtd/spi-nor.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
 
@@ -1612,3 +1614,87 @@ int spi_nor_parse_sfdp(struct spi_nor *nor)
 	kfree(param_headers);
 	return err;
 }
+
+static int spi_nor_sfdp_reg_read(void *priv, unsigned int offset,
+				 void *val, size_t bytes)
+{
+	struct spi_nor *nor = priv;
+	struct sfdp *sfdp = nor->sfdp;
+	size_t sfdp_size = sfdp->num_dwords * sizeof(*sfdp->dwords);
+
+	if (offset >= sfdp_size || bytes > sfdp_size - offset)
+		return -EINVAL;
+
+	/* The cached SFDP is kept in on-flash (little-endian) byte order. */
+	memcpy(val, (u8 *)sfdp->dwords + offset, bytes);
+
+	return 0;
+}
+
+static void spi_nor_sfdp_nvmem_put_np(void *data)
+{
+	of_node_put(data);
+}
+
+/**
+ * spi_nor_register_sfdp_nvmem() - expose the SFDP as a read-only NVMEM device
+ * @nor:	pointer to a 'struct spi_nor'
+ *
+ * Expose the whole SFDP, in on-flash byte order, as a read-only NVMEM device
+ * rooted at the flash's SFDP child node (compatible "jedec,sfdp"). This lets
+ * generic (fixed-layout) or vendor (nvmem-layout) cells reference any SFDP
+ * data. The device is only registered when a child node with the "jedec,sfdp"
+ * compatible is described in the device tree.
+ *
+ * Return: 0 on success or if there is nothing to do, -errno otherwise.
+ */
+int spi_nor_register_sfdp_nvmem(struct spi_nor *nor)
+{
+	struct device *dev = nor->dev;
+	struct nvmem_config config = { };
+	struct nvmem_device *nvmem;
+	struct device_node *np;
+	int ret;
+
+	if (!nor->sfdp)
+		return 0;
+
+	for_each_available_child_of_node(dev_of_node(dev), np)
+		if (of_device_is_compatible(np, "jedec,sfdp"))
+			break;
+	if (!np)
+		return 0;
+
+	/*
+	 * Register the put before devm_nvmem_register() so it runs last on
+	 * detach, after the NVMEM device that uses the node is gone.
+	 */
+	ret = devm_add_action_or_reset(dev, spi_nor_sfdp_nvmem_put_np, np);
+	if (ret)
+		return ret;
+
+	config.dev = dev;
+	config.of_node = np;
+	config.name = "sfdp";
+	config.id = NVMEM_DEVID_AUTO;
+	config.owner = THIS_MODULE;
+	config.read_only = true;
+	config.word_size = 1;
+	config.stride = 1;
+	config.size = (int)(nor->sfdp->num_dwords * sizeof(*nor->sfdp->dwords));
+	config.reg_read = spi_nor_sfdp_reg_read;
+	config.priv = nor;
+
+	nvmem = devm_nvmem_register(dev, &config);
+	if (IS_ERR(nvmem)) {
+		/* NVMEM support is optional. */
+		if (PTR_ERR(nvmem) == -EOPNOTSUPP)
+			return 0;
+		return dev_err_probe(dev, PTR_ERR(nvmem),
+				     "failed to register SFDP NVMEM device\n");
+	}
+
+	dev_dbg(dev, "exposed %d-byte SFDP as an NVMEM device\n", config.size);
+
+	return 0;
+}
-- 
2.43.0

