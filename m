Received: from mail2.kuutio.org (mail2.kuutio.org [91.107.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E84A8FEB;
	Tue, 13 Oct 2026 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.107.195.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917814; cv=none; b=rwrQ20tAth/pSNSfeGCwFfL+c5hcWiGDCSI3R9rGJUY0XXoKRda0Q1a3OwVt49pmYtdy3tAYs6Um6PEZA02oK4Er861QKA4mopguBttOsoXM4I1dqTRt2JdtLnBqyZAH36k1qPhtjHt6Db3FZfQty4NvVWRVZd7TlYe6opDZ4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917814; c=relaxed/simple;
	bh=bnvH0XpzTsSggskR9d/7IjvJ5ltng9D5qvywkjibTns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BdcIcH0u4JPffazxTzM0kOMoOQ7Dn11O9znTmq65u0NF7C09pbR0eoZuDZUygCnuYTqT7vE+7fdzkjJCbwcR5uDNNxvoaROsQFtEhhxdbIE9+CDVXR0ZgaCmTDXwORvstnNqTWfgXz67r5DBn4UrDacx18QV2Ru9iC7zRHMK3+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net; spf=pass smtp.mailfrom=lemmela.net; arc=none smtp.client-ip=91.107.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lemmela.net
Received: from localhost (mail2.kuutio.org [127.0.0.1])
	by mail2.kuutio.org (Postfix) with ESMTP id DE6A720EFF;
	Tue, 13 Oct 2026 18:56:42 +0000 (UTC)
X-Virus-Scanned: amavis at kuutio.org
Received: from mail2.kuutio.org ([127.0.0.1])
 by localhost (mail2.kuutio.org [127.0.0.1]) (amavis, port 10024) with LMTP
 id hleBfKRbLbpz; Tue, 13 Oct 2026 18:56:41 +0000 (UTC)
Received: from muovi.kuutio.org (nbqchc6j3dhrbnnpubi-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:adc:6a00::8be])
	by mail2.kuutio.org (Postfix) with ESMTPSA id 05DC91FD41;
	Tue, 13 Oct 2026 18:56:39 +0000 (UTC)
From: Oskari Lemmela <oskari@lemmela.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Javen Xu <javen_xu@realsil.com.cn>,
	Marek Vasut <marek.vasut@mailbox.org>,
	Issam Hamdi <ih@simonwunderlich.de>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Jan Hoffmann <jan@3e8.eu>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manuel Stocker <mensi@mensi.ch>,
	Oskari Lemmela <oskari@lemmela.net>,
	dam.dejean@gmail.com
Subject: [PATCH net-next v3 0/2] Support unaligned RTL8224 PHY packages
Date: Tue, 13 Oct 2026 21:56:33 +0300
Message-ID: <20261013185635.1412452-1-oskari@lemmela.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RTL8224 packages contain four PHYs at consecutive MDIO addresses, but
their first address need not be a multiple of four. The Hasivo
S1100WP-8GT-2S+ uses two such packages at addresses 1-4 and 5-8.

This series adds a dedicated realtek,rtl8224-package binding and extends
the driver to use the explicit package base when provided. The
package-relative port index selects the MDI pair order and polarity
fields. Existing configurations without a package node retain the
aligned-address assumption.

The package-addressing change was tested on a Hasivo S1100WP-8GT-2S+
using an OpenWrt kernel. The rebased net-next version has not been
runtime-tested.

Changes since v2:
- Replace the additions to the shared RTL82xx PHY binding with a
  dedicated RTL8224 package binding. The example selects the package
  schema while the child PHYs retain their Clause 45 compatible.
- Clarify that unaligned layouts require a package node and that
  unused ports, including the first port, may be omitted.
- Limit the package base to 28 and each child address to the four-port
  range starting at that base.
- Use devm_phy_package_join() for both DT-described and legacy packages,
  avoiding mixed OF/non-OF package-node reference accounting.
- Share base-address parsing between probe and MDI configuration and
  derive the port offset without allocating per-PHY private state.

Changes since v1:
- Target net-next, as suggested by Andrew Lunn.
- Remove the Fixes tag and describe the change as extending support
  rather than fixing a regression.
- Rebase on net-next/main.
- Add a separate DT binding documentation patch with an unaligned
  four-port package example, placed before the driver patch.

v2:
https://lore.kernel.org/netdev/20261005201540.913977-1-oskari@lemmela.net/

v1:
https://lore.kernel.org/netdev/20261004204637.721148-1-oskari@lemmela.net/

Manuel Stocker (1):
  net: phy: realtek: support unaligned RTL8224 PHY packages

Oskari Lemmela (1):
  dt-bindings: net: realtek: add RTL8224 package binding

 .../bindings/net/realtek,rtl8224-package.yaml | 332 ++++++++++++++++++
 drivers/net/phy/realtek/realtek_main.c        |  56 ++-
 2 files changed, 379 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/realtek,rtl8224-package.yaml


base-commit: 8b4e7209c842d8cb9516f1f5ef0a88aa2d8831a6
-- 
2.55.0
