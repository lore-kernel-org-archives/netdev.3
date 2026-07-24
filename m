Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BEA3515E4;
	Fri, 24 Jul 2026 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872600; cv=none; b=FajjaKg78NZNPzuwD9l3FVBZlq22lcgnG+LrhW9C34hI2Vf00AD/qujCxswxSndOsKkHhXpkIJRDQr7TkFF9OYV5/vyDam2RDviLG240zS0XbCbLO5De6a9uCj9F3X44vT5WQf3TeaiJCUSSZ0XGKqiVUd74RHD1aLoZA3ny9EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872600; c=relaxed/simple;
	bh=tWjTyIL9UGtLDYH4snYnjp7gZZzoIb5B9y/G/DHNVc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L6Tz1x/p0AkfuFhq9LkTtjQhvYEZrb226PAWbVLIDNn/fP4+c+iQKuK2xoYeR447EBIjYeA+XRfZbaQH3xKH7Ph4ZfGZkJo/rB1T3cA9y2cWZYToWw0oT07+1YEznejurf3pDbirVKXzkuBKdj5iU6NvqCB0oREAMKCUuQ84lv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ZOsBvD4w; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="ZOsBvD4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784872584; x=1785477384;
	i=markus.stockhausen@gmx.de;
	bh=N3AMg74EydnxebeMtIRoijdB2HixNSQRAf1d4AfP5LA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZOsBvD4w+G+4FZZTYgnTkuuMLux4vvoA4z/KYSpF9t8Y5QvwpqfnynlYYpQmfyla
	 nzhOHkWwiSmbI96TYR6heP/mvUtEd0gVDQIJkfY/wEPfmXlRY1cP3cBfYTBuyzNkZ
	 FC5HjgtEeG52YtHm6wbJr0MYtRulKjYX2Md+c7yaqfVtRILK9Q5Hte3kIf76ttSHX
	 B8bxCTwLb2BZFUY2zs8z+zagLl4dis218jUb7Rq0O4cAl59A9Ni3CV/teWt0SQAf4
	 x+5J11jxkAZzXcWsZqfOROX2gODV+zOWiw9wabwALe+t6MVfp74o6trn/x3OS7/1t
	 nbjI8OZoVTFyUVAS9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbox-1wblyt0ge3-00O3Fh; Fri, 24
 Jul 2026 07:56:24 +0200
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
Subject: [PATCH net-next v6 0/8] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Fri, 24 Jul 2026 07:56:03 +0200
Message-ID: <20260724055611.1008577-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LT5eM7uKCOReN3CA9IM/mOPpRA/UzGOsZfJCZ3Mpwh2LNetYTt6
 xz4Qngh3e8xlpOaAFL1orbIsNfsfcCAqaHIE5z/woWYKettjNBb1gOgSKTategwuKQFOoU2
 WQ4YzUwJhupk2+E1q9ipyhnYHJb8uXuMhDSG2vHhRPlsRgZ+oX8YRPz5OYm1mE50bH1O9s/
 R54iOTTPsRxQrWwansiTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jPuSYzoseXs=;VRuUrjCw1SmikXBUTihSpygX+qa
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


v5 -> v6:
  - Adapt polling documentation with new findings after questions
    about consistency of 100MBit downspeed detection. (Andrew)
  - Add a clearer explanation to the page tracking commit and why
    it was choosen over a polling enabling/disabling solution. (Andrew)
  - Make bus notification symmetrical and respect LIFO order. For this
    add a __phy_detach() helper that avoids code duplication in the
    phy_attach_direct() error paths. Drop the mdio_bus_notified=20
    status bit. (Andrew, Sashiko)
  - Adapt notify_phy_attach()/notify_phy_detach() documentation to
    reflect above changes.
  - Drop lockdep_assert_held check from otto_emdio_set_port_polling()
    and remove lock handling during polling initialization. At that
    point in time the driver has exclusive access. (Andrew)
  - Drop polling check in otto_emdio_notify_phy_attach(). Notification
    is symmetrical now so there is no chance of double invocation.
    (Andrew)
  - Add Reviewed-by to "Increase MDIO timeout" patch (Andrew)
v5: https://lore.kernel.org/netdev/20260722062356.12291-1-markus.stockhaus=
en@gmx.de/
v5 Sashiko review: https://sashiko.dev/#/patchset/20260722062356.12291-1-m=
arkus.stockhausen%40gmx.de

v4 -> v5:
  - Design bus notification symmetric so that notify_phy_detach
    is only invoked when notify_phy_attach succeeded. (Jakub)
  - Improve documentation of notification callbacks. (Jakub)
v4: https://lore.kernel.org/netdev/20260709064157.2865063-1-markus.stockha=
usen@gmx.de/
v4 Sashiko review: https://sashiko.dev/#/patchset/20260709064157.2865063-1=
-markus.stockhausen%40gmx.de

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
 drivers/net/phy/phy_device.c                  | 179 ++++----
 include/linux/phy.h                           |  18 +
 4 files changed, 514 insertions(+), 92 deletions(-)

=2D-=20
2.55.0

