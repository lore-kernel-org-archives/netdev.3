Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427864DBD62;
	Thu,  6 Aug 2026 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044983; cv=none; b=TuPjuxK4WnYEP36iGVqxDzDiI5gwPaEqfIpZM6cLxLXSAp0JTXkno4st75s6rvttGLxO2Nwtx5LdUzFnkTCzeydfpxK4OxOKxsJy9m27br1GrOZfOHk3fohVrEaLaxLZUJ6ZconNGtriJnF5py1dIYbfi/Tv94dPW3w/1448P6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044983; c=relaxed/simple;
	bh=RLCazpUsppKqIdADbfwz06QeneAHcndtbbRA7UjishA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ncFwhRBFeDCD+E3YT+EKKWSYbgb/LT6sTOcBnV04YtnLXsCBjNqVE0sfAz30GSYE29B6hiXoAVtVLMvIkO2/jLn2+RahFfsDQ9XgF6SMR7Q7VUmcIKhB1s1/99FC5x96UQR4pWpYap95FPxqjyrLq9h2VlGqK6p1AlBpbarqKZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=cBLKZ/qG; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=PzwlBNQ3; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="cBLKZ/qG";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="PzwlBNQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044980;
	bh=RLCazpUsppKqIdADbfwz06QeneAHcndtbbRA7UjishA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cBLKZ/qGLRVmfL0lcBaL2mL5Aj5sXsrAJbMYkuC2H+kZebsSg6fGS0Okei4dyvt4L
	 T2kNNAAu92cFp3RUORUcKXMfd+wxxN5Cq63YR2XNo9FVgHbt2n8ISG0Dqs3mefryco
	 GhbiY3tmfmvgNA4Qbfg1Zdo47HteXb0c+27Nj0Y9LxtdMJj34jKY9tF21+4kXPcCZw
	 jx75LdCyT+fyIqRANu0BLvxwFYQo6rWbheypUJRKUc0CwB9lrrbwUfeApridRlL34W
	 VWf+bYtOeJvvFqdtOX5RJFVsu6yIkL8waubHL+biC2oHaMcrxowgELenIROeJB5ia3
	 j3TrDnfHc+paw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 83FD84970D; Thu,  6 Aug 2026 19:36:20 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786044969;
	bh=RLCazpUsppKqIdADbfwz06QeneAHcndtbbRA7UjishA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PzwlBNQ3FwozfN3OMq2RxroSxKneXbYv20FO8QnAdXnJBKdcPRT9GJImB38wXHCsj
	 L/88rvl/DGdXo9DtP1+KdDpHJahE44rvoHkbjKo1mru/kvWimgflbclywkzj8hu0kF
	 dxZQxA2AjbsbwETkMSW4b10ezRYuYOqEH5FrPTXAes+tmCS0rAfNT1ENV8xMiaX+TG
	 7eSW4Wv9Jr2Ils3DKLkNVYSGTI7aEXI53LiQEePSwlthH4h1RcIzxFORWJU4qn84oZ
	 A2BnXKroMoJTW1XPxuYFXtbZ/4UDRFGEgjmuJHhbB+toOHC+sajTj9lWF9QfNvD2dX
	 OTslgCJUUaszA==
Received: from ThinkPadAMD.lan (unknown [213.80.50.14])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 56B3149707;
	Thu,  6 Aug 2026 19:36:09 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Thu, 06 Aug 2026 21:36:06 +0200
Subject: [PATCH net-next v6 08/13] ax88179_178a: Add AX179A/AX279 multicast
 configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-ax88179a-v6-8-fde7414619e6@birger-koblitz.de>
References: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
In-Reply-To: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
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
index 9d6df9d5c61c841965e9f7fa4b1075561b7f9c50..7a8c12027b9fcf7141694952528861e986d065ad 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -314,10 +314,14 @@ int ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
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
index f981a631dbbd1231ea8e1de0db215fbe5256e6d7..72c7fd897eaf72c3098393e152ee48099c1adc55 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -597,6 +597,7 @@ static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= usbnet_mii_ioctl,
+	.ndo_set_rx_mode	= ax88179_set_multicast,
 	.ndo_set_features	= ax88179a_set_features,
 	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,

-- 
2.47.3

