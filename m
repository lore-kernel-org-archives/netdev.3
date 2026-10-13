Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4135218AB;
	Tue, 13 Oct 2026 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911574; cv=none; b=S9LONYQRJCsw88I+u4JuZNva343NBPbGEtfOja0Is6C2cmBN86FGgRimGmBayo09Q+m+PSuUnt23GErL/UkW4kQxtqnY+PWA3v9u96belaoY7KrnwtJwVwO4l2RNhTIIuBVWT4HubgrV5HqQex7dc1L1KO7CJbyG3D+6kAMJpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911574; c=relaxed/simple;
	bh=N9YboAI3l9JLB3r7z572GPOgLzaT9hJb2bn87VaEfsY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZB0Fh8hYBpBSha9fJ14MvBa0SjUXl0xAN7x785xpSYSe/qsq/ZNJRPUCjhUoi4xPzNoVLvddR5Zt7Y5bKkoXtwGhNyuriWVN7MQ2xbOqcmYSLSalvVfTvakqrlxHa8gFMA93xKtbHWf+gzTc5grJ8lkqiE65DTqa2Dq2/m02pGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B4542000F0;
	Tue, 13 Oct 2026 19:12:51 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4ECED2000EB;
	Tue, 13 Oct 2026 19:12:51 +0200 (CEST)
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 83166202DA;
	Tue, 13 Oct 2026 19:12:50 +0200 (CEST)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: netdev@vger.kernel.org
Cc: s32@nxp.com,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v2 0/5] net: enetc: S32N79 pseudo-MAC (PPM) networking support
Date: Tue, 13 Oct 2026 20:12:44 +0300
Message-Id: <cover.1791908694.git.claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This series adds networking support for the ENETCv4.4 pseudo-MAC (PPM)
ports found on the NXP S32N79 SoC. On S32N79, the ENETCv4 ports are
not wired to any external PHY/MII; instead they are internal "pseudo-MAC"
links into the on-chip NETC switch. These links are proprietary, expose
no standard IEEE interface, and run at a speed fixed at boot time by the
Port PCR[PSPEED] register.

A key use case is a port that has no "ethernet" DT node at all: NETC is
reached over PCI from a host that probes the ENETC, while the internal
NETC switch it connects to is not owned by Linux. Such a port must have
its fixed link synthesized at probe time.

The driver synthesizes the fixed link directly in C using an of_changeset:
of_changeset_create_node() adds a "fixed-link" subnode onto the PCI
function's dynamic OF node (CONFIG_PCI_DYNAMIC_OF_NODES), with the "speed"
property read from PCR[PSPEED] at probe time and "full-duplex" set.
phylink then picks up the fixed-link node through dev_fwnode().

The series touches three subsystems:
  - net/enetc:  pseudo-MAC fixed-link support + probing of 4.4 devices
  - arm64 dts:  NETC IEP18 ECAM node on S32N79 and its RDB board enable
  - PCI:        a quirk creating the OF node for the ENETC PMAC functions

Because this is primarily a networking feature and the pieces are
interdependent at runtime, it would be most convenient to merge the
whole series through the netdev tree.

Patch 1 has a runtime (not Kconfig) dependency on
CONFIG_PCI_DYNAMIC_OF_NODES; absent that, the pseudo-MAC probe path
fails gracefully with -ENODEV.

v2:
 - Switched patch 1 from a DT overlay blob (of_overlay_fdt_apply() + a
   .dtso compiled to .dtbo) to of_changeset_create_node(), per review
   feedback. This drops the embedded overlay externs, the Makefile
   .dtbo wrapping, and the OF_OVERLAY Kconfig dependency. The operating
   speed is now baked directly into the changeset-created fixed-link
   node (read once from PCR[PSPEED] at probe time); the phylink
   get_fixed_state callback is no longer needed and was removed.
 - Patch 2: described why there are two ENETC PF IDs in the commit
   message, as per review.
 - Patch 3: replaced the 'msi-parent' stub property with 'msi-map', as
   per H/W spec.
 - Patch 5: reworded the commit message to match patch 1's fixed-link
   approach (no functional change); added Bjorn's Acked-by.
v1: initial submission.

Claudiu Manoil (5):
  net: enetc: Add pseudo-MAC support for ENETCv4 Ports via a fixed-link
    node
  net: enetc: Enable probing of version 4.4 devices
  arm64: dts: s32n79: add NETC IEP18 ECAM node for ENETC PPM ports
  arm64: dts: s32n79-rdb: enable NETC IEP18
  PCI: Create OF node for NXP ENETC pseudo-MAC functions

 arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |   4 +
 arch/arm64/boot/dts/freescale/s32n79.dtsi     |  24 ++++
 drivers/net/ethernet/freescale/enetc/enetc.c  |  12 ++
 drivers/net/ethernet/freescale/enetc/enetc.h  |   1 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 113 +++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
 .../freescale/enetc/enetc_pf_common.c         |  41 ++++++-
 .../freescale/enetc/enetc_pf_common.h         |   1 +
 drivers/pci/quirks.c                          |   2 +
 9 files changed, 190 insertions(+), 9 deletions(-)

-- 
2.34.1

