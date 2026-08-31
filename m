Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A7B45040B;
	Mon, 31 Aug 2026 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186926; cv=none; b=aX/3veSWxIgLJtwcFCVmfvMvREnLTMjpRDjJydVX5Nj/4lxndaDM2kUA9LdpQraD0nE2osPBz/TQlmfNU1HE6wWcTE+kQTTANRh8ubaC5Cm6rzi7muOqwEYWOBPYzkwrGpRlc8I47eE/DnuARDgsaTjvhLa4NztdHPjcYwys+kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186926; c=relaxed/simple;
	bh=FO7q05gOR7vjGsCtLBGeaiNEBRtSh2qgUtdF5VjOVmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWkZ/AaQKbmpcU8D5cKCGZAHUMIRNWUa4pUwPyGTd6mVv0NTikNJNnjHIV1eNZ7rUiqyGzD0sm/oxDx8EW8AVhf1lYGf4PIDDAkgYVEFkiO27DPfOGsa1SHWqPub+XVNsi2Nidu8mW1DBWyVmyME8EOLpbwM+hiXrr+PWGY6Smk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=gzEzAdPI; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="gzEzAdPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788186896; x=1788791696;
	i=markus.stockhausen@gmx.de;
	bh=0lgMHLQ1b/VPmNEa8gOlTbR8z6+OpMBJS/LWkuxdUqY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gzEzAdPI/mebzjFy5v25Kh1ZlHN35uSAlLQRVV+OpWWrRYWCCF3yPv4UwkMLMBhr
	 WGea6C0V8om4kecyAA5Cg3Hj/bSZRNCg/JtBy1FWg61IoMyHYCr5XErt+BQYAokht
	 tBGpJqZgZPSfzDlfjC7tRzlqe6eZXt763JOIuF9yPJsn4gQ8E+Or7Zoqf8n3cCUB3
	 pj7Gytx+NuWcWdvZHRQJ1HJwV3w7KZy34x2S5EBKFNcRe00ges+MIOe0+Cu5l5ggB
	 UKx72gVA5leNo9kxvMV8rh2zxkMui8DIEvmZcfjcRKVqvtGVrrBZDtLPxbVNd+jbC
	 KYSxWCU7qk8ICLVueA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1wz7Hv2gV1-001y1P; Mon, 31
 Aug 2026 16:34:56 +0200
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
Subject: [PATCH net-next v15 03/13] net: mdio: realtek-rtl9300: deny C45 over C22 access
Date: Mon, 31 Aug 2026 16:34:29 +0200
Message-ID: <20260831143439.2404484-4-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:fBx9l7scVXTtG3fnSyuC9o64DX2sdtzCv9A0X4GnEIX6MDNO88W
 MFkekxXSvYA9q8ZvAZrO2m7OHaEkYLAdFCXjwnT+PMou9Lx3XIcFz1WloOKWDFJHjCKW5Y3
 Fog7pLoyIDyThuTsGPbcgsG7avYgmrtFab2tvKCH/GHYB86AVZhzt1ExJGo+DWwccqM5MXs
 OkcT/A9exLRfVSpM/P2VQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+afMg67D89k=;hmMBgvT1GfyvnAf7SAlGjFcvNIS
 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

Hardware polling breaks C45 over C22 PHY access. Currently this
is accepted by the driver but it silently fails with undefined
results. Make the situation clear to the caller by adding checks,
returning an error and giving a one-time warning message.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 73ac5fdcd267..69565a87f99d 100644
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
@@ -453,6 +454,12 @@ static int otto_emdio_read_c22(struct mii_bus *bus, i=
nt phy_id, int regnum)
 	int ret, port;
 	u32 value;
=20
+	if (regnum =3D=3D MII_MMD_CTRL || regnum =3D=3D MII_MMD_DATA) {
+		dev_warn_once(&bus->dev,
+			      "C45 over C22 read access broken due to polling\n");
+		return -EOPNOTSUPP;
+	}
+
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
@@ -463,11 +470,18 @@ static int otto_emdio_read_c22(struct mii_bus *bus, =
int phy_id, int regnum)
 	return ret ? ret : value;
 }
=20
-static int otto_emdio_write_c22(struct mii_bus *bus, int phy_id, int regn=
um, u16 value)
+static int otto_emdio_write_c22(struct mii_bus *bus, int phy_id, int regn=
um,
+				u16 value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	int ret, port;
=20
+	if (regnum =3D=3D MII_MMD_CTRL || regnum =3D=3D MII_MMD_DATA) {
+		dev_warn_once(&bus->dev,
+			      "C45 over C22 write access broken due to polling\n");
+		return -EOPNOTSUPP;
+	}
+
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
=2D-=20
2.55.0

