Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BD23C0A0B;
	Thu,  8 Oct 2026 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431493; cv=none; b=KFO+lc936o8jJrAnC4S/LO9gqLN66M++yDZnDNvhfqiRoFg3ntbWBTk6UxqHwyq4XsqWbTh+T9lneaTTRHr6unqGXt4usLhhtxYqHlCsM87A++YAE6kwU3gPFOugunPiHRjHSlrW08h1x9bFJJeCMko4Ul39w+3riEc9APSV0Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431493; c=relaxed/simple;
	bh=pRuGlSrVHBYdsO1UnsRtb9s1Jv7DtuQKirqcCXuKLaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EDKM7yx2ib/DO8sp1+Ro9iCVNkw6iii5PagFU9ZzVBp7eBcURtXxR2ZTYst+c0J6M3muCDwveRGP9AVSo5YNf2R6TKI/iPV76lLH6nPYqCYQk32XzWdVPkr56guwxVIxiPg3OsJ2IUEaYrTT4Y4NmtvGjO4a+0x2VG5dpF1ezqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=DnwXCZdc; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=N1mX+Rui; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="DnwXCZdc";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="N1mX+Rui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791431490;
	bh=pRuGlSrVHBYdsO1UnsRtb9s1Jv7DtuQKirqcCXuKLaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DnwXCZdcL4i876CuyI/7X9XglYYDqpExB2FOPbR2fBS0SxGljuTPIejOcgg+g7NaI
	 naFv+lRlOnErqPP7SDqWS0s9u5hVlbO6+t8vunmGMbh7vXn7JQ/acE5WAQ6DZ+7b2A
	 2fMWh5cVlWCj9gY4bdgvPdVY2zki0GW2lhCttow7us8zRQ8ufe+Boz+5UJWtqHnOlT
	 TdpwCFZnAsd7xk4CAqQ6/jGuwtGc+mYTT13AGZg2SVmH62VSFnZyBzpg5STay8b1Su
	 0vLwWgJRCP2j2tfk/62ZjyaLyfnJiJrwWfy/tf/6q2cncPBKAiXRdhlJxbVLFTjB+4
	 Ioq0Jb57t5A6w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 0FAAB47215; Thu,  8 Oct 2026 03:51:30 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791431478;
	bh=pRuGlSrVHBYdsO1UnsRtb9s1Jv7DtuQKirqcCXuKLaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N1mX+RuiEadsEDzvxZ9npc59e070ohWTz0rsflPLo3GBhaNqCpYplyypks4SAg+nf
	 fJexeJt5fAnCBJqGb7jXF5cOJKe+qiUPlEXqggClym7BBrH6M7qFPjotAWMe8F8UuL
	 CvC9Sy6wyo8RN2/vsqfRaB+LmfzQCGjisxQeE4pbSdZN1NMl44fml427abjEfbyo4x
	 hzVbN5DLFuIHeIrDW+1Gqiwupm8vEos42tQkloYhi+E9Kd1xwnCb/yDjhf6i29+fLm
	 ga/MOupAlj7v5D4VU6SRXA6Vgy4C/0XgmRrP/N351OEQTX6t1fo4lyKA0rnoHobcjt
	 U7s4oc1yMJRgA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 636E3470BF;
	Thu,  8 Oct 2026 03:51:18 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Thu, 08 Oct 2026 05:51:14 +0200
Subject: [PATCH net-next v18 08/13] ax88179_178a: Add AX179A/AX279
 multicast configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-ax88179a-v18-8-6fa1d4c40422@birger-koblitz.de>
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
 Birger Koblitz <mail@birger-koblitz.de>
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
index 0efc2eb95e4b319fe8b39c23f4b4d8e14d5e9bce..ea19700c8230f7b51bd1f6edf44133c31b7298a1 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -321,10 +321,14 @@ int ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
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
index bdc67cbc17287e2969b36430c672887ee63d18ec..e86cbe3e4400fa2c8e1a6a864fc8e1d328f13724 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -672,6 +672,7 @@ static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= ax88179a_mii_ioctl,
+	.ndo_set_rx_mode	= ax88179_set_multicast,
 	.ndo_set_features	= ax88179a_set_features,
 	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,

-- 
2.47.3

