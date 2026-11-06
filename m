Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949789;
	b=iJ7xxJuKfy1kIALJw/OgFrMfp8lMOoJhvmjynq094DHXCvtPMMqqcVy3tfoQLONIj+31
	 8U8cmVFUBz7PvRKBkFtktowq4FBzLjc/hxkbcPSdvtHTUu/el2xmvlGnraX4tyER7DGi/
	 sd7SWeAu1vb5uFZyawBeGlygiOJerrQhe/tjug77fZL8bDRymM6XYc9jJX1w9neHFwE/y
	 NIsgLP+7ri+E99qMbRjfJfkUZrmxfhAwx77bB7QnkRpa+PuU+F2BIoq7af2R9gdBFWOIn
	 EMElrAujZ9Rhsfqk7wdKeTQh54y9Qui0YUxjNbFt/NKj1Ot4cwl5NjQFxIMFtsy+7eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949789;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pCfFm456CsVfjOH88KlSb93hqVwmD/ejTQ6cUioUW+4=;
	b=U9SXOth/bou1cg22LQkpKiIGhW1DRfXbFGUJb8spD01WXbT8hRAOzQzHyb/85U9WDISV
	 AdrnckUYQhT749Hom8+YEjf3gYG7MSPX+Xg9D/9lP4k7CKRHFT9GyIFe5kH56auzFex0e
	 jKgEja0tEjxW6RhntIOzhgfoTLylvkDS9bEh2fNGx2rCRb/gYHMc8mFx+ddHEPX+b+1d4
	 AWOltRQxMihso3zhLnpiMLbyOSOfOnphSwBKUuVtNdst3GIux6FGbgx6fDZ1w84iF9X9o
	 HvrXt8KR+V7YHGET8ZcP/qbENUYCv/IleNqum65UIJxNpreHJROfSDILjkZ9nuvRNzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Z7rs94EX;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD812606A329;
	Fri,  6 Nov 2026 07:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD812606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Z7rs94EX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Z7rs94EXRPOwAmC+lPUo5h7O8utGpAcjvA5IKWWLg7WFiMGElSzpP9WTajzqY4n6K2frcs7tIwwy5
	 LKTk63IVt0v3jMp0bvvtlFJ9VUEODj23fIS9kNPJXCcHj2w8Ut6lrKFuGGPvMlwl3yZJqnNewXoki8
	 cQsQlEY1st3YyPQE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46aed80543bc-4df6d;
	Fri, 06 Nov 2026 15:23:04 +0800 (CST)
X-RM-TRANSID:2ee46aed80543bc-4df6d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.104] (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36aed805776c-169ad;
	Fri, 06 Nov 2026 15:23:04 +0800 (CST)
X-RM-TRANSID:2ee36aed805776c-169ad
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>,
 David S. Miller <davem@davemloft.net>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Ciprian Regus <ciprian.regus@analog.com>, linux-kernel@vger.kernel.org,
 yana06070@163.com
Subject: [PATCH net-next] net: ethernet: adi: adin1110: Fix phy_device leak in
 probe_netdevs()
Date: Fri, 06 Nov 2026 15:23:03 +0800
Message-ID: <1793949783000.333861.5224091507677300156@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

adin1110_probe_netdevs() probes each port with get_phy_device(), which
allocates a phy_device without registering it. The pointer's only use
is phydev_name() for the phy_connect() call, and phy_connect() attaches
the device the earlier bus scan registered, not the one allocated here.
port_priv->phydev is then overwritten with the phy_connect() result and
the allocated object is lost.

The devm cleanup action only disconnects the PHY that phy_connect()
attached, so nothing frees the lost object: one struct phy_device per
port leaks on every probe.

Keep the get_phy_device() result in a local variable and free it with
phy_device_free() after phy_connect() returns, success or not, as
mdiobus_scan() already does when phy_device_register() fails.

Found during a code review of the MDIO attach paths. get_phy_device()
only calls phy_device_create(), and phy_connect() can only return a
registered device.

Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
 drivers/net/ethernet/adi/adin1110.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 53fac3d..fd769f1 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -1571,6 +1571,7 @@ static int adin1110_probe_netdevs(struct adin1110_priv *priv)
 	struct device *dev = &priv->spidev->dev;
 	struct adin1110_port_priv *port_priv;
 	struct net_device *netdev;
+	struct phy_device *phydev;
 	int ret;
 	int i;
 
@@ -1604,16 +1605,17 @@ static int adin1110_probe_netdevs(struct adin1110_priv *priv)
 		netdev->priv_flags |= IFF_UNICAST_FLT;
 		netdev->netns_immutable = true;
 
-		port_priv->phydev = get_phy_device(priv->mii_bus, i + 1, false);
-		if (IS_ERR(port_priv->phydev)) {
+		phydev = get_phy_device(priv->mii_bus, i + 1, false);
+		if (IS_ERR(phydev)) {
 			netdev_err(netdev, "Could not find PHY with device address: %d.\n", i);
-			return PTR_ERR(port_priv->phydev);
+			return PTR_ERR(phydev);
 		}
 
 		port_priv->phydev = phy_connect(netdev,
-						phydev_name(port_priv->phydev),
+						phydev_name(phydev),
 						adin1110_adjust_link,
 						PHY_INTERFACE_MODE_INTERNAL);
+		phy_device_free(phydev);
 		if (IS_ERR(port_priv->phydev)) {
 			netdev_err(netdev, "Could not connect PHY with device address: %d.\n", i);
 			return PTR_ERR(port_priv->phydev);


