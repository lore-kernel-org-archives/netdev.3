Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212993;
	b=Bbyg7I05J5MPImqVUp8tAnkkaYXeHLikaYsxNH1tF3H1oToIhsHyXDPeI5/KzYjmf2L0
	 c5AjrnjgA30qOiSR/WRxWk8WfF/7PqQK+ycP0CR4lohsZY2DtaAA6mbmuCWBbRlnKwgpE
	 vq32Tli00kHgH3a+vYFKUK2U+l1g56YB/hS+PzX1b9wbuCp7ulgjOu5KAqhR9h8TJ3tcb
	 ke0aa62eYLlmDgFyc/GADB74cmR+BuKxCCfkLA0tdFyLsBnquPeiAUpOZ7dY1zjIw17QC
	 +CYUT4m8HhpKvZ4Ic2hzEAFwX/4FBSA8UtDA/uOO/jPPs1TCbla1KAGWb28pOwINcig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212993;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PIsytMA70Zu9zd2fra8Ox+iIp9CD6WGyu99mDg6eiaY=;
	b=Vbcxz1pdANveIEk9PapMFpGEQjOy+OP1PlEIBrsKjmM3yUc6bPcrxwsJmQxq213tve2M
	 nRRhgrElGRZqSFmlbkKtGR2nyngN24bkMxS5etCvTZ7J1Y3EPRx8sOXFkoZAWhnyToHzP
	 Bv6ZhIN6J4PgVl8G6Cxuwx33O8+tSP68+o8vO427wn9zxMViRrpVA9qhnBaFq+0HyIVAO
	 ApUdDS8jlzhsSiJxLClkNc/3ZxOYLj8dyne9fpdKxqHzfSyS3wof3S9WK+eiLvMEV4b74
	 50Taohxo9PNTXcgLUXDD4ODf/diEjQoQ/a4v6CJIAyG4MsPEPLYSRF7KHFfTbaVR6dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=VEwrf5UR;
	arc=none smtp.remote-ip=203.205.221.240
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9A0606A321;
	Mon,  9 Nov 2026 08:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F9A0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=VEwrf5UR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794212983; bh=PIsytMA70Zu9zd2fra8Ox+iIp9CD6WGyu99mDg6eiaY=;
	h=From:To:Cc:Subject:Date;
	b=VEwrf5URwfEpy5BYU+0S2Ti63pqyeQSD9dfhbE4MYDeuI0WulkYZ0ZLqUtR3Q50Uc
	 IEBpZfjW/Fus7feNhDNxLsfMfSq/sg64BrSMUS3LM+a5F83SX/bLK42m679hZbUhCn
	 picP7V8pOhaCXWf+aIFW8wosxir35AzMxQwFB+Ro=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:db4e:1753:6c8f:65bf])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 7681DE3D; Mon, 09 Nov 2026 16:29:40 +0800
X-QQ-mid: xmsmtpt1794212980tspby4p0r
Message-ID: <tencent_91DA7FD8277B509C55906702D1E425FBC906@qq.com>
X-QQ-XMAILINFO: NvKPbWBbh1DVBvs5M/OQJuNLdC1jqoSiFDumPsN8jOCSPwGQZoyvcM8SxxIWSp
	 yQQRiTqt3bIZHq+CWR2x8rq/E1112sS82DvGnGE5EcwUKIACRuc8NNjES/+kVWIxU6mbTYCdFck2
	 K4MNzoitCS5zkxHDrL6x3Vx5FJ+3+XmZCxpJK8DxuE9sKQbmQSbiJYbUa9dcd1zfUJYcMt2YJKRi
	 m2XNIE7JtozKHDuiel8Nf0ltUt3AT8IiKLzXW2F+ympm3J19kw7tPwBo7tPPqMKbXe6saENXs5Kc
	 IMEzq7UIDASQb8BZGPWhdU7PGvNzA4vhSgB+3VPBs4m/uaLU1T0JC3uJEXIx0Nu1geVaSiqHERw/
	 nt95/q5eiHmQcDHtr/juut4lcjeWfmrvD5Um5klSVbp9ZIA5bvPf17SiPTq4/l7mZqbGfxDqCuXu
	 6gyodv37Wf7b3b/Xtzv/yxsnPECy1HAUvjtRxlWgA4iKVdYTzd4zHtBNy3RVFeHSZIer5R/aEI0e
	 O2x1KR6nvPtbE3FvcR10Myxz1J61ZES+j/91OBx8NkLf7ntBPxA6ctKn81xT0Q62ohq8cQRMnL8c
	 OkEh5jVbWgR6lEBnmIhxIiIwEomZEcc6Es/skAPNYUVCDPudoJrBivh547sKE/qVRYNebTHXLmNm
	 EDlj103zmqih6m3vYLApWQgGtklsjBlTMhI2BFhfEEaNtMOdFw6KDm4JfO76FFp6rEQ/7IUTw4pN
	 LY0Y2HOLlKpi6kPFha9a7DnIhneDOMw2Iu7amsmfFlJYkkHuQSZbEX29uoihPoW3sYj+cLLgH0gU
	 Q+3uUIl5Gg0BcEstlveAQPIpwCOhUUjInk3JwsBd3dloq4jxhl0UnCEMKVKDZcXffJl2PTPs5nyY
	 w3oS9+MI98L0s8YT7XTC3KKmgbdcNOlEbbzvA91jI4ld3PnQx9ei4H9yD0WIGUffHWtcVxv7WmrA
	 uIkUEClk2m63HVRjCtK7/E5uHnUutbjvW7Uo1op3V/GxC2krr+5lQJpHSNbIpSd98olRvAORX4vG
	 2/wo6reUs2duCZ7d3sb9Y71PVzdSZGFwXsJg5P0LPejnQFkxBm3SgREQVD+Uip4I5dpBNXbQMJdJ
	 Ac9IOhKRFF8il8Z0rMZO8RWC4kXuNnudkvZ/+v+RUTUfcMiAk=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Yingjie Wang <1075151112@qq.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	liuhangbin@kylinos.cn
