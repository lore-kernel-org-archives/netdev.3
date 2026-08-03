Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6551421259;
	Mon,  3 Aug 2026 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777576; cv=none; b=GjkkLvZwQ5fOL4+5mfd6DlToO+hzMEwmNqh1GSqmDcbBMDFdubVjGKU2NOk3HR61uZ5rE2Qq/qBhbAvFjQ5e3WG6g28G94yX7BCymUCPmy9l90Ht/kclmLDbr3fVLuylEsB43K/W/9dDGBstzS0k1NbfrGE1091Saf8Co2ywHV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777576; c=relaxed/simple;
	bh=atvf+AsuBnzffDwfwJ29qn2L06KJZTBxknpsPAQdTbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6gBIQFSzCDr0X7F+IxYnWNy+LEFWLjqGF4xPvbo/QAYfOs0JKEKLOJ8nSMRxsDJP5IuxW98Sym73UxHZK+aeBouzpaa666Xg/iOHq7zSIdSa6brWVC+g9vGhfjfgkexNK1rEfqFDylgeCgmE8hnFydlcu1/da2u7j7RZaGeAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ATxrFraj; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="ATxrFraj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785777555; x=1786382355;
	i=markus.stockhausen@gmx.de;
	bh=C0FthCe6pfn/9WIbcCv7S7vlwPyKw8h3KbE2dpZz/IY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ATxrFrajDOhot6oxmxQ+bJbum+lGl5cn6Axw8cuJYaHv2Zc6/ewfmBXvN79Wfce3
	 AUQfIbiAVY13RG0K0O+EhzdrncNEHdl7ufoMPmskESMClH8kAmsp1KIIzRRd54Jtb
	 bkQHPk70Hefufrq4iqIS/64R4d0yXrd+6wCcR2CbCHVR2dL+W8aCKV7BhaOvHKz7j
	 bqMr/APFE72fwnEuizln3P773T8WULhPSwLnqsnywWWOCuwhjEuaSmvRpDrB94seR
	 S7XLswVZYIM7X1Qls1fphrteMsBOd3tigXqF8WpC4exQj1AOne1oNDv2dxyWl+1dW
	 zcpNGaHGCM/D3j9hjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KUT-1wxeLC10Kf-01530P; Mon, 03
 Aug 2026 19:19:15 +0200
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
Subject: [PATCH net-next v12 11/11] net: mdio: reword MDIO_REALTEK_RTL9300 Kconfig
Date: Mon,  3 Aug 2026 19:18:53 +0200
Message-ID: <20260803171853.507506-12-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:Kc8gIOgdfRtF/bbzgg/uIEuH96TLjOO6vaDtrNUM3NFD3XpKcCS
 gJOIn4W4+E/zbohnChuwrtQG0MDvOX/ypxVe+/yUK5SJYP9a4S6irtjOt/5Ohfb1tbdM7vO
 MIHNwiPr/Bc1Gn3Z9nOk6QABa+MlYfSXqBJYQA8vAxYdyRzgev0OucrtVizB5310TWr8AR3
 ywbOYBt8J7QsDKmA3hsPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VgUO2UA32gI=;+DwAqya0relc1RzFXZlcpoxZUfl
 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

The Realtek MDIO driver has been enhanced to support multiple devices
from the RTL83xx/RTL93xx series. Reword Kconfig accordingly.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
=2D-=20
2.55.0

