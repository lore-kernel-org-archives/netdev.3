Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975B1421253;
	Mon,  3 Aug 2026 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777574; cv=none; b=u9Ql2V/V27Z0GhCe26LSItyTGZ3TJA8oc2q2Gh/WjolXe2OjBP/xjDaUPvnhgdtrF5NMul+ZuW9K/hEjqhhFDbFdfgu/kA8Zd1gtvcN6+dj04A91yRuFVMKen+jEk2yaVEfnm/QP7LMJuDCBk5U6iZLkUBnnLUPTyxfX12GopJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777574; c=relaxed/simple;
	bh=1J8EWbP6o052Jef52muAvojoeQiQ5vUNbCJmFUbLif0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTD28DFuzc1DPww5eOYxskcZn1btDhrNsRcu+3kw0rD69MnOUkq6qUo0SR+KZ2o6e7hTONsDkMaJrufarxHKEhssyxepOYVnup5l6dBwYr0vziDjJJOCD2Jij6xsOEIfsjH5fSPqa8uIc57nNADuAjeDHJfxHZDbTdI99iYsCLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=G3yX/KIs; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="G3yX/KIs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785777553; x=1786382353;
	i=markus.stockhausen@gmx.de;
	bh=U8CvpRJ6m+1FxdqNrV63BrUnp39pBm5W0l7Gv9nTSX0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G3yX/KIsGrLaOlCurf6IHEOCi7Vz+h5Axcag0xZINeYcp0RGGpgaKPBPgQOPQD3a
	 W2jUzFs8if6rzFjLv06OEoNXmkQ44yN4cueylSLABoPKYB5NswGA8W/Zjbra9s6OP
	 bvDK5ZqXA81xMleMolFBO8PdYr4pVEEI7ubfOcA2bdGK3OJVi8ZtsGfGzqE60Abl3
	 QVHDEhB9EXaeFBxUdv35GZtNNgZ9s4OVj46cNW50aAWQrzcQP6D2jK81Kk/9b86aM
	 gmF0FdN30YLQkXLiCERES3EFKSqgfcR0vcjlugZy3OncFIMA5RdiRfgowttDJH2mo
	 syq353dDasdtzg5XRA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFvp-1wjXnw2Gaz-00Cvsv; Mon, 03
 Aug 2026 19:19:13 +0200
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
Subject: [PATCH net-next v12 07/11] net: mdio: realtek-rtl9300: Increase MDIO timeout
Date: Mon,  3 Aug 2026 19:18:49 +0200
Message-ID: <20260803171853.507506-8-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803171853.507506-1-markus.stockhausen@gmx.de>
References: <20260803171853.507506-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JWm28nDAskPv3kKawU7CY8MJN2aUTgDAvjjDpMMXbHeWnuN1x2h
 Rq8PtS8lH42yetIu36XTWa/DhSj6Fn4uJvTjQWvqVxiNjQe3maKXsBdjP0cgOQGxSVFcqBX
 bGT0JaTWBiBqfEuTcBgJmHoxNszY1WaVShseqGOzkVduok+BExxd/wQNv+Uhy4Fxi1/z1gS
 U1Bw5a/VQ6f4uopVQ7Jgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UeMcpHiWEXI=;mgY9y0FaUdok0mzIdw1xF2s80fm
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
index 914686135006..f8577aedf08d 100644
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

