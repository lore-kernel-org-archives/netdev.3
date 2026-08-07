Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B539A067;
	Fri,  7 Aug 2026 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122688; cv=none; b=Q/edTp5Cwskt/+lrXKaQ37YIGPutwhkAqCJcK9s68xPyYQzWOFdFxR9lpmCPYvWsKRlr/g3QCJNkAAbEQvKCbc6JFCxZdBPU3ONij1vy/Bwa0b78UukT3d0ftxnQ8jG9YVWg3vnA5TGCNid3HCsMtfj9LddiKZ+UWmdEXYJiLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122688; c=relaxed/simple;
	bh=90QkMpi+2/JHlW8+O2FT8jWuoZwB9C+w5AZkxhDPlyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soEbv8LbQORZ/GRkvCxE8WCoZ9cO+BoIfs1XqxemiF6yX+JMo9CbDdOv4rBU09zsIigZHF+U3/1V4IuxnecDwFI6Wak6oJzlW99SjNPJeRcaJrKyt/v4pjISceKs6fruSaJRP+aXkJJ2968xFWUWHvFaHKRoJSGzlgzbK5WlBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=RI3nOL8e; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="RI3nOL8e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786122672; x=1786727472;
	i=markus.stockhausen@gmx.de;
	bh=oJF5MvpNOR9xoFhX9Rn30mXfBhG4duCOVnBhgdJAAc0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RI3nOL8e7o6dvN3KFyPUnExHvSJFprGlkpVhQRPxGivr88WUUjXXDJQ+HkRMROJQ
	 QPmZrAgjjusFhYH3VOFVbxIPOHrfpNcq/TQi+ZIIOMsoyvn7bf9rFqh00qOcifFBs
	 /VJKTAhaQau3kIIigmBwFxkqXF2Nq1WmTUu3lFDzWGwr1vXopA4LTxWAL27FbJYWc
	 7g+hV9UQQUBfCXsGPJYreeIe3R4BAAm9bfR8GRf99eerFCl0V1gty+ecQ3AQB4ICl
	 saDHVw+nP1i7iZF9NjKg7OnMqpMsZCbZmyzdgmsP4wFygWsKtczaNAF3d7ACTgOTV
	 ChDkmYrGlJrxXzkWEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1xIPRV3W0w-00qEde; Fri, 07
 Aug 2026 19:11:11 +0200
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
Subject: [PATCH net-next v13 02/11] net: mdio: realtek-rtl9300: Add polling documentation
Date: Fri,  7 Aug 2026 19:10:49 +0200
Message-ID: <20260807171058.522833-3-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:W2wtpTJX4b1VjJjqZDWLz153tFPHUJL8a1A4TnbIlj4BLcbUFez
 oKta5KgpOOSFNnkgqSy2gLwR4KElOkgiRJPjYVSbQ91SYEc7RFSIQptqeWJ3Q0sPPYI6uHc
 /khPkmerazyRm949cSR6mZPtv3E4DP7qBIiT9pmMJRL73rxEnkir0h6VlH0peip1xV6rEf5
 S+E2eMgUGox/oi7UR6lnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HCGfWIStBuc=;cKOwT9AxTyrWQGlESSFoT+EHfFc
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
index afd52a1cd7f8..73ac5fdcd267 100644
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
+ * its polling work. Inspecting the command sequence for a paged write on=
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

