Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D7E3A5430;
	Fri, 16 Oct 2026 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147147; cv=none; b=hnkGV+twUK4KIvIomfPmdKz1iASBYHocI3RXpQG+dccGSt47bhNBBVu6l5IgcnbwmEf57DwaxCFQfEAy8HivQfnhnM208Y1QJ27aLL9X6ppcGDYVyxO2yGLvniePn7pzl5kefECcPZZuqdO7TGWG30GFmjZWzFd1OPTLd2qvV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147147; c=relaxed/simple;
	bh=dgPyojKrklW2/ydEPGCV2gH9I4AT3YqSs/zddDCl9bg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g1l5kwc+3IRQsGviq4WIsdmEp6UB3Uzo+iy7DEkT6uxiPiGWOhCIeufrAfifQXGxHMY/pqwyQIeXRqWWesuZ4BN//F0/FX2ahF5kcFfdwNm0PPPGh+yJw6gJg5guieT9Z3dCUIcl8dsGAyJNiamROibhcZDqNpzx2FRDqesHIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2C6nLOlH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2C6nLOlH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792147141; x=1823683141;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dgPyojKrklW2/ydEPGCV2gH9I4AT3YqSs/zddDCl9bg=;
  b=2C6nLOlHiz8Y/R7kFsf51qi8UGAYksvjsLqLFaUFFgQBsRWfd8F6Y6XK
   CuLQ2qhAlHJale8eIsYxubeiDltT52UAwCKGKpz9K5aWi1sNX5vxptW4S
   6jll/wHVcqF1NOIZ3JA1JF0z2uySlWksxGS5ZwX+YMNbnzb631WN2uJn0
   Pzw/96t1WVOABqO4JSZUvVOTUNG2Z67pMnf7vtyFUr5yaxJXTaFNr3YU9
   1b7g1QUw50+cLaWWpEXCFs6A/RF20PEFB59mwexax19/cXiKk8QNe7wST
   VOzQhbxx5x38BiYEt2g39M0U7eh4MLRj2l0pBlQkWYmnXV3BkIpaiacdD
   Q==;
X-CSE-ConnectionGUID: n/wAGzuIRsihiIuVm98YmA==
X-CSE-MsgGUID: 6doiG0+yTYeGdsWNhpqRbw==
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="296557701"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2026 03:39:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 16 Oct 2026 03:38:58 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 16 Oct 2026 03:38:48 -0700
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
Subject: [PATCH v9 0/8] Read MAC address from SST vendor specific SFDP region
Date: Fri, 16 Oct 2026 16:08:28 +0530
Message-ID: <cover.1792145382.git.manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Some Microchip/SST QSPI flashes (e.g. the SST26VF064BEUI) are factory
programmed with globally unique, write-protected EUI-48 and EUI-64
identifiers stored in a vendor-specific SFDP parameter table. On boards
that have no on-board EEPROM (sama5d27_wlsom1, sama5d29 curiosity,
sam9x75 curiosity) this is a reliable source for an Ethernet MAC address,
instead of relying on a U-Boot-provided or random address.

The series exposes the SFDP as a generic NVMEM framework with no vendor
code in the SPI NOR core:
 - The SPI NOR core exposes the entire SFDP as a generic read-only NVMEM
   device, rooted at a new "sfdp" child node of the flash.
 - A new NVMEM layout driver (drivers/nvmem/layouts/) locates the
   Microchip vendor parameter table at runtime and presents the EUI-48 as
   a "mac-address" cell.
 - Arbitrary parameters can be read with a standard fixed-layout
   (known offset) or with an nvmem-layout parser (location discovered at runtime).

Changes in v9:
 - 3/8 - Add Reviewed-by: Miquel Raynal, Reviewed-by: Michael Walle.
 - 4/8 - Add Reviewed-by: Miquel Raynal, Reviewed-by: Michael Walle.
         Drop the early return after of_get_compatible_child(). Updated the
		 comments and commit message to match.
 - 5/8 - Move the Makefile entry for sst26vf-sfdp-eui.o to the end.
         Move the ETH_ALEN check to the top of sfdp_eui_read_post_process()
		 and bail out early.
		 Compute nph as hdr.nph+1 and loop for the 0-based parameter-header count.
         Cosmetic fixes.

Changes in v8:
 - New 3/8 - nvmem: core: take a reference on dev.of_node in
             nvmem_register(). v7's 3/8 (now 4/8) called of_node_put() right
			 after devm_nvmem_register(), which left nvmem->dev.of_node backed by
			 no reference at all once the caller's own reference was dropped.
			 Fixing it at the nvmem_register() by taking  its own of_node_get()
			 when assigning nvmem->dev.of_node and released in nvmem_release().
 - 6/8 - drop the #address-cells/#size-cells from the qspi1_flash node.

