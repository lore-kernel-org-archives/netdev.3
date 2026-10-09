Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963B3CE489;
	Fri,  9 Oct 2026 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550152; cv=none; b=fyX3e0cfEj9v5ueoC9/GQq6nCQsaBlmdmBfg2zx4DaE8SGOl5mOTsqi+Df5hXkesjZ9nfJ+9IvCEhdRu7HhZ06PCRhvdI5YB9nOXCJiXhN8cRQxohD3GlDP5ptxyDOO2rIzCT1w1CYsow4V13KnAbuCXR0Fw88NhIsDcU2rtYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550152; c=relaxed/simple;
	bh=XI4Ekq5uN1tv5Vxv9u2qHb0Mmnx6aKfDsexGYsVBuGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CfzMEuNJLSJt4gMbeRlMvozk7aJzD3QRcOZ6CHVcNqHkbBwhChBZiG6nAKJOPLq9rQe1H3xI7W8ZXZ41gdtB3OBr68fwyjXVkRnMqxN/C9bQ+lBSpyjQ4BkfDbTp1pjY1w2ivle41LwlnGkdPwZ7f5zZEtHxztE3VYv1UAzcaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C973200320;
	Fri,  9 Oct 2026 14:40:36 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 60305200099;
	Fri,  9 Oct 2026 14:40:36 +0200 (CEST)
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 15FED2037D;
	Fri,  9 Oct 2026 14:40:35 +0200 (CEST)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: netdev@vger.kernel.org
Cc: s32@nxp.com,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v1 0/5] net: enetc: S32N79 pseudo-MAC (PPM) networking support
Date: Fri,  9 Oct 2026 15:40:29 +0300
Message-Id: <cover.1791548316.git.claudiu.manoil@nxp.com>
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

Rather than hand-building a software node, the driver describes the
fixed link with a self-contained DT overlay (following the lan966x PCI
approach), applied unmodified via of_overlay_fdt_apply() onto the PCI
function's dynamic OF node (CONFIG_PCI_DYNAMIC_OF_NODES). phylink then
picks up the fixed-link node through dev_fwnode(); the real operating
speed is sourced live from PCR[PSPEED].

The series touches three subsystems:
  - net/enetc:  pseudo-MAC overlay support + probing of 4.4 devices
  - arm64 dts:  NETC IEP18 ECAM node on S32N79 and its RDB board enable
  - PCI:        a quirk creating the OF node for the ENETC PMAC functions

Because this is primarily a networking feature and the pieces are
interdependent at runtime, it would be most convenient to merge the
whole series through the netdev tree.

Patch 1 has a runtime (not Kconfig) dependency on
CONFIG_PCI_DYNAMIC_OF_NODES; absent that, the pseudo-MAC probe path
fails gracefully with -ENODEV.

v1: initial submission.

Claudiu Manoil (5):
  net: enetc: Add pseudo-MAC support for ENETCv4 Ports via a DT overlay
  net: enetc: Enable probing of version 4.4 devices
  arm64: dts: s32n79: add NETC IEP18 ECAM node for ENETC PPM ports
  arm64: dts: s32n79-rdb: enable NETC IEP18
  PCI: Create OF node for NXP ENETC pseudo-MAC functions

 arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |  4 +
 arch/arm64/boot/dts/freescale/s32n79.dtsi     | 24 +++++
 drivers/net/ethernet/freescale/enetc/Kconfig  |  1 +
 drivers/net/ethernet/freescale/enetc/Makefile |  1 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 12 +++
 drivers/net/ethernet/freescale/enetc/enetc.h  |  1 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 98 +++++++++++++++++--
 .../freescale/enetc/enetc4_pseudo_mac.dtso    | 32 ++++++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  1 +
 .../freescale/enetc/enetc_pf_common.c         | 41 +++++++-
 .../freescale/enetc/enetc_pf_common.h         |  1 +
 drivers/pci/quirks.c                          |  2 +
 12 files changed, 209 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_pseudo_mac.dtso


base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
-- 
2.34.1

