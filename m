Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622093;
	b=W1a9drF/3tE9kqyK2IEKrxNlxElX7n0zUnXmEsr4L3loF4mrmWGk2GKMJw6m7PTC/eOa
	 Y5gjF0ZFto4oyxGwxLhk4dqr1UBRdQ3//eP3S2ZZ/+pBcVbvqnu7obSgq3YjinZDCHPX4
	 3JT32xXiKv1d3//GGL4JxlMzwoNSbGDJSlg23Xn80wry/lO35EXsPbVJjDzM1fC5rNKoz
	 pUT3ic7Oyg/JjSsayWZ1Z1cQtyiZQ/SCgPAvLZNBn+FaEmFaGELKFWPMyzVMVpnJcK7Q6
	 3QFJ2CZQ52hc2XnFYKdwQQtXDJp9lXJCbiT+cUqHOMgbpyOsMbRNk0JqWapnceGvDJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622093;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=26Ew83+7Mi3ZWEYZMN+jfH4zJjxT0j2F/U0mB+W/3K4=;
	b=FxZL7TAp4GP3XVyY7CdDWCQ/z8Bp+LIr1x5hlnrArj3Klc7ld2xkU42Yfw9hIe6UNuTd
	 wXLgCaDs4V54Xkp+Fdqxp3MDUWQgRKJq535fPJXrmj79BwpWwEa/vyRLwRxRGxhCddOeu
	 wWlu7oArHyvy2g3rdFal+2yMyquR4oaE3PUtuI56whC3HWI2WHNm0Xv81j6B+mH2VpSm0
	 LncwO9BdP4uNSKbBkBwRV2rNjPcjq3cRrTorJDxO2K0Tp37NLMoX8uWLNRi37MzdNg3Rt
	 0iv0FiGo45+Fb9zO41AnDAAgkbasVrr9uxaxSfFhvjOi+st31wSJ0+tu6krg611YyFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b="S4SStrx/";
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8127606A32E;
	Mon,  2 Nov 2026 12:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8127606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=S4SStrx/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793622092; x=1825158092;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=WC3JV8Hpsc3JuumgJF2EtoGz1qp8MrT/ss4vVUWAba8=;
  b=S4SStrx/AOR1iIxMk0fMu0MrjhELEOsipuQjo1KLoUk/M3yHP2dgknnP
   RBkc+d+8YpDX+VORQq8fRwK5qtjbmhrSYPN2IPZpsQw9IPxJwF5Pn6eeu
   LgPatl81NGhBEIqryFYxAKHg7K+Lsr+e5n3IAcxkuY+GnXMSlphfxA5t1
   A7DlgTmiPWHMw8HdZVl+gufix6wDAegxQedy63+R52vp8qvkliUVj2w+Q
   jyhJvl6v20aukJjrhLSZTwL+26HDrsNsdIxRdCT/a9VXO5aPY2cZuxbZM
   N1v5zfeTrpxnEAY1+q5NG6s9NMsqIoIk+ptTlkkLQNqtffGLapdjwdBxh
   A==;
X-CSE-ConnectionGUID: kCVTsL9wSd+CRTjxzCZkwg==
X-CSE-MsgGUID: V3Q7uwtKTvSiBD14TgXmaA==
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="232950948"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2026 05:21:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 2 Nov 2026 05:21:31 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 2 Nov 2026 05:21:29 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v2 0/5] net: sparx5: add tc matchall port policer
 offload
Date: Mon, 2 Nov 2026 13:21:23 +0100
Message-ID: <20261102-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v2-0-3bd47ec1b227@microchip.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEOA6GoC/5WOQQqDMBREryJ/3V+SVGPTVe9RXKTxWz9oIomIR
 bx7U3uCbgZmBubNBokiU4JbsUGkhRMHn406FeB661+E3GYPSigtzEXgs8TBeqP1ipNj7NrRYpp
 sXKtfbnIe4pxlYEcxYVmXWoq60qQ05NkpUsfrgXyApxk9rTM0uek5zSG+jy+LPPovVgph/scuE
 gWWRupaXG1NVt1HdjG4nqezCyM0+75/AMItLvf+AAAA
X-Change-ID: 20260930-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-474610756e26
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <robert.marko@sartura.hr>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
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
This matches lan966x and ocelot. The policer meters each frame without
preamble and inter-frame gap, so the configured rate is a data rate, as
tc police expects and as on lan966x and ocelot.

Since the policer meters all ingress frames on the port, only filters on
chain 0 with protocol all are offloaded, and filters on shared blocks
are rejected. A police action that is already offloaded as a port
policer on another port is rejected too, since in software it is a
single bucket for all of its users. Only drop is supported as the exceed
action, and the police overhead parameter is not supported.

Patch #1 drops a redundant prefix from the existing POL_UPD_INT_CFG
register macros.

Patch #2 adds the registers used by the port policer.

Patch #3 tracks whether the ingress block of a port is shared, and adds
the per-port policer state.

Patch #4 adds the hardware programming of the port policer.

Patch #5 adds the tc matchall offload.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v2:
- Patch #4: meter the data rate, not the line rate, by setting the gap
  to 0 instead of 20 bytes. Fix the commit message, which wrongly said
  that lan966x and ocelot meter the line rate.
- Patch #4: take queue_stats_lock around the existing ethtool read of
  port stat counter 0, since reading the LSB latches the MSB.
- Patch #4: correct the comment on the traffic type mask.
- Patch #4: reject a packets-per-second police as unsupported before
  checking for a missing byte rate, so the right message is reported.
- Patch #5: reject a police action that is already offloaded as a port
  policer on another port.
- Link to v1: https://lore.kernel.org/r/20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v1-0-4916708a7ea2@microchip.com

---
Daniel Machon (5):
      net: sparx5: Drop redundant POL_ prefix from POL_UPD_INT_CFG
      net: sparx5: Add registers used by the port policer
      net: sparx5: Track shared tc blocks and per-port policer state
      net: sparx5: Add hardware programming for the port policer
      net: sparx5: Offload tc port policers via matchall

 .../microchip/sparx5/lan969x/lan969x_regs.c        |   7 +
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |   6 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |   6 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  39 +-
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 117 +++++-
 .../net/ethernet/microchip/sparx5/sparx5_police.c  | 431 ++++++++++++++++++++-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.c |   4 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |   7 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |   7 +
 drivers/net/ethernet/microchip/sparx5/sparx5_tc.c  |  14 +-
 .../ethernet/microchip/sparx5/sparx5_tc_matchall.c |  39 ++
 11 files changed, 663 insertions(+), 14 deletions(-)
---
base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
change-id: 20260930-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-474610756e26

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

