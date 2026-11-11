Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398205;
	b=3rUlMBbIQbIJn7mPzxG+AagU9tKOv+TJRKf0esZHL1tPZcWN81/jy8rwuPByiOPfmVTs
	 YGJtLl1sz++tmW1qGxO6KYLPAFJgVA5qKh1Gf7hGeqvxBlAJN5BbqxBPMMHk1RKOV8Evk
	 HZDZuRG8qnn8pT8mc8TN+ZG/aPiSi0oveo1zR1jqnRziopDNf0Qt5LnGRIXSSuzUxzD6x
	 fqMnNlE5xj1obqb+BoU8DK6z5KblZFN+3llJZzrKJiz5+czIcm6Ohn9mVWqJ5yG6dagG4
	 C6yXVewrs4IgQ+RoDddv/KQdOHFeSgB2bEuZbSOLmmYo1XabgjrXel3NqYdPkHOxoTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398205;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=DULki1YBXyFynwEGll1lTeawgQQau54Q1Gc3UmY3fP0=;
	b=atTYYULo3vLM9K+JrY5/Zb0FAWm/9MwgHzT5waRkRGMbbwzJ/szPDm3EC4Pc/ugIA52v
	 x0cD66qQ4+XyoIahjLQchgBXdh1lEQn9/lwcNmAtz3TnItCWn2C+XiMr8n23M9c/mZsD4
	 2zM+ftwCMErPzITRFjUD8jUP037pRSOC36soRZleFiYRDgbmqrn8pK89j9ZHtG65Yh6ix
	 wE9tn21uOhnSBahuDwrL74HQLv4rXC3zBSqjvkyJDjNQ3XSfrI98g1Pi7QUiWpoYl+sT/
	 Qt4egyHq/mPhViITcutF+X3LAxGyF2YSUVi5YSZTlVXyR6iOmEqsvX7KqdbP7TPqoBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=r0WJpFLz;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D213606A326;
	Wed, 11 Nov 2026 11:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D213606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=r0WJpFLz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794398204; x=1825934204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sX4k5hGxDxklxKUVC2c3/iBQqa3z7wVgYLg4zMnrnuQ=;
  b=r0WJpFLzv/nj7Ia394R4aNukRgF2zdiK3KAQ20qNGhSBfynzzG9lC8Oz
   oe8utVzoJoKZIJbJt0THcTKZrnWp+cyoaOTZe/JkLPwLisvzWvgm5CuaG
   ewfPF7kKqbAAKos3hb+y3HhAbq4547aEQadO7vJZjfWCkMcU5qBafw7Hp
   INrQqIqx5xY7qaklxWjGPrLifUAFC3xPa7y/9P0Agq/uIJqBaOwkILOQR
   KGLW1fDE8AiXa78R2MM7t49nH9O7Wks1KUJDJwnuvwPKYxecrPAMpSdJW
   t/ZKG/9iBC4cYr21meaNa6H/VKNL0/Zve8+FrTPv/tPIINm1WJlq7FlJT
   g==;
X-CSE-ConnectionGUID: ZQleCz6uQM+icV/46ESS+w==
X-CSE-MsgGUID: DDIKRFZuTfiYrR2ZltVdLg==
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="66350182"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 04:56:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 11 Nov 2026 04:56:42 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 11 Nov 2026 04:56:34 -0700
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
Subject: [PATCH v10 5/8] nvmem: layouts: add Microchip/SST SFDP EUI layout driver
Date: Wed, 11 Nov 2026 17:25:37 +0530
Message-ID: <c04e78faeb56eef4600be7bb9b2ba87b0f39782b.1794391660.git.manikandan.m@microchip.com>
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

