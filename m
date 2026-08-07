Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C23932E1;
	Fri,  7 Aug 2026 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122688; cv=none; b=iGV6rh9w7xZmBvB/nVqDZvZXDWp0GgYXsQmFS+TqC/0MJt/PcDqjGZgRPGtuglnPWrcJbEvCwcJr/SrbPZcFULCZRO6gDqZPBs1qguJiDOr/x35qT8/4XcRfYCCgndyIqrqZZh74eYnjqzRR19yXSicUf7aHHaH1Cr3+dJODJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122688; c=relaxed/simple;
	bh=TIghXL5owWVnnjvW0ulROs0OVFhoWJvo3h+520hGwQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MG1rh2p9HQU/sBMAFUy9rJ28ZSLfws3AWuYGoiGU6v+yJK+CzUZf0SHFzyhVoGjXnyLmQUiR6QZTfLn4ikDNpPN2ckrfUDj3WZhd1/sIyC56jZm5z7s6iel/8DOEpHIlwBOYBYj/6fcbxlzoVHhTvvO3+1X8Q+APNgPaPMFp+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=bh/v1eiY; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="bh/v1eiY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786122673; x=1786727473;
	i=markus.stockhausen@gmx.de;
	bh=Dg111OB8LNxR8zRXuRJo0Qvd5kRSOC0o4dHP4DT5hlc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bh/v1eiYWKBYNO//bkKzW2wAWZqnO+IoYkaTDpQlAfoX/8JbKpDV0RHvyYRDg1bH
	 2ekrMPGqjCJ7157/1cJMRCnB7nSuizbdJSDTBSG859t4a7vk/paCUyepVNbeJJ5Pt
	 ABWQ6HTpY0Gn5Na+IzNMRwDtJDTblYUheMlmWVtKuRKptVy22Mg9D522E95PtVpGC
	 jaZImKo7nNsd1jwAOrfkBRE07uWd4QcCDQMEjayojn6IBPHrjTnRCv3lCCIl6MsjN
	 yGeRhsYDHXEf5EZ0S4Ec7Bg8kjrFrKBkI6natNRL1zdwgkXdA5EGDSzUuiPYQeQTt
	 OHp8u8JSG0Yur4dkrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1xRRru2I5L-00h7x5; Fri, 07
 Aug 2026 19:11:13 +0200
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
Subject: [PATCH net-next v13 07/11] net: mdio: realtek-rtl9300: Increase MDIO timeout
Date: Fri,  7 Aug 2026 19:10:54 +0200
Message-ID: <20260807171058.522833-8-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807171058.522833-1-markus.stockhausen@gmx.de>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SsIadHSjX66e1uXGRH/KBPj0LsXO1k1PqVTEaDrWPHxsazHVodq
 S5rl1gXWJcLJ1BwyQsBR9vYhj8rIAF8IHUdliLs4zARX/68CUPl4MAQtoP360EERwceaW+q
 x7oS5ijaIgJWdBKDDUs6MQg+ShBsQXCmoVOWy11Pjti34d8BNmEvCB1ukpO/s914xHtWpqF
 wpttyL/kcsYzbahbVt8lg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2ljl8Pdn9MQ=;3Rwp3QzY3rt8uzC0vcVSfmc/ZOI
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
index 7f6bda5ea1ad..88ba73b2ee81 100644
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

