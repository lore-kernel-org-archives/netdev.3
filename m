Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031544E038;
	Fri, 31 Jul 2026 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514773; cv=none; b=lOmYT0IxxlsbXkOnfk97qVGXRRAcvKDliKSqq8IpUX9/zDwib3A/dc9wutvY9bvmXQ+voQlwk8A3uumfQgDEjN/M2cwi2v5mWIqHt9uQ6EHDxuq1TRrRVn5SDd4bG4gARLd1uLifZdfLIUc+TP273fOLEl4rbmbUphr3q5khtFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514773; c=relaxed/simple;
	bh=fXRHUdjfAua1nrEYCsRaLrF7OYw453wcv12/L8FXInE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SwdaOAjhQcwGU/571vSqrjgcWqGt98DnDIIoOjFG2+K2YN4Zh7S6ekih4WdgXR9jD2KUH5Mewmcy/Oe2r7mI/mKHZRxWRK32pzHUvu9R1/baW8BzGEIU0KTffuXuMUWw30b2mkxCGBXtrJ4puMFmPQfGmt867VfHaPOMp64HaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=j0M3So5T; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=tn34jHxG; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="j0M3So5T";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="tn34jHxG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514755;
	bh=fXRHUdjfAua1nrEYCsRaLrF7OYw453wcv12/L8FXInE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j0M3So5TJeq+9jHriGRJVkLc3Logu4ZcNT/0icoWQPk03RlTYT+sxjuoJwgFEu4aN
	 AG/5PZSVTHCCZOXYN7PUqq1F4QxsAFEygZOGZvUcmAD+/KJphCtLxspURjWko01PTS
	 hZvJ7KZWuUvTuOEnEodsXZNnoz3VM+JwE5tTh4c23tnb/w6M9Pzlh3UlALpTGtGUGC
	 GncfQe5V7/2ggguUYafQ5dc4LeQLsTvCOCM1f8s2bQbnOXoMWAcwdw+j5DYKhbu/vC
	 l6fRg0q5byhH7h/57eX3P7SsgLIDs9he0uqvIrNcFC/BB1bBdBURMxhM1TBN9grrGU
	 qa5kQq2EGpKYg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id DFB4149501; Fri, 31 Jul 2026 16:19:15 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514745;
	bh=fXRHUdjfAua1nrEYCsRaLrF7OYw453wcv12/L8FXInE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tn34jHxGnFTDf76hU5R+I5d7brWhXOsLZ4TdbTX/s+nc55HDB64AkQ0xMgXDEujLR
	 d5l7rfwRHHimkYjMoS8qJsUOLKbLEOwRdaIS8ghbGq2Uz5dDnZmIrgUubV27uaw69z
	 aN1JC7Ihq8Tgj7bo9kz0BI0og57omyyNX9NmjocomIuf6kaY+cSPyDLxIj7nik0PJd
	 zgfLTRlxDyl7LD/9YqiizB+NPzkbKSbh3G1Dp6uol8UtUZ6r+hpXXRXafehVLAXuGr
	 XvDxlZOX+oe0QX2agEcyteSaJpPCpfZiyWg9B7uGcYtcszBBkVcUX1XLsQ6WqO1YYk
	 cOUspiHfFTAww==
Received: from ThinkPadAMD.lan (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 05672494F1;
	Fri, 31 Jul 2026 16:19:04 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 31 Jul 2026 18:19:07 +0200
Subject: [PATCH net-next v4 07/12] ax88179_178a: Add AX179A/AX279 multicast
 configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ax88179a-v4-7-2cf1f71b1dd2@birger-koblitz.de>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
In-Reply-To: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
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
---
 drivers/net/usb/ax88179_lib.c      | 8 ++++++--
 drivers/net/usb/ax88179a_devices.c | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
index 26c874b31beafac796264e46ecc942b4bd460ac0..e3f01a9654f8399158aa67b688ee76dd93997939 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -307,10 +307,14 @@ int ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
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
index b6c24a11660fcc17957452a86e66dbda3b71f2ec..9667cdbda9fa5e8da5eddc610f902b7c9bb66cfc 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -623,6 +623,7 @@ static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= usbnet_mii_ioctl,
+	.ndo_set_rx_mode	= ax88179_set_multicast,
 	.ndo_set_features	= ax88179a_set_features,
 	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,

-- 
2.47.3

