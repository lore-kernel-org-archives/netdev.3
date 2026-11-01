Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515463;
	b=BoCpeururefLBATH9Ylco3jnLpcTF1QeZLZEaGRmYmhY1SBCRMDACfhbKdOew9/HD1Im
	 1a6L6xmYZyREN4dxDx9utI70UGerqBFMW2UKGRJEQTR0EOV1O4BuePf+R31glC+Kicpey
	 bqvkLA0hiPnvpHgIC/hVTwK+Fnrzt1acdH9j2CUWMdwvmfPhf93M980CSxW5aN3uhbNNY
	 yRt5CXgfZha8Ha0Kku60DLKX7S09cWrCpX7xBAcGxF4IISNuLDVI87gT3XR6kOOMN+JDN
	 dlSRQcO+lgFR5ksfYiL14FMAVdEzMw39RN9j7itZgh8UkMhwwxUCwTIK6nZG5O63XuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=5Ev7O2wtjipyW52mLBQqnkxEqb7oWc9PFrK8Po62zno=;
	b=tEdn4wsByMEuncikBzr1SyTBN2/sUCLy2i/YpYddRNHhzvwCItEDsZxzcP0LA29FXj2y
	 5mwaVWxBOmwrYsBPS1NmPg3ohx/wXCEuxWvukiTzJG9f/J9c7NAXmAMDAZQGbV/AwXMLH
	 hivDlx2FU3eZNkyuvNRAXbFBRDthIRxSoQcP+XdoAIG6XXl2oCoKs6E1YhXm01t3EpD9j
	 AFjDClaNOHW22a/vQ6yHTD9ilRbLTKBL6n69xy9HKnUUxdq1TilPaThhH/el+mwzJOkRl
	 LqLR02zIe9HS+wJX9ECdQ/C1wzRXjUg2ZhOVSwvamUzAnGWOLImaah1IU0UcW6ijQpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QJ0tRNtV;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C9606A327
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 06:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 811C9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QJ0tRNtV
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd8b299b05fso1660850a12.0
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 23:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793515463; x=1794120263; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Ev7O2wtjipyW52mLBQqnkxEqb7oWc9PFrK8Po62zno=;
        b=QJ0tRNtVw0UBJcI+m3zD77D26sKHAAhU5Iy86+mFSogbYweS26vJlwcF/CLeTTL+YF
         1i4g1BDkBdJwl7Fce3yz4m68nDOmfdonf+ysTL37zSz4mVvyEuZoNSjhkmVye4bzX6GT
         XdZ/X42g8UTtn4WKnkpWBfJHw9DDGimtcAmlpCYKpFGMSKW/ADebticYZrtlW27emwpw
         I8ikQcrZcXYFO4RgDe294nx0NNMoeQa94z/JpF7DpNLJ89SApAs+VrYp3xrfMRJ+k1sm
         4rGQNDqHO9lsZ2Bb8A2ik31ABogxhhyq3J8XYDVIM8URMFdCRgUcjP66hCaUYtNe9j2y
         eLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793515463; x=1794120263;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Ev7O2wtjipyW52mLBQqnkxEqb7oWc9PFrK8Po62zno=;
        b=bahlEbs/K8lUO4dDdm8sNZYszz1c8/mJOIVWzZCeSSYEej6fJoZfB2ObvOMrUbdPsC
         IDkvghHpw69sHBnlFF7hk0oMtyGo3wqIHokIFg60yfJmGU+Kh7QolbTpkVjynUIaoEH0
         QqGbbiAx+eQlsP9PvHjAxRZJ4wT67nLZ2koxdUFGqbM6K3Y5OxPUnGIBpDjijp6sYXyL
         2LMmYM99dFRuIUyqi64m75U4s+PNl6hTb9P+4b6RLNna+/979B+TGUxoZ2qUUn5n43Cr
         r4043vrE0DysfylJONkZcLDS66uNi3ER1ErmPhcBIVeeLLSJeYgnW3WFmi40zjmV7Jpg
         J7wQ==
X-Forwarded-Encrypted: i=1; AKwUvBzi8jypL7AOWGX24B2Vt+8fFroQcTyuJeCsogv1nTsQFgqx65iizqT14G2VqwrUJS+xQrzyRs4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nlo6lL/6ceS12eYK/QAzkQHsxNr5/lXyvaq7jGKD1/v0FSQ4c
	q+qqjFzn1VsS48InpmXpLXoAbvzhXsLVGyW262T5gOPc0f2bbRsfXqyyO9rncGqaJIWLUIgCigi
	qSLairQ==
X-Received: from pjnm2.prod.google.com ([2002:a17:90a:8582:b0:3ab:c373:bf62])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48d0:b0:3ac:80de:44e8
 with SMTP id 98e67ed59e1d1-3ae8983c697mr5327256a91.43.1793515462592; Sat, 31
 Oct 2026 23:44:22 -0700 (PDT)
Date: Sun,  1 Nov 2026 06:35:24 +0000
In-Reply-To: <20261101064418.2055158-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261101064418.2055158-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261101064418.2055158-4-kuniyu@google.com>
Subject: [PATCH v1 net 3/3] ipv4: Call rt_add_uncached_list() if !do_cache in ip_route_input_slow().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jason Zhang <jdz@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since the cited commit, ip_route_input_slow() could call
rt_dst_alloc() with vrf in the local_input: path.

If res->fi != NULL and one of the following is true,

  - a non-zero itag from fib_validate_source_reason()
    (realms/classid)
  - RTN_BROADCAST with BC_FORWARDING enabled

do_cache is set to false.

Then, the route is not added to rt_uncached_list, so the
route cannot be removed from rt_flush_dev().

If the route is cached in sk->sk_rx_dst, removing the
vrf device gets stuck. [0]

Let's call rt_add_uncached_list() if !do_cache in
ip_route_input_slow().

[0]:
unregister_netdevice: waiting for vrf0 to become free. Usage count = 2
ref_tracker: netdev@000000008b304ac4 has 1/1 users at
     dst_alloc+0x14b/0x490
     ip_route_input_rcu+0x1540/0x2530
     ip_route_input_noref+0x5a/0x90
     ip_rcv_finish_core+0x4b0/0x1140
     ip_rcv_finish+0xe6/0x190
     ip_rcv+0x6c/0x130
     __netif_receive_skb+0x121/0x300
     process_backlog+0x2df/0x5e0
     __napi_poll+0x8c/0x380
     net_rx_action+0x43c/0xab0
     handle_softirqs+0x19f/0x520
     do_softirq+0x46/0x60
     __local_bh_enable_ip+0x79/0x80
     __dev_queue_xmit+0x1b0e/0x24c0
     ip_finish_output2+0x8b2/0xcd0
     ip_output+0xf2/0x1e0

Fixes: f5a0aab84b74 ("net: ipv4: dst for local input routes should use l3mdev if relevant")
Reported-by: Jason Zhang <jdz@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/route.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 93b9f4189525..3a90c8d28b94 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2494,6 +2494,8 @@ ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 		if (unlikely(!rt_cache_route(nhc, rth)))
 			rt_add_uncached_list(rth);
+	} else {
+		rt_add_uncached_list(rth);
 	}
 	skb_dst_set(skb, &rth->dst);
 	reason = SKB_NOT_DROPPED_YET;
-- 
2.56.0.317.g454f8302e1-goog

