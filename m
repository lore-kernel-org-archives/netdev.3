Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A412F7F13
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647831; cv=none; b=AKc+JXO1TghMV0ulBgT6s5jCz6wAKU24W9Qrc3LU2bEiTu2sEQ6clfiAXiSnYtD+2FhL337mZkLxExiVUJlz8O0DiUKFwCOX3NPqhczRa5m45w/2C87CcUmmikGnJ60UBAS2HolI4Y/L2PzS0s3FGh5UzZZk/cla0Qt5ZZFQbhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647831; c=relaxed/simple;
	bh=h4fLtGo7L69mVcw54e0Pb54zpPd24shJdWWvb7gIyyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uSXJejPp7yyeBUKkza+j5GgiaPA3BhmY4CBH60tdZTgRrGPmjZqS862vq+38PKApRU0GJSLw3pXXXsgKXb8ruNjqunIUsazZy/bQOFTn1Y/ferAB8F1Gmw/rcFu3epwJ8EWEptQLRxQeZGVBMYeiDwJWwFfG/xihkwSt+Lb+DY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=sA30iXCX; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=hSuRYtde; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="sA30iXCX";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="hSuRYtde"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=sA30iXCXWlrQXllzr8GkR3qhzjT+hclWF8Uw2QVWa+3ehVo8fuuG9640Znfnk9Pzp3HC6GDx/mTV40xwzRu/k3GUOeu2Ppg/Xyhc7+Nck3R8+kNTJthxAQs36/K5nB605dFg97agccZqcRP9LD3UWNVYZ5C9213Uuzj59Nmwc8sWI4eH92ocSxvaOBxCDGX1tQuHz3QYg95FkyJZFRkpD9+VW4M9ImA7L4gKMfnzY7wy6pzgkXvukgIHuZyg8+1H3Xy718eq3F9dKAlvfGJkbCFZWcOoQqfv8PbMreY8XBmNSL1p1U2CaC39+XObntj0noJotNj1+ePH4lCyjOtR7Q==; s=purelymail3; d=tinyisr.com; v=1; bh=h4fLtGo7L69mVcw54e0Pb54zpPd24shJdWWvb7gIyyE=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=hSuRYtdev1Zd1tMy/7jBRWsW1ugClYYHqZNSZk6zgh+C+Q1tkMFmwoPgn8ccpr1dqvvlkmIuwhb3AZ4tmcoJ13Yeyj+3/OZiCmOrjcGJFrzHrEytARl5JTRJqBqNYI24eFPkWNYAtvrmK8JMCZipf+7WIuz1mgXCahSE6JjhuAL+HxwTetWZY1MCw/IMKFmqJkGKNX7XY6wGXllYM8dt+nfIIVoSVKHs6KJv5mA+9LiKwZUEBFo5IdhBwXpwgaN7fFPf77ZjcygES7dyZjr1e4rQKGklFCpB9qTZGjvgNotqkwisy5/yk7QxGCrItz9yRUXTJ3G1jYoO53t1AJxuNA==; s=purelymail3; d=purelymail.com; v=1; bh=h4fLtGo7L69mVcw54e0Pb54zpPd24shJdWWvb7gIyyE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1221505461;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 13 Aug 2026 19:03:46 +0000 (UTC)
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
Subject: [PATCH net-next v7 0/4] net: dsa: mt7628 embedded switch initial support
Date: Thu, 13 Aug 2026 22:02:37 +0300
Message-ID: <20260813190241.789323-1-joey@tinyisr.com>
X-Mailer: git-send-email 2.55.0
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

Bridge offloading is not yet supported, but due to the CPU to switch
link being Gigabit and all the user ports being Fast Ethernet, software
bridging is a practical solution for the initial driver.

Tested on an MT7628NN-based board.

Changes since v6:
=09- added depends on HAS_IOMEM && (SOC_MT7620 || COMPILE_TEST) and
=09  select REGMAP_MMIO to NET_DSA_MT7628 kconfig entry
=09- added comment about all ports being disabled by reset in
=09  port_enable function
=09- added depends on SOC_MT7620 || COMPILE_TEST to MEDIATEK_FE_SOC_PHY
=09  kconfig entry
=09- added genphy suspend and resume features to mtk-fe-soc driver
=09- rebased on net-next
Link: https://lore.kernel.org/netdev/20260704105659.140970-1-joey@tinyisr.c=
om/t/#u

Changes since v5:=20
=09- updated tag_mt7628 to kfree_skb() on error in receive path
=09- removed Reviewed-by tags from tag_mt7628
=09- removed mmio base pointer from mt7628_esw since it's only used to
=09  initialize the regmap
=09- rebased on net-next
Link: https://lore.kernel.org/netdev/20260613181845.111877-1-joey@tinyisr.c=
om/t/#u

Changes since v4:
=09mt7628 dsa driver:
=09=09- updated mdiobus allocation to use ds->dev instead of esw->dev,
=09=09  matching other DSA drivers (no functional change)
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
 drivers/net/dsa/Kconfig                       |  10 +
 drivers/net/dsa/Makefile                      |   1 +
 drivers/net/dsa/mt7628.c                      | 652 ++++++++++++++++++
 drivers/net/phy/mediatek/Kconfig              |  11 +-
 drivers/net/phy/mediatek/Makefile             |   1 +
 drivers/net/phy/mediatek/mtk-fe-soc.c         |  52 ++
 include/net/dsa.h                             |   2 +
 net/dsa/Kconfig                               |   6 +
 net/dsa/Makefile                              |   1 +
 net/dsa/tag_mt7628.c                          |  93 +++
 11 files changed, 924 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/mediatek,mt76=
28-esw.yaml
 create mode 100644 drivers/net/dsa/mt7628.c
 create mode 100644 drivers/net/phy/mediatek/mtk-fe-soc.c
 create mode 100644 net/dsa/tag_mt7628.c

--=20
2.55.0

