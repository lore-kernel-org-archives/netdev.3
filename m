Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C36360EF6
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792378900; cv=none; b=lZYpMSsNIdSULx7DBd7BWMchwewYjWhAfr2+4Wi573kMOFGkhpPB2n7FKnO+2dudZb7FlsYdsdSaoJcwVLzt5x0Nb3NX1xwtcAgA+deMIngWlNU51vv3k8JulYVWwVLA26UIPMKV8wdaBITdmSMrFic1ftyQ1pRcXjoUotBYOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792378900; c=relaxed/simple;
	bh=g3I5FYgIeX7uxb/Cfoc/AEAx7kZPkkJbAgv5X7Cg99s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lamMPlAeuw9INSl8f3vM/4k/t8tn8W3YpfmpXydbdwB6aVvk8fdE8IGDdJ8taZhuwUYAqKIqFJD6jBQKz/oJSLbxNFvMnpwhV71yFytG0XzCxfV89VNEmpP/TMEx8KrDkT5FR96rqET5sIuK0yVM6nA7ldV8C5CSpc1Or2crXoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Rd0JfPaD; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Rd0JfPaD"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5366ae57896so4862481cf.3
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 20:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792378897; x=1792983697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R5TeWWNtJggGTTz6M8A9FjvcqNzl7loaYSyNhUw4yhc=;
        b=Rd0JfPaDo5lXdChKvRJbyuRl1KfFof78opAI5/2c++af0OTYTN0XVBu3Jh90Eu6wBt
         6aCskj8ElMhWcRWjkdUbJ0N41Rlrn9B8Lmnl6zwyFHWA+jlyu8XfmZdvkwd5Z7oppRIi
         IMiPg2aFBzJStBMGbS/Z/GhdWM76IiU2CtcBO8jb/GExL4K12pg8Ox+gBG1XRXZh8D9G
         vx55m7Zm0rpfWFgj/qsuCoDUDGZBlQbIbRvJ+P7NXE0FBKduXDt1PE9BXVfU9nsqdKcx
         FRvUUUiZyEf3ACjNlmIztRmuAwBRgBaEYC76sizfAmAReGYe5nMaFqLi7mnDK8EszsSm
         R4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792378897; x=1792983697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R5TeWWNtJggGTTz6M8A9FjvcqNzl7loaYSyNhUw4yhc=;
        b=ibPDLATWyLed5KqyDaWkY3LWdjnGYZ6OYvHY4iN5ep1kvjH5zM2cxXFtivqKmTjgVQ
         7TLiJ/b0pfVux/cqx2BH68McgYjbd4/IACY7Vejop6/h7Hz4TEXhiSjqEvllxNpmoPEU
         GARNdm76RGqtMdJS6AcnPz6687HmHcV9nKrx5il6fcE8qfC3JKjF8LuO3PvA33WTWf43
         BCnBonNKdDpD1K+h6eUEN3PB+YNDUih7NsSCIFqPAGj7O7WRr7tuIxK2vBBVGWzZUlLE
         Qv2o7IlH2++ff3uL8t1uup/qby2YcnJJe1UrbfJNwCUs9psBNqYw1o1BG/NB6zh2btnI
         a//A==
X-Forwarded-Encrypted: i=1; AKwUvBxUUX9zwQX0tPlTIVjKIqLworz7l1AW9RpPr2IXrfjD6e2CkF1LUvfgp4N8Fv+0uxk7KCHbY5Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqVYdRzANMVp3BqfFjQG41i4cAgHi8OEGWBxmmrKaN3bi39hvC
	fiBY330fjIVgpXnhs7EIb6pcrpTPlFxe0E+72GP7vhucJDqh5sI7kK3sdrUsE2gf3iQ=
X-Gm-Gg: AYBFou3JeJFWbdxMoUd0ywgtT07CSDJBgzSjBsg14AD4leZzBLuVehoHx8tUZFrNV5B
	D67Egbasr/zF5RaAho77t04vP21/4NNoQFOYhF+wievHeaCAMdWKFG3hMh0fXRdtay/Uvp+T2pk
	ATlz55x+aEU5fh4B43o5+A1zISD40RiJB21aTf49+E06gv8hFW72UAYXSVZnk/AGlEsKKSr7wXq
	bz67aMnwPMkD7F0DzlJtLwA+Ygo6ndkrqle95+9TKaspPNCrSfrMGFWI13kg24RDJTHwF8Dubqg
	Te/StCPH5xQhI9mOgTv55mbKf3lqpqWJeMdiEG/6PCXiMjgH0dXafstGeJxVTHbfXTvvlyR9VQw
	dWKwNxs86s1jjcuzIRAx4wpZxXpx6MMQzv4755On73Xcs5zpTBpOf7zj7b8IRF3vf1bkyUzvOa6
	mcV5RXplEnC/pMyXnY7b84p1q2DAh8Pyoy80ss3QBOBizzvu9S7dDUU91VK3Lg1/QFg6Z2MjBYQ
	hwQeWvtRCxAVA==
