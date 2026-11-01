Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515462;
	b=eE8aC5eNy7WCLXB35aG99mRLS/sNYOmG9f8SezHX4IeuYdyZmh6L7BQkWPoW+snqQx9N
	 rgoU/51U2XKdJ7OiLLZLi7tA+HUg3Z/p/RL8v0GJ5mQGLBC/RYDyD51ogXKOzlY4+eD8C
	 yrASwPa+t/xiqX9aqQuyRJxku6tOA6XzqgGUCwkQ+LjPi/bZetO18YiKabuRAqzOl7XrG
	 Ne/2UPZwOQBMfkF/tPEOo1i5bR0lxaLtbKlFgUYQzP394vtqfTz6tpWdnxupfraT6Y1pY
	 ck9FaWb79AHz1+Oz3Tz9JfCT9HrgS3nO7WsYivYqVy+0xU35wINQ12NA5eyHXZaMiPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=qfkdlpdRiZpnseLQZ4bfNcTvkCrp4WZ1abTx4bw3dkc=;
	b=S/UvzsxTr0T1xit2vTOUEgd/eOEACwOMgDlXUFB4wUmjHsMpxfKoS86CCzNQZ3XGEYvt
	 qCMvtz0EOUrxdhjZpDWW9/RthuXtd0yXsHQbXnL4FdA7zMb7HO72PJ5yuBjKxQGsMxhsC
	 JwGs2kCgVFZw9ZSrTz55ZYeVthk2JUvm7pQGyxpV17huyKuxW0GOKkxHveFi65BDE8jB4
	 HiVtsiV2tfxKKeE5l5wHD7cbYVgzr8NOYzO/CozfB3ANVySB/YJIGnO+B++kBNAjV5qi9
	 nRVIPjLSgUSvh/XvgU8bD2mW7ibcA7iZjRZsUbHzXRA5ZgS3ZN0FiKQvV2ssMp8v3Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MKbeHTWK;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C118606A32D
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 06:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C118606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MKbeHTWK
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-89f9fdbabe1so2830951b3a.1
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 23:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793515461; x=1794120261; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qfkdlpdRiZpnseLQZ4bfNcTvkCrp4WZ1abTx4bw3dkc=;
        b=MKbeHTWKuDQ+kH/cApeyhjCrrGU/WFBocj5n4lkkBZv9dPO/95vlZVbLf5wk0AoOQ9
         vobRw+OuY/bjAxoKMmuKdxr7lnZTen2gDHCu8KzlKmNCj4z43rg/rp8QhVGkQnJtUavy
         w+x7eQRHswT0LvFS/Yp9MQJRyJZcZ26bR02IupyA+D5/aU3u7jAjXmaHQvlJ/f3mJc6v
         gCYNdX87TxH/0SjoXhLrUE4PAJvTBm8p0sMrhFd4H+is0oKDywK3ZD+33tT9dJ73Swa/
         m/6udqndOl+cFiDaTZBRJEoWkDF5WlAPlaTMFScD159X/7AzZUPEnQJ3rksJG2jgv52B
         yW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793515461; x=1794120261;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qfkdlpdRiZpnseLQZ4bfNcTvkCrp4WZ1abTx4bw3dkc=;
        b=zed+7kCb7uaIBQ+Z/aP8eSLVVuv8bbl1nLJoxhGhlXKDlCH/HQWNRpq3I055GOgLgP
         2lGN5GEWy5OyLjF4jiLnU5QuxZkfWGroPcprgOHJb5xuC9c9KS2DD1hqXXOZA8rnuArH
         Z4Svze5WxVVjtK5YONiM6MxETfMLn1T3/ntOIz8xjDay+4Gb+/vpdA3YHV5Ap5A1eTE7
         C1GEiPxFt7K5uNhA7fqIoQoXjALTe0a5Y+OwTr3E8HUKgxV9VThLSkpDxxKShsARwpSV
         MKngdOEHOfoC5+UymjHDnz9cSM9vN2lfIJ4kG7mw/rpJs8yHJvfbYWsBJbkdx1krTW2D
         ciaw==
X-Forwarded-Encrypted: i=1; AKwUvByeIgOW8yn2Kijk7EL6ksa+zVLMRJ+uSZqaW64rtXqvLyIY/WN/YwdordWn0PLcdQMrivO166M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxKFn0Y4EWx11hOqSVmK/5j6wWDs7mVoIVoiLguaOGWqCDfp59
	oLGAGXD5C4IQKZbVAvWq4T/cyJCXQFpoNCnLEyN3tbDzFBI26mPMLmkgrThYbSM5qqg7glVT2sm
	IIwhiqg==
