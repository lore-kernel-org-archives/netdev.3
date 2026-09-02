Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED734AA011;
	Wed,  2 Sep 2026 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368259; cv=none; b=gAq9L2hNuNfTpQ5S5fa0em9QEYvLjg1QR+29JH2mz/epGktHWxsUVSUnoQhlLUq4b3oSrymuQSExhJLBhJIftDv1GOIKQPxtYcVva26rorugOQ6533A7XLbWlvVIPp7ZxgdbBpSwVrCAfSsRMVmeZt6G4YdqyD+jupZBIe+Mwo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368259; c=relaxed/simple;
	bh=ZGl5Vcmlux3CLdbnKMcw3UCD1AYWBXFWxW0/LVCsG1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LUpQ1UHHANOerPj3y39siDdPxCF9JSA44Us74Wrzaz8bImLe0B/VHmlchSRkYZ2l4CZD6Ii1IkCGtvhAEk4vdqifWGNJ4Xf5JKfIjZO6s/D1R5v6ZcPt9JWydjEgE81lPHD/PR6TOUSMqO61b+4tNaR4LvChyRlsdJ1PX1PlJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=h9jrzJa9; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=3MK8WXi5; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="h9jrzJa9";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="3MK8WXi5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368251;
	bh=ZGl5Vcmlux3CLdbnKMcw3UCD1AYWBXFWxW0/LVCsG1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h9jrzJa9ydxKl3ePh7Zbz98qb+61LCfSrMYskdoytEcurl/ybVQcpBb8ca/L7J8ox
	 9VjBqJwSIRYnozKK0CdUr1Jxz4D05dSVecnLAFUq1DMwqA4Y08+pE2Jj7C778cGFFN
	 sQRi6clKG2pcHRCQx6VPjLNO5446f66iXd+YdVVsvn3QsyVUbm1CgHUNXfx4pxnEUY
	 RCo4qRYpxVKrzk0AY21Dye3acc1Etied/4dCUH8+XiANWByOmEOe8cPVA+sEXiuVMb
	 obNigXY8/UvYiQkAMpaSi9OeY2dTEEu71NwWOFB7A6DA01C/JqoNlp6+7K/8jVwrKS
	 yURLt6HTgWg0A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 394DE3EF20; Wed,  2 Sep 2026 16:57:31 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368245;
	bh=ZGl5Vcmlux3CLdbnKMcw3UCD1AYWBXFWxW0/LVCsG1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=3MK8WXi5R9EZuKmWqu/tdSoR1bwnQSdytI2bhesSsJsHtf/dqIlmExFqVjKJQt2BF
	 Da6OyIhKg4G17zzjKk5JZamo3oHwJq72gkrg3BNP1HqWHeEzr/0uO+rpgSJxYL6+5K
	 8fZ3gZh13SF4ZWZQ+J6PrtrKfKMs79gBr1BVYAM1YX3eDvl3iBJ65ygRhYKbMzF18f
	 1hi6fT5VO+0KeSIqAaZWoOiANbI2tpoyo7OFGOXWx2r38VE9Wgt9NIzsKYmU0e/gtx
	 fuUu0f9UwcvOx5QpmKCa0BihIFWLBW8vp3zU3yXmVqxx6xlq4v+oxZpIpgjH00EH01
	 bOdnlaYKObmkA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:c4e4:2069:f0cb:22e2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id B36843EF11;
	Wed,  2 Sep 2026 16:57:24 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 02 Sep 2026 18:57:19 +0200
Subject: [PATCH net-next v9 05/15] ax88179_178a: Add netdev2data()
 convenience function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ax88179a-v9-5-8e6d7710a2ae@birger-koblitz.de>
References: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
In-Reply-To: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

Add a convenience function for the ethtool ops that use
phylink and need to retrieve the ax88179_data structure from
net_device.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179_lib.c | 7 +++++++
 drivers/net/usb/ax88179_lib.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
index 761701ebc0692338b5c0a9f73d0b6965cda87d6e..ea36aef3d3e45ee4f84362a1b87628a12a355bbf 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -128,6 +128,13 @@ int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 	return ret;
 }
 
+struct ax88179_data *netdev2data(struct net_device *net)
+{
+	struct usbnet *dev = netdev_priv(net);
+
+	return dev->driver_priv;
+}
+
 void ax88179_status(struct usbnet *dev, struct urb *urb)
 {
 	struct ax88179_int_data *event;
diff --git a/drivers/net/usb/ax88179_lib.h b/drivers/net/usb/ax88179_lib.h
index b2ee1356727cf4b3fa05f0b0d5fd863ac3f9a87d..9ff2a94a6fb2de4ee85f25e913ae2fe263bcea7c 100644
--- a/drivers/net/usb/ax88179_lib.h
+++ b/drivers/net/usb/ax88179_lib.h
@@ -181,6 +181,7 @@ void ax88179_write_cmd_async(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 			     u16 size, void *data);
 int ax88179_mdio_read(struct net_device *netdev, int phy_id, int loc);
 void ax88179_mdio_write(struct net_device *netdev, int phy_id, int loc, int val);
+struct ax88179_data *netdev2data(struct net_device *net);
 void ax88179_status(struct usbnet *dev, struct urb *urb);
 void ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo);
 int ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo);

-- 
2.47.3

