Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377760;
	b=qPUYbp0QRsZFMzkO+poFc11S2XPJg+NjzWClqSvfHOyEonCU9BqJxNVVEePNS0f+puu5
	 DfIHs6hgSfbxxzR8jG0vmb/F1x/GdTD22neGaJW2YLHOkfoZaqBATD9I7h90FwXpsI2Vg
	 tZavt2QsAN+2IXMcQ8cn+n/7DZ1h0sj1B5ROAI+KRUdbdE5KpOcaAEOF0NoLH0fs/UmGo
	 x96wTHbH6bzSZuZoFEIs5x9WThRkESpLE9slWV/egQwAF+ftEYFdp3sUjeIueoZVyTCPO
	 CA7Dg97KLTv1/feZdlf8ZEuE7bO9SRVqzsQgUmaahdnRMuPkZ/C9coPrKq+0Z7Qq1og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377760;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MW0zD9KSMGx2T80Sakg+RFoXs36lTEMU6Hbk1o80HfE=;
	b=fQb41fYWrDqS6QCPCgu3iAqr0n6zEGF9HsDJulS4yj2ls0MEhI+TquqwyOPXeLs3r4Ei
	 jGlereHRc2mEaG7jNcF06+wBsnus81RjUJJEu7AMDd6b2aOb3lmYn84f/1P16w+NAhUHS
	 AP6EBPmFHyNxpzvkUurVDV5YOBIVQATTxTWryzewlDMGLuaOfE41xJX1DaYaDeO0nVuXT
	 r+MyA/ObNLWR60nr+fB2+gf4iS16TQyxgX8AdCv3SM1utBfxE83EKKAmRa753zl/S/j4W
	 /PDqsh/JuU6x6wfWOz57QRa8A6qRQ2xACJEaCeOjU7zx1oYZv+EkMOK9bJ3lnRL0PAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=uZWVpxVi;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2782606A31C;
	Wed, 11 Nov 2026 06:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2782606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=uZWVpxVi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=uZWVpxViarE7Cj7TRhvVv5Iel0V/32j9aqJleaeHPYixxzKf2C+wh3UhF6iRRrgRxRJ3GfzZxnH3/
	 9BBgPLrCH/m/AkUi4HAWVnJnBqWbQRqUBpyTwgE+OITjAZ4tuMPUQA3HdD9cQvErVx5RV7WiBdFoXJ
	 6fbRGwBvkTo7dFtk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af4081b5b7-b0a23;
	Wed, 11 Nov 2026 14:15:56 +0800 (CST)
X-RM-TRANSID:2ee16af4081b5b7-b0a23
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[112.23.105.204])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af4081af8f-d11aa;
	Wed, 11 Nov 2026 14:15:56 +0800 (CST)
X-RM-TRANSID:2ee96af4081af8f-d11aa
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: [PATCH net] amt: handle all upper amt devices in amt_device_event()
Date: Wed, 11 Nov 2026 14:15:35 +0800
Message-Id: <20261111061535.189769-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When multiple AMT interfaces are created over the same lower stream
device, each AMT interface links to the stream device as an upper
device and takes a reference to it via dev_get_by_index().

However, amt_device_event() uses amt_lookup_upper_dev(), which only
retrieves the first matching AMT device.

Consequently, when the lower stream device is unregistered
(NETDEV_UNREGISTER), only the first AMT device is detached and
unregistered. The remaining AMT interfaces remain attached to the
lower device, triggering WARN_ON(netdev_has_any_upper_dev(dev)) in
unregister_netdevice_many_notify(). Similarly, when the lower device
MTU changes (NETDEV_CHANGEMTU), only the first AMT device has its MTU
updated.

Fix this by iterating over all AMT interfaces associated with the
stream device in amt_device_event() for both NETDEV_UNREGISTER and
NETDEV_CHANGEMTU, and remove the now-redundant amt_lookup_upper_dev()
helper.

This issue was identified with the assistance of an LLM-based code
review tool, confirmed by reproducing the MTU update failure and kernel
WARNING on lower device unregistration in a User-Mode Linux (UML)
environment, and verified in UML that all upper AMT devices are cleanly
handled and unregistered without warnings.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---
 drivers/net/amt.c | 48 +++++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 81d26ef82cf5..568ff4f77be6 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3404,22 +3404,6 @@ static struct rtnl_link_ops amt_link_ops __read_mostly = {
 	.fill_info      = amt_fill_info,
 };
 
-static struct net_device *amt_lookup_upper_dev(struct net_device *dev)
-{
-	struct net_device *upper_dev;
-	struct amt_dev *amt;
-
-	for_each_netdev(dev_net(dev), upper_dev) {
-		if (netif_is_amt(upper_dev)) {
-			amt = netdev_priv(upper_dev);
-			if (amt->stream_dev == dev)
-				return upper_dev;
-		}
-	}
-
-	return NULL;
-}
-
 static int amt_device_event(struct notifier_block *unused,
 			    unsigned long event, void *ptr)
 {
@@ -3429,23 +3413,33 @@ static int amt_device_event(struct notifier_block *unused,
 	LIST_HEAD(list);
 	int new_mtu;
 
-	upper_dev = amt_lookup_upper_dev(dev);
-	if (!upper_dev)
-		return NOTIFY_DONE;
-	amt = netdev_priv(upper_dev);
-
 	switch (event) {
 	case NETDEV_UNREGISTER:
-		amt_dellink(amt->dev, &list);
+		for_each_netdev(dev_net(dev), upper_dev) {
+			if (netif_is_amt(upper_dev)) {
+				amt = netdev_priv(upper_dev);
+				if (amt->stream_dev == dev)
+					amt_dellink(amt->dev, &list);
+			}
+		}
 		unregister_netdevice_many(&list);
 		break;
 	case NETDEV_CHANGEMTU:
-		if (amt->mode == AMT_MODE_RELAY)
-			new_mtu = dev->mtu - AMT_RELAY_HLEN;
-		else
-			new_mtu = dev->mtu - AMT_GW_HLEN;
+		for_each_netdev(dev_net(dev), upper_dev) {
+			if (netif_is_amt(upper_dev)) {
+				amt = netdev_priv(upper_dev);
+				if (amt->stream_dev == dev) {
+					if (amt->mode == AMT_MODE_RELAY)
+						new_mtu = dev->mtu -
+							  AMT_RELAY_HLEN;
+					else
+						new_mtu = dev->mtu -
+							  AMT_GW_HLEN;
 
-		dev_set_mtu(amt->dev, new_mtu);
+					dev_set_mtu(amt->dev, new_mtu);
+				}
+			}
+		}
 		break;
 	}
 
-- 
2.33.0



