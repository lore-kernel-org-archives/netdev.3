Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4DD4AA1C7;
	Wed,  2 Sep 2026 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368262; cv=none; b=VrU2GsLhJEUfcPbL9Yz3/GObdD+viOlUWsur43HwYO4JdUxtYOAZSuoltaykfIAjnWx7Nt9b2gpjNvA+6yREFNjDZf0iE1PPOD5RCZRZcsRwMf8UUAg6gHa3leUAcvLEsEzLbAGZx30tMKUdSvrvPjA1etND/fr8RykKhUTtGZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368262; c=relaxed/simple;
	bh=OoHYE3NOeYeoK87wOxlezn9bCXrVNWFGhoepfTzTH4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lsYhK9eor8wX7GWB1wGt36AmNDg17CS//ZiUCqOUgsK3cwNO6F+ebbhFm4Ln2kVdeTdUKkx3cO966Yut9W3GJpAIvDa9xSJvsmjXEJEE05Ova9Ed7ssA23kP10Y5FLmo4jSbHw6jlcst0vz3fcVpJG1+JDJg79zoHf7wRD4b6oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=zfhTymgR; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=fpGH8dB/; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="zfhTymgR";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="fpGH8dB/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368257;
	bh=OoHYE3NOeYeoK87wOxlezn9bCXrVNWFGhoepfTzTH4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=zfhTymgRzik3o0l0LO4tfIXq4j65VVngxs1kAlYAz6Osa6MJNCpktSpfwUac5i8fh
	 /4p9HYWQ6I2qn9255byzAX6K1eZVpjT3Sc67GzSGX0H5gZ8Wl0pxO852kq0t0iS4NT
	 TDJJZNxCRHtR0UpiHeLrlS+rfQJZUfPlt4ho9k3qfApZbsQ3TY5i5vWNnVNcAH1cs9
	 7gNl/3rq/FtfCZGmJgvICErWvR62YrMrXSQ+PVeOkzKA1edpBLMrtUlJT7ttHjQOk+
	 udz6xymQdbJQsNM40PmPfPRNabbm6nImGlvfFhDGtSdinB3Z4ExLGsS/+MJ3nPnj4T
	 juJBilzrIsm2A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id C40563EF34; Wed,  2 Sep 2026 16:57:37 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368246;
	bh=OoHYE3NOeYeoK87wOxlezn9bCXrVNWFGhoepfTzTH4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fpGH8dB/Yimr2UGN0fHvH+zS0aFuPDlrJ0cgsa7WpyVHPeVCqdCqZRVLvg1J0ddad
	 c/CuQutO477TsBSNVMWEL0o25KA34YyxYpg4CRhU0SWOInvgYDfs5c1mM8BcPRiSV/
	 ircWv6GY+lLaz9H2Ep1iluQEvOlQgIZvfHinzN9WFPd/7JO8IwUHq7+thTdbHVXqpu
	 cOfRGVY4WMJwGL7stRXr8u+++4XwZ6mf4y8eZ4BtyCI/pEk5UKspIel/zbCcLZ8ymy
	 rJUSbE+eaUMBM6upeOALNatd7hDzLwl1E5m9zjAkejKOiS9g4EHJyP7Ox8cuSLKO8Q
	 PRKyM02BS+FmA==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:c4e4:2069:f0cb:22e2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 614AF3EF1E;
	Wed,  2 Sep 2026 16:57:26 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 02 Sep 2026 18:57:24 +0200
Subject: [PATCH net-next v9 10/15] ax88179_178a: Add AX179A/AX279 multicast
 configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ax88179a-v9-10-8e6d7710a2ae@birger-koblitz.de>
References: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
In-Reply-To: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
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
index 4e51b2ec2d1dc2def852b407fdc736a4dc676461..6ade76679629adcbb33e780900a38b44383da735 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -606,6 +606,7 @@ static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= usbnet_mii_ioctl,
+	.ndo_set_rx_mode	= ax88179_set_multicast,
 	.ndo_set_features	= ax88179a_set_features,
 	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,

-- 
2.47.3

