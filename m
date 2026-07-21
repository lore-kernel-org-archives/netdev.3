Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A373403E1;
	Tue, 21 Jul 2026 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611768; cv=none; b=Lfxq3bL2b7O4R3NrStHAKVjLrUCxac5p+Aj3nX/YVOmpJhdMjvEa6BhYa5EPcE9gGKjC7JcTwkfyDe791QG7CpXXXeQyUcxi5dZBUJxu1QfI93MJDV0RKzPhXdhw6aPn+xr8CvoG36SVcwkgRZpSE40NdrqNY9fT0u/GpQ9++oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611768; c=relaxed/simple;
	bh=eJMieyDV3EZzwKIlHI9vHv7je1D8dJwnhudfFu9FrzE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gyH+J96rHwgfoBNHdXTw9bhmRMzOUniggYazh6+TuUSFspWXBBo/KY6EtyqxsUfqSlw5WVUEgmClP+WNAFl47CwMJJVohPGy4sbDGuDNYW+7SXyjBGCn76/Ulc2d4LibCoGDmjdSlneW4uqxrcnQ8G7c7775POmx8kWr+FaDow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o0kJ2tuI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o0kJ2tuI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784611769; x=1816147769;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eJMieyDV3EZzwKIlHI9vHv7je1D8dJwnhudfFu9FrzE=;
  b=o0kJ2tuIvEp+YjvLcCQaj/3HxP83WcqqYdE7QAXK/Lo96C3nCmgGbtEJ
   HfhMhnOblQHN0ipcw2skq0ug+reaHznu6E7fECc/ChtC/iQ2l6oLX8mXi
   6Ero3WoDAZvNfbImUlEX+deYlieHeQ6/ARIn9ZSnf1YbEc7GR/BPYJlyf
   G2d9aiDZgJZjd9c38eee7sc07D9vLfOhq61oOE3IKPMVVW8ZLWVZ4myvl
   e+ZHRqdKSvVo9aREO7t/O4Pb4wCJUlxUwaxuVycUtZuxOrm7zrtNWpU0u
   CpKytgmdACuQd5qaHgbFc2RppKof9eLRXg7hfZOJNBBULovJ8C36CjF2X
   Q==;
X-CSE-ConnectionGUID: Mxsn5rdUR4CIeUZSSNpL3Q==
X-CSE-MsgGUID: Zzt9BG4zTIiQHT9bve7zfA==
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="292305099"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 22:29:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Mon, 20 Jul 2026 22:29:19 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 20 Jul 2026 22:29:11 -0700
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
Subject: [PATCH v5 0/7] Read MAC address from SST vendor specific SFDP region
Date: Tue, 21 Jul 2026 10:58:52 +0530
Message-ID: <20260721052859.171341-1-manikandan.m@microchip.com>
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

This v5 reworks the approach into a generic NVMEM framework with no vendor
code in the SPI NOR core:
 - The SPI NOR core now exposes the entire SFDP as a generic read-only
   NVMEM device, rooted at a new "sfdp" child node of the flash.
 - A new NVMEM layout driver (drivers/nvmem/layouts/) locates the
   Microchip vendor parameter table at runtime and presents the EUI-48 as
   a "mac-address" cell.
 - Arbitrary parameters can be read with a standard fixed-layout
   (known offset) or with an nvmem-layout parser (location discovered at runtime).

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

v4: https://lore.kernel.org/linux-devicetree/20260630092406.150587-1-manikandan.m@microchip.com/

Manikandan Muralidharan (7):
  dt-bindings: mtd: jedec,spi-nor: allow the SFDP to be exposed via
    NVMEM
  dt-bindings: nvmem: layouts: add Microchip/SST SFDP EUI layout
  mtd: spi-nor: sfdp: expose the SFDP as a read-only NVMEM device
  nvmem: layouts: add Microchip/SST SFDP EUI layout driver
  ARM: dts: microchip: sama5d27_wlsom1: use fixed-partitions for QSPI
    flash
  ARM: dts: microchip: sama5d27_wlsom1: read MAC address from QSPI SFDP
  ARM: configs: sama5: enable Microchip/SST SFDP EUI NVMEM layout

 .../bindings/mtd/jedec,spi-nor.yaml           |  18 ++
 .../layouts/microchip,sst26vf-sfdp-eui.yaml   |  60 ++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |   1 +
 MAINTAINERS                                   |   6 +
 .../dts/microchip/at91-sama5d27_wlsom1.dtsi   |  61 +++---
 .../dts/microchip/at91-sama5d27_wlsom1_ek.dts |   2 +
 arch/arm/configs/sama5_defconfig              |   1 +
 drivers/mtd/spi-nor/core.c                    |   8 +
 drivers/mtd/spi-nor/core.h                    |   1 +
 drivers/mtd/spi-nor/sfdp.c                    |  86 +++++++++
 drivers/nvmem/layouts/Kconfig                 |  10 +
 drivers/nvmem/layouts/Makefile                |   1 +
 drivers/nvmem/layouts/sst26vf-sfdp-eui.c      | 182 ++++++++++++++++++
 13 files changed, 415 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/microchip,sst26vf-sfdp-eui.yaml
 create mode 100644 drivers/nvmem/layouts/sst26vf-sfdp-eui.c


base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
-- 
2.43.0

