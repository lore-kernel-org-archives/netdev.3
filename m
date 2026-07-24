Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4937F748;
	Fri, 24 Jul 2026 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872612; cv=none; b=nkZmdMicOimvLkKrSjQyaH4h8Rp9UQry2hkBLLtnI3EyofdnZqAdxD+mHHHas7XfyxIWK0AZPCgbQklMkdMZl9fEDBt56/sJlypU+1XTVEcAuuVvtyyBfFY9rmXCaoyCGP5recU0A3Sp77M83tFgaadi9wp1FJ4mrRLZqFTncXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872612; c=relaxed/simple;
	bh=CiPYkqtGoB+Iw5S5scKeXQzgEsvnDRCGFm4q1BR2xqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6Hjv0GZDD5rWxcSd6f7Y63AQuZt/+2sOvPr2WgH8GbJ3G4xFWv6Wy4GJ6CiD8HZNUef8cYjXxsmKzgaPsh4ROcNq4Xa4H3a+l0JkYiFTA5kk81LI6KIUqKJlZ9Ln/hiFWL/ykFrUbMGNqU6yJojZIMoj66vsmGzUPm78i7dBVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=mxzOMEtb; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="mxzOMEtb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784872586; x=1785477386;
	i=markus.stockhausen@gmx.de;
	bh=1rcMuC5lE+5EI49rzux0OA7Bb6FXKHNDCMj6j7bFLbw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mxzOMEtbbuFE8CthDT2qWqxc7mY9nbLHTH4wc41J5e9XFYVVnU9l008gLG+HRbJF
	 8HaIGo6jDMgSVtT0bJwFFnplCcRKMkaY0AdCD9GkOG5L3KRwq/a0xVjZjMpVi7ptu
	 yOnz+8DolOxthoWVY9ZWR8nZvH/r5ToR0ixvknd+0ZzbWXAGwMHom5mS1+BXnpIdD
	 rX56854s8Zw+BYaN+kXfrIuVvrI8g51zkTYmDSnQws0QOV24T2nfnAGLQehR6sa/j
	 Wcv1cZOE7HXw7hfIoFVJH/Zo0JO9+H6oF4ORXxJFaBGOgpQHddILVl8QJ7FgFozpB
	 Wk0W9QN6BWew0sMRFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKu0-1wOpgg35tQ-00RZta; Fri, 24
 Jul 2026 07:56:26 +0200
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
Subject: [PATCH net-next v6 6/8] net: mdio: realtek-rtl9300: Increase MDIO timeout
Date: Fri, 24 Jul 2026 07:56:09 +0200
Message-ID: <20260724055611.1008577-7-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724055611.1008577-1-markus.stockhausen@gmx.de>
References: <20260724055611.1008577-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fm5eHkiFE3l+j3vlMcIuxCUBevDgbfVkgdAk3buAVaXaSSEGKPH
 Kc0Kc6kkFDBu3IRbjdQDNvf9d7xLbkB+V7xL4Z6fWAASEELJJ1UklJJgJc76SZSLauDYgvm
 d4MpHGVNmVi3rT733lJVrKTndrMfb1wCt9TPV8LXYUEs4Ilz0DpINIZ6G4GEVbhvhRvTrgX
 JtFoyvTM8easPtghqhf9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qHguSB+x1Io=;eMfoDijWgfQN6Obtn5gtjg3+G9X
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
index b5ec5d39cfcb..b81dd588cd6e 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -272,9 +272,9 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
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
@@ -314,7 +314,7 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
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

