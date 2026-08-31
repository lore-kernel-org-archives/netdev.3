Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106E4EBACB;
	Mon, 31 Aug 2026 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186906; cv=none; b=dYn9aTjLoKEn7yosOvcb2DvnqwNemMAkwpE/XB+oiCCHe0vvZfS0DZ2l12QnnB6cppYvPNQtTD2WQUNUxzScDBRuHdDUtFk3pxq0HxhRGTF8344pPJNbgUzN/kAgK7VnEm7bUpl94ZSWWiA6rwk6U481159mmbRvfnhwd0S7RDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186906; c=relaxed/simple;
	bh=4Xxq/TUSBfdBvryEcd1n7ej9Emw5QIQr2NYZ2skzr7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pS6bNAkHYY+NEfT9sMLMy6SCAUwoFJqq3WtGc3tWT1Eln4BlNKpw/7sTkid7QcNazQhro3UJU2xYFOzk/srH9N07uAaB+YryOFq8QnLbN8fa7FSuA5dSeLa9BhaPediyw8KIfLo2agxfpSonPf3LP2SpZPfY2A5aphqk5q9UgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=aP5M47Sb; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="aP5M47Sb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788186899; x=1788791699;
	i=markus.stockhausen@gmx.de;
	bh=guZIg66vcU98i9tHuSivOFpvVpM+nwK53Hyz7hksgUY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aP5M47SbrEyEUTEfT7XnwGxfAZSHHKq/kL9UZ+m9R9NpEfg36W9xf9gxnUbtxW4h
	 1bpmXYTRVlWv1rYE8Lvp5TpdIZEdOxEThTn30nr6HEvOTc8pXK9yATsEHJxrqoZ8G
	 Z6S6z3oS9txFfXx8PtGJuWhpkpVWNeIj2zVOf4PR2ZUTJs8IFoWluYy9U0wOMQrgL
	 T9UoRFqCmeQp9DvBQLbneSbdU/VjI1Zy7wJ/B2apv2KmUFM21dzf4xrTJlie0X7yQ
	 FREmVCZJ1YfFon3MFbtDcdmsO/KeZR33YGlGuroEX3RsnscoRmMevlbmaUjY4lfjS
	 uReky/4BGa1gCqeY8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Vi-1wq0XD1wnw-010uj6; Mon, 31
 Aug 2026 16:34:59 +0200
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
Subject: [PATCH net-next v15 10/13] net: mdio: realtek-rtl9300: Open up C22 and C45 space in parallel
Date: Mon, 31 Aug 2026 16:34:36 +0200
Message-ID: <20260831143439.2404484-11-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w+mPFNkTfxgsbgGKixHGpPqalnYiq/87/jRrcFXofYViDb4oUTk
 AXwEkCVjuwn+r9u0pYGZvsI+lNgJi3Yhpqs+ou0RvIDuuKiiCS5Yyk0Gd/zREsx60n5qhSh
 UBDkbkhi939azfqcDoL5AAGNTeXv0Pt1qKqaq9+yOEJXt0oZDGrV8LNqZAeIUdoHo3W1yYq
 XwpZ5Lku199grzmGnQnaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aSdLFq+Q1dI=;zSwIr78d/lh9S5YP56zhnSnSpw4
 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
 /ut2hcS4u1rZjAbQKmE3oql

Until now the MDIO driver supports either access to the C22 or to
the C45 address space of the PHYs. This is due to the fact that
the polling configuration favours one of the address spaces and
limits access to the other space. E.g. when polling is set to
C22 most of the C45 space can not be accessed.

There are however some exceptions from that. EEE register access
is allowed independently from the polling mode [1]. As the
downstream driver already allows parallel C22/C45 access [2] do
this in upstream too.

[1] https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/file=
s-6.18/drivers/net/phy/realtek/realtek_multiport.c#L349
[2] https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/file=
s-6.18/drivers/net/mdio/mdio-realtek-otto.c#L1072

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index ae7ba86e90b9..b90972c1dc6a 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -688,13 +688,10 @@ static int otto_emdio_probe_one(struct device *dev, =
struct otto_emdio_priv *priv
 		return -ENOMEM;
=20
 	bus->name =3D "Realtek Switch MDIO Bus";
-	if (priv->smi_bus_is_c45[mdio_bus]) {
-		bus->read_c45 =3D otto_emdio_read_c45;
-		bus->write_c45 =3D otto_emdio_write_c45;
-	} else {
-		bus->read =3D otto_emdio_read_c22;
-		bus->write =3D otto_emdio_write_c22;
-	}
+	bus->read_c45 =3D otto_emdio_read_c45;
+	bus->write_c45 =3D otto_emdio_write_c45;
+	bus->read =3D otto_emdio_read_c22;
+	bus->write =3D otto_emdio_write_c22;
 	bus->parent =3D dev;
 	bus->notify_phy_attach =3D otto_emdio_notify_phy_attach;
 	bus->notify_phy_detach =3D otto_emdio_notify_phy_detach;
=2D-=20
2.55.0