X-Received: by 2002:a05:620a:8812:b0:93e:fa30:f1dd with SMTP id af79cd13be357-93f29dac9e9mr998353385a.70.1792378897136;
        Sun, 18 Oct 2026 20:01:37 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f3c61c440sm216840185a.10.2026.10.18.20.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:01:36 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: Daniel Thompson <daniel@riscstar.com>,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	peppe.cavallaro@st.com,
	joabreu@synopsys.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] net: pcs: pcs-xpcs-regmap: support XPCS memory-mapped MDIO bus via regmap
Date: Sun, 18 Oct 2026 22:01:25 -0500
Message-ID: <20261019030129.1470307-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019030129.1470307-1-elder@riscstar.com>
References: <20261019030129.1470307-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel@riscstar.com>

In some DesignWare XPCS implementations the memory-mapped MDIO bus is
allocated to a register window that does not align to a page boundary.
This makes iomapping the registers problematic.

For example the Toshiba TC9564 (a PCIe Ethernet-AVB/TSN bridge) provides
an "eMAC" subsystem with the XPCS base address cuddled up to XGMAC
registers.

Let's introduce helpers to allow the driver that owns the eMAC to register
an XPCS using is regmap for the memory-mapped MDIO bus.

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Co-developed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 MAINTAINERS                         |   2 +
 drivers/net/pcs/Makefile            |   3 +-
 drivers/net/pcs/pcs-xpcs-regmap.c   | 169 ++++++++++++++++++++++++++++
 include/linux/pcs/pcs-xpcs-regmap.h |  13 +++
 4 files changed, 186 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/pcs/pcs-xpcs-regmap.c
 create mode 100644 include/linux/pcs/pcs-xpcs-regmap.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 55ead3d1007a8..972c9faead5b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27148,8 +27148,10 @@ F:	drivers/net/ethernet/synopsys/
 SYNOPSYS DESIGNWARE ETHERNET XPCS DRIVER
 L:	netdev@vger.kernel.org
 S:	Orphan
+F:	drivers/net/pcs/pcs-xpcs-regmap.c
 F:	drivers/net/pcs/pcs-xpcs.c
 F:	drivers/net/pcs/pcs-xpcs.h
+F:	include/linux/pcs/pcs-xpcs-regmap.h
 F:	include/linux/pcs/pcs-xpcs.h
 
 SYNOPSYS DESIGNWARE HDMI RX CONTROLLER DRIVER
diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
index 4f7920618b900..088d35f21a4c3 100644
--- a/drivers/net/pcs/Makefile
+++ b/drivers/net/pcs/Makefile
@@ -2,7 +2,8 @@
 # Makefile for Linux PCS drivers
 
 pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-plat.o \
-				   pcs-xpcs-nxp.o pcs-xpcs-wx.o
+				   pcs-xpcs-nxp.o pcs-xpcs-regmap.o \
+				   pcs-xpcs-wx.o
 
 obj-$(CONFIG_PCS_XPCS)		+= pcs_xpcs.o
 obj-$(CONFIG_PCS_LYNX)		+= pcs-lynx.o
