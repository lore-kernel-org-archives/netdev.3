Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C895C563295;
	Wed,  9 Sep 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966106; cv=none; b=AiSXVaCZWnZDIx1mSenlYl6dPMopXtY+x6yXD96tbOLYdOaPfqEMDRG7FdI94sUwmdEnIGqH1WY+shaS0NsQgQA363GsmBuq6iK5wSmg31pHFMamVI6/mWi+RJRSJSOdImDFvnTOd0cm1e7cb3LDpXGFG2fUh6vYHe+fD+vbyCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966106; c=relaxed/simple;
	bh=zdFOdPEKO8fAgtOp1xcwHR3KuI9ZNWjUNMt08uJjsIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2IfR3TFzBVpqJ0JIqe4b5xjD60yqtfKuTdgU15sBFP8dmDSjfFCDa64kSnnchRfCpm4y6nybyir6EM3I/2/pbJ5zNhalGnd54KpD3DK7gEMKZW2T8KlEt7lXIpzgoVW1Sk54+T6oZwo1xzEe4CrUBoXKjqAiNWULiiFo5BIIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=MEQ6W2+w; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="MEQ6W2+w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788966089; x=1789570889;
	i=markus.stockhausen@gmx.de;
	bh=ro4KPZjquKAkGfInjdfDp4NI1D3ahj/48HbhBaSlHcc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MEQ6W2+wRqu0lXjbCyUnZ3GOd5MYs0irRP4eJKNt0gspEzRP2m7Gv856PcMlW8qJ
	 A0l5EqMVlqVgpGydrMM2k+67XvZUtw+n4FMOtNtOL1MYrJxFC6nH6wVWasehDlGdc
	 jWA9AtZDGr1dfRi7eOOXJAXkM2kNB3KO2RXwzi3dI/8jBAi/EvbgYcc8vjmCelJyM
	 tm+wJPb9PjAUs1DQHN7zrVDjWh7/ShIlqgMDlV3rxO0SC7k5h+R0MGcfgpw6U021Y
	 mbu2qcoKxUkPIgvBqvjZHxiU2Df64LC39WCPLF6GoGLI3Q2T3PwNM01A/3uLjyhnC
	 Pm8Ub+3wGm2tnHyuzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCpR-1wWdDC11dP-00dXK2; Wed, 09
 Sep 2026 17:01:29 +0200
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
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v3 3/4] net: mdio: realtek-rtl9300: Reject duplicate MDIO bus IDs
Date: Wed,  9 Sep 2026 17:01:06 +0200
Message-ID: <20260909150107.3602067-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909150107.3602067-1-markus.stockhausen@gmx.de>
References: <20260909150107.3602067-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pn7m5tGsZtdauFYqmJsEuNK8K8w8WVUi8s7O4pdt1IUf5ryYMTO
 768OdDpmFNi+F+agbVrmjPb4rllvy5tzFG5Pof9X4I2Ni7MpzQdPBDdYsy1uPhey5noWx/6
 /sS8RaZ73SilPuwaXoe+HvWOReZXm6z7cr9pv+xVwPJYUl5FmECp1XlTJXgMR3YBjXJeMYi
 xBgvAjsUUGQK4Af7G6j+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oJsXxzefJD8=;qUg5AVWKUfR8/tBs4d3JcHU1/Yc
 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
 WGPGnBRmVDsRCwzQKzKRwVnfow==

The reg property identifies the hardware MDIO bus and is used as an
index into the per-bus state. However, duplicate bus IDs are currently
not rejected explicitly and only fail later during MDIO bus
registration due to the duplicate bus ID.

Keep track of successfully registered buses and reject a duplicate reg
value before allocating another bus. For this use the already existing
but currently unused priv->bus[] property.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index de0204d8be48..14fc98949fa3 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -846,6 +846,9 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 		return dev_err_probe(dev, -EINVAL,
 				     "illegal (dangling) smi bus number %d\n", mdio_bus);
=20
+	if (priv->bus[mdio_bus])
+		return dev_err_probe(dev, -EINVAL, "duplicated smi bus number %d\n", md=
io_bus);
+
 	bus =3D devm_mdiobus_alloc_size(dev, sizeof(*chan));
 	if (!bus)
 		return -ENOMEM;
@@ -869,6 +872,8 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 	if (err)
 		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
=20
+	priv->bus[mdio_bus] =3D bus;
+
 	return 0;
 }
=20
=2D-=20
2.55.0

