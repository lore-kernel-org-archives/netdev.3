Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6736B44CAC1;
	Mon, 17 Aug 2026 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984021; cv=none; b=u/QKQVKdmdBZlRibSZr9JXKx3a+0JCuQtxcX8Xvx721AugmGjGjHLqhwZB43zXHnSv9ZrieVuNowCJJzwfFl36D+A5yTVmllti9/VYvDVEKK9WYzvvutHq24cEz601MlzW9KY0Wd7CNQfNxwQP7GNx8msTf8wJmal6Yohts9Rno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984021; c=relaxed/simple;
	bh=50asmd0v89jf8sbiXlPpH7thJaGXVHVcrBtxEUqQazI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzQyOUE/Ck3QzG8M0eJnQm/+LhA6+WsaxBM3KtKbbedRHx8LR9954TVeS1wgSi3g8bIMpL8PiUBa9daHCQBlsC4KAJHMxbTS1UHgGi8gxJ9PnwJSTkv9VXl1ADk8ij/ynWE+jc80h/rciqOZEmQm+nMsCz6mG3F62Os96URbFfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=qvaRaw95; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="qvaRaw95"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786984012; x=1787588812;
	i=markus.stockhausen@gmx.de;
	bh=TlXtvVBokk5CZAnvMEuEUNfha8Z3BonhxpKBaDkqRPQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qvaRaw95gli8Ky9oVXGzYyJRIXDCPcY5/er2nZQqUp7ndWS0pPMO2zz6HfezY7nI
	 wjlsR3Y3cNSWZaZkGzZIQA/Z8wVtkLKjvuCPxtEl3JYZiwlK1JtHMSVTrRN3wZphz
	 JfvJXphi+MRduGCruG31UnjeAP/BN+8MGXvZ7rjSlL4aESQQN4x/n2ktbDHIpub5V
	 LdzCf5oUS1/YwPWcY8bRQDXe1ZRBQB34lP2aIQExcgo/Lf00zgSri027GHlI8QfvN
	 iykljfZQyGt8ZEHLTrgMjG3C2DbrrDxbQBDY0weo2Bt2R7wltBCTl7SIzH6hluouG
	 9dU90kDZxnQ5BrlFcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1xJ9CK1QSi-00Kd7w; Mon, 17
 Aug 2026 18:26:52 +0200
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
Subject: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open up C22 and C45 space in parallel
Date: Mon, 17 Aug 2026 18:26:29 +0200
Message-ID: <20260817162632.1208891-11-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hukWj5I1Al6cEs9s3HM6HNDXOQD7aQunBLfGyS0mtSKiH1kfhTQ
 XJ6hYuVoiNd4+a/D2rczXdFTEhDAqix7j6qQzD6ElgdNrPMm7PxByiE+mOmgVkW2+zTHhXO
 hY/lvK+j0DMzYCsdo5eQ0yhCK8GN7czB0q1ZdSLAO6jYjAjpSsTwhkPPsgUlMCczyHBJ64B
 svBb2zJaZ4eMq0OJicmHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QhlcnsImibE=;10JXog2tBYKEPny+VoWZ0iFZ2Ku
 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
 3hevkvvwOBFutYrH+jE=

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
index f3777c61705a..c417a2e3d613 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -683,13 +683,10 @@ static int otto_emdio_probe_one(struct device *dev, =
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

