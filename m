Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED373E6394;
	Mon, 31 Aug 2026 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170357; cv=none; b=Wtx+NvmTSoeaginHF/uLwo8/K8gtJFHdLK9ALUhN2Ananbn6qHERCSroQP1dX9u2DnV+dy6cnATpqyy/jwuwkjIjwHWYA7d1zp72IIiv8ILtoYzhnicOD91G9jNpYh9foWstmd6Vae5FITBC4BWwbqZlB1Udv04zX79H0vtwzVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170357; c=relaxed/simple;
	bh=1Ofau6VVBRhKQ8ChQEZRogyVJMfmMxBhTM8Z+sQOs2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3Sqcm2rQ+ElMu9vKNapKnfisqbfIzxdQOlVCIOiFk1b8dGjE5SINvyc44SY1TSweOxSOrjUBrCBa+bOSSc/2u4txdSlmNqEznmgpVLDyBxS+rY/wMuZOYOF8oda2jh6cBhlgTPjQJSZGSKI3lOFnmocPKR2GoCGK5ckKeHOAqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=PlCwMKWE; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Ym+0+x+Z; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="PlCwMKWE";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Ym+0+x+Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170353;
	bh=1Ofau6VVBRhKQ8ChQEZRogyVJMfmMxBhTM8Z+sQOs2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PlCwMKWE0EWSXnThmR16Yv4ai2QMU3ytmkpRHOlHefpEFWVYujTT+CACm3ZNejS3A
	 40/klMiyvTwfJRJt2P92OZcPxRrnrCqdBJBw2e+qWxZ+29dVzAywq+zFyzE2kS4vE1
	 tniv+F0B/oKu0TlnhbaIejOohIvr5rQi7xMp3Qna2HU8Vn+jO0PvoISM1r/LB87LBn
	 OpmN8NYiCBY1zWQ8ToQ7wHwfFLIpI5Q6/3Z6E59KXnIDFGDrbGHbjC4jeo8OBCnEG5
	 UTenX/0fkzuCCu2i4jBYAVcjBaoiG+dMF8Xz12zXSgW/FYAeEKYHWX+5c2XTW/S1s2
	 L+fn4KkpE3Ohw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 4DFCA3EC6D; Mon, 31 Aug 2026 09:59:13 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170341;
	bh=1Ofau6VVBRhKQ8ChQEZRogyVJMfmMxBhTM8Z+sQOs2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ym+0+x+ZeVJ8oEAA7mGQ/8kEjBNSoyvlK89tU4S4MiXMm5VejXIGImJKhZiuZps9Z
	 Z+IeY/zYuGhjke0VFRUyPXm5u3ZapPPzSVaqxHb3N3+1Uk7Zv3TBu1veAvYHndc0qj
	 Ugc2uFx5Es/SFjwwCwLEfnsHwyEZ5Rm0NmKSTpXf7YIpNaRvIcyZzXGHKvnhX8bDwg
	 xXSEhT5q8K48Osh9Uq2hasHYgF5+vHXe0j7ETjMXRPrmWcY6ADpchzdov08vkZ1hCQ
	 wQtdMUJgQ43FEKlxW+MTsfmooEExb5yT7UjQ8SVco+xKa3nluv7Std4da7arc0hgSa
	 lYYAvOclXs06A==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 2A32D3EC5D;
	Mon, 31 Aug 2026 09:59:01 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 31 Aug 2026 11:59:01 +0200
Subject: [PATCH net-next v8 12/15] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ax88179a-v8-12-de905f2ee426@birger-koblitz.de>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
In-Reply-To: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
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
index 61eab5e4d9a2955a6493d54c6380297a338d0842..dc101902b9df99fe10d218a99de0e878b17569d4 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -228,6 +228,20 @@ static int ax88179a_resume(struct usb_interface *intf)
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
@@ -317,6 +331,7 @@ static int ax88179a_set_eee(struct net_device *net, struct ethtool_keee *edata)
 }
 
 static const struct ethtool_ops ax88179a_ethtool_ops = {
+	.get_drvinfo            = ax88179a_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,

-- 
2.47.3

