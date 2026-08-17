Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C11451980;
	Mon, 17 Aug 2026 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984024; cv=none; b=npVzlY4IwfjfsTjgHHofTkVdj5pNw+HE0wuJhoHbGg2jT69PaXC9qIaDXmKDBP80cUX8ZEj7S2dLeHpHBhedN1UYIK5rWTE+riW5EZ+1ujnG/dOjdLpdRYtgHq4QKRurqrp0SiDqEn2HgXUGR2sBYyeYuMnq4WwRUeof1SIs2+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984024; c=relaxed/simple;
	bh=RtC7LQPB1v77I5nLT0Z4LoRciM3Vh1Xo+4KP2ANRtNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4q8bOCBt0j/N/ykhoQI+F/K9WLb/iU1jk82MezUkI7uoeKm/Pw1QwJZN2WLo5WnlZ9bkrpWA12ksZJMEvKQgpf8wheeLs1qqqUe9Cs2BPBmR6C88afnvr4jXnPwgLEs+dtcMUNP2iK4l5o96PJHbm8J2zovTFPjG0RKDCcxOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=mNFQP8eU; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="mNFQP8eU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786984008; x=1787588808;
	i=markus.stockhausen@gmx.de;
	bh=w/VIqI7C9H5v96m8XZ++T3Kr+ivr829FYqFtUFCITbs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mNFQP8eUJNc4/vAzaGuOTUCA4jk69fRpimPeC7xP7hXP6de5RGDennSq/PmURynA
	 3n8bh21kCyeJh7H26UTydUNWoX7R3tvhweKNGyHgw/IAtrniPpn5pnRsVAeKZ5ddD
	 EKeGwk8tG5K+ocRdWabTtovKf7zKc0CffywSHA85EUXPrq0wk6OeTTs4OeCr5G9tJ
	 APRMhRIA/e32Q45CCrtDz8ok3OzFQbjKZFBEnaRygR9QJdv/P0s4SE7LpbjwcUH79
	 pp1Od1B/2+HLMAUfZgPi5yHs2bwM5KJMZ9TpDP0OWJ121P1dKJlDLRwcTRtT4hlNo
	 Rkq6mEGFW9fPvdCgQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE6L-1xF3Fz2oln-00N7pv; Mon, 17
 Aug 2026 18:26:48 +0200
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
Subject: [PATCH net-next v14 00/13] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Mon, 17 Aug 2026 18:26:19 +0200
Message-ID: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MUsJHW5dIsJ6x+y23e+A0YEhJ0ADzGug2iFf+ivDYnDExvZHmVq
 v/fEfqJa42VwK+8g+w42kUZ9rX0kxlh1FWfFkmrX/77w1TKpn8C/1yT+1N/HRwEjavcgk0x
 D3mQvjnxCw48Oh444XZSKSOjcF7kGdBUU+Xx5oPOZ51QttkPjFGbT/tt4DBGTg3V2/p9Gyy
 HwVLlwojjo4f3KMoJ9a8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WA7wxFCQRt8=;elseIApAvSOaT4RzoH/0ouNxdC8
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

v13 -> v14:
  - Add a patch to allow C22/C45 access in parallel. Add C45 read/write=20
    functions for RTL838x and RTL839x. Drop the corresponding pre-patch=20
    that checked for empty C45 functions. (Andrew)
  - Do NOT add Reviewed-by to "Add support for RTL838x" patch as it
    was changed due to above adaption. (Markus)
  - Add separate patch with C45 over C22 error check. (Andrew)
  - Relocate addition of phy_detach_internal() into a separate commit
    for easier reviews. (Andrew)
  - Add Reviewed-by to "Add polling documentation" patch (Andrew)
  - Add Reviewed-by to "reword Kconfig & module" patch (Andrew)
  - Add "Fixes" to bind/unbind attribute patch (Sashiko)
v13: https://lore.kernel.org/netdev/20260807171058.522833-1-markus.stockha=
usen@gmx.de/
v13 sashiko-nipa: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026=
0807171058.522833-1-markus.stockhausen%40gmx.de
v13 sashiko-gemini: https://sashiko.dev/#/patchset/20260807171058.522833-1=
-markus.stockhausen%40gmx.de

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

Markus Stockhausen (12):
  dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
  net: mdio: realtek-rtl9300: Add polling documentation
  net: mdio: realtek-rtl9300: deny C45 over C22 access
  net: phy: add phy_detach_internal() helper
  net: mdio: realtek-rtl9300: suppress sysfs bind/unbind attributes
  net: mdio: realtek-rtl9300: Configure hardware polling during probing
  net: mdio: realtek-rtl9300: Add page tracking
  net: mdio: realtek-rtl9300: Increase MDIO timeout
  net: mdio: realtek-rtl9300: Open up C22 and C45 space in parallel
  net: mdio: realtek-rtl9300: Add support for RTL838x
  net: mdio: realtek-rtl9300: Add support for RTL839x
  net: mdio: realtek-rtl9300: reword Kconfig and module description

 .../bindings/net/realtek,rtl9301-mdio.yaml    |  14 +-
 drivers/net/mdio/Kconfig                      |   4 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 419 +++++++++++++++++-
 drivers/net/phy/phy_device.c                  | 180 ++++----
 include/linux/phy.h                           |  18 +
 5 files changed, 533 insertions(+), 102 deletions(-)

=2D-=20
2.55.0

