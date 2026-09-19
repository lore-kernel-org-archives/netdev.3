Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79835A398
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851983; cv=none; b=klPCNYiOdbINlOG9JKcGIJi/s4o7KNEaY28rwR0mC49JjKj4eR3Of+YY1WYBOPE0YnwdGyo9SxZYrUk+fMoDcxQfK2RtW6vvwZCerjC9gy1FeZh9RwSARNMaaU3claZEWM+1Sv6cgEDHpwTQskLyo8iq5hXuHZXz/y0hiDGWh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851983; c=relaxed/simple;
	bh=bQt71qds/ETlV3MaQhtxMntNA5mIVvUT56qHS7ozc4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTDudYUWHJUOZgfomZUBybb/ysuQM3rMN0EFeRuJhk8o5AfEbsIIm7/jkdlDJRLcXtddF7AC+DNs3esWaLhhn3RgvbunelvkefpJz4eS8waTiiFj5j1ZiE/68QfK9wfrthsd8nVpeQLjRfc/E2KkvQgy8LFadO4bv7iqpaS2BKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbZYXtqB; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbZYXtqB"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c3304784so1616758a12.3
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789851982; x=1790456782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hrS1SeqIDZottndBkhcKc+LUT4GTeQPPCofsIBFZYoI=;
        b=kbZYXtqBwcOYQ0iTEGDPhJcc8ez9rJ8N7VDHxw9SToDNGgyYo2UG6+czD8XTIZrWh6
         qW9jxu1xCHyx55SbqzBOUb8xFP1pWMtcem8W7a2zOo1VBzZj2P5hoybdWc5K2ENRL8uD
         A+nmvTJUabyIy9CpawrCaH5A/UGK6nZs0Jm7L0xNCXyvCFodZlTEPlibE5Nied3aOOCm
         lamQNTor2ZK9KCyCx4mwW7G5NMUILpmgkf9oFZUu9gpvLogXqF/Eqo5/aWQ19McsN5s8
         kDT4b+ktIrFE1D6htAfjwjUlhqCSnWvz/ub9x8czhpF/LoXgWBE146cnrSCBssoM6zjL
         aZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789851982; x=1790456782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hrS1SeqIDZottndBkhcKc+LUT4GTeQPPCofsIBFZYoI=;
        b=KOMdzP6lps+ZULvTRHgeNk7yAFlnNdHwZQejzn13WsQQZHwLc+sIBhp/bsaOFJfDBO
         tlMAIDQcc0taS/6Y1ublGFIG69gp22pZ/NMzhiKVaIapW1G0NJSUxy9KH1vQnGeGgXoQ
         XjaW04bSDpEjxrBlY3nJvPxdUVsliDsHERMApswZOUJCCBRVDeZ9RuEiSdZH7QdQOyxO
         YUrzBt17+LAJe49/DF1si+LynaYkxrk8+/uaXPB/xIAhUo1vYOvMTvv2bskR2sFXjZR2
         cmVoREl/uGRl9T4u5b91eVvOx0oZeENp4e40yR8k5RSupev9eSpdx4Wc7q34ZlhklEzB
         f5og==
X-Forwarded-Encrypted: i=1; AKwUvBzxvpq5xN7c1lkRsUliePQYAYUiASLNuKM3DhsKrsWz4mdzU37Iz3HUs9hjC76oB1wqGY/r1+k=@vger.kernel.org
X-Gm-Message-State: AFuF++mn5/KdgmKIgxyJ4qSJ0f2oh5YOqdRfj4/ml3VOlwi6JATl6jm5
	zmCJTAPxUmC7UzC2XcJfLGCE2VxN+YcNdlUimjdIh4PUikGbO9fUkRTqwxze7CI6
