Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE749219D
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437326; cv=none; b=HX2h49hOdNwe6MbiZzP+YWIIrC/nbsw9CE0xg+TM1Ynecyw8drYmCyU9z0iXP7d4oaAGHD5f0aF7/Ped3ip46Jubqblue54lGVtLZdaV1Ee59Oc5kkaD2/IPELzQ+SffU+9yXw0cFkAhQNjtow/ylWMd0AZm7o+9GQImb73Kz50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437326; c=relaxed/simple;
	bh=3HT21EKjEC84ISx8TeY3/TshfcqtWZSXY6q3l5LDpA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D2opRoqceOYlyWum4YhfWl8hCVOlNO/Kl9VYoU3b2HH4BO2A47OXVWO7PzNYSA/dZfs/DCVZbcm3+RBKfMHAXvN2YX38zngfYntXHiUkosqbxyHt8qyUXWBvIvW/yESuIPzZMauR+54NirCBvsELeSbMZEDF8HjTzhkxrwAts3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TyQRo5kn; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TyQRo5kn"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-933023a5980so504678085a.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788437324; x=1789042124; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lk0+Q6hMtOKZcsh1EUAVE+I7/l7qpGkOYE9jwGLdbkM=;
        b=TyQRo5knFV5EUjSOz70qNbN1XqAiMhgzZoWONgdPyOV2ijPquWDN5TyqSftcUWhRvs
         cF+V95NYvwYg6r8PgHz4+NXACiA18aorShTr06D7U8s2hnxyeNKa3NjbBzgkDiXKlYzO
         VGNgY/J60KZ49Hp2ewwA4944zr93q7tPvXATZdqBTCjdp2BHx00xlxqD0IBZz26Q2Kie
         vq30aACaQV+AtpUevq3XqKwMKyvHm6NjOXMWvMyaluar0rI/5w+8JVM937YCt7nWE9tp
         V9YjlG2P/CQ12PW+utMu5farHTS2wTrBcAUNBrLjbj9qxRxQIdyUbQZWGhnfm7rQ61c+
         7x9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437324; x=1789042124;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lk0+Q6hMtOKZcsh1EUAVE+I7/l7qpGkOYE9jwGLdbkM=;
        b=hswWVqLa9uK7gXpozYvwXIl14s5jcVXci0F9N91971wHkMGv7uLRqXc2Fhv4jGjdww
         ogXNbtB/+iAClZmJTFyw/x7d461sTRmXa7CxEfXa024rxm1lKvV1DSYWnzl8sVBL5TwR
         upOT0lx/vu6xAzoqfvHahJkOrabvEeEeQY7c7m2w6mAb1iRwzrf2VMzS/dZeBVnAu4wH
         4YniXKqvFtwnOAHo5oAbywo7pgjurWeJXRp8xfU63zUisvVv5dLu5V7Pdmw2eJ4VcoLr
         yFQSi19cnGzHu3fraiDw0O4vl0TJKF+EsB0QcGv1FLQ5Yw0iq7JZOxa4n4y6ENY/vXXW
         srzw==
X-Forwarded-Encrypted: i=1; AKwUvBxYrBslVSA4w9zQOsSc/Y1pxZlaY7pFc6RJocJtmvxugp7CRSjVAr7a2Ad7i4NKam/1J+rQZNs=@vger.kernel.org
X-Gm-Message-State: AFuF++nH3SR88RTvn5IGIkG7i1T1CncWzKZ66yIpIe9melUDQZJsMrzx
	zqOiPqXCF6xgl9PNu4plDAksSGgz7ofok2+WCBm1ZnUUI66w8ApA9XTNbeYoSX9HQd5PWDIwUiO
	xzqwbxERieabtRA==
X-Received: from qknuo16-n2.prod.google.com ([2002:a05:620a:6310:20b0:936:c016:504d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:d8c:b0:92e:ef09:f8f3 with SMTP id af79cd13be357-93960c91ccemr1343874785a.2.1788437323089;
 Thu, 03 Sep 2026 05:08:43 -0700 (PDT)
Date: Thu,  3 Sep 2026 12:08:32 +0000
In-Reply-To: <20260903120840.1024153-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903120840.1024153-2-edumazet@google.com>
Subject: [PATCH net-next 1/9] vxlan: initialize _md in vxlan_xmit_one()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

If a VXLAN device is configured with both VXLAN_F_COLLECT_METADATA and
VXLAN_F_GBP, and a packet is transmitted through it using an external
ip_tunnel_info that lacks the IP_TUNNEL_VXLAN_OPT_BIT flag, md is left
pointing to the uninitialized _md stack variable:

		if (test_bit(IP_TUNNEL_VXLAN_OPT_BIT, info->key.tun_flags)) {
			if (info->options_len < sizeof(*md))
				goto drop;
			md = ip_tunnel_info_opts(info);
		}

Because IP_TUNNEL_VXLAN_OPT_BIT is not set, md is not updated and remains
pointing to _md. Later, vxlan_build_skb() is called with md, which
eventually calls vxlan_build_gbp_hdr():

	if (vxflags & VXLAN_F_GBP)
		vxlan_build_gbp_hdr(vxh, md);

Inside vxlan_build_gbp_hdr(), md->gbp is read:

	if (!md->gbp)
		return;
	gbp = (struct vxlanhdr_gbp *)vxh;
	...
	if (md->gbp & VXLAN_GBP_DONT_LEARN)
		gbp->dont_learn = 1;

If the stack contains garbage, this causes:
1) VXLAN_HF_GBP flag to be spuriously set in the VXLAN header.
2) gbp->dont_learn and gbp->policy_applied to be set from stack bits.
3) gbp->policy_id to receive 16 bits of uninitialized kernel stack data,
   leaking it onto the wire.

Fix this by zero-initializing _md. If IP_TUNNEL_VXLAN_OPT_BIT is not
present, md->gbp remains 0, and vxlan_build_gbp_hdr() returns early
without modifying the VXLAN header.

Fixes: ee122c79d422 ("vxlan: Flow based tunneling")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 459f19f7071e5bafe9e4c57ef8819645c3da7121..6d886b6f2dc1d62f0eb26c9ba310c4feaed9cafd 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2362,7 +2362,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	struct ip_tunnel_key key;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	const struct iphdr *old_iph;
-	struct vxlan_metadata _md;
+	struct vxlan_metadata _md = {};
 	struct vxlan_metadata *md = &_md;
 	unsigned int pkt_len = skb->len;
 	__be16 src_port = 0, dst_port;
-- 
2.55.0.970.g62bdec98f9-goog

