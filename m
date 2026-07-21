Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F2239FD4;
	Tue, 21 Jul 2026 05:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611814; cv=none; b=fgMd4JuAv9bRdxTEgnXodmKvSdYZmHSVQE/ySkTlLO0kdxmc6bUydEHVo39BEdzO9ZUnANP77C7XTrcF4wXeySSmAgefy7UmclW/Tcsrs7grUs/WaOpckRm1SJ0gfVw5ijbKO8YyxY6U0pXsyDUAANkDnIjkTrjpwegdoi1WnUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611814; c=relaxed/simple;
	bh=0qenKQGYRppCTsYcMWqwWJbLWIvnSTxY6bhy9Zk8pQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rhfuinq4osaKW00SirUD2V2KblDvgG6s/n/SzRTWIvWISmW1kQcO6oOftk1MwMKcQfJ+cPuCQW2IVO/Mtlvz/hnMrlAaypNUL+rSQft894MiD/BcsCXqqFp7ETJhnmM4xXacwXAAtJ4B59R+6ErR+YyS/Xo2ETULwcLL526S9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Bi3rLJdt; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Bi3rLJdt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784611812; x=1816147812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0qenKQGYRppCTsYcMWqwWJbLWIvnSTxY6bhy9Zk8pQM=;
  b=Bi3rLJdtpuMeh5u4+ICrXFdONyap+5zFyHAF6WJkQ6rzJkcnh/3EsDF2
   81SCDmvtIsUcxiGPPBuM8PRj5kBfxTERYLOf+SZ6Q10T56UP2iZ3acVza
   z7reFdeavYoT/MB1qE1WkmpSbLtNQ22hwnYE8Zbaenv66FBmNVoQjfPN3
   tMcGCOhmfT+0kgYKja/hABI1qe3RLmwh0FLl0G6Yn2WH8Jn9HO0w1W8Os
   L2fDj7jYEIT3/FgIosvaW3X8IgXLhj3lio7bVUJZQmdwYNwjf4cwhQbcT
   gkOrvRba9wHWnOd6xskxCUGywEOLkMWwf6p56FcwstSj8oay0lC+gKBU6
   w==;
X-CSE-ConnectionGUID: iTdXx/9LRBKtFajdHE/flA==
X-CSE-MsgGUID: f7XQ8/UqQnq4PeyKASXbjg==
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="228074715"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jul 2026 22:30:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 20 Jul 2026 22:30:09 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 20 Jul 2026 22:30:01 -0700
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
Subject: [PATCH v5 4/7] nvmem: layouts: add Microchip/SST SFDP EUI layout driver
Date: Tue, 21 Jul 2026 10:58:56 +0530
Message-ID: <20260721052859.171341-5-manikandan.m@microchip.com>
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

Add an NVMEM layout that exposes the factory-programmed EUI-48 identifier
from the Microchip/SST vendor SFDP parameter table (e.g. SST26VF064BEUI)
as a "mac-address" cell, for use as a network MAC address. The vendor
table is located at runtime via the SFDP NVMEM device (no offset in DT),
and a read_post_process callback reverses the LSB-first bytes into
canonical MAC order. Binds to an "nvmem-layout" node with compatible
"microchip,sst26vf-sfdp-eui".

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 MAINTAINERS                              |   6 +
 drivers/nvmem/layouts/Kconfig            |  10 ++
 drivers/nvmem/layouts/Makefile           |   1 +
 drivers/nvmem/layouts/sst26vf-sfdp-eui.c | 182 +++++++++++++++++++++++
 4 files changed, 199 insertions(+)
 create mode 100644 drivers/nvmem/layouts/sst26vf-sfdp-eui.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ab8736850ea..9fac8c5203a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17815,6 +17815,12 @@ F:	Documentation/devicetree/bindings/sound/atmel,at91-ssc.yaml
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
index 4940c9db0665..b99eac1f63f2 100644
--- a/drivers/nvmem/layouts/Makefile
+++ b/drivers/nvmem/layouts/Makefile
@@ -5,4 +5,5 @@
 
 obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
 obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) += onie-tlv.o
+obj-$(CONFIG_NVMEM_LAYOUT_SST26VF_SFDP_EUI) += sst26vf-sfdp-eui.o
 obj-$(CONFIG_NVMEM_LAYOUT_U_BOOT_ENV) += u-boot-env.o
diff --git a/drivers/nvmem/layouts/sst26vf-sfdp-eui.c b/drivers/nvmem/layouts/sst26vf-sfdp-eui.c
new file mode 100644
index 000000000000..641318d6f0af
--- /dev/null
+++ b/drivers/nvmem/layouts/sst26vf-sfdp-eui.c
@@ -0,0 +1,182 @@
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
+#include <linux/etherdevice.h>
+#include <linux/minmax.h>
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
+/* Microchip (vendor) parameter table identifier: id_msb << 8 | id_lsb. */
+#define SFDP_MCHP_VENDOR_ID		0x01bf
+
+#define SFDP_MCHP_EUI48_MARKER_OFFSET	0x60
+#define SFDP_MCHP_EUI48_MARKER		0x30
+#define SFDP_MCHP_EUI48_OFFSET		0x61
+
+static int sfdp_eui_read_post_process(void *priv, const char *id, int index,
+				      unsigned int offset, void *buf,
+				      size_t bytes)
+{
+	u8 *data = buf;
+	int i;
+
+	/* SFDP stores the address least-significant octet first; reverse it. */
+	for (i = 0; i < bytes / 2; i++)
+		swap(data[i], data[bytes - 1 - i]);
+
+	if (bytes == ETH_ALEN && !is_valid_ether_addr(buf))
+		return -EINVAL;
+
+	return 0;
+}
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
+	/* The number of parameter headers (NPH) field is zero-based. */
+	nph = hdr.nph;
+
+	for (i = 0; i <= nph; i++) {
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
+	info.read_post_process = sfdp_eui_read_post_process;
+
+	ret = nvmem_add_one_cell(nvmem, &info);
+	if (ret)
+		of_node_put(info.np);
+	else
+		dev_dbg(dev, "exposed EUI-48 at SFDP offset 0x%x\n", info.offset);
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

