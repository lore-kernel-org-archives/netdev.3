Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BB92DC331;
	Wed,  1 Jul 2026 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917255; cv=none; b=NDaf8CbuMzYMZZ0Y+attF+i9ang5vqP8kiUIvYJJeLHF6faBIQCSNTf+cuZqZqIb2xBk+djkfCFQghjxaB9DTlAiO/DqK263u5MX/srCeDGlJYLH0hoo9GI9QpqkfqRIjv1kreXT450/SZIcP2fgPXOYoEQj6tkZ/1w0HlINvns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917255; c=relaxed/simple;
	bh=FwG9XPxIQQfsuFlFND0+WxSwKM5jedQZzWqkuukEI9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Vpjka40OcSl+Ey5cHEXUX1edO1ZMAGekuVFZBUQHKx9q+6UCBQFH6pa3VrqFzt6VAMLWXt+u7OhTfXtwr4WOjCl3tLarUT+uNzXEDB/iys92H2WSZIobe8Tc59wASVUrXBM6MswxeywnOnuI//RPOab1gancZoBZw+TPCY2MF0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+6aY+Bb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+6aY+Bb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC715C2BCB8;
	Wed,  1 Jul 2026 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782917255;
	bh=FwG9XPxIQQfsuFlFND0+WxSwKM5jedQZzWqkuukEI9A=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=l+6aY+BbqWKSOCJwobLTZMq07FORvQQs29Mlx+0pVzNM8BGhZWk1oDARo7wIylV/2
	 +TAXajSesfNz2xNa1JAZCxfxXxyrbTnAOAQfANXvKBAQHBCSONB5SfSe0n7QNYxdns
	 8bXRyozzRbpCOawvW5GsSWod0QDPGJBOB1t25CXs45wYTF6COcC1uf+KTBx7Lr+QFE
	 AhqEsL2b6ocjPxVJoMNfi8DExr7W34B1OSGhnqtSiNaH8Am5qCcLKVnWhGpKde5gdx
	 zXXI8r7dNuwvc7AQNH7VlmIDKW3vdNGXL0uAaMy2o5MhItTDW3nDd76nLlJZX6yayn
	 Lw5j5Gnj/AJzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3ECC43458;
	Wed,  1 Jul 2026 14:47:34 +0000 (UTC)
From: Enrico Pozzobon via B4 Relay <devnull+enrico.pozzobon.dissecto.com@kernel.org>
Date: Wed, 01 Jul 2026 16:47:23 +0200
Subject: [PATCH net v3] net: usb: lan78xx: disable VLAN filter in
 promiscuous mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-lan78xx-vlan-promisc-v3-1-232266d32743@dissecto.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw7CIBBFf6VhLYaHoejK/zAugA4WY0sDldQ0/
 XcpXZgY3c2d3HvOjCIEBxGdqhkFSC463+fAdxUyrepvgF2TM2KECSIYxw/V13KacMoHHoLvXDR
 YcmWlOkhVg0F5OgSwbirYC+phRNftGZ/6DmZcgWutdXH04VXkiZby5uHktydRTLHVltgj4bqR9
 ty4GDPR743viiWxD6cm9A+HrRzgmkoiRM3kF2dZljcwRYVzGgEAAA==
X-Change-ID: 20260623-lan78xx-vlan-promisc-83af8a48a7ec
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>, 
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung.Huh@microchip.com
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Enrico Pozzobon <enrico.pozzobon@dissecto.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3497;
 i=enrico.pozzobon@dissecto.com; h=from:subject:message-id;
 bh=T6eb/DFqmbo3Thzxo2uZwZZS2rw6/n4NBOq19Ptob6M=;
 b=owEBbQGS/pANAwAKAfB2RbS6BRipAcsmYgBqRSiDWot391JCMA+RzCsVgv41t1o4jYkto4Fu0
 if2vEGAbSyJATMEAAEKAB0WIQT58xDVmo5qdqM1wSrwdkW0ugUYqQUCakUogwAKCRDwdkW0ugUY
 qUgXB/9YDmHTo+TjghaT/gOUctwAoag3jyvjGuh/WCCjs47KZGsqNnjIdxX2goE20s3hWtcvVxf
 MkT1SSzUfDZ9eoxXI0RODlRHsxvYUMZbriwlDLVoGBRHnku8MvnCkcQR/I5mVDhh1TMbr0ejlao
 oHuIfk1aDqNDNLaqHP9tspqZYWRcSNIlkRg+OGxdJvW+1QY+KwhW/yI/mOT++ysBEFLGpEN7Om3
 f/JYgxXjvWAqCWRLmDM2j7YyjW72M8eHNBFfoFVoSNpGsvGqc1Zyr+Xheva+3xXUjE3YU6rOgRE
 3XJrLVZCTnLxDhCfj54ROBtOjKWMKmC7LsYbnkbzvhNCI3/i
