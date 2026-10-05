Received: from mail2.kuutio.org (mail2.kuutio.org [91.107.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6665531714A;
	Mon,  5 Oct 2026 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.107.195.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231823; cv=none; b=GiD7K6uLz3KOZjPLcgVWhuZsvFHTqEo2K3hR3jwMwOGhwCfGdt5CF32ZUBVpTAwb3eZnNLLfgq5/sSFNLYp8mN/UF4cnwn0VKCWCZTB9Qlv4s4uWvE/SCOD3drhoCqh+6ZXaHuhGfQi4/a0J4O6hBDw3009/qGjLtaf2Fa/dups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231823; c=relaxed/simple;
	bh=miP2jVdaSSEmcRSnUanYI1fm8lLKcxXEn09+4uSO2N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTyajNaPQbHGQrByNmtVDSXCr1XpGOROQBUT+p/Eu8wuav/0Y024+nN1EDneUfUJcwonhX50iB8wx/fMitR8+wiCBhiEVehc6lYcxIB5uBFn4nN5ilu/aeqUiMIrMLV1eUzGAj/HyX9fLVgzQXyrwmd47chcCE4qd6ydP4bukTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net; spf=pass smtp.mailfrom=lemmela.net; arc=none smtp.client-ip=91.107.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lemmela.net
Received: from localhost (mail2.kuutio.org [127.0.0.1])
	by mail2.kuutio.org (Postfix) with ESMTP id BADC920F04;
	Mon,  5 Oct 2026 20:17:19 +0000 (UTC)
X-Virus-Scanned: amavis at kuutio.org
Received: from mail2.kuutio.org ([127.0.0.1])
 by localhost (mail2.kuutio.org [127.0.0.1]) (amavis, port 10024) with LMTP
 id CVZDsY7fl8hU; Mon,  5 Oct 2026 20:17:18 +0000 (UTC)
Received: from muovi.kuutio.org (nbqchc6j3dhrbnnpubi-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:adc:6a00::8be])
	by mail2.kuutio.org (Postfix) with ESMTPSA id DE8B61FD40;
	Mon,  5 Oct 2026 20:17:17 +0000 (UTC)
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
	Javen Xu <javen_xu@realsil.com.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
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
	Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH net-next v2 0/2] Support unaligned RTL8224 PHY packages
Date: Mon,  5 Oct 2026 23:15:38 +0300
Message-ID: <20261005201540.913977-1-oskari@lemmela.net>
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

This series documents how to describe RTL8224 packages using the existing
ethernet-phy-package binding and extends the driver to use the explicit
package base when provided. The package-relative port index selects the
MDI pair order and polarity fields. Existing configurations without a
package node retain the aligned-address assumption.

The package-addressing change was tested on a Hasivo S1100WP-8GT-2S+
using an OpenWrt kernel. The rebased net-next version has not been
runtime-tested.

Changes since v1:
- Target net-next, as suggested by Andrew Lunn.
- Remove the Fixes tag and describe the change as extending support
  rather than fixing a regression.
- Rebased on net-next/main
- Add a separate DT binding documentation patch with an unaligned
  four-port package example, placed before the driver patch.

The driver behavior is unchanged from v1; the rebase only updates patch
context.

v1:
https://lore.kernel.org/netdev/20261004204637.721148-1-oskari@lemmela.net/

Manuel Stocker (1):
  net: phy: realtek: support unaligned RTL8224 PHY packages

Oskari Lemmela (1):
  dt-bindings: net: realtek,rtl82xx: document RTL8224 packages

 .../bindings/net/realtek,rtl82xx.yaml         | 52 +++++++++++++++++--
 drivers/net/phy/realtek/realtek_main.c        | 49 +++++++++++++++--
 2 files changed, 93 insertions(+), 8 deletions(-)


base-commit: 8b4e7209c842d8cb9516f1f5ef0a88aa2d8831a6
-- 
2.55.0
