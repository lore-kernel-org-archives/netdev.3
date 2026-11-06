Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.97.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949701;
	b=haMY0RNp8dEbpTq9fZvQvRU2Z+Tpeh6HqvxDgrl/M2h5DyW0yqo6ns6q6dVqphOWgq79
	 +p2Li2aLm6bTKQB2ZqhGSEMla1CuKFEASB34bKVdiZ2p5RcylHhPVzPuDD9IELeOyeSLk
	 JkWv+/PQ73P6UbB/pmo/3WVpjhA5+yEpgdvCovJrAncrRbW2NgmeU6+lErho6drYEQHp3
	 zfagjqUcRJnQf9M/SUmvhYZmy0BNpSLV+oUX+bh8iin6Ad81EGQlCPzlh42MFfvV+1zgF
	 echrlNGebrVxhhly+vMZBIZ1ME0i64Pnn8ZBBbBM86uz59SYMC/xBUo1Ohl5TvCfEGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949701;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=dw2wwIa5KiQ4m+CZJzqK4mHabxUELfoWipJwxC32AEg=;
	b=TiN5sJTKBKplxR129smtZ74MZWrel5mwK1DKz9Cx3eqaD26DNLcwcPl5Q9nslIeJdqSm
	 u6fIAhe/AncPw2qcbuAG9PLd0mfrGz27VFixR+Ho5QBa7mV+Vto5EXs9rcpnDh9fIb0b+
	 05is4UrTxOA0EZskE2q3AOOBsdT/pK8qK6paqvFy0pO6ZlGwvQtC58wlkVwbhD0AyDm20
	 TBHXPSj0poG3zcqXBmNnuQuDlP4ZuTCOBaJFEhANb9roku+IPsNomvs01HhjnKi4DTeDm
	 ous+KeNUdLCi6D144mo6lRHra7FILpAv5F/1PgmirZdDiLxRKouRLJrZXP4hh3JLbUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=birger-koblitz.de;
	spf=pass smtp.mailfrom=birger-koblitz.de;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=IFUOpx6q;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=tsaddMoL;
	arc=none smtp.remote-ip=23.88.97.239
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D1606D834;
	Fri,  6 Nov 2026 07:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F2D1606D834
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=IFUOpx6q;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=tsaddMoL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949700;
	bh=Q0JBHsoXOE0rcjBzburvk9Dhq9vEVC5K5ZbvCLUZ7po=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IFUOpx6q4Lh4W/l3Daqnv23w1DeuNIqgkmP1aAOL4kGFrFllolQoCnB9ybDcusrQR
	 utcL2CfeFiNPAYGNdUbsMFrHjflMaDWsbsQFEhwRTvSXodR+GzzpZ9AAB3SuyspOw9
	 2wtljS+iWT8Oulg+B3byJlBgJINgJThfrHxvDkOud8qjfeFzk7AveSGh3DYHd63KvZ
	 VnIQ2nrTEnTaW2Mlp6396FsfQaXJ9/i/m6Z2IN9H4U+IsfEXA9zuZUAraxVUrml6an
	 YZnvEbxeHCmnohTBljjwcuuuiPwRru/abco4li4oUIVkrXqtmutKtMGdt6DBijgjOI
	 0w/LDS8v+UJrA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 0ABD948BBB; Fri,  6 Nov 2026 07:21:40 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949687;
	bh=Q0JBHsoXOE0rcjBzburvk9Dhq9vEVC5K5ZbvCLUZ7po=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tsaddMoL4wNVn/RSgf/9hPROsls2Ru6IC8aLgalSo5pn0BvC2RK4JZNqYN9PWlGMz
	 PtsC2+/97Ye83wE3aU3mq+tE0PNnr2JlA8P9el7HtI0ayo1SQAIJMXdQlYgLjSPZKV
	 HFsfide/rcXEoWoJ15l76z9PeIv1O7vn8rVHouuXjhSp//7VAy9ZSXhrI+zfU4E0hn
	 BwDRABAMCDLQNwR4TOyYumgFM2J7VHfBZ92ytKkx9HN/SD3rbrucp12gmJP2jYwYgV
	 1IZ4WquEJI4GqnDfALoj3L6B0V1qwVbWKbeLKIqOFj48FuNwi8P7SyDQD3EBX2qxnj
	 24w+yWG6QyP8w==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 1562448BA9;
	Fri,  6 Nov 2026 07:21:27 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 06 Nov 2026 08:21:23 +0100
Subject: [PATCH net-next v20 08/13] ax88179_178a: Add AX179A/AX279
 multicast configuration
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ax88179a-v20-8-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
In-Reply-To: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Emir Beganovic <beganovic.emir@gmail.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

Add support for conditionally setting the ip_alignement flag
AX_RX_CTL_IPE in AX_RX_CTL and make sure that AX_RX_CTL_DROPCRCERR
is also set to be consistent with the initial configuration in
ax88179_reset()

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179_lib.c      | 16 +++++++++++-----
 drivers/net/usb/ax88179a_devices.c |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
index a314db4c9766679568a036f98acf868784835865..b4b00c8b4b62320471e13ae34a1fed5d02e80441 100644
--- a/drivers/net/usb/ax88179_lib.c
+++ b/drivers/net/usb/ax88179_lib.c
@@ -321,16 +321,21 @@ int ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom, u8
 void ax88179_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *data = dev->driver_priv;
 	u8 *m_filter = ((u8 *)dev->data);
+	struct ax88179_data *data;
+	u16 rxctl = 0;
+
+	data = dev->driver_priv;
 
-	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_IPE);
+	rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_DROPCRCERR);
+	if (data->ip_align)
+		rxctl |= AX_RX_CTL_IPE;
 
 	if (net->flags & IFF_PROMISC) {
-		data->rxctl |= AX_RX_CTL_PRO;
+		rxctl |= AX_RX_CTL_PRO;
 	} else if (net->flags & IFF_ALLMULTI ||
 		   netdev_mc_count(net) > AX_MAX_MCAST) {
-		data->rxctl |= AX_RX_CTL_AMALL;
+		rxctl |= AX_RX_CTL_AMALL;
 	} else if (netdev_mc_empty(net)) {
 		/* just broadcast and directed */
 	} else {
@@ -351,9 +356,10 @@ void ax88179_set_multicast(struct net_device *net)
 					AX_MCAST_FLTSIZE, AX_MCAST_FLTSIZE,
 					m_filter);
 
-		data->rxctl |= AX_RX_CTL_AM;
+		rxctl |= AX_RX_CTL_AM;
 	}
 
+	WRITE_ONCE(data->rxctl, rxctl);
 	ax88179_write_cmd_async(dev, AX_ACCESS_MAC, AX_RX_CTL,
 				2, 2, &data->rxctl);
 }
diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index 4207d2cc2b865e5780b3c7f5ba2645a6242df477..a6b0a3f47118c46db38d483792c083510aa2641a 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -678,6 +678,7 @@ static const struct net_device_ops ax88179a_netdev_ops = {
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= ax88179a_mii_ioctl,
+	.ndo_set_rx_mode	= ax88179_set_multicast,
 	.ndo_set_features	= ax88179a_set_features,
 	.ndo_vlan_rx_add_vid	= ax88179a_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= ax88179a_vlan_rx_kill_vid,

-- 
2.47.3

