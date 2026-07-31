Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC0368957;
	Fri, 31 Jul 2026 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478478; cv=none; b=mCtQB6xY41oWGXE30CmdQ6PQ4EqMyLflrpk8vhsbAEReYkzfQqQEBnrKBQHCeEly0kdp/PkKWZNOTlbKCEzSopp1OMulSQ0HOExNYBw2PYPl07CvWS1GzcXeiUCPwNbRa0y3WuJmcQYhfOUaNsO5FM8HRoyIBMjy4fWBm5WsQY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478478; c=relaxed/simple;
	bh=90QkMpi+2/JHlW8+O2FT8jWuoZwB9C+w5AZkxhDPlyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ey3eL8aGd4s1YS6th6J4dRdDv0B9ZRHQnltTEGHZllrkIP9NoGm7EHat/Vsnp7aWYiGG8u5uSPd9xk9kD+GtTlRp3LP6HEHLIszaJSsXJ1zqWL3AdS44AB6UsuloBdVPM3aMoqd/9lDgP5k9AcvbytjveL5dLZsJmCFqkUTJ8RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=HsSbOoCx; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="HsSbOoCx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785478454; x=1786083254;
	i=markus.stockhausen@gmx.de;
	bh=oJF5MvpNOR9xoFhX9Rn30mXfBhG4duCOVnBhgdJAAc0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HsSbOoCx2RNUh6Luffgb6XhpubRCbkR7h0oj3om5N2+V2JtDajOd0X9jKZpNQ6K2
	 ElHiSVhYnGx/68dwH9/HZfKGoA+duXqSZPfNZ8utkNWZt3k+jfBqFO5dzkwNYFsSi
	 sQSCH7O5S3yD5v8nAnmNK+zlSFNbdSyHWdCloCKQHvM5eeAkLDf9vufLkLrPwzLB4
	 ak3lG9/RIUld93ESCpnWMQqVn29AUxpalUCnIXw/6q/Md8atvXcskh0VU23fKsrUF
	 eHe6VerIjpfPUyT9DRT9vO+ERIfbKKNN3sxlAF4zOHb/BOgnF7n5N9oPqSKr8QGP/
	 7TkFtcAmecZughwqiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MO9z7-1wabQl03gX-00Mwfc; Fri, 31
 Jul 2026 08:14:14 +0200
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
Subject: [PATCH net-next v10 02/10] net: mdio: realtek-rtl9300: Add polling documentation
Date: Fri, 31 Jul 2026 08:13:52 +0200
Message-ID: <20260731061400.78301-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731061400.78301-1-markus.stockhausen@gmx.de>
References: <20260731061400.78301-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YKUldfCdhnqJS/rANST/d2NkKIAuCPMoQA2HdTpPKGWCUGBK/Ao
 G68TYf8tV4vdcRxXVr3BmZN5JGqpFBFvxU21by3EFMZZKscRUBJBBPKKJ3Ok1mHiZ00gU/g
 /Yxwo5MHXfkvqtE5FVHhS/jbvs82dWsXZnuVoLq4jEcSEUqUTSuqN555u2aP4WIrHtocjPt
 IJPuKxuv3VAIC9pZ/t8dw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RmWEjmtp0eo=;QSH0YqVzABwcBupSYzkTjx+HLYr
 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
 XupDZD5tOmQv

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

