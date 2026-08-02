Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C63812EC;
	Sun,  2 Aug 2026 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659753; cv=none; b=lC+rU7wlJ6hrYmPmim+H/1Q2rXauzKo0ZEvf93iqqU371DHRmCyRJOACRLK/CKvlHYidNjz5ap2nLq+JQSojvXrBNLx2lCBXWaVAV3JLkK5RzKqGQvv5xNpHVebho0TqCpSvbmdYitFF2cYOyKxOQo1M+5wAxvdb9aqbeOFf4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659753; c=relaxed/simple;
	bh=BO3WUbLCW0GhHr1f2JHbs0yyCbZpY3Mj1nmldeYBuf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A66JC9Kg4DISYKQe2y4P6vJTEnYDxScy8ddFd67wBJHBwHlLWl31ox0dlDNblPmdiWsmJpfAOOFsnbmoJQZTqwCjNdFhIwpSCKwMdsEvkor5UW3VEJbs2qMD73kbqg7P7MvsZhh9mcJLZkSSKGT1/YPisndGYdoo4csrEuv31dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Wcbg5Swn; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Wcbg5Swn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785659746; x=1786264546;
	i=markus.stockhausen@gmx.de;
	bh=rXKACndHioisriX0dZZF1U7nHNOwzMoSTFKNXMBDY7c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Wcbg5SwnAwMQo+le2g9isgohKf/uhROBuS9C7k9DrycYKE4m9Q//AnlEwv46aOUR
	 O9nSVFgu2RfnckGAtrTjFNyO7YPJCADa5Bq7fff1iABqYHHX7lrIYMG6vN63VtEnB
	 p1vXwng1IuYPRNu1lRPGiL92FIUCZ/IGLuBPRumWQk+8ULZAzgz0uie3Kl0HrF0DM
	 c0ZjtFgs3XmCY/B8wJRj2XpB5MyQY8mpJ3a3aomFjq06+tLbOCXyCoHdxbE8iSiyY
	 ohP2OyFUqhFvHZArrmD1w+vTh+OnnrYZitRR6i/xRzHn22rB2Eq5npTU/ySc2A23W
	 /HEKZnbmD9cm5dPwUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42nY-1wqRfe35X6-002nnj; Sun, 02
 Aug 2026 10:35:46 +0200
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
Subject: [PATCH net-next v11 08/10] net: mdio: realtek-rtl9300: Increase MDIO timeout
Date: Sun,  2 Aug 2026 10:35:26 +0200
Message-ID: <20260802083528.490216-9-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802083528.490216-1-markus.stockhausen@gmx.de>
References: <20260802083528.490216-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W5Rllo5lFVbRh5IETgrCqiAXhXGtnypXy2le0ZuTbqPok/k9jls
 CzqNuc35525mF4a/mtOTgRPjvElNx7mZgYOa6JG59Myqb9dzJR8y3g3HShEMocjxn/Pt4WG
 9VUrFS/XeOLUOA/SjsAEOVDhnhZqIjlU3JXh61/nVizkGYSKDP489Kx/Hx5PR4O8KBDwfN7
 C43CH/xlwilEGKGPNcUAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8CalmPUGRS0=;Mm182svRSqYwKYZ/ylKNWKXGe9h
 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
 GoaI/nDTrKpmljwQ==

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
index 95641052bc9b..dc30412a1af9 100644
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

