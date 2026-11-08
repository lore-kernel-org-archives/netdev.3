Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.191
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121784;
	b=LbHamruZkgW5SY1KgToD+2m1n22yjHMLBJ4eOCftSvjiJolw4RYFQuSXWcCV5JYegP1k
	 jTozAvrhhjWCj0uMV+hFBaT3A8EEdKt3lyfm/HyY97Xt8Pzw737Xd/oLLpTMUh4Fj3qwz
	 dsC2ZdL+F7APC0G0gKf3AnW578D82+vo1IKXcrQRn5PU+MPUuI+nRuIsTSk1hPNyW3N4c
	 NSR8t54QqupxGUvHreoEU+4W9cu3XO7mv7vpz5f+hYyyCAk/Fqey2boc31Dhpty0zjWKv
	 QKfW+2HERxGMaoTBGQriFKRu+9amW/FX2QDmZ7A+n2spObRIe4jB/P74VR/dywXI8oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121784;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=u6kbnt8wIfmVTnovskbJOkzKYfRyHxmOIoHNpPYAAZI=;
	b=Hmethtc/2SUdetk0nEciMFaOyTua9UnVsyYOqVp6eFiDVjZZL1vVPcwsdftcQRo6Dvgq
	 BQuRSm9ls3rTZ294vbTLvq3Mxz5mjlmwnhkwgXRXC6RTQ6hiLHj/+INbAVIhgQeRsUZft
	 23mHPyON7tpeAYwU613TKF8/7px8MoZaeg+S+yYf8MxANdLGjXzhf8oRKU6Q0Mf43xDJm
	 KSQDWtglyvUoaR96zAFQLn+6k0ZjBedJBKIz9J2P5TuvZlEqMwCJW5lUwqSUrNm1UlrUn
	 wM1F7Rgb1CDa3jrFR0SDbWIk8vKXMXOJiw9jiY4Zh4vbMi2KqmjU3ZOAKW+rh0g277A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=UjlzLPoL;
	arc=none smtp.remote-ip=203.205.221.191
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9838606A31C;
	Sun,  8 Nov 2026 07:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9838606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=UjlzLPoL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794121779; bh=u6kbnt8wIfmVTnovskbJOkzKYfRyHxmOIoHNpPYAAZI=;
	h=From:To:Cc:Subject:Date;
	b=UjlzLPoLymNtxXWzNzUwM35h6oWQXENyG2d/N4Vfu6IGxTgbyoNDdIyXSS0FqStWh
	 ngFvYkAMykFURCiORnZ+F00k28ikLjOYz65v079Y9lroOnQgi/3SE8RhKyEOoxeRII
	 3rZbNW8RixALMJvkilIbql06fXYdIctBc7qhYKaE=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:5872:d752:285e:a265])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 264264C7; Sun, 08 Nov 2026 15:09:36 +0800
X-QQ-mid: xmsmtpt1794121776tu7jnxuck
Message-ID: <tencent_3049FF6D9F23419F56589E244420973D2708@qq.com>
X-QQ-XMAILINFO: Mpk1SqVBRfAQvrb5ZmWJ3UNm46QhUTuOOjt3uwMnDrwSV4MbvIVXkiisq4n1zG
	 hTuqt2zlxk3ftFrRdOnJXgxKwpStSb7fzcd2CETOxmml1DaBidCUs6m8IxdrbbG9NwpKANlc4Awc
	 M7/rUSNSlUMFWdLYP2IhWQUmeuBVTVstHvm+EvcX2gWA4/fkyZjicEzXs8bqtHOCq/zciClvgeS6
	 8x0D2mJt+RszG8RokGS9U2RfD+P/WGbjA71KA/Kayj8IU26MyDsIuFN52vdUCNT9Ogn75wUg2ed6
	 yh0h0aqlDYeBHvz4q7+kMcbmSDBus/bBvQpV39v2Jm3bGQvGWeEW/W4h0jxm89/jRGqivhxvh4pV
	 WOGr43QIYHkBcJ4IzqGeL74FDt48SXDx5JngMvWopMkMd1pd2/o2HShIIL1vukPhx63Gcd2Iythd
	 oynfVsgjV9NKPyQ842aJzg4bHPOccM3AmjHTWTi2uaOBxi9CjDd7RhZuD8B3p1BQLSH/E8ZZkbXa
	 MJ4IDFVzcRxkBWalqYBZ1S+Ndd3cmAVtruPSFPDDe8Sukxmbb/zTFWhEUzNYbOE/1pS3OkoW+hPR
	 G4yqfxl6y4biF5BGPz26wxnQsxlotcHw3uWEsF4gE59b7pufZ3/i1wuLfYC5/pfNynqF2UZbZa8p
	 av9YqpTNfVDRN4YGpw1youT/OF/X/MXHZxH9YPEJzTcbqkMcmnrKB24R4Gbjt318oLbgM4A5ZZl/
	 lN3a+6LRpvWR6anZBcBNlHRcVSNk6eNmAuvrm7UrH9ozXyQQb8+ALmYOTll01VCK+ELca3enl1CO
	 yNpHK61cEB3FXRTRBuzB8S1GVOxMkr3W1ALuh5rdGxPvlG3L41Fhessl/yb93jgaHM2vO9wgz3MN
	 QEg8Tuh3fjoo49HeniCKfUV9CS3TOlZGCoxjva3Nx7vgbt6ioOFS/3chtK5e3YFu+a5bM/fB1x44
	 RAEN8iXbNXPplitMU+xi2OXXaQ8pjCa+6EmqRWMM14DlVwzOhunL6N/mYY+WX1nyE/abdgba4v7Q
	 DBW79ePh8YHYHXLprb+O+9O9eufNfn4OxxRepuVcYOiZPqaoM+51ARtB5Zvb0TbIaKx6jjbWaOpl
	 NoXGIKvkg8w9oKVHQteNbmAA2kJ8CcpgY+/9TdBeXMlPweAoA=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
	ast@kernel.org
Subject: [PATCH net v2] ipv6: reject routes without an inet6_dev
Date: Sun,  8 Nov 2026 15:09:36 +0800
X-OQ-MSGID: <20261108070936.2832089-1-1075151112@qq.com>
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
Closes: https://lore.kernel.org/netdev/tencent_CB9E1044AC97882719FF3A9F5B410A562408@qq.com/
Link: https://lore.kernel.org/netdev/DMP4WRIOGMBX.3VW2KNLBGDZ0K@gmail.com/
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
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

