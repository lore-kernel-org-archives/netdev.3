Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794295333;
	b=P31w3PjrSqPT4n/4eI6gjA4FxeHM4j9riktLXoARGsuCRqR88VlnKfDEwNzA3HEOf2LO
	 VjRwDbm2Jq+nDlPQ7vvFDj5vduPmbq243P9y7tN168h/09NyV6Mn07rQ9LdkOUwZbDXCw
	 QsSMah2uCJUA3BSQyeGlneqlLyYmj3DIdEans4fjMmnglUvggugN5Mi6on2WsTwLvqSdY
	 cwNNy5V8h7MKuy/7fhSkSmxtztYM+C3TVrZIvhjduYyKtM8F4hH8Sc26UYfI2hPSquNoZ
	 ANMDL2Uh0maC1nPneAa/cwUYsrH4UJUscXJDwUgv6Qgat5uxOduxmUBnq3QFYe/q2zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295333;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zja2eMNGFiEkBZuH4kjMHFhhzIaxVJH4a94KyNvHTDk=;
	b=X5Z9o7MHTKZlCxJby+e15zdNNPklFb3DbXB9PgSCxUJFeNTMZG3fSSvGrlzlVOZSUUEI
	 34EphU0iDaniw3nskdfTJlm/+oj9v2R98zlYwb6U2dPUj1+oZBEhAENv8npVvafdz15JO
	 pvavwJCvAcIkPzkkqsi2UpkrQ+594hhF8oDhLsReoXMBNJ05IByWD/L8JGLx9MIC4stiT
	 AcT5J7JmGxgBk6+uSvu8upzVioZuTJdGKJ0zfXzlVQVCkeApXVECCk/8fyVQWInmFjtqX
	 mHCJxkbFkUEkOZ6C8BgIlV+oe/mqnBs7/psA7P7+icxK7DHJbWRk66GEtGa9E50rqNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zto+oPJQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2FB606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zto+oPJQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BB11F0089F;
	Tue, 10 Nov 2026 07:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794295332;
	bh=zja2eMNGFiEkBZuH4kjMHFhhzIaxVJH4a94KyNvHTDk=;
	h=From:To:Cc:Subject:Date;
	b=Zto+oPJQ1+a6Qg95BBg0sfY4N6K1Bts7Uchj9COTnSq4Sc51Nid7AEPcXpS4wFjX1
	 gzmVzD6oDdEq4lIfB09KAo+8awCwAToWjl9AtMGOBc13WtBR2oG/Gs6ol8PMP+0+Cr
	 YHAj2wGrOtav9dNIAFVEjpidDrYeWLzi2uYHykiHxqEEoXzov0PiY082QTlp+SEIi0
	 DhmzHKhKhe0hxvrsFL9bIcH7/IKZLZf8ZRemfqXkpeAuVb/L1GhGiip2wvZTbEv+Zh
	 0c812A/cRLfxSDiGayDYh2z3xzVJmZUlvuFv6HfYQMxhK9+NJjIU3fUgnWLl78T0xv
	 6C/bFLFA+XSeg==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net] vxlan: annotate lockless accesses to rdst->remote_ifindex
Date: Tue, 10 Nov 2026 08:22:08 +0100
Message-ID: <20261110072208.3273638-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_fdb_replace() can update rd->remote_ifindex in place while
the destination entry is visible to concurrent lockless RCU readers:

- vxlan_fdb_info() reads rdst->remote_ifindex during RCU-protected
  FDB dumps and gets.
- vxlan_fdb_switchdev_notifier_info() reads rd->remote_ifindex from
  vxlan_fdb_find_uc().
- vxlan_snoop() reads rdst->remote_ifindex on the RX path.
- vxlan_xmit_one() reads rdst->remote_ifindex on the TX path.

Annotate these accesses with READ_ONCE() and WRITE_ONCE().

Fixes: 906dc186e020 ("vxlan fdb replace an existing entry")
Fixes: 87613de95041 ("vxlan: fix snooping for link-local IPv6 addresses")
Fixes: 49f810f00fa3 ("vxlan: allow multiple VXLANs with same VNI for IPv6 link-local addresses")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Cc: Andrew Lunn <andrew+netdev@lunn.ch
---
 drivers/net/vxlan/vxlan_core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d11028b374721c9f4691254edb61a55c679fd2f2..13bfb1bb11b7be4d4e224d7f892c960512301b2e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -215,6 +215,8 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 		if (nla_put_u32(skb, NDA_NH_ID, nh_id))
 			goto nla_put_failure;
 	} else if (rdst) {
+		u32 remote_ifindex;
+
 		if (send_ip && vxlan_nla_put_addr(skb, NDA_DST,
 						  &rdst->remote_ip))
 			goto nla_put_failure;
@@ -226,8 +228,9 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 		if (rdst->remote_vni != cfg->vni &&
 		    nla_put_u32(skb, NDA_VNI, be32_to_cpu(rdst->remote_vni)))
 			goto nla_put_failure;
-		if (rdst->remote_ifindex &&
-		    nla_put_u32(skb, NDA_IFINDEX, rdst->remote_ifindex))
+		remote_ifindex = READ_ONCE(rdst->remote_ifindex);
+		if (remote_ifindex &&
+		    nla_put_u32(skb, NDA_IFINDEX, remote_ifindex))
 			goto nla_put_failure;
 	}
 
@@ -300,7 +303,7 @@ static void vxlan_fdb_switchdev_notifier_info(const struct vxlan_dev *vxlan,
 	fdb_info->remote_ip = rd->remote_ip;
 	fdb_info->remote_port = rd->remote_port;
 	fdb_info->remote_vni = rd->remote_vni;
-	fdb_info->remote_ifindex = rd->remote_ifindex;
+	fdb_info->remote_ifindex = READ_ONCE(rd->remote_ifindex);
 	memcpy(fdb_info->eth_addr, fdb->key.eth_addr, ETH_ALEN);
 	fdb_info->vni = fdb->key.vni;
 	fdb_info->offloaded = rd->offloaded;
@@ -569,7 +572,7 @@ static int vxlan_fdb_replace(struct vxlan_fdb *f,
 	rd->remote_ip = *ip;
 	rd->remote_port = port;
 	rd->remote_vni = vni;
-	rd->remote_ifindex = ifindex;
+	WRITE_ONCE(rd->remote_ifindex, ifindex);
 	rd->offloaded = false;
 	return 1;
 }
@@ -1470,7 +1473,7 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
 
 		if (likely(vxlan_addr_equal(&rdst->remote_ip, src_ip) &&
-			   rdst->remote_ifindex == ifindex))
+			   READ_ONCE(rdst->remote_ifindex) == ifindex))
 			return SKB_NOT_DROPPED_YET;
 
 		/* Don't migrate static entries, drop packets */
@@ -2442,7 +2445,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		addr_family = cfg->saddr.sa.sa_family;
 		dst_port = rdst->remote_port ? rdst->remote_port : cfg->dst_port;
 		vni = (rdst->remote_vni) ? : default_vni;
-		ifindex = rdst->remote_ifindex;
+		ifindex = READ_ONCE(rdst->remote_ifindex);
 
 		if (addr_family == AF_INET) {
 			key.u.ipv4.src = cfg->saddr.sin.sin_addr.s_addr;
-- 
2.53.0

