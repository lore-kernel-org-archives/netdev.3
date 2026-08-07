Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E31139CD16;
	Fri,  7 Aug 2026 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122695; cv=none; b=akSV8GyOpbeKbZVol2cKEOPGIQ/+Uv81jENmkks+DV2jR1MKkskSH299mfUOqP5bcMj/IpezH6BPignnoHDvDt2lUVj0Lemv4Fsfo+lRp9zGfdhDxSkDVSbVfeWhJ2Tp0XNwOn8ggmZLslvw3qC2U07p+WAmgIXcnZ2Y9XYYpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122695; c=relaxed/simple;
	bh=rBw3ksG8sn3qePBYAOan3UfsqwmqPGXIovfdeShyRnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKDs/6xRAkhiuZBNtxHze4pzf8L12IyL4rYASLjKHoQx9wygbHSD6C77eIHmHnUzJnWNNPOx9Fg/jXekV+ENxlDb427EdEK/+VF/GmBXJuipCeQW/nIc+uHn0HgcTwn5F4c0iwQZgF/X0223Yb0vzAZ7aMuDMqs9+TYubfjGpbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=foUfRUVc; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="foUfRUVc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786122675; x=1786727475;
	i=markus.stockhausen@gmx.de;
	bh=E2FjJxWwQ87JgCPJxps7bGNztmSj/+VNQGA/ayLoYpQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=foUfRUVc5QfTeYNKI52QxcicqO4Yds/E0N80L1D+t7m0OT30pI81g2p+xjH7YhQW
	 Gf30pmXCR3dTWSmI9Iwk/8aoUPZ3r7G6ecfe316SxcTpU70rPqoO9L5NBkkAj9Yj0
	 lqBGWd5O5UwFCcVTzRSjaDl574mcH3RCoV7apjTzIcr40+rFun4xSPI/ULk8oEmcU
	 7Y1CMv2LcU1cv3ddCjlpINPgSh0zTWte4Q5Dv7+gVEuPOVOjQcQW2gmi4kNRU2FJo
	 6fq5jeDeSGySnrCmQVcXOzMa8MVQ2e3YaPYYYa8LwKpy5MK7/hWnqqS+d8yu+Zpj1
	 29pZ5DLs+EK0+sYAmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bWr-1x19Zh3UEV-017UXb; Fri, 07
 Aug 2026 19:11:14 +0200
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
Subject: [PATCH net-next v13 11/11] net: mdio: realtek-rtl9300: reword Kconfig and module description
Date: Fri,  7 Aug 2026 19:10:58 +0200
Message-ID: <20260807171058.522833-12-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:tmlfDcTRn83lJLV1Ti6r4nThmplum/Iea8zkrbh/+62Q1wiEeU1
 VegTs3T/NyBKYajTFVXcY8CYQDIt6HlxmfMQ6IIbzPszeH2j3yuIQXrd6keOAV8KkJGpuGc
 zlMXMlkTtls32CLKL80DofSHWwIx2p+DMlFOKLSGdRKKfckG+qWBnulJGDALfFwsbpiwKsw
 1IIc5hUH+gZsobd8lcPsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uONGnqVsehg=;sHhfr8kJtYVZImZhoQ3w/dpj4JZ
 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
 LoZS7s7/ztZ+Go6Pr90=

The Realtek MDIO driver has been enhanced to support multiple
devices from the RTL83xx/RTL93xx series. Reword Kconfig and
module description accordingly.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
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
index 7792cdbedda4..0a0cb814fbf1 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -1088,5 +1088,5 @@ static struct platform_driver otto_emdio_driver =3D =
{
=20
 module_platform_driver(otto_emdio_driver);
=20
-MODULE_DESCRIPTION("RTL9300 MDIO driver");
+MODULE_DESCRIPTION("RTL83xx/RTL93xx MDIO driver");
 MODULE_LICENSE("GPL");
=2D-=20
2.55.0

