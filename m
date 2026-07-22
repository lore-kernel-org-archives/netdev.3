Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB0C358D00;
	Wed, 22 Jul 2026 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701456; cv=none; b=b8pGkEdm3dtselygIxJha+uL7xi36tjIghSa9N1c8QMaLqZ1qnrApQT+U1NcEpwQUEyw+XeohA5lnzpWEPBIPaHY+ZIMX3phs6Faoz/LFkydqUbc1TCtjFGGB07lbTnOQMOLJO05pwPWoZhpXNd2ZwwAAI/gSiIEr43u+HIE/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701456; c=relaxed/simple;
	bh=FXTPn8htFc124U77ajJtcqZBuokkA6sg3gE5WnKnxko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4Y8zwqs8qg2Un0YQHtJbKnoOVISG36OHMvJUy5jTgWvPvyaSAhSsmsXA+w2p2uApAqtMxRJVkXs3roCk4NgXJj/7WLr0f61ce2Xxp0hV34Q6KrpGHlnBaekaQdzuOk0oBBZS8sl8LL5zAqU062/Jn8kxmsGxry1y9+6TLvDp9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=XBu5DEq1; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="XBu5DEq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784701448; x=1785306248;
	i=markus.stockhausen@gmx.de;
	bh=SK4Hl1YKok0iuE9BgnelaLmANdbD1sHX+/J6pYgEN48=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XBu5DEq15EOalVKfgUIWAh4aTlf+6SFE9gYZT2QyemfDHH4mN4nmkuZhiK7hjPhe
	 7Qmr1lbw2Xi7WEko3l9U0RIXmduTzm2krVo9VS5G+iIo6A+Fjlfb5blZUPYfiR/Gn
	 fRbuzaJjtWgkS2IycVRepXQ6Fc0zbUmWcMTwjnp5vZzHbYAL4H0UmnpXA8Sa2apcV
	 RqrWYLX1Xb+Yk29BlGC1C4tW0ds+fQ7h+KYcWi4KfmrptkScJssG7H8G98vxVeSAd
	 DHzCUSeZLfrxQo9WDQBW1i+8SXmTUPevsjVtB9CdXWpkxGXVisGE6glwyDD5LQgUa
	 CCPc/46cMoAxGfdxnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UV8-1wmyKz3WZW-003t1A; Wed, 22
 Jul 2026 08:24:07 +0200
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
Subject: [PATCH net-next v5 2/8] net: mdio: realtek-rtl9300: Add polling documentation
Date: Wed, 22 Jul 2026 08:23:50 +0200
Message-ID: <20260722062356.12291-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722062356.12291-1-markus.stockhausen@gmx.de>
References: <20260722062356.12291-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xjhFj1Qc/3FKJIaz9EeIiCP5Oo3u+4mpCVuBWY9yeHmobXQK2Ev
 l43Wzc0vXldfmDKMiEwAyv7q8NZCVF6sIeb0h3M/S6HNnT0cLVAhERjkINm1Zv4vYzqwgGL
 nQ8G679N1w33eBOdEWPPYNjtakGb6w0FWfjNmZoDs/kL0kHFEMaFz4TeEZO/YUE6O37U/iN
 6kAlefIHV2X/S9+kSTteQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Uq/24iYRYQs=;n8VfSDXs9/Z1yUfIllCN62Xk78I
 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

Add a detailed explanation how the hardware polling unit in the
Realtek Otto switches works. This simplifies developing future
patches and reviewing them.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 68 +++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index afd52a1cd7f8..8269ec5c92c4 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -35,6 +35,74 @@
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
+ * From the above snippets it polls MDIO_AN_EEE_ADV and MDIO_AN_EEE_LPABL=
E via C45 over C22. As
+ * of now it is unclear how the hardware decides if a PHY supports these =
registers. After one PHY
+ * status is read, the polling engine goes over to the next PHY. Basicall=
y the bus is always busy
+ * and the MAC status is updated in real-time.
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

