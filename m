Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA864192EC;
	Tue, 30 Jun 2026 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828990; cv=none; b=qmQvcipwJ3ytF9T6jWNM1W0qCYCeWmx8I5ZiVjmiWXK8fWlv1wvuszXmOfU+aYWhOxkqw2GUCsDI6dCXEHoFtY0/qXu1H/5eY+p6g+kSL1Cr+m/Dq8DARm7kL00f8UmvvHQoF/Skc+87sqz54CLC/jUaMmuYxsK2q003MhXdBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828990; c=relaxed/simple;
	bh=YQEluft6inscCZmKUrC6Q/duocdLvbzZL7dDcWnSyzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pyN7P3jO/8WOlGM288UJWtwXdnU5Ne0kmpXT7GtvvpozOkGK+UBgWR3tqynpFBz7kpZ9MtzfQdLV9ai42vb+8EkmN3aQUqHbpJ6r0ghRtLbbpzHuCiV4xY/oTB9b0IX02zUhOUg6fZ3Jq2ojOy/bWRU0fftUkYvJ9BG44Wachhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtDi5qIo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtDi5qIo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39928C2BCC7;
	Tue, 30 Jun 2026 14:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782828990;
	bh=YQEluft6inscCZmKUrC6Q/duocdLvbzZL7dDcWnSyzY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=VtDi5qIoJrTRlFtAZmzCM3yA1geqoqr8YtLd+fz27lKS26taFNWX2R7fd1gwAh1+e
	 nKzbiQT7Q2O7QifrxTfIgftZW7iePTvaerTG712SUpjdY9wbWALW/I+7fgquN6o5LJ
	 dViIfV22UFGs3ir1AkB/CB2T+i9EgwNmadBsoWUoIe2+rz2HYW73SgvpXHGIkUc5D4
	 uQ9bTPYhVAtNP+j73WlWzJIlbupa3iEsaLJ0kpM9pDxENk3F44lR/nqRDOevqQM6/w
	 1B7zL2Gonyb4sIcK036vTURw2npCWwU7X1UymYjkW/4cSwXq8TGDHhV3GsWMZURzEH
	 UNA19ae73FH/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2216CC43602;
	Tue, 30 Jun 2026 14:16:30 +0000 (UTC)
From: Enrico Pozzobon via B4 Relay <devnull+enrico.pozzobon.dissecto.com@kernel.org>
Date: Tue, 30 Jun 2026 16:15:44 +0200
Subject: [PATCH net] net: usb: lan78xx: disable VLAN filter in promiscuous
 mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-lan78xx-vlan-promisc-v1-1-fbf0f903bd8f@dissecto.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QqCQBBFf0XucwO2hi79SvQwbWNN1Co7Jgviv
 7fp2z0XzllgklQM52pBkllNh1jgeKgQnhwfQnovDFe7tm5dQ2+Onc+Z5jJoTMNHLZBvuPd88tx
 JQFHHJL3mLXtBlAnX/bTv7SVh+gexrj+c/TptfQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447;
 i=enrico.pozzobon@dissecto.com; h=from:subject:message-id;
 bh=bIwnc5BgyWpD7lh2kO182FaahM9KA6UXn2GOq+qIiR8=;
 b=owEBbQGS/pANAwAKAfB2RbS6BRipAcsmYgBqQ8+8/wyMoAeNBOxZzpXYbCvn4s+ZCLPV7ghbn
 QoIGddxQK2JATMEAAEKAB0WIQT58xDVmo5qdqM1wSrwdkW0ugUYqQUCakPPvAAKCRDwdkW0ugUY
 qaB5B/9VlU0xwm3cQBq+9uWbxzEf4Cy5w/pSIg2UVvuF/MhtMb5Id1mYlanE2NLJrd2JSbHXKQq
 +GUVHp58Sql963S78jqwDF1Dj/wHaegT8w9oxwISxo9mgAls2s8cmPfrW6H9MBApqmlAp2T5xNI
 1jJ7f1Q32lZ4S/oCe3Qg+PeConUyo8kdqPqE+B0JLAe6+yKaBnRdOY36OYAdRSUmkNNQ/01YTob
 IvCRKblNVekOgnVojYVb8oKChJfz36XE0ct3/dA1fdmkpkVtWPIkpXc23akLfH60/nL/a1637py
 5rqmRLXr2hgYH8wbE4DiOZGZ4UieU1/gNrWrY1wiLZYvyeAG
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
 drivers/net/usb/lan78xx.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index c4cebacabcb5..a1a53ef85cb9 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1525,7 +1525,14 @@ static void lan78xx_set_multicast(struct net_device *netdev)
 	if (dev->net->flags & IFF_PROMISC) {
 		netif_dbg(dev, drv, dev->net, "promiscuous mode enabled");
 		pdata->rfe_ctl |= RFE_CTL_MCAST_EN_ | RFE_CTL_UCAST_EN_;
+		/* bypass VLAN filter so all tagged frames are captured */
+		pdata->rfe_ctl &= ~RFE_CTL_VLAN_FILTER_;
 	} else {
+		if (dev->net->features & NETIF_F_HW_VLAN_CTAG_FILTER)
+			pdata->rfe_ctl |= RFE_CTL_VLAN_FILTER_;
+		else
+			pdata->rfe_ctl &= ~RFE_CTL_VLAN_FILTER_;
+
 		if (dev->net->flags & IFF_ALLMULTI) {
 			netif_dbg(dev, drv, dev->net,
 				  "receive all multicast enabled");
@@ -3074,7 +3081,9 @@ static int lan78xx_set_features(struct net_device *netdev,
 	else
 		pdata->rfe_ctl &= ~RFE_CTL_VLAN_STRIP_;
 
-	if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
+	/* keep VLAN filter off while promiscuous */
+	if ((features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
+	    !(netdev->flags & IFF_PROMISC))
 		pdata->rfe_ctl |= RFE_CTL_VLAN_FILTER_;
 	else
 		pdata->rfe_ctl &= ~RFE_CTL_VLAN_FILTER_;

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260623-lan78xx-vlan-promisc-83af8a48a7ec

Best regards,
--  
Enrico Pozzobon <enrico.pozzobon@dissecto.com>


