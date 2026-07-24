Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB223909C
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 03:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784865263; cv=none; b=WdQjTJJZFaaJSbk7K5VY0PwrAJcBpCedeAaTiGA81Bt8qDSB7r1tMrBOnBBDex5Ki5OCjtTcU3IddAq6qp6eeg0TzWCsDh7mAJQUtsKa3qFyZMHfj0BnkB5vqOnpTmkJBRevYt4WvHvStzuuVZWA353lKwA+kRV4maySDe0LB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784865263; c=relaxed/simple;
	bh=UnVD8bdQfRsWJuvziXY4OYczj7ZRLcEygES82GgHMas=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Id5d8GdtkP+LVc5RdVFxTotC6ecCAndaoM0n3MW4ylb/HfY+8N+/YgYnu+Ch6txipQ7WAfCIrpZh2pOpoaLpoJSkf0dh0EPD93sNlzTK34fQdPFUhlMCXn3KY5bID56AwX/IlUnKeUtZ4yKyN5g2YMybjjeYul11vknKR2WKWvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TLoBTFB/; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TLoBTFB/"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9309af14fd7so226805085a.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 20:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784865261; x=1785470061; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=38U7fA9r0hG0hZ6cZcbTDu+o4F77ZMDOdjIUvbpxuNA=;
        b=TLoBTFB/TDrR5vb+qSIL1isEuIWjO72e08SAqZC6cs27U8sXyHiGjbARCNDqzfzaD8
         O0igNHdUGV0VBRsKz86XdqEBZDVoGJCwKP1xA/WS8WxRfji4suTguGMdoLYRVTSgNvwd
         BPyzzuRficg0sBE0vwjl9uMkzEHiArG0sAP2VxzviY4fdpx5OsUQW/b/RY6neLE5F1X0
         xK7K4WnpqG9myAc2cWj7LXkR7yohgrGIS7ZWJXT7qISFt8EOv5LGrdMRHdJPWm9RQlFt
         5Fn0SHw/SUiq7BeVkMCbdhOxEQcI0Aw3xFms1gyV27iGXSbTWVxB2ZVX/Pe0hfwsRQof
         h39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784865261; x=1785470061;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=38U7fA9r0hG0hZ6cZcbTDu+o4F77ZMDOdjIUvbpxuNA=;
        b=JDOhYKL0/YtOo8Yj0h7G9RfgLYIpXw6XHAhLTecRMY+MksE9JJ6D7fu/NfsjuIaHsV
         NlIf4gMcn0OFu0QRcSI3JSG2Sjd0smJA/hwtbQdefpv7pQcJqhvO9JoSSP6by/ChGBbo
         g8F0Vq+2+V+yDaPlcH6VzEUQl7oThcQMwJRxA0wzl9V7b5BELuvFuPMu5F+HI2whFJw8
         QIz7JcgVABJem2SrzVc48pzHkEimWBTuoMRKjsPi/B4R4o96dWovhLA0GgyKv3bDgV1m
         um0uK98xaIBJDOkvHd8X6LiVDaNSK0rMFPS0+m0P3rzYCMdEQCoLv51i5/SGCQbltS1u
         oRSQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZIg857biGNFW+pmTy1oQV70fKz/S6j00IDNyRTpktnAunVPBqBLGyuiU8RJ8/JhfXwTwa1W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfWC2fatn5tmTDX5/W9sA5E0/7GHvIGoBhqvGh/Kf8K4qx5uJe
	YC/n4WLfgHULeRVQDOfoq9Fb9xD16Au3lKxSMlRTKtXAH33wrfAe24nVuyOZJ8UyQC9nCZSC+ir
	+0QSSEGFBdcoq3A==
X-Received: from qkgv19.prod.google.com ([2002:a05:620a:a93:b0:92e:66f4:e7fb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4706:b0:92b:6805:9197 with SMTP id af79cd13be357-93103910d40mr664204585a.63.1784865260478;
 Thu, 23 Jul 2026 20:54:20 -0700 (PDT)
Date: Fri, 24 Jul 2026 03:54:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724035419.1473174-1-edumazet@google.com>
Subject: [PATCH v2 net] vlan: fix skb_under_panic and races when toggling HW
 VLAN offload
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Tangxin Xie <xietangxin@h-partners.com>
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
- AF_PACKET SOCK_RAW network header offsets remain correctly aligned at
  real_dev->hard_header_len.
- vlan_header_ops is used unconditionally.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Tangxin Xie <xietangxin@h-partners.com>
Closes: https://lore.kernel.org/netdev/99d678ae-c7b2-4b44-b534-b8320679deb3@h-partners.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: apply the VLAN_HLEN provision on needed_headroom
v1: https://lore.kernel.org/netdev/20260723092203.5b1470f5@kernel.org/T/#t

 net/8021q/vlan_dev.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index ec2569b3f8dac629027b4344bc89402decf026d1..aaf2051a434cfef30d52e0434a9c372142f49195 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -502,26 +502,6 @@ static const struct header_ops vlan_header_ops = {
	.parse_protocol = vlan_parse_protocol,
 };

-static int vlan_passthru_hard_header(struct sk_buff *skb, struct net_device *dev,
-					 unsigned short type,
-					 const void *daddr, const void *saddr,
-					 unsigned int len)
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
@@ -580,14 +560,9 @@ static int vlan_dev_init(struct net_device *dev)
	dev->fcoe_ddp_xid = real_dev->fcoe_ddp_xid;
 #endif

-	dev->needed_headroom = real_dev->needed_headroom;
-	if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)) {
-		dev->header_ops 	 = &vlan_passthru_header_ops;
-		dev->hard_header_len = real_dev->hard_header_len;
-	} else {
-		dev->header_ops 	 = &vlan_header_ops;
-		dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
-	}
+	dev->needed_headroom = real_dev->needed_headroom + VLAN_HLEN;
+	dev->header_ops 	 = &vlan_header_ops;
+	dev->hard_header_len = real_dev->hard_header_len;

	dev->netdev_ops = &vlan_netdev_ops;

@@ -1029,10 +1004,8 @@ static void vlan_transfer_features(struct net_device *dev,

	netif_inherit_tso_max(vlandev, dev);

-	if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
-		vlandev->hard_header_len = dev->hard_header_len;
-	else
-		vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
+	vlandev->needed_headroom = dev->needed_headroom + VLAN_HLEN;
+	vlandev->hard_header_len = dev->hard_header_len;

 #if IS_ENABLED(CONFIG_FCOE)
	vlandev->fcoe_ddp_xid = dev->fcoe_ddp_xid;
--
2.55.0.229.g6434b31f56-goog

