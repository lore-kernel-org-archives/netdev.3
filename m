Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.32.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714961;
	b=Fw3EsGl0Lon05amV9lObwzec3cFLyI+2ggThHYws21XrLAXgUaspoKbxYnmAQiJTsM+w
	 wqOXsLLhdjqix2dTv3YZa3Ch/PVGOnBw68x+Zo6Uw/w2U59RUWEDVsB3FISSd5ArRj+av
	 kN5hZzPQGP2thNhnPpoVfj7Luk6itPxMId1GPvUu+qdAra+N/q+AurF6eDRjmgSqQFeTP
	 6QbkJtug+bm0N6TxWZ60fK2vdAsTQu6cqYBkC4NI1D8qVfceZSEnbUDooUx7NQ00I/zGi
	 Cy99DXoEgyHpHKC59jp0N+H5phybb8ewlTC/uGVYUwxjRFyn5/hVl2xUrM4YsuT0R8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714961;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OgSB2dLpNlVg6m8t+Mucq+MCmoGh3nhFHSqkGHmNRqM=;
	b=Of18uZoRTAGnRVTrN2bw82JQjhi/R5HPrUb5dD6FmJPhb72oUXy92DkSF3MvOh2cCQ+r
	 zBIE0Kr3DHZ1hfX0S0CGU6Yv9qIjNlBIXHELFatlZ4ABa3WgioDiVr9ZWSzHFq2Qn2RfN
	 YDe1TdFKEX1A5eVV7qbA8bwNO7qDQrmzKpgwk2xB4nz7vSSzKtD44WUsLtRoNIp0BRz9/
	 d4ScyBIztI5FaYzLWqwMW36Qif7zgEpPRstQV0CAhokL3fUGUuWGZ3mpnouYA4Zl1Fmn9
	 70FUeeXttne7WjTUX91lyxlaWR8iap38OY1HbGkQIFnFFSo3P9j9Y2ExOct3LGJSdXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=NBsR73Do;
	arc=none smtp.remote-ip=92.121.32.54
Received: from inva129.nxp.com (inva129.nxp.com [92.121.32.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FCB606A32C;
	Tue,  3 Nov 2026 14:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36FCB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=NBsR73Do
Received: from localhost (localhost [127.0.0.1])
	by inva129.nxp.com (Postfix) with ESMTP id 058A260000B9;
	Tue,  3 Nov 2026 15:09:14 +0100 (CET)
X-Virus-Scanned: amavis at nxp.com
Received: from inva129.nxp.com ([127.0.0.1])
 by localhost (inva129.nxp.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V0_MSZfE6aKZ; Tue,  3 Nov 2026 15:09:13 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva129.nxp.com (Postfix) with ESMTP id 75F26600009F;
	Tue,  3 Nov 2026 15:09:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva129.nxp.com 75F26600009F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
	s=nselector2; t=1793714953;
	bh=OgSB2dLpNlVg6m8t+Mucq+MCmoGh3nhFHSqkGHmNRqM=;
	h=From:To:Cc:Subject:Date:From;
	b=NBsR73DoN5Cj8DrvwHiGKj4Y4InQjSibwVevXoNk7vjlRi1LX30HzSE3zTnW0c+Dr
	 trkPs4PzKwC7Uql0MrIRLZTs6XGh+Rw5niKOcvDnqpaUuCgwg8Lx2p01PNSZQBISM3
	 LXHKNYFhp0cnrWDeLYLqQ2ULQrvpwQIMNriYLt8VxRMZRBwHJByVK8ELOF0AMaxHBF
	 X8M0uTp3LoM9EvEbyKAZR/sveE6/VvSuVTApq4YgZVpcWuYuWpg8aUk6DYQdThDkDT
	 /UvfHkaRpNseqJ8H17hNpYEagOkNqBBYGsiG9QVf7vTLcFfsdg7aUucfgEnLuVp6Gs
	 EOMRemYbuajSw==
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id EE84A202AF;
	Tue,  3 Nov 2026 15:09:12 +0100 (CET)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: netdev@vger.kernel.org
Cc: s32@nxp.com,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v3 0/5] net: enetc: S32N79 pseudo-MAC (PPM) networking support
Date: Tue,  3 Nov 2026 16:09:06 +0200
Message-Id: <cover.1793712309.git.claudiu.manoil@nxp.com>
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
  - net/enetc:  pseudo-MAC fixed-link support + probing of 4.4 devices
  - arm64 dts:  NETC IEP18 ECAM node on S32N79 and its RDB board enable
  - PCI:        a quirk creating the OF node for the ENETC PMAC functions

Because this is primarily a networking feature and the pieces are
interdependent at runtime, it would be most convenient to merge the
whole series through the netdev tree.

Patch 1 has a runtime (not Kconfig) dependency on
CONFIG_PCI_DYNAMIC_OF_NODES; absent that, the pseudo-MAC probe path
fails gracefully with -ENODEV.

v3:
 - Patch 1: fixed the CONFIG_OF_DYNAMIC dependency, refactored
   enetc4_add_ppm_fixed_link() as per Wei's feedback, and improved the
   commit message.
 - Patch 2: added sysclk_freq info for the v4.4 ENETC devices.
 - Patches 3-5: no changes.
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
 drivers/net/ethernet/freescale/enetc/Kconfig  |   1 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  26 +++++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 109 +++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   4 +-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   2 +
 .../freescale/enetc/enetc_pf_common.c         |  41 ++++++-
 .../freescale/enetc/enetc_pf_common.h         |   1 +
 drivers/pci/quirks.c                          |   2 +
 10 files changed, 204 insertions(+), 10 deletions(-)

-- 
2.34.1

