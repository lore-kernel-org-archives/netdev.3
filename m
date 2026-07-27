Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9963B3C3F4B;
	Mon, 27 Jul 2026 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179790; cv=none; b=TfHe9pvhOb9xr/7Ea1Kz9hSD+kr9dSXl12AhdkOW7SJF7FCSim86TlLk6g7yEg0UArq1XEsiKcUptCFv3lPMixqoaGJfIxpKU48eInyEtxP7jDNkMhVa2xQMBtZs9nEDCgnHFKamZr9QUIVUWPFKuDIZG2PVXaJO1sIox7zDXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179790; c=relaxed/simple;
	bh=5mVaAuyLprgob4IjCHVRROZ1+4QsFW7lguncshMrJag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIkLWucAdnooxK+iwKzE7UEr2rN+fLhOC+43YNzNHwNE4OSVbiQ992VlczQXTKcCWyJlRbwTjoLwyXPpzQD5q2RoVnLK3hNTnm5P8fPMYRPnSgbTAXcnROxIGN5ionSXq08XE7JsL5gfWJNYxL86QFGN+fjpcsR/AI/Jr9vVDtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=gy9yHaY/; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="gy9yHaY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785179774; x=1785784574;
	i=markus.stockhausen@gmx.de;
	bh=qO1P5tDT6rfX9FnO2cmUDtQb1EcwRyW++fmLmdzAeAw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gy9yHaY/v3Gu6m0n1si2RrHlVlWdTb4PzsGaHtkIkCRlVCJ2zQELzSs5dk+DqlPU
	 PKzwgeJRYyEqVUS084R2/wDK4xfK2VUqKEBOpQ3QuEErutU3G18K0IZGRd6VnbUF7
	 rZ+5RuloJWL8TA02vR3ulBoKBRT2Hgkv0lQMZMhm3madN9CfISVQuXrZYxnnKbDw0
	 Dh6QmPURHGOVW3VCnpfqR1JoM16QzcxTJ3S/KvVj76dYBKUCkSiFWpJO7dfkD+0b9
	 kiE2yBcRF8zfnDHFG0/LCuOhezLqmy6MGw+iNyis//4dh1nNMU30G+LtxNQBqcFCW
	 MjAUykPIuRrD/cAzxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1wjSiS1YqQ-0016FZ; Mon, 27
 Jul 2026 21:16:14 +0200
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
Subject: [PATCH net-next v8 7/9] net: mdio: realtek-rtl9300: Increase MDIO timeout
Date: Mon, 27 Jul 2026 21:15:57 +0200
Message-ID: <20260727191559.19617-8-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727191559.19617-1-markus.stockhausen@gmx.de>
References: <20260727191559.19617-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:psQTjGRC8nafsi6eGHwZWtihZCdKOKF5COsHzf5256WaqWACfB3
 +utLRExC4kH+9erb9butO3aqfV5PG0+tHMiX6+dU0JhAtCCo/rOY9S531yAPlAVou74wKwD
 xgcT+p6ejPzhatc2iZFJU1o70u8JOemOO6GQwjqRdZ0/rIdQtaFMAlNi3yaC3u4iZpC8+zp
 QOFmGmvOihiDCE/wEEaDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nLkJ5HyAZZ0=;wiuLGZWRtARRs0nfyGXUEuMYJTJ
 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
 /iZwAtPCbAI/nt2Oaj8E7

RTL838x devices with 28 ports produce PHY access timeout errors during
one of three boots while waiting for MDIO command completion. This is
currently set to 1ms.

Background: Access to the Realtek Otto ethernet MDIO bus must wait for
a free slot between two hardware polls. The polling sequence consists
of at least 17 commands on the RTL838x devices. This delay can be nicely
seen when disabling polling completely. The following times are measured
on a bus running on the default 2.5MHz. Time measured is from the last
register write that sets the command-start-bit until the hardware
responds with the command-finished-bit set.

- average c22 read with polling enabled on all ports: ~380us
- average c22 read with polling enabled on one port: ~380us
- average c22 read with polling completely disabled: ~180us

For this bus frequency the bare hardware runtime for a single command
(32 bit preamble + 32 bit data) is ~25us. So the hardware adds quite
some overhead. On top of this comes the fact that the RTL838x devices
are low on resources (500Mhz 4Kec core with 16K cache).

Increase the timeout to 10ms to be on the safe side.

Remark! In a future patch the bus clock frequency will be made
configurable with a minimum frequency of 1.25MHz. Setting this
(e.g. for debugging purposes) doubles the command run times but
will safely stay below 10ms.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 6986bed5258a..ef4fa8e8274f 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -273,9 +273,9 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
 cmd,
 	u32 cmdstate;
 	int ret;
=20
-	/* Defensive pre check just in case something goes horrible wrong */
+	/* Defensive pre check just in case something goes horribly wrong */
 	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
-				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 10000);
 	if (ret)
 		return ret;
=20
@@ -315,7 +315,7 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
 cmd,
 		return ret;
=20
 	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
-				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 10000);
 	if (ret)
 		return ret;
=20
=2D-=20
2.55.0

