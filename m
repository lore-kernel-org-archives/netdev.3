Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7007296BBC
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454516; cv=none; b=OX6zcYO0bxSsAk2kwVZ7107lV6ZATTTqWz67T815ueTCa6V6/Bj4ihoq+uoYfmUhYBrEL711kvVgypJnBOi9ZiW78SCAVRTJQ9EPthkOPLhk1rnnXzyNodUxoJSgkua5nZgFs0p3RFH6uGTEndJbb7sOGHeDI3Gw54GPswQuczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454516; c=relaxed/simple;
	bh=OrLryESLunSXgkQUHGbNnJiJ7iV2sfxorvYaKw+jD+A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hlelAcpJ6xAaBzdWPqS7X6kcl6H7NRlLRvzF7F4peT+0nTJWlBlemzi6ZwxYWWhFHmbddqmu2fMn2LDpZ0QiBjZpGqp3jaXCR9zZZ3jVV/v0IRpkqpInKn8KnuMx375Fl1h8aKscI3zoq8KS37yP6JWXp4cSeLzNTwu1jGDqXNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oVy0rMwj; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oVy0rMwj"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6H/lKvW0xrFpB8eqAylgVvg01v+ySBWnNVt860ap44k=;
	b=oVy0rMwjzBf+xJlcCX09t4rwFfP6gqyp09sT8R7sL/xNeKRv3uESJxL/l39f/3Vegh8gAwfRQ
	4d1FLTOgguCq2HFqD+B3LN17y/RWxY0zf1DIOApLH4Bhb4y3fxR1xriNi9R50FnrQkkmdDbJVUC
	chf5LXLeRoQyX4LD9YQRr30=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hKBp75S73z1cyQ2;
	Tue, 11 Aug 2026 21:11:11 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E4B24057A;
	Tue, 11 Aug 2026 21:21:47 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Aug 2026 21:21:47 +0800
Received: from localhost.localdomain (10.50.85.175) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Aug 2026 21:21:46 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <herbert@gondor.apana.org.au>
CC: <netdev@vger.kernel.org>, <zhangchangzhong@huawei.com>, Dong Chenchen
	<dongchenchen2@huawei.com>
Subject: [PATCH net] ipv4: icmp: reject non-unicast input routes in icmp_route_lookup
Date: Tue, 11 Aug 2026 21:30:37 +0800
Message-ID: <20260811133037.3344927-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200002.china.huawei.com (7.202.195.90)

When the forward output route cannot be used in icmp_route_lookup(),
it enters the "reverse path" and calls ip_route_input() on fl4_dec.daddr,
the original packet's source address.

ip_route_input() only returns an error for truly invalid packets. For
local, broadcast, multicast and unreachable addresses it still succeeds
and returns an input route whose dst.output is set to ip_rt_bug().  The
existing check only rejects RTN_LOCAL routes, so the other route types
can still be returned and later used for output, syzkaller triggering a
WARN_ON_ONCE() in ip_rt_bug() as bellow:

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

If the original source address is unroutable, ip_route_input() returns a
RTN_UNREACHABLE input route with err == 0, and the ICMP reply is then sent
through ip_rt_bug().

Only RTN_UNICAST input routes have dst.output set to ip_output() and are
safe to use for output.  Reject any input route that is not RTN_UNICAST.

Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 net/ipv4/icmp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 0caedfc7ca92..d58ac2f23f9f 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -584,12 +584,14 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 		 * At this point, fl4_dec.daddr should NOT be local (we
 		 * checked fl4_dec.saddr above). However, a race condition
 		 * may occur if the address is added to the interface
-		 * concurrently. In that case, ip_route_input() returns a
-		 * LOCAL route with dst.output=ip_rt_bug, which must not
-		 * be used for output.
+		 * concurrently, or if fl4_dec.daddr is otherwise unroutable.
+		 * In that case, ip_route_input() returns an input route
+		 * (RTN_LOCAL, RTN_BROADCAST, RTN_UNREACHABLE or
+		 * RTN_MULTICAST) with dst.output set to ip_rt_bug(), which
+		 * must not be used for output.
 		 */
-		if (!err && rt2 && rt2->rt_type == RTN_LOCAL) {
-			net_warn_ratelimited("detected local route for %pI4 during ICMP sending, src %pI4\n",
+		if (!err && rt2 && rt2->rt_type != RTN_UNICAST) {
+			net_warn_ratelimited("detected unusable input route for %pI4 during ICMP sending, src %pI4\n",
 					     &fl4_dec.daddr, &fl4_dec.saddr);
 			dst_release(&rt2->dst);
 			err = -EINVAL;
-- 
2.25.1

