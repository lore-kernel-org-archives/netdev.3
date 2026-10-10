Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CD37AA94;
	Sat, 10 Oct 2026 04:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791608090; cv=none; b=ffheEYpgAmIvK4UU7yQmmBIa8GAoDg+u2tQPzQ2KJYxznPsLAjclXIE9kb82e8YePJOvtiBulxcq0SxImWyizwkewlAVOuIm+Jyi5EeyUG3IrXYqcSdEsG0uBowm5u3aMOzHK96zXPXjCbkvpr6nw19Tf3Qn8rOftHBzGaDznOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791608090; c=relaxed/simple;
	bh=1JQfZA672J6OveCAyEFBpwt3mdwIiAJM1L5TlYtB+GE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7Q2ykI4awKW+COiDHlKzCyfI64DzVFptB8GcnsPtPqzPaR/HJZ4r/gqTP0rHW9dZ9g37fwikCignwKiBldR3EuA20eqExi9pD36wfsHBVZl9ClzppWQfXc9LnjQ4kD9sB6HcTOnuxPiz0zyuxSmXztoAD+z1Tctw8hLStgxp6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=RC7k4noY; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=yfkt02jY; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="RC7k4noY";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="yfkt02jY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791608086;
	bh=1JQfZA672J6OveCAyEFBpwt3mdwIiAJM1L5TlYtB+GE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RC7k4noYZ+SudO+AbiDawnQToaYi/d8kv9kTNbQa7Augf2J2tSrqX/1+xZurwoKqJ
	 JNZ74TvRF28h+6/enRSPbV1F6oCXJpS3BzsNOoZFdFPmeNeB/TlWvgrrWlq91/Y7or
	 MML058Mzac8t8aZIEgG0i7K5Dq8AVsXZdH9LNcJXMZOVFk+7YK7jpqVa4tJRAmBGSt
	 x3OTHITHxHohKnt3bVHblbZnxQFiQUDgR6AK8AZzpcJPaSaHpfVbkTrklxGPe0DhC5
	 dCv9PJA6ENm73/3zLAER15hicpuPP5t2Plcd2oK4nqhzQ87tsP9uqCxXduo5ACJzvr
	 RbKGuVwfzHTGw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 9377F475E6; Sat, 10 Oct 2026 04:54:46 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791608073;
	bh=1JQfZA672J6OveCAyEFBpwt3mdwIiAJM1L5TlYtB+GE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=yfkt02jYV1VEkDHoWhkD2I8XQeFJdKYxAc9L/KIdI3B+VRwlOi9Kp63fbrRbUtq42
	 D9NWDVgvm+SPnvXZh6NBDxUTBXFF4lUudwS4QcEnsUmsPht8dRZpiA2A5K7OK4SjgA
	 JZiIedXBf426lIRKKk3XexQ0XziPw7o3kjU/IAbV85KOU+ohO5zyOFrfK4wZNrJKkw
	 CaCFWwlyKu6TODIY8C+T/FsIz2IVURKcDQaDELZvvdVhaq9pQ3gR91P671eaHV3RVO
	 1hNbjWk1P7DVm13/udTNlHrm3UnwP+1nDURsqRV3WB1+SSuNmIsdSfVYGT3JAAL52o
	 ljt8BrpY+VQyg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C998D47526;
	Sat, 10 Oct 2026 04:54:32 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 10 Oct 2026 06:54:32 +0200
Subject: [PATCH net-next v19 10/13] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-ax88179a-v19-10-7475173cfb56@birger-koblitz.de>
References: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
In-Reply-To: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
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
index 01d6a35f68b2c56f79acbe2875ce8e99ccdfb197..69095110e70435806a99274c50d79e86016ec9a0 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -235,6 +235,20 @@ static int ax88179a_resume(struct usb_interface *intf)
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
@@ -340,6 +354,7 @@ static int ax88179a_set_eee(struct net_device *net, struct ethtool_keee *edata)
 }
 
 static const struct ethtool_ops ax88179a_ethtool_ops = {
+	.get_drvinfo            = ax88179a_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,

-- 
2.47.3

