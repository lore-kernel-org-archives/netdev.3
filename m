Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C8732B13F;
	Tue,  6 Oct 2026 03:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255934; cv=none; b=cmQA9x/Y7oHPu1i8PWze4Z2o5kcanaEvHkhXca4L9Hg0YqiKhlQC92iYMwgJptvPrTdF659UNCKFd4sG/cKNP7UfGDhKvJm869drP58eaSmr+WmtDwt+0b7WISvvlUv/CYbjOyXl/HOLb7yt/KqLQ+1me2kUr6ffBO6vHp56ZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255934; c=relaxed/simple;
	bh=Cs/pTIEsOs/Xib/PVc3EE/VZjgP3y+9Dd887aAhGedc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U4vA5zzCfgz6XFcVYTuplOcLbtrVst23pgLjfxuvNu7nd5UuhmYZE5/0OEyLy2vnTge/a4YLURtrTU26qblQ24/H3cZtQvek0kEb1MJagU1XTbgl1caQxHnb479xGCm0WkHqthn+bF+fAWpd6ABeeQY1iGqX0oHk9NfYZL/Ljj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=GLQHft6b; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=iEd64AKY; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="GLQHft6b";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="iEd64AKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791255928;
	bh=Cs/pTIEsOs/Xib/PVc3EE/VZjgP3y+9Dd887aAhGedc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GLQHft6bK4ZmuNzQLO0LG657zvNCg9LPDA6ghMoNuIMCVzhkmhZ7Dcp7tNr6deq5d
	 GOWNIOXxQAYr+oStmGhRPZPjLV+QjHNAXuwcZihJGIvHOeH4FQ7uhvwMRGUAr2BiSJ
	 C//JKe0VQZY+SyUB5sppn8Um/MWviw0TPkrnLxd0jDCQcNBPllOBRKde7KlPJZILQ0
	 FVPVEhJP621TLXd5IhoTq5u9hU3RAW4wM3q1cT7KHHVR2gONFCWXQYjZ5tUALq71i+
	 My5zL8Gdg9XL8F1N7QBZuBuyJpt+q253rFo/l+vquccu0q1mgu+NAgiGpbtCdevvSV
	 yS2UE+KYKIC1g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 68A5A485C4; Tue,  6 Oct 2026 03:05:28 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791255915;
	bh=Cs/pTIEsOs/Xib/PVc3EE/VZjgP3y+9Dd887aAhGedc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iEd64AKYONRWe3ldveRd+KN7EEfBts3c4SjflD3yyuyFj/KfTVucJ26HCbov/rsrb
	 LQ7uhA7BLV3KTexFC8L/FMv6NU1GhaXmgKYulBirc6R3vrI4w5DCkYMWmaqTAiB2Qh
	 qSMLST0OsTVH/Vz2lX9lcVgP9vcZkprTv7aUL+cSgd53x9kuMRT/ZnKuRnXJhE3Ntl
	 KgfPvRo57tYSo8U4MlJ/IPWEhOdGUJymzzI8vzDuyut+GS3IofSi38pnjLrMh8yJAo
	 BsnWGo3eSDt1E5a4inrQfvYk0qi5JOR56VL2iKwIIwCzxgHdnIItJr7E2dPQwpHgAE
	 tdklO1YpEZM4g==
Received: from AMDDesktop.lan (p4fd5971b.dip0.t-ipconnect.de [79.213.151.27])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C4470485AE;
	Tue,  6 Oct 2026 03:05:14 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 06 Oct 2026 05:05:14 +0200
Subject: [PATCH net-next v17 08/13] ax88179_178a: Add AX179A/AX279
 multicast configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-ax88179a-v17-8-252814fe35ea@birger-koblitz.de>
References: <20261006-ax88179a-v17-0-252814fe35ea@birger-koblitz.de>
In-Reply-To: <20261006-ax88179a-v17-0-252814fe35ea@birger-koblitz.de>
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
index 53ccfc5d56c24eff102fc94f631d50d2d2ec1abd..6ec662780483e94f9606f05f253106b8a6856d43 100644
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
index 4ca61d02c0c4d4e7f876170a803c3a46d76cae83..e592382692c74e2694cc78389219125980eae8a5 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -661,6 +661,7 @@ static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= ax88179a_mii_ioctl,
+	.ndo_set_rx_mode	= ax88179_set_multicast,
 	.ndo_set_features	= ax88179a_set_features,
 	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,

-- 
2.47.3

