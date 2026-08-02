Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473772DEA95;
	Sun,  2 Aug 2026 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659772; cv=none; b=Pmu/f+nn04mj7IQW/1Es8j860o9HtK7CYg1lxiDhFdvFBA7EqCIQUD7sHkm+bEvQlhy8sTpgMJV6Le4T2IAnBCw0uPVk13IJ9+v9kU4GA3gODqCIkqT/xsAAHMhDPHe710z/+6XwK2a85eMsWe7VU6/U5+5ub+4+rYi/T/QhkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659772; c=relaxed/simple;
	bh=90QkMpi+2/JHlW8+O2FT8jWuoZwB9C+w5AZkxhDPlyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYo/LzVlZJjLiDiIKEj85B76F5pVEfoVdN03+R7MbxHpzbf0TR9ZyF5lFwUYjkVRHzFS5LF73xlAFNxqMGw8zr0trwsXd6DQB1E53bHogY1MqmLm4yQu2LCy5nHo88f0uTsDGAqNkGG7IwOLomreeIGyXMK0sWubyl2EFXF/aOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=MBP8PvoG; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="MBP8PvoG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785659744; x=1786264544;
	i=markus.stockhausen@gmx.de;
	bh=oJF5MvpNOR9xoFhX9Rn30mXfBhG4duCOVnBhgdJAAc0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MBP8PvoGHddD5w+Szm/mhhePeLLb9r6TGmoa2KAlxvVVY6TryPr0Akg7aMHf4o3/
	 5j/4XY5rTFlWz89RsdTjkBYN6W1qWPg6/akZYiCnayz1Djav4wBk1YAvYw84aHZa8
	 gXHo0W/ud6z+K+pRzhElnl+MqhlJeburRDR3QdbySYxvkFy3Rb7fyt62ZAhCYIbli
	 y3YvAzvVsn53Ay4h8i5vLZDzgQQZsUYKZZQToKJ/dZ3qUekPBnB/uIo5kPgxFVKFy
	 3x2QvqliK/hxwsVI9+eOhoTfWFDn8FLQ9Ocn2fIh8wjKReQo1F6FcT2X08lo2oXEM
	 BfsuZJ2K1uyYFxglLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMfc-1wl09U2i6W-00H3Ot; Sun, 02
 Aug 2026 10:35:44 +0200
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
Subject: [PATCH net-next v11 03/10] net: mdio: realtek-rtl9300: Add polling documentation
Date: Sun,  2 Aug 2026 10:35:21 +0200
Message-ID: <20260802083528.490216-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802083528.490216-1-markus.stockhausen@gmx.de>
References: <20260802083528.490216-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sSwLxJRtioLIZVvUcRifZKO+wQ1UpWcoCbze+5BbX3uK3c1F4RD
 64r4lr/wdcnygxrEEkUx4X/SseJQkh4WyhI8BukTtP/sfe0dP9BXlZyhpQ1uRAccu4s6dgQ
 Cy54ITryIf0IxUCZKP7R+5dcvUKZWPVlDSp/mkf5bqFc9LTdnNhU0TcCKRhT+AfMJJXRR03
 dOL9Yu+Oz1k/ZDQcy+ZnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AjV43NdW3I8=;ApsnDZgIa7wBxofe04OU3FiJ6I4
 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
 txrxVkP8C41om/YppP+sxs1TA==

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

