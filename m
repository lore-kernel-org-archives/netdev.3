Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8A84EA38C;
	Mon, 31 Aug 2026 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186905; cv=none; b=knoychTg/MqFu45880cQz2n5aSbjw2GUnHmpfhtZPv1I+2f3OGtyFlAAJ1qDeF3MfrBWGZZbXzQrRNE4oBN/6RsNsLraf7j8oXLD/Oin3rRhgmCzp+QWdEXkgrfUmQO8XLh1XB2IyseCV1E3tVP5ZDJMX/k93ZeJydCIEHakDyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186905; c=relaxed/simple;
	bh=X3ISsO3/DtUWqM5dwl6VLQklnTiPj1FRIhmqckoM87I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lc2B3HGVt5MilZHCBAd016ZfJe6Q0u+MDiun/8seMKBRz0oo94q9OBLvrP5P8kFuGUUHCYACyCn31HF+EiEwoTNKiSInv0gLju6fvkDq5jdwEpKmIs/AHJvC9iYUFL7Bb6wCOl2AK+CuogNWA720lYMdU/f8OXWT7EIjvWq4o3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=rV4OOBj0; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="rV4OOBj0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788186900; x=1788791700;
	i=markus.stockhausen@gmx.de;
	bh=gQeqMJ64Vj4m2pyIQyK2YKPE24SuDfKJAphxNjL9uOs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rV4OOBj06gNrZFerhGO7jfjYLgX0vKXIJfQXU59k7AotpH1TtVHLS/tTH1jZYO10
	 PqmpITE14rGLCfddkquuQ7orHFN/mHo3JqTq7keW1jSXa7wG1JwGJYziBkLQQvvuR
	 PDBmFwouqJ/XCmeeKWNT2lx2KJtcox1Y/BxR+fKZycBnmmpF3c6+2dGQEmPozTCBU
	 mNcbbPTCcOaN1uHfTol3u5LWlM0sRlkimR/UaRWsPv2FccmVDlav06Sv44DonG5NQ
	 mebX/ye8EF+zypmk+hC9YUChsdTiJ6QJw/tlSRPFSI1ttyZHVhf+GjJrzHmFBSebj
	 51s2M8decgEPiKr1Kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPog5-1xEZlv2jRb-00LpHr; Mon, 31
 Aug 2026 16:35:00 +0200
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
Subject: [PATCH net-next v15 13/13] net: mdio: realtek-rtl9300: reword Kconfig and module description
Date: Mon, 31 Aug 2026 16:34:39 +0200
Message-ID: <20260831143439.2404484-14-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BZN7f/6qDK9mbxUskGBC2DC5w6sokxNwz8KD0WrOnmvmLzyjWiH
 iSTZvdFlhp/EZkVPZNIkwL5k4sWa8XSC7ZfHeVVnscvkj4u2PwCo1IDs6G5jzruVggzzSvH
 /6XOncFf6Qhp4NZKeIH+ZBwIQN/LzoNlPGyS7JD4yYYyTPXfJH10lDFscrfD1hUWE1OHKdp
 4fkyt/bopxQISuhlvEPvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:24YSsCJpkSw=;WkMzP18vbagGtaikM81k1xnoIbB
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
index 86b2040fa333..11d078ef941c 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -1150,5 +1150,5 @@ static struct platform_driver otto_emdio_driver =3D =
{
=20
 module_platform_driver(otto_emdio_driver);
=20
-MODULE_DESCRIPTION("RTL9300 MDIO driver");
+MODULE_DESCRIPTION("RTL83xx/RTL93xx MDIO driver");
 MODULE_LICENSE("GPL");
=2D-=20
2.55.0

