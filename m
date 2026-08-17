Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5316E448391;
	Mon, 17 Aug 2026 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984017; cv=none; b=HF63mUN1jjEF3bRTSq6W1x03iItni3br9WVWUvCke7RgjumN3kwyXvzhvm2vMSEhxiMzK6UEg2sHkFM+qd3OSNaqRgMnkWJzuTfoU+ipK1N90l4Xxhiv/6BetfDnGZRTWk6m5pUS4dGHKBxbPDzPu1z0LV2gzU2vBr8PKKnl8lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984017; c=relaxed/simple;
	bh=5/lw5sZpsLyAz1JRaJWSE71skFZpQCmTU0OmQHURBdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvU5ofWM876y2AfwVJLPAZaVMqFpC72PQKrtPbV+ptSKBfmvNOgQCfGkmBNe4nJNVYkPyHMLF7y7tLlJfAI96xe6jZL7VdUPMlbVEQhR4OZ/wSBtubSIcgRGfXH310kjE+vEdWj01AN81+XnpEBLzecUdy4uEmteWB6W70uH/o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=S2StzWvr; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="S2StzWvr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786984009; x=1787588809;
	i=markus.stockhausen@gmx.de;
	bh=7Zitt/SWRk9KOmy45oJeGbbCVQyAHJj52bKEQEf/c78=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S2StzWvrmP0XG7S0N3ay/j9rj7YQO8xacZGL5RRfWY7pHbgzeYdw/8ex/ij7MeJu
	 vcpEfYWV7wmP19UscqN82wcTB9y+UfDvI25t19/IOugzQW9eZgJvANnNh/QDyIs18
	 hZWb1nDrwC1OhwKxphDyrEDibiWxH+HKJgGx5EJNGbtgNvkm2JG3H/vvoPGojm4qr
	 FUZaIVIsFLyBWbVSNcq0u0S3zX/mCW6ee21oxUGq01LyVp2e0g/5g0FSqbQApfrU7
	 J45SstQUli1Lj44Hw5jlk5ycQivlIJyDdO0AbjbsUih0aGaG58q6XBK//mRZ1q0/j
	 PrqXFQ45u9OUOPNVKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzOw-1xLM7Z1fyu-00IRGa; Mon, 17
 Aug 2026 18:26:49 +0200
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
Subject: [PATCH net-next v14 02/13] net: mdio: realtek-rtl9300: Add polling documentation
Date: Mon, 17 Aug 2026 18:26:21 +0200
Message-ID: <20260817162632.1208891-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V1LuWph8nKuJIT7ltmB/SBM4jBROoDXKjXvJKCoMCRHnPI9mXQl
 2Rf7ISyrIOYVNu6GisWDNdAjWtXoCLMyYFpBYePGr58nFoFBKAwSblasqU0ZhH08ouOLpiB
 W5fRCVmi1c/7+Wtbs9JSkosyGjymLHqkX+6Bpwe9ChzIkQNxjjH3x3uKVI3znfkL5QhPBps
 zV3nuCknR64lPUZdbZItw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vCT02QLYpAo=;OMSc+4cGjIGetEINOKk8UdWBQJ+
 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
 0qu92F1+RimRYnqxZaIrBL0tFBYg=

Add a detailed explanation how the hardware polling unit in the
Realtek Otto switches works. This simplifies developing future
patches and reviewing them.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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