Subject: [PATCH net v3] ipv6: reject routes without an inet6_dev
Date: Mon,  9 Nov 2026 16:29:40 +0800
X-OQ-MSGID: <20261109082940.3724298-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
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

ip6_route_output() and ip6_route_lookup() can return an error-free route
whose rt6i_idev is NULL.  Lowering an external nexthop device's MTU below
IPV6_MIN_MTU tears down its inet6_dev, while fib6_ifdown() leaves routes
using nexthop objects in the FIB.

An unprivileged user with CAP_NET_ADMIN in a private user and network
namespace can construct this state.  Consumers which treat a route without
an error as usable can then dereference the NULL rt6i_idev.  This was
reproduced as a KASAN NULL pointer dereference in ip6_tnl_xmit().

An audit of IPv6 route and tunnel users found this unchecked
ip6_dst_idev() dereference.

A similar missing inet6_dev check was fixed in commit 1b9b5323725e
("netfilter: ip6t_rpfilter: reject routes without inet6_dev").  However,
the route construction path still marks routes without an inet6_dev as
successful, leaving every consumer responsible for the same check.

Acquire the inet6_dev reference before initializing the destination.  If a
non-reject route has no inet6_dev, initialize it as RTN_UNREACHABLE instead
of a successful route.  Explicit reject routes keep their original type and
error.  This establishes that ordinary error-free IPv6 routes have an
inet6_dev while retaining the existing defensive checks at callers.

The modified route object builds cleanly with W=1.  A full x86_64 KASAN
bzImage build completes; it reports two pre-existing kernel-doc warnings
outside this change.

Tests:
  - `make W=1 net/ipv6/route.o`
  - full x86_64 KASAN `bzImage` build with `W=1`
  - KASAN QEMU with an unprivileged user and network namespace: after
    lowering the MTU, the stale route returned `No route to host`, a normal
    route still resolved, and the collect_md trigger completed without
    KASAN, oops, or panic
  - `tools/testing/selftests/net/ip6_tunnel.sh` in the same KASAN QEMU

Fixes: 5b98324ebe29 ("ipv6: Allow routes to use nexthop objects")
Closes: https://lore.kernel.org/netdev/DMP4WRIOGMBX.3VW2KNLBGDZ0K@gmail.com/
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
Changes since v2:
  - Use Alexei Starovoitov's V1 review as `Closes:` and drop the
    manually supplied `Link:`, as requested by Hangbin Liu.
  - Add the discovery method requested by the netdev information bot.
  - Add Hangbin Liu's `Reviewed-by:`.

v2: https://lore.kernel.org/netdev/tencent_3049FF6D9F23419F56589E244420973D2708@qq.com/

Changes since v1:
  - Move the invariant into IPv6 route construction following Alexei
    Starovoitov's review.
  - Acquire `rt6i_idev` before destination initialization and preserve the
    existing handling of explicit reject routes.
  - Update `Fixes:` to the nexthop-object route support commit.

v1: https://lore.kernel.org/netdev/tencent_CB9E1044AC97882719FF3A9F5B410A562408@qq.com/

 net/ipv6/route.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 2eb884558c24..a4c792fc55e3 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1165,6 +1165,12 @@ static void ip6_rt_init_dst(struct rt6_info *rt, const struct fib6_result *res)
 		return;
 	}
 
+	/* addrconf_ifdown() removed inet6_dev. The device can't do IPv6. */
+	if (!rt->rt6i_idev) {
+		ip6_rt_init_dst_reject(rt, RTN_UNREACHABLE);
+		return;
+	}
+
 	rt->dst.error = 0;
 	rt->dst.output = ip6_output;
 
@@ -1200,10 +1206,10 @@ static void ip6_rt_copy_init(struct rt6_info *rt, const struct fib6_result *res)
 	const struct net_device *dev = nh->fib_nh_dev;
 	struct fib6_info *f6i = res->f6i;
 
+	rt->rt6i_idev = dev ? in6_dev_get(dev) : NULL;
 	ip6_rt_init_dst(rt, res);
 
 	rt->rt6i_dst = f6i->fib6_dst;
-	rt->rt6i_idev = dev ? in6_dev_get(dev) : NULL;
 	rt->rt6i_flags = res->fib6_flags;
 	if (nh->fib_nh_gw_family) {
 		rt->rt6i_gateway = nh->fib_nh_gw6;

base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
-- 
2.43.0

