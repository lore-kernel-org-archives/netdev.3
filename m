Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF6450400;
	Mon, 17 Aug 2026 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984036; cv=none; b=nmMd9do+ueSJo0Wj6HcQtV6jJ9xHH9QI6qTrctQWOxK2/ZnfH2ofN4GxUs2h/b0JUGU3LRAFEJzrlTskBx+HQxPx+Pa7ueODE+QLOY6sDFAa7VW/6cEAh5hhH6D/op96SESIubqBTl1cGQRbGNCn2wUvDz0oTidFdug+r4sliOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984036; c=relaxed/simple;
	bh=tQDwLT53zEHg1MxKXtAz+J6H3LruSX0ZMwidG8zeCeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acvABwM6iZ95R369HABI7ZfBD7cLzAUBvx32VVteLT/AE8ym0sAIq3njSTKL+eDdxoOtFgOyj2DeJhDhXmXz3Zmeb8hVaCId53IIVJRaNlpeP+NjdbKMDfcQ7C5IlzR8X4FAyfkcEzk+1ne/rnySOcSde55/n8TEHWNhEt7m1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=E5I5sif6; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="E5I5sif6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786984013; x=1787588813;
	i=markus.stockhausen@gmx.de;
	bh=QcMLKVtXiET2fMhqYMIk1joF2NZj4SdlFSNzQUIMGWY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E5I5sif6cQpKhxRw5PRTQROR6xKh9qXugCHJcRBT4P/Dwu4cm98jeR6jUs8rkNlB
	 nI0XWNySKtu7642gEycHsKa/hxPWoxR49zdgx1gCOHlCRLKNOBD7IvrpcG7NdV9zN
	 /D/ixQ0RaNfYZGukJyKmT5j/FySyUVnFdds8MmXEnoc5U3jVTVyZDiasAT25RviVS
	 vBsywULPzgS0aXJ4JY+Bi/+p2P2nkv19c8ynZVAnG/Azr0traAnbxMnkt+h6nnqYU
	 PDKS98KETYoUpTUEw7OTDtSoXEqHsh/sy0oenQFdRFazTO9bsTPW32BbgNKXCtZHL
	 fbNOyhBi1f0Lpl9QBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KPg-1wmp3f1pH0-017l7O; Mon, 17
 Aug 2026 18:26:53 +0200
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
Subject: [PATCH net-next v14 13/13] net: mdio: realtek-rtl9300: reword Kconfig and module description
Date: Mon, 17 Aug 2026 18:26:32 +0200
Message-ID: <20260817162632.1208891-14-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:I/hoMpm+ip7bfYOG3b0ZrLVL4AlZmkQgsIHzdq/4u/JgMyTyn7C
 Q2S+ysVCMVBEDi7Xe1EfuFg7VHC9C/QVsWu16PlWyBSWfXgrNF8CCbHguhyLt6TxjS42fZo
 PiHUB/ipr2aQgQ3dB/rUkxW1EdVFymehwaOU/VmzfRNnRMd64g4KiJv8XqqGa/Tk59RTaWU
 6g9P9y/0mohACqsBsvInA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:quqGDnnsWKg=;NgJKKQlttg5KbAGoqfLAWDewbIn
 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

The Realtek MDIO driver has been enhanced to support multiple
devices from the RTL83xx/RTL93xx series. Reword Kconfig and
module description accordingly.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
=2D--
 drivers/net/mdio/Kconfig                | 4 ++--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index a05229838cb4..d44278f26fab 100644
=2D-- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -172,11 +172,11 @@ config MDIO_IPQ8064
 	  interface units of the IPQ8064 SoC
=20
 config MDIO_REALTEK_RTL9300
-	tristate "Realtek RTL9300 MDIO interface support"
+	tristate "Realtek RTL83xx/RTL93xx MDIO interface support"
 	depends on MACH_REALTEK_RTL || COMPILE_TEST
 	help
 	  This driver supports the MDIO interface found in the Realtek
-	  RTL9300 family of Ethernet switches with integrated SoC.
+	  RTL83xx/RTL93xx family of Ethernet switches with integrated SoC.
=20
 config MDIO_REGMAP
 	tristate
diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 24c7d91c2870..94c04704c24b 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -1145,5 +1145,5 @@ static struct platform_driver otto_emdio_driver =3D =
{
=20
 module_platform_driver(otto_emdio_driver);
=20
-MODULE_DESCRIPTION("RTL9300 MDIO driver");
+MODULE_DESCRIPTION("RTL83xx/RTL93xx MDIO driver");
 MODULE_LICENSE("GPL");
=2D-=20
2.55.0

