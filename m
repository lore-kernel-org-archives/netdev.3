Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F141D121
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438370; cv=none; b=lgmralpktHuFMlro3k4bhc9cjI8VhXJiUImHUcVFfUKJGRNKNS43GNIItncvmNCoocJti1jQG1NhNhYiChWQrNjzn8ywFMvduZR7dPg+Jb2k1HwgfJT9FAlB4JF+YVLy4HtHOEYo+lGuR6yZ8DjM197cmhtkDUZ8ZfeJjKL2s94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438370; c=relaxed/simple;
	bh=hoXQO2oTJ5Cc03aQnP5DAu5QILFMIN3kcNZ3LumNcCU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JMIb4voCaAJDSDtfKlntRmpTAUN12XiiJJy6efkLryrEnCMuR5LEUiLJG9e4Zz6PXq5vjBeysoKYQ4EFZIWIYU18dMgLkAKGrNvG07u/AF8TApclNxTfBzaDE3fedqAZH7jv8mMSS0DMQSLxhfnN+9+8KtCfujOXfbpwm45rOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bL69Loft; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bL69Loft"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e695a3b28so77078085a.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 01:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786438368; x=1787043168; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8h75iphs+jLyjLv6gqZb1nj8tBrO0oNpLde5I5yjDTY=;
        b=bL69LoftAXKUY248pZx/bUMsuucxnWGW42h6t2iNPGuoJ6fB3bzFPubfPwT57qv+EW
         2FawPYt5cFQ9gp72eXwswLp14tfyZ+YtqEjSIZN4AMbqDJx3FjIiOhdFusvGBs5F1ZFZ
         G1Xttxu4toOP1zTPUQQTGQPqpGxrkYMx48TMyCoATGbhnnRTDSFkcBv6fqEil1ip3Pbe
         aEJ1cH7mPboraqXaJE79eJuGk12RHYxeNFD8DSZqrJRfgdVHgfiqLKhsoZt6qY1gcbD6
         XXNkF7JTolxmksyd5pVdzEFv9lNxLkXbZSYpRfVAKR9cdz85h2f5C/EjqpBBvrpfk67o
         dpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438368; x=1787043168;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8h75iphs+jLyjLv6gqZb1nj8tBrO0oNpLde5I5yjDTY=;
        b=VaSN3dSA5q79z5LEDsRoRJARy3fI0utHU0mMTRIOsLcniNugCk1/n2HjjDMwyop45l
         h/14MViW2NDRNB1IP6waz/AjteNtk0dEMM3ue1X1QT81awYqI1QbKzfCvYWzjrKlmE5E
         SlCOMPgyLQV3fA5pWtd8NHlCWkyfwixsUdn1Nqb8LyIeg/UmF+xyaLce7/Eegu0yOQMu
         hbjnZfUucDZpvkAySEYWAmZBiM8XctgqF2L+sbfgcoTr75FLSIU8yDym/M9vD1cfuXlZ
         0lmNvZQA93HJjclCkiVRQoVd4SFuy9h5KgRb7e+HlrJ0nQGbuM73YRH9/aw/ttaPp+de
         WuGg==
X-Forwarded-Encrypted: i=1; AHgh+RoLciouNwmzQHyF4zB33t60QREJ+LUTRbjl46XpxoJzNb0AgBY5kFiP19kYR7Qm6WTiv6sG0lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIYfdL/I3ZRGjbiG+PExOInspXSBo78U29AoF3RBO+CaafXgiz
	OXa3UAf8rzzVpJGNAdwgGZ8i9oskWvq7pBwI+hNJc7Fco8G9ZNVEtHXzn6eksSlU/JmgEU2a9+h
	cwFWLA57z7eXzxA==
X-Received: from qkpr2.prod.google.com ([2002:a05:620a:2982:b0:915:6649:4998])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2a12:b0:934:b798:c245 with SMTP id af79cd13be357-936a9448a95mr79342885a.16.1786438367846;
 Tue, 11 Aug 2026 01:52:47 -0700 (PDT)
Date: Tue, 11 Aug 2026 08:52:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811085246.2267779-1-edumazet@google.com>
Subject: [PATCH v3 net] vlan: fix skb_under_panic and races when toggling HW
 VLAN offload
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Tangxin Xie <xietangxin@h-partners.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Toggling hardware VLAN TX offload (NETIF_F_HW_VLAN_CTAG_TX or
NETIF_F_HW_VLAN_STAG_TX) on a lower device invokes vlan_transfer_features(),
which dynamically changed vlandev->hard_header_len.

This causes two issues:
1. Lockless TX paths (e.g. packet_snd in af_packet.c, ip6_finish_output2)
   read dev->hard_header_len without holding RTNL lock. Mutating
   hard_header_len dynamically under RTNL creates a data race where upper
   layers reserve insufficient headroom based on a stale hard_header_len,
   resulting in skb_under_panic when vlan_dev_hard_header() is called.
