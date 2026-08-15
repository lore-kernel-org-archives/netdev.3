Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE942464B
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786808419; cv=pass; b=O0KO4hfXV99Z6QHrz8bZRKzqSm2bUixSqGOgtBvJP32bChZIswojGlrF3qze8+WFWU3GKW1TBQ1UBR5KkhmLE6DDeM1TW7ACEvUhW+kMDzGm6QTwH9R1UZDZMm+rYAsUxF9nc+yHEvZY2thn7wBvfYWQKZAWKgkubM6sAFuFPh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786808419; c=relaxed/simple;
	bh=VdMKIWXHtkouEonplv0xQCQR8WcRhsnhn6oql9JJZuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hDSm/NCfycnbOUCyj02QBApxDTbSWgfZ5XifzdhMcnVZsjzrBB7GiqVZRsz9JUfYdBsSkh4RTCuqSLork55H5eqzfO7hUifAO4xcxEdURAwkBVLHyuBPvB3NS10OnuMfYIStP67RkNSjEmhoJBoHznpA9GABvrRguZnfYoXMbos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=m2kcq/eJ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=E2Va6955; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="m2kcq/eJ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="E2Va6955"
ARC-Seal: i=1; a=rsa-sha256; t=1786808386; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gG+7QLuLORYCsXmNUP8HPwOao+m9OdDjBGRWqhDTM8u42L7erCRp86Nnwq4R3T36x5
    orZ1KXu/cprG78I9ust6UQbvN0Vqh1tETopGz345F7j4Ic+wIFpPdWMgjBixzn3QnPBS
    ZMfODSOmZxyC8k5RVlxAXaMmbcfAY20eyFmrYuBDtzR/8vdVo9//nImf3LtEXICyMjdm
    wgWXiX/70afxrYvm8kGehjfjR2aYJ4NZNPenGbz9mFGv8q1SJM0Q3hOe1Kv7RrtPxdzF
    e8+7U2b3GsKl5QD1mxD8enFrrP15Me5LuMqZJ9AVq7ud7A1u8UkCU4zhzAFjjbk7apP6
    MWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786808386;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ORGgbUPDGg9Hek3HxOMNu+zs1MSisWsg0MqP2vIJd3w=;
    b=by5HjmcC4YxCnn962XULrzqQQazFITwtBrMu/3tFuls7yWrB55f78D+COV7GfRiskZ
    1KOq8aHvRYOQQ1w4K0VBAsM15IqO0lzAfU4ZmxkPKNWf1Ad1fbqh+Evk/1LyUciuFLHh
    LYBHf86qkzGKLHPRRC/RNtYx04+apHXG4TnutwxD3Snri46hxqWDwLqmS337UbC1W9Fc
    Hl438h+7GKqm6nOnfvrHBPAqAFUVZiR7y0xfM+/gjGQy66i8R8HdUnP4LSVAj1zBmawb
    IqRJRXCqbsnboi0k9dt0M5T/rz9o9leJYPDaJ8xPT1YxmaELN1dqasoj9eEFSqIJBvFT
    Ax2w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786808386;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ORGgbUPDGg9Hek3HxOMNu+zs1MSisWsg0MqP2vIJd3w=;
    b=m2kcq/eJCC/YQ3VJh2Smmy2s36gGDEbxgb0xugZae3+Oqd4KRB9XtTffiD/KX9P0a0
    ZHdq10YWN4bp7NsrW+TJjZn+8Z1IRyyXuWubYUt4F1OizrEHsk7bs/p1tnEAXVszQ0Bb
    kW2W8TUf/ek5hHiTok377I5Z10NOQjSFfeOdceNybMkqGYAcRNYwfNVsLHbeBLSpoHRB
    7n23rvV6eYWZbix3aHs4js/Bdua95f7gLO+O3hQzZ3jE2szOU9SOhbjtXXBbeOFd2w7d
    tkW6lcM1bN/DVO8Q1Zpynshj/p1qgutWeqVmnqVOvBxNFmWAS+3Bi20dgWUtzDYiHPB4
    YviA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786808386;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ORGgbUPDGg9Hek3HxOMNu+zs1MSisWsg0MqP2vIJd3w=;
    b=E2Va6955BtY1zoj/pyci7EAwiPovsGtHrBCtTr32+dveAUOlHihp9SpuiyIb7Liw2H
    z7etTeXjRXcm+PBeXDDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727FFdk6J7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Aug 2026 17:39:46 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiale Yao <yaojiale02@163.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH net] net: do not bond/team netdevices which use ml_priv
Date: Sat, 15 Aug 2026 17:39:38 +0200
Message-ID: <20260815153938.187073-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Commit 8ba68464e478 ("bonding: refuse to enslave CAN devices") already
addressed a syzbot kernel paging request crash report for bonding.
The same problem is also valid for the team device driver as both work on
netdevices without taking care of the private mid-layer data structures.

To reject ARPHRD_CAN, ARPHRD_IEEE802154, and ARPHRD_IEEE802154_MONITOR
netdevices does not solve the root cause of the problem as ml_priv is also
used by some ancient ethernet drivers like S/390 or 82596 based drivers.
Today those ethernet drivers likely would not use ml_priv at all.

Make sure that only capable netdevices are offered to teaming and bonding
by checking that ml_priv is unused.

Fixes: 8ba68464e478 ("bonding: refuse to enslave CAN devices")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/bonding/bond_main.c | 4 ++--
 drivers/net/team/team_core.c    | 7 +++++++
 include/linux/netdevice.h       | 5 +++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 522eab060f9e..bbb344b67458 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1892,13 +1892,13 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	const struct net_device_ops *slave_ops = slave_dev->netdev_ops;
 	struct slave *new_slave = NULL, *prev_slave;
 	struct sockaddr_storage ss;
 	int res = 0, i;
 
-	if (slave_dev->type == ARPHRD_CAN) {
+	if (netdev_has_ml_priv(slave_dev)) {
 		BOND_NL_ERR(bond_dev, extack,
-			    "CAN devices cannot be enslaved");
+			    "devices using ml_priv cannot be enslaved");
 		return -EPERM;
 	}
 
 	if (slave_dev->flags & IFF_MASTER &&
 	    !netif_is_bond_master(slave_dev)) {
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index feaa75fbf8fc..8bf4c1c5d657 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1215,10 +1215,17 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	struct net_device *dev = netdev_from_priv(team);
 	struct team_port *port;
 	char *portname = port_dev->name;
 	int err;
 
+	if (netdev_has_ml_priv(port_dev)) {
+		NL_SET_ERR_MSG(extack, "devices using ml_priv can't be added as a team port");
+		netdev_err(dev, "Device %s using ml_priv can't be added as a team port\n",
+			   portname);
+		return -EINVAL;
+	}
+
 	if (port_dev->flags & IFF_LOOPBACK) {
 		NL_SET_ERR_MSG(extack, "Loopback device can't be added as a team port");
 		netdev_err(dev, "Device %s is loopback device. Loopback devices can't be added as a team port\n",
 			   portname);
 		return -EINVAL;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8840b126979f..74536f642b41 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2784,10 +2784,15 @@ static inline void netdev_set_ml_priv(struct net_device *dev,
 
 	dev->ml_priv = ml_priv;
 	dev->ml_priv_type = type;
 }
 
+static inline bool netdev_has_ml_priv(struct net_device *dev)
+{
+	return (dev->ml_priv != NULL);
+}
+
 /*
  * Net namespace inlines
  */
 static inline
 struct net *dev_net(const struct net_device *dev)
-- 
2.53.0

