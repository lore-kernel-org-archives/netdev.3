Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BCD3DEADB;
	Mon, 31 Aug 2026 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170352; cv=none; b=L+qta4VC18Pe5cVo3cfejQlXZNu0Y9qFLe3HQdRpSN4JPGZSACVZf4NbUQpbiVsfCdO/za2DDhVUMCTJUvWhMpQHJqzL+OjcD7SfkkecUkr8tK+CbLOm1tF727w4Cn6wKiecyXLeWbuVqxPjhaP3xLo54PY9SKDr/7h34Pdl6AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170352; c=relaxed/simple;
	bh=++ScnF0DVp8QWqnrfC6nYqUG7xy4qO1nKUus8qx9L2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OoOHmQTVIbXKZmh2gqRhWACQS9ENCRRqF6FIM06yxkgNCCDJQ+N1WF4y9d95CgUoeykex6WzSmD4Xpbh1MUdRgtAcvMZ3nrez4zofeoxolVJmF/7XhC35g4wtJsviRqUMDUT5SsWSAAta8jHQfOYq7y7zYPsk0bvoR8XleM0dlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=FTHL4Xqd; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ddmOTrsU; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="FTHL4Xqd";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ddmOTrsU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170349;
	bh=++ScnF0DVp8QWqnrfC6nYqUG7xy4qO1nKUus8qx9L2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FTHL4XqdDX+UsWRJDRqfJ5DS8S0PxIYA9JMkzM/9aP5WOb9UUDcXV8l2D2BGpXS1p
	 XuTQ9JKctSKNCOJE/OQ0V17vWlyxed8WRSvPbPQb6r4jL3DvLQggyrVQaIO8/66k/B
	 VdbJPIhBoAScKO+KDBtWVR46w54AArpQygT2StuHPZYmVxtm08FB9bV9/UEBKvoLTd
	 6BGrwcIwyA2m/rfYaaxsf/wmzvDPlB6ikdCTu7QCapKAeAtQ1e0bVb9GQfS/6pV3Ji
	 xTGR1ywHlHD/rgfk0WbMqdYQT0JUVeICbQA8dEReU3s1oqFWn26TcpEBvhrkj8MPH4
	 XXNGE7wUgiIoQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 042F83EC90; Mon, 31 Aug 2026 09:59:09 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170339;
	bh=++ScnF0DVp8QWqnrfC6nYqUG7xy4qO1nKUus8qx9L2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ddmOTrsUTp7ty+1Y1hVxns3T5m1Cz8CDRHmRj9RXVjxmqAET0EDkisjwNiFVZVDlu
	 DVmB8Q5hVgD1zY1zDwGyCyNXNEcpoWO4kIQSQzyK/jlldTbSDxmi2wZR+3vJ8O2lYS
	 /r0XHZAOuXN8YzHq93uxuhNmLQcilP6rJNE8PmVSoHUwvn+6VaG+JEiF21UpeBRJw3
	 gMhbNrzcybFxnidlYDKR6oD2ELNsI5jyF2takYYXRhV+k1F4xSby2rdVFs8GL+WVVn
	 J1Li3A0A2JcnIqC/OunGFNDx7JO4RfsXHVtF8Pu8J8uEtiQL6/hQfl0iAB8hXBZvLF
	 +oNJ7uNmE9lJw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 31FC63EC32;
	Mon, 31 Aug 2026 09:58:59 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 31 Aug 2026 11:58:56 +0200
Subject: [PATCH net-next v8 07/15] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ax88179a-v8-7-de905f2ee426@birger-koblitz.de>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
In-Reply-To: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
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
index e76a5bc1d36da93a5de2eb1f6cfdf22d84be899f..cf2dc989f230ee47f4bf0b4f42ab02a511abc19d 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -394,10 +394,27 @@ static void ax88179a_mac_link_up(struct phylink_config *config,
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

