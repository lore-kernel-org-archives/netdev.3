Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2998C470119
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858860; cv=none; b=T2zlHmepoUqOSrDxjjT7Vz2hPU1j8/XgM0g28s8slX/KDKHlTMz/ogwuWrPd1FYtDeFew9W8FpUsK+MHpDxf6qaPrse8LczaCwod5UPsd+CaFfqCe95Fqt5T/oJ0+iI10j0jHQpDinpUu3j89dl+a2qHyrsJc4/IOJIYkWsR9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858860; c=relaxed/simple;
	bh=jU+3f89ymxzifmU9mxynIu75rAWJIl6clmXF85030ac=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V12XT5Wl1sEjEubs5UZETLv+bhYtvS7oXDM03YvuPhOiselvzZ7wc15d4Y8ft4ChfuZBYw1VAHj6zfNFgZMGmUKjR9ToPEV6ENPcSY/XU5jzWZFrG2t/kzRpN1IgOJZbApgP0bEcF+cSudLLwzR8Fxqwtiiw1dlJfQohXPfD0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PlpCIhm+; arc=none smtp.client-ip=209.85.219.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PlpCIhm+"
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8efe7db1c42so53508796d6.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785858858; x=1786463658; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4aI9w/0nmZPq1RfO1pNEdmzN8LhGBhlT9DnGtqMgwm4=;
        b=PlpCIhm+ucTJ22omyDT8P5IpymsmbMmZ9pXENS6YxVa1n5xesRRtgJor9eu9OmMR+Y
         EPWRdKmYPmoQaqOar/ejjxK+TTzRjm8JCBZ9YoB0a0VYz+Gmw/yyUoan6CsZXE+3Oiag
         u/VpMSOgm452ZAhgP2Ri6u5kF7V3EoWAT92wHG3D6tHCNdEFkf5qX5bWRnJ1MUBPwm2S
         uOF63zewjAWILmI9MdMdQY677PLJId1vpPaJfSbMlebKYD6RpawSy7BagoyY5CVm/SUK
         svjPjyht+oQwQM0q/aZVTsuKE8+kZp7T/6zAf3rPdWUIZ/Pzd2x1Z+zw4xQJdlTWnucV
         rMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785858858; x=1786463658;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4aI9w/0nmZPq1RfO1pNEdmzN8LhGBhlT9DnGtqMgwm4=;
        b=U5UVz/9xpG0x5NRUvbRP63iGOcMUKG/Xs0YKUCFmUCMH/eq6LJA4WHKfO9YBtOS+me
         NK7Zpk3bo+rhth8OGd+EC7LvSbLx7S2dlGjVUafJjl9dUjU0FSXRENmnrOh3c73La/Mg
         0DO3Pp9Ta9xP+mJWZ7c15UgB05H+2KP7neUnilHLS+GQVjaeo5761YXSRPrqzDlkaw0I
         A9kz5y8LaT5cal54imgmoAOPhgepM4ZGvsJbAlFYlTD1+k6+hNN6vtqXRmArm+OWO+JR
         1CEcP8OhDWBa/FquvNM+NHa2n7zu90Ntg0HnQynCca4Vi9mKvwDehoXx0tv5uxsnvbLH
         iIEg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/7JjTblNhrOT7ddFc6DYc9Elo4GMWeqXPs0CD72sryupwMtiFSTd8mDqidBtmD3zA+6TSGHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUXLF6+aXgoSoH1kqBAJrGq1s6UOepcOVaGfuyr3w+jn+/VEDC
	mlV1WzTehU7FDJjJgbzwKLu8TxOuG22T+HsK9RGndqIYX58C0YHqikiEbqN0g7DkPZ2MZfVf9Vm
	kdAr/egUlHHlNag==
X-Received: from qvcq11.prod.google.com ([2002:a05:6214:19eb:b0:904:58e5:9f88])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3115:b0:8cc:d29:9f78 with SMTP id 6a1803df08f44-908811af1f0mr3429956d6.11.1785858857490;
 Tue, 04 Aug 2026 08:54:17 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:54:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804155416.2168523-1-edumazet@google.com>
Subject: [PATCH net] ipvlan: inherit needed_headroom from phy_dev
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+1f9fd0f4b601cf88d6e6@syzkaller.appspotmail.com, 
	Tangxin Xie <xietangxin@h-partners.com>
Content-Type: text/plain; charset="UTF-8"

ipvlan devices inherit hard_header_len from phy_dev during ipvlan_init(),
but leave needed_headroom set to 0.

When the underlying phy_dev (or stacked lower device) requires extra headroom
for headers (e.g. macsec, ipsec, wireguard, tunnels, or veth with rx headroom),
upper layers calculating packet headroom via LL_RESERVED_SPACE(dev) fail to
reserve sufficient headroom.

This can result in reallocation failures, skb headroom underflows, or KASAN
slab-use-after-free crashes when dev_hard_header() / ipvlan_hard_header()
prepends header data.

Fix this by:
1. Inheriting needed_headroom from phy_dev in ipvlan_init().
2. Propagating needed_headroom updates to attached ipvlans in
   ipvlan_device_event() when receiving NETDEV_FEAT_CHANGE events.

Note that a similar issue exists in macvlan and will be handled in another
patch.

Fixes: 2ad7bfab3016 ("ipvlan: Initial check-in of the IPVLAN driver.")
Reported-by: syzbot+1f9fd0f4b601cf88d6e6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a720a21.40259c87.584f4.04bb.GAE@google.com/T/#u
Reported-by: Tangxin Xie <xietangxin@h-partners.com>
Closes: https://lore.kernel.org/netdev/CANn89i+1EW-sFNK8xoq98gMbPCeLS7e=+rs9gHfLg5Wj+4x0sw@mail.gmail.com/T/#mcc6307f115e500df23ea2980d5669fe95f20b6b4
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index ed46439a9f4eb1dd8bfaf6c83476ba4f2aff31bc..7513c005a5121676d3f8edb0898492ad434a9fab 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -146,6 +146,7 @@ static int ipvlan_init(struct net_device *dev)
 	dev->lltx = true;
 	netif_inherit_tso_max(dev, phy_dev);
 	dev->hard_header_len = phy_dev->hard_header_len;
+	dev->needed_headroom = phy_dev->needed_headroom;
 
 	netdev_lockdep_set_classes(dev);
 
@@ -773,6 +774,7 @@ static int ipvlan_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
 			netif_inherit_tso_max(ipvlan->dev, dev);
+			ipvlan->dev->needed_headroom = dev->needed_headroom;
 			netdev_update_features(ipvlan->dev);
 		}
 		break;
-- 
2.55.0.571.g244d577d93-goog

