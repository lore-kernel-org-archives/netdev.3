Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792990504;
	b=fCsFIHp6T+usguq75SCSklYEnfGojOTd0K0SdHzwG7k8/i0mOkMwMFgw6yBPCDyxLjZM
	 COuqpXJ2rdq/GdSFqOFC/IQaJ6+/GoJHgoLkLGzGZbDM9wdrpqdHJ3i2OMoJqgz3p4YRs
	 QGk93U+f6zDuuD7exFFEWUKGvtS2DXKWizIq/pmj8XXc06sGPJ736GQydjBRnI/fnlwSA
	 rCq0Bd3izg0qOlaPVLqqgVYNo3NCsDUoXfgy96aDv16OLgIL7TAUe03WY3IUpvZNl9qcN
	 R1YnA0FHasOJcXZq3apdpsIZwR59BHk4td4ElxTgfa4c1Hk4d/6KXUn7Nb8CCPH6JMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792990504;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Tx6DnqrGDY9IqsJ3uNvaKkne162q5Mtmc+8Cn5vVktU=;
	b=L2LmFYl9RuU8uwc6zlLPX4pMbbCsoXeSAfBDlHRfDiINYyM4rfzs1FbANlDQnbPyG165
	 jVcb85H7JkWB9PIoItwBcwYsXo0LSobdG1WHW+J4GU01+H1jA9aFJHHyCiR/qe/TD7sSw
	 qWmqEOkV6M+/le2qM/OupUFyf+k0QnEZn7A3MUqQxgfgxZMHZVptqr+sJoR5JM5rRUVrt
	 HyYWgVTpQzIdgmxaETnMez0FUJp0PBGSea3Pvw3d4Lzu8JVOJPyK5ZHV8aDxFcQ9Wy62M
	 4Dd3GtgCw4sVnORnu41icaSD6ZHTsV3r/EjJKcKFzrk0veTFIv0OBbA1OTtJaVapauw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=YjTbs8pV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279B606A329;
	Mon, 26 Oct 2026 04:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3279B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=YjTbs8pV
ARC-Seal: i=1; a=rsa-sha256; t=1792990452; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Vnyl0/xgFPk4QCdETPkuQ00PzvB3gszxmomqlXk0j0Pv36bYyX0DxMPqMts6+MLkxIdTHDneD3qYG1QWfdUIYHNKOY4kY2l5Y8+RtPjbxSMnyaq/qylZKrWoRlUTZPf5jRolac4nxup5PiVk0ZChQVgThtuo6v37IhJOLwksQ4A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1792990452; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Tx6DnqrGDY9IqsJ3uNvaKkne162q5Mtmc+8Cn5vVktU=; 
	b=CNO8aQelAvD3IL9RWonfRnB0rQcSVort6vpuEeEZ6yimZhsExLjZPmutAut36vzC7roFu1ldQtbT94bjwF4mznZ2aaRZWx0+bA88tgX4z3edE/COjv5a+wZdPdq6DpjLd53zv3CVNMxztulV4dvwvixhz9bEzBRz971CVqlrbHo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792990452;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Tx6DnqrGDY9IqsJ3uNvaKkne162q5Mtmc+8Cn5vVktU=;
	b=YjTbs8pVv5KrvPDTqSRpMhSB2I8VPhSF4LKBW0jfX4TAGryuG9ythidX02ANviWb
	F0lFX9wA/1NHwVROp8jElumGX51ybbD1CfVMHTsxWoqSJjPNrBpdsiXTHQzWErfUCgS
	MqPCOXMSJPe3pafQwpVUYqebmIgVwNN08Yx3Ax10=
Received: by smtp.zoho.eu with SMTPS id 1792990450628417.61970225618165;
	Mon, 26 Oct 2026 05:54:10 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Wei Fang <wei.fang@nxp.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Igor Velkov <iav@iav.lv>
Subject: [PATCH net v2 0/2] net: phy: postpone PHY interrupts during sleep with MAC-managed PM
Date: Mon, 26 Oct 2026 06:53:41 +0200
Message-ID: <20261026045343.837889-1-iav@iav.lv>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the MAC driver manages PHY PM, phylib never sets irq_suspended, and
a PHY interrupt during the sleep transition runs the PHY driver's
handler while the MDIO bus may be powered down. On Helios64 (dwmac-rk)
this hangs the board on suspend as well as on resume.

Patch 1 moves the two flags out of a bitfield they share with the link
state written under phydev->lock; patch 2 sets irq_suspended for these
PHYs too.

mac_managed_pm (fba863b81604) means the MAC driver suspends and resumes
the PHY; it does not cover the PHY interrupt. Neither phylink nor any
MAC driver touches irq_suspended, and resume_device_irqs() runs at the
end of the noirq phase, before the normal resume callbacks of the MAC,
the MDIO bus and the PHY, so callback order does not help the
interrupt. v1 asked whether phylink_suspend()/phylink_resume() would be
the better place; v2 keeps the fix in phylib, which also covers MAC
drivers that use phylib without phylink.

Changes in v2:
- new patch 1: bools instead of bitfields (Sashiko); sizeof(struct
  phy_device) is unchanged on arm64
- phy_free_interrupt(): re-enable a shared line after free_irq()
  instead of dropping irq_rerun before it (Sashiko)
- reworded the comment in mdio_bus_phy_suspend() (Andrew)
- described and tested the suspend-side window, noted the wakeup
  event; the v1 tests with Wake-on-LAN (Helios64 20/20, ODROID-HC4
  10/10) were on v1 code
- W=1 allmodconfig/allyesconfig: no new warnings

Not tested: patch 1 alone, and a vanilla net kernel on hardware; the
tests ran on an Armbian 7.3 kernel whose Helios64 DT describes the PHY
interrupt.

Link to v1: https://lore.kernel.org/r/20261002043548.1302145-1-iav@iav.lv

Igor Velkov (2):
  net: phy: move irq_suspended and irq_rerun out of the bitfield
  net: phy: postpone PHY interrupts during sleep with MAC-managed PM

 drivers/net/phy/phy.c        |  9 ++++++++
 drivers/net/phy/phy_device.c | 44 ++++++++++++++++++++++--------------
 include/linux/phy.h          |  5 ++--
 3 files changed, 39 insertions(+), 19 deletions(-)


base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.43.0

