Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E73806B6;
	Fri, 24 Jul 2026 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872608; cv=none; b=d9krRcaQMV7ruzpR334Fk2YEpLiJbzyNY29GMGk/JpAFD4oPlRBeZ0Jlt9icun3xD9Le6xn3Rzcpd7eg4aYtbJYUvFG7f7TnyEomo+8HbQOZ1FbAyzejs9DOwCQTo7pKHVw2/ouEl3JpjfnxqwDoMQNwTePDiXEn1gtmYKMxkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872608; c=relaxed/simple;
	bh=L5YC/sZ2QpVeNEpeZ2BRKP5JntgdZBdt2QyL+ubYj4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEyfYx50DH8Q0qxOh5xxQlORrjbPTKIYAIB7l6fFljMrei9tLKfHAQWzn/mjz5ejayzq2EZ+DGJZMDWeR2A4DxptDALPIGs+BvZXRFV3vJO7qYUy7VPbOSx6aCzlDaDbvweJM8udtmjxf2fZS5WFmkJV7rox5j3bifR9xCSNSPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=OGE4Tp/h; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="OGE4Tp/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784872585; x=1785477385;
	i=markus.stockhausen@gmx.de;
	bh=wfHwXvl0asFCK8Kz3AHpUBZFPj2n+hqqODivkrTs9Wk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OGE4Tp/hyraIHsGQq7AAzWTWzgJht5blexWr+y1lj5hr1F0UZfVaag6sqgHi3+N7
	 jjpNTv+7Ftle9+ATV/trK+6Nb4oNwrsLunvshslbcRINIegCGHmhKM2yQzjfJWqEG
	 00vqmQovnD4UMWLbE7Odz255VqVZBK2srrYXJ9he/LO1doyIEyllYHLodcJXyCt1y
	 gse2f/IQmIf9a+HwEs0L4Hkti/IlqcDhqC76iLbtc9y7yy6lzx+AwmX3aM3ogp+9Y
	 kxoh+8gFaQ80Xgp1QtERXm46LbQHEOK3lWAw7J6Jdj+8mBfkc0zzWJ79LLpc6gFNQ
	 csOhFaP7HQwEsbGwlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD2Y-1xQ25T0PHG-00hdZI; Fri, 24
 Jul 2026 07:56:25 +0200
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
Subject: [PATCH net-next v6 2/8] net: mdio: realtek-rtl9300: Add polling documentation
Date: Fri, 24 Jul 2026 07:56:05 +0200
Message-ID: <20260724055611.1008577-3-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:GrOPo43ZvHi/dnwv2AHXboTo8TmErqWG63N7ZriALtiSlc9gv5U
 Gk+LyPDn+Q8u0IzfLe0Ke/kLzCkxy0NMAC+YLTSoyWJDalmeJXtGEeqOCgL+CDVb31EDOy9
 D3GN2h2CKiIEYwPCgvRnWJov0TXa0ndiAnsF/hFvAsF9UiQFvy0otVMt2HRvHxtAzBjTK0q
 yiUMxQAc/UDWdecBDeXAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A9qJqpxUre0=;wcyBj3VY+rSdJA4roVxY2Iu1fjg
 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

Add a detailed explanation how the hardware polling unit in the
Realtek Otto switches works. This simplifies developing future
patches and reviewing them.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 75 +++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index afd52a1cd7f8..3dee5bff4134 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -35,6 +35,81 @@
  *
  * The driver works out the mapping based on the MDIO bus described in de=
vice tree and phandles on
  * the ethernet-ports property.
+ *
+ * The devices have a hardware polling unit that runs in the background w=
ithout any CPU load. It
+ * constantly scans the MDIO bus and the attached PHYs and updates the MA=
C status registers.
+ *
+ * How does the polling work?
+ *
+ * Each device has a SMI_POLL_CTRL register. A per-port bitmask decides i=
f the hardware polling of
+ * the associated bus/address is active or not. The hardware runs a tight=
 loop over this and for
+ * each set polling bit it issues a status check for the PHY. Attaching a=
 logic analyzer to the
