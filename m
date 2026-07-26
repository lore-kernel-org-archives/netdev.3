Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7F376BD5;
	Sun, 26 Jul 2026 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050319; cv=none; b=EWYWw1kZu4BZbl304E5LkOnuhS+MOriAApRatovrdud3WgPe0je/0W6HbxlgipO1aod2ebIelCOI+6YYAZZTjZmELQG/3Mt2WUi/xVQ5s1rM3P7QPg15gtrygEp2CmW0SC7maFp4+7C9XbbL2Ia6dKCYW6SmB2N+EC9gX+S9PDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050319; c=relaxed/simple;
	bh=L5YC/sZ2QpVeNEpeZ2BRKP5JntgdZBdt2QyL+ubYj4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARHfQyWL2jpW2crinPYYKzg4lvCdYPurFApU/UAKcCeJI/7pTgaLNSG+vSF+SZs2HGDA9B6/8toMwb+Gob23T9b8Rhxf+Vv2BKvaqdmcIt1hGoHFHGLWg0JDN3pYo6vMCx+7Yul+rS2sy0efBOV7m/ahRBreG7iGLHMvRvDC4M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=bZILfLO0; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="bZILfLO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785050288; x=1785655088;
	i=markus.stockhausen@gmx.de;
	bh=wfHwXvl0asFCK8Kz3AHpUBZFPj2n+hqqODivkrTs9Wk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bZILfLO010CyfPUCyRbCd1KW+SonI0+EV4AsOWO5gSF3IpcStxRiLt94xuKdHSfI
	 UQjqNW5UOrLMKO5suaiS8cuprVeXS1kwTH2tIn0S2GJm7h1VIx29smynUDW8ru5yD
	 O9LoKeYP3rkZ+rlKLTlNUnlsSB7TryGqe+uFl0YDLxkTDriSER9uynpTBN8vBxUnM
	 uJH04JSXMrEIpTia9sbADvuhah0dtE1A5BdEnp/PMr7O9aKY92GaGLGwvU3VG7BEa
	 ts+9uROB4yulc31hVjQdEu2i41K6HSvBgpq/P3RnZVtJmxYU9+v1QBZZy3TViOBZC
	 5tj2i3g22uiBp3kagg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDEg-1xE77Y0kvQ-00f96c; Sun, 26
 Jul 2026 09:18:08 +0200
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
Subject: [PATCH net-next v7 2/8] net: mdio: realtek-rtl9300: Add polling documentation
Date: Sun, 26 Jul 2026 09:17:45 +0200
Message-ID: <20260726071751.1359156-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726071751.1359156-1-markus.stockhausen@gmx.de>
References: <20260726071751.1359156-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7UrOweIvfQPxSw909jEC5CfGeFVhlkW91G8oHOY3H+pAyO/d1Py
 Qdg5P9qh/XZs76tksT+7T3NtxkT6lzyQbmN2Bt67lFWW0gOuJ7/i7jovKzB6dAgZ07vfMqu
 NMjq5SnHObeAo2iBv0Vmy1foFcvDyK7iejAGIwdyQu5fdEvLqlO97c06BnTv8wHP+tKYUu8
 p+ZjJQDG9mThPIolzn9Cg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AtT6f0Bt+E8=;wRHHFlhihRM8fzOe3bmKgI/oDz3
 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
 cI4QX2gBFvk2wLsEb6rmw

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

