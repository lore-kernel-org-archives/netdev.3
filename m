Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389243E092;
	Tue, 29 Sep 2026 03:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651973; cv=none; b=WZVbVfHFCfPBb2qVRvmJCvRl72ij0uBG0YbO3f/Xkx+4YE7QkBR7VK2gQ2ZID9oLU10mAoZjzAETEg0Stqw5uOd8L1DzT1ypby0LJEr0yip5BGdGdg+K/as7vak+KNu6XLmurpggn/dWDiHtBNM7q+mQKm4LLiOkpgxox9tADIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651973; c=relaxed/simple;
	bh=DSnWQE7w5FHRTPoFKEEPlTEVr028IIf8Lm3EMd/13Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QsDbkixt4YEzQ5YIs/tXm/FCVxhQezac7boOCSTFi3dzVtIsd8QOfI/WHT1O+O6DytuJRc+MCJbdTVj5qthEgdDIhRs4JhIjluF4T0tz4k/SBtZKbyBCp6Z8FmdimVbu9vTm3yHH+mpyeT5zEAi+FfFhfbRKbzv/d/eaM4NdFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=EfRAhlpT; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=fVe49yjz; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="EfRAhlpT";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="fVe49yjz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790651962;
	bh=DSnWQE7w5FHRTPoFKEEPlTEVr028IIf8Lm3EMd/13Mc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EfRAhlpTqlEC30VFQHRieyoErE/ib1eXrDHw0wqNTV9ZBlkBNngISC4/7jBO5nDG1
	 6ILBbjpnqwvnG/zk0chhzU4ycIXM/MdJD4wJCSlPovi8xBqxURflIMHTI++opcEmn9
	 lZSTaBnbvqqVCIwPxhtG76I5NfQG6UCSG0aefEMusDjLg4xo9MNPasJ88zUf3Wxdww
	 UMzA+pjfkB7Uyd1MCJcIwJvGmkM41wxKYSPYqamYDQy7xKE6gv8bpmH9txbfkui8Dm
	 yFD7uUXAz9gCi9mqvhZjxEB65vKjYxvdcG4vYJjSm42uBdvr+rLbUyMknROxIY/l02
	 DiMbzV5PTle1w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 0D32A4228E; Tue, 29 Sep 2026 03:19:22 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790651940;
	bh=DSnWQE7w5FHRTPoFKEEPlTEVr028IIf8Lm3EMd/13Mc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fVe49yjzx/kW/7J9MdIoSqyaOJBEv8+dok72EnbS6UngNElvHgk6IMqa+yNC6qvih
	 bkC3/BCeIzMQUFyU0Tu+JrWiPySfF4wKrB2TembnL/q34DtLC4Gt4jUdizN6REU7yD
	 P77TTeXQ257cj3usnQvLaqoKgIWt83VvguiMEiZWXM7aSAREIoRvEQwIAl1xU7RTp4
	 RQgWIorJmjhsu2erwTnSlz8NwlodRdkfTr3G3DIbDVB9lYs+rPfq0rr1EZKaRWMljr
	 /LLBJISjol/GYN+cy2IDzpdHyZXsgOsN5shyG4m3Av4yuUL0llKzNJqJy9GRGuUqsD
	 7p9U+kPB4F8Zg==
Received: from AMDDesktop.lan (p5dd1eaf2.dip0.t-ipconnect.de [93.209.234.242])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id B190D42269;
	Tue, 29 Sep 2026 03:19:00 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 29 Sep 2026 05:18:59 +0200
Subject: [PATCH net-next v14 11/14] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-ax88179a-v14-11-a1f2249e42ea@birger-koblitz.de>
References: <20260929-ax88179a-v14-0-a1f2249e42ea@birger-koblitz.de>
In-Reply-To: <20260929-ax88179a-v14-0-a1f2249e42ea@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Birger Koblitz <mail@birger-koblitz.de>, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2

Add ax88179a_get_drvinfo() as implementation of get_drvinfo, in order
to provide information about the device firmware.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/usb/ax88179a_devices.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index baf91ebee9e35a855b1aa902ba099169277330a7..16b441feaf08f739a5991cb2b7ec8304ec80ec5a 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -234,6 +234,20 @@ static int ax88179a_resume(struct usb_interface *intf)
 	return usbnet_resume(intf);
 }
 
+static void ax88179a_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *info)
+{
+	struct ax88179_data *priv = netdev2data(net);
+
+	/* Inherit standard device info */
+	usbnet_get_drvinfo(net, info);
+	if (priv->chip_version < AX_VERSION_AX88179A)
+		return;
+
+	snprintf(info->fw_version, sizeof(info->fw_version), "%d.%d.%d.%d",
+		 priv->fw_version[0], priv->fw_version[1],
+		 priv->fw_version[2], priv->fw_version[3]);
+}
+
 static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts, u8 speed, bool full_duplex)
 {
 	struct ax88179_data *ax179_data = dev->driver_priv;
@@ -339,6 +353,7 @@ static int ax88179a_set_eee(struct net_device *net, struct ethtool_keee *edata)
 }
 
 static const struct ethtool_ops ax88179a_ethtool_ops = {
+	.get_drvinfo            = ax88179a_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,

-- 
2.47.3

