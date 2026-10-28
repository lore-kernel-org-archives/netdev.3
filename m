Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201565;
	b=hmoWe8TEUaZAUj5hlyUDYAlydfG3PNSg9oeQtxHZ6rc0uEB1Dz+BeH6DMBreSl3SioyG
	 un3K55zJpaiii9edkRrhKZUcMtaTZhyBUFtkNhISHYrr9UYwQ56po08+OzfWHylnJOjHM
	 Rb0I4AfXHmmG8k/afKjv1QLSqI2/Mo09bvnyFaYncoG/eVlzPFWdTtkc7UrZiPkAMVzyW
	 QdOOdZH4E1iFsWxjCO0hX/OQUW0SlO8vidCUsCCVJ8B7kspy8FO3wUH4jLGWrzsCqmhRE
	 0t79ZVUjRgw+Q3JsuV5r969jTNGrrnPOiYkNiIWLYrJIoWDao27ar6PDbePcHyc7yjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4CoutM7AnpgKYRtmRzJTqqEDXmlCJEKKkP9PY75AExE=;
	b=XYHkNNINSNpvUo6FyiFtFH1QEAnXDeJ1ka4qJSClwqCZWVrFCE0EMM82aS+m6lTFt0D6
	 PQ+MN5NyPirmlA4M/oV05h8/uwwiWWAyIcNeTIL+eyougzzotosepe/jPsJ57XOw6Mt75
	 ZwDkctMzFvwZZKuENfk5EYhHa4tBsua3PqoKTrmKkjeO8qF8ri2cv3M31pQgC4ERNmCo9
	 HU/+B3eO2zWgyvERS0O8j55XjzHIEGCZrplrRLfCpaJWoJ4ix7XPTmDOmNvQ+1npYR4aI
	 FUmlBaKzcdkig0gZkDt/OjVfwuBHUp/KNwp+eAIUZtrqhyjMUDjepDDhAhLOjw8n0mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=heXmpuck;
	arc=none smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029D606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2029D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=heXmpuck
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ba328513b9so1247611e87.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793201563; x=1793806363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4CoutM7AnpgKYRtmRzJTqqEDXmlCJEKKkP9PY75AExE=;
        b=heXmpuckafKBBzZLru5IJ/va5qQlYdgMLi4tTuQgsejbiQrUne3QPPyo712jMF2Ws4
         naqfFmSORKdP82ovy4Ddq1iqs/GTETMzgJpoGjvxVkpGjU4fB478AMI5cw3W3CWPR7iM
         zWNm4UwcQFxHl5pixyIN94gJyr8hOyOKhwIuB2lsyG2ZnQrNTQc8aUGZEOX7iB/iCyWy
         3UUjNMTeKU4lnIvCddt6IJPdV8EqwWrNuoMnS1M3t0Ur4zoi0Rrp47BfBLjlsiSM1yrE
         6/GxNfUedNV7z4In+zUU2LQT1KvNVxGdkbqzG2wlN/C1B3lf7dmwR+gcLdvP7hHJoypa
         Iyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201563; x=1793806363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4CoutM7AnpgKYRtmRzJTqqEDXmlCJEKKkP9PY75AExE=;
        b=Bv+Xm9SUvd7HLemyspR4v0ylJ/cltII2IDtQ6SaRnYyR11So7wn/qDeZDrYe1GDDbY
         4bJisaU/yximAeZxKXHJRDwm9O8f7Oq+fOnZHfFX3viQJHOWuj1HDNiFVxtXZgeI+ktw
         HASTgq7TG8PcRd9TmvARbkfnbHi3vvBqkobDI2ovBDq34kZsG4W9d3GQQs07aLZ9GiK2
         2WEfIeZGgHRp2ULfY909XaHXqu6OAY+qwJ1IpZZ7QP7UYVRAIO/a0spOBXDO75+y/ist
         praKRtAnAJfEpJyynyT1HfrknVst0zAFg46iGCTLJXYr2oYtmWEO+PyCKqDwRGMotmc+
         N/aw==
X-Gm-Message-State: AFq9FYKIPx/hXsYg/gjZWRvzTUWSBxJOasem2K5cN+ZKnQuUbmF9geDt
	wFO8gX9ImvRaLUTJCvgkHvUP6zAG7rFVdT0g8pKq45InqVYbwjiUpe0lS62XYISEYQ0=
X-Gm-Gg: AYBFou2y/qHhz2n26vpLL1Vtp8QApStl9v6KE7ESTNdkNk/wQX3SpctEPf7KB6rRH1s
	oAU5wcMCAa/sFES97tX2uSiI3rY9Mca8sb3uUIIZqIEr+HgcMTXpGxiAZyMG4Js4U0WRIcvrCCG
	TSrQ3itqlKqQmX6irqO/2kUYKS0L/u9Gi3lFD2sqKA9Te9XrEfkPWWl9Kq/HfI7Vr3v7wFiS69i
	nzvLqcYKqwJLI6UgA7KmWRnet9mxcwXtf3EawRQRUdGrKzhuG8ju8nqSFW/z1XVv60fnmMdVJTl
	EVIYpJVq840f/Iq/RD0Q7XXsOyFUU6OcNSa8iEO6w0sATsidGnxu5DMes0srtSPY/I9VXqeOxO+
	9Q3/svjG+xq6BSmRkioxTV74to7cNO5b3inlhg6YwTSY/3tL0f3BGNxbvuiVqpCLOADZ6iCdv9F
	+X1q5y3MuZW9pYFo/12JoRqpXJp8f60HJ/FlxO352rQQ1cexPmxixqtYjaEW3YVV6tw0CRmjf60
	jjnT6jcyZATXDv5FswRJIieW3U1CFQX6Qv9YePeoxpKxpSbnZKowgQUvuGyQqp+EvvvzNO1AHtr
	DpxqnPYsfWd6sJ2/cufww9uOVbo=
