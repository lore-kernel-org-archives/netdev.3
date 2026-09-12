Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080F47DFB9;
	Sat, 12 Sep 2026 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218320; cv=none; b=mla4TDVmL2QdLgzLmjyJ9C4yAKwzeI4xTpM1iy6DvRbJhPVY9ajB0Z+e6KwSWp+ZQa7sHFv6Vty8aCKfjs0bHiY1q1sS35WLAddgAB+Q1sMOijnjGyCojz8oZzGPFGk4QxQkahee59A9zviueCFuYIFCwK3zRzm/iDmmcijLLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218320; c=relaxed/simple;
	bh=OL48ECLz4corOWXRjDjrbBEuKa9WWNVtic9VmLmHi14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8/z3108EuflS/FQ9nToXRDeUddJVlRfQUcO+SY21/zuusi8kaIE2cFSir2/PdPfxLNqa4b94KBXoqVx4pAOVk5SHuYhZKOxhWoFh/4fnN4LB0U5NouMn5LtHxLvVATkC4uYInJG8vOnjUpRMRqu0NSp++O76+WqZ+elNgrustM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Fpi1dGs8; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Fpi1dGs8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789218309; x=1789823109;
	i=markus.stockhausen@gmx.de;
	bh=qCko0zT/+9pCEI05GD5Phb4KNIYAMRHnlhQf5Jy+gS4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Fpi1dGs8bMyOn4s0RFKFkDUtYxnNMTRuWGtVTvk4qwCPmXMKThXKjOwr7lZF/2or
	 9PskdXXyRTFr24meinT+1YIJQIKZSyy9NQZnl9feB6itx7CK8E+Z/8xLTqJPXY74V
	 sYo4fCL7qL5sjTc43z5TZFAvkMmh9HU4jbMOgOqgTFmNl1IT4C2EXPG79e2sIy8ID
	 nTIM7WjKxf43BlZeoMvjYuTCXvUq62gNpiMX3Xh/huNer236M8n3cIJx1eSNVv3jj
	 ZSXz6N0k/lFci+nmOuXZ4vDx9ICIB2v9NNRMpo108L0fTjZ7d4DTz/KFt6pqlyLwW
	 tnzl1/Om41JQ1SonaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mBa-1wgAZN2rk4-012Jzf; Sat, 12
 Sep 2026 15:05:09 +0200
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
Subject: [PATCH net-next v4 4/5] net: mdio: realtek-rtl9300: reject duplicate MDIO bus IDs
Date: Sat, 12 Sep 2026 15:04:50 +0200
Message-ID: <20260912130451.3757276-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912130451.3757276-1-markus.stockhausen@gmx.de>
References: <20260912130451.3757276-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5bEVmqeKOhynLk+bGLsmkru1mxFCL662HuWaqJa9BnEsaP8ttc6
 lfoW9tAFPwnemHOMMRmO4t5l/qMT+/WTDAepnlIxZKlD/5nyLXYDuJTSUXa127cWiRWeRmD
 IC1DqSh3zj05cxZtgacjICJOtgrhdi/K12S7EgKWpZGfUOyI9WUl/BNgjRasIT5wFtKrACB
 XmsFwsqlO/twuamBZf/uA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vjt+WWzxPvI=;gcSU5xA0KGNqnnX8KlEhg+90SUk
 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
 BSnhLssFtP1Fu/Uspl8DNd8uHg==

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
index 8ca917d9aea3..45cbefc52100 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -845,6 +845,9 @@ static int otto_emdio_probe_one(struct device *dev, st=
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
@@ -868,6 +871,8 @@ static int otto_emdio_probe_one(struct device *dev, st=
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

