Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3E03F5BF5;
	Sun,  4 Oct 2026 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791092378; cv=none; b=dVrEMAXVsfcts7Q4MZRdRPuswOmuL6Ig6cteoSRllG3OujbxUveS/JYMhrgE5TRzWq8Lus71wxv27Atw5AkVSQ9FOm0+xmKpwu0+KGDP3gL/+17/4k5YMjgWYeatBzdUvt2TbUOAk+6r+Ux895R3w8Rv8Ywvh3pRyEdVPVtt2/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791092378; c=relaxed/simple;
	bh=jSSRBu+EE49mKlG8PnYl2TjsGSZMSiKvv1J8J2qLOVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KU50jYKuHnvWAdz86jFGstCOISW7LcLYKM4nDfO+PwZhM0SL/8e67Ptbq5wrdywu6MdRodMd9GAqwoLPfPbx+V6eeEXi236RW/kUn+hHQYTcfGEXHFR4kC/hOQ9W5dC+018ZA9elANk7/pgy0fJmXmBu0e4JmHlAs9qCdg2XhVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=TMdXk7dj; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=TFOmTCQn; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="TMdXk7dj";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="TFOmTCQn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791092365;
	bh=jSSRBu+EE49mKlG8PnYl2TjsGSZMSiKvv1J8J2qLOVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TMdXk7djL6SYS5ezbfukjDzWuZ71fbx5vnPHkXiATB+nV+FkEPAHFx/Dh6/Ou3t7S
	 lESFnBJreCMR3oXVfKymiyNWSu6/PSQLpUTUNPkM5eBZJOuwgTEz9mRmiFlyPFQG2B
	 uW+Ib6mZMI9K7WRKX3hnFQeiHkV7iQY55nFDfeYPq0hcjtrLLyoSqTF7MUWztXl+LV
	 ssHyrhoZviPLjeoilkxzt+dWHgqQJXp83NVOFl9/xmtGDVeT3Xy0aNy5CNsMtamykt
	 B0c1S1XLMgg3Z3rkwTKx0pDNLAFg187Ll8dA6i3BEk3bv/RQ/uyefyZ+H0HPQZajdt
	 ctBxDww+BSSMw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 4D4D148352; Sun,  4 Oct 2026 05:39:25 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791092348;
	bh=jSSRBu+EE49mKlG8PnYl2TjsGSZMSiKvv1J8J2qLOVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TFOmTCQnBdQm2Ozh4SeHmloRQ5nCQ+R5L4+jrcOo3h6xpG21AsondABxGZ2EjmWlg
	 F41cySOqEEeza/zbDOvaIhcKuhEsnD7VEfNNpPQmeAEbgXpvmlyawGPDqB8bGiNp9x
	 BA5j5vSJvj6uCQUP+nBjFCUdpVlELtX38t5ir5HHA6HpGUmp29JxEP9zxfJfCSwJ6r
	 0dtfTeeF2J9Wsb33QPqJPdIfi5VmcTIHYZJlsr0Won/kUS/UMILdUOcyqvVOdp55I7
	 1IT1CjtLqDwqIbfbVZt111XcGaKRdnsCcU88vZMeWEl4ArqK2gHm368+wDz+V7IYfo
	 cERGiZ5s26ELQ==
Received: from AMDDesktop.lan (p5dd1ef42.dip0.t-ipconnect.de [93.209.239.66])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 48EF84833E;
	Sun,  4 Oct 2026 05:39:08 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 04 Oct 2026 07:39:12 +0200
Subject: [PATCH net-next v16 08/13] ax88179_178a: Add AX179A/AX279
 multicast configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-ax88179a-v16-8-2a9ae4e68f7b@birger-koblitz.de>
References: <20261004-ax88179a-v16-0-2a9ae4e68f7b@birger-koblitz.de>
In-Reply-To: <20261004-ax88179a-v16-0-2a9ae4e68f7b@birger-koblitz.de>
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
index 9d84a678172c9c8fe9918dc034944e6a7c89446c..8d09d4808a3bfea2d9d0cc147488283e09fd2f1a 100644
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

