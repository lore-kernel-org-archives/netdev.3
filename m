Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9EA517BAC;
	Fri,  4 Sep 2026 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542941; cv=none; b=QVXAGTycRBODDw5vO3DqJM1WlmhRidOcfICEybKqvcebwt801X7f60jIOM58wkEDXd/8GtM1K3qqjNw1rL2se7Xr+2x7IT5slV4bRIaBr2EaZXsJ6RCufltG/1geFNC+mPkdqXcLM+B+hksE5kWJqjfZhSLomB/ELDuAUmtzl/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542941; c=relaxed/simple;
	bh=fGL13KUMxMV78pruvdzOA5fjuCZo0brCIMFql7x7Qko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k+eNGkYkt23/cW0gkNHRh2NK7XxiG/8W79HdXosRddbneKf++vMn8tqtLAR66FK/D9UbtZfQ2XhfIc7k2nDlnINo/w8r17OL9vK2uuC1X5BccBOz3Qhh7FzfwA3kZJYUZzPzAAXQzt69n5+7fY4NPYCjaugWyI86eq8RstKhlig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=I2NEiI2p; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=CbZu00d4; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="I2NEiI2p";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="CbZu00d4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542929;
	bh=fGL13KUMxMV78pruvdzOA5fjuCZo0brCIMFql7x7Qko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I2NEiI2p1vkad9FZAuQuMmDB+SZqh5cxOYsYDjnIM8EQlJFbM+I114BM1fWp8yBgl
	 uo/9Ixcc7I+8SyDG9tVhwOYuW31iOa0PFblBV83uPXWZ50OByTDWoel3ZvdNlwgLkz
	 x387RQ+CiqIFXrtBumkjVEwBmUaF0kErX5ufbyJLyvzV8shMai/NRhYUug0MOogsS3
	 k5p+aPawVocRoa5Q7JzFByB9fq2+3CCU+Xohml7JTCx2PhFr6SJfhLC5LzhmVPI5fa
	 ZRwXgneK4jd/G2rlAY722SCfVfmpbh2KERA6gbG4n1fQS6dL0wLS6FD3Z1DuugVWs8
	 YGMK4R5lWRP8A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 14CDA3F101; Fri,  4 Sep 2026 17:28:49 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542917;
	bh=fGL13KUMxMV78pruvdzOA5fjuCZo0brCIMFql7x7Qko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CbZu00d4ggTTXaoLvm32vmJUvWYE3Hjc2RWb6vfaaVR0nRWoPAKaZjoCvwtJH/njy
	 62m2HCsFkQt+1265ETxNOSJwgMiKgU0UkvnEFaY45aifz5XPS7ZohbEnB29fTh7uul
	 N1oEyGWoObvCozkExLoeM3RgrEbjGgAUhSH9kRdI2CTJ3Vz/x7zJtm99e7r97GXgP1
	 6k/CnFWwQCcyq9BQYleFcz16P0yfp8bvRt3vw2PyUjX+GE78YlXmub2dEKCsaHsKAe
	 N5wdYN4IKauW+s4R1pAUzfRQXXQKFAAxh5pM+KZF2nyJwXc+C9hFhLQDGOiYvrZQzh
	 zPVyAOg3I4zDw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 704E03F0E0;
	Fri,  4 Sep 2026 17:28:37 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 04 Sep 2026 19:28:37 +0200
Subject: [PATCH net-next v10 12/15] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ax88179a-v10-12-b5e60eca7690@birger-koblitz.de>
References: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
In-Reply-To: <20260904-ax88179a-v10-0-b5e60eca7690@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

Add ax88179a_get_drvinfo() as implementation of get_drvinfo, in order
to provide information about the device firmware.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179a_devices.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 1a74831a82b4764527c7f1d343d3cf7ad7399ff6..1e04390f0f75721adb1abc5d92dd5466c700d61b 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -218,6 +218,20 @@ static int ax88179a_resume(struct usb_interface *intf)
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
@@ -307,6 +321,7 @@ static int ax88179a_set_eee(struct net_device *net, struct ethtool_keee *edata)
 }
 
 static const struct ethtool_ops ax88179a_ethtool_ops = {
+	.get_drvinfo            = ax88179a_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,

-- 
2.47.3

