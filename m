Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608AB3B9616;
	Thu,  8 Oct 2026 03:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431490; cv=none; b=OB2qLMmHbKFZ9bWlEor6FDZ3Lovayq/FZXT58uhJCidUqxg36c5m6KymVXyR/j2Jz27QMJxi29HcrgFjfRMY+0OXNIKhPAc/EBNbBWVCMW9oDX45T+Vh0tPXMwJrifWmeRabUiJlondXEej+J6CjMB21HDHYuapWK+5gAX+u0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431490; c=relaxed/simple;
	bh=MZfBOekyJVkD0zyE2lnjmd516UzXjDlS29Kh4yD/Nwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnNuwnJXkYopCPj3WppDLOz4NbG5gK2liwh9TJ38WD8Z//mt+26ZzNtPat3O6yXdGy6B60taUC0PPy6VHycVWpkPleaEU+Wm0JckIJZApGn1VzxaANMIYt/8poRM2cBBA94xcQJx5bGRhV3zLtPO9ZqDUB9h5eS9MqhGUXDB7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=U67utxsI; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=2YVI9sCk; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="U67utxsI";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="2YVI9sCk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791431487;
	bh=MZfBOekyJVkD0zyE2lnjmd516UzXjDlS29Kh4yD/Nwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U67utxsI0Bn2eS6c1hKU+Z1DpfMMq4WBQNEtX7iEKXq6iXadymxI/IpkAx8MfOqWe
	 m6EA2VYk62mjVseWn0g3ribtZWFAf0xKCw8qLyyFfYIb2unErcZSW+uQ2f6TgCcp9O
	 T4q92eF8vJTcBrfggL71a99ewEQJnYf8G3E1Hyf3mR8Xz6miivW1FZb1QAM15qnye4
	 yiIySAIpFKAwqLSYJMqLs/ThvEMiT5MnQVIMZwEYqvNaef6JeVxrDS54mQ1m1EtOm+
	 ExT/uOlaxt0Bmn635+wQQd4HMAh+GxwbqtaYaZOcfheAji9HedcZ9UHmEm6hlTuu1Z
	 5rRFgCyjod5hQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A5FF847225; Thu,  8 Oct 2026 03:51:27 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791431477;
	bh=MZfBOekyJVkD0zyE2lnjmd516UzXjDlS29Kh4yD/Nwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=2YVI9sCkIne/bsjIkjQcIArZ/CNrTk9MVcPtxkSAqnGwm1drhMbTYsL6V2ogDwlJe
	 KHPo8rkzQNOdSRfBDkaNeJiuKTmI/QUKmNzTcNzWom6zjF+19ljS3QxmZba9S70y/p
	 tyF/P4hawruVdES9aOO8pdmyUefO5XVFtf++3UpbiYKNcl4QDQzixVvjQK4ejaA2Pv
	 HJpFWeq1a1chkXs/XlOXUflBnkKRLQzkXuzg8dJg5BI5EXKeBCXGWt5GgZakADgLlV
	 SksU4W78KF1yJLVCP2b8hBXYOVBaCgMjjgEf9E05u3rhDy193TFMLQ8c2j9yEifv6Y
	 7F+VAoXDx1Wsw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id BCD96471B6;
	Thu,  8 Oct 2026 03:51:16 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Thu, 08 Oct 2026 05:51:11 +0200
Subject: [PATCH net-next v18 05/13] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-ax88179a-v18-5-6fa1d4c40422@birger-koblitz.de>
References: <20261008-ax88179a-v18-0-6fa1d4c40422@birger-koblitz.de>
In-Reply-To: <20261008-ax88179a-v18-0-6fa1d4c40422@birger-koblitz.de>
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
index ebc6ac2c0b27333d60742422d81e63882ddb1005..692ede39c9e9a0cf546733c8d0f71a199385eb6f 100644
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

