Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8AF44C508;
	Mon, 17 Aug 2026 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984030; cv=none; b=cyT8vdmA5Lol7L1xbBsfIbmz5MbSCUGknEjfin3j+aB8LfbIFaWE4bS2SAil6wtvnXfNh+azel1iAqRTFRaFNzyQxuQp8z+I+MVQJL6QwQp4eYPI7BsTuI3Z/T/+2vgtY/QIJzO2i7PdmK++uqe8s1c6oHYpq2IAiGsMzgYJnoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984030; c=relaxed/simple;
	bh=kZOD2n7oePpkrNt30MSDc0q/7rMzp5l74KMr0HOzIQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gF0QDMfcWIgQun+VmdYoOAWdQBgdS83dkta5F/5/3Gws785JCm6YuZbmDqqrYwLWCAQVnxCAsV2JPwP7j45dj1eFhbUe6DMpjBCplFGZMqM6j6HdgQr9eC7Pf16xAHylMLY41NaJmwA9hYIRPyUfkT0yso1dJhlXmVCPanWE5ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=t2f24Gk1; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="t2f24Gk1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786984010; x=1787588810;
	i=markus.stockhausen@gmx.de;
	bh=/8eKDDbpjPYPAXbCYdjmEiFc4cMI4hEyu+DlIbbTnT0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t2f24Gk1eGJZ7e/Y6qJ7fb7ThfVSeTL5KTBZtZOql3eb2kubcM3LKP2oVPqnU2K8
	 sw9ZxGnqWRCsQA5ARwEu1FO/sV6WJ52dADOyXj1Y4kE0NbZdKPuZC45PcCNi9iqwJ
	 0o7zvoTN+aG/k25B7DL/mNscgvxEnhTrtim9SOxNSi6wEaXNYoE8edt8vRLR64pB5
	 2YUy37V2ZscyekQktyS2vMdOwg8IHY6hjcH75EuL2985/9x+tsiUcRh9kyuxJ3sJ2
	 AViEA60a8oHr8bBTPzm3Ooukw4sOlJB6ykskAAJzXkMdIT/7BR1mLcaxy/HD3+dGC
	 flU3jTHTkpeUxnkRpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUowV-1xMA0W3M4f-00YhcD; Mon, 17
 Aug 2026 18:26:49 +0200
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
Subject: [PATCH net-next v14 03/13] net: mdio: realtek-rtl9300: deny C45 over C22 access
Date: Mon, 17 Aug 2026 18:26:22 +0200
Message-ID: <20260817162632.1208891-4-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:ROl2DAWzXlFx0RO1evjbTjdsDgNg0ouOBcL9D6nM89uUmEn7Hu5
 mgEiqyC/TGbLUR8M2byDvsE+ldMKsyBIBOli5ALgUosQTi9SYFd9h37dtPb9dYSna+GHK3W
 MBIEUyuaqJNa7mUtrfbV1jmhZTPMiFhXf81sYwGlYKKHMPq+0zRv7Q/Y0r/r/Vgl9tyfrW0
 GeYzPATjgBv11wU5pVbLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/0xr4VlpiFY=;Ps4iHZJ9HY2fhgDujMA6vQEeiTi
 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

Hardware polling breaks C45 over C22 PHY access. Currently this
is accepted by the driver but it silently fails with undefined
results. Make the situation clear to the caller by adding checks,
returning an error and giving a one-time warning message.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 73ac5fdcd267..87b91aef9b56 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -115,6 +115,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/bits.h>
+#include <linux/device.h>
 #include <linux/find.h>
 #include <linux/mdio.h>
 #include <linux/mfd/syscon.h>
@@ -453,6 +454,10 @@ static int otto_emdio_read_c22(struct mii_bus *bus, i=
nt phy_id, int regnum)
 	int ret, port;
 	u32 value;
=20
+	if (dev_WARN_ONCE(&bus->dev, regnum =3D=3D MII_MMD_CTRL || regnum =3D=3D=
 MII_MMD_DATA,
+			  "C45 over C22 read access broken due to polling\n"))
+		return -ENOTSUPP;
+
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
@@ -468,6 +473,10 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
int phy_id, int regnum, u16
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	int ret, port;
=20
+	if (dev_WARN_ONCE(&bus->dev, regnum =3D=3D MII_MMD_CTRL || regnum =3D=3D=
 MII_MMD_DATA,
+			  "C45 over C22 write access broken due to polling\n"))
+		return -ENOTSUPP;
+
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
=2D-=20
2.55.0

