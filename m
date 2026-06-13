Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C82F99BD
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781374814; cv=none; b=XPQ6yUuVXOT5oQwruJXoAY53oWREZ0KSEFGzIMbZntWBLD16exRyznBZSFIz0JDNGFs5o+zh8gqT39oMyOcB1BAKaK7AJw8zI1uf+HzwJnZRbNkukdJw39atZky73eXfbd7cN6oBI9S/D+CcCpkRjDbtdpQ/ze0nfAb08ZithJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781374814; c=relaxed/simple;
	bh=+utTWZs6M5NXkqDr6efGi+oVl4ef1snX8eibw7QTZmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fpLBptC6W9GNW84OmYmFzvTcYfMaILyiSFuIsY4GtYrx4vU35mnl6jVg7dddLYAwzaQw8DWKAC+yIIk4DQfxCR/jQdfHBgC8k4xOTXrKkPowpKumnlleYZR5kopPENBxMAllj9/avsiM/RnXHCOqcg9sgkS9ubqZOlyIisc8GSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=g4xFdcLk; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=gnOnIeZa; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="g4xFdcLk";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="gnOnIeZa"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=g4xFdcLkvaTuKnFclQAjGD/5FAUC6oS7XJLBFPn8VUM799KpOi1or9bavNkChrfaWE2UPN4XsU6WDNgzyxdb9trODhUX8pswdYRPnFGnJ805p5581kp8O/a7X7mhUilEQAG9tnXXY3vvLRoPHnp7z3eqYh3K6jGQdIZSBVdAzuGLSWUy5NG1LqCY1OqTFRJHevn3b2botsDqoN+BzysY3i1HBWjwh0aS0zDmsxh6tNlPB1CZ5VlUel34G/wBt9LRfEuDCpVwJ+6YT2aH21XnAPQYDm11fYUftr5qLE6MKuyn85DaAcDt6m+YVn7VleLE0Zf9v9GJUNhEXmJYyKgkJQ==; s=purelymail3; d=tinyisr.com; v=1; bh=+utTWZs6M5NXkqDr6efGi+oVl4ef1snX8eibw7QTZmk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=gnOnIeZaWd7JwgIZIFF19x8z9EuBc4e4HXtWXccrMKO0Mu/8I04p+omsjZyCbp3LouJTt3qyHkWsqdEmZRztNqVbHSlyNX7cwei1KMgaw1G0qgZa5MHaVnuyAw21MbeNUcz577rZQ1/5iBDDmFjOFxyP1y/rUGl+8h/XJg3p3RGd+I6mWQ/XtL3K8nIltPAGiRoAzl1TeQJxwfC4Xs5XFCZFRztQANu7YAMNSYVxeyaSxgyrzRCLJ6JvW531d8GtoDmfHRQQ/PzXCkRs/8L3UM2QldTe6iyx2PMvERPpbiS5ql4Dak8b2ZpPRtaxJtLEZMGekYXDYc8+JxMDQLBQ/A==; s=purelymail3; d=purelymail.com; v=1; bh=+utTWZs6M5NXkqDr6efGi+oVl4ef1snX8eibw7QTZmk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1738339834;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 13 Jun 2026 18:20:02 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next v5 0/4] net: dsa: mt7628 embedded switch initial support
Date: Sat, 13 Jun 2026 21:18:41 +0300
Message-ID: <20260613181845.111877-1-joey@tinyisr.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

This patch series adds initial support for the MediaTek MT7628 Embedded
Switch.

The driver implements the basic functionality required to operate the
switch using DSA. The hardware provides five internal Fast Ethernet user
ports and one Gigabit port connected internally to the CPU MAC.

Bridge offloading is not yet supported.

Tested on an MT7628NN-based board.

Changes since v4:
=09mt7628 dsa driver:
=09=09- fixed mdiobus allocation tied to platform device while
=09=09  being initialized in DSA switch setup
=09mt7628 phy driver:
=09=09- replaced phy_write() with phy_modify() when setting PHY init
=09=09  bit (no functional change)
=09mt7628 dt binding:
=09=09- moved unevaluatedProperties after required block
=09=09- removed blank line between compatible and reg in example
Link: https://lore.kernel.org/netdev/20260608192948.289745-1-joey@tinyisr.c=
om/t/#u

Changes since v3:
=09- rebased on latest net-next
=09mt7628 dsa driver:
=09=09- simplified vlan_add hardware vlan slot search
=09=09- fixed vlan_del not removing vid from port pvid
=09=09- separated mii_read/mii_write error handling from return
=09=09  value parsing. Updated RD_DONE/WT_DONE bit checking
=09=09  with clearer logic and a comment.
=09=09- moved NET_DSA_MT7628 after NET_DSA_MT7530 in Kconfig
=09=09- added missing reset return value checks in probe
=09=09- fixed mt7628_switch_ops missing const specifier
=09=09- removed mdio node parsing from of, as there is nothing
=09=09  to configure
=09mt7628 dt binding:
=09=09- updated description to be more clear about port count
=09=09- dropped optional mdio subnode. the switch does not
=09=09  expose an external MDIO bus and all integrated PHY
=09=09  access is handled by the driver.
=09=09- removed unused switch0 label in example
Link: https://lore.kernel.org/netdev/20260428185510.261521-1-joey@tinyisr.c=
om/t/#u

Changes since v2:
=09- fix binding issues found in review
=09- fix ignored dsa_tag_8021q_register return value
=09- add switch teardown to clean up tag_8021q
=09- fix ordering issue where mdio probe fail would leak tag_8021q
Link: https://lore.kernel.org/netdev/20260330184017.766200-1-joey@tinyisr.c=
om/t/#u

Changes since v1:
=09- changed port 6 phy-mode to internal
=09- cleaned up tag_mt7628 rcv function and mask defines
=09- fixed sorting error in drivers/net/dsa/ Kconfig and Makefile
=09- fixed sorting error in net/dsa/ Kconfig and Makefile
=09- fixed mt7628_mii_read/write return values on error
Link: https://lore.kernel.org/netdev/20260326204413.3317584-1-joey@tinyisr.=
com/t/#u

Thanks,
Joris

Joris Vaisvila (4):
  dt-bindings: net: dsa: add MT7628 ESW
  net: phy: mediatek: add phy driver for MT7628 built-in Fast Ethernet
    PHYs
  net: dsa: initial MT7628 tagging driver
  net: dsa: initial support for MT7628 embedded switch

 .../bindings/net/dsa/mediatek,mt7628-esw.yaml |  96 +++
 drivers/net/dsa/Kconfig                       |   8 +
 drivers/net/dsa/Makefile                      |   1 +
 drivers/net/dsa/mt7628.c                      | 649 ++++++++++++++++++
 drivers/net/phy/mediatek/Kconfig              |  10 +-
 drivers/net/phy/mediatek/Makefile             |   1 +
 drivers/net/phy/mediatek/mtk-fe-soc.c         |  50 ++
 include/net/dsa.h                             |   2 +
 net/dsa/Kconfig                               |   6 +
 net/dsa/Makefile                              |   1 +
 net/dsa/tag_mt7628.c                          |  89 +++
 11 files changed, 912 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/mediatek,mt76=
28-esw.yaml
 create mode 100644 drivers/net/dsa/mt7628.c
 create mode 100644 drivers/net/phy/mediatek/mtk-fe-soc.c
 create mode 100644 net/dsa/tag_mt7628.c

--=20
2.54.0

