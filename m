Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B863F54B7;
	Sun,  4 Oct 2026 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791092377; cv=none; b=O8HlyUfEjU5lztkQ2F34nmUJGMscDXU4go30jf4x6NwZnSxe4O72zXbuH40RZuFqhv3lHdyfOyHWv2BwTZWDwZnw3cg7sbkTcXT+t0+wVpQJ9x5FxbBAC4ym2jheGwnmCxliCOqITowyc+ZnyddtfJcTpRWzJtMLfUMrEi1+XG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791092377; c=relaxed/simple;
	bh=EUoJV6aGllFm0Nv0ifVDs6BxxIgFh7Eus1fd8fjQ88Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJJZsWK1hyl7neFha49WxSRk/uo6bucb0LBwDFlyYWN/rIVdjVs3d4XlC/JmY59XznedceuqToI0dOedbXmjtgF1Yob2D+5JXoWv21NapEpD6z7RgoXr8OPuYHIPxQ40WlVWK3nyfgkkHc3oWZAvxed2iBXMGmpE98lmZzJHe3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=bNPhkCN4; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=rIJdNxVG; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="bNPhkCN4";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="rIJdNxVG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791092365;
	bh=EUoJV6aGllFm0Nv0ifVDs6BxxIgFh7Eus1fd8fjQ88Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bNPhkCN4d1FzJARmZ204OVFDBDqMoK005QilDNJZSWE3eP7xmNEfOltc+g5FQ4ZlE
	 PticTA5/xHgAYNHl7O4M9AojDwaD64//PLKASw0/59m8JlK1JUM46xtyzKcy2qPmAT
	 TrqtgnmBxepOlap219aX8xqO8HT2FjPqdBV7pubSvO9RxxAj+SrE9gospj3gsLPe/i
	 OsPOrqOM7zH+/dt3Fbm6Bb5/hWbbDdAZBDI5aw+Pk1fZd8Mz50GwHO7mXq2XaEso5R
	 aBNebo0WyTZHkd2z9D6qm0VTTzWE4E/+Pv0thp+wcOtwiGzh+NBTzZy/2jCQwOHbOK
	 iE0OFVioRhIqw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 52DCF4833E; Sun,  4 Oct 2026 05:39:25 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791092348;
	bh=EUoJV6aGllFm0Nv0ifVDs6BxxIgFh7Eus1fd8fjQ88Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rIJdNxVGdqBhKVKSWXrAhLtUWiZ8psPkXdS6L28RCIG92yjeX3sS/zk3jsDAs0u+Z
	 byA5X/SH4CWKBZJ/4pMNopMkfYkisg0apYCsEsb+Jw84d9s4LxDMZaq6WpzTEKAH4/
	 1AsEv1exMWM9h+FrmTjP2MVeMqYlP1hanNcqWFZYLcaq/NDNksOdJdsYoG5mOaLCmV
	 keq8S2ieEoz1g2KrpQI8AZUq+Pvw+SsSB4LLAfxxZA93L5r+nFjKdN40CPCL+0I/eU
	 4s/FAMUQSn2O4XpSssrOqjK15eT/kPBZXzP8YwaSufRhemJOlL1mozg8Z+LtUpIMaM
	 g1yF3Wauis6Hw==
Received: from AMDDesktop.lan (p5dd1ef42.dip0.t-ipconnect.de [93.209.239.66])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id BC5F64834C;
	Sun,  4 Oct 2026 05:39:08 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 04 Oct 2026 07:39:14 +0200
Subject: [PATCH net-next v16 10/13] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-ax88179a-v16-10-2a9ae4e68f7b@birger-koblitz.de>
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
index 28612a1beb1a15465ee131546870664767ed20fb..f2140e2bb443123962d32a4790932e990607a0c6 100644
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