Add an NVMEM layout that exposes the factory-programmed EUI-48 identifier
from the Microchip/SST vendor SFDP parameter table (e.g. SST26VF064BEUI)
as a "mac-address" cell, for use as a network MAC address. The vendor
table is located at runtime via the SFDP NVMEM device (no offset in DT).
The EUI-48 is stored in canonical MAC order, the 24-bit OUI followed by
the 24-bit extension identifier, so the cell is exposed as-is. Binds to
an "nvmem-layout" node with compatible "microchip,sst26vf-sfdp-eui".

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 MAINTAINERS                              |   6 +
 drivers/nvmem/layouts/Kconfig            |  10 ++
 drivers/nvmem/layouts/Makefile           |   1 +
 drivers/nvmem/layouts/sst26vf-sfdp-eui.c | 158 +++++++++++++++++++++++
 4 files changed, 175 insertions(+)
 create mode 100644 drivers/nvmem/layouts/sst26vf-sfdp-eui.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..fec148278068 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18413,6 +18413,12 @@ F:	Documentation/devicetree/bindings/sound/atmel,at91-ssc.yaml
 F:	drivers/misc/atmel-ssc.c
 F:	include/linux/atmel-ssc.h
 
+MICROCHIP SST SFDP EUI NVMEM LAYOUT DRIVER
+M:	Manikandan Muralidharan <manikandan.m@microchip.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/layouts/microchip,sst26vf-sfdp-eui.yaml
+F:	drivers/nvmem/layouts/sst26vf-sfdp-eui.c
+
 Microchip Timer Counter Block (TCB) Capture Driver
 M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 5e586dfebe47..855c7db530da 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -26,6 +26,16 @@ config NVMEM_LAYOUT_ONIE_TLV
 
 	  If unsure, say N.
 
+config NVMEM_LAYOUT_SST26VF_SFDP_EUI
+	tristate "Microchip/SST SFDP EUI-48 layout support"
+	help
+	  Say Y here if you want to expose the factory-programmed EUI-48
+	  identifier stored in the Microchip/SST vendor-specific SFDP parameter
+	  table (e.g. SST26VF064BEUI) as NVMEM cells, so that network drivers
+	  can use them as a MAC address.
+
+	  If unsure, say N.
+
 config NVMEM_LAYOUT_U_BOOT_ENV
 	tristate "U-Boot environment variables layout"
 	select CRC32
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
index dd6c6c70b1a9..3f5e01e40448 100644
--- a/drivers/nvmem/layouts/Makefile
+++ b/drivers/nvmem/layouts/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_NVMEM_LAYOUTS) += fixed-layout.o
 obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
 obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) += onie-tlv.o
 obj-$(CONFIG_NVMEM_LAYOUT_U_BOOT_ENV) += u-boot-env.o