X-Gm-Gg: AYBFou0wbhEyC7zCgRO9dytOwSoF+VPNM/kyxfME5aLAw3/RDeEogzI6m1n0yNR1jDV
	daY9VYHZ3uyIym9Md8nzVRPU4qbiN51vdv6P7XW+k4jYGRatPKsmVVV++tAVvxW7KOY5mSZ6ORg
	SRSlNSfxGnoDKqeNrZgL9b95ndsmFM4q/6bqavFGrXy6d+z9w5U8X4rZ24UPHm7+u9REBVyPQhl
	iBGfhdVCawX4PQpXzT1S72rbQUUflaeFpQeSWwSTirq3c5Un7pXTnbhy3PgT3YkB9doRZSzpIk/
	v1SJYhezYTpxW4Q5111Ta9p+/yuk0pZYbgsk9sHq2C5PEYXVxjU2z4v/XPjdJGZA7bHdGn0XH/9
	jBco5ptVH0ll5h/wYce85SKvxQmgMoXMubXKT1BmDF8n3viMhrELefbfpVy2jC5QtGT2WzsIr7I
	hGtsIWH5tw5VE2z2U7B34C8ArFACDaf4oeGHDB9fduS2LPOmtrKb7o15Fi+xqIYbG9t6SjIl0T/
	nnHYu2MOER51MedUXbGQFuQLSYYVuydZV62qoTvcaTaAi8jrhkQ7btbtvukkR0gGXaPPCgVpi9l
	I10j3+D7NQ==
X-Received: by 2002:a17:902:dac2:b0:2dd:c100:7cc6 with SMTP id d9443c01a7336-2ddc1007e7fmr52950545ad.66.1789851981674;
        Sat, 19 Sep 2026 14:06:21 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc16b67b5sm13013095ad.4.2026.09.19.14.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:06:21 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: fix payload_len inflation in ip6_xmit() when IPV6_RTHDRDSTOPTS is set without IPV6_RTHDR
Date: Sat, 19 Sep 2026 21:06:20 +0000
Message-ID: <20260919210620.3029622-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ipv6_fixup_options() was introduced to ignore destination options
before a routing header (opt->dst0opt) unless a routing header
(opt->srcrt) is also present, rawv6_sendmsg(), udpv6_sendmsg(), and
inet6_csk_xmit() were updated to normalize `opt` via
ipv6_fixup_options(), while other callers pass `np->opt` directly into
ip6_xmit() (such as tcp_v6_send_response(), sctp_v6_xmit(), and
l2tp_ip6_xmit()).

In ip6_xmit(), ipv6_push_nfrag_opts() only pushes opt->dst0opt into the
packet if opt->srcrt is non-NULL. However, ip6_xmit() unconditionally
adds opt->opt_nflen (which still includes ipv6_optlen(opt->dst0opt) if
__ipv6_fixup_options() was not called by the caller) to `seg_len` and
writes `hdr->payload_len = htons(seg_len)`. This causes the transmitted
IPv6 header's payload_len to exceed the actual packet payload by
ipv6_optlen(opt->dst0opt), causing receivers to drop the packet as
truncated.

Normalize `opt` with `__ipv6_fixup_options(&opt_space, opt)` at the
start of ip6_xmit() when `opt` is non-NULL.

Fixes: df9890c31a1a ("[IPV6]: Fix sending extension headers before and including routing header.")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/ipv6/ip6_output.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 550965058991..17d6add40864 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -295,6 +295,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
 	struct inet6_dev *idev = ip6_dst_idev(dst);
+	struct ipv6_txoptions opt_space;
 	struct net *net = sock_net(sk);
 	unsigned int head_room;
 	struct net_device *dev;
@@ -304,6 +305,9 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	int ret, hlimit = -1;
 	u32 mtu;
 
+	if (unlikely(opt))
+		opt = __ipv6_fixup_options(&opt_space, opt);
+
 	rcu_read_lock();
 
 	dev = dst_dev_rcu(dst);
-- 
2.55.0.1082.g2b9226bbc0-goog

