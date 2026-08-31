Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B430B4508E0;
	Mon, 31 Aug 2026 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186925; cv=none; b=U1piZhaYO2YJCFjU99IF1ImNLnvJ7ZSIPNlNQkSbMLQvE1kUkdBtE+dzapSpvIzEZb0eKjzeydAyREZhkeKb7ocAWXhu6TXkhTffBDD29dWW5oqA9X1i/ZbuglAm4DqJ3wo6iWqj4PCmIzK0f8WYBP6qWTHhVNNIMoZbVOBcH4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186925; c=relaxed/simple;
	bh=iyPZ3ZurK+7yLwGWinDW75wS8Zt7kQ6m4k9IVCvb9vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwgHYf4o1w9wfTIxxQPie42irSAiqdhlfA5MFMbd1uMGjkiPOOOQwV72BHYeTuXW83vlKMvH5ZdFDN4QlKNoqHOSC6jUg56cKdguD9YjHzxGieevChOJARz8DHlAamllxBUKlkd6yeuzYV5AXzRWDeDspI0dWblPMN6EVrgZUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=JvIK6agu; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="JvIK6agu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788186898; x=1788791698;
	i=markus.stockhausen@gmx.de;
	bh=tPrSzoytq2XlGr1YQP7x20woHgS47Yn/Xw+/QSslyDk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JvIK6aguA2j7rD/3GY/uzxsHJPEnY2O4mI54lb3UpUBBDxtLxGgFSuJZ+Q2lZsbI
	 /ybMdTps2b0BjWf9GWSMsLqbIlG0NWU16vre+Zw08/98MwPN4V6sOyfNcY1WjTWJB
	 7mWrTpO2m/cb89vx7SxLz6lcfI6lvs/BB6WfWlr3YBlA41bpyH1DybvNaS0QvHFHi
	 HwYJDA4wiJrfffFlA2jo1gZM7YUbLD9UiamrjDh6SQb1L3x+5Yt22B94eBXYRWo8c
	 J84EEOBSD4ozpeFaY54nZusrPK8XS0hguBCSaMRDMvcsnrilZD0d0Y7YigOmFuXqZ
	 wKKJf8nO/XNhG+r4qw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1x7OlE3K49-00ABTx; Mon, 31
 Aug 2026 16:34:58 +0200
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
Subject: [PATCH net-next v15 06/13] net: mdio: realtek-rtl9300: suppress sysfs bind/unbind attributes
Date: Mon, 31 Aug 2026 16:34:32 +0200
Message-ID: <20260831143439.2404484-7-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:BjSsZaF9MCte7IZncy72VVmZiuXqAphSk/mkUbvxpGK88jjdikS
 slybrHNkkEqZN6lKlIzq6j6SQUkv4vQpk6AGx17k5Cflv3PSPxfEtc7CbiFLJfdVpPgES8V
 hYMEcaSRFBgGzetatfnqxEZqYScPjL1o3kUq7vQFbnLJ2RRQOyr2aF5AIIf3CK5NtQOBzxJ
 TInlQ1l8FZGJhTBeuU7pA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KDdSEA0vGSE=;JH1fNQMCi3VsOvgk8dZcOidAXzD
 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
 NExUkzkdpQdbog1imR8S0uI

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

Fixes: 24e31e4747698 ("net: mdio: Add RTL9300 MDIO driver")
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 69565a87f99d..7de8adec243b 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -844,6 +844,7 @@ static struct platform_driver otto_emdio_driver =3D {
 	.driver =3D {
 		.name =3D "mdio-rtl9300",
 		.of_match_table =3D otto_emdio_ids,
+		.suppress_bind_attrs =3D true,
 	},
 };
=20
=2D-=20
2.55.0

