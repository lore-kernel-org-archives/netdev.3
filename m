Received: from outbound.baidu.com (mx16.baidu.com [111.202.115.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6480C2C21D0;
	Wed, 14 Oct 2026 01:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941807; cv=none; b=Ga7jQVvMdMaHRM6CPo5OFc71XH4AuZQbpIBv5/0dy4zkaIH9+NGQjQbHaEw1fJs7EU9KbRSCZnjVyRZxwSFuWS5UECbY03Oa0r2t4f75UzZy2MPGvfcHGiKZcXozHCeCSCeFSdQEB++9bUEl4IgirhhGuHZb+ZGWOeRVoVFijfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941807; c=relaxed/simple;
	bh=CrROQyki+DwHSh+jADVdBk8VglktdnxfLw6Mnlctbx4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DbRcRW50BTPH4HgY78ePq0E4vI98itLeyMLTqRpyMvGOtHL8/Yx3A7uACk4zrzjBs8131ibZxS+m5ZVeIiuKw1+D16zrd79kcQQGtZYzlzbAuHhbfNcZW117rH8uJ5AJVg3PHAo6ZCRmUtT+xkXK0DWj6Z+wOakxEUaiFHBP3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=ODe3vqlo; arc=none smtp.client-ip=111.202.115.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="ODe3vqlo"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH net] veth: decide peer queue count from the peer's own attributes
Date: Wed, 14 Oct 2026 09:36:20 +0800
Message-ID: <20261014013620.2497-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc5.internal.baidu.com (172.31.3.15) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1791941791;
	bh=KwZ45N9B3ZKb9EyEDCOtRD18J/GFstUQfelRuV4fxSw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=ODe3vqlogUr+Gk86zlggNBW+WmRCqce7RmepO/xtEuprcGkhxuxg2jRBzOE9oieYn
	 bwNJ9cDh4OQACyE7ElUBvGaEg1yJ2D0MQGUSJykJ2TMyHrlwwLC7M8coXX3VuTyw72
	 E6Fm835CqI3zF9JbaR4w9aPBTceAQ8gQuNnSozpeupE/CgKonaSsjRUbVVDj2UPyKj
	 vvILF7ClPEwyUfl9NgfKPdcJz9/2rUpgZ/bU28h/fz3CQpqeNpQ7EvWD1IHgPmCw70
	 KKbkxZ9KR2+HOItJ6ZDZXAwPolO5ahM9hvhWFTk/vyrQmJAfpxCnSSb58xQ4GLrgSV
	 pWpOrWlbqarvQ==

From: Li RongQing <lirongqing@baidu.com>

veth_newlink() creates the peer netdev from tbp, which points at the
nested VETH_INFO_PEER attributes when they are supplied (peer_tb) and
only aliases the primary device's tb otherwise. However the queue
reduction is gated on the primary device's attributes:

	err = veth_init_queues(peer, tb);

veth_init_queues() checks !tb[IFLA_NUM_{TX,RX}_QUEUES], so for the peer
it inspects the wrong attribute set whenever nested peer attributes are
used:

 - If the user requests IFLA_NUM_TX/RX_QUEUES only for the peer, tb
   carries no such attribute and veth_init_queues() still shrinks the
   peer's real_num_{tx,rx}_queues back to 1, silently dropping the
   user's explicit multi-queue request for the peer.

 - If the user requests the counts only for the primary device, the
   peer keeps nr_possible_cpus real queues instead of the legacy
   default of 1.

Pass tbp so the peer's queue count is decided from the peer's own
attributes. When no nested peer attributes are given tbp aliases tb, so
the common case is unchanged.

Fixes: 9d3684c24a52 ("veth: create by default nr_possible_cpus queues")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/veth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 643b97d..07b738d 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1919,7 +1919,7 @@ static int veth_newlink(struct net_device *dev,
 	priv = netdev_priv(peer);
 	rcu_assign_pointer(priv->peer, dev);
 	netdev_hold(dev, &priv->peer_tracker, GFP_KERNEL);
-	err = veth_init_queues(peer, tb);
+	err = veth_init_queues(peer, tbp);
 	if (err)
 		goto err_peer_queues;
 
-- 
2.9.4

