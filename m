Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476814;
	b=vQsrTdhimU/P8clIeyGtt2O71kZzNC4Th0gF3gK9kyimMokn2jO2sThezyeDQ9twyuiN
	 xoN5+dB/ZwOrfg45WP+PrVv+x1fh+jz3/AUEwlbQkbc22yOjyqzJv04Pjycx3ERaSKMbz
	 lw9qslqErncSgz6ZIoKmbEKPCc2E/kN2g4lrDonkBEB90TMVNohXJiBR9pFsGRFDBBDB0
	 F7ioIY01j+1d7NJo2x6S30qNvjwLZddABI6kc/80YUBL3pi/YaZlHTiAJpKxskHo7RcxC
	 21opYdp5hkiMtJVGzvdoTev2jhtOrUptgBM/zZe5WUb1L4EJlz/CUY0LH1SsKKsaU/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476814;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y4YhAhyayvyCbm+IS4ybj27bnorKrlzrUXxTUWhF7GQ=;
	b=VefG1S8wV8540YhA5Es6wyiYe2AewwgpsNwg/+hEhPkclR4Flfbzr5XiJWlAL0ddlpqC
	 YjTYXUXeodUP0M/s/DKiI7Cp6SurNyD0V6cKb4cAzNwvGSOE6B0dgzJBeTzBql394cnLL
	 bTeEFk4T8sVzXAJ8dNA7esMdOxGiJ7yEvhUKtC+gMH3PgYy9jMcpytEdbQiMzPPyAxn8/
	 7osA3gzow7b6leV0v+xflSJCYK36x5aEIpyiAuTj2D2qwmBVuHCMYLv8iU5CtS+icFMqx
	 lIaJVCZRQVXusI6lHZg4MLrVADEGtgdbkztuZqKo3tqy9J5D/YNwhhuzvU/WEGWpRqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=RmN0t7IQ;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C8A606A321;
	Thu, 12 Nov 2026 09:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77C8A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=RmN0t7IQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=RmN0t7IQnY+8+6sci+0WgpfDt+qRBy4KujaIG3zvrgsBbzd8+eJChK255EGPGR47Qw1NPlohV/aE4
	 QBrPgNNOHCYoGIxplD6y/56ElAsVPmbC26JcNnBfUYXPqk789MqTeo8YN7vRq9l6Thm37/8ZxaVg5P
	 gMreI/BCfNtSvvBs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af58b096e9-816ca;
	Thu, 12 Nov 2026 17:46:49 +0800 (CST)
X-RM-TRANSID:2ee46af58b096e9-816ca
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af58b07794-fbc62;
	Thu, 12 Nov 2026 17:46:49 +0800 (CST)
X-RM-TRANSID:2ee16af58b07794-fbc62
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Hangbin Liu <hangbin.liu@linux.dev>,
	Hangbin Liu <liuhangbin@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: [PATCH net-next v2 1/2] ipv6: check mc_forwarding before calling ip6mr_get_route()
Date: Thu, 12 Nov 2026 17:46:29 +0800
Message-Id: <20261112094630.197244-2-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20261112094630.197244-1-sunwenbo@cmss.chinamobile.com>
References: <20261112094630.197244-1-sunwenbo@cmss.chinamobile.com>
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

When CONFIG_IPV6_MROUTE is enabled, rt6_fill_node() calls
ip6mr_get_route() whenever an input interface is specified and the
destination address is multicast.

However, when multicast routing is not enabled in the network namespace
(i.e. mc_forwarding is 0), there is typically no matching (S,G)
multicast routing cache entry, and skb->dev is NULL in the query skb
allocated by inet6_rtm_getroute(). As a result, ip6mr_get_route()
returns -ENODEV, which causes rt6_fill_node() to jump to
nla_put_failure and report -EMSGSIZE ("RTNETLINK answers: Message too
long") to userspace.

In contrast, the IPv4 counterpart rt_fill_info() checks
IPV4_DEVCONF_ALL_RO(net, MC_FORWARDING) before calling ipmr_get_route(),
so queries with mc_forwarding disabled fall back to emitting RTA_IIF and
normal route attributes.

This discrepancy was identified with the assistance of an LLM-based code
review comparing IPv4 and IPv6 multicast route get handling, confirmed on
a UML kernel where "ip -6 route get <mcast_addr> from <src_addr> iif
<dev>" returned -EMSGSIZE on an unpatched kernel, and verified after the
change that multicast route get with iif succeeds while unicast and
non-iif multicast queries continue to work as expected.

Check atomic_read(&net->ipv6.devconf_all->mc_forwarding) before calling
ip6mr_get_route() in rt6_fill_node() so that queries with multicast
forwarding disabled report RTA_IIF and normal route attributes, matching
IPv4 behavior.

Built with W=1 on UML, x86_64 allmodconfig, and x86_64 allyesconfig with
zero new warnings or errors.

Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
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



