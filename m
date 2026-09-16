Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD9399013;
	Wed, 16 Sep 2026 03:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529092; cv=none; b=F3rnAxhXFSfZSI5wIc//zs2wXMNLOAXsxnD2wd/9CqQue2YrXuRpZNh+rEUR2NAsJmDQ09H5akSp/XcFso5x5zI5833s8VnslzREJU3qtWOiTfIHuBinlkRcS5PIe9ZYMm425JODIIfJuutHrh/FYWeO7u0MdMs9lgz6KrtPbQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529092; c=relaxed/simple;
	bh=LgT2j6yqRy2OxDj7YnSkWiMKWiluE/LZmQEYV7eqCVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tec/P82+QZBB+nVfhLMBJCc7rEbKsFH2HFSh6B5E+gaLkQShxV+N+WeNjbox4tAG/ws192PzR+Fn5mIvoHnjBG0KbDyqK4mYChScw7obifSLdbXTGRTY/IeBMbSg8b6z+sPQD1/Gtb9rHAg4LxV3Li8y9t5hKmBUJAuwUhMQMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=aTIWzxfc; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Bl/y9hgz; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="aTIWzxfc";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Bl/y9hgz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529089;
	bh=LgT2j6yqRy2OxDj7YnSkWiMKWiluE/LZmQEYV7eqCVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aTIWzxfcBL9RgCSShzvcUmzEzCKXX2otogmwNh49XpwzFSs/nOM07PMAyr6m3VYsl
	 jHNsWRs88NnzWgd0+2PnzPjEJ1IgFv0x3kifBu07cmscADOTJop/jo6C7HWdeafLii
	 iGt6lwHFV+w58dgFBXAxEOlXCByMM7VLCyUpbunQJtbfQpVTzOUrykSx02wpfkcTFv
	 ztKC6QmLV6aklZSA7gZjU8SsrnH4HzI+C0o77BEfSW6BOQ4ZuembhuG3hTMSjzkCqk
	 Epja/JUvRzIc43PKJ+QH+nJA21bcstzEXx1eYSjcp6kIfSnJoNSH0W24bC1gAXi7dR
	 +HGymMqREoDbw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 4CD333FA75; Wed, 16 Sep 2026 03:24:49 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529088;
	bh=LgT2j6yqRy2OxDj7YnSkWiMKWiluE/LZmQEYV7eqCVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bl/y9hgzdHtDNxD5ot+IPZBXJ2MX0h+t4J/Qv29MFt4S+ToNmYVgMj6/2fQDE4qY0
	 G5wE/onUX7MVNXiCIu6Yf0ynkKkeNqBqhdCUNN6guSIdAIorPH6mszEWviYpZ8POjb
	 bTzo2HBiUOfNKMIPiC1J4PuPrR8da7QHw9LvC1xEl82V9nUGBCRFhz3vOjPDvyKrPo
	 c9QgRH8gmT9a+A33PCyJ2EpdGQ2Wei2M9ANY+m5xU3TownRNyc0Ze2PXrmT3M66Jou
	 7tYmsVOSaF/jddkQB1ER0zZGZ+MmDo5kQubA72rHLr5b57J3bFrrFm/TgHTUXaEQfi
	 /qDej+HEVTidA==
Received: from DELLLaptop.net (unknown [223.86.26.228])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 50C273F6DB;
	Wed, 16 Sep 2026 03:24:43 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 16 Sep 2026 05:24:06 +0200
Subject: [PATCH net-next v12 07/15] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ax88179a-v12-7-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
In-Reply-To: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

The AX88179A uses a simple HW configuration for EEE
via a single EEE configuration register without LPI timer support
Add support for this EEE enable/disable register and replace the EEE.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179a_devices.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 5dac7a137c323ba18375aadd631f7bad6de22a93..785919e14e861e5e44a67a7407690a0cd8ddb180 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -384,10 +384,27 @@ static void ax88179a_mac_link_up(struct phylink_config *config,
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 1, &tmp8);
 }
 
+static void ax88179a_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
+
+	ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, false, 0, NULL);
+}
+
+static int ax88179a_mac_enable_tx_lpi(struct phylink_config *config, u32 timer, bool tx_clk_stop)
+{
+	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
+
+	/* AX88179A does not provide LPI timer registers */
+	return ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, true, 0, NULL);
+}
+
 static const struct phylink_mac_ops ax88179a_phylink_mac_ops = {
 	.mac_config = ax88179a_mac_config,
 	.mac_link_down = ax88179a_mac_link_down,
 	.mac_link_up = ax88179a_mac_link_up,
+	.mac_disable_tx_lpi = ax88179a_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ax88179a_mac_enable_tx_lpi,
 };
 
 static int ax88179a_phylink_setup(struct usbnet *dev)

-- 
2.47.3

