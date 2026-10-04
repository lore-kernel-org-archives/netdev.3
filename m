Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879B03F44FB;
	Sun,  4 Oct 2026 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791092365; cv=none; b=UssQzt4iZNZ/Loe1z8HBZE0IQZo4JtAc82kz4rgt0k3/KvtfTTBjQ4N+OBfITdHXYZwiU9in64mPr6ugiR5p47w9vGOYcd041gW7VAoS0yLF6aUZtscExcIuKIEApfjzByX+LsWjEThu0nRDXKAeYbpO10RdAYfqYJ9hQ8iYJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791092365; c=relaxed/simple;
	bh=kO/E0+66Aeswq0UC8BtggpSkLfEi2Vb5MPs3YzxqsDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=at7mMg+dZZzUMYwn6QQeOaDX4ln3DoalqJrrtbY/bs2v4MUrpZMhoTE6ed24uN0LMbfXSvQi9St+JpxoMfABv8SFs86myDIOzYonJkxNKmgflvF6UGKdsKucRxl86KCoMy0+E7WjZz0ycxLLnWKeUsMtCr9uBFDmJteuGPi/i2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=DCQfmXx9; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=z0yPEdsH; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="DCQfmXx9";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="z0yPEdsH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791092361;
	bh=kO/E0+66Aeswq0UC8BtggpSkLfEi2Vb5MPs3YzxqsDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DCQfmXx96oHa68tmXivVnUr/izCsE+8rsx2n5LnSNh+hHjnae4PtP4r2D0yDHBESK
	 hZXB6VGJItHUdSXAsmGLQSH5Fak3j7gTaZ7cQW6uZwCgmJM8Ascu1gfkQnE1Ry3hZz
	 V7nvUXwgEUKln5AeRsLwzMStE7WDSUdzptEbAHGO520RhEjSwV2kX61a11bJGtdY40
	 +rzQnow/xAf1XrgJbKcSQGOE9f+kl2a78gry5plquYmHWz6Z2bL8viZ41w1O2KPHAx
	 sve1fsPwrr19hU4FkAIvoNDCW4zupFCG39nmLcPXgfTRORdD3TAWj8WPJdWo68N/0F
	 3aMCa9LLwBCPQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E1B6548385; Sun,  4 Oct 2026 05:39:21 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791092347;
	bh=kO/E0+66Aeswq0UC8BtggpSkLfEi2Vb5MPs3YzxqsDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=z0yPEdsHj7xgCYbGzosY/EkySdnwecyaa0Skfu9HiAU9Yi4VakVcgo11FE7PfqBAp
	 L7yb7wygZUPptiiEI0an9NMTV8kbBkxcHRhMwFEwyurmkw05R6JOgCmict581SClHM
	 0S/DgOENNIh0iiRCoR0Ls9dzq7gTiRxh+ot1Zl6CcR5tA+AK4VTkxZ82mHmz6StG/h
	 Iuz1b4VfZr9yU/P187k2IEUZ0UICHXAVNZoIGG2fgsu38DSt7lzq06GLyQia74HhqO
	 EUa6LNfmnEm0Om4xT0ds1aB69kezPgpVFKWteGNRIo4CYP/j33fX75nQH+rPe0xkHK
	 bdvaKFTA+n7Vg==
Received: from AMDDesktop.lan (p5dd1ef42.dip0.t-ipconnect.de [93.209.239.66])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 9179C4833A;
	Sun,  4 Oct 2026 05:39:07 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 04 Oct 2026 07:39:09 +0200
Subject: [PATCH net-next v16 05/13] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-ax88179a-v16-5-2a9ae4e68f7b@birger-koblitz.de>
References: <20261004-ax88179a-v16-0-2a9ae4e68f7b@birger-koblitz.de>
In-Reply-To: <20261004-ax88179a-v16-0-2a9ae4e68f7b@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
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
index b15eddb0ebe290fcd6da7653afec19918a47717a..96748ca49743dcaef71bbf649a543508be01b8e6 100644
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

