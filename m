Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD243B27E3;
	Fri,  7 Aug 2026 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122698; cv=none; b=e6b9T4BfPZqN+L9KJZaSs80Q9Kx8Ec1/dsfRJJiXHJtqTuVc7jyjw5OZ4SxfcYbROhtCX86A9PpIWloO8mxvyp++4rg+OwXmxM+MRwqW+8J3Kk5BAL+k9tcedI/X/JnHbBVq2QKaOA4j8jJNaKHcDwQBrP7IzLu+DIWxZZ/DMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122698; c=relaxed/simple;
	bh=im8rsPDuu6VHt5wRCMi+LI3RVLs/FkqjNIffwRt3HuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ne5Leu3+2rZHjS7qUVpfzFA7d4/S3Kpx6BnN61FtSLQe4AR0eNg8H/cxkEc8O9m7G+zywnuXnOgS7pFgGwJsp24aoXC68BG4sOBtXGm4aMWYrIbdt+AprCRrRVvRh4EcnsKaA+8/2qQbdfUl2+PPexV3MQWXKBip/2059Nbgde0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=T7kEzBxQ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="T7kEzBxQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786122674; x=1786727474;
	i=markus.stockhausen@gmx.de;
	bh=ynLUkNVxiUVhXM3BRWHTLeavmaSh53U2wAJWMFsK8as=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T7kEzBxQiD4onJVeXrubo0qMibZNkHaKS03ROdiYrzunW0PxX5hm9xRSJHkY4sEG
	 wOdCQtL26NZnvE8DwvfYH0X5YGPSkn0sIhONXtPrpToNuYOmO3uWy773g8uiiTIv0
	 j0UQhIccAfzR7idQQDLsQ4VJnIwYcCYxERVFMfYU02d1UK8Bj+iiZB+ftbvy6bYuh
	 kY/eIzFO13HkaV4AwAmM4nCQvyf1b825MJkA+SytgDFdDVduTbMljmm4wuZ9VyRKA
	 rcvSWLm+uf7VSRDaw7LFTV+8PaV7DVbAz58ZTDErosTEidhcs+XtomPc/NKjDuHff
	 Q3blYGBKcKZdHlRPWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3mz-1wU1kY3cSZ-00Vxvv; Fri, 07
 Aug 2026 19:11:13 +0200
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
Subject: [PATCH net-next v13 08/11] net: mdio: realtek-rtl9300: Check for C45 support during setup
Date: Fri,  7 Aug 2026 19:10:55 +0200
Message-ID: <20260807171058.522833-9-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:1N3I5GkCkKxgeTjmUQb2RoOFrVTiJ92RwjIOrFqHbiNyWj8hPRW
 rXFJtqNRvaO8kNB0WOZJV6PhTabUac2s6AxK9ZZHnITNQz9gH271WXvVRUqrpAgmJ3ddhVv
 ElmApvox5QA8lVLhnmnsDIknnSyGNM/qFj8iMsA6rCqX0bUdLU9q9Pe1jRuuojgpJab7vwh
 PazBKic+IAO8eT7jVqnqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BtakJw7bcFw=;76K7NLmgGPS2vCBke47hKi2UBE+
 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

The to-be-merged RTL83xx devices have only 1G ports. Thus the MDIO
bus always runs with C22 mode. For now it makes no sense to add
those devices with C45 helpers that are not used at all. Add a
consistency check in the mapping helper so that it aborts setup
if devicetree defines a C45 PHY for a device that has no such
read/write functions.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 88ba73b2ee81..22b1c4e05354 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -782,8 +782,14 @@ static int otto_emdio_map_ports(struct device *dev)
 		 * (i.e. clause 45). Select 10GPHY mode if there is at least one PHY th=
at
 		 * declares compatible =3D "ethernet-phy-ieee802.3-c45".
 		 */
-		if (of_device_is_compatible(phy_dn, "ethernet-phy-ieee802.3-c45"))
+		if (of_device_is_compatible(phy_dn, "ethernet-phy-ieee802.3-c45")) {
+			if (!priv->info->read_c45 || !priv->info->write_c45) {
+				err =3D dev_err_probe(dev, -EOPNOTSUPP,
+						    "bus %d does not support C45 access\n", bus);
+				goto put_nodes;
+			}
 			priv->smi_bus_is_c45[bus] =3D true;
+		}
=20
 		__set_bit(pn, priv->valid_ports);
 		priv->smi_bus[pn] =3D bus;
=2D-=20
2.55.0

