Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558DC36D9E9;
	Fri,  3 Jul 2026 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064805; cv=none; b=IiwyrVxf2LS369+xYU7mWLVDRS3XVf4J2e0Aeo3pn03XQ3VJRTnL5Jfpd1LpsnamUFn+ETDsphoVQWkTDIaEtwGwvs99kf4BT3IRoV50f8kSOXVxUYbZV6beQHN/XRW619vaOi0lpEVwOXSFvVCaAMKji059EaB9uCCFAMxVQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064805; c=relaxed/simple;
	bh=E/n71tfBeXMreQ5j5FcVNbsmMGH4GRHm8HlUFHurLTM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F/Q16Mb+oG2DFN8+rFLUB3Ccvj33xkKnFzkgn+1BiMMS7WiIQJXDZTNStGw/O3FPSPJH+JRkuFhwnuQmc3NIzIoXjQWvz8H1LVrhjR+4weUBvo1yy5mIaByYxeGibGGMU+wfPNjb9K6PQzOzuK7QwkpjAFkDeZU5RrO4NLO7c0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=AKet1qXo; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="AKet1qXo"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id D068160C04;
	Fri,  3 Jul 2026 03:46:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064803; bh=bSeScTgkF1wlE04uhDKWHgET2Y222X2hoz1k9Bxl6kg=;
	h=From:Subject:Date:To:Cc:From;
	b=AKet1qXoExQwhVMIEeUFfeFS0xbfwQf37LI4d9BykDcbKPFPVImqH5a5c4z+8dXyU
	 MGficMyAl5If+8WGitzsi7J77s7UQYjbw7gZ+gaaHxTLNGNjbMbxPNOVvVUeDPbzhY
	 WgCwg9nlw41X9WPE/YHCJGHzBSSQczHYd9feCzOHjEzhJQnf8PycjBq/U0jj7o23bt
	 u9pEOOzpcYH7ji2G4gCJ2S3LN2iz6lorjquGtpuRmTiog0IqFNTJiqhuMkMEDsAqfn
	 n3jovkhMHdGnOb7uaFwCff5+KmPJG5ABCKo2C5LinVu1/Ln9YMpqIvh5RdcTSYYai5
	 bE+bX87zbpuzA==
From: Luke Howard <lukeh@padl.com>
Subject: [PATCH net-next 00/17] net: dsa: mv88e6xxx: support for Remote
 Management Unit
Date: Fri, 03 Jul 2026 17:46:34 +1000
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANpoR2oC/zWMQQrCMBBFr1Jm7UASMQavIi7a9KsjNEqSloHSu
 xsVF3/x+Ly3UkEWFDp1K2UsUuSZGthdR/HepxtYxsbkjPPG2z0n1DatPC0hwKsq52lmNw72GNw
 BEYaa/Mq4in7DZ/o7dPk9ZR4eiPXTpW17A1RH3GaEAAAA
X-Change-ID: 20260613-net-next-mv88e6xxx-rmu-2db17825ece0
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Florian Fainelli <f.fainelli@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Max Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, 
 Kieran Tyrrell <kieran@sienda.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=2446;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=E/n71tfBeXMreQ5j5FcVNbsmMGH4GRHm8HlUFHurLTM=;
 b=302qDTqv0UAb2iVuN0F74rHpNRwaq7hGZkrv8TkWWPqMUNfRQBFshgwGPOjJ+kOB0yFNfidGr
 oWAw85yr9uFArfOu+O3rFZpuOT2rv7EGcS3K0C0To+YCs+OjvAxhDdn
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

This patch set shephards a series of commits made by Andrew Lunn
and others to support remotely managing Marvell switches over
Ethernet (as opposed to MDIO) using the Remote Management Unit
(RMU).

This is the second of four patch sets: the remaining two add
support for remote management when MDIO is unavailable.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
Andrew Lunn (11):
      net: dsa: tag_dsa: Add helper to add DSA header to RMU frame
      net: dsa: mv88e6xxx: Add conduit state change handler
      net: dsa: mv88e6xxx: Remove mv88e6xxx_rmu_setup()
      net: dsa: mv88e6xxx: Add connect_tag_protocol handler
      net: dsa: mv88e6xxx: Add sanity check of received RMU frame
      net: dsa: mv88e6xxx: Get Product ID when enabling RMU
      net: dsa: mv88e6xxx: Add RMU register read/write/wait for bit
      net: dsa: mv88e6xxx: Move available stats into info structure
      net: dsa: mv88e6xxx: Centralise common statistics check
      net: dsa: mv88e6xxx: Get some MIB stats via the RMU
      net: dsa: mv88e6xxx: Time RMU operations and disable if slow

Luke Howard (4):
      net: dsa: mv88e6xxx: use lockdep_assert_held() if CONFIG_LOCKDEP
      net: dsa: mv88e6xxx: cancel PTP polling work on .shutdown
      net: dsa: mv88e6xxx: size ATU snapshot buffer and region by num_macs
      net: dsa: mv88e6xxx: RMU DUMP_ATU support in devlink

Mattias Forsblad (2):
      net: dsa: mv88e6xxx: Introduce Marvell dsa tagger data operation.
      net: dsa: mv88e6xxx: Add RMU enable/disable for select switches.

 drivers/net/dsa/mv88e6xxx/Makefile  |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c    |  92 ++++--
 drivers/net/dsa/mv88e6xxx/chip.h    |  35 +++
 drivers/net/dsa/mv88e6xxx/devlink.c |  71 +++--
 drivers/net/dsa/mv88e6xxx/global1.c |  64 ++++
 drivers/net/dsa/mv88e6xxx/global1.h |   3 +
 drivers/net/dsa/mv88e6xxx/global2.c |   1 +
 drivers/net/dsa/mv88e6xxx/ptp.c     |  14 +-
 drivers/net/dsa/mv88e6xxx/ptp.h     |   5 +
 drivers/net/dsa/mv88e6xxx/rmu.c     | 611 ++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/rmu.h     | 145 +++++++++
 include/linux/dsa/mv88e6xxx.h       |  11 +
 net/dsa/tag_dsa.c                   |  67 +++-
 13 files changed, 1073 insertions(+), 47 deletions(-)
---
base-commit: 165539241e210db8e962479c3c5072372576b618
change-id: 20260613-net-next-mv88e6xxx-rmu-2db17825ece0

Best regards,
--  
Luke Howard <lukeh@padl.com>

