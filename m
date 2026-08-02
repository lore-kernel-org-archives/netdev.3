Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A61390603;
	Sun,  2 Aug 2026 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659766; cv=none; b=bn/4R5JRfT1vVKQ6RtSo1V9IYHoG/4iXdbN7dNNXoVPsTCJc3A0kntMyjfBIcpRb/S5HXcgnvaTRzG21SS4l9aAvKlwfGgW2QbkmhnpmzgCHdCHEdcswMZvzaOUwfTOxmpV2VX0mraiW639KKznXsK/U2149ZPaS0LNvYfe+CLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659766; c=relaxed/simple;
	bh=eGRblj0aQ+CIoO2i96zWFxt2hMUQ6VzGffxPqaRiOi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlKmMEt2dG/JOqiQOtcr9OSOdxmUVq4X4huPxMh6LuoUwFiq0GvT+5Rc68oolgUCuhSSQd5rDhalXOrz2mGvgnEQLJNtTI4u3pULNW/HuAAOczsv2lJ2LdfMtNLFpRKAJTiVJgShfw95bwVpGrE93L/G3q6v0GwnS5KIEeFN6Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ba6A0Oyw; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="ba6A0Oyw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785659745; x=1786264545;
	i=markus.stockhausen@gmx.de;
	bh=n2prthgwjvFWlQX0XxMCJUlg/PFtRnm2Fr4r9UdXcbo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ba6A0Oyw/Ceb1lR+0nKyw3b8Mcc2REDI2Efqr+7C/8sWEGB3Sdo11CHgG69eJSqG
	 ZXa9KWbBE3sw7v0MbSALz/Ih+hvFBFtopZ0dS/ca9B4I8Olb/Mt6hybDlMuTYDwdF
	 R8V9ZJdjYRqAonoGY0U15nqYt2xv4mSHbc4zhtf5KdIk4UgvQ9RAqU7nyCTFhzrl5
	 e7Hctvj504NQbmf//kNqINmTSGuKuUm3CSy3wcxP/Y3jttwMI8Lnpc0wGIHAbuvFD
	 TAbHsdSelCxS4LEGCMTzD4/qktPxs9L7GSx9cJmAbZQXpbwY51EtY+LmsbD13UjMJ
	 jeGNMSFtY4NjawEnuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bSt-1wyf581zKV-012IP6; Sun, 02
 Aug 2026 10:35:45 +0200
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
Subject: [PATCH net-next v11 05/10] net: mdio: realtek-rtl9300: suppress sysfs bind/unbind attributes
Date: Sun,  2 Aug 2026 10:35:23 +0200
Message-ID: <20260802083528.490216-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802083528.490216-1-markus.stockhausen@gmx.de>
References: <20260802083528.490216-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TXYmmforOCGVbta0743j5ZTRnXuZIfEHj7HOsPRvylChBnykiQd
 eS0KVT70MQ6IABUWlNMTkFYotbM3Zc+iQiwvrh3w1GtWM2xWQ/UZIQoI2nV0zMNo/wnzCYw
 GgY0zz8WhMwyJJJn1W93YyytwYO4X0RSA6tEiO4M1nieS5686y3GeonhcC1tgZc6M87Wmui
 p4D+QtjSlTHp9dYpJKZ+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wcmdlBmfxhg=;8LmUoaVTD7Ls0d9SpNPNmRZ+PHp
 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
 H71URug==

The Realtek MDIO driver relies on devm managed resources for lifetime
management and allocates its internal central controller structure
otto_emdio_priv via devm_kzalloc(). This can lead to a use-after-free
in the following sitauation:

- If the driver is unbound via sysfs the controller devm cleanup is
  triggered immediately.
- However the MDIO buses are allocated with devm_mdiobus_alloc_size()
  and are reference counted. So if a MAC driver still holds a reference
  to a PHY device on the bus, the mii_bus will remain alive.
- Any action that is run for the buses afterwards still relies on the
  availability of the central priv structure. This will access already
  freed memory.

There are multiple possible solutions to mitigate that:

- disable sysfs bind/unbind attributes
- Clone all controller->priv data into the bus->priv structure.
- Check for "bus->state !=3D MDIOBUS_REGISTERED" in all callbacks

Since this SoC-integrated MDIO controller cannot be physically hot-plugged
and manual unbinding introduces potentially dangerous race conditions,
set suppress_bind_attrs to true to prevent unbinding via sysfs.

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