Changes in v7:
 - 1/7 - Add blank lines in the "sfdp" schema per review;
 		 Add Reviewed-by: Rob Herring.
 - 2/7 - Add Reviewed-by: Rob Herring.
 - 3/7 - Drop the spi_nor_sfdp_nvmem_put_np() helper and
 		 call of_node_put() right after devm_nvmem_register().
 - 6/7 - Note in the commit message that the sama5d27_wlsom1 SoM ships the
         factory-programmed SST26VF064BEUI, so the EUI-48 "mac-address"
         cell is always present.

Changes in v6:
 - 3/7 - Move the SFDP NVMEM registration from sfdp.c into core.c, since
         sfdp.c is only for parsing the tables;use of_get_compatible_child()
		 instead of the open-coded child-node lookup.
 - 2/7, 6/7, 7/7 - Add Reviewed-by: Linus Walleij.

Changes in v5:
 - 1/7 and 5/7 - Add R-b tags
 - 3/7- Rework the comments, function name and commit message.Check all the nodes
        (for_each_available_child) for the right compatible "jedec,sfdp" instead
		of node name.

Changes in v4:
 - Rework per v3 review: remove the vendor-specific SFDP handling from the
   SPI NOR core; expose the whole SFDP as a generic read-only NVMEM device
   and move the EUI extraction into an nvmem-layout driver.
 - Introduce a new nvmem-layout driver to discover the vendor-table location
   at runtime; no offset hardcoded in the device tree.
 - Describe the SFDP via a dedicated "sfdp" subnode (compatible
   "jedec,sfdp"), which also resolves the v3 dtbs_check "Unevaluated
   properties ('nvmem-layout')" warning.
 - Reverse the stored EUI bytes into canonical MAC order.
 - Enable the layout in sama5_defconfig.

Changes in v3:
 - 2/3 - add support to update the QSPI partition into 'fixed-partition'
   binding in sama5d27_wlsom1
 - 3/3 - add nvmem-layout in qspi node for EUI48 MAC Address and nvmem cell
   properties for macb node in sama5d27_wlsom1

Changes in v2:
 - 1/3 - parse the SST vendor table, read and store the addresses
  into a resource - managed space. Register the addresses
  into NVMEM framework
 - 2/3 - add support to update the QSPI partition into 'fixed-partition'
  binding

v8: https://lore.kernel.org/all/cover.1790847519.git.manikandan.m@microchip.com/
v7: https://lore.kernel.org/all/20260812104955.485667-1-manikandan.m@microchip.com/

Manikandan Muralidharan (8):
  dt-bindings: mtd: jedec,spi-nor: allow the SFDP to be exposed via
    NVMEM
  dt-bindings: nvmem: layouts: add Microchip/SST SFDP EUI layout
  nvmem: core: take a reference on dev.of_node in nvmem_register()
  mtd: spi-nor: sfdp: expose the SFDP as a read-only NVMEM device
  nvmem: layouts: add Microchip/SST SFDP EUI layout driver
  ARM: dts: microchip: sama5d27_wlsom1: use fixed-partitions for QSPI
    flash
  ARM: dts: microchip: sama5d27_wlsom1: read MAC address from QSPI SFDP
  ARM: configs: sama5: enable Microchip/SST SFDP EUI NVMEM layout

 .../bindings/mtd/jedec,spi-nor.yaml           |  20 ++
 .../layouts/microchip,sst26vf-sfdp-eui.yaml   |  60 ++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |   1 +
 MAINTAINERS                                   |   6 +
 .../dts/microchip/at91-sama5d27_wlsom1.dtsi   |  63 +++---
 .../dts/microchip/at91-sama5d27_wlsom1_ek.dts |   2 +
 arch/arm/configs/sama5_defconfig              |   1 +
 drivers/mtd/spi-nor/core.c                    |  75 ++++++++
 drivers/nvmem/core.c                          |   5 +-
 drivers/nvmem/layouts/Kconfig                 |  10 +
 drivers/nvmem/layouts/Makefile                |   1 +
 drivers/nvmem/layouts/sst26vf-sfdp-eui.c      | 181 ++++++++++++++++++
 12 files changed, 399 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/microchip,sst26vf-sfdp-eui.yaml
 create mode 100644 drivers/nvmem/layouts/sst26vf-sfdp-eui.c


base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
--
2.43.0

