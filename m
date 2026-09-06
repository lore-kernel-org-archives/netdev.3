Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D12F38330E
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788684267; cv=none; b=odKC0LOqbphYULfccyKVkKavW1iqLbeWwmCrrRxlb93UBm7REfdpt+Z2BPaPV5k1nFhqftGdONgtuijTYbmeA8b3GeaOYYAQ4ZpEam2FQWmR7wUiGMK9bgsOEHE+84Sr+7+uXfkKymM1SS+Hm1fopwOFc81ww7sjQye8v81h8qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788684267; c=relaxed/simple;
	bh=qNTDOlPILV3T04HAjwGIZq4By932gRZYYSompesDPNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AfmlScsya7MZ1qn23wfIJIfuQJYul9LWbkSFWvyHGHsMgr9OPx1Ckrs35v72gtmVYKaAVGFN8ltZw7akSbrVt2vw/XDOfnYITbbzTUaYzG421uieoNHlPsO9a+2pCJwz2kMGIMkPXbhlnFWvit+bYlEkOhABYT2tk3EhTENaRmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+N8muI9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+N8muI9"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d8f265cbe6so18502895ad.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 01:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788684263; x=1789289063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/l1qLwJSS6D6HFID29WNOWsYoWwOmZTzkLIw+IBHN20=;
        b=s+N8muI935x/XJrIVxbQJKnJDcod/ClhFST8qVlYz/Tv8bcLq3D8xXbsH0ZzhpJ8+u
         n8xl9SprMXFaeOdI3asZhL9dBj52/sLIzfzha8OE2pFoVpQt6Z+pMKhZCwBrQjirft2P
         GavT9ouD9Lp4hQtBL2MFngYmrseYDOzaDSj3neb/jLvyio/zR3gMphfTIXK++mZzVy8P
         BTS9B0RmtARKFlF8LPJODcPM/ryAYPzDWU9XbyHbGnvI/2GicI1GUivw4lReC5DdpZ/s
         yYSyhhzrw2ps75Xm4W2bVXLBEn4ofJP7gC95S4jPe4TX0VuReL7vl2mNNO6Hs9VVpCsA
         4Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788684263; x=1789289063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/l1qLwJSS6D6HFID29WNOWsYoWwOmZTzkLIw+IBHN20=;
        b=o42/Bs9uGZqUXvs4rncbrFpkLrV94xwUoWKzTvwaweqx6rt0l+zO3lOMLu9SWuPn5Y
         lu46GW7qvO8hzTjBdg13fO09F+CO7c1EviDV3yyablt/53s3PLddVC30wDEowtHDs3sI
         2lwjdderY0NMm+3O9dsWgDuGBchthtuLej0s6EMWySZYUvIEeNojW+ztQ2oXSgR9+m/T
         5xte2QIytCyWdSUVhcYjyWxZIo7hUlTTNyENeiby/djzOlZtoU9E9imwipJvBSgEp5H6
         qPEcAtQTqAjmEsFQ1dIz70HziLysfKgxSSUlKA6qejXKSLIfoUP6dxqeazi+Gh5b4zJZ
         viLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtqxbDh/YYlhxIveP0tiU232LPS8qnh/4PsLZ4sA2h6JecyFPVwRySjqIacEHylU32aX5b80c=@vger.kernel.org
X-Gm-Message-State: AFuF++lV/ifZrp+H85vPNblWuCs+tNzJlOyZvJHhYaoKyeJy8e2Gc2br
	qLJS/GnC6eHX7b3KLB+VyiqyVjzE8ZY0glR8LIQObw4rjeZOW+sJ8Uof
X-Gm-Gg: AYBFou0+kPlD+Y+C0IvlwF9O3RUio5Ow84X4Lknb8DSj3PyfnfBVo+MPpsIbOzn8V47
	5Xb7ianUTwZ8vKBBFdZXNGMrXFif4nufx3JhhcW9AOj8nEtKMlOOfj4Uv2ando/V2xp0PT5KPA5
	g+8s+aj1uBvNplrearr4XFU2V0DRNAnYeIWGmmvUcfPj/OeMBg/voBr+z8KB0KGKzGX5/Li0dLw
	K49nUpZAKnr0L5u/tkHeoQgqePCF3E92bNyMKzeUii9fMUCFrGkFZqVrXLRvzb25gsGqN3ydild
	sdjJUZXxN87uK3FTAlSkikhiRJXurgU0fHtyOiX99/aOCHm/89/Ua0HXswAfc5gHZoZ/nGjNsgu
	1TGYQGxeC49K8UuSTQ8KqeoDfd8y/HA1e48vCAhGGKl7KUuL/+qSujGvpOIHLcUgVDPyF8z+oqL
	u6ngUNlRVMea9hMJt7k76mkItMo+eU1clzhQCXg8oixEOVgINJtdxWyP+xCVF+9C02dIj/UWuqJ
	/NFPqxs1VjkYkDEmS/4
