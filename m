Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F8532C942;
	Tue,  6 Oct 2026 03:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255935; cv=none; b=gmI/EesoHGdbYubOg9YCaj4I+Sxt3lp9wSYrwcX0QUSaMdT0wnKimBljeg+zeJb8y1tUvpIVWtkk1GkJ8xbJOy+8V+RtOzrRtA1gWxBzdZM4lL7Zp+qEtrkOTHplSvUsX1mXn/F98pYKkBkaakbHdkuT7t/YkAhlb7wEVsr5HoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255935; c=relaxed/simple;
	bh=vpipJ6woiEO7rxtSTKIhAV98Xzs+OvVnK/G1yvFpKkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YtFwkZEoOV2HWpT/L0VLeXg5KhbGOFa6F8WIhvKEWF3FcE25v9YFgwX7QmLUfxtYTVKfYXV+65mhY7X7ba/ZY+PR0uYMQDw0efZmHKyM9+/xE3Uh/TvY1gBfX0hE5SsX8Pxn7T9FaV4at4FLhsJYvtOtLq8MwKdPNwHHUS3+dVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=soNZ25SG; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=0tzZoxNY; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="soNZ25SG";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="0tzZoxNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791255930;
	bh=vpipJ6woiEO7rxtSTKIhAV98Xzs+OvVnK/G1yvFpKkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=soNZ25SGjFGMyGJJHWrxzm3jnCo5JRfIr/bYumO/IbQ/PyeREfetReM+l6v1rMBrl
	 q7eCntWPlOeV2/FG0aKYsdCSh355Y20ie4wTgWXUgPH+g7G6F//53DWikh72HyRjgL
	 PsbxUhkV1VGYGq+7gu6zelskugy5Tmqn0yKW4hWUAwJxdTcDitHyGpskAaf7xKuw2d
	 VSI4IxXqVKKsXUU9iKcJ0c7w3mdw4CPNJOXSc9FoGSk+b6aN2KwiC9fUXR4gcV7Yvm
	 4yA6RMKRWJM3cw9wA08TypOiqpin70MHMCd6a4Etsamw0PDaKkZ7fuqi0QNH7POW3l
	 +uxKrjg50pt7Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 930E5485F4; Tue,  6 Oct 2026 03:05:30 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791255915;
	bh=vpipJ6woiEO7rxtSTKIhAV98Xzs+OvVnK/G1yvFpKkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0tzZoxNYqzgq9mtB2B63NicW8CUnbSw5AQhRpgE/V9kdLtRGcRdO3aYlHv8HnvKOQ
	 SvAASOJyB0dmTb/wQYIfonnSqYkDQ/7p6aVyO1O6AK7Nlyq6gfYbEO0Oq2siF/+f5A
	 vQj3M1eJIkZIqnWPg5f8Phulf4rUkcO5Ws+JsgQkVcOKKjzF8SY4guNMNV1R3NN41O
	 yKSuRZo5AkgSdW6ia+Dqmtab8aF6PVzhljP08AIq167gCiLJVgtzMrgx9ztspcGs47
	 EBHAgO5LIM9hl4FMq/fYhEsBnAliPC0VKexD1AgD1VcAVM92FN90ctpgDityrL0WD+
	 PBUgroLzUPj7A==
Received: from AMDDesktop.lan (p4fd5971b.dip0.t-ipconnect.de [79.213.151.27])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 4160F485A8;
	Tue,  6 Oct 2026 03:05:15 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 06 Oct 2026 05:05:16 +0200
Subject: [PATCH net-next v17 10/13] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-ax88179a-v17-10-252814fe35ea@birger-koblitz.de>
References: <20261006-ax88179a-v17-0-252814fe35ea@birger-koblitz.de>
In-Reply-To: <20261006-ax88179a-v17-0-252814fe35ea@birger-koblitz.de>
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
index aa5f2d6e42e76bfa07d14330d96fb302360fd23d..929fa51280e843393f7a340561985579712be28f 100644
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