diff --git a/drivers/net/pcs/pcs-xpcs-regmap.c b/drivers/net/pcs/pcs-xpcs-regmap.c
new file mode 100644
index 0000000000000..f3f3aaaf0b75a
--- /dev/null
+++ b/drivers/net/pcs/pcs-xpcs-regmap.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synopsys DesignWare XPCS regmap helpers
+ *
+ * Copyright (C) 2026 RISCstar Solutions.
+ * Copyright (C) 2024 Serge Semin
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mdio.h>
+#include <linux/pcs/pcs-xpcs.h>
+#include <linux/pcs/pcs-xpcs-regmap.h>
+#include <linux/regmap.h>
+
+#include "pcs-xpcs.h"
+
+/* Page select register for the indirect MMIO CSRs access */
+#define DW_VR_CSR_VIEWPORT		0xff
+
+static ptrdiff_t xpcs_regmap_addr_format(int dev, int reg)
+{
+	return FIELD_PREP(0x1f0000, dev) | FIELD_PREP(0xffff, reg);
+}
+
+static u16 xpcs_regmap_addr_page(ptrdiff_t csr)
+{
+	return FIELD_GET(0x1fff00, csr);
+}
+
+static ptrdiff_t xpcs_regmap_addr_offset(ptrdiff_t csr)
+{
+	return FIELD_GET(0xff, csr);
+}
+
+static int
+xpcs_regmap_read_reg_indirect(struct regmap *regmap, int dev, int reg)
+{
+	ptrdiff_t csr, ofs;
+	unsigned int val;
+	u16 page;
+	int res;
+
+	csr = xpcs_regmap_addr_format(dev, reg);
+	page = xpcs_regmap_addr_page(csr);
+	ofs = xpcs_regmap_addr_offset(csr);
+
+	res = regmap_write(regmap, DW_VR_CSR_VIEWPORT, page);
+	if (res < 0)
+		return res;
+
+	res = regmap_read(regmap, ofs, &val);
+	if (res < 0)
+		return res;
+
+	return val & 0xffff;
+}
+
+static int
+xpcs_regmap_write_reg_indirect(struct regmap *regmap, int dev, int reg, u16 val)
+{
+	ptrdiff_t csr, ofs;
+	u16 page;
+	int res;
+
+	csr = xpcs_regmap_addr_format(dev, reg);
+	page = xpcs_regmap_addr_page(csr);
+	ofs = xpcs_regmap_addr_offset(csr);
+
+	res = regmap_write(regmap, DW_VR_CSR_VIEWPORT, page);
+	if (res < 0)
+		return res;
+
+	return regmap_write(regmap, ofs, val);
+}
+
+static int xpcs_regmap_read_c22(struct mii_bus *bus, int addr, int reg)
+{
+	struct regmap *regmap = bus->priv;
+
+	if (addr != 0)
+		return -ENODEV;
+
+	return xpcs_regmap_read_reg_indirect(regmap, MDIO_MMD_VEND2, reg);
+}
+
+static int
+xpcs_regmap_write_c22(struct mii_bus *bus, int addr, int reg, u16 val)
+{
+	struct regmap *regmap = bus->priv;
+
+	if (addr != 0)
+		return -ENODEV;
+
+	return xpcs_regmap_write_reg_indirect(regmap, MDIO_MMD_VEND2, reg, val);
+}
+
+static int xpcs_regmap_read_c45(struct mii_bus *bus, int addr, int dev, int reg)
+{
+	struct regmap *regmap = bus->priv;
+
+	if (addr != 0)
+		return -ENODEV;
+
+	return xpcs_regmap_read_reg_indirect(regmap, dev, reg);
+}
+
+static int xpcs_regmap_write_c45(struct mii_bus *bus, int addr, int dev,
+				 int reg, u16 val)
+{
+	struct regmap *regmap = bus->priv;
+
+	if (addr != 0)
+		return -ENODEV;
+
+	return xpcs_regmap_write_reg_indirect(regmap, dev, reg, val);
+}
+
+static void devm_xpcs_regmap_destroy(void *data)
+{
+	struct dw_xpcs *xpcs = data;
+
+	xpcs_destroy(xpcs);
+}
+
+struct dw_xpcs *devm_xpcs_regmap_register(struct device *dev,
+					  struct regmap *regmap)
+{
+	static atomic_t id = ATOMIC_INIT(-1);
+	struct dw_xpcs *xpcs;
+	struct mii_bus *bus;
+	int ret;
+
+	bus = devm_mdiobus_alloc_size(dev, 0);
+	if (!bus)
+		return ERR_PTR(-ENOMEM);
+
+	bus->name = "DW XPCS MCI/APB3";
+	bus->read = xpcs_regmap_read_c22;
+	bus->write = xpcs_regmap_write_c22;
+	bus->read_c45 = xpcs_regmap_read_c45;
+	bus->write_c45 = xpcs_regmap_write_c45;
+	bus->phy_mask = ~0;
+	bus->parent = dev;
+	bus->priv = regmap;
+
+	snprintf(bus->id, sizeof(bus->id), "dwxpcs-%x", atomic_inc_return(&id));
+
+	/* MDIO-bus here serves as just a back-end engine abstracting out
+	 * the MDIO and MCI/APB3 IO interfaces utilized for the DW XPCS CSRs
+	 * access.
+	 */
+	ret = devm_mdiobus_register(dev, bus);
+	if (ret) {
+		dev_err(dev, "failed to create MDIO bus\n");
+		return ERR_PTR(ret);
+	}
+
+	xpcs = xpcs_create_mdiodev(bus, 0);
+	if (IS_ERR(xpcs))
+		return xpcs;
+
+	ret = devm_add_action_or_reset(dev, devm_xpcs_regmap_destroy, xpcs);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return xpcs;
+}
+EXPORT_SYMBOL_GPL(devm_xpcs_regmap_register);
diff --git a/include/linux/pcs/pcs-xpcs-regmap.h b/include/linux/pcs/pcs-xpcs-regmap.h
new file mode 100644
index 0000000000000..c6d934b1054ed
--- /dev/null
+++ b/include/linux/pcs/pcs-xpcs-regmap.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_PCS_XPCS_REGMAP_H
+#define __LINUX_PCS_XPCS_REGMAP_H
+
+struct device;
+struct regmap;
+struct dw_xpcs;
+
+struct dw_xpcs *devm_xpcs_regmap_register(struct device *dev,
+					  struct regmap *regmap);
+
+#endif /* __LINUX_PCS_XPCS_REGMAP_H */
-- 
2.53.0

