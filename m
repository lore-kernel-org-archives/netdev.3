Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A6D43803F;
	Fri, 16 Oct 2026 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147183; cv=none; b=kTZh64QHnYEqQNns0ck4/qYgDvdGpmzvNGqiA2X5pRD2JQIF8cba/z37/7Qa12rT9oaWMg/yDxJ//G+LWnSF1MZ0vqd8J5f/UzNBxO/RCjTxlhsvfQwclC4VQ/EI+KsUHj9JGe8g/MskGUTw3FkjASnJfqPcNQQgT/rV/isDdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147183; c=relaxed/simple;
	bh=pyoeyqlj2ef2+TJRwREjVNJtbdmhfRsvaWxlfOjmE4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYzXJevdsAJzQ/QiZWiwHaegADntHXD9c6BlGGg6HT+gpsdCatL+cpVCCS5OGszfzS5mkvIG5xRDv4aT8VTUPGXLyJqwU3HLoFlNmF3B5bBASvmOVS8o31KEMUMP7u9Z1mN/zC2z9HgkrgGDzdXtD4L+RHDnVvJcR0HjhAfENdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Iun9wRpu; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Iun9wRpu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792147177; x=1823683177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pyoeyqlj2ef2+TJRwREjVNJtbdmhfRsvaWxlfOjmE4A=;
  b=Iun9wRpuSM9vINO7/gy00de6cXwOSrgwCTpqixx0sKNbRs5ukacqjiXM
   SpidWpn8nVSs/Dmj0KMTyEg+zN0PkSLi0rOY3qaDFmnt29CijaEMQf2dc
   +u1f++hYmFCVJd8veKObjdNP4aPvYHUacBGNBDW1uIA2RRpvf9Wq02Cab
   rpZXgPkIx+LsEjuKv0MVCwS1fZEQlIg8G+VjLhNHvwi21fK0PION6Cwhh
   oPN7/7c5M7vt177UBu3J2WUqoJmIuwD0VikVGo2Hq1srApzi569S1JInH
   Ew+z+oINq5joWqO3cQ12BzCVXjAnCqPCvhhCdSGKm5o55Lbat4ES43y87
   Q==;
X-CSE-ConnectionGUID: JDoxDy82Tu6LYhgkHviMTg==
X-CSE-MsgGUID: Xa1eC8fnRnqH8lMVC36B0w==
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="64191102"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 03:39:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Fri, 16 Oct 2026 03:39:35 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 16 Oct 2026 03:39:27 -0700
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
Subject: [PATCH v9 4/8] mtd: spi-nor: sfdp: expose the SFDP as a read-only NVMEM device
Date: Fri, 16 Oct 2026 16:08:32 +0530
Message-ID: <889d6d5b7c608fd6553f38e4a34b050dcf70317f.1792145382.git.manikandan.m@microchip.com>
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

The SPI NOR core already reads the SFDP tables during enumeration and
caches them in nor->sfdp->dwords (see spi_nor_parse_sfdp()). Re-expose
that cached data as a read-only NVMEM device, in on-flash byte order,
rooted at the flash's SFDP child node (compatible "jedec,sfdp"), if any.

This lets NVMEM cells reference any SFDP data: a fixed-layout for
parameters at a known offset, or an nvmem-layout parser for vendor data
whose location must be discovered at runtime.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 75 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 8bc117b46e02..ed478e48ca11 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/spi-nor.h>
 #include <linux/mutex.h>
+#include <linux/nvmem-provider.h>
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/task_stack.h>
@@ -3001,6 +3002,72 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
 		nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
 }
 
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
+/**
+ * spi_nor_register_sfdp_nvmem() - expose the SFDP as a read-only NVMEM device
+ * @nor:	pointer to a 'struct spi_nor'
+ *
+ * Expose the whole SFDP, in on-flash byte order, as a read-only NVMEM device
+ * rooted at the flash's SFDP child node (compatible "jedec,sfdp"), if any.
+ * This lets generic (fixed-layout) or vendor (nvmem-layout) cells reference
+ * any SFDP data.
+ *
+ * Return: 0 on success or if there is nothing to do, -errno otherwise.
+ */
+static int spi_nor_register_sfdp_nvmem(struct spi_nor *nor)
+{
+	struct device *dev = nor->dev;
+	struct nvmem_config config = { };
+	struct nvmem_device *nvmem;
+	struct device_node *np;
+
+	if (!nor->sfdp)
+		return 0;
+
+	np = of_get_compatible_child(dev_of_node(dev), "jedec,sfdp");
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
+	of_node_put(np);
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
+
 /**
  * spi_nor_late_init_params() - Late initialization of default flash parameters.
  * @nor:	pointer to a 'struct spi_nor'
@@ -3204,6 +3271,14 @@ static int spi_nor_init_params(struct spi_nor *nor)
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
-- 
2.43.0

