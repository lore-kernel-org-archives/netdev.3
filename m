Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A5A4A2E27;
	Mon, 31 Aug 2026 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185298; cv=none; b=gWGam8/6KrdUA9mM5l2Cmq0LGBlIU/d0k55SFBqhGz6FvMhBem70iROjlu3uAyUf4eE4TVEtRuDjknkoa5JKAR5+6lhaRQZz/55io5xql+RWyWByTwy9KBQ2dM+tHOXvp7gaSn8z88lZfJYhx0h7CFT0aXX7m2aa3POlFu7vLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185298; c=relaxed/simple;
	bh=nwA7qNpdElyaD/w4fbelPLYkA0W8/2DWZVnSoO3+QX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gZ8DKTLDTCX7xBHbqNYw9+1NUURU7vdtgq/xeyBqjDg3H57XIjVxAJHt8TGTBtbXqes6Xa+/J3lHMBkKB9VEOzCmaXzZuEpxvAlgHK4f+mRM4Wou8IqKXuc9tycbq0a2OEI/9+hGintN7aR4P4YtXxf0Vmk76bTRu/0CrxIzt48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fy7B+QhW; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fy7B+QhW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yg
	NHUxDzTC/VV4Fi5XNpXg/tWCbnOntK/5+gLe80oeI=; b=fy7B+QhWkdi5mJAXN8
	YzW3VLQOb/0yQWGDt3FhOgT33vRQHSv82bJ9NzjyENLrM98aN8WJwJ9J4Ju80Tnk
	eDoRryV9aWMwlF7ERBWPV2uBX1vFBhnlOlkwzKLdGNNODpxNoX5ZBdTTJZmBfANM
	ZmHWGJNPG4XXCc93H4zCqgzZA=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBHjrqSipVqvp9iSg--.52939S2;
	Mon, 31 Aug 2026 22:07:15 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] bonding: reject IEEE 802.15.4 devices in bond_enslave
Date: Mon, 31 Aug 2026 22:07:10 +0800
Message-Id: <20260831140710.469576-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHjrqSipVqvp9iSg--.52939S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr18urWkKw1ktF1rArWxCrg_yoW8Wry8pa
	98CF1FgrnFyw1xW3W3AFs7ur93ursrZa4I9rWUJwn5ur4DXF95Cry2qryq9r1jyrWkCFya
	vrWq9r4F934DG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pREoGPUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xTHAmqVipTXTAAA3E

Bonding already refuses CAN devices because their protocol-specific state
is incompatible with the bonding model. IEEE 802.15.4 devices have the
same constraint: they keep protocol-specific state in
dev->ieee802154_ptr and do not use Ethernet link-layer semantics.

Extend the existing check to reject ARPHRD_IEEE802154 and
ARPHRD_IEEE802154_MONITOR devices before bonding changes their link-layer
settings.

Link: https://lore.kernel.org/netdev/aohMHTTH4VqqgZA7@fedora/
Link: https://lore.kernel.org/netdev/6001bd73-ef68-4820-8371-a22775fb820a@hartkopp.net/
Fixes: d5ae67bacd96 ("ieee802154: rework interface registration")
Suggested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/bonding/bond_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 522eab060f9e..c716336c5172 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1894,9 +1894,11 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	struct sockaddr_storage ss;
 	int res = 0, i;
 
-	if (slave_dev->type == ARPHRD_CAN) {
+	if (slave_dev->type == ARPHRD_CAN ||
+	    slave_dev->type == ARPHRD_IEEE802154 ||
+	    slave_dev->type == ARPHRD_IEEE802154_MONITOR) {
 		BOND_NL_ERR(bond_dev, extack,
-			    "CAN devices cannot be enslaved");
+			    "CAN and IEEE 802.15.4 devices cannot be enslaved");
 		return -EPERM;
 	}
 
-- 
2.34.1

