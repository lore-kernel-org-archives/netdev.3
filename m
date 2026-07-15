Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E0031F9B7;
	Wed, 15 Jul 2026 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784143043; cv=none; b=ILelWLPVyBJ3EmUDnfCMQMJNOE/ohZUtFE6V+3VwO/jWdu3nYaMOoGTw4hnN4f4QVyGaviqAy+LENmJXfxjF0t9bmGGgKfdpZdBrnpvWUR0WW+yE5aAXFWxbZs1aDLeS9mkiqw/EG35MRrbNgKqPSDGahyYmhqiTF9VxPBsl3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784143043; c=relaxed/simple;
	bh=U/37O++Bmi/Jd0n+jDQY/s6xGJ8a2ievmvzU7NeBUZs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gvLSr6S+ZLAuiZSLOZtFrX6eSchtHS7ABETURucesGyXOvld8r0lqTgHIrUTar9cRfD9jBxFMxuggtVlZh568fZ11jlUIm0K1V1MBCOn2axfmu3uClRbRFzxep7RV+A2lkBWaEu++7ArAKod4/8pEgqzWFq3q+yMJ4qPysFMCgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=e02c33De; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="e02c33De"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 075B0A52C4;
	Wed, 15 Jul 2026 21:17:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784143026; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2VVH/7Yd5khrMIykiuT8v/P0iIITSr71VM6VksaHUVg=;
	b=e02c33DejakXNXBwefDQc4Qj9qB4u0AWavFEXX0JRKfxywU6Pm0m09GXhXMyRhM6qSHv5B
	oFVScRAjicUHjMTFWmwUJYvtFpEtsEM8Wp4PPqkb3ek/QR6GaXYfVgYnTnfWJcdimwHuUt
	FCwoiC6Bgu09OJQ3tv2ZmGXtdfOBcu5jCOPzvdooagkjdvy2eYjhweXdqXvLiiT2EbBemn
	s9lS4TYuosJwEiDQSfCnAbQ01oELZKuOjeXR/42884pYJKzvpwtjXJP2MWtQQJoCjhIlYm
	qLctZn4ECTqIep5k8k2HYdACGTmmExbuTBMzars/vBfUAsJUkqw6sBWApIdwcw==
Date: Wed, 15 Jul 2026 21:17:03 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-msm@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next=5D_net=3A_phy=3A_at803x=3A_Use?=
 =?US-ASCII?Q?_a_helper_to_check_for_phy_reset_existence?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260715101355.88536-1-maxime.chevallier@bootlin.com>
References: <20260715101355.88536-1-maxime.chevallier@bootlin.com>
Message-ID: <E3E933B2-2DC1-449B-AEFA-101A439A2D21@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime=20

On July 15, 2026 12:13:54 PM GMT+02:00, Maxime Chevallier <maxime=2Echeval=
lier@bootlin=2Ecom> wrote:
>The at803x family of devices are subjected to an errata that requires
>hard-reseting the PHY upon link change=2E
>
>That can only work if there's a physical reset line wired to the PHY,
>which the driver checks by looking if there's a reset GPIO configured
>for the MDIO device=2E
>
>The reset may however be controlled through a reset controller, which
>isn't accounted for in the errata handling=2E
>
>Besides that, PHY drivers aren't expected to directly access the
>mdiodev's resources directly, let's therefore wrap this with a phylib
>helper, that uses a similar mdio helper to check for reset existence=2E
>
>This was found in preparation for bus-level resource management for
>better mdio scan support=2E
>
>Signed-off-by: Maxime Chevallier <maxime=2Echevallier@bootlin=2Ecom>
>---
> drivers/net/phy/qcom/at803x=2Ec | 2 +-
> include/linux/mdio=2Eh          | 5 +++++
> include/linux/phy=2Eh           | 5 +++++
> 3 files changed, 11 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/phy/qcom/at803x=2Ec b/drivers/net/phy/qcom/at803=
x=2Ec
>index ba4dc07752b6=2E=2E6872dbf77856 100644
>--- a/drivers/net/phy/qcom/at803x=2Ec
>+++ b/drivers/net/phy/qcom/at803x=2Ec
>@@ -537,7 +537,7 @@ static void at803x_link_change_notify(struct phy_devi=
ce *phydev)
> 	 * in the FIFO=2E In such cases, the FIFO enters an error mode it
> 	 * cannot recover from by software=2E
> 	 */
>-	if (phydev->state =3D=3D PHY_NOLINK && phydev->mdio=2Ereset_gpio) {
>+	if (phydev->state =3D=3D PHY_NOLINK && phy_device_has_reset(phydev)) {
> 		struct at803x_context context;
>=20
> 		at803x_context_save(phydev, &context);
>diff --git a/include/linux/mdio=2Eh b/include/linux/mdio=2Eh
>index 300805e66592=2E=2Ea7d9e3ae362a 100644
>--- a/include/linux/mdio=2Eh
>+++ b/include/linux/mdio=2Eh
>@@ -86,6 +86,11 @@ static inline void *mdiodev_get_drvdata(struct mdio_de=
vice *mdio)
> 	return dev_get_drvdata(&mdio->dev);
> }
>=20
>+static inline bool mdiodev_has_reset(struct mdio_device *mdio)
>+{
>+	return (mdio->reset_gpio || mdio->reset_ctrl);
>+}
>+
> void mdio_device_free(struct mdio_device *mdiodev);
> struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr);
> int mdio_device_register(struct mdio_device *mdiodev);
>diff --git a/include/linux/phy=2Eh b/include/linux/phy=2Eh
>index fc680901275b=2E=2Ebeff1d6fcc7c 100644
>--- a/include/linux/phy=2Eh
>+++ b/include/linux/phy=2Eh
>@@ -2231,6 +2231,11 @@ static inline void phy_device_reset(struct phy_dev=
ice *phydev, int value)
> 	mdio_device_reset(&phydev->mdio, value);
> }
>=20
>+static inline bool phy_device_has_reset(struct phy_device *phydev)
>+{
>+	return mdiodev_has_reset(&phydev->mdio);
>+}
>+
> #define phydev_err(_phydev, format, args=2E=2E=2E)	\
> 	dev_err(&_phydev->mdio=2Edev, format, ##args)
>=20

Reviewed-by: Nicolai Buchwitz <nb@tipi-net=2Ede>

Thanks,
Nicolai
