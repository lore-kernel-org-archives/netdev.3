Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142851477F;
	Fri,  4 Sep 2026 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542940; cv=none; b=BfJTe6RI5d3WdK8UEQu3+sf4ueGLKjUCVQnVEljrMduttm3+ip6eYgWF24w8IdkhHiIzXK7J01LCDbDIwNSYbxxJZmksEs46P8bEUO3t7N0Q+6Zbf+QlRr+vBr/DMKK+CNQAXZygv8rg7HloM8f/Z5nqUYxvLHM4Ra/NCpPInoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542940; c=relaxed/simple;
	bh=wlSi2rFq7KWkS6PXtXc1Ccq8ddUuIZEu3t4EjSi1EdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GHYGAFwVby0yS+cDs66rYmD3ptBhdhc6/BK6jOXKVrP/0c24gH0JCy7fxT9j6ozQgmCkTjFH/Kz2ryFPsWSHfU5tia0rhx52A8+MlUFCn9/I2UIVa9rW1sRWcmfXi4ZOKJlcLAtC9F0zSqZEnAJ06zdctPVj5OQGaSoI8RZY29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=I5H6A6Y5; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=BrpK7jQQ; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="I5H6A6Y5";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="BrpK7jQQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542927;
	bh=wlSi2rFq7KWkS6PXtXc1Ccq8ddUuIZEu3t4EjSi1EdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I5H6A6Y5u9ZounPXdh/y2lwKlzifIJRA1eO8kgNy0QC3pwkv2hFzdxDKwfC45T+45
	 WUY3EMNl9W/RFF2m3Z0L/wrM+cIpo0FiX9DORhymGD0g0Zsn4vJteOsP/Z/U5g2abX
	 TVzH2nXpLrLLGAF+vxwy7jVJCCvuzUfZyJIn3q0o6/2I7u1J26yzr+3Vfh675M+vP0
	 8kU9PUiifLQtWL0egDt/dM2Ekuh/E7x1c9CsNxOl7cFboRTcTaAY6DwXyFs6bphboL
	 ZQyoPu1j+qygpXjeksLF66aVukJhXxWj/niPl/x1kS3h6SucWM4jCikFZV1hn0Ozmo
	 ytFlikJr8IYyA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 6AFD13F0FB; Fri,  4 Sep 2026 17:28:47 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788542917;
	bh=wlSi2rFq7KWkS6PXtXc1Ccq8ddUuIZEu3t4EjSi1EdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BrpK7jQQj47pYOaLjKcingpyJvthSVX1toF6qV2iQIsgmbS0Q8dvLxlyZUClCsBSZ
	 uduWkHdrCfM6JcDTRIG/jYRZkRTeeHOk1yqM4WLpOiIsUIXS5IRAJwS2Jy4ednG/eK
	 7IyxVLoJlsaeOLD0QBntpbSRrh+mVBerY9uUMLRzNt4vQdo5q3OKCkCTfMVJPAZsyl
	 aA6u7+ngVTkF1NNusvzlFaaiINrx51WkGVCIVhJsX62cldTmuRefk1f0nSHnligxyF
	 xEWtibiGEGaY2gUiJSG96oocqFpzpF/1j9uVYHAt6harFXy+ai7usuPyuDbK4LAi50
	 1hqybTRrvuBcA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id A54853F0EB;
	Fri,  4 Sep 2026 17:28:36 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 04 Sep 2026 19:28:35 +0200
Subject: [PATCH net-next v10 10/15] ax88179_178a: Add AX179A/AX279
 multicast configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ax88179a-v10-10-b5e60eca7690@birger-koblitz.de>
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

Add support for conditionally setting the ip_alignement flag
AX_RX_CTL_IPE in AX_RX_CTL and make sure that AX_RX_CTL_DROPCRCERR
is also set to be consistent with the initial configuration in
ax88179_reset()

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179_lib.c      | 8 ++++++--
 drivers/net/usb/ax88179a_devices.c | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
index 3324069e90fc352048817963f27a49ed3872b348..708b0b23f1363daf90f329a3e6b6a2721d110387 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -305,10 +305,14 @@ int ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
 void ax88179_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *data = dev->driver_priv;
 	u8 *m_filter = ((u8 *)dev->data);
+	struct ax88179_data *data;
+
+	data = dev->driver_priv;
 
-	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_IPE);
+	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_DROPCRCERR);
+	if (data->ip_align)
+		data->rxctl |= AX_RX_CTL_IPE;
 
 	if (net->flags & IFF_PROMISC) {
 		data->rxctl |= AX_RX_CTL_PRO;
diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 12885a4936223def82e4b85951a566cbb64d2193..e3dc244f79e538c55d64c747e1bb65b7d873247f 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -608,6 +608,7 @@ static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= usbnet_mii_ioctl,
+	.ndo_set_rx_mode	= ax88179_set_multicast,
 	.ndo_set_features	= ax88179a_set_features,
 	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,

-- 
2.47.3

