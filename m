Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF631E820;
	Sun, 26 Jul 2026 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050301; cv=none; b=rT9O4+FRgOVD1Imf1NBg1WCmnEAfvjgPBWWwLFS6+pp/0rPVlLQDQueLRPSRXKGB4icYW0SsPvl7eFL5ZMEr4lvlsa/s5QbAeSq40YdVaGdTdEET3sxp6Wsy8Xm4/hIXFzIG+ZqIXaQfhdQXfx8n+6O6Wkz9b9R3szf8f6stTrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050301; c=relaxed/simple;
	bh=48lTuM3n87FEYPXxxEw4FsSdQwbJkfxhVtXAFFsxYtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZOHwmsRj0Kh+8R3smqt66QOBx1pgXHpXTu6Y+Tgh5lwxE/ZkvsqxSEsF8KMudUD+Vq5XlwcIJXzjCQzrOihJBHgc/9n6IEIS+Qmio4VWika4lhqae7s7qQhfrYS8zyLoqiTKcp4RwUeqbwDKS3D2hAY9VLjR6+oGuG4vd5g++rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=APXxhzNO; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="APXxhzNO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785050287; x=1785655087;
	i=markus.stockhausen@gmx.de;
	bh=kNzBB0YxSWNMoE36PTE8zS9uJsmQCfSK9Ye0E5cnhCo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=APXxhzNO4HFGduAX++DhTds3+x24OmhUv+FLSSbrrxliylTJNarj1NdibSU6zXun
	 eJOCV3gucSwZifLew7Yrp+PBgfMZdtCNMv5m1ig0CNc7jeO/0zR5CTQXX4qkK03uj
	 boTH3RM0R+z1wOMVx7rjqcbuv9Pbdzr3edQbmmuz4UJKex7CXLwsa8lBfy2DI5FiK
	 F/FDy7KJ2QCcJ3N/qtVch5O7SKtnLVJUsLiMTg6qvEwmJnUgYK9MvZfmaSwYCmdZE
	 hppA1HkBd1ZSbIy6EcBHlyJLmvYIJwzsjNHG6lZYHS2uUj/ovAr83ibzXLd77/2uw
	 O7tOPU6s84xlLiR04A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QJD-1wmVg22Nyn-00DCrr; Sun, 26
 Jul 2026 09:18:07 +0200
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
Subject: [PATCH net-next v7 0/8] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Sun, 26 Jul 2026 09:17:43 +0200
Message-ID: <20260726071751.1359156-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jp34n6Dmrn1bggwJWgVPae/Y9A6R/uRWBukNF3UcQ5uLmfIOvIL
 QsD4mkXQNIWOyloOIRoGApY0HMcKWLDW5/kEi8233JrU3HJRzHpIsErW0xb5SPjUK6brTG7
 yv46WUhhuSHcyVOo8O9ksv8df254AlW+CTgWj9K/cQNYZzL1JtKln4wnMrEQQw0zLpdFcvv
 N+fsOqICBxIs4QQMqPSYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YrkF2bRplq8=;3EfC7669D4GYt7D5v8VahxEi7it
 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
 4c3wuWt09r4AL+CsCzBnk

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

Markus Stockhausen (7):
  dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
  net: mdio: realtek-rtl9300: Add polling documentation
  net: mdio: realtek-rtl9300: Configure hardware polling during probing
  net: mdio: realtek-rtl9300: Add page tracking
  net: mdio: realtek-rtl9300: Increase MDIO timeout
  net: mdio: realtek-rtl9300: Add support for RTL838x
  net: mdio: realtek-rtl9300: Add support for RTL839x

 .../bindings/net/realtek,rtl9301-mdio.yaml    |  14 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 382 +++++++++++++++++-
 drivers/net/phy/phy_device.c                  | 180 +++++----
 include/linux/phy.h                           |  14 +
 4 files changed, 498 insertions(+), 92 deletions(-)

=2D-=20
2.55.0

