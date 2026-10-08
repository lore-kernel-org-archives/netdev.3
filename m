Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52323C3F73;
	Thu,  8 Oct 2026 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431495; cv=none; b=Ol29BS5kuQRiE0kd8NoGmVTP5AopD3eyisI+U2fYGgybzCPRjDmdqDG2oMFjKe+YxqBHDvlNu9KXOvrNtvPaVEIDNFYFc/2GaYT4a1NzakvK7W8xHOFxXXSK/RTR6nKlGWOlFLK+GX5WvVeSFlX5IwDIJsD5BMdj39rZChdjEr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431495; c=relaxed/simple;
	bh=75+Qk3xqFqT8LEzTBVWxvqO16VwVZ0tK22I4tlMGSH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R3P2RIU208nohaI9dvT/Hk96ChsRgXX9jW2XE4Mw9nc/1N+av0RenLGgoE3O69csB5MpyP3gw3OPc4BaAoCP2MKUFxsNcSV4KcKT7fSOF8moLC3OWcy9S7aTVyJuhKhO2F7eLfVzyJ9pZPGFxaKHSKlHIqb8VaB9Umu9PtW8I2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=iI1URVKM; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=1+3nMFY0; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="iI1URVKM";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="1+3nMFY0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791431492;
	bh=75+Qk3xqFqT8LEzTBVWxvqO16VwVZ0tK22I4tlMGSH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iI1URVKMZhhf1RbOcaEO3JeTrYSfkuJputgR/5EjJYDWbrAsarpy0tftKQI5JZtSz
	 RqDlOmFKZOgZXrnB46WznhA9Kvgwrm2/RNoCBReZX7R0SjcCoL/04VPqHkBNLGM3ZD
	 +hLL7CGw2aZN9m2glwSeaPvtaUKtwUPk/ju7hNSUc4+tzyXBfRnAgP0/POUYOXgwZz
	 nAwBWdgMKgbPw913O+YbiB/YrGQVamI9WJTbx8X7VLqHcv8anyH0VmR8AgUMFDI+Yb
	 p3kvA5umn3lQARVdaAMpkg93lEAjjHtQP9N+TcthGFkVVVsbMONlKgH+THHxbKKIk1
	 F83khpBaNYYrg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 1A001470CF; Thu,  8 Oct 2026 03:51:32 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791431479;
	bh=75+Qk3xqFqT8LEzTBVWxvqO16VwVZ0tK22I4tlMGSH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=1+3nMFY0Q4xm+66PGiZsLAup/wGFpKHXW+xfMzKEtwddz5dlNEXBszAtV5mQ75mTV
	 AA3g/hKA67z3Tytz1VNxOB0f0AJTPtA85Ye4dnYjsg7m9jzldMGQnw474n/ONmK5nV
	 og30LI7mKxHdikBVPh4H2gV/K/ITFBw862V2n7GCoiZtSG8RO8b0gJVnxWha+UNUA9
	 sxJHlWtKA9P1iUzv97k3hLZQ9u+11hhUtkvrOiBAwxG22XmQo/0rcKGJ7CXpky1Nm3
	 sZWX3QY7RWZdRMfAGeU9ZdRnrVs+S1Ym3+zcYIr19c0HCUBAjhxRw1JdZsEHsLLyfj
	 yA6xeE9C6GpBw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 730DF470D0;
	Thu,  8 Oct 2026 03:51:19 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Thu, 08 Oct 2026 05:51:16 +0200
Subject: [PATCH net-next v18 10/13] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-ax88179a-v18-10-6fa1d4c40422@birger-koblitz.de>
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
index e9913a7c703905c9422405c8158bf068f1d94083..4ba2b85a5ce6f95dfb182c67667e0565d02877b4 100644
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