X-Received: by 2002:a17:903:b48:b0:2da:effd:f904 with SMTP id d9443c01a7336-2db1258c686mr229715195ad.8.1788684263408;
        Sun, 06 Sep 2026 01:44:23 -0700 (PDT)
Received: from 192.168.50.3 ([183.193.115.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db190f6fb0sm28470765ad.51.2026.09.06.01.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 01:44:22 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+459f67f4d8af8ce6@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH nf v2] netfilter: ip6t_rpfilter: reject routes without inet6_dev
Date: Sun,  6 Sep 2026 16:44:10 +0800
Message-ID: <20260906084410.5601-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6_route_lookup() can return an error-free route whose rt6i_idev is
NULL. Lowering an external nexthop device's MTU below IPV6_MIN_MTU tears
down its inet6_dev while fib6_ifdown() leaves routes using nexthop objects
in the FIB. An unprivileged user can construct this state with rtnetlink
in a private user and network namespace, then trigger a NULL dereference
through an IPv6 rpfilter lookup:

  Oops: general protection fault, probably for non-canonical address
  0xdffffc0000000000
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: rpfilter_mt (net/ipv6/netfilter/ip6t_rpfilter.c:75)
  Call Trace:
  ip6t_do_table (net/ipv6/netfilter/ip6_tables.c:316)
  nf_hook_slow (net/netfilter/core.c:619)
  ipv6_rcv (net/ipv6/ip6_input.c:351)
  __netif_receive_skb_one_core (net/core/dev.c:6216)
  process_backlog (net/core/dev.c:6680)
  __napi_poll (net/core/dev.c:7739)
  net_rx_action (net/core/dev.c:7959)
  handle_softirqs (kernel/softirq.c:622)
  do_softirq.part.0 (kernel/softirq.c:523)
  __local_bh_enable_ip (kernel/softirq.c:450)
  __dev_queue_xmit (net/core/dev.c:4913)
  packet_sendmsg (net/packet/af_packet.c:3139)
  __sys_sendto (net/socket.c:2252)
  __x64_sys_sendto (net/socket.c:2259)
  do_syscall_64 (arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: Fatal exception in interrupt

Reject routes without an inet6_dev immediately after lookup. Such routes
are not eligible for reverse-path filtering, and the check protects all
later rt6i_idev dereferences.

Fixes: e26f9a480fb6 ("netfilter: add ipv6 reverse path filter match")
Reported-by: co+459f67f4d8af8ce6@bugs.sh
Closes: https://lore.kernel.org/all/VtWUkE8QzJt5CroTj2V2v3ZQ0gwbXZ7nq7I3@bugs.sh/
Suggested-by: Florian Westphal <fw@strlen.de>
Assisted-by: Claude:gpt-5
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
- Reject routes without inet6_dev in both loose and strict modes, as
  suggested by Florian.
v1: https://lore.kernel.org/all/20260906034939.3746540-1-bestswngs@gmail.com/
---
 net/ipv6/netfilter/ip6t_rpfilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/netfilter/ip6t_rpfilter.c b/net/ipv6/netfilter/ip6t_rpfilter.c
index 67c87a88cde4f..b5def30c3127e 100644
--- a/net/ipv6/netfilter/ip6t_rpfilter.c
+++ b/net/ipv6/netfilter/ip6t_rpfilter.c
@@ -61,7 +61,7 @@ static bool rpfilter_lookup_reverse6(struct net *net, const struct sk_buff *skb,
 		fl6.flowi6_oif = dev->ifindex;
 
 	rt = (void *)ip6_route_lookup(net, &fl6, skb, lookup_flags);
-	if (rt->dst.error)
+	if (rt->dst.error || !rt->rt6i_idev)
 		goto out;
 
 	if (rt->rt6i_flags & (RTF_REJECT|RTF_ANYCAST))
-- 
2.55.0
