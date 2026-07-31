Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942B53451BA;
	Fri, 31 Jul 2026 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478470; cv=none; b=KeNHioweSSUaLNWguaJD/ud/som3MXWhd1GzK5dHInXe70itSZVQoNxKDXSrMl8kvo3pWmtCmE3WS38DZXw1FWOdoVtF845pBJoW0JGrmFyPumu4Qw5bS456czmRTg/PYNrlhISzwtfc5Q0173HSnSF4knPMTsWT3VhO8rfEwuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478470; c=relaxed/simple;
	bh=B9biaABewm856WtGEqbZmoffP8c4pQXWCvz/bhQwj88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ElUQ7s1iRQRFiDJyGMYSvsXdulmaXOlN7nuVWydBUszhjp0t/rpKn3KNYPDtzzGJxglJya1oNvR1lvIurN4XGU8DwMXj4OxVFecANfO+ZYi5nGuegCF7pb2G6bSejppa2iTQtzD2JqbdNvNjW+wpJ+pDmAnq19Ne0jbj1Hn0caA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=B548EMx4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="B548EMx4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785478453; x=1786083253;
	i=markus.stockhausen@gmx.de;
	bh=SNfHP8ZbiKUm0gpcOHOIgiLlw6he0f+Di9bNlJ0W0TI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B548EMx47gOYeFTLjKSOBmo3Cf41g4wlLgtfyM6n0W086dAGbbXpC6YXJyRjh9bA
	 HUpXJOgBo/AEiYXeejh6SCjhGF4/PkpdGRf96ub4ko8xct14nn0A8JRRxUqnnrGV5
	 4JP9yiZy5ayNGKktlA22IDzaZDSb1EKf//hX+OwAaldq1Tj6GTsYWm4oagOgmRNx7
	 YXI9VtZqYpUDikgV/ChD9hD2JCBkB8BaRqmJLx4pr0yYbJFRG2l4gwB1yXFkue0n1
	 PclkroexO4abgtEz6A05/xM1Y6V+rOJgZKX4nULIGAUwhyYmyDkNX2wDQRCk+sNu2
	 dDD2owM5h9YDqExe6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWASY-1wS2yV0MH4-00Ustr; Fri, 31
 Jul 2026 08:14:13 +0200
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
Subject: [PATCH net-next v10 00/10] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Fri, 31 Jul 2026 08:13:50 +0200
Message-ID: <20260731061400.78301-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gz2jr+oKtKC7w6L008iGwCCCufTAVlPuQqeQhIDfXsC/ZTCQhzK
 8zML66EFH+yLyF1j/kc5pMDbKMMrRkRnOwCJOTOVQ/TI1rt47rUOkSKPAEAnpC1JiGwUpN/
 GpcxYcJmbPpplXFcJVl6EqKIhxGMaBUyQ3lBiS5Sq5BAb8zR3hwu5lPCMicyLUNpxDIBsdQ
 hLj6Zo+CxdiB3oTvgx3fQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ze3bLCmy7Yw=;HTUjzGTZHn4ZoiNivUkFYYcBnKC
 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
 H+2

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

v9 -> v10:
  - Run devm_add_action_or_reset() after devm_of_mdiobus_register().
    Critical last minute flaw during v9 refactoring. (Sashiko)
  - Enclose page access into guard() during detach notification to
    avoid concurrency issues during teardown. (Sashiko)=20
  - Clarify that system suspend/resume ist not supported. Hardware
    polling will not need to take care about system power management.
    (Sashiko)
  - Add patch to reword Kconfig description. (Sashiko)
  - Remark: v9 was mislabeled as v8
v9: https://lore.kernel.org/netdev/20260729160227.155613-1-markus.stockhau=
sen@gmx.de/
v9 Sashiko review: https://sashiko.dev/#/patchset/20260729160227.155613-1-=
markus.stockhausen%40gmx.de