X-Received: from pfbii9.prod.google.com ([2002:a05:6a00:8c89:b0:8a1:6f:7af2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b81:b0:8a0:3ef7:42da
 with SMTP id d2e1a72fcca58-8a9ba9f7fb8mr5573845b3a.4.1793515460896; Sat, 31
 Oct 2026 23:44:20 -0700 (PDT)
Date: Sun,  1 Nov 2026 06:35:22 +0000
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
Message-ID: <20261101064418.2055158-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/3] ipv6: Flush exception route while replacing nexthop.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jason Zhang <jdz@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The following creates a cyclic reference between IPv6 route
and nexthop:

  1. create a nexthop A
  2. create a nexthop group w/ A
  3. create an IPv6 route with the nexthop group
  4. create an exception route w/ A
  5. replace A with a new nexthop B in the nexthop group
  6. remove the IPv6 route
  7. replace B with A in the nexthop group
  8. remove the nexthop group

Then, removing a device tied to the route gets stuck and
triggers the splat below. [0]

At 5., fib6_nh_release_dsts() is called, but it does not
flush exception routes, so the nexthop A continues to grab
the IPv6 route reference.

  nh_A->rt6i_exception_bucket[] -> rt6_ex->rt6i->from

At 6., fib6_purge_rt() calls rt6_flush_exceptions(), but it
only purges exceptions tied to nexthop B.  Also, the route is
unlinked from the nexthop group by list_del_init(&rt->nh_list).

  -> f6i->nh -> nhg->nh_entries[]

At 8., __remove_nexthop_fib() cannot find the IPv6 route, and
remove_nexthop_group() calls list_del_init(&nhge->nh_list) to
unlink the group from the nexthop A's nhe->grp_list.

  nhg->nh_entries[] -> nh_A -> ... -> f6i

Here, the nexthop A is reachable from net->nexthop.devhash[],
but remove_nexthop_from_groups() cannot find the nexthop group,
leaking the whole chain.

Let's call fib6_nh_flush_exceptions() in fib6_nh_release_dsts().

[0]:
unregister_netdevice: waiting for gre6 to become free. Usage count = 4
ref_tracker: netdev@000000009652f190 has 1/3 users at
     dst_alloc+0x14b/0x490
     ip6_rt_cache_alloc+0x27b/0x670
     __ip6_rt_update_pmtu+0x572/0x850
     ip6_tnl_xmit+0x8c5/0x1b70
     __gre6_xmit+0x7af/0xaa0
     ip6gre_tunnel_xmit+0x685/0xdc0
     dev_hard_start_xmit+0x204/0x5a0
     __dev_queue_xmit+0xe8a/0x2550
     ip6_finish_output+0x232/0x570
     ip6_output+0x226/0x3b0
     ip6_send_skb+0x133/0x250
     rawv6_push_pending_frames+0x503/0x6f0
     rawv6_sendmsg+0xdf0/0x1310
     sock_sendmsg_nosec+0xde/0x130
     __sys_sendto+0x27f/0x320
     __x64_sys_sendto+0xd9/0xf0

Fixes: 7bf4796dd099 ("nexthops: add support for replace")
Reported-by: Jason Zhang <jdz@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/route.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 616b86f89f63..fae698c5522b 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3701,9 +3701,10 @@ void fib6_nh_release(struct fib6_nh *fib6_nh)
 {
 	struct rt6_exception_bucket *bucket;
 
+	fib6_nh_release_dsts(fib6_nh);
+
 	rcu_read_lock();
 
-	fib6_nh_flush_exceptions(fib6_nh, NULL);
 	bucket = fib6_nh_get_excptn_bucket(fib6_nh, NULL);
 	if (bucket) {
 		rcu_assign_pointer(fib6_nh->rt6i_exception_bucket, NULL);
@@ -3712,7 +3713,6 @@ void fib6_nh_release(struct fib6_nh *fib6_nh)
 
 	rcu_read_unlock();
 
-	fib6_nh_release_dsts(fib6_nh);
 	free_percpu(fib6_nh->rt6i_pcpu);
 
 	fib_nh_common_release(&fib6_nh->nh_common);
@@ -3722,6 +3722,8 @@ void fib6_nh_release_dsts(struct fib6_nh *fib6_nh)
 {
 	int cpu;
 
+	fib6_nh_flush_exceptions(fib6_nh, NULL);
+
 	if (!fib6_nh->rt6i_pcpu)
 		return;
 
-- 
2.56.0.317.g454f8302e1-goog

