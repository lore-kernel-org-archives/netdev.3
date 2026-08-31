Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7E3E276D;
	Mon, 31 Aug 2026 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170354; cv=none; b=vFh84Hu1PT/b1HAbMZsPCMLS3toynz6y5ZEJaSH2KYCRiYCJ2u9CxXVa2xGNsId1NRm7m57vXbQdttyb50f/Czeb4jn8D2Lxp7w4xDL2NateI7hcmVH8ccmVOYEdY3ILzYJk88qAXyqGcPhm9bDwCTTVY0fkjOHL4+94Lkuws5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170354; c=relaxed/simple;
	bh=E0MXpjFH7mYjcbni6iXg4UXw//WxDXgZGz917IzAjLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DIcQQ2mOD2UxjjComrX3HO4nwekAr8raNL7jMTOuhEzFDFB7wt6RICR5IYOHlz8sBXTwpJRRGI9i8T0fqL4/IDSurnOJ1HWRc0ERulA00D7v0VC4AnXBONRrn1kRR1pj5fuoah6f5HTLEEinwAa/xicD+7TdrGHWNmKd9WQDZp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=RjNZF8RK; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=rV5+nFBB; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="RjNZF8RK";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="rV5+nFBB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170351;
	bh=E0MXpjFH7mYjcbni6iXg4UXw//WxDXgZGz917IzAjLk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RjNZF8RK8XLpDw0rPmP/+XX0VMb5LwQ7J8obmJ+e4HipbpEdHDqvgQ5qn2HqNI9HC
	 wAiGQYVl2ya6gsIzeeQK6C9EkpISPVOnJ9xekualyKqL4ze/kMegG4gcaQWYeJH9uh
	 +aSpu/cBVUXR936FwyeQDIehOU1aTzIau071SBKng6dRrdzCij2OveSogMKfPFYiL3
	 DdnN5x23hk1hTw2+Gqqmj3F6xFr4AlvNTPo9CrkeWaHzsQTdL0M4VgdLD58wbQ/cwL
	 oZJl1evTjo5o7F9gsIoBIPeQUwEM0lo769ZTjdMn9InvoP7YAg2M3mxJmwFU6RsfFA
	 nmvk0JNflTzcg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 24EAC3EC7C; Mon, 31 Aug 2026 09:59:11 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170340;
	bh=E0MXpjFH7mYjcbni6iXg4UXw//WxDXgZGz917IzAjLk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rV5+nFBBMT/HLTtLtOiJT9ed5O7FvLtHjPlK5sA1oH7y8+Mws9h2CD8LlVRa4ryy3
	 ZU9cyVkiLWMl0zYXvWvks+X4VvjIMQj2gzKd4+QsveB4ItSUMYO6FllzoPZ2ugUAGy
	 DIHu5xO78jK3XYX9j5vu/Rhu+WWK3bWy6JbvR5kYzgddJlRQMVf9h4klQ49L1w0kKe
	 lgbQdTqqIQoFqR8eKwM+5TQyz9e59/v5VZPAvyoRpIFbvNr0+gWWs3MYHvDK+e/bJu
	 gc/4Be90BY36si3BjjAN2nIFCUCN09HoXG3IFFnU1fi2le0fSQ9NlapFqIFctdiPIt
	 a5hr55fsE8hNg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5E0723EC53;
	Mon, 31 Aug 2026 09:59:00 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 31 Aug 2026 11:58:59 +0200
Subject: [PATCH net-next v8 10/15] ax88179_178a: Add AX179A/AX279 multicast
 configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ax88179a-v8-10-de905f2ee426@birger-koblitz.de>
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
index c9c60425082cba18a32f36927687bbd9c207941a..5de0f9557ec5cd7fa41b9d828c6d75dc927e99e3 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -618,6 +618,7 @@ static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= usbnet_mii_ioctl,
+	.ndo_set_rx_mode	= ax88179_set_multicast,
 	.ndo_set_features	= ax88179a_set_features,
 	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,

-- 
2.47.3

