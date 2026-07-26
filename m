Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774022D238F;
	Sun, 26 Jul 2026 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050316; cv=none; b=RRbdzBhR5CYWxkXKwhmLGI52hpYXSTeLcYXsO/CjExduSS0Mngb3l6ePUH12Ori3WHUKxIH5czf9H7+rhYbrvqGCIhY6uBLih4wj1PMRN52z/dFtvgwrg32fkvrdBQ+nisCvWe5vAgzdFOARBQ901unjkOtvou95TCjT6Bwo4Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050316; c=relaxed/simple;
	bh=CuCHS+T80K3Hg/taiO2ji5jJy3g6CZqYKfkoQ6I3+rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/9ujQ2kDzb2KRSz0DuOFnE/GoaPuJT21/rE2I1vHliYF7BzfWimHyN1WpT8OX+8x1sryqMKDh7afwhLWVdDbMoZIhnXfB1Y5IVOAUrFvUVBef9yLXYnA2PsSEArMemL02DhLi9i7y0siI+gkvUbvFixv+Z1/yc2tIHD7pPNKJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=AFKVYIBP; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="AFKVYIBP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785050289; x=1785655089;
	i=markus.stockhausen@gmx.de;
	bh=gFzKd0YyLNIKh74XrSMg0Tth9fyuug6lL/sX3WS1sYU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AFKVYIBPZN3HmHTe4CBnSmthPqnb7+g2oQEBKKE9zMqxtST7yiNbQqLLzuuhR6Ak
	 eqWTYoWFW8v9ySZeSo18Q9TVQJBtlsccjVd8rP4er1gvCGIlpInkHjQ3LvSOWrWpc
	 //iLIY99r5+ihD3npbgdSVWjgAiqazeVBWubjmHD+BjWGxbBl0UuBORsbH7Jcee1a
	 zFGWjcIVyvziW0Yp1k7b+vfWP/hjAVtbQIh5vnJSuKBp8g1LhSXGnsDB2K4fZc8MK
	 s2UFdQYnPN1xFYiP+cKuxJ0NWFag7qpYXUsepvwYd15jFH1YDRGR5K7CebUpgIhZ6
	 r5HFH4k0VecIr2jhzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79uI-1x24Rp1Zxk-00tXkw; Sun, 26
 Jul 2026 09:18:09 +0200
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
Subject: [PATCH net-next v7 6/8] net: mdio: realtek-rtl9300: Increase MDIO timeout
Date: Sun, 26 Jul 2026 09:17:49 +0200
Message-ID: <20260726071751.1359156-7-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726071751.1359156-1-markus.stockhausen@gmx.de>
References: <20260726071751.1359156-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:spLM1j6A014MFhNR1hflED2zK6nlBvZsaU/Im8cuBZvE0UYyMyz
 GXRQ70Ns+oxzP5649tmEUpMVGSjSgNK2f7wIVKRUrvTUZU3rskHfUrWLtRSzPwEBa2X+uoj
 Uzgq5h5/OxdiLCcocb5okiBd5dkQIxor/+Dd+UfpukKPbG6/pbP5kbJQTSt88Mk13rqrkKM
 cUCBIoCYebu2afY/VnGTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0PeFehjVPTI=;4ay9bU0mtI1lmdbf8KtRsWcJitZ
 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
 CTsPVlOyy26OrgOKuyhgt

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
index 07dcc2231582..f9c02140aba7 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -271,9 +271,9 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
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
@@ -313,7 +313,7 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
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

