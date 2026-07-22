Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB3342CB3;
	Wed, 22 Jul 2026 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701478; cv=none; b=WIvcSsx0ITLGJCX2bkkLhbCgtp+DHNYef8PAw6sY3Ltuix4xjb2E3CMvBECezcuKOontHL4GKiXDrwHJfJ2IrsUiw1Kqk+fwjcfTPWTTXt0yBescZze6kXfy9fkkfT2ckxUbhLmZpldBqTrNsWqrDH8acb+DPolXXYAyyESL0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701478; c=relaxed/simple;
	bh=oB2oGMEsUijvpoMtOAfjPVR4DjajLzzwSLhf5Ef9ULw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpIrtWeTG5QFMu+NwisUHOUcjljC2OjqGUiOZRbXeji80AvRf3vGva58jsXx+59FIz4kL5Zj0V+gAVsVFlWewGV0mgswnOjoab9ot95kYfDR4VyyTaUg3CObF1/2k4XbCOkq9vcZuLyiCmoXMjrRPhkPq985gFBsyeqsg2/LEQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=LeBI72Nb; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="LeBI72Nb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784701449; x=1785306249;
	i=markus.stockhausen@gmx.de;
	bh=DImM5t4cNwcYmhsJR+O6ugYQgPlnNLAi+fIISdtOT+I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LeBI72NbRXpQDZL8Sn8C+G+iMForU0LB+eQcyujgMZUkKfTKFOo8ytQnyBqbHpgY
	 5hHVpoSMDcOrxviM6WY43g458jnqGMJ6WyQnOqX7yuQsT3dSS3OEvTCqHewdIjalv
	 hFWyF3UY++rOCuqoWGmznKikyA8b0tve1GkwiVK/YNWG/5SRybpUGRvrTtP/dyw+r
	 auTj7W2SsduW+FWFSif/WfNl3BOt3lP8bT4zS/qPz5sGco2zDWZtHpnQZljkO1ZZZ
	 D1nZsM8Vq1YKbM9nob1sVci5+e9HWzCIdvf+ZtG5zze6X1GRPyip4w3y9YqxEz6hw
	 qF4o+Dthqzy5MPbDDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeR1-1wRAF82omR-00Z0hh; Wed, 22
 Jul 2026 08:24:09 +0200
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
Subject: [PATCH net-next v5 6/8] net: mdio: realtek-rtl9300: Increase MDIO timeout
Date: Wed, 22 Jul 2026 08:23:54 +0200
Message-ID: <20260722062356.12291-7-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722062356.12291-1-markus.stockhausen@gmx.de>
References: <20260722062356.12291-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0OAP4DTV8MVnqPc+I8EeJwTZaH1v2YvZ3Kt0c6oFSEK/NBtADSz
 jwLWxN2+9nVnSlYs7xpiqY2M+Aqz5PXi5/nMcoVLnsnbnKQCJTIBX+Vy/9FeHYKEzhEgxuZ
 c2I1iZm2tbttvnAidwrMI0IbcbOjxh1ylpV1zpzrUtUcau/H6xIdwtBU9c5XPEpbBxiDGxG
 4crzWSJ5uXghCCeXEtRtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H6I7WkhKC0k=;Dn3vtzRHQl+0vHxqEYDFyT++lIF
 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
 o2eG/QYeQpmWZTmjkqQO2

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
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 2d6faa4ccd06..26d73f5b5422 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -267,9 +267,9 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
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
@@ -309,7 +309,7 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
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

