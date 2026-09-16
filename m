Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22B837C119;
	Wed, 16 Sep 2026 03:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529107; cv=none; b=oj3smfHxm1szZ9NbOv7Vbnj3kEWAMEZQUkWPMTav8Q9q7yXEGpCCvbZj5YDCcDEmidLzCXX7Cwk7r7tqZjxH56r/cQPe3hOzQnhGX2GXdb/vWZ5bSvPNtWyel3D1zV/KJegRPN/s1Mpgqq8QZAhkiMXLOt+Q0qCzt3PAiXp8uMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529107; c=relaxed/simple;
	bh=NcbNkay5OqNhKbALtpWwHiOqWRFp2I3RdeCx/AOF7mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tSDrkNoGCE2ZXxrFpY8SDV/nLEy7qo3O+jz8/4MpwmT0xN8KD0bw/JrhOPNuY5zB3LiTzjJEEBkOSNOn9Tk/9yJ/5U6TIotpuywWjB9WhRF03Qay6/TDJR4PSlcJFoLuX7pRdm/xwqCqC5Dj32UOi/lCziAc42N8ZDrzqvj+BBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=VC9axKxp; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=lPupUxuL; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="VC9axKxp";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="lPupUxuL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529104;
	bh=NcbNkay5OqNhKbALtpWwHiOqWRFp2I3RdeCx/AOF7mg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VC9axKxpwVuhc0eH4MHe7ibQUEp+03hw3HIZsev94HEpKWYHg717u1f3QwHla8LpG
	 PL4WjnDi+H0OK7PAtPtHw6TwZNUOiCEp5sig1jBFgRto/89pX+LASd5e9P15F/pdDX
	 VI7Su8Xz5NQu8f1EBU6Ek1xBoQt4StDcqJCoNKjV5jguwscrCejPhVFrNNbwT6kNaS
	 To5MIfJY4gvhw9PbsYLFu16kWjfRHtu2A256yqiJlSTTGEyySpAcjUaKQtVX70MwXY
	 3EHaYSj3uHIV0JEunxTHkUrLgOgfHYTl5SsqjnE9sdbgftEotMJgstm3QKfSAb5ShI
	 YJGW3tbGXqhZg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 01D0B3FA72; Wed, 16 Sep 2026 03:25:04 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529103;
	bh=NcbNkay5OqNhKbALtpWwHiOqWRFp2I3RdeCx/AOF7mg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lPupUxuLcPIaWmPQq9w18A4oIcIbQE9ZC9wT1J+1IU+pwn3gA/CtM/yOXf3XVP/Qr
	 yHYfb1ucAAqM5ZdeouVqSmHkF+mzKrmvjC9y5ksfAjZHdjaNaA/ZN9rClIS1dMS9+M
	 UDmlrpWbB+h2sjYlqblWwLh3/ifxcm9beqShlVy+Yo1vbWG6SHSh3qP2LfEOGoHnBu
	 A5cL2TWXpPu8WRcs8NMCi66+FXdS75wa2la/GlqnPAzYIl8Q3nUFxnCNG0zPoAqXRO
	 t4eJhRiRWFJ26T/xeZ0JcfNnZggpNJxY6aTSSu5wSfNDC5OG4Ep59k6y7JiC+d3/HM
	 oruHi23u+wfmQ==
Received: from DELLLaptop.net (unknown [223.86.26.228])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id F36A73FA6C;
	Wed, 16 Sep 2026 03:24:58 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 16 Sep 2026 05:24:09 +0200
Subject: [PATCH net-next v12 10/15] ax88179_178a: Add AX179A/AX279
 multicast configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ax88179a-v12-10-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
In-Reply-To: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
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
index 481139f71ac26f218b672622eec93c7a026c0089..e77450bc3299fb1a3698b36cab2785e82cf759a6 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -615,6 +615,7 @@ static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= ax88179a_mii_ioctl,
+	.ndo_set_rx_mode	= ax88179_set_multicast,
 	.ndo_set_features	= ax88179a_set_features,
 	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,

-- 
2.47.3

