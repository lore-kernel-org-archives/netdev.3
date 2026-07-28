Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEB93A7F49;
	Tue, 28 Jul 2026 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251621; cv=none; b=ZJqhrl9YuEob/uol7maNXfMEqATpJ9ZyCLKtrTWazvYRCusrBDidKMgyJmA2Rs8xARCBgl8q87yGIi1/ekGzx5JNP0tg5GcQs1LQ/H21aMlyFPN6HUGmPH1pMRXUsuQAErITu0rVMU5E6vzmlaO3J3b/XJJnmSjGtXNMNe0BIyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251621; c=relaxed/simple;
	bh=5ZiI8w3nbHsWcGWEWXl6g7CKRP5HFJI95EK5NZGbGH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UTlXEKFF0SIwOJUQgthD23aqWAF0BvpVhTjOxqv605u1/Ue02g6hykIUaODsFu0OX1Z2G+GDTpg1YPCqYuSHNxzFPxqd5xU9iDylOMYulRPJiHghcWfJ/EmsMYl4i9AsfIXXgVJUTScoQEEffsjBO2PUdM81gGQnC1fzKELAdiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=loHgVr6G; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="loHgVr6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eH
	19iQyE6ktEKZqX0mDW3aaBU9J8G0dsrql/GjjwTmc=; b=loHgVr6Gdd+zHaNSKx
	nwfAk0lcJQItGAnvFE5ruQ5jWXgVMnN/pflUHRdENTKvamn4DE5CI1WdksU5oc5p
	o/7Axn06uMQlkdU1wx7uaIsH56Zqjl2YohvxX9RCHlrjQlKDN0KqE81PcscM5Th5
	Tuca/MOK4XKxsfsK5EIPDpSwU=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHGYnrxmhqAhzILg--.60915S2;
	Tue, 28 Jul 2026 23:12:44 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH v2] team: reject CAN and IEEE 802.15.4 devices in team_port_add
Date: Tue, 28 Jul 2026 23:12:40 +0800
Message-Id: <20260728151240.89434-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHGYnrxmhqAhzILg--.60915S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AryrKry3KFWkCw4rZFW3trb_yoW8CF1kpF
	4kua4ruryDWF1xJw1rWFZ7tFy3Xw48Za4IgryUJ3W29ry5XrWrArW5Za4DK3WjyFy5AFyf
	Zrs8XF45u3s8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pREzuJUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgyh22poxuwFIwAA32

Enslaving a CAN or IEEE 802.15.4 device (e.g. vxcan, wpan0) to a
team master triggers a NULL pointer dereference because these
device types use different Layer 2 architectures from Ethernet and
the team driver never initializes their private mid-layer data
structures.

Reject ARPHRD_CAN, ARPHRD_IEEE802154, and ARPHRD_IEEE802154_MONITOR
devices in team_port_add(), mirroring the existing CAN check already
present in the bonding driver since commit 8ba68464e478 ("bonding:
refuse to enslave CAN devices").

Link: https://lore.kernel.org/all/b58d98e0-8fe3-4e4e-b8a5-c1c7e647ccca@hartkopp.net/
Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
Assisted-by: Claude:deepseek-v4-pro
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
V1 -> V2: Extended check to also reject ARPHRD_IEEE802154 and
  ARPHRD_IEEE802154_MONITOR devices per review feedback
---
 drivers/net/team/team_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index feaa75fbf8fc..d8c46105fc8b 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1224,6 +1224,17 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		return -EINVAL;
 	}
 
+		if (port_dev->type == ARPHRD_CAN ||
+		    port_dev->type == ARPHRD_IEEE802154 ||
+		    port_dev->type == ARPHRD_IEEE802154_MONITOR) {
+			NL_SET_ERR_MSG(extack,
+				       "CAN and IEEE 802.15.4 devices can't be added as a team port");
+			netdev_err(dev, "Device %s is CAN or IEEE 802.15.4. These device types can't be added as a team port\n",
+				   portname);
+			return -EINVAL;
+		}
+	}
+
 	if (netif_is_team_port(port_dev)) {
 		NL_SET_ERR_MSG(extack, "Device is already a port of a team device");
 		netdev_err(dev, "Device %s is already a port "
-- 
2.34.1

