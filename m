Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB3C46C4D0;
	Mon, 14 Sep 2026 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390045; cv=none; b=cV3EcMHdRoN0Q4vSHkG/NQr0Ps6u5KplLQdKR6edz5aqD/UhmDByIDT3JZZP/LUEVcSuPAxYrBKj0jZqXkfKq/RQx1BgML0RWnQtgFm3yshvKyZteyvqX1PCWUKahSpIATX5qtH9xfAlMmEpeGnSTeUEgbcBoxai5alyU5t6lWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390045; c=relaxed/simple;
	bh=yGXMzJN2dzt1mpXm/L1oEs9LtoywiK/5tqkbYs9Tn5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VgXXpdMhCCn0drLjb5Th0wKUbkIBQBGsVgE/mDwZBppgR94G1NJ18WHIRowpZ2GlV3WcijfoXN/VPoaShTA4EWluggWyKmCLjfpZ6qxNLImoPcGOZUOkWCR+4aq9aaqnrjFYlSxj5Je9fdImteids59Cv2daNKBQzGrlTypuE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ied3JwzW; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ZRUoTqd8; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ied3JwzW";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ZRUoTqd8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789390041;
	bh=yGXMzJN2dzt1mpXm/L1oEs9LtoywiK/5tqkbYs9Tn5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ied3JwzWzcknUw2lYGQMJn+9dwjBKOkH5paur9ynRvEUYF15537cQFeSG1iUSJS6u
	 d2mkq1tGMx1DrNFRHmixLfM7JWdGnixuyd8uJuQcoCMbyrzivpzQpZGy7DMpQ1JID4
	 Sd6HLU2OWIXDHII2uXlSwxzDMS1hxZWdTjoSZ1LNi7nQ5G+k0waLI8wHzclW7b6Ttk
	 v1QZCl3G3Hl8VKur+EKR/ZQLaeI8RaQNI8JmEuf5JCWCZHF9HLGFV8oWoM3lfoSm1S
	 VsRlJZG6EKHIlIvGETjzWinly4q/bEScTNNa7kGCsPhM2DJTUSx0JdNGE1YeUIA9mD
	 obed6npae2A1A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 83C973F6E4; Mon, 14 Sep 2026 12:47:21 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789390040;
	bh=yGXMzJN2dzt1mpXm/L1oEs9LtoywiK/5tqkbYs9Tn5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZRUoTqd89Wd+Ol/i2PmB7V/FZBXKcHDSvbnfnheTiLHxYG8HVBJwQ1m4RT8g5fKQm
	 VI+EUpczqwPOJRLLDjq81+fxFFUloYlhcdWCrlQ9wn92B/eKm5Wx2MJAHQkXSTRjg5
	 4EbSfNXNpuLDUDdlibYdGB9fdog2sEjfoNamIkpw+nuK2c5s/KalNZY256OWDxJL1l
	 XpieK3BkFnM4pd1GEkkQ3buQp+5FQwLuP4tkS/bI4brZDkwb6kh4o+jDDXuqiPlzqf
	 mTd6LSdYfEWhToVUnsMz3bcil5ldK8XNV2WEL7Ew0V1WsLdO9QYAeTsS/Ytm4Zv36K
	 rlRzTV4lanrGA==
Received: from DELLLaptop.net (unknown [IPv6:2409:8a62:2532:dca0:14f4:3e22:1e7c:23c2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 6FF773F6DB;
	Mon, 14 Sep 2026 12:47:16 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 14 Sep 2026 14:46:19 +0200
Subject: [PATCH net-next v11 10/15] ax88179_178a: Add AX179A/AX279
 multicast configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ax88179a-v11-10-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
In-Reply-To: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
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
index 4bca801236b08f5e361f49843602bb20e51ea3ed..24accbc22092ac3ab7ae0059e7b749c9f7f39530 100644
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

