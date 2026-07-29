Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9633C1D62;
	Wed, 29 Jul 2026 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340969; cv=none; b=Eabz62CwMTE54eKNTSidDcZQAqWumorKozD9INkPqK3/a7B/yB3i575MiAOEspQX3YrCnf1Vgqf0Bgidp/aLOdRuT+rmSq/ki6YTHZx+7zdp5GiTrJZZ3oGyxbk41aS8W5Fk5BAqHbWc/c2oNzoT19ejEuP8VXi7KiH0x0JJY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340969; c=relaxed/simple;
	bh=XNr5q2VP3Hj5lcNfDJOwDL1mnheDQ08PmWSrNH5e7Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6QHGit4Ehfr6xXtJ3DOOQlDy0M4ZvIocYHWTuc1M9CQ5RvP/Zn+aHkOLnTDIUmHOSmtHNEcV3t28RtAsQ/pusF/UxZXlDcG8FlmV5FghJDsKSXdP+5lDlVAEx94DFjYYbGJEiyVNorMYleK5G4d3qbp7C0lY4cUT+xNk3A3qjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=giPzJr2+; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="giPzJr2+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785340964; x=1785945764;
	i=markus.stockhausen@gmx.de;
	bh=MAzry3gK3e22Zv7QTuCjf6NuR53Oaa/JO2Le8+kacXs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=giPzJr2+9aJ7bY4nsy6Lp90Miem5j+aN6N62/o9F4LLZviOpABrReZ4RnSVDMxLS
	 fheECQ5TnGszuyr9hXlAf+hM+fcECNanZEAkO5rZPWvR2tdMNRYtLqsB1Xx4DfpFw
	 qoMM93iPVJZRr4CBgfGvmMIXj47ReJV7xVGzjsL6dVO2lMWUjK58L//ldsyMddLwI
	 fBeyPWp+Fs6ZIjT9byfWAtk+8YTc1Jaus0HlOfKuxPXnNH+gfkWNfZ0D049kAvR3k
	 7iN9gA9Q/SeH5y0ZAdXeSVphFEzzuCDpINSF4qyCDBkaUmX0FI+/hxf2jCkHJIFxl
	 XtfVl32vmNtGC0v54Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zBR-1x2E0V1Iyh-00yHdA; Wed, 29
 Jul 2026 18:02:44 +0200
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
Subject: [PATCH net-next v8 0/9] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Wed, 29 Jul 2026 18:02:18 +0200
Message-ID: <20260729160227.155613-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fZJ6MIq4ls5TkMPt4W1lgXc6HCI6mgx+bC2ROpxMKnzbbm/qHNk
 hX0oyBGR1am4tt3cMNd/QLp2eRvcHPHEbiJ/eD4K8zfleUo84RKBdhcCpop8zEDVKYpLIsm
 d9wgqAuy6/m9/hVMiThSZm2m+uljhPMaLsDjoClFu8vm/kDSkARqOqSXCXafyEATK7rhKNQ
 kAVKKHMoA9xYjvTL++RAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JSlN8o9K7FE=;SygnoCan4HECo0UJhbjaOyuEi3I
 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
 w1c

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

Markus Stockhausen (8):
  dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
  net: mdio: realtek-rtl9300: Add polling documentation
  net: mdio: realtek-rtl9300: extend controller structure lifetime
  net: mdio: realtek-rtl9300: Configure hardware polling during probing
  net: mdio: realtek-rtl9300: Add page tracking
  net: mdio: realtek-rtl9300: Increase MDIO timeout
  net: mdio: realtek-rtl9300: Add support for RTL838x
  net: mdio: realtek-rtl9300: Add support for RTL839x

 .../bindings/net/realtek,rtl9301-mdio.yaml    |  14 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 445 +++++++++++++++++-
 drivers/net/phy/phy_device.c                  | 180 +++----
 include/linux/phy.h                           |  18 +
 4 files changed, 553 insertions(+), 104 deletions(-)

=2D-=20
2.55.0

