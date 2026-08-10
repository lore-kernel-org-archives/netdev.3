Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1998E3E16AE;
	Mon, 10 Aug 2026 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365247; cv=none; b=cElnAHSIZQ4DfUB/cQbNlC/7YdqTu+wWvvhYBErGBO35hFhFBYbBHllYUb60AH4MmFkuCJ6bFCq23zlzP91FekZ2sr/m68er1Aai2rdxbgBoTu3mXX5hQQlkBO38um1R/jyA1ZAkDJC1qIsVFUDBCa8A7Hxr/94z9cRtC7RrdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365247; c=relaxed/simple;
	bh=CiKkG0NPRdaJ/1V4wh/8ckoknQmdNRaqW0rMtaEopvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iAC/yjOq3x+7Z7CpzVh8e7r6rDpZcZVHiKhcStTOKITuQmikywJlV+70bHylixMiL53k2VVrsEtejpQgtA3a3OtyRE3PVi24wjWncSXDdnLDs+5euYyfpem3yXYaYOc7bGQZcfZFPbTCYeOGJflgbyrq1EAmkHgbo4dBGtVfRd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=UeKCTtbC; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=hIuWUUdk; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="UeKCTtbC";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="hIuWUUdk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365244;
	bh=CiKkG0NPRdaJ/1V4wh/8ckoknQmdNRaqW0rMtaEopvU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UeKCTtbCT84sPHBYU1Oty1OJb0/353Dtl6oJr+ALYtByVfiYy61PrCvq+IwObBBLx
	 zPPMLj6moKHgjRUYpC2fMVLyAb1SEW8Bw5Mjh5KzsaMUenYAD3nMBZN0+jd8dVnY6y
	 9okSqXBr0zY12t32rgtCWT1TMuKYAr/yKn34zhUxivgmzUc4ty3Yyrp4jwph6ZqJG2
	 dZAc0VYAZXOPTZPRS78VIT9wbixH+r9goy9+9/x7vLdqEKnbSuAdCc6mme8CVYVikU
	 OZaAuU/P4669+0bL9itTmGy1HqQ8SYZaHiQe0pvomRpH+VMUfxMx/uYyk0aptZzO/V
	 yFLhrO4LTjFTA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 441074979A; Mon, 10 Aug 2026 12:34:04 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786365219;
	bh=CiKkG0NPRdaJ/1V4wh/8ckoknQmdNRaqW0rMtaEopvU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hIuWUUdkvejcatT/p+sW+u5QDtaVhh+lfvH9cs1RgtkBTXa1C7zYRhU+y9GxZCMyE
	 8xtNEks7bdsj+fmSkDlYJLRD7S5V6Gl2KvRfUjXAC3IuRd7brs8+3sJHRB9ErPWTd/
	 EzrDNKn+lMFGVAnc93GvxQDSHOiGGQig1ZCyoHWICh+SfE2MlysdOg80nPEopA8kNG
	 aZlkQN8RvthtevsIBCiuBuwt8WdWNJknmOnKfIpZfrSfISW7uFNGEMDSDsMg5YjR0Z
	 vz4txPydXaDvNtBeAt40vRCvIH+q5vAfweidwY/rtlHvyiyYap+ktT0uU85hOHNLlg
	 02uBLAs/h1gIw==
Received: from DebianDesktop.lan (p200300c69f06340062b039dfa3272a8e.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:62b0:39df:a327:2a8e])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id AE07349776;
	Mon, 10 Aug 2026 12:33:38 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 10 Aug 2026 14:33:34 +0200
Subject: [PATCH net-next v7 09/14] ax88179_178a: Add AX179A/AX279 multicast
 configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-ax88179a-v7-9-da633191c129@birger-koblitz.de>
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
index 4e8823e1c4a15bc8caf788446c8c030b34039a01..7332967a59e16868825bd62a91b918aaeecd3500 100644
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