2. In addition, vlan_transfer_features() updated hard_header_len without
   updating header_ops, causing a mismatch between allocated headroom
   and header creation.

Always setting dev->hard_header_len = real_dev->hard_header_len and
dev->needed_headroom = real_dev->needed_headroom + VLAN_HLEN unconditionally
ensures:
- dev->hard_header_len remains 100% static and immutable at real_dev->hard_header_len,
  eliminating all dynamic runtime updates and data races on hard_header_len.
- Upper layers allocating skbs via LL_RESERVED_SPACE() will always reserve
  sufficient headroom for software VLAN tag insertion (real_dev->hard_header_len +
  real_dev->needed_headroom + VLAN_HLEN).
- vlandev inherits real_dev->needed_tailroom so underlying trailer/padding/ICV
  requirements are honored.
- AF_PACKET SOCK_RAW network header offsets remain correctly aligned at
  real_dev->hard_header_len.
- vlan_header_ops is used unconditionally.

Note to stable teams: Make sure to backport these commits:

e16e960d55a4 ("ipvlan: inherit needed_headroom and needed_tailroom from phy_dev")
cef51860becd ("macvlan: inherit needed_headroom and needed_tailroom from lowerdev")

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Tangxin Xie <xietangxin@h-partners.com>
Closes: https://lore.kernel.org/netdev/99d678ae-c7b2-4b44-b534-b8320679deb3@h-partners.com/
Cc: <stable@vger.kernel.org> # 3.19: e16e960d55a4: ipvlan: inherit needed_headroom and needed_tailroom from phy_dev
Cc: <stable@vger.kernel.org> # 3.19: cef51860becd: macvlan: inherit needed_headroom and needed_tailroom from lowerdev
Cc: <stable@vger.kernel.org> # 3.19
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v3: propagate needed_tailroom, add stable tags.
v2: https://lore.kernel.org/netdev/20260724035419.1473174-1-edumazet@google.com/

 net/8021q/vlan_dev.c | 39 +++++++--------------------------------
 1 file changed, 7 insertions(+), 32 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index ec2569b3f8dac629027b4344bc89402decf026d1..2859cbac3f266b7c4e3f44f41280d33ab69c5270 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -502,26 +502,6 @@ static const struct header_ops vlan_header_ops = {
 	.parse_protocol = vlan_parse_protocol,
 };
 
-static int vlan_passthru_hard_header(struct sk_buff *skb, struct net_device *dev,
-				     unsigned short type,
-				     const void *daddr, const void *saddr,
-				     unsigned int len)
-{
-	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
-	struct net_device *real_dev = vlan->real_dev;
-
-	if (saddr == NULL)
-		saddr = dev->dev_addr;
-
-	return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
-}
-
-static const struct header_ops vlan_passthru_header_ops = {
-	.create	 = vlan_passthru_hard_header,
-	.parse	 = eth_header_parse,
-	.parse_protocol = vlan_parse_protocol,
-};
-
 static const struct device_type vlan_type = {
 	.name	= "vlan",
 };
@@ -580,14 +560,10 @@ static int vlan_dev_init(struct net_device *dev)
 	dev->fcoe_ddp_xid = real_dev->fcoe_ddp_xid;
 #endif
 
-	dev->needed_headroom = real_dev->needed_headroom;
-	if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)) {
-		dev->header_ops      = &vlan_passthru_header_ops;
-		dev->hard_header_len = real_dev->hard_header_len;
-	} else {
-		dev->header_ops      = &vlan_header_ops;
-		dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
-	}
+	dev->needed_headroom = real_dev->needed_headroom + VLAN_HLEN;
+	dev->needed_tailroom = real_dev->needed_tailroom;
+	dev->header_ops      = &vlan_header_ops;
+	dev->hard_header_len = real_dev->hard_header_len;
 
 	dev->netdev_ops = &vlan_netdev_ops;
 
@@ -1029,10 +1005,9 @@ static void vlan_transfer_features(struct net_device *dev,
 
 	netif_inherit_tso_max(vlandev, dev);
 
-	if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
-		vlandev->hard_header_len = dev->hard_header_len;
-	else
-		vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
+	vlandev->needed_headroom = dev->needed_headroom + VLAN_HLEN;
+	vlandev->needed_tailroom = dev->needed_tailroom;
+	vlandev->hard_header_len = dev->hard_header_len;
 
 #if IS_ENABLED(CONFIG_FCOE)
 	vlandev->fcoe_ddp_xid = dev->fcoe_ddp_xid;
-- 
2.55.0.679.g6767b8d81c-goog

