Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884789;
	b=mczBQtuNEbYg97yyIOBytEaCsY2QITSaGZnH3MGjG2SVOTjJj70NxIKM4r6YYVfDncbq
	 f0QQ8HNFM8bhBTSOAz/E3O6gTEY0JcRHpslTAUDR4bAcPcEbc+Bv/ZxtmwaSjX35C34OX
	 4cjT/u1H5YS9mQ1BSUAUgg8mJUlVtsUMfkbT2irFUEcySwbr/aPmsIvkMtFI0/zPg5aQS
	 BTeMtUQ9CHFj+dLql/dTwgI+vJOIgUkwU9TEukMfrtjPiY3b+M9k0QHlcrZktgBooy4Uy
	 eUADQZxLtUuikoZC/JE+bc2+fHWFlXh2IvRyqiet6IWxnZiPR9h8VqR2UDuC30gbpNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884789;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=+m9RT7968WtHnxAjfDqAkmFJdjtt1Ew321JDDBClL2U=;
	b=1qWg2xMrss006hS4EmZD9MQkRiKdT2Ay3knjJGaWxwmRljTv+tSMKGmxJED2uwOoYbTi
	 YZ5z+RvTzUI+h5y2W/DDgPWqClAGo4GUIKG3WoNp3f0hvnTPgOR9o4hq1jjOJscI/MinR
	 sHEtFezlQ4J0FposwlFf8ktiA7pf90bQ0WjjZHtGTci92MTPBcVOHsQY4QhkgQF1di6qy
	 gT6pY+TPwgHDi6l5/xvI8tkau5VrzCPv9jg30wWthg2tZgm/52sb79zrHWRLUSN8KX5i7
	 IzSWYssEuQ81XJcoqgNlE+E6NBx0H/TkOn5VkY+uQ50OV/vboLD+nAbYxvo+QWrSlWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=YpequSpP;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E17606A32D;
	Thu,  5 Nov 2026 13:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8E17606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=YpequSpP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793884795; x=1825420795;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=bP8qyqJblAFa/8/WKXRBh/BDhS3ZOxXRh6pYul7fS0I=;
  b=YpequSpPjtgBdb6R6A5wD2mnpUVmIAEUnWIzLHBoh2cBjKKnob5Ffrbt
   3mfz/NgJkaUpg7d0UZXQJqNC297xFrstgdk5PV44ZY185fwiM1nD10DeH
   V7bUskkgHMjX0kjfM9We0n88w7FxtMUTokjJbcxt/OmqjQV02Cyr252/j
   +2aGSMO2ikXGVz+erCjumuLhTyJF4o3xnJlv+Q6GG7CbFwNVp14Mm64FL
   EQ9O85uRe9mipWDldiBDE5s+t4IiK6iAN+5eBfUww66juco6mP0CeAHoq
   VDDCKAiiWHn7QG/Xn8iPqbhU+0A+lTKkeKCpCdUxz5Zs9DmH5de0FsjaR
   A==;
X-CSE-ConnectionGUID: IEs8SPjMSvGA7kui+ZQDyg==
X-CSE-MsgGUID: mXhmQBDTQsm7Rr3TrlWfkw==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="233135318"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:19:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 06:19:47 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Nov 2026 06:19:45 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v3 0/5] net: sparx5: add tc matchall port policer
 offload
Date: Thu, 5 Nov 2026 14:19:34 +0100
Message-ID: <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-0-b45a3a26bed5@microchip.com>
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
X-B4-Tracking: v=1; b=H4sIAGaC7GoC/53OwWrDMAwG4FcpPk9DVlx73mnvMXpwHHURNHawQ
 8goefd62WGw23YR/PpBn+6qchGu6vV0V4VXqZJTC93TScUxpA8GGVpWhGTRdwi9gVtI3toN5ih
 wHaYAdQ5lO3/vfdvnsrRxk8ilgnHGanRny2RVOzsXvsp2kO8q8QKJt0VdWjNKXXL5PH5Z9dF/s
 RrR/51dNSAYr63Dl+A40NskseQ4yvwc83SAK/0gGukfCDWk6wfjOOqeyP1G9n1/AMKMmoBjAQA
 A
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
Changes in v3:
- No changes, resubmitted because of missing sashiko-nipa check on v2.
- Link to v2: https://lore.kernel.org/r/20261102-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v2-0-3bd47ec1b227@microchip.com

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
base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
change-id: 20260930-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-474610756e26

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

