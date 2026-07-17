Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 99FED305676;
	Fri, 17 Jul 2026 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298815; cv=none; b=NftkvTMzSdntgqen4OnImwZiB27g0I+kai8V/NkPFknST7jcFdLb/yD5wREbOO3kgnjKeQlhX+Vgdo0A75LUwcmGTmQFHeQ0081SvlDxuZHSRsxOADgqlM2nCZE1hH67+pfu9oQHXiIDePgO1YVO6F5+u/ZSPVj5FhR78+sGVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298815; c=relaxed/simple;
	bh=Q4220uw1LI+jSO86nf3aFK2EsETUPLIIgYVrgtImPRI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ryeMz5bSoyT932munDn8OUCNcQxuXi3YKd9+8WM+XPUM9KSFmsUrzpsyQlqIbyFG64VcsdFWLGmCnZ80bUz9gEymQH5dYLs4s+eSxkg4Mh3Txp3STCTtds1BLFYlP2ge7MXiveZ4O6nxALxLq09KRF6dkGf6srmPXPAOqpp7olM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=UqX7Sq7A; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="UqX7Sq7A"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Xin Long <lucien.xin@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] net: ipv6: fix a potential use-after-free in ip4ip6_err
Date: Fri, 17 Jul 2026 22:33:15 +0800
Message-ID: <20260717143315.1942-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc7.internal.baidu.com (172.31.3.17) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1784298804;
	bh=BNCQi1jTLW7XPXFXQMcD6/PhUT/qZSzT68Oxpjr79f8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=UqX7Sq7A0rAYWXvUctdxhDImxEai52UChlE9wO2XiI2VCEOz5cdpbqxk73AtpdJGA
	 X0NY8NzEb2Vc1BeYG//bn5BztDEIQpSOZk6ZZQPW6kVORH03riP+mfe2cnGFs2QOlt
	 5HwaUgdVKROfd8av3JTRaIfu6NbSCYQx4hnw8BEA+hS/TyLbRTdfwaeEXk7GDay6W6
	 9zqtsFcE/NRORVugqUXhwxyBX8rfTtNcpt+JVbHQUWRbRnpk3WKDhfpr9vltRuv/oy
	 4duUadmt9l+4HvbJojeI+vl0B7euipCbur3iPAOrUyWb5hVHwAa/ul86o6pnY9ZIfd
	 99Wcm26+ZqoUg==

From: Li RongQing <lirongqing@baidu.com>

Fix a use-after-free bug in ip4ip6_err() where rt->rt_flags is accessed
after the route entry object has been released via ip_rt_put(rt).

If ip_rt_put() decrements the reference count to zero and frees the
rtable structure, reading rt->rt_flags immediately afterward
results in a use-after-free pointer dereference.

Fix this by caching rt->rt_flags into a local variable before calling
ip_rt_put().

Fixes: 77552cfa39c4 ("ip6_tunnel: clean up ip4ip6 and ip6ip6's err_handlers")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/ipv6/ip6_tunnel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index bf8e40a..984cb0c 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -569,6 +569,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 {
 	__u32 rel_info = ntohl(info);
 	const struct iphdr *eiph;
+	unsigned int rt_flags;
 	struct sk_buff *skb2;
 	int err, rel_msg = 0;
 	u8 rel_type = type;
@@ -627,10 +628,11 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		goto out;
 
 	skb2->dev = rt->dst.dev;
+	rt_flags = rt->rt_flags;
 	ip_rt_put(rt);
 
 	/* route "incoming" packet */
-	if (rt->rt_flags & RTCF_LOCAL) {
+	if (rt_flags & RTCF_LOCAL) {
 		rt = ip_route_output_ports(dev_net(skb->dev), &fl4, NULL,
 					   eiph->daddr, eiph->saddr, 0, 0,
 					   IPPROTO_IPIP,
-- 
2.9.4

