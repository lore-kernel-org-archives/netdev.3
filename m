Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156D3D9DB1
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650623; cv=none; b=eLeOmHJDEN37bEuQFMt+O0h5TRRu9x1rsQfgIhV9CeRUu3qY7BsQakZX53HuE4gBY/jZCVJloj7Pg4sHa80JP8NaqlBVU9BHdsonreZyG8b3JjQmUMDcvj36EZfKbmgMnJS5AzNN6irIBSkiH7LAkRsmMo2YC503iRPyAhQZfXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650623; c=relaxed/simple;
	bh=Xglf5FE+8Rt8nGlLhWHDfoV8ey79pOok1vvMISLr+pY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X9iU4qj1YUWrn1oNUOrRZWD+JNoMk+M+nhjy4u5Rk7r1YCscq2cm0Vi62fhTme9eYeOrVea17MqVhaPKBJUvxVsrJ2vxKPt4umYQ1NXXoh/d6tRvg3LuulvN7xkqmD/7S3G1F72U7y6aiqKyTcalv5cYtfFS+T+bsQdBG8QwJ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uAnF4C3t; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uAnF4C3t"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RSNxJ21s4/P8k8rWp2B6fntRNm/PG2x/fX4BNACTwvs=;
	b=uAnF4C3tYF7ZkfpeYTO3AtKEgZk3aXqnBpnw0Wr/jb8AAouO1vy/kFkT3Y9XjR1+RPkRzBZVa
	RWstoXzld3lUeqefh+WDe98ZBLvaYe1ovLFyQO2Bx0TVruke/obh5TmsfgxDp4wgkip1uSEkHaF
	Qw/oWsjR3I/sKqGv3oJwp6A=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hTj7r52D1z1prM0;
	Tue, 25 Aug 2026 17:26:00 +0800 (CST)
Received: from whupemk200012.china.huawei.com (unknown [7.152.185.169])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BE5C4058C;
	Tue, 25 Aug 2026 17:36:47 +0800 (CST)
Received: from localhost.localdomain (10.50.85.175) by
 whupemk200012.china.huawei.com (7.152.185.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 17:36:46 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <herbert@gondor.apana.org.au>
CC: <netdev@vger.kernel.org>, <zhangchangzhong@huawei.com>, Dong Chenchen
	<dongchenchen2@huawei.com>
Subject: [PATCH net v3] ipv4: icmp: reject RTN_UNREACHABLE input routes in icmp_route_lookup
Date: Tue, 25 Aug 2026 17:45:23 +0800
Message-ID: <20260825094523.1461020-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk200012.china.huawei.com (7.152.185.169)

When the forward output route cannot be used in icmp_route_lookup(),
it enters the "reverse path" and calls ip_route_input() on fl4_dec.daddr,
the original packet's source address.

ip_route_input() only returns an error for truly invalid packets. For
unreachable addresses it will succeed and return an input route whose
dst.output is set to ip_rt_bug(). The existing check only rejects
RTN_LOCAL routes, so the RTN_UNREACHABLE route types can still be returned
and later used for output, syzkaller triggering a WARN_ON_ONCE()
in ip_rt_bug() as bellow:

 ------------[ cut here ]------------
 WARNING: net/ipv4/route.c:1273 at ip_rt_bug+0x14/0x20
 RIP: 0010:ip_rt_bug+0x14/0x20
 Call Trace:
  ip_push_pending_frames+0xfa/0x100
  __icmp_send+0x905/0xf10
  ip_options_compile+0xc0/0xd0
  ip_rcv_finish_core+0x321/0xae0
  ip_rcv+0x1de/0x260
  __netif_receive_skb_one_core+0x11a/0x130
  netif_receive_skb+0x7b/0x260
  tun_get_user+0x11bf/0x1c10
 ------------[ cut here ]------------

Reject input route that is RTN_UNREACHABLE to fix it.

Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
v2:
- RTN_UNICAST judgement will reject bforward packet. Only reject RTN_UNREACHABLE
v3:
- Modify the comments to make them more accurate.
- RTN_UNREACHABLE dont need warn log. 
---
 net/ipv4/icmp.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 0caedfc7ca92..7350f0380be1 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -581,16 +581,15 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 		skb_dstref_restore(skb_in, orefdst);
 
 		/*
-		 * At this point, fl4_dec.daddr should NOT be local (we
-		 * checked fl4_dec.saddr above). However, a race condition
-		 * may occur if the address is added to the interface
-		 * concurrently. In that case, ip_route_input() returns a
-		 * LOCAL route with dst.output=ip_rt_bug, which must not
-		 * be used for output.
+		 * At this point, fl4_dec.daddr should NOT be local (the
+		 * address can be added to the interface concurrently) or unroutable.
+		 * In that case, ip_route_input() returns a LOCAL or UNREACHABLE
+		 * route with dst.output=ip_rt_bug, which must not be used for output.
 		 */
-		if (!err && rt2 && rt2->rt_type == RTN_LOCAL) {
-			net_warn_ratelimited("detected local route for %pI4 during ICMP sending, src %pI4\n",
-					     &fl4_dec.daddr, &fl4_dec.saddr);
+		if (!err && rt2 && (rt2->rt_type == RTN_LOCAL || rt2->rt_type == RTN_UNREACHABLE)) {
+			if (rt2->rt_type == RTN_LOCAL)
+				net_warn_ratelimited("detected local route for %pI4 during ICMP sending, src %pI4\n",
+						     &fl4_dec.daddr, &fl4_dec.saddr);
 			dst_release(&rt2->dst);
 			err = -EINVAL;
 		}
-- 
2.25.1

