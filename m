Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD33EC81C;
	Mon, 10 Aug 2026 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365255; cv=none; b=p6SYNX2tI90KBmrS57H/2fYJUMAesut4MdFyX5Yz7jMPJvrN++wsBAvWdQv9gUtX1LKOeQfE28g6vD2V88OJS0A4KRdHYkf2k3CoW1hZe6GubzqyjZ7+rlEMCUaLMz9M2gP9aqxr/Eol4PHHRZSW4P/BWL7MbL4eJZiZ207mNRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365255; c=relaxed/simple;
	bh=dOKM8/Y4i7J64IGMeRUEntMUGSGOIEO671WfB+QlScc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XNB5IGGYfpRJXscedYFHFPfkNDFE4kZNCOWwrLcEJw0x2e6WfKqY7s0vp5O5s/ye3h7KunpF/BpVHoShlvreP3pxkXh2Z/Ju5UEzr4Rg2Z2605/zZTeiMJhxpzsvN7xAv5V7q3YzbfE6vcfYXAe0QMS/YxBjgmqjpvjThe2fwK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=x437vfaO; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=1oPspNNY; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="x437vfaO";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="1oPspNNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365250;
	bh=dOKM8/Y4i7J64IGMeRUEntMUGSGOIEO671WfB+QlScc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=x437vfaOHcRHO9bWs/MM5xDbS1qgL4iq6LjAlaN+zIM5eiGPtpgCPDkvKzby6qZXi
	 ykoTBla6c3bhglYQ8W6UUnO4H6MMqUMQAPULKPE3Vs87qmoyPUia6pwAcmPBW/Z4Cy
	 XYIYelzTaCqRt4jfLIslaHTCP9gfdQNWEHlQEc5B2B1dza0EsgaFT8M2OlywoqkGZL
	 AYS9KH0FOezJWp7JXzz+IgpmtX9EHZjayzN+1h+0Clb504wbdZTExvrrbxxsAmvpie
	 UXrpaRg9qfFWcEs6LnU1ZAaX6fzgkQPLJxQ9Hvf96uBSR0MaZdHfP+Q7AcSAyYwB8U
	 NGZu2yizaFx9Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 983DC49770; Mon, 10 Aug 2026 12:34:10 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365219;
	bh=dOKM8/Y4i7J64IGMeRUEntMUGSGOIEO671WfB+QlScc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=1oPspNNYNFskAa0P7FoxVY8sxEiDJGs81mMhk2XvBEGHVq5tFF1jeHwl8d+SE/O+M
	 fktsyBCfpCHuz3LUgqK+iO5YS/wUqnl6hvCZuqEbK0zRSvEtFwp5jQPQxwatbu0cx8
	 HzGUQEtAuenph89tiAn3amL9t3gRpUdDmsKeuqvzhiddP1EAhxsYr2OWSI/4FgULh0
	 HHxWrkrcc246g8HkqjZ2i9gMCIRe5gWXyGIhvNJP7g9JNuuahmsDfyi9eIPETj8xcT
	 7lee5crp1L1ceuxD0v8U6lc9CzH5D7qynem4xag50auyw/x8T3/XcZGeH+3FDBmZEw
	 xu4xYoH0Xsrsg==
Received: from DebianDesktop.lan (p200300c69f06340062b039dfa3272a8e.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:62b0:39df:a327:2a8e])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 6610549778;
	Mon, 10 Aug 2026 12:33:39 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 10 Aug 2026 14:33:36 +0200
Subject: [PATCH net-next v7 11/14] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-ax88179a-v7-11-da633191c129@birger-koblitz.de>
References: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
In-Reply-To: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
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
index 2acfc8906c9d0abbab18966d904f6b812a96e584..6b57111a0e05add3fecc6b8ef9078ecf8c301276 100644
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

