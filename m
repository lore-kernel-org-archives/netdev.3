Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390352;
	b=Mv8D1B+x8t7L8FaaZrakdKmgocpPz41Z7bEKLpYxuuRioBje8iDlqrqJaQrI7PY2zvpQ
	 oO1e6QNtFRisH61QIDNx2GXecnfLaz3MXonN6ZE27TogiWvGV3uEXXFkIyHdwsnxKCBtW
	 F7FXFv8N1VpSkgR83tUmgmq6IhacoqOTJ9tHYNEi47AIpy/iOFLTSKzvU6rngF1SfjLvY
	 Y8jujtklrBcghbKa9WYSTemzoKU/X6o/4aIug6vTqtGXy0qGU43nZKPdbTVcuiRk53LFY
	 5ymyVTi8NONSKy4GGL2d3tMcojNshyRbW2m9twEvEhq8UZyyI+qdJUCiS77WOe04kMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390352;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a0PF6itKsbJatHBMiVBSVDsGtFU6B9IuJ4xx/BZZwZo=;
	b=1g3OCFsqq1w3zGH64nZyCmWRCGQASfRQnq0StLUiInwD5tEUz8YcG0xO4+BUg75iVQhM
	 2cbexAYQJefinwADYMIF+HV/paGzWZeq4wT7jH+V/woM0Y4JlC4JfBADANTL30xi+HOQT
	 TtbKQmX14gEUQ0dcCxtoTQQy/XUEyxKEEQO+sO4Lqlb1sc6IaJ0pRVGeBcjzQUHFQkLQZ
	 /pWMIpts6itgPqYHVvYdOCy71PVRCqBVgwCeWUC8KbOKhLOJdqfMMc0Lle2pnnbQw9oRH
	 hlmZeR0OaYgdpXykLcEHCJqQfNROr77Qh/avuxyjPLYkUyhr5VCFMy/n3WcRzjWRPGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=RucgFyUA;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A77606A33A;
	Wed, 11 Nov 2026 09:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19A77606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=RucgFyUA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=RucgFyUAAn1FjcbEpDIRJ3eHX3KeEz3AQfvfT0bgxkyN8U7ZPSjhy9tCv8ZEjNa7pwTJl5uq5eFuK
	 rsw6XKLH4yS9lb3fAY8SvDkw43Ry9smE6DUobSje67I7F/c91C5JJyfXZM4FSaGPe59rrzJgbvhWlo
	 qWK/v6XGQqRpzALU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af43949f5f-d55d1;
	Wed, 11 Nov 2026 17:45:48 +0800 (CST)
X-RM-TRANSID:2ee56af43949f5f-d55d1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[112.23.105.204])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af43949db3-d6fa9;
	Wed, 11 Nov 2026 17:45:47 +0800 (CST)
X-RM-TRANSID:2ee36af43949db3-d6fa9
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: [PATCH net-next] ipv6: check mc_forwarding before calling ip6mr_get_route()
Date: Wed, 11 Nov 2026 17:45:28 +0800
Message-Id: <20261111094528.425826-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
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

When CONFIG_IPV6_MROUTE is enabled, rt6_fill_node() unconditionally calls
ip6mr_get_route() whenever an input interface is specified and the
destination address is multicast.

However, if multicast routing is not active (i.e. no multicast routing
daemon is running and mc_forwarding is 0), there is no matching (S,G)
multicast routing cache entry, and skb->dev is NULL in the synthetic route
query skb allocated by inet6_rtm_getroute(). As a result, ip6mr_get_route()
returns -ENODEV, which causes rt6_fill_node() to jump to nla_put_failure
and return -EMSGSIZE to userspace ("RTNETLINK answers: Message too long").

In contrast, IPv4 counterpart rt_fill_info() checks
IPV4_DEVCONF_ALL_RO(net, MC_FORWARDING) before attempting to query
ipmr_get_route(), and falls back to emitting RTA_IIF and normal local
delivery route attributes when multicast routing is not enabled.

This discrepancy was identified during code audit of multicast route get
handling. The failure was confirmed on a UML kernel: querying an IPv6
multicast route with an input interface ("ip -6 route get <mcast_addr>
from <src_addr> ...") failed with -EMSGSIZE on an unpatched kernel.

Align IPv6 behavior with IPv4 by checking whether mc_forwarding is active
(atomic_read(&net->ipv6.devconf_all->mc_forwarding)) before calling
ip6mr_get_route(). When mc_forwarding is 0, rt6_fill_node() proceeds to
output RTA_IIF and normal route attributes.

Tested:
- On a UML kernel with CONFIG_IPV6_MROUTE=y, verified that
  "ip -6 route get ff0e::1 from 2001:db8::3 ..." with an input interface
  now succeeds and outputs the route instead of failing with -EMSGSIZE.
- Verified that IPv6 unicast route get and multicast route get without
  an input interface continue to work as expected.
- Built with W=1 on UML, x86_64 allmodconfig, and x86_64 allyesconfig with
  zero new warnings or errors.

Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---
 net/ipv6/route.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 2eb884558c24..6dd4a70f6490 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5862,7 +5862,8 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 #endif
 	if (iif) {
 #ifdef CONFIG_IPV6_MROUTE
-		if (ipv6_addr_is_multicast(&rt6_dst->addr)) {
+		if (ipv6_addr_is_multicast(&rt6_dst->addr) &&
+		    atomic_read(&net->ipv6.devconf_all->mc_forwarding)) {
 			int err = ip6mr_get_route(net, skb, rtm, portid);
 
 			if (err == 0)
-- 
2.33.0