+ * MDIO bus of an RTL8380 and RTL8393 gives the following commands (in ke=
rnel notation):
+ *
+ *	RTL8380				RTL8393
+ *	---------------------------	---------------------------
+ *	phy_write(phy, 31, 0x0);	phy_read(phy, 0);
+ *	phy_write(phy, 13, 0x7);	phy_read(phy, 1);
+ *	phy_write(phy, 14, 0x3c);	phy_read(phy, 4);
+ *	phy_write(phy, 13, 0x8007);	phy_read(phy, 5);
+ *	phy_read(phy, 14);		phy_read(phy, 6);
+ *	phy_write(phy, 13, 0x7);	phy_read(phy, 9);
+ *	phy_write(phy, 14, 0x3d);	phy_read(phy, 10);
+ *	phy_write(phy, 13, 0x8007);	phy_read(phy, 15);
+ *	phy_read(phy, 14);		phy_write(phy, 13, 0x7);
+ *	phy_read(phy, 9);		phy_write(phy, 14, 0x3c);
+ *	phy_read(phy, 10);		phy_write(phy, 13, 0x4007);
+ *	phy_read(phy, 15);		phy_read(phy, 14);
+ *	phy_read(phy, 0);		phy_write(phy, 13, 0x7);
+ *	phy_read(phy, 1);		phy_write(phy, 14, 0x3d);
+ *	phy_read(phy, 4);		phy_write(phy, 13, 0x4007);
+ *	phy_read(phy, 5);		phy_read(phy, 14);
+ *	phy_read(phy, 6);
+ *
+ * After one PHY status is read, the polling engine goes over to the next=
 PHY. If one bus is fully
+ * scanned it switches over to the next bus. Basically the polling system=
 is always busy and the
+ * MAC state is updated in real-time.
+ *
+ * This is a glimpse look at the complexity of the polling and leaves out=
 the C45 case and the MAC
+ * register update logic afterwards. Important to note:
+ *
+ * - 100 MBit downshifts (broken cables) are identified and propagated to=
 the MAC correctly
+ * - Access to MDIO_AN_EEE_ADV and MDIO_AN_EEE_LPABLE works via C45 over =
C22.
+ * - It is unclear if these sequences change for different PHYs.
+ * - Access to Realtek reserved register 26 (link speed) has not yet been=
 seen.
+ *
+ * How does MDIO access from kernel work?
+ *
+ * When issuing MDIO accesses via an MMIO based interface the final write=
 to the command register
+ * sets a "run command now" bit. Between two polling sequences for differ=
ent PHYs the hardware
+ * checks if a user command needs to run and sends it onto the bus. After=
wards it simply continues
+ * its polling work. Inspecting the command sequence for a paged read on =
the logic analyzer gives:
+ *
+ *	RTL8380				RTL8393
+ *	---------------------------	---------------------------
+ *	phy_write(phy, 31, page);	phy_write(phy, 31, page);
+ *	phy_write(phy, reg, value);	phy_write(phy, reg, value);
+ *					phy_write(phy, 31, 0);
+ *
+ * What does this mean?
+ *
+ * There are slight differences in polling and PHY access between the mod=
els but the challenge
+ * stays the same. On the one hand that greatly simplifies the MAC layer,=
 on the other hand it
+ * has some implications for the kernel PHY subsystem.
+ *
+ * - Without the polling and a proper MAC status, some of the link handli=
ng features do not work.
+ *   Especially an unpopulated MAC_LINK_STS register cancels operations t=
o other MAC registers.
+ * - The Realtek page register 31 is magically modified in the background=
 so that polling will
+ *   read the right data. On the RTL838x polling simply resets it to zero=
. Other devices seem
+ *   to track the page access "magically" in the background.
+ * - A C45 over C22 kernel access sequence is most likely to fail because=
 chances are high that
+ *   the polling engine overwrites registers 13/14 in between.
+ * - PHY firmware loading can have issues. Especially if a PHY is designe=
d to expect a clean
+ *   sequence of registers and values without deviation.
+ * - An access to one PHY will need to wait for the next free slot of the=
 polling engine.
+ *
+ * Conclusion: The Realtek MDIO bus driver PHY access must know and handl=
e any interference that
+ * arises from the above described hardware polling.
  */
=20
 #include <linux/bitfield.h>
=2D-=20
2.55.0

