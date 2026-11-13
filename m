Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.32.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583013;
	b=ZtRju6mY2ENuZ3RQrJtMOslqWCJ+FGc4RGMk436ELehOLTKpiLk7/AbgaLRSffQV0QN5
	 reqfgcYxroFpxIC1LwGybYaf9KBHhveXnLp+h53nEj5jlsINcLOYqwjvA5/ZB4roYWdbn
	 h41zuWh2B/seqSmV8FFJK7lRkGbusnJUR1j0J2ZILfzYb7Rcj1kuLkslV0xR/rTvNWyZM
	 jBmJyj8a+zqV3vkhEdlNLLg+8h2z9RIlRS4IbdSRirTlADsggUUh8Kj0cYO73XJWeyz0T
	 t4fCohcaM9tlJv/BqpaVUiGOwgQh+iKbo4iqxdzKdCQa6YSw7EfdFHwUjXzbU8sODRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583013;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Kk2gJ7wcF7/2L1X8IwAHhLjVDaseQemAe/zD32tkLAE=;
	b=XCKmv7AVB6G6BrbVkzYgO/A24mqovZYBo8faz8EZCod5n8l+vJYS+TAwguOO8JnJLlOS
	 mMOrtEjdXeR/zasTomv/CsmFiYi0/Urj6R8xFbPD2lhcrgvFOCkdKITovpAN4zBWjseTI
	 Mwlazb9cZLSwZ6d+L0mcVZcZq95+rJPLoZHHSqdxE8aYCS6EWPG+uSVLMoRHeEg5xWopC
	 3zZWyMkOw9fqZcOpazglA4MjUrmwnYT+i3Xk14Uj3U/kXjrvqco6R3IO7pdI8rANKF1Sc
	 3e0eEchGj1XxqnQrXzJohpa8uks8Z7h6c3ZWonDeoTX2Q+WzLQXg/BOmyxBwPYXD5PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=rLxQ2p8N;
	arc=none smtp.remote-ip=92.121.32.55
Received: from inva130.nxp.com (inva130.nxp.com [92.121.32.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0F606A886;
	Fri, 13 Nov 2026 15:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54B0F606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=rLxQ2p8N
Received: from localhost (localhost [127.0.0.1])
	by inva130.nxp.com (Postfix) with ESMTP id CFA8B608895F;
	Fri, 13 Nov 2026 16:12:33 +0100 (CET)
X-Virus-Scanned: amavis at nxp.com
Received: from inva130.nxp.com ([127.0.0.1])
 by localhost (inva130.nxp.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FHoNgRoMwA3X; Fri, 13 Nov 2026 16:12:32 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva130.nxp.com (Postfix) with ESMTP id 73BDD6030CE5;
	Fri, 13 Nov 2026 16:02:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva130.nxp.com 73BDD6030CE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
	s=nselector2; t=1794582159;
	bh=Kk2gJ7wcF7/2L1X8IwAHhLjVDaseQemAe/zD32tkLAE=;
	h=From:To:Cc:Subject:Date:From;
	b=rLxQ2p8NhZwCksadVtfsDEcnilQ/o6YOeWZIWHGg/F9fdHTqD6Hf0CBG69GQW3UdJ
	 uAXgtwkeMH0+uq+XoPNFbM3ehGEc8ZLoz7WlgwJKEs1sGR0kCexyxIkxE0vBd/W3ZM
	 d6REO4cvMx3IJJfkurkSNpSqG9moCXHhc64/b6RBLjlulXYbH04DvCAW2FOzh21rIx
	 CUJgZjtt5G06b+MsdorJzQFg+EItBbilRKn76q3fElz1+TaQQCpd98XeBXTrL5aIBK
	 PYyBcCzd/5D4EsQgrpOoBvDlKPRti2mntF3qYbbDTd22/oG2+guPKFb5GtX5xzo9lv
	 XjMgPw2crB3Sg==
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 89993202B6;
	Fri, 13 Nov 2026 16:02:38 +0100 (CET)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: netdev@vger.kernel.org
Cc: s32@nxp.com,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v4 0/6] net: enetc: S32N79 pseudo-MAC (PPM) networking support
Date: Fri, 13 Nov 2026 17:02:31 +0200
Message-Id: <cover.1794581338.git.claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
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
  - net/enetc:  pseudo-MAC fixed-link support, probing of 4.4 devices
                and a fix for more than 6 ring interrupt vectors
  - arm64 dts:  NETC IEP18 ECAM node on S32N79 and its RDB board enable
  - PCI:        a quirk creating the OF node for the ENETC PMAC functions

Because this is primarily a networking feature and the pieces are
interdependent at runtime, it would be most convenient to merge the
whole series through the netdev tree.

Patch 1 has a runtime (not Kconfig) dependency on
CONFIG_PCI_DYNAMIC_OF_NODES; absent that, the pseudo-MAC probe path
fails gracefully with -ENODEV.

v4:
 - Patch 1: made NXP_ENETC4 depend on OF, as OF_DYNAMIC is only
   available with OF; improved the commit message.
 - Patch 2: new, allocates the int_vector array dynamically to prevent
   an out-of-bounds access on S32N79.
 - Patch 3: clarified the commit message.
 - Patches 4-6: no changes.
v3:
 - Patch 1: fixed the CONFIG_OF_DYNAMIC dependency, refactored
   enetc4_add_ppm_fixed_link() as per Wei's feedback, and improved the
   commit message.
 - Patch 3: added sysclk_freq info for the v4.4 ENETC devices.
 - Patches 4-6: no changes.
v2:
 - Switched the fixed-link patch from a DT overlay blob
   (of_overlay_fdt_apply() + a .dtso compiled to .dtbo) to
   of_changeset_create_node(), per review feedback. This drops the
   embedded overlay externs, the Makefile .dtbo wrapping, and the
   OF_OVERLAY Kconfig dependency. The operating speed is now baked
   directly into the changeset-created fixed-link node (read once from
   PCR[PSPEED] at probe time); the phylink get_fixed_state callback is
   no longer needed and was removed.
 - Described why there are two ENETC PF IDs in the commit message, as
   per review.
 - Replaced the 'msi-parent' stub property with 'msi-map', as per H/W
   spec.
 - Reworded the PCI patch commit message to match the fixed-link
   approach (no functional change); added Bjorn's Acked-by.
v1: initial submission.

Link: https://lore.kernel.org/netdev/cover.1793712309.git.claudiu.manoil@nxp.com/

Claudiu Manoil (6):
  net: enetc: Add pseudo-MAC support for ENETCv4 Ports via a fixed-link
    node
  net: enetc: Allocate int_vector array dynamically
  net: enetc: Enable probing of version 4.4 devices
  arm64: dts: s32n79: add NETC IEP18 ECAM node for ENETC PPM ports
  arm64: dts: s32n79-rdb: enable NETC IEP18
  PCI: Create OF node for NXP ENETC pseudo-MAC functions

 arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |   4 +
 arch/arm64/boot/dts/freescale/s32n79.dtsi     |  24 ++++
 drivers/net/ethernet/freescale/enetc/Kconfig  |   2 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  34 ++++++
 drivers/net/ethernet/freescale/enetc/enetc.h  |   3 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 109 +++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   4 +-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   2 +
 .../freescale/enetc/enetc_pf_common.c         |  41 ++++++-
 .../freescale/enetc/enetc_pf_common.h         |   1 +
 drivers/pci/quirks.c                          |   2 +
 11 files changed, 214 insertions(+), 12 deletions(-)

-- 
2.34.1

