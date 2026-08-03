Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE782421240;
	Mon,  3 Aug 2026 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777562; cv=none; b=GzQs0vs1/qsd1UOJpuFDAwLZ43Mv61WvSEJddtAuVSnnvxg0CgIE8JbrAsyf6hJt6iimFIc/7La8K4AsdiS9KG4HoM//a8eDtYBahp4IW6d4zKyqo5Jd44BfwJgHzXR7X8FHES9dIsI2Mn7jmwxt9LsfoWM8V1eLa4fUiRow+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777562; c=relaxed/simple;
	bh=eGRblj0aQ+CIoO2i96zWFxt2hMUQ6VzGffxPqaRiOi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJQXzPX9it3Hts7WmFIf4dfard5Qq7vC1zznIVV8kg/wF2130iSqoMQMkjtJg/+YrFS39OBf74QnFRtfaAO1JyWae7Tt24NRom2pxEtY3aWGM+v8MuTwkH9d6ckm6/cy7Sx/b3CrIm/m6NB0yCKtaKqtGnTOO+yklDIy5EAJL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ifcNfn1t; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="ifcNfn1t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785777552; x=1786382352;
	i=markus.stockhausen@gmx.de;
	bh=n2prthgwjvFWlQX0XxMCJUlg/PFtRnm2Fr4r9UdXcbo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ifcNfn1tW5yFHQGppV2db9BsGQPJivi9ETFlcLYWQhSWXfvIBV1FfVRQV6WMIUsh
	 cs12Qdu1pPnr2ugapAp9Dcbfg0HxxZtwS2ZmFc30v/mW8kf8+kEh55FwEC9hOhiW4
	 HHFre98Fbx0vDs/qSo1VHt4ab506bJXKYVhNdBauV1hPiO+VP7PhYN80a4dNDCi78
	 NZI3zkm84kuYaRBmtIPTBzYZBhdFQ3HZSXPVv82gjtBWGqrbN7bBcoRPAqymvwnPd
	 Lkm1u5RuYOWvhOHQ8593o6Kkbfvh/7W4/fL8TjmVncqxbciNhNzxVCid89IiloSHB
	 C7SFbZiKpse30hYUXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZkpb-1wO2wJ17l1-00YT8l; Mon, 03
 Aug 2026 19:19:12 +0200
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
Subject: [PATCH net-next v12 04/11] net: mdio: realtek-rtl9300: suppress sysfs bind/unbind attributes
Date: Mon,  3 Aug 2026 19:18:46 +0200
Message-ID: <20260803171853.507506-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803171853.507506-1-markus.stockhausen@gmx.de>
References: <20260803171853.507506-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bc04mdDrnWUjvD52cDW+zMcatF/kvX8rnP+yqLiSnYR6w97cYd1
 iLy8aNzQtpH8HVXVR3X265gt8BWqVTHepok4V49D0WAH73hbx9LRki+YGSrqNFaVk0pgTMa
 4/hxYuq5W26BvKyFHLN2N/dwPySvljiT8HdRS1EEjYi5v2vHUQxveZO9Xgltn7dIUghuEYA
 uSowEGhLpbi0lMo9pO92Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0R+fAq6uQxo=;VSaa4/aBVnWGy1JkKNjcyvR7zJI
 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

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

