Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A360403129;
	Wed, 12 Aug 2026 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531819; cv=none; b=U8tFGBx+LSQJHFJj4/pbDLkuQ8srLjx0qMoqoJrdMcYNEDUrGJq/BbWSsuOUQ4ZerEVcrjDwe72SYnAAiM2bnqoyi/Zll45Tdzf9g3ts2IxtJK1j17OKwVjCm/jJFWlIPrS7EZ4gIraze2akegLfgTPNC/dL/ooUcChP5zdpgTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531819; c=relaxed/simple;
	bh=gpDYs7XwG2MOK8iGen6heUfirgyajDEaGvE4a+Hf2d4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eqgiVqjqYvX7upvBfBMRwpbsgTn0iCn9aY4N7lRCj6CpKMZN+RSplPI9pPbEbDVmOxTwPNOZXp+H0SAd6UoGNZI8/wyCuOaKpqqB0MjXE5WKeYiydncoUJ1VQADkaAmFJyHzMTIt5hCVr8pEUFtnC6dDaoPn/izTpQtWDkOR6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lu2PPtCI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lu2PPtCI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786531819; x=1818067819;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gpDYs7XwG2MOK8iGen6heUfirgyajDEaGvE4a+Hf2d4=;
  b=lu2PPtCIRd+1ZjxgKrkbZZRK8h+oZ3RA7GfHa2t+jF5RGbujHu3aXEkj
   3g8qBrrtNMw5+hsXcEL+nm79DL1bzN6HXCi+bXybIGka6qjdlYIeofAk9
   hSzZ5vn6IuDXaVZBSFAJNPfGSsdog4AKrwqWnlsypfdbOiQiFg6QJMOQf
   94HPVn9Du9GmML8XQdFI7fBGGDlvlq91dw9QotrZ7mJXB1Awgz7yIaAs/
   bJfJts4M3qCZvLXs4KJQWBn0gmepmWe77+O9ChTCMAdQu0CIbIFc9EKa2
   29+cOaZg97lI2yhPPH7nuE44LEiRiRQiabe3cb1orY1kuk/q16mrfWhQS
   w==;
X-CSE-ConnectionGUID: GIjc+UcvQfWhXBoZDrj2vg==
X-CSE-MsgGUID: RnpOSZXdSnCb60OLRa9FAg==
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="62017601"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2026 03:50:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 12 Aug 2026 03:50:16 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 12 Aug 2026 03:50:04 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <arnd@arndb.de>,
	<linusw@kernel.org>, <gregkh@linuxfoundation.org>,
	<mathieu.dubois-briand@bootlin.com>, <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH v7 0/7] Read MAC address from SST vendor specific SFDP region
Date: Wed, 12 Aug 2026 16:19:48 +0530
Message-ID: <20260812104955.485667-1-manikandan.m@microchip.com>
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

v6: https://lore.kernel.org/linux-devicetree/20260729043026.1811147-1-manikandan.m@microchip.com/

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

 .../bindings/mtd/jedec,spi-nor.yaml           |  20 ++
 .../layouts/microchip,sst26vf-sfdp-eui.yaml   |  60 ++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |   1 +
 MAINTAINERS                                   |   6 +
 .../dts/microchip/at91-sama5d27_wlsom1.dtsi   |  61 +++---
 .../dts/microchip/at91-sama5d27_wlsom1_ek.dts |   2 +
 arch/arm/configs/sama5_defconfig              |   1 +
 drivers/mtd/spi-nor/core.c                    |  78 ++++++++
 drivers/nvmem/layouts/Kconfig                 |  10 +
 drivers/nvmem/layouts/Makefile                |   1 +
 drivers/nvmem/layouts/sst26vf-sfdp-eui.c      | 182 ++++++++++++++++++
 11 files changed, 400 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/microchip,sst26vf-sfdp-eui.yaml
 create mode 100644 drivers/nvmem/layouts/sst26vf-sfdp-eui.c


base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
-- 
2.43.0

