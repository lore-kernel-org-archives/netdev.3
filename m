Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131A423784;
	Mon,  3 Aug 2026 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777577; cv=none; b=c881A2UXIThVubXk7NrAgbzMtSRpooEqcozsPYI8d6v33yp8iGMGwDynktHLEsex9b9m//NKzwUKt6L30h2C/TeTja6pXHpxDaJ1FUc9HG/h6no9IsGKaEQ+nZW5pbMoKPTr5dPVlqJcp1QWMSyUcTHMQuIkcHKLWKC73kNOWIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777577; c=relaxed/simple;
	bh=90QkMpi+2/JHlW8+O2FT8jWuoZwB9C+w5AZkxhDPlyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieHHgu025QzffzCrWP3KJ+i9ixa3k1HWA2CtD0bHvfasHQoEQTDeiHai3l60YxD91u5WURpaDapO1BLf2wvbRgj+ymRd9BTRip8ykFeLuTerELTPNd4zMxkKoxx/KjmoBqH71sI+Idlq2Ep0O/2rg8SDn5FJRc98fp02qjp/ehQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=TTz8GUpY; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="TTz8GUpY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785777551; x=1786382351;
	i=markus.stockhausen@gmx.de;
	bh=oJF5MvpNOR9xoFhX9Rn30mXfBhG4duCOVnBhgdJAAc0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TTz8GUpYYLyXLJ7EfUXgSB54R/CSxfX90CsxcQt1If/BGC3zN88O9Cj3s7p6e9gg
	 41yTgFi/7Ef5UsrEDFaxOecAzhivCmOvGohb9nfWEfXI7FtI2AlIni3fy36BKSolb
	 rebEx4GWd4MSsDmZRNSDvutyBLa9B1ubOVAH2+wJus+QrcrXb9J9Czb976G9pQnXK
	 tPACxevWXxoVldZnvIwhEFT2ivDBrszslt7sC37LEFwLZuImRixQKW86fRkjImQOc
	 bNppOAosURvHYl6SHbAZLO5xBopADAgpV8EWSuoIK2ufOENXKvfEYqo5LBWrffUP3
	 iYDxIoerFeoG+IHEEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MyKHc-1x7EiR1gDM-00x6We; Mon, 03
 Aug 2026 19:19:11 +0200
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
Subject: [PATCH net-next v12 02/11] net: mdio: realtek-rtl9300: Add polling documentation
Date: Mon,  3 Aug 2026 19:18:44 +0200
Message-ID: <20260803171853.507506-3-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:kf4euuGsd4nUP0CRFV/hCbeZvy82R82iVZ/W/vYfZo++bSrSh1g
 Unz1iCYHbbtRe3gaPXk7luDYxwd32/w8eYMlniPGXz9wHd0ETKBKpfXYwcetpQl5br8tVln
 RidcIuKhFLLZrcdRd9LgwdB/cNXM+5cTZUj3EnzekXI2fhli4X3leNDvjeI2oU1yHF98NiZ
 KbaCg9AbzwblTcvU77YFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Jen5GOpCxG0=;KKfJxF4hIKpVeJds/uaXVktndp1
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

