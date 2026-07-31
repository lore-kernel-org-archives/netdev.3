Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B93451BA;
	Fri, 31 Jul 2026 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478464; cv=none; b=LYluef8t/TbeCvkCfMqrhSUsTkPxl85z1lQqft9W9PF72Pdfcp4esA9hMEpL5iiQM+n62JXnpzMSEJa4yRDCpPbzbcEZhDMINZJf7R4DN4YFtilFP7s9/h53j7mg9fV3RjixQLW9dImCHUkEnfQA9b9h0w3FBv8gE61Fq02Ez6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478464; c=relaxed/simple;
	bh=dmCOeE0jBMWx4tHqDlBJ47Fgz14B2C2Li6SjrV2fpM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fzhwb7rPYwGoWIEAMQ1K+WP25HZuLLfgA8cM4Popy/bB74wRJ7UcFIYw9+yBvFYvSC0WQm4AVCsqeWQNRGlq0ofQ8I6kt5emMkBxh4rWRjc4VdJVPAHmHiu0T4ki/FeiKOtualoioTp+cCVedcwG6hLUAAY16Tdkhhb8F+Faz5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=uPeN4QuS; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="uPeN4QuS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785478456; x=1786083256;
	i=markus.stockhausen@gmx.de;
	bh=Ol5d9uqQKV08wdgWcna4Ht1b7YSH8kdtzLuaU1wj7Y8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uPeN4QuSv2M5TstL68JvIF/T0uXhGOpRKUKohqDi8gl//YQTDywNTH8Qs03t4Ws5
	 xX5JGE+NJCn6YmSuf76DyYfkVIrCYyQboWnmlWiJcbtokhVe6E2MDloA2bpyyduD6
	 IZHOEtahHLY1/rHwqc3AqJh+KnFCdO9QS25alrwgr3L2NmF4vfR3ZlmLodNhGp+VR
	 WW75wv08BspF9zqidnd749nsZpp58PQUQ3AU9tdFgemANqUMHgLTpgz+hHnjJWQux
	 GO/OP4uQaoytltnQcCMD3HJkYaEc6w1BCgibS6kkZ0EbBDoutuzej804kkwMr9U5T
	 3VXuTG7x5rV67Ase5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWzfl-1wRlir0eK1-00Vi72; Fri, 31
 Jul 2026 08:14:16 +0200
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
Subject: [PATCH net-next v10 07/10] net: mdio: realtek-rtl9300: Increase MDIO timeout
Date: Fri, 31 Jul 2026 08:13:57 +0200
Message-ID: <20260731061400.78301-8-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731061400.78301-1-markus.stockhausen@gmx.de>
References: <20260731061400.78301-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LyxSb41bA/FK5GfwsF8cO3ICdsklcymxIAQwzU7H8BLGG5uJWXZ
 LoTqA45r2mCHWVl45dG0r/Brx5k27rF3yWNG3ti5Nefs6xR+IVSfPbbNlHL+SsHKE84xMPe
 DerYmJWyTPAepRLLgm2RVB+jIa6ACep84UonSyPw0+p3iycnvjOdR2INTDbtSTRHekfRgs5
 DHr08aHzUN6PDbkbjOudA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GyM2cbCK/Gs=;gtmQ9FXBzhaQbFUFd2zUNDFJxEn
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
index 9663f644a313..1408e252bbba 100644
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

