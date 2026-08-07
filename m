Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35D039EF1C;
	Fri,  7 Aug 2026 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122688; cv=none; b=OJNZ583cIBc48bRGoxDd4ETDBWZ/x7DRFLV6XbLIAyboAnD4WRb0Xpk8PXZcycGfxm6WLS+kwWoPDabkiAfy33lhk+6xOVZf1M82qCJ97afy43xCRcDkcJs5AzFuA17YA1o559uK8jc9W5rvvsh8n0uqtlSLPKri3p7tHGX8198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122688; c=relaxed/simple;
	bh=kOFXmggba7tyfUglUqNlkFFeVELub8myU8sbT1lNbW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EFFIrhvcEcTh4gqtlse0CvfdEmgYaw3ohoTIV7Y2bVpn8o4hX3KHAsJw8KC7wxNFWQhU/zA2XcjhyMw2ctjBWv8yu7Dhwdq0ZrDKnQy6Fx3fvGkAvdpKsbg8AsZhbmffqimNJ1Y99n9wY2MuFWXwYcLIx5XFp6J98pZrglpEi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=eonmyv6Z; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="eonmyv6Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786122671; x=1786727471;
	i=markus.stockhausen@gmx.de;
	bh=UmmCNtr0Ns/TjAqPXktzzRy5MnsBbycUq+l5T8g3Y2w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eonmyv6ZiwwIKYa1XkET1u3SzuIf7ivo9jyLor+gyVZeo9NuJQsv9Yw6wjY1U2en
	 DWsZRDYj7Eab4Y8yILHVHS+lR+CsaaduVVfr/BnjeAV7fX9V/LjtIXRpR7C3M+LJ+
	 MqFbzfKyc6K/vGrqz/aTIthvrpC231nxVa/l93QoY7O7GIU0uT762x00KAagSMtvg
	 oEnKZg+Xzkx9sCIVnJeuW017tP0dpHjN/iAJNXDJVaUvluvEGWn4al5XOI73IGtmG
	 cf8xZat9QwzRnG6RYWx01Q7ACU8PfttnqhBaaAVf8PMkYI04OA3J1xDK8TGkIDWc/
	 OgTsKLKfo4bYzMwsgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6DWs-1wqBB10OqW-0020RE; Fri, 07
 Aug 2026 19:11:11 +0200
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
Subject: [PATCH net-next v13 00/11] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Fri,  7 Aug 2026 19:10:47 +0200
Message-ID: <20260807171058.522833-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5AK3Nfia/4Gzb9RcjFcsDoukxGTKHSWFtsTN/diJJ/3tBM/8/CD
 pQ3H+Yq/vu7ko3z/TMtUqX161RIdd3zBkij+sYWlk+pqHjm1USPapisGdV4BxUITyWW9k1K
 7eaAazOcVGlklttTYpYI9I64Oxa6+G6WDir3TY1h/iep5aO59YO/IiJlgpAFFMiug0paw7k
 ucBy3O5Cf3LuFZP/ZrIfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UwNUeKMHbjw=;kBzMPGkbCOatpJ/PZTqtqn8fJQw
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

v12 -> v13:
  - Unmapped PHYs do not exist on these devices. Add error message and
    clarify commit message of patch 5. (Sashiko)
  - Rename not only Kconfig but also module description to reflect
    the list of supported devices. (Sashiko)
  - Reword sysfs bind/unbind patch to clarify that for now this kind
    of mitigation is sufficient. (Sashiko)
  - Explain in commit message that relying on regmap lock for=20
    enabling/disabling of polling is sufficient. (Sashiko)
  - Use dev_err_probe() for C45 check in otto_emdio_map_ports().
    (Sashiko)=20
  - Make clear that the bit registers (polling & port_mask) are 2x32=20
    bit and have their lower bits 0..31 in <reg> and higher bits=20
    31..51 are in <reg+4>. (Sashiko)=20
v12: https://lore.kernel.org/netdev/20260803171853.507506-1-markus.stockha=
usen@gmx.de/
v12 sashiko-nipa: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026=
0803171853.507506-1-markus.stockhausen%40gmx.de
v12 sashiko-gemini: https://sashiko.dev/#/patchset/20260803171853.507506-1=
-markus.stockhausen%40gmx.de

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
  net: mdio: realtek-rtl9300: reword Kconfig and module description

 .../bindings/net/realtek,rtl9301-mdio.yaml    |  14 +-
 drivers/net/mdio/Kconfig                      |   4 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 350 +++++++++++++++++-
 drivers/net/phy/phy_device.c                  | 180 +++++----
 include/linux/phy.h                           |  18 +
 5 files changed, 470 insertions(+), 96 deletions(-)

=2D-=20
2.55.0