X-Received: by 2002:a05:6512:6cf:b0:5be:5d8c:85c7 with SMTP id 2adb3069b0e04-5bfcad4329dmr1063224e87.24.1793201563041;
        Wed, 28 Oct 2026 08:32:43 -0700 (PDT)
Received: from gentoo ([178.68.9.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfca57ee5fsm669346e87.32.2026.10.28.08.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:32:42 -0700 (PDT)
From: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
To: netdev@vger.kernel.org
Cc: Yaroslav Dudkov <aroslavdudkov622@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Wei Wang <weiwan@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ipv6: ignore link state in gateway check
Date: Wed, 28 Oct 2026 15:26:33 +0000
Message-ID: <20261028152634.3355852-1-aroslavdudkov622@gmail.com>
X-Mailer: git-send-email 2.54.0
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

IPv6 route cannot be added in table when all
following conditions are true:
- gateway is not link-local address
- ignore_routes_with_linkdown=1 on device
- nexthop has no carrier
- gateway is not present or covered by any route in table already
Also multipath routes addition is invalidated by kernel even
if only one of added nexthops satisfies all above conditions.

Reproducer:

  ip netns add t
  ip -n t link add va type veth peer name vb
  ip -n t link set va up
  ip -n t addr add fd00::1/64 dev va nodad
  ip netns exec t sysctl -w \
    net.ipv6.conf.va.ignore_routes_with_linkdown=1
  ip -n t -6 route add 2001:db8::/64 via fd00::2 dev va
  # added
  ip -n t -6 route add 2001:db8::/64 table 100 via fd00::2 dev va
  # RTNETLINK answers: No route to host
  ip -n t -6 route show table all
  ip netns del t

Route should be added because:
- RT6_LOOKUP_F_IGNORE_LINKSTATE in commit d5d32e4b7668
("net: ipv6: Do not consider link state for nexthop validation")
was added for this
- the same route is valid in main table (when no specifying table id
while adding route)
- fib6_nh_init() initializes nexthops with no carrier
- IPv4 already does this (fib_check_nh_v4_gw() ignores link state
using the FIB_LOOKUP_IGNORE_LINKSTATE flag)

Before commit b2c709cce682 ("ipv6: Convert gateway validation to
use fib6_info") rt6_lookup() was used for checking if nexthop is
valid, rt6_lookup called rt6_device_match() which does not check the
link state. After change rt6_lookup() to fib6_lookup()
find_match() under fib6_lookup() started to invalidate linkdown
devices, because RT6_LOOKUP_F_IGNORE_LINKSTATE is not passed to it.

Adding RT6_LOOKUP_F_IGNORE_LINKSTATE to flags for ip6_route_check_nh()
solves the problem. RT6_LOOKUP_F_IGNORE_LINKSTATE is already used
inside the first search ip6_nh_lookup_table() and fixes the
bug in second search fib6_lookup(). Also RT6_LOOKUP_F_IGNORE_LINKSTATE
isn't read inside fib6_select_path().

Fixes: b2c709cce682 ("ipv6: Convert gateway validation to use fib6_info")
Signed-off-by: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
---
IPv4 example of this situation:
  ip netns add t
  ip -n t link add va type veth peer name vb
  ip -n t link set va up
  ip -n t addr add 192.168.0.1/24 dev va
  ip netns exec t sysctl -w \
    net.ipv4.conf.va.ignore_routes_with_linkdown=1
  ip -n t route add 192.0.2.0/24 table 100 via 192.168.0.2 dev va
  # added
  ip -n t route show table all
  ip netns del t

Also when adding RT6_LOOKUP_F_IGNORE_LINKSTATE to flags of
ip6_route_check_nh() makes adding this flag inside of
ip6_nh_lookup_table() unnecessary for this call, making another call in
ip6_route_check_nh_onlink() with flags=0 the only place where it is
needed.
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 94e5ef1c4f83..95d7b5b10e51 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3426,7 +3426,7 @@ static int ip6_route_check_nh(struct net *net,
 {
 	const struct in6_addr *gw_addr = &cfg->fc_gateway;
 	struct net_device *dev = _dev ? *_dev : NULL;
-	int flags = RT6_LOOKUP_F_IFACE;
+	int flags = RT6_LOOKUP_F_IFACE | RT6_LOOKUP_F_IGNORE_LINKSTATE;
 	struct fib6_result res = {};
 	int err = -EHOSTUNREACH;
 
-- 
2.54.0

