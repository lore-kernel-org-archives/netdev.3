Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC564503EF;
	Mon, 17 Aug 2026 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984020; cv=none; b=GOkj1NZN5dF4fSKQ59MNiO0Xt2CemrTft+iRv5F2rmnase0IATIbMzRSeM9Bn+irJ1VM/bMbbAWfzknUk169x1gGNRr5FpMQqcKwfxnOOzIxjykM4iWYLMw55AIbvXfL3pNEnR4JXuIH8XvenhXXYDa2CD9mfehBYqvEcQox5mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984020; c=relaxed/simple;
	bh=Wd0G5TaLath3FmMynRxogYebKqqH9ZfU0l2S+FEsuEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RClkhq/Fnzfr0vhRmfWSU7/0G3YZbR8fEsZi2lfw5cj00ZDSldDIjWkjJeGNjL4zb4lWOk11PWgt2lPdl6ScRK4yqCwPr3yrpfVVAZnfk07DGJ3xFLA8PbR9f+/Fwvl+lIzLqB04LG8c6hM8B1M8pUHVPrNtPRxzDVElCTn5ohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=BRLtWZTt; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="BRLtWZTt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786984012; x=1787588812;
	i=markus.stockhausen@gmx.de;
	bh=ZOEbbvJLv7OAv4mvvT7KbTWpH75xLBc2PH7SAMnsaWA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BRLtWZTtuDfhJr5Z7EL5Uge7rczw4MutPM8yyLfZzMl/6IiRwOkzdTR8gVd7J0+N
	 kpA17L0aAmyBZZCmGBSkeoFfxUAQYaaPhjramLfjO5dULEn3n8UmS6ss3FcPze6rt
	 CCXo/XfidGmEUMQ+yheB/idpiJo8E9/FBT6yzdIXZe9uN5zyjZ9I5OPeF+gC4GqFZ
	 5NNFlzc6k/CYm3gwPh8nQ1jr8Xrsfa6xDfb+wJlgRFru8/5D9vepuz8ibz+wRrk4r
	 9eFomCbCL35UjuU7qH2dYl6sqMfue2SV+uawGkjpbfHwV2w7pvE2QSTlaNk/eoe/C
	 uXFqIR2dDEEgizF68A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XTv-1wrU1i43nd-013cVx; Mon, 17
 Aug 2026 18:26:52 +0200
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
Subject: [PATCH net-next v14 09/13] net: mdio: realtek-rtl9300: Increase MDIO timeout
Date: Mon, 17 Aug 2026 18:26:28 +0200
Message-ID: <20260817162632.1208891-10-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:t+Yln0T/WISQZI4k82wpVGdCtgOkPlDZ/Zart60ug+YAvgOl0BP
 M/BGA6MYCwJpLDQJz8hQJ3YEO2rEFKRQa2/oi2G7LJRHxTCEQpfI/loYBod86pjv9JetGm8
 Nv8+XTKf+h/XjQAL9zQ9HKdZFKKZViKJ4okOfnumqayKeK/pdgwyUO/hJ3WbdsuFJ1qT6m6
 55s1HIsboT63pK3ox3qMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MlEpfIDWjGw=;4FaqwtlLoE++EfBswXI/7AzIJev
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
index 6774494d4ecf..f3777c61705a 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -274,9 +274,9 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
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
@@ -316,7 +316,7 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
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

