Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C26F3CF203;
	Mon, 27 Jul 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179800; cv=none; b=Vp+KtrFDgBzp8Ut7O1yrZzqHYuFxpzKvAS2FzcglQmVAMLh3T9hh7GYDq3d5GPOr8mgjAWW4lhzMMR42mH/CqO1bzQIyQyf+tAJF17zKQ9Q7Am8sNT/hFYU2NYEunQzno8IF+tGgFXem+48ZChSo8w7da9p28p4tyWtEx1GC9Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179800; c=relaxed/simple;
	bh=L5YC/sZ2QpVeNEpeZ2BRKP5JntgdZBdt2QyL+ubYj4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYzyisE07f7xQo0Hste0XcOyWwAui0kJfc1wQ9njSOvj1qMPTU6AqmywborDZd0jlPqYPPaj6LajVWlk6CAPUkwiYmIWbiRHIPkA5n68AZfih2jTe0PC+eiis4YdxG7v8H1cRfJnKr9PMteCCpuzLhNRI3s1JKPIA3HABtsEf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=UjPiRFCe; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="UjPiRFCe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785179772; x=1785784572;
	i=markus.stockhausen@gmx.de;
	bh=wfHwXvl0asFCK8Kz3AHpUBZFPj2n+hqqODivkrTs9Wk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UjPiRFCes4swGu98SSHyKhBvp0Jh5lIHIyIHg807Quk679d/FVs4uZAtSvWXKGpD
	 rEk0zyXi/unSpJFKxEhAsu5bnWpcXJaUBr/feUIDP88FIRG7CYohIdHvcAPfRx5si
	 jyTGS11xuz1/B0iChKRor9si4T/4MdVidoZioKBEXibQHrWREDCvmhHlN/3IPQQRb
	 5He4mOobntQgvX6HZCwWStF8uqmVtiqLwxnzoYyNnqA7rid0hlid2lgx5S4LIYFls
	 /UvUeW1Wqbs2+z80lUZRQQvE6skdtfZrPYgJ+Db9M61/nZwNjUJzBqzJRWnTuv4TA
	 AdukWQfXS3VZRXC5VQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79yQ-1x2dE031bQ-00tlbX; Mon, 27
 Jul 2026 21:16:12 +0200
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
Subject: [PATCH net-next v8 2/9] net: mdio: realtek-rtl9300: Add polling documentation
Date: Mon, 27 Jul 2026 21:15:52 +0200
Message-ID: <20260727191559.19617-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727191559.19617-1-markus.stockhausen@gmx.de>
References: <20260727191559.19617-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v4W2kI9K24zaKJlhDjj5xeqzl3GJHl7zrK0HcyHLtyFfDI5DPmT
 RfHxa3RU+wJu9qlUfZo1GhvGnDd6iWlMbwYdi/ojsvELOP3Rf2jpRq8hjWqQ5XGirjMqoIw
 J4tIyyas+Al8QTlNoq2BD2tPmEww00mp/TlP3E46AYnv2NUK+WfIAuWNVhoKF+QRaQbc31b
 6vhskvT6svBM2bLlZOOEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vTLjPdiGfFs=;OEGBE4OFR68RPkJqE9tAXXmjC8N
 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
 gCkQ/M/VNZJ1wBV+NBLCL

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

