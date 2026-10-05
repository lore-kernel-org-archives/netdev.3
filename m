Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BC356754;
	Mon,  5 Oct 2026 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186570; cv=none; b=OVgr6u5l1FWuHfr13lVGENgihCZwMKbAdUB/pi5xjtxOgXPudh6LRdd9Lb2wYwn9XddK0RZ5joK4z080nnhYuoUgpDGl3ZJk0KRLbAPla4akCxxDJ1ZMaHL9hhmOPr3XkXRkGJnHtXeHn66FX1qy/lky5d4X3kNyCODPptaSruY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186570; c=relaxed/simple;
	bh=WIdT0aigGGswRVJQ4kHOsmyELSZ79AjZ8V9lms/4m0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlCqgkSt1dE/70meqsUA5dfsracUhULPUVwNid3Vi/ZxzBe6ZmN3gPxT5uUI/JgPmpIr1tAlJeWwPdG5wyz3HA2kB1JSOoQKXKunLm9P48WdJs9zXqyt4G2xch4mcl0rx+Ef1a6MEIbB9MMRWSEOqHP4cL04453augoswQ53DMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=WL9HdHNm; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="WL9HdHNm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791186566; x=1791791366;
	i=markus.stockhausen@gmx.de;
	bh=1WdTc29vPj6rVqcOupSzyxrmwRf3u6QptUUTawYqeW4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WL9HdHNmAVm6ZuorojAD9/RgZfh+P1b660WGstHmjZS4LTuLJxHogccOcKO8ikE1
	 B/rRu9IHaKxUPReGNnvBlq7ZDglyXC4PNHLA+zxtTKMCSbAPfWSdIwLEOQV6uOXgg
	 rHE8K9Yl6KuEKjP8SO+38yBoCCmpAKPKjCnspQzv0DEMxWU15Bm8B0LZhCIts/U4m
	 rRIzh6jHEivs7IUAlz9UjuVQ2uuGiFAvGpZV1rgjDrg/siGQ+DagyfTHBUGh2pq9g
	 5AWzr1qzYm0Vu2LAQQBlifcBTHuIGDlV63HfNadBXDT7hy4kPerHje0AqjfpLJeRE
	 Lk67EJatQ8q7jwHw+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUmD-1xOwnK3X7H-00ApNE; Mon, 05
 Oct 2026 09:49:25 +0200
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
Subject: [PATCH net-next v5 4/5] net: mdio: realtek-rtl9300: reject duplicate MDIO bus IDs
Date: Mon,  5 Oct 2026 09:49:07 +0200
Message-ID: <20261005074908.1273383-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005074908.1273383-1-markus.stockhausen@gmx.de>
References: <20261005074908.1273383-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z1zQ/yM54stex9dV3bujFFSJZGxzpFpmq9yaXwnmoAPjvE/nbo5
 9maFIJPnxKf3ERdIcfIamdvUqbcvZmlIomkKo7pM3q5ch9DI66tFSSrHE/jgHCnvNTzRI/4
 gaUcZN9v3IOoJILJee15EJj1wZdb63lsT+wHqLJ0gJDMImTSXw7QJuTU/aAeeHrBsByoLEb
 fv3ZBiitRKSebUUu08mhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:liOF5beRMVw=;coMik3tkIu4LV11cMZaOrNXvlF3
 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
 oVCDG4lA==

The reg property identifies the hardware MDIO bus and is used as an
index into the per-bus state. However, duplicate bus IDs are currently
not rejected explicitly and only fail later during MDIO bus
registration due to the duplicate bus ID.

Keep track of successfully registered buses and reject a duplicate reg
value before allocating another bus. For this use the already existing
but currently unused priv->bus[] property.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 79422893cc85..63ffb7f82b98 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -851,6 +851,9 @@ static int otto_emdio_probe_one(struct device *dev, st=
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
@@ -874,6 +877,8 @@ static int otto_emdio_probe_one(struct device *dev, st=
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

