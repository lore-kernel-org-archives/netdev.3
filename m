Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6B330BF6B;
	Fri,  7 Aug 2026 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122677; cv=none; b=lEEMNuiYLeHU3PuPrMkAQpWJXHIQg0M60Y33N/kS5pokB1uIXkx2klEBNWrIhgyl57n6k8o0ASf7tEgc8CoemywO4BdW0DX9ptXHocSacPU2TQmeYP4EZCAnDTrhwWkre5ujfJ4hOigYuV4PXSdBosozZ0b4jIWm3totzwpFbY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122677; c=relaxed/simple;
	bh=QZqJp6npfoMfWBrr5dDx7UP6GrSBlMKFKj48IAD8Csw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJmHuwbsm5hcjY5+5/d9HsmgAXhR+/cM+YMp5xU3xxcOvzoOL1gib/60/3p2KiFibrpxBLjpHjANb5FMSRJJdWdcgLpmvk4Gm1fCWxc2xIKWBVwgRx9/YD5gurZwqjZgBDaULHfy+U4vHwnl7cUx6gAdt62mV5O2vGpCLHruxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=GdHO8waG; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="GdHO8waG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786122672; x=1786727472;
	i=markus.stockhausen@gmx.de;
	bh=q5vI6OGph6++8qobuIlLg4pV5Z7H1LO86IX15eNcx7c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GdHO8waGhgLCnk21WFjDlKwBhqW4PzjBXXC5DYSbMeUvqKG9AAQdeQufgOvPB9CE
	 cpdVD2mTA7SeF95DFI4rdhPDWV7OZ1RpWiH/A6OLykzK/857J5lPflDLcwYby1J+b
	 YcVPDsP5fc+k+iazNIlGrx79hZvgnMKofQtdyEEr/MmBAf0X2lugnPwtx8bJ8JNP5
	 iq9hjya9abQKBV1I+sT3XeX4WFff1whxyGKaTC5m0aV4Ps598XYmkCtYRjYpC6kuP
	 HkhE8PRp7Zh1dwrOGzPaaJgcGi3Fhav46Wl3z1v0VsPIa+BPuKWO5hEriBIccIJ63
	 JjZ3jwuj46XY3gIr7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2DxE-1x1zag2KFC-014TCo; Fri, 07
 Aug 2026 19:11:12 +0200
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
Subject: [PATCH net-next v13 04/11] net: mdio: realtek-rtl9300: suppress sysfs bind/unbind attributes
Date: Fri,  7 Aug 2026 19:10:51 +0200
Message-ID: <20260807171058.522833-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807171058.522833-1-markus.stockhausen@gmx.de>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q4MJ03KpsFVM4R2qKYMc1hiZxbREZC2j7gGCgUljBeHVDFh0vex
 Xtpe92fp5mdrLUNXCeEVqbKXthP39c9QKnHTIujYuWAXqQVD/DH5CBbqrvK/o9qKoMFUxen
 N+jkBtPLEHyEaN5AqCl/j1Om80dc30UIPTGo+YQje5+z2jBQyzqtcQduWp0I+QN5AWtCAq5
 XZPxVD8HjIopYSgKvh40Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IegSx+BNrXE=;dHVqsg+GJpAETWn2URedVbplRF3
 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
 WPEDmMKXzemS+FxJnyo=

The Realtek MDIO driver relies on devm managed resources for lifetime
management and allocates its internal central controller structure
otto_emdio_priv via devm_kzalloc(). This can lead to a use-after-free
in the following sitauation:

- If the driver is removed or unbound via sysfs the controller devm
  cleanup is triggered immediately. A corrupt devicetree might produce
  a load failure and a cleanup too.
- However the MDIO buses are allocated with devm_mdiobus_alloc_size()
  and are reference counted. So if a MAC driver still holds a reference
  to a PHY device on the bus, the mii_bus will remain alive.
- Any action that is run for the buses afterwards still relies on the
  availability of the central priv structure. This will access already
  freed memory.

There are multiple mitigations to choose from

- Clone all controller->priv data into the bus->priv structure.
- disable sysfs bind/unbind attributes
- Check for "bus->state !=3D MDIOBUS_REGISTERED" in all callbacks

This SoC-integrated MDIO controller cannot be physically hot-plugged
and manual unbinding gives no benefit. The driver is usually
integrated into the kernel and not loaded as a module. Avoid a
complex driver rewrite (data duplication) for now and set
suppress_bind_attrs to true to prevent unbinding via sysfs. This
mitigates issues for the known use cases.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 73ac5fdcd267..1873928b362d 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -830,6 +830,7 @@ static struct platform_driver otto_emdio_driver =3D {
 	.driver =3D {
 		.name =3D "mdio-rtl9300",
 		.of_match_table =3D otto_emdio_ids,
+		.suppress_bind_attrs =3D true,
 	},
 };
=20
=2D-=20
2.55.0

