Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB84279903;
	Mon, 17 Aug 2026 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984017; cv=none; b=VpSksAiTOQUa1+7gLAB3H4/rfb/FCIe/j3ySw1DIs8/axM1Y+P5HPdC1vkTpbQsu20ixZSQe1hS6aLXc4lT9fcvbq3bzcwNFWClwdaPEhEfe8/VOnqCdbTFmeMHpXoVoVGnrVLcJv6f5LWLx9+tuA6p0hXBmfYWQJN1uq1MhzGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984017; c=relaxed/simple;
	bh=xw5AE3Ir1EG2IbK2XmjsVjlyAvF3FioBeH5OVXXXprs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cs0eXnN+HCSrno+rKk+tRgBN/8uh+gdvFcMwgkJHTKDZyiE5MH6n+SClFHS6/OF6UdeDtuKplrAQRc5IEbQgY7f8vomTrJcPR8F0exMgYUn1mvB2FYR20H/11aQh7WD1OFHeOHjBjInGr+Bd0yhT2bK3NE6SzcSAFjxIR0LGxNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=DD+B4GYR; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="DD+B4GYR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786984011; x=1787588811;
	i=markus.stockhausen@gmx.de;
	bh=pckg6Hbo6yhD6c6aDfpHb4Ba+o1d+AYhJKqmLbDV7yY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DD+B4GYRrKhjdWneXwK4UuqK1tysxVoUVdFK87JZSk3SQEfg1a+Vm+Dzlk9N8Jti
	 shGSwpl7U6aZcZXdjxOsATRoPLvP/YTwB5n8VViXmo/MRRfB6lqmc0xOvJr82pfHp
	 DqxxtOCVL9G8tI/e0B48kOID26s1x7b3io/3Q10mteRcGKVDGEE1MzwoJiFOjC38U
	 mORPB4vhMXl/pMyCpkZncpU4xUzTkJ8dTNljAC8pqBixtxwhCYKiFJGoDjrWStXg/
	 H3AHAuZVC43E/UEqsNe30T4E+ggeJjAiI05IhPKyOFOs+/iln/ZbAIWncXpLGKap7
	 pQrsg9HoD870p+y5TA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRVh-1xSCQ53drX-00RXfj; Mon, 17
 Aug 2026 18:26:50 +0200
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
Subject: [PATCH net-next v14 06/13] net: mdio: realtek-rtl9300: suppress sysfs bind/unbind attributes
Date: Mon, 17 Aug 2026 18:26:25 +0200
Message-ID: <20260817162632.1208891-7-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:33xhdr06PtpVSwoasYe2TEn5yKdsIsxskeX0/cQoh1WVHagAFJe
 8G3B5HqHzU8nHCBSAswS1RAL1ZZIglqVfiAu+myFRXr2pdHlRISnWT0HBkekpVDiroAPIK7
 6d0q6KHGcl/Jw9ZEqOEXnpjUIYstqCTMD8fGVp+v9GmpwUXxCq4bRdFQdPurB+AFZnw/NlG
 FBQrULjtx7ZdrCO/0HsIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IGHc5ndOrsE=;m6We59/mQiOXVlHJ5N3ByuSJvL4
 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

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

Fixes: 24e31e4747 ("net: mdio: Add RTL9300 MDIO driver")
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 87b91aef9b56..3360cadfb7f3 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -839,6 +839,7 @@ static struct platform_driver otto_emdio_driver =3D {
 	.driver =3D {
 		.name =3D "mdio-rtl9300",
 		.of_match_table =3D otto_emdio_ids,
+		.suppress_bind_attrs =3D true,
 	},
 };
=20
=2D-=20
2.55.0