v8 -> v9:
  - Align polling documentation with sample. Instead of "read" it
    must be "write". (Sashiko)
  - If otto_emdio_init_polling() fails do not leave otto_emdio_probe()
    but jump to error label for cleanup. (Sashiko)
  - Bind cleanup action to the bus and not the controller. This was
    done wrong in v7. (Sashiko)
  - Clear Realtek C22 PHY tracking page during detach. This ensures
    that next PHY attachment does not work on wrong initial page.
    (Sashiko)
  - Explain that polling registers have different names for the
    devices to avoid AI confusion. (Sashiko)
  - Improve notify_phy_attach() and notify_phy_detach() documentation
    to better reflect under what conditions these callbacks run.
    (Sashiko)
  - The v8 lifetime increase rework changed an error message without
    explanation. Undo that change. (Sashiko)
  - Improve page tracking commit message. Explain that bus scan runs
    before Realtek PHY check and thus a delayed error handling is
    accepted for now. (Sashiko)
  - Explain that the driver implements c45 access for RTL838x and
    RTL839x for completeness. (Sashiko)
  - Replace kzalloc() by kzalloc_obj due to checkpatch. (Markus)
  - Use define for page register 31. (Sashiko)
  - Avoid duplicate pointer walk in otto_emdio_notify_phy_attach().
    (Sashiko)
  - Drop unneded parenthesis for phy vendor check inside
    otto_emdio_notify_phy_attach(). (Sashiko)
v8: https://lore.kernel.org/netdev/20260727191559.19617-1-markus.stockhaus=
en@gmx.de/
v8 Sashiko review: https://sashiko.dev/#/patchset/20260727191559.19617-1-m=
arkus.stockhausen%40gmx.de=20

v7 -> v8:
  - Add patch 4 to increase lifetime of controller->priv structure so
    it is available until the last bus is unregistered. This avoids
    a use-after-free if controller is unbound via sysfs. (Sashiko)
v7: https://lore.kernel.org/netdev/20260726071751.1359156-1-markus.stockha=
usen@gmx.de/
v7 Sashiko review: https://sashiko.dev/#/message/20260726071751.1359156-1-=
markus.stockhausen%40gmx.de

v6 -> v7:
  - Drop phy_poll bitmap. It was used to detect asymmetrical attach()
    and detach() callbacks. With v6 callback refactoring this is
    now obsolete. (Sashiko)
  - Relocate notify_detach() callback directly behind phy_suspend()
    for better symmetry. To avoid further AI review complaints about
    missing LIFO compliance explain that phy_detach() even without
    the patch is not compliant. (Sashiko)
v6: https://lore.kernel.org/netdev/20260724055611.1008577-1-markus.stockha=
usen@gmx.de/
v6 Sashiko review: https://sashiko.dev/#/patchset/20260724055611.1008577-1=
-markus.stockhausen%40gmx.de =20

v5 -> v6:
  - Adapt polling documentation with new findings after questions
    about consistency of 100MBit downspeed detection. (Andrew)
  - Add a clearer explanation to the page tracking commit and why
    it was chosen over a polling enabling/disabling solution. (Andrew)
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

Markus Stockhausen (9):
  dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
  net: mdio: realtek-rtl9300: Add polling documentation
  net: mdio: realtek-rtl9300: extend controller structure lifetime
  net: mdio: realtek-rtl9300: Configure hardware polling during probing
  net: mdio: realtek-rtl9300: Add page tracking
  net: mdio: realtek-rtl9300: Increase MDIO timeout
  net: mdio: realtek-rtl9300: Add support for RTL838x
  net: mdio: realtek-rtl9300: Add support for RTL839x
  net: mdio: reword MDIO_REALTEK_RTL9300 Kconfig

 .../bindings/net/realtek,rtl9301-mdio.yaml    |  14 +-
 drivers/net/mdio/Kconfig                      |   4 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 444 +++++++++++++++++-
 drivers/net/phy/phy_device.c                  | 180 +++----
 include/linux/phy.h                           |  18 +
 5 files changed, 554 insertions(+), 106 deletions(-)

=2D-=20
2.55.0

