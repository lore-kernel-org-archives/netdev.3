Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3D33B6F9;
	Wed, 22 Jul 2026 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701463; cv=none; b=lgW0DGn5Xgz24DO285PByV3FDsB8kXwzd7qNljeieg7bR+MbseXLNo5ZNyJeXq1dhGcL1W5b+d42b4JbV46EAsLYQ+av3qMjvWfFzox6aLqbylIL/MkzbIFGTADrVOry4nK1o2DZyEt+2MjX3SV70gS7CnzbRmuJdZDLnFVeSqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701463; c=relaxed/simple;
	bh=h5omoAb2rkaTK8aDLloqERgBKsao+idHyAoyAzK2LXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U7LLPNHG0Q5P3MlzPTP9rKdeuwQqQSw7zLkvYrToElWNbYlPwC5iH8lCXOn2A4AULWjb6EYZS1Mij7U1TRbKbdPKqZkc8MeStieGSXtOHZ/V70cdT2KpOaO2CyszrqyoaTl6/9oChzd7GBgGjLJPZTfC94xQXfC9xrgcf+PdWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=AIe+bj1V; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="AIe+bj1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784701447; x=1785306247;
	i=markus.stockhausen@gmx.de;
	bh=IBwYV2prEdVKu0genzvjYQW7GcqtSL65WVGaPNSzXbQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AIe+bj1VSPp/ur9m+2K7sgWEAsvuAfLFfsPot26WIZqVj29tZZl1lSxVnXU8Bxib
	 4K4surrpmW0+92GA0qWC6px+bAlTkprv6IQVP/D8YK8G9m4+IQ4y5VP3QBYYJu0Fq
	 AhhxHMaWCH46doln1Aj1J3EJoh5kHZkBpsd+BXMCrggbLJmzC+y74umpaSRpuagPj
	 7TX54M9/FsTV8c2oBfoEm8+dBY9sXKq0GFiYGSE4wlPCNShMP44UvkigSmjekb10T
	 PvlEHP8IdInj4DVdzR/6R3mSRmGXURHQuCs0sWp8qc/x2gRFGaGBAz4UChn2dAlEF
	 pweIDd7Gnn8ETqn8zw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysRu-1x93dE3sTC-00zJ64; Wed, 22
 Jul 2026 08:24:07 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v5 0/8] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Wed, 22 Jul 2026 08:23:48 +0200
Message-ID: <20260722062356.12291-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yOTiUvjBYt1Rb+uCZX+12cnD/l3MXLqjSQl+GL8uLNhpUd28+ia
 5qZ9GgKtAejmTmpVq1wVoaAVGGCvxL/3k7ziOY9jtsNKWOhu/w032I/i+mly4GzPEnam1Kr
 DGvwkpsJv5qSZ+iXfh3vCxaHoEfZEFxUt4tswD8E6z8hYCiyII31y/XDrQ2Ijk125oMa/nh
 gK968HINdlSFmuL7ybkQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LLCCwGoBAAY=;WtMFL4x4iqClytQe03lEfcrIypf
 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

The Realtek Otto switch platform consists of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

While the MDIO hardware polling unit and its necessity for the MAC=20
layer was always well known, no detailed documentation was available.
For this series the MDIO bus was inspected with a logic analyzer for=20
a better understanding how polling and kernel access interact on the=20
bus. All this will be explained now in the driver comments.

This patch series adds support for the RTL83xx devices. For this

- Enhance device tree binding.
- Add special handling for limitations enforced by hardware polling.
  These already have minor side effects on RTL93xx devices but are even
  more critical for the RTL83xx hardware.
- Add RTL83xx coding.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--

v4 -> v5:
  - Design bus notification symmetric so that notify_phy_detach
    is only invoked when notify_phy_attach succeeded. (Jakub)
  - Improve documentation of notification callbacks. (Jakub)
v4: https://lore.kernel.org/netdev/20260709064157.2865063-1-markus.stockha=
usen@gmx.de/
v4 Sasiko review: https://sashiko.dev/#/patchset/20260709064157.2865063-1-=
markus.stockhausen%40gmx.de

v3 -> v4:
  - Add Acked-by for dt-bindings commit (Conor)=20
  - Test phy_poll bitfield under lock to avoid race. (Sashiko)=20
  - Fix whitespace in commit "configure hardware polling" (Markus)
v3: https://lore.kernel.org/netdev/20260705163532.2853959-1-markus.stockha=
usen@gmx.de/
v3 Sashiko review: https://sashiko.dev/#/patchset/20260705163532.2853959-1=
-markus.stockhausen%40gmx.de

v2 -> v3:
  - Enhance documentation and make clear that the driver and not the
    kernel must handle the bus mess. (Andrew)
  - Block non-Realtek PHYs on C22 buses to avoid issues with driver
    internal register 31 handling. (Andrew, Chris)
  - Drop C45 over C22 patch. This would need a bus lock/unlock design.
    For all known hardware designs it is not needed. (Andrew)
  - Drop tune_polling() and init_polling() from private structure.
    It is not used in this series and only produces review bot
    questions. (Sashiko)
  - Sort patches for better logical consistency. (Markus)
  - Add device tree patch that was missed in v2. (Markus)
v2: https://lore.kernel.org/netdev/20260629152336.2239826-1-markus.stockha=
usen@gmx.de/
v2 Sashiko review: https://sashiko.dev/#/patchset/20260629152336.2239826-1=
-markus.stockhausen%40gmx.de

v1 -> v2:
  - The polling activation logic was refactored. V1 simply activated
    polling after bus probing. Now a dedicated phydev/bus callback
    takes care of this and also handles deferred PHY probing. (Sashiko)
  - Run MMD prefix helper before register 31 (aka Realtek page register)=
=20
    handling. (Jakub's bot)
  - Always run MMD postfix - even if the c22 register access fails. This=
=20
    ensures that the MMD state machine stays consistent. Adapt the error=
=20
    handling inside the postfix function to not overwrite the real MDIO=20
    return code (Sashiko, Jakub's bot)
  - Drop unused RTL8390_PHY_CTRL_PARK_PAGE define. Like on RTL931x this=20
    field must not be set and thus can be ignored. (Sashiko)
  - Change title in device tree documentation. Because of this do NOT=20
    add the Reviewed-by of Krzysztof. (Jakub's bot)
  - Fix wrong use of RTL839x in commit message of patch "c45 over c22=20
    mitigation". RTL930x was wrongly named RTL839x in the list of good=20
    devices. (Markus)
  - Fix typos (e.g. c22 over c45) in polling documentation (Jakub's bot)
v1: https://lore.kernel.org/netdev/20260613112946.1071411-1-markus.stockha=
usen@gmx.de/
v1 Sashiko review: https://sashiko.dev/#/patchset/20260613112946.1071411-1=
-markus.stockhausen@gmx.de


Daniel Golle (1):
  net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus

Markus Stockhausen (7):
  dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
  net: mdio: realtek-rtl9300: Add polling documentation
  net: mdio: realtek-rtl9300: Configure hardware polling during probing
  net: mdio: realtek-rtl9300: Add page tracking
  net: mdio: realtek-rtl9300: Increase MDIO timeout
  net: mdio: realtek-rtl9300: Add support for RTL838x
  net: mdio: realtek-rtl9300: Add support for RTL839x

 .../bindings/net/realtek,rtl9301-mdio.yaml    |  14 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 395 +++++++++++++++++-
 drivers/net/phy/phy_device.c                  |  11 +
 include/linux/phy.h                           |  19 +
 4 files changed, 429 insertions(+), 10 deletions(-)

=2D-=20
2.55.0

