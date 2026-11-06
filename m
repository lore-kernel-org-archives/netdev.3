Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.97.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949701;
	b=VJP+etMT0aAGvcmwmOlXk7eN84Ly8BnDo3Mn2go7V+7C/kg1yU5GqWmGn4osq9FRWlXY
	 0eoBid0SWu3ZUUezfnD/Om8jwxv02JUtLkJoQsBUnkgCauc5baSXDgSRy6w7j8NWLyQ+6
	 Ds3M9DUltPnEl2SA1bdfqu9L+/aNrZqKfM7Plu4uUmID4TOl3MSec+zIaN4w0OIXf2HAt
	 IiYz3tKrlqww3lFvcWKR9wnSw3e6j9eQzCmlNkDx6GcKhH4cNk+g92fRXoy9WIW4eAizA
	 /QrlP5IIpBcFO50+e3Wn+83EdC7XiyfHAIiRrW0RnibYNyFrEPEayPxxwGV/yYMTTYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949701;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=26rwK9emvjRNxgkx1aM0VjRaoRMNaYYnmRitPoyIuNc=;
	b=pSvK5UiZrCRNdBnBjjPtSjBJy1/2ohq2D+vT2QH6MDx1EWgwxcshNj+OZldZ/iju8ZJ0
	 nWFiNrSLqQHWy556CCyYSY67dNfk60qjzRTGhBpTnYVO5xPRaOVPCGosJ0AZS1zU0hhOf
	 tXc6q9rF/wjU6w6yCyEQL0iFTLM4sQNFtMUuB33y0LrckYx+cdU4wEhC2MfFW4jKMslbq
	 Qp2Ds7xxJXCXTq248VmDfPZeXGPfY0C8qkb7ZgNQyfNsAm2j89L3VBcIHR/HGkzarUu1V
	 tzmadr+04RZOL5876rIY81XwBKF7s2z6hUTY+7EZJZLmAYUUIMIg2g23f4GkQ9HgZKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=birger-koblitz.de;
	spf=pass smtp.mailfrom=birger-koblitz.de;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=LQLjVKMg;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=MU5jOZYH;
	arc=none smtp.remote-ip=23.88.97.239
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C452606A339;
	Fri,  6 Nov 2026 07:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C452606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=LQLjVKMg;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=MU5jOZYH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949699;
	bh=t6c76qrcB5Xzyp5vYgM4qQyIE9cJhW/WseYa5dwzUCw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LQLjVKMgnXFOwac50vuR1abAbUuAFBak4s4BG/HyIVYJF2Z9f9oZohRGVnjtRK6Yo
	 SAoKmPIPKOvEuheOfYHa3J8Zjgnk0tY4vbPXYT1U5VNYdhRX34LuPSZVAV3TNQy67i
	 E6jay5GiVxd71TQ/QHAJst/uw+KOp/PCzoi3VUOjEmTlZ855cAz3C7mPe0wayrNf07
	 NzLY5MSXHpOdAS6KYymHBEEVZwBsrXqGeu/k6d6ldVqgqOKmeFnnikvb+WbAOAvP81
	 i6rRBLOmrSrLi5i35AgjbcROj65twWR+qPsU3TUAzeMhTyfEFO6jy+yfswHZ01zWIq
	 XnuKn6zfo6uNA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 2B9EA48BB7; Fri,  6 Nov 2026 07:21:39 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949686;
	bh=t6c76qrcB5Xzyp5vYgM4qQyIE9cJhW/WseYa5dwzUCw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MU5jOZYHlwDlTgovqPNIV59fE9wyN/vLO0RoyQThDaLvVW2q/NrEBqEkF+4LQa+4f
	 +j3Kt9fgPlfmhcddgZZcRaCjDg7fXHLjrFcPa0SlJ3Urpo/YTiLdjD54e22yiHg73l
	 XH8+4VLOU7k1RVmwBmP0oTb+0c70DTVoox6dy6uoUJnVeRXVd3n2XRJTrcP+Y89Ahu
	 QLTAaufu64FZP464xBwQjdD7UY0R3wXSUgdzC3lgWxfSuxXYXMCKeY5qxS7qpOGueA
	 XZLWFU4oamEIRpBpN0QydAxKJE7cn/O+MY49Y7KO82mIoElSw/wnvztkevpLoiFrsX
	 tHcu5IudMjntg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 9464448B8E;
	Fri,  6 Nov 2026 07:21:25 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 06 Nov 2026 08:21:20 +0100
Subject: [PATCH net-next v20 05/13] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ax88179a-v20-5-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
In-Reply-To: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Emir Beganovic <beganovic.emir@gmail.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

The AX88179A uses a simple HW configuration for EEE
via a single EEE configuration register without LPI timer support
Add support for setting this EEE enable/disable register in implementations
of mac_enable_tx_lpi/mac_disable_tx_lpi.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179a_devices.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 1aa8479422517bff6758c884c5e47258c5d3ed3a..62619fd68c408f453e48c94020bce2254da9a1f9 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -395,10 +395,27 @@ static void ax88179a_mac_link_up(struct phylink_config *config,
 			 AX_MAC_RX_PATH_READY | AX_MAC_TX_PATH_READY);
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

