Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A01041CB54;
	Mon,  3 Aug 2026 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777587; cv=none; b=dMsESCy7bG7o3kwEQEaKtudqbVV7aMIBdoAHVLHi2KjYDCMfymgRS0in6i8UWseVpLsJsoZvEGn8aKRVw+pWDzQdRFIL5F1Khz916+xJrwBPZWwgHQfxi7LgOfc8mQsyZSw7qWfN8ic8xrH5Br7TlF6YVlSAS6ybD+3amOuqi6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777587; c=relaxed/simple;
	bh=DltHrEbu6Yn+fopGZabZd5WXyXxJ0a+yc9NdxpOGJ9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMgGzbcpaXg29qIXRFDYfIjOrEXekiRrlqQL5gkX5GXWXT4fcYr81Vz/bxqZ/PWread6YtNw8GufL7NY+1sWkyIq8hPXs4ZZiIa3gHV6YKb3ce628OtmDainzHThF/mKqsnCyIu7455X3xUIyaBWNDoNmfqBjsMJhDrhVN6vbXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ncrXSc7m; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="ncrXSc7m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785777550; x=1786382350;
	i=markus.stockhausen@gmx.de;
	bh=1stOHUjr+xFqar4yFGfRJOSH930hQu8td3GUUJ/e9b0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ncrXSc7mVIz7x6oz3Cg18iuxMTqx5Eob777amMsv616PtQMEsZM70KDfw8qV06lt
	 aqS9CoQ0sGWMmQuUjmCKa8rcwvgW92SR8gj0dQWCrZ1eLA0u7vqIeS8EE4lnM2Jwz
	 gzsl07DlIyGMJJTC8yViZKu+RbMjZrziploSmVeYmZz2LYwD8rOdoWDCYiwNtWi39
	 S00i7euDAXkCdky3zTIr++RC6Sgc63jMI9Fmw/geYNsyztHWXutI/0KuKEPYCWwSh
	 JTnOKHbls3kBBgRgKHtTars38IAs2ydPFR5T5nc7PBWSYnI2iDuOWrJihOcqwdrRB
	 fP+czG2cKK6uHqRYRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq6C-1xAWV40HdI-00rakm; Mon, 03
 Aug 2026 19:19:10 +0200
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
Subject: [PATCH net-next v12 00/11] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Mon,  3 Aug 2026 19:18:42 +0200
Message-ID: <20260803171853.507506-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZMXaIqG1WWSHaGK1ahsIxIU4fyctTltvnI4Mlfbvubwu7RZ48i3
 hDWboVp70jxLwnCebKmv3Ay1dGYgHUghe/huQTdCj8SyNqCqi9KN3Xrnigh4g9p2eDgHdDf
 mu7ZmpNq7k1BY6Opsl+u14erZ/RuX0Bm1dHPmKA7vVopPvStLHyMVMNP3fRLBku11O2CYWa
 8z1svyrq3zXWI8Y1a7WyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bCpdYI8S2dc=;aP8h3U1CQJ0Cupvl/zcuWoXzKn3
 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
 tfWmxpDC2Iwqk4w1v26Tqia4srxOjO39f0FvU=

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

v11 -> v12:
  - v11 was sent with the wrong starting commit and with leftovers
    from v10. Sorry for that and thanks to Jeremy.
  - Allow to support devices that as of now only need C22 read/write
    helpers. This avoids to carry around unneeded C45 code for RTL83xx.
    The feature is implemented with an additional patch. With this=20
    drop RTL83xx C45 helpers. (Sashiko)
v11: https://lore.kernel.org/netdev/20260802083528.490216-1-markus.stockha=
usen@gmx.de/
v11 Sashiko review faild

v10 -> v11:
  - Fix typo in bindings patch. Cypress has only 52 ports. (Sashiko)
  - Drop "extend priv lifetime" patch this was too complex and produced
    even more Sashiko findings. Instead use suppress_bind_attrs to
    disable sysfs unbinding. (Sashiko)
  - Rename detach helper phy_detach_internal() to avoid confusion with
    unlocked helpers that start with two underscores. (Sashiko)
  - Clarify the reason for the unconditional notify_phy_detach()
    that Sashiko complained about. (Markus) =20
  - Explain that FIELD_PREP(RTL8390_PHY_CTRL_EXT_PAGE, 0x1ff) is taken
    over from SDK and no meaningful name can be given for 0x1ff. Just
    like RTL9300_PHY_CTRL_PARK_PAGE. (Sashiko).
v10: https://lore.kernel.org/netdev/20260731061400.78301-1-markus.stockhau=
sen@gmx.de/
v10 sashiko-nipa: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026=
0731061400.78301-1-markus.stockhausen%40gmx.de
v10 sashiko-gemini: https://sashiko.dev/#/patchset/20260731061400.78301-1-=
markus.stockhausen%40gmx.de

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

Markus Stockhausen (10):
  dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
  net: mdio: realtek-rtl9300: Add polling documentation
  net: mdio: realtek-rtl9300: suppress sysfs bind/unbind attributes
  net: mdio: realtek-rtl9300: Configure hardware polling during probing
  net: mdio: realtek-rtl9300: Add page tracking
  net: mdio: realtek-rtl9300: Increase MDIO timeout
  net: mdio: realtek-rtl9300: Check for C45 support during setup
  net: mdio: realtek-rtl9300: Add support for RTL838x
  net: mdio: realtek-rtl9300: Add support for RTL839x
  net: mdio: reword MDIO_REALTEK_RTL9300 Kconfig

 .../bindings/net/realtek,rtl9301-mdio.yaml    |  14 +-
 drivers/net/mdio/Kconfig                      |   4 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 344 +++++++++++++++++-
 drivers/net/phy/phy_device.c                  | 180 ++++-----
 include/linux/phy.h                           |  18 +
 5 files changed, 465 insertions(+), 95 deletions(-)

=2D-=20
2.55.0

