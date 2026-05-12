Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFA33A2E3A
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591201; cv=none; b=S/0doVaAWfW4fSpwG9eKOz7SQBqANSk/2mHQcaa+R3yuM6b9vo8H0SKlr5jJkVic5+chfiikqW4mAdAJ63105UgBz2rxMf9qRCDYGTzyJSj+w1fa5cNH44hprHwCCDIMPGKzgsnVA+s4cO7F6ZiLk3k5/L4Y6hYHY4DbbC7DSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591201; c=relaxed/simple;
	bh=ZxdpVpIkIQWn2exfGsLljIHTPpE160PL4emDIZb/CE4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=STK2jxCPSa1xgbpVNkls4fRjqtldmk+5gxQ/t4OfLQ5F2crhNQ1qN3WHdlgjb6ryBO+HQyTWOf/DEFem9vj4mCAnKK/ALaV40YEWNq0IXrNE+vnuoF8Kf8B/cofOzrum7vlYv/p6XvI0n4nAEEaTbq33UzXElZif+XfjP/s6nY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mSX5eA6L; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mSX5eA6L"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2E2794E42C19;
	Tue, 12 May 2026 13:06:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EBD0760646;
	Tue, 12 May 2026 13:06:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4EC4C11AF876D;
	Tue, 12 May 2026 15:06:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778591194; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=7OHxdT9tWXwmNyU9dGIuLoR/ft56evCPaFK7QoqG7IE=;
	b=mSX5eA6LmqbxD9f5w0cksR9kmBoF181KaYAERUiIfmw6OjLaXoeZSToaMVeaX4FKqjkg+F
	17de7jClPCqkA29ikb/OWCSbNTpcy+IyMx0T0W7Mt+jPHO/avUN5K5VIPdKSART8t9Vcv9
	6+biiRVvFaIQLMo46wGeSkqkwZ3QQvsmOH1sfonHv87nRm7/CscOipE8HHYMbZLq7KdMFj
	wwiHTbwYL7+SwVyLv+GzCcVwPstOneiu27WZ6qm/uQhLvshf7xpmDUzB0RhQietZ7QQVlw
	K0bAIHWH6gLVyn5eZcE56tJaFz14l2PirR5YpDZq+PJAcrw3vH1dTN7DDw6P7A==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next 00/15] net: dsa: microchip: Remove unnecessary
 ksz_dev_ops callbacks
Date: Tue, 12 May 2026 15:06:22 +0200
Message-Id: <20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM8lA2oC/yWN0QrCMBAEf6XcswdJSpT6K9KHmm71UE5NUikt/
 XeDeRyG2d0oIQoSnZuNIr6S5KUF7KGhcB/0BpaxMDnjjsZby+GJQfmRVnY6cq25vZ68R+i6MBk
 q6TtikuU/eyFFZsWSqa8m4jOXn1x1v+8/LmbIEoUAAAA=
X-Change-ID: 20260511-clean-ksz-2nd-series-3b755ec99cf0
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

This series continues the rework of the KSZ driver initiated by a previous
series (see [1]), following the discussion we had here [2].

The KSZ driver got way too convoluted over time because it uses a common
framework to handle more than 20 switches split in 5 families (see below
table)

+----------+---------+---------+---------+---------+---------+
| Family   | KSZ8463 | KSZ87xx | KSZ88xx | KSZ9477 | LAN937X |
+----------+---------+---------+---------+---------+---------+
| Switches | KSZ8463 | KSZ8795 | KSZ88X3 | KSZ8563 | LAN9370 |
|          |         | KSZ8794 | KSZ8864 | KSZ9477 | LAN9371 |
|          |         | KSZ8765 | KSZ8895 | KSZ9896 | LAN9372 |
|          |         |         |         | KSZ9897 | LAN9373 |
|          |         |         |         | KSZ9893 | LAN9374 |
|          |         |         |         | KSZ9563 |         |
|          |         |         |         | KSZ8567 |         |
|          |         |         |         | KSZ9567 |         |
|          |         |         |         | LAN9646 |         |
+----------+---------+---------+---------+---------+---------+

The previous series ([1]) replaced the unique dsa_swicth_ops struct used
by all the KSZ families with one dsa_switch_ops struct for each family.

These dsa_switch_ops structs still rely on common functions that redirect
the calls to ksz_dev_ops operations which are custom to each switch
family. Many of hese ksz_dev_ops callbacks have a direct equivalent in the
struct dsa_switch_ops. This series directly connects the implementations of
these ksz_dev_ops operations to the relevant dsa_switch_ops attribute
to get rid of one unnecessary level of indirection.

On top of this on-going rework I added PTP and periodic output support for
the KSZ8463 (which was my first goal). There are more than 60 patches for
all this so this series will be followed by several others and if you
want to see the full picture we can check my github ([3]).

I haven't finished yet to group all the patches into meaningful series
but here is more or less what I plan to do next:

- A series will split again some operations to get rid of the
  if (is_kszXYZ) branches.
- Maybe another series will be needed to completely move out of
  ksz_common.c everything that isn't truly common to all the switches
- A series will add PTP support for the KSZ8463
- A final series will add periodic output support for the KSZ8463

[1]: https://lore.kernel.org/r/20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com
[2]: https://lore.kernel.org/r/20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com)
[3]: https://github.com/bastien-curutchet/linux/tree/ksz_rework

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (Schneider Electric) (4):
      net: dsa: microchip: remove unused phylink_mac_link_up() callback
      net: dsa: microchip: bypass dev_ops for port_setup()
      net: dsa: microchip: call DSA's phy_{read/write} to do mdio {read/write}
      net: dsa: microchip: bypass dev_ops for phy_read()/phy_write()

Vladimir Oltean (11):
      net: dsa: microchip: bypass dev_ops for FDB ageing operations
      net: dsa: microchip: bypass dev_ops for change_mtu() operation
      net: dsa: microchip: bypass dev_ops for VLAN operations
      net: dsa: microchip: bypass dev_ops for FDB and MDB operations
      net: dsa: microchip: bypass dev_ops for mirror operations
      net: dsa: microchip: bypass dev_ops for phylink_get_caps()
      net: dsa: microchip: don't reset on shutdown or driver removal
      net: dsa: microchip: bypass dev_ops->setup() and teardown() for lan937x
      net: dsa: microchip: bypass dev_ops->setup() and teardown() for ksz9477
      net: dsa: microchip: bypass dev_ops->setup() and teardown() for ksz8
      net: dsa: microchip: remove dev_ops->setup() and teardown()

 drivers/net/dsa/microchip/ksz8.c         | 406 ++++++++++++++++++++-----------
 drivers/net/dsa/microchip/ksz9477.c      | 288 ++++++++++++++++------
 drivers/net/dsa/microchip/ksz9477.h      |  23 +-
 drivers/net/dsa/microchip/ksz_common.c   | 385 ++---------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  85 +------
 drivers/net/dsa/microchip/lan937x_main.c | 207 +++++++++++-----
 6 files changed, 663 insertions(+), 731 deletions(-)
---
base-commit: 1df461e527477068e5f3773e645d555120704be6
change-id: 20260511-clean-ksz-2nd-series-3b755ec99cf0

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

