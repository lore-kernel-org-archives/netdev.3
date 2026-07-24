Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423B53B19B6;
	Fri, 24 Jul 2026 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878622; cv=none; b=V79VbWlLkHQl0F+J9vzEtDZKYMIz/xuWgjv9NVRfPfR44nh/VSkMNgHEPb8dcQUxVT/avHFrQX1yP9gc29fCtHM5CMKzfx7HnXQwtDQ/9kb282ZgXABMcKWq1TX4vkkLhsYi/NUMlUqC/U/rqZ3Dd7h6mMWUuWIYw8YIDMFU0Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878622; c=relaxed/simple;
	bh=z0SDU9UqzCrc+NpLDY6Ok2tA8Jfx+0J76yanVklX/hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i3KLMWAJD0g8uvWzcrXolfNSiCOAdSOn80lJR7uWl99FioPdnKYydg3T7aTrHRp3qDANoJnkQueMhR+8a2p8bKItHz90wELVN7GF8CMV/Bw7cPXnZwY2xzM6q3hUafKKRCHK6ZANpcX+xwKWZGsFj0agWPViL0tNwMcz2RhKDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=yJ0cdHRr; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Tgcstv0q; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="yJ0cdHRr";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Tgcstv0q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878619;
	bh=z0SDU9UqzCrc+NpLDY6Ok2tA8Jfx+0J76yanVklX/hs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=yJ0cdHRrMUAgzGki7/gfKH2QslPzQM8CWv9DRpW3UKI1Rj8hsWilZ+geyzRJJNMeE
	 Y9jMkrpIHser/WGYrNQcqBEPw5vcnIrzeFtpuAIYn7PKHyxGw8vwupfDUwe5eeRRxg
	 pt6KdmyPpnLLMFCYcmlaXf0hGvubQN1OP/NvTHKecDnJVG0M0VOYdcAdo8VZwka/MB
	 2tQYhH/iP3l2KUBZuLOvyeVBUybnsILJprs5jsLHILlWHCKVwnSJzAZJKjjpRC6sYS
	 Ni48LwvDP+0kve7fIPsKFYXVSxEJ53UTYCOGyHGCcr8qlZMQkkanIr+QE2tbLvppT5
	 /WLP2kvgmWX8A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3643C493D2; Fri, 24 Jul 2026 07:36:59 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784878609;
	bh=z0SDU9UqzCrc+NpLDY6Ok2tA8Jfx+0J76yanVklX/hs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tgcstv0q6uE1OBXoEvgczn+SHKAncfk+OnXfIPcxkAp3vgM6FVCaa44/inha91BqE
	 NIZX823ijm4MzAj5ePzFVcPZx0H0B5SwxEYjhI62qS89UG5AnSUYTczD2bTA5XRuB1
	 Ma0fL8w+EDIB1tQKTXWUhL2VkVCj5WOdOPU2QS/Bh8eu3T/962azlbcipJ2zyJ214Q
	 h15P8rVzZ11C8AKbzjf3ARv4hUTYlPlAZgzGzlfW4+JbmP26gqgig84Sb3K/ThMrhJ
	 JHrQ6ZgQJAlRL3dSkq083I7lpyeW/UGg9hru0GiVN0/VsAPQfWO0E/iG+au0AXoQcC
	 XBQ/oR1073pjQ==
Received: from DebianDesktop.lan (p200300c69f1c3c00ecd187824fbc6faf.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:ecd1:8782:4fbc:6faf])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id D3F8749344;
	Fri, 24 Jul 2026 07:36:48 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 24 Jul 2026 09:36:51 +0200
Subject: [PATCH net-next v3 08/13] ax88179_178a: Add support for ethtool
 pause parameter configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-ax88179a-v3-8-bdde4f905883@birger-koblitz.de>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
In-Reply-To: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

The AX179A-based chips support pause parameter configuration.
Make it available through ethtool ops.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 02c015847eea3dfbdfa73f3d59a7d5b0dd1bc339..cc9a3ef4fa03ac36f89f78d2909a84d9b11d336c 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -314,9 +314,6 @@ struct ax88179_data {
 	u8 link;
 	u8 speed;
 	u8 full_duplex;
-	bool pause_autoneg;
-	bool pause_tx;
-	bool pause_rx;
 	u8 rx_checksum;
 	u8 eeprom_read_cmd;
 	u16 eeprom_block;
@@ -1000,6 +997,29 @@ static int ax88179_set_link_ksettings(struct net_device *net,
 	return mii_ethtool_set_link_ksettings(&dev->mii, cmd);
 }
 
+static void ax88179a_get_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data;
+
+	data = dev->driver_priv;
+
+	phylink_ethtool_get_pauseparam(data->phylink, pause);
+}
+
+static int ax88179a_set_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *data;
+	int ret;
+
+	data = dev->driver_priv;
+
+	ret = phylink_ethtool_set_pauseparam(data->phylink, pause);
+
+	return ret;
+}
+
 static int
 ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
 {
@@ -1177,6 +1197,8 @@ static const struct ethtool_ops ax88179_ethtool_ops = {
 	.nway_reset		= usbnet_nway_reset,
 	.get_link_ksettings	= ax88179_get_link_ksettings,
 	.set_link_ksettings	= ax88179_set_link_ksettings,
+	.get_pauseparam		= ax88179a_get_pauseparam,
+	.set_pauseparam		= ax88179a_set_pauseparam,
 	.get_ts_info		= ethtool_op_get_ts_info,
 };
 

-- 
2.47.3

