Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607C0377ED7;
	Mon,  3 Aug 2026 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752106; cv=none; b=Mi1VXeIk5NeVtHSDe5hK1AWL0q+rycNrikSb79U3yioyqcSUqNhYw55H5iOXgykmH6YQneXSLFZAg/twSAjzt7cSwLmWWF0+F5LlG6ZsKh1aTmPg3m1fyQZCk8N8monETjUzbbEX2PsTwiEUzETD+MDhBvzwumMO8BxRyfTIJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752106; c=relaxed/simple;
	bh=Nqis0AhewKay1mWAEqC0vpbdPsm8FDS2/zO5ZoQx0sA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rpJDD8mEyAzbCdWXV3+WE+6K8aI8NVeO8CWhu9Ax38K7ZYcpo2Ly8WU9XpvQlYeTccJihHsELuqO3qIUul1fnEomeM9LVlXouwTSJr0+IzS+5Ndazw78eBQEHGe7NvAAskKbNMu9qgyQSQIPox9QTu7cwQJpq2s3AW7jOnaOrZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OjMlDi8J; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OjMlDi8J"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD61F143D;
	Mon,  3 Aug 2026 03:14:58 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E9793F632;
	Mon,  3 Aug 2026 03:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785752102; bh=Nqis0AhewKay1mWAEqC0vpbdPsm8FDS2/zO5ZoQx0sA=;
	h=From:To:Cc:Subject:Date:From;
	b=OjMlDi8JHKJvNrw1Ik34MDmGLWNRT8F76LVrZmVRN2K7vekVXN7TLR36it838n1Dv
	 Gd/kjdGQrNqbdlnOm3SRGA+1ZJMtKxa7ymt+v4ppvWbd36NQ/E3mnxDZHREaRfyfDM
	 OSSiRbQrJp9tg0jndOFgk6iZPt3BP6P3UU4aY6Mk=
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Liu Changjie <liucj1228@outlook.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/6] sunxi: net: add Ethernet support for X96QPro+
Date: Mon,  3 Aug 2026 12:14:46 +0200
Message-ID: <20260803101452.2993721-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X96QPro+ is a TV box with an Allwinner H728 SoC (the same die as the
Allwinner A523). The Ethernet connection is using the secondary GMAC,
connected to a MAXIO MAE0621A-Q2C PHY. The setup is a bit special, as it's
not using a crystal oscillator to clock the PHY, but instead a clock
fanout pin from the SoC.
To make Ethernet work on this device, we need this clock, we need to
adjust the PHY-ID, and we need the devicetree bits:

- To make the PHY operational, the PHY driver needs to enable the fanout
clock. The generic PHY DT binding describes such a clock already, so
the binding needs no addition in this respect, but it's in each PHY
driver's responsibility to take care of that clock enablement, which
is done in the first two patches.

- Also the MAXIO PHY used on the board is the -Q2C variant, which uses a
slightly different PHY-ID than the Q3C variant described in the current
version of the driver. Add this new PHY-ID to the driver, but also
allow it in the DT binding, since we need to use that PHY-ID compatible
string version, to skip the MDIO probing process, which wouldn't work
without the clock. This is done in patches 3 and 4.

- Lastly we need to describe the config in the board's devicetree. Patch
5 adds clock fanout pins to the .dtsi, which the final patch 6 enables
the MAC and PHY nodes and connects them together.

This enables the box' Ethernet functionality, made possible by the new
MAXIO PHY driver. The MAC part is already supported for a few releases.

This is based on v7.2-rc1, plus version 2 of the MAXIO PHY driver as
sent by Liu Changjie. Since those two patches have been reviewed already
some weeks back, I assume they are ready to go. Please let me know if
that is not the case and if I can help with anything there.

Cheers,
Andre


Andre Przywara (6):
  net: phy: maxio: prepare for more DT properties
  net: phy: maxio: parse and enable PHY clock from generic DT binding
  dt-bindings: net: Maxio PHY: add PHY-ID for -Q2C variant
  net: phy: maxio: extend PHY ID matching
  arm64: dts: allwinner: a523: add EPHY 25MHz clock fanout pins
  arm64: dts: allwinner: a523: x96qpro+: enable Ethernet support

 .../bindings/net/maxio,mae0621a.yaml          |  4 ++-
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 14 ++++++++++
 .../dts/allwinner/sun55i-h728-x96qpro+.dts    | 28 +++++++++++++++++++
 drivers/net/phy/maxio.c                       | 27 +++++++++++-------
 4 files changed, 62 insertions(+), 11 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
prerequisite-patch-id: aa3058cd68d68f361088b39cac0b12fb96be8b55
prerequisite-patch-id: 90f19ec9993e373e39efda42984c88d7b51151e5
-- 
2.43.0

