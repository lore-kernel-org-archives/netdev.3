Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351CC21A95D;
	Mon, 27 Jul 2026 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179776; cv=none; b=YE1OPd+vdQMyJKiq8BCpfiYEJFRtRCGNQCDwFlLe6stf2QVbudFKuYR5kT8TlaG6DVHVvckfzu9K8+UcNNmEiEsdzDdGuTnw+zTalaykKeIyKZ2r+yTET22B+/rk4W+LTtdlCNKJ42+RNid/9FscXcjbWCCtpuYKqTE9VdIIgO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179776; c=relaxed/simple;
	bh=G0cvcFa17P3yf0nyAOWPZLG7Z7PP1/OCqVGKdpFeNes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8khc2h16s3jGrMsU7cjNltgQlPudmmDw9PFRgmKIIeSTuvcVWCtLbgyOY2cAs2o5iAYTiYgLjm89/olmtYZel5wOjKg3E/BznTTlHYp4SmHbF/IIrB1ILzGLw1MRt66mtmuqr789+udZp16a0sJZeSkx9//AOhkpgg3ZUoShEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=NNDQtwZT; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="NNDQtwZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785179772; x=1785784572;
	i=markus.stockhausen@gmx.de;
	bh=5Cazy4bA4xkV68GAsHv3oyLPKNE5RM/C2AqKVLXFIYQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NNDQtwZTDCOUVR0I4gmdMXHlypDNLzh98Tam/0gUXTKH06k6pb1fTKaKKV1SnWug
	 5llSnJCsXz8/ojzS8PZJCLitYK+wFZywVXO6F7NSyPfXQVm2XBBsXX/gBwZQc5Elj
	 jn6InJteL/WgXcCv+ZRZtq/74u1wwV7HII6ShQ9yUJzAvJKPqhM0/jINBz7VCj5xC
	 GfXZt00U6QlhLGmf5MEljAkWSlYAvlwbfoLLSraUsJVEDv1Pd0IFcdH3b7xD8hgfJ
	 x4BMqEHZSi2sQZyf7HPsWTMsaB0AN0U8QTGPuFkLd33I7otpcfXt30n7en0qLNHPP
	 nPi6ap5r3JiznrJCzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1wdfQa46PX-004hHM; Mon, 27
 Jul 2026 21:16:12 +0200
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
Date: Mon, 27 Jul 2026 21:15:50 +0200
Message-ID: <20260727191559.19617-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nqI9VHfWSNDDYz16vzhV8TwEX5caygxx/XeMKoPIAnkMZ+DJzc1
 tL8nBil1c/qzu+y1GnNO6cZaabz0oE5gaUJ7awWNQcd0/ivpdjeswIZGVHh24vKgjP+jH+M
 9p6Y19Vmgt7mQqxMNuRnBvzJJY7waN+Zc6iWUACxZoZxOnJcH62LYj4m09hvCxsv16agXgc
 htFWEb5dmSsafDNY2ODBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uMAoTkkZlE8=;YX8Fo63hA9DxP/47Tm1hc7DE9x5
 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
 gPmsVCUzBeIs

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

v7 -> v8:
  - Add patch 4 to increase lifetime of controller->priv structure so
    it is available until the last bus is unregistered. This avoids
    a use-after-free if controller is unbound vi sysfs. (Sashiko)
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
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 438 +++++++++++++++++-
 drivers/net/phy/phy_device.c                  | 180 +++----
 include/linux/phy.h                           |  14 +
 4 files changed, 542 insertions(+), 104 deletions(-)

=2D-=20
2.55.0

