Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7EA4EBACE;
	Mon, 31 Aug 2026 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186907; cv=none; b=ZQ4Po5iWzEkEto2ABUMQhXlXRpd1imaD2c1eDDQIcU673k2pVu22Rzr7lCLonSMbmRocAX3RThtccvYrtPYO7usrklNMOdRx04qDMiixzcPWHGt38I+AmHW8xAOPibzL0YPgsbQX03pYl+s7IbjyAXCQN1GIfoz79XWcqr9EntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186907; c=relaxed/simple;
	bh=RiZHtCw5lF0HhezzhO8tUGhszOSNZLO0Y3PoPQHhjfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uWAn3BG6ExuOTh93jLPkzem9Gzl0cpg5UcMq7xu4cDZhEiJBFTTct12agN6zgfA1ViIJ6z9sBEkKPaRhAI3QtfXf2FH3tTCfFKudTMj5NtAmPOxR9LP51iQceLmtGuI3+cGIaDagmujAHGbTKy/2oIIhSAjtnkNFD18Adt7MQ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=n0Fu6/jM; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="n0Fu6/jM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788186895; x=1788791695;
	i=markus.stockhausen@gmx.de;
	bh=ICLdSsPhdAP25XgZtKwYGVH7tBOGivbNgzmhOYyliJ4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=n0Fu6/jM55Ndi+x2g/clberlXS6D6i05Fe+WOkCrLDCRRqmRimmztwTUtxplFuT0
	 lxFVOh/K35VMpDUXSuL5+ucIGYEAVQtThhV+fbOO0S+JfElVpbSm9RgFq0SoeRA5L
	 Qy6t+QK5nV/294/dJT0sYtibwSsxgGjZJT9MowthARPP9Fngq6CRMMRDaKD0Q7RM1
	 KqxKtQWPNkWjsnuRUWnjuiu3G+Czs8eM6KoGvAZYJlPmIAVL2kbCh6spGQQmWg+I7
	 K8hrvC/zchXEn9I1RzseV8wTP0tI3gFlHhsOkCHPjtXKJzvicq68N2SkAvktb/cqd
	 33AR5yH++AiAoeHvVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1x93zE19rr-00GFDX; Mon, 31
 Aug 2026 16:34:55 +0200
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
Subject: [PATCH net-next v15 00/13] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Mon, 31 Aug 2026 16:34:26 +0200
Message-ID: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N4uE4CdsW0bnLjT9wQ71blaHAfEYqeI+tuwOsRZdrbMeew+KBpk
 zxbEtqEpRDoaHMgWq/e2BfJYvKAJCJtWsMgf6X9XpyltpwI9WAygR0m+Id8p8P7Z+5bymSS
 3R64EyWE2yNDHd/jkjrhj0HtR98Lymy6Lva5uU48sVAYwmDoi+JEhJO+IgOC/jdnjn7q3c5
 skuQ0s9PQBhqqp9X3g7pg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:66BM8lkZiVc=;SV0UYms8iA5gDbAYaGzGfo3iXgc
 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
 mseORN0Mu824f+BTk/Agjf5

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

v14 -> v15:
  - Copy kerneldoc for phy_detach_internal(). (Andrew)
  - Keep phy_detach() comment in phy_attach() error path. (Andrew)
  - Use more SHA digits for fixes tag. (Sashiko)
  - Replace -ENOTSUPP with -EOPNOTSUPP. (Sashiko)
  - Replace dev_WARN_ONCE() with dev_warn_once(). This reduces log
    spam especially for high port count devices. (Sashiko)
v14: https://lore.kernel.org/netdev/20260817162632.1208891-1-markus.stockh=
ausen@gmx.de/
v14 sashiko-gemini: https://sashiko.dev/#/patchset/20260817162632.1208891-=
1-markus.stockhausen%40gmx.de

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
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 426 +++++++++++++++++-
 drivers/net/phy/phy_device.c                  | 188 ++++----
 include/linux/phy.h                           |  18 +
 5 files changed, 547 insertions(+), 103 deletions(-)

=2D-=20
2.55.0

