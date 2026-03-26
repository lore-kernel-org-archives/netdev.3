Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84A2D7DEE
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557910; cv=none; b=J6Uuyb1O1zOa51ERBuULtF8IqNShdWErCv07hAPmKw2pkdwMsqGn0Qr6IGkdN9cIZFz603+7P5TAhYW2Mr3gl56xlKx30lisJXqyA4HNaQ7jsz7pEY7GClomTnUjD30rHqYf12AIPzONYmBGkqqq0EpNO/XcraHV/AbHwVksChs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557910; c=relaxed/simple;
	bh=A8Vv186XBmHJRcoqnKM+XynUbHzUn+KZwWgmTBD1Uos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fCCwPAlcC87XQpJZ1venOoOj1RHvcQUL1WULadkgZvBfMIqWrmAZZoeIe09IdW78yHqnXqOtihxTsTfqnNz/GPHPb0yGks0xlsvDlCiUHuTMfDb4bPl4ir/xDmElcXKRyKvDjHUDcxRYeaR+dR+UXxpLHK4TXtmQvg7r86W2kfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=QeCzl0nY; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=de0NzruM; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="QeCzl0nY";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="de0NzruM"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=QeCzl0nYFGIfZpruiqDsEjRyFT9amF5gvn4iTTBr4U7lLFHwvIpDAGH+mJ1ucF3GQMlBwlfzO9Tp+mr+qyuWvXcbwVvsr9/0qaZd3oqp+HtCuj9s6Witf9svUSDBsc1uon8inYJKwLAB/avGqwtNkg9QIjQWUz76zD3d/f6M6QeYH1JLuerGTWvqOvrqJ0bY8/zSRKs7Fex3qK7oTtbBdcz/8wDtTj60ANYl9/uG5vZqpRWwGdj4UXxZmeO2XsmsURML7/aJy4t8IKQDj7Owjp0b0KzT+dxtgjS+Wylng29tFTpVS6yVoWLTMLfwUFAKJwJ9aUtBjS9kEpKFWmeZwQ==; s=purelymail1; d=tinyisr.com; v=1; bh=A8Vv186XBmHJRcoqnKM+XynUbHzUn+KZwWgmTBD1Uos=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=de0NzruMuOOniEcXGL1lDoVvSMRcpnxFZY8/pejwSxTjcCSGI1tjoG+ibTf0UNIBfhBAU40BLKydafPoakrpK55trJOzdNCjYfsYfjQ1oU/5qcbGOJB6aVeAppplYh6LvRqSDWNwYJiZVMG4xenDKvK6dD6G9MsIckUEz1OMi023xFgjlutXt1CjMHadJLhz7wxD+pO3Vag3iURPZC7ee8omBAKdg2awVfI5CiO7crPirx6BvxA08thFsqeD3krDVfrxUU4sUu8i0sgS21lTYeIt3mINu/gSDk29dEmAnP6FOeqa1w6qISQo7MarbTqn4MJl03r5stkXvHdu5WCqug==; s=purelymail1; d=purelymail.com; v=1; bh=A8Vv186XBmHJRcoqnKM+XynUbHzUn+KZwWgmTBD1Uos=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1206586277;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 26 Mar 2026 20:44:29 +0000 (UTC)
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
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next 0/4] net: dsa: mt7628 embedded switch initial support
Date: Thu, 26 Mar 2026 22:44:09 +0200
Message-ID: <20260326204413.3317584-1-joey@tinyisr.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hello,

This patch series adds initial support for the MediaTek MT7628 Embedded
Switch.

The driver implements the basic functionality required to operate the
switch using DSA. The hardware provides five internal Fast Ethernet user
ports and one Gigabit port connected internally to the CPU MAC.

Bridge offloading is not yet supported.

Tested on an MT7628NN-based board.

Changes since RFC v3:
=09- remove labels from DT binding
=09- set ds->user_mii_bus if mdio node does not exist
Link: https://lore.kernel.org/netdev/20260321194340.2140783-1-joey@tinyisr.=
com

Thanks,
Joris


Joris Vaisvila (4):
  dt-bindings: net: dsa: add MT7628 ESW
  net: phy: mediatek: add phy driver for MT7628 built-in Fast Ethernet
    PHYs
  net: dsa: initial MT7628 tagging driver
  net: dsa: initial support for MT7628 embedded switch

 .../bindings/net/dsa/mediatek,mt7628-esw.yaml | 101 +++
 drivers/net/dsa/Kconfig                       |   7 +
 drivers/net/dsa/Makefile                      |   1 +
 drivers/net/dsa/mt7628.c                      | 637 ++++++++++++++++++
 drivers/net/phy/mediatek/Kconfig              |  10 +-
 drivers/net/phy/mediatek/Makefile             |   1 +
 drivers/net/phy/mediatek/mtk-fe-soc.c         |  50 ++
 include/net/dsa.h                             |   2 +
 net/dsa/Kconfig                               |   6 +
 net/dsa/Makefile                              |   1 +
 net/dsa/tag_mt7628.c                          |  92 +++
 11 files changed, 907 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/mediatek,mt76=
28-esw.yaml
 create mode 100644 drivers/net/dsa/mt7628.c
 create mode 100644 drivers/net/phy/mediatek/mtk-fe-soc.c
 create mode 100644 net/dsa/tag_mt7628.c

--=20
2.53.0

