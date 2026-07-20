Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DA438E8A8
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532386; cv=none; b=A3PQpBFcGTZnw1u5/4HiPuuJd4V/c868RDiQzYYJ1nY2tB0Zz4k+RuKlY5cSUS2JXFrTaNh1l4C9aTEWOrLs8qUnGotuPbDlqAx33uURWA5G77NylL/Unv7UZlFBU7FrEFnppcRP75Ew3pa7JWsBCa9S1Tw8Jj3IKREPOgZOC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532386; c=relaxed/simple;
	bh=7BNo5os90LSimEvpewHudBK5lQf975mDX9WhUlO9Gzk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KPwz1Fw0I4cwZDoJXWlh1tsHf+AOKuod1SqDVJwcIhX7xS5dr3i3zn389VJJUGTtmglz4GIlPLXL/lyiWnom6N86i64AfcJKMiK9HMbclEngCMOA3uChg+m2BQ93ujEQYOZSrPBly/JMTdXqcmFBNoOxgzO8tYdbpnePT+Vj5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O33Nc8EY; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O33Nc8EY"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92d1cae5740so896716985a.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 00:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784532384; x=1785137184; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0x6Y/T76mZpPCbDUsDJcvds+AUEJ3M3WuMJZGQ1AH80=;
        b=O33Nc8EYGlZXrcyKpNVC7d1bMQekJF+QN1aEmyXbqz87os3qqDllk4E4pgLgVzr7H0
         +8efo5eqJPHArqLSq/PBt9I/DK+Kq6KTs+U01Kn++pJeUZhIVWyHhBbb2T8zyvc6LVZE
         pGqODcRCOT2OFkjmhfarqEdAZSZWLQUdjbtvle5vtMOppRn9T944B380OhPh0DruBq9N
         IZEfB5J+90lyEE4j6seyhfFWXO2vjNzDcNjC3iwZ/g7B/8A5H9oFGDrZQrCT//ZVDtvI
         yE+Vc1ZcVSvFn2Gx5J5Ll0r7i90z/OkkPbPzDTAJX88JgN+73hraTo9rufLMSXg55ssy
         KDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532384; x=1785137184;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0x6Y/T76mZpPCbDUsDJcvds+AUEJ3M3WuMJZGQ1AH80=;
        b=BU6a/et3hd0ySDNlj3jehqGmgWfE6+/ldedWQrM7lX6IfOxqRZinL1KozzZq+8zapu
         Gg+dOdyPRuVyshxw9tE8gvIw+oxo3vNCO6o4n3xHn+571nrZboLcbKdYk1gt/QiRbvaG
         n2Fg5moecur5i8eX8ZutiHTQDe9/OLNLOEzAtjHfFYULtU0VO2Ldh1SQTlKh2OTUqHJE
         VBratAuv23jfjXNryPD4UTNO9p84er5zxw6HtYJZwJDqIQNmAWSp0AqVk2fpzB0g2HhC
         216mGaRU5XV7baVf3bpCbCS04BHDLYbTSky9BriufVGeGPZG3jzsQesPLALyZ4g+SXOh
         RpEg==
X-Forwarded-Encrypted: i=1; AHgh+Rryv3LMNgzEV838CTuiZh4FFlHKjRj7z7b1RFuj8eHvObkzCf2pHnVxYVkSe6NM9sP65jau6LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCnUzCj1oDpE/Le1oFwNUb5BVzCwH3hi6UrfY7snk8dbvCHVlc
	P+qhpRQAW9/jFhF+/11oDXNxPgG3/JDwsheFS6cIrqcVPsjY8qFREWF/cemSAzJoLeQcPpWPqWD
	iMiHk1DrBta/v5g==
X-Received: from qkbdx14.prod.google.com ([2002:a05:620a:608e:b0:92e:5859:219a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a0c3:10b0:930:b440:a63 with SMTP id af79cd13be357-930b440109cmr859432685a.80.1784532383688;
 Mon, 20 Jul 2026 00:26:23 -0700 (PDT)
Date: Mon, 20 Jul 2026 07:26:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720072622.3541873-1-edumazet@google.com>
Subject: [PATCH net] vlan: fix skb_under_panic() and races when toggling HW
 VLAN offload
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Tangxin Xie <xietangxin@h-partners.com>
Content-Type: text/plain; charset="UTF-8"

Toggling hardware VLAN TX offload (NETIF_F_HW_VLAN_CTAG_TX or
NETIF_F_HW_VLAN_STAG_TX) on a lower device invokes vlan_transfer_features(),
which dynamically changes vlandev->hard_header_len.

This causes two issues:
1. Lockless TX paths (e.g. packet_snd in af_packet.c, ip6_finish_output2)
   read dev->hard_header_len without holding RTNL lock. Mutating
   hard_header_len dynamically under RTNL creates a data race where upper
   layers reserve insufficient headroom based on a stale hard_header_len,
   resulting in skb_under_panic when vlan_dev_hard_header() is called.
2. In addition, vlan_transfer_features() updated hard_header_len without
   updating header_ops, causing a mismatch between allocated headroom
   and header creation.

A VLAN interface may require software VLAN header insertion at any point
(e.g., if reorder_hdr is disabled or HW offload is unavailable). Always
setting hard_header_len = real_dev->hard_header_len + VLAN_HLEN and using
vlan_header_ops unconditionally ensures sufficient headroom is reserved
by all upper layers and avoids any data race on hard_header_len during ETHTOOL
feature changes.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Tangxin Xie <xietangxin@h-partners.com>
Closes: https://lore.kernel.org/netdev/99d678ae-c7b2-4b44-b534-b8320679deb3@h-partners.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/8021q/vlan_dev.c | 34 +++-------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index ec2569b3f8dac629027b4344bc89402decf026d1..acf7f52d1eb2191ec0387dc29e2e9eb34124aa9d 100644
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
@@ -581,13 +561,8 @@ static int vlan_dev_init(struct net_device *dev)
 #endif
 
 	dev->needed_headroom = real_dev->needed_headroom;
-	if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)) {
-		dev->header_ops      = &vlan_passthru_header_ops;
-		dev->hard_header_len = real_dev->hard_header_len;
-	} else {
-		dev->header_ops      = &vlan_header_ops;
-		dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
-	}
+	dev->header_ops      = &vlan_header_ops;
+	dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
 
 	dev->netdev_ops = &vlan_netdev_ops;
 
@@ -1029,10 +1004,7 @@ static void vlan_transfer_features(struct net_device *dev,
 
 	netif_inherit_tso_max(vlandev, dev);
 
-	if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
-		vlandev->hard_header_len = dev->hard_header_len;
-	else
-		vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
+	vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
 
 #if IS_ENABLED(CONFIG_FCOE)
 	vlandev->fcoe_ddp_xid = dev->fcoe_ddp_xid;
-- 
2.55.0.229.g6434b31f56-goog

