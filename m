Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E634D0CC1;
	Fri,  9 Oct 2026 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546849; cv=none; b=FKPCVEn8fJXX14OdPT7d157wckK//QjPVaQ13UG6S9mt6knZ27fPPuPZ/rZPAlGea3V7aTxKDpqi9GtS0Sp4xq2VY6Wngv4C69B5A2aCa3O/cN/k8ykUjiaHy9/akl7AO/JOU43JJFtbo4RNvCwKh9njS/aGQz7xaw9aR8uRwKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546849; c=relaxed/simple;
	bh=taFyZ5t12GbWm2zzYISSWlCvN0RZfDZunnQWmHBdvZM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=OxjFcWD8C2psj++nxYEdU2z5DZD54SD3twGHcPRFbZKKpSOZ8RcyfhPlxHBtJAErfJ36bTKjTId6FdS++MxRokcwcvUGVCEiYuOcHl+/z+9VEYE2ZUiwGgKQW8qHsM4/NoHWsMhc4EzUpyb0DuV+1OzRIwQ/iiBULfYMcaYtnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=H4vNo3j1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="H4vNo3j1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791546840; x=1823082840;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=taFyZ5t12GbWm2zzYISSWlCvN0RZfDZunnQWmHBdvZM=;
  b=H4vNo3j17Y1z3cfip4ZbqORMbyFSfN8M3PBYCEy0SHu6HYBfzH4/592m
   t//7usQK1lUfk1lG3sN1IN0Fpv7F/1TMBSXJhFDjuPjW8AKvQWSeq3D4s
   PCpeWNA7gl2Aa0fe1ORALYtngIcwVolv32O98MkkHHtcVCdz+tMjkdcWT
   TTZkIueS1RONvjPvXhfrZ3s+zbOFAofUMc7vr+6KyC5H+P/qdFL2Beilv
   0L10oi3NlAR0gxuFj3TTYsOsrH9YmEkkmky9v8keMwyTPNtM0q3u5xDFB
   oMgsgDg/zfhO0Xthev4MOsLDLEoirhsVa6lb3emR4OY+ioWaFKmoG3a2Q
   w==;
X-CSE-ConnectionGUID: GPvI4pCYQRmkWyhqC5R3CA==
X-CSE-MsgGUID: G1G6WGXmSJCr5loWVLf/2w==
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="231901784"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2026 04:53:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 9 Oct 2026 04:53:59 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 9 Oct 2026 04:53:57 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next 0/5] net: sparx5: add tc matchall port policer
 offload
Date: Fri, 9 Oct 2026 13:52:00 +0200
Message-ID: <20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v1-0-4916708a7ea2@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGDVyGoC/yWNQQqDMBBFryKz7kC0cSS9SnGRxrEdsDFMQgmId
 29oNx/eW7x/QGYVznDrDlD+SJY9NugvHYSXj09GWRrDYAYy7mrwYXHz0RFVTEFwXd4ec/Jax79
 3ze9a2mwSWDPayVJvppF4IGjZpLxK/V3eIXLByLXAfJ5fc0ZWVowAAAA=
X-Change-ID: 20260930-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-474610756e26
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Daniel Machon <daniel.machon@microchip.com>
X-Mailer: b4 0.14.3

This series adds offload of tc matchall filters with a police action to
the ingress port policers of Sparx5 and lan969x, which are both served
by the sparx5 driver.

In hardware, each ingress port has four single-rate leaky bucket
policers. A policer drops the frames that exceed its rate and burst.
The four policers of a port share the pass and drop statistics counters
of the port.

The driver uses one policer per port, because with more than one, the
statistics reported to tc could not be attributed to the right policer.
This matches lan966x and ocelot. The policer meters each frame
including 20 bytes of preamble and inter-frame gap, so the configured
rate is a line rate, also as on lan966x and ocelot.

Since the policer meters all ingress frames on the port, only filters on
chain 0 with protocol all are offloaded, and filters on shared blocks
are rejected. Only drop is supported as the exceed action, and the
police overhead parameter is not supported.

Patch #1 drops a redundant prefix from the existing POL_UPD_INT_CFG
register macros.

Patch #2 adds the registers used by the port policer.

Patch #3 tracks whether the ingress block of a port is shared, and adds
the per-port policer state.

Patch #4 adds the hardware programming of the port policer.

Patch #5 adds the tc matchall offload.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (5):
      net: sparx5: Drop redundant POL_ prefix from POL_UPD_INT_CFG
      net: sparx5: Add registers used by the port policer
      net: sparx5: Track shared tc blocks and per-port policer state
      net: sparx5: Add hardware programming for the port policer
      net: sparx5: Offload tc port policers via matchall

 .../microchip/sparx5/lan969x/lan969x_regs.c        |   7 +
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |   1 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |   6 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  36 +-
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 117 +++++-
 .../net/ethernet/microchip/sparx5/sparx5_police.c  | 404 ++++++++++++++++++++-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.c |   4 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |   7 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |   7 +
 drivers/net/ethernet/microchip/sparx5/sparx5_tc.c  |  14 +-
 .../ethernet/microchip/sparx5/sparx5_tc_matchall.c |  38 ++
 11 files changed, 627 insertions(+), 14 deletions(-)
---
base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
change-id: 20260930-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-474610756e26

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