X-Developer-Key: i=enrico.pozzobon@dissecto.com; a=openpgp;
 fpr=53D697CA0B11F68C9552A59DA3D0B3A0924EA5BB
X-Endpoint-Received: by B4 Relay for enrico.pozzobon@dissecto.com/default
 with auth_id=836
X-Original-From: Enrico Pozzobon <enrico.pozzobon@dissecto.com>
Reply-To: enrico.pozzobon@dissecto.com

From: Enrico Pozzobon <enrico.pozzobon@dissecto.com>

The hardware VLAN filter (RFE_CTL_VLAN_FILTER_) drops VLAN-tagged frames
whose VID has not been registered via lan78xx_vlan_rx_add_vid(). It is
left enabled in promiscuous mode, so packet capture (e.g. tcpdump or
Wireshark) does not see tagged frames for unregistered VIDs.

Clear the filter while the interface is promiscuous and restore it from
NETIF_F_HW_VLAN_CTAG_FILTER otherwise. Enforce the same condition in
lan78xx_set_features() so netdev_update_features() cannot re-enable the
filter while promiscuous.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Enrico Pozzobon <enrico.pozzobon@dissecto.com>
---
Currently, on microchip lan7801, enabling promiscuous mode does not
result in VLAN tagged packets being captured. This patch fixes this,
forcing the RFE_CTL_VLAN_FILTER_ flag to be off when promiscuous mode is
enabled.
---
Changes in v3:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://patch.msgid.link/20260701-lan78xx-vlan-promisc-v2-1-fe3b18066728@dissecto.com

Changes in v2:
- moved VLAN filter logic into lan78xx_update_vlan_filter()
- Link to v1: https://patch.msgid.link/20260630-lan78xx-vlan-promisc-v1-1-fbf0f903bd8f@dissecto.com

To: Thangaraj Samynathan <Thangaraj.S@microchip.com>
To: Rengarajan Sundararajan <Rengarajan.S@microchip.com>
To: UNGLinuxDriver@microchip.com
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Woojung.Huh@microchip.com
Cc: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/usb/lan78xx.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index c4cebacabcb5..cb782d81d84f 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1499,6 +1499,17 @@ static void lan78xx_deferred_multicast_write(struct work_struct *param)
 	return;
 }
 
+static void lan78xx_update_vlan_filter(struct lan78xx_priv *pdata,
+				       struct net_device *netdev,
+				       netdev_features_t features)
+{
+	if ((features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
+	    !(netdev->flags & IFF_PROMISC))
+		pdata->rfe_ctl |= RFE_CTL_VLAN_FILTER_;
+	else
+		pdata->rfe_ctl &= ~RFE_CTL_VLAN_FILTER_;
+}
+
 static void lan78xx_set_multicast(struct net_device *netdev)
 {
 	struct lan78xx_net *dev = netdev_priv(netdev);
@@ -1533,6 +1544,8 @@ static void lan78xx_set_multicast(struct net_device *netdev)
 		}
 	}
 
+	lan78xx_update_vlan_filter(pdata, dev->net, dev->net->features);
+
 	if (netdev_mc_count(dev->net)) {
 		struct netdev_hw_addr *ha;
 		int i;
@@ -3074,10 +3087,7 @@ static int lan78xx_set_features(struct net_device *netdev,
 	else
 		pdata->rfe_ctl &= ~RFE_CTL_VLAN_STRIP_;
 
-	if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
-		pdata->rfe_ctl |= RFE_CTL_VLAN_FILTER_;
-	else
-		pdata->rfe_ctl &= ~RFE_CTL_VLAN_FILTER_;
+	lan78xx_update_vlan_filter(pdata, netdev, features);
 
 	spin_unlock_irqrestore(&pdata->rfe_ctl_lock, flags);
 

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260623-lan78xx-vlan-promisc-83af8a48a7ec

Best regards,
--  
Enrico Pozzobon <enrico.pozzobon@dissecto.com>