+obj-$(CONFIG_NVMEM_LAYOUT_SST26VF_SFDP_EUI) += sst26vf-sfdp-eui.o
diff --git a/drivers/nvmem/layouts/sst26vf-sfdp-eui.c b/drivers/nvmem/layouts/sst26vf-sfdp-eui.c
new file mode 100644
index 000000000000..c4fdda35b64c
--- /dev/null
+++ b/drivers/nvmem/layouts/sst26vf-sfdp-eui.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMEM layout for the factory-programmed EUI-48 identifier stored in the
+ * Microchip/SST vendor-specific SFDP parameter table (e.g. SST26VF064BEUI).
+ *
+ * The whole SFDP is exposed as a read-only NVMEM device by the SPI NOR core.
+ * This layout locates the Microchip vendor parameter table at runtime and
+ * registers the EUI-48 address as an NVMEM cell, so that a network driver can
+ * consume it as a MAC address. No offset is hardcoded in the device tree.
+ *
+ * Copyright (C) 2026 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Manikandan Muralidharan <manikandan.m@microchip.com>
+ */
+
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/unaligned.h>
+#include <uapi/linux/if_ether.h>
+
+/* SFDP header and parameter header, as laid out on the flash. */
+struct sfdp_header {
+	u8 signature[4];
+	u8 minor;
+	u8 major;
+	u8 nph;
+	u8 unused;
+};
+
+struct sfdp_parameter_header {
+	u8 id_lsb;
+	u8 minor;
+	u8 major;
+	u8 length;
+	u8 parameter_table_pointer[3];
+	u8 id_msb;
+};
+
+#define SFDP_SIGNATURE			0x50444653U
+
+#define SFDP_PARAM_HEADER_ID(h)		(((h)->id_msb << 8) | (h)->id_lsb)
+#define SFDP_PARAM_HEADER_PTP(h)	get_unaligned_le24((h)->parameter_table_pointer)
+
+#define SFDP_MCHP_VENDOR_ID		0x01bf
+
+#define SFDP_MCHP_EUI48_MARKER_OFFSET	0x60
+#define SFDP_MCHP_EUI48_MARKER		0x30
+#define SFDP_MCHP_EUI48_OFFSET		0x61
+
+static int sfdp_eui_find_vendor_table(struct nvmem_device *nvmem, u32 *ptp)
+{
+	struct sfdp_parameter_header ph;
+	struct sfdp_header hdr;
+	int nph, i, ret;
+
+	ret = nvmem_device_read(nvmem, 0, sizeof(hdr), &hdr);
+	if (ret < 0)
+		return ret;
+
+	if (get_unaligned_le32(hdr.signature) != SFDP_SIGNATURE)
+		return -EINVAL;
+
+	nph = hdr.nph + 1;
+
+	for (i = 0; i < nph; i++) {
+		ret = nvmem_device_read(nvmem, sizeof(hdr) + i * sizeof(ph),
+					sizeof(ph), &ph);
+		if (ret < 0)
+			return ret;
+
+		if (SFDP_PARAM_HEADER_ID(&ph) != SFDP_MCHP_VENDOR_ID)
+			continue;
+
+		*ptp = SFDP_PARAM_HEADER_PTP(&ph);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static int sfdp_eui_add_cells(struct nvmem_layout *layout)
+{
+	struct nvmem_device *nvmem = layout->nvmem;
+	struct device *dev = &layout->dev;
+	struct nvmem_cell_info info = { };
+	struct device_node *layout_np;
+	u32 base = 0;
+	u8 marker;
+	int ret;
+
+	ret = sfdp_eui_find_vendor_table(nvmem, &base);
+	if (ret == -ENOENT) {
+		dev_dbg(dev, "no Microchip SFDP vendor table found\n");
+		return 0;
+	}
+	if (ret)
+		return ret;
+
+	/* The EUI-48 is present only if its marker byte is programmed. */
+	ret = nvmem_device_read(nvmem, base + SFDP_MCHP_EUI48_MARKER_OFFSET,
+				1, &marker);
+	if (ret < 0)
+		return ret;
+	if (marker != SFDP_MCHP_EUI48_MARKER) {
+		dev_dbg(dev, "EUI-48 not programmed (marker 0x%02x)\n", marker);
+		return 0;
+	}
+
+	layout_np = of_nvmem_layout_get_container(nvmem);
+	if (!layout_np)
+		return -ENOENT;
+
+	info.name = "mac-address";
+	info.offset = base + SFDP_MCHP_EUI48_OFFSET;
+	info.bytes = ETH_ALEN;
+	info.np = of_get_child_by_name(layout_np, "mac-address");
+
+	ret = nvmem_add_one_cell(nvmem, &info);
+	if (ret)
+		of_node_put(info.np);
+
+	of_node_put(layout_np);
+
+	return ret;
+}
+
+static int sfdp_eui_probe(struct nvmem_layout *layout)
+{
+	layout->add_cells = sfdp_eui_add_cells;
+
+	return nvmem_layout_register(layout);
+}
+
+static void sfdp_eui_remove(struct nvmem_layout *layout)
+{
+	nvmem_layout_unregister(layout);
+}
+
+static const struct of_device_id sfdp_eui_of_match_table[] = {
+	{ .compatible = "microchip,sst26vf-sfdp-eui" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sfdp_eui_of_match_table);
+
+static struct nvmem_layout_driver sfdp_eui_layout = {
+	.driver = {
+		.name = "microchip-sst26vf-sfdp-eui-layout",
+		.of_match_table = sfdp_eui_of_match_table,
+	},
+	.probe = sfdp_eui_probe,
+	.remove = sfdp_eui_remove,
+};
+module_nvmem_layout_driver(sfdp_eui_layout);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Manikandan Muralidharan <manikandan.m@microchip.com>");
+MODULE_DESCRIPTION("NVMEM layout for the EUI-48 in the Microchip/SST SFDP vendor table");
-- 
2.43.0

