Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39D28030E;
	Sun,  2 Aug 2026 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659757; cv=none; b=Uiy/9BttmfnrZiw3m6JXu58bV2EpsDzzElOEhgRnNP+IdNaQx5ZKjLkidUiPv1TKeYy4cloPUVoFyxrBcfbd7pypeTo35mEeZbqFMJ6TBWlwCaAKcFU0bQaT1XRu2j4N/VcuCBx6RtYGcP7P7kKgxwFJ2v/D4ABobZR6PEbWV2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659757; c=relaxed/simple;
	bh=gaK6t5OME/86vxVDp6RlYnXHOBWfTgxinypWeEN4vAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qnr+Aq1WHnSV4ZYJZiv5ptg/tONlZPR+/jVfd/ACy3C64sTAG0LbZjlDAdAupre9swtRDPkPaexNIk+u/Utv/OFJI49sW7pUHRc1/uARTdJS8NmVMJ8nx8sPDni73c0wU6Rl2r1LWgUNTKeyo0ktgWXhowFavfi60LlzngR7e68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=BPnXM0jc; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="BPnXM0jc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785659742; x=1786264542;
	i=markus.stockhausen@gmx.de;
	bh=39rbjs/WT2XgRQCiEkrIdor8dFD65W5nB3I0hbL/e7o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BPnXM0jcoo+3nQhTvfTSiyoVt0gNK3TljV5wtrmU5ktOrHpA6w8fvI5qec8I4OxT
	 GGyGVLiZEFAeDOns4rZWBgTkbxOtnW0+7tr2axGHxdQNtyLzMCozQD2p9wO37widv
	 g340dK3QdaRAGW3IwF80nTfU0nmFz9DQtYTOCHdZ00wGxbGdyonbiqRvGgu83/ITo
	 /G5zqQ8IErXIXgGaNBRwYOCO/1pzKO/V5EaEFeYDDoBwBuZkH2vxt97gdu0MlFyj0
	 0sJ3dWK4Q4GOzpo8SQajR6LVnL41PmMuaFZv0NZjGlZLmZ1URPSzsmfOFx4FhtfSh
	 62Nn/wRcdrJidkj1Lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mxm3K-1x8pgu1t8Q-00wYJF; Sun, 02
 Aug 2026 10:35:42 +0200
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
Subject: [PATCH net-next v11 00/10] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Sun,  2 Aug 2026 10:35:18 +0200
Message-ID: <20260802083528.490216-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uJqCDZoz9LGbEH8FJrT0xT6oNZmv0h65HDHBunBGXSc4e1bv7yb
 SUYZxg01ZAl3nw24YXBAL/oIuwe9Hh+9hNdhVD40vd/iKqYZfZchVhd1aBo/Hc4GSsPRKHo
 0CcslyAzJj/NTC1LEltFJnIRCvyMV9NW5FJ+6ceIUMfqK/zR6J2k14NY+g7BVOYnIKcGVz6
 ENaQ93bG3+waMc0Vmc6lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QUHad4W7fMY=;Qt758NaIVJUElSzrLUKtXjX5rK6
 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
 hRnuPP6eO0nqw3xQ==

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

Jeremy Kerr (1):
  net: mctp: usb: Allow multiple urbs in flight

Markus Stockhausen (8):
  dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
  net: mdio: realtek-rtl9300: Add polling documentation
  net: mdio: realtek-rtl9300: suppress sysfs bind/unbind attributes
  net: mdio: realtek-rtl9300: Configure hardware polling during probing
  net: mdio: realtek-rtl9300: Add page tracking
  net: mdio: realtek-rtl9300: Increase MDIO timeout
  net: mdio: realtek-rtl9300: Add support for RTL838x
  net: mdio: realtek-rtl9300: Add support for RTL839x

 .../bindings/net/realtek,rtl9301-mdio.yaml    |  14 +-
 drivers/net/mctp/mctp-usb.c                   |  33 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 398 +++++++++++++++++-
 drivers/net/phy/phy_device.c                  | 180 ++++----
 include/linux/phy.h                           |  18 +
 5 files changed, 547 insertions(+), 96 deletions(-)

=2D-=20
2.55.0

