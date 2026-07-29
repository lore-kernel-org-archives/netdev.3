Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6720453A4F;
	Wed, 29 Jul 2026 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340993; cv=none; b=XlNkMdJC2oHHu6itp/R0Xd4u8hGp7ptfo/pFIOPtsPvt4W2i2K0OBAa1iuGL4yHKNc2VExNLiSH+/ve1eahwlerv0C82SzrDTN6kqg4bE4aFK3bu1eDMzAb1XeGbxFOm1ibR8s2KDf/j/SEeIkLY7nemGe4n/UGr3MDcfUIvfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340993; c=relaxed/simple;
	bh=UI5sXDxX9+XVNVzWbQv+xHn9/mBY3OrN8YJ1o8odtOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfeqAeQBjnsGhlGEi5ja1zGuiPLlQOswoFju4eSR0w8mc+uPEEQsonLjeCuiPoOktEjNzty7x9lhBvtzNdiQ8KZQsueRJVgx7GFEYo2/bmn0Qne+bon7AF8/YvvX+niB2fsE8cLSpx67Ky7PpjPmkTcMS768r0RP0HyFhnRv9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=JSvGKNi7; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="JSvGKNi7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785340969; x=1785945769;
	i=markus.stockhausen@gmx.de;
	bh=tBFZ8OwXzNDnN3kTvPglkN1EquN0hIarfFZ59FaK4qc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JSvGKNi7TwM16f5Tm+BW/x4n5w8oiYst0WUGqyl3BMUsqxDOl7xYfjbP3RBa1hoy
	 LcpUQvrtEKrpQdd5DheJKl5ng42g7CasP5PlXdNbba4fg92yWoA9UA/kUb7yIP2eG
	 WinsckNcVEq1L1ifOJ8ic5aLmFKYhsf/2RX/aSoqRIDdHZBPS2lG1VUL7sGlnPtZ2
	 WxRFy0gCIIo/sz4gtlk9B7WD3+TyDiO7XBZJYwb+Lamdo3fC9uouWJJqK9RsE7aCf
	 xr4xGSDBvrea+9PZvAmbl+Zf0bpXAfMLzmS8RKxbb/IyhVeYsTE/E1dn6YcYaZM/m
	 k9g+wwRjrJZKGu5ecg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0Ne-1xDPzk44mO-00ZIlf; Wed, 29
 Jul 2026 18:02:49 +0200
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
Date: Wed, 29 Jul 2026 18:02:25 +0200
Message-ID: <20260729160227.155613-8-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729160227.155613-1-markus.stockhausen@gmx.de>
References: <20260729160227.155613-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p2EPMixrfs6An+5fy1y0gBTGujqpMY/wVPsD+ujc82ThelmgJNu
 oD9cz42HI12bX48GDFv14VSO5/9BWv/Cf+v8q+mro9QqI8MLv6J8XL/jviEXl9jMfjjLp3X
 CFN86m7UDE1v4qt1JzxNpxFJK7mLTlAd8/Cpb/9su8UdyYI3Mm60CjllcZ/13V2uAPN/Lku
 2BfmCzFSBB7AYHR6BhYAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y1JCCVn8X+U=;0oWYQ0YEfO26Eo22jWMe9uxFQ3q
 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

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
index dc3661b2cd94..543f16f84133 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -275,9 +275,9 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
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
@@ -317,7 +317,7 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
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

