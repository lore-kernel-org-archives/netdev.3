Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42EA41D635;
	Tue,  6 Oct 2026 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294687; cv=none; b=h+rE498H7TSCZj2wPuwj+l998WqFkbkYY4orN9VWw5qpQE4Nk99nAdRy2GwP8AeOyNNa+X4d4qqBU5yNBw+uApec+LyHwjAlPZ1CEbn0DLd/pIqnQa2CX67cHI9zsbIxklbXQvFnaw9AQRRA1jkzvJtH3oP3TCTovjXQI1nQHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294687; c=relaxed/simple;
	bh=v9lEBvjdaqO6XwdYDIqvh1dxR9AHhNinpBUAg9b7Qhw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=HTgxM9gbL9i8SdrtyJujH5ptTZhpdFv+TPcZ28NIjVhOZYcgsLMyIuBkVyQe9B5euLTbC9czFIAReU2eksUD4sKy8UhfhkfxiMcSIHa2tgwaqXeVnN2zem4JQ7zfG0jwlh91oWiQFbGLwj8PxsfSrlVLOGaJUOb/NkY2NjRcsTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hhQPo4EV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hhQPo4EV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791294685; x=1822830685;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=v9lEBvjdaqO6XwdYDIqvh1dxR9AHhNinpBUAg9b7Qhw=;
  b=hhQPo4EV/JpbIxJ0jtYRCeoDpR80s++ZsaTeA0F5lygaUl3epxNnm1bJ
   qBxk5Z0aYQ7fQbwPmnT+C77bGOkIuNYShEwSBFwRzOTENEi2D4v9WTYmf
   tXlcwgIx2xkGBudnMKNXH/TcHVGKxPwgXA1Zh/9oibFwlar8At1HnifQC
   XRhXldS/palrSIGXVNYrIobjNyt6NdxZu6wrjq8yFcP8tdmIXH6bxVeVu
   U2bKj8m6toBN9jps4kIuvte/4/2LPNQwZ7ElJ7Y+Jlb47bj4z+q/fgDBE
   9v+AoDF+S2BM/zE+4UUmoaeFqWfGj+IZsshux2lGTa/IvrxBYZCbP2nST
   g==;
X-CSE-ConnectionGUID: +wFIaA0USQyKvtmAKQmJ9w==
X-CSE-MsgGUID: IYhRJQgaSj+cmdGukXM8WA==
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="231742330"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2026 06:51:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 6 Oct 2026 06:51:24 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 6 Oct 2026 06:51:22 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next 0/3] net: sparx5: add TAS offload
Date: Tue, 6 Oct 2026 15:51:05 +0200
Message-ID: <20261006-sparx5-tas-v1-0-5eef1126dfd5@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMn8xGoC/x3MMQqAMAxA0atIZgNpwApeRRyKjZqlSlOkIN7d4
 viG/x8wySoGU/dAlltNz9Tg+g7WI6RdUGMzMLF3RB7tCrkOWIIhUxRmR+NIEVpwZdm0/rMZkhR
 MUgss7/sBfcsIHGYAAAA=
X-Change-ID: 20261006-sparx5-tas-20de2210770d
To: Daniel Machon <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Richard Cochran <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Robert Marko <robert.marko@sartura.hr>
X-Mailer: b4 0.14.3

This series adds offload of the Time Aware Shaper (IEEE 802.1Qbv),
configured through tc-taprio, on Sparx5 and lan969x, which are both
served by the sparx5 driver.

In hardware, a TAS schedule is run by a TAS list, which steps through
gate control list (GCL) entries taken from a pool shared by all ports.
Sparx5 has 128 lists and 10000 GCL entries, lan969x has 60 lists and
3000 entries. An idle list is in the ADMIN state. Once started, it is
PENDING until its base time, then OPERATING. A stopped list is
TERMINATING until the end of its cycle, and then goes back to ADMIN.

The driver uses two lists per port, so a new schedule can be set up in
one list while the current one keeps running in the other. When the
new list reaches its base time, the hardware stops the old one.

The two chips differ in how a list addresses its entries: on Sparx5 a
list is a contiguous range addressed relative to its base, on lan969x
it is a linked list addressed by absolute pool index. The driver
handles both.

Frame preemption is not supported yet, and every queue uses the
default guard band of 1536 bytes. Making the guard band follow the MTU,
and taprio queueMaxSDU, are left for a follow-up.

Patch #1 adds the registers used by TAS.

Patch #2 moves the existing TAS link speed configuration to a new
sparx5_tas.c.

Patch #3 adds the taprio offload.

---
Daniel Machon (3):
      net: sparx5: Add registers used by TAS
      net: sparx5: Move TAS link speed configuration to sparx5_tas.c
      net: sparx5: Add TAS offload support

 drivers/net/ethernet/microchip/sparx5/Makefile     |   2 +-
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |   2 +
 .../microchip/sparx5/lan969x/lan969x_regs.c        |  10 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |   2 +
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  28 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 204 ++++++
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.c |  53 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.h |   1 -
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |  10 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |  10 +
 drivers/net/ethernet/microchip/sparx5/sparx5_tas.c | 806 +++++++++++++++++++++
 drivers/net/ethernet/microchip/sparx5/sparx5_tc.c  |  17 +
 12 files changed, 1094 insertions(+), 51 deletions(-)
---
base-commit: a5e7d8e446af9803e37a3b6a4d416fb41178348f
change-id: 20261006-sparx5-tas-20de2210770d

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

