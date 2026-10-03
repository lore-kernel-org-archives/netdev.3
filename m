Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C4939B949
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062626; cv=none; b=IWYsfb7Pq6jPOPTmMbWFc1vn7dTT6pfiAKjeqoJw/ee2opvy+C9aDz22SID84kkOfpcFdb7eQ3CH3+jpWKqCeWRIS42qDAI5FPAdE8EXluQnY8okZUETlBM7r24WvVX9wIzyV4gSeAGI7uK4AuMNVJbXPsq1dzbCr+lki/cxhf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062626; c=relaxed/simple;
	bh=ThoT7cXfDyyrpjdI4GGUDFw/EtThazkBFBTRFFAW/OI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZTqDu7MqMvacbmBuL7W1u/TEb1oF5EpzqTNt65k7IzMhY72i0wfapnhqoljm4zN1qnF3jSZF1RMzjlQuLcsQscT5wnZTNyyFzDItJtDv+InaQBEdydhFKQ20wNBsZ8uMjRwyCM22Hs7E+9DcuTnv/2laEAljf54PBn70SoT6X9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDFc14oz; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDFc14oz"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-88a2c5d7ef1so804099b3a.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062625; x=1791667425; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c0OjECR4PbKu7DNQWWCoLM1tH92ztwNdu/t4kIPA7nQ=;
        b=KDFc14ozYF7q03c5BSg8Q+bgyIqXXeggfHl64L68pMX0f/+h8GsUn+53UaPmKTq0NP
         5iZ03ZhN6hO8QMERZ2MaUxz0WK8FSx6M8NcPvAA1KDVtoml0oSf2eR02erWkEjybal5d
         fBZK//j4rPeE4vMrsaPIJD+AotMDzY4DvIWwS6/TWQ6KYVxj5gpI0fh37qO/EoE2iM5G
         3RkUs6Z7mr7ZwvQQgyfn9PeHzzkFx7OMPp4wgzXDTmW511gCBrNuN7aQQJvkZQ6mv/Yz
         xJC2fFiBqEt6kK6k/KAZm51XbPg+MdJlT+YTduSfMHv8YdcjRHGmvk9z+FN3bXH5jh5W
         in3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062625; x=1791667425;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c0OjECR4PbKu7DNQWWCoLM1tH92ztwNdu/t4kIPA7nQ=;
        b=gE1RrOo+maORmS4KsWYoIFPBEbqiqJgT3zPK8vOsNwlk4407JA7ZQiMVAjUn6/NJKU
         rYf6CUfrBjeeTf/y6DNCXPQeCmfy7guykl3L4r4XNIbA4KFHg6YwEEa3BpKQSKl7v0YW
         1XXjWTjnMSLEqvXVGg7Xuh5Gse2zomBiXX+Xy//qFTVOWJ9lwaoKOW5hIQySY/kgTveV
         osSLG5OdGCbsYG1U/a3fLVl6qQGV+UF2/euCSQy9pbs3Gyw0padQZE3Z/7DBFqYgfG5b
         e9G1Av7TrgUhGuFuJXADjkdQzxMvqZWFEvC7AVxDhAUlMnqUAs75r4qrm5sBeB3YUg2h
         QjVw==
X-Forwarded-Encrypted: i=1; AKwUvBzoNQ44q6wADHB/8+2cJuvkAnJ8kF8rcO0yzXENp6tWCFhB2IAXz3T2AsqoO+Vk0y7duxFPgN4=@vger.kernel.org
X-Gm-Message-State: AFuF++mWQ4HGM8J95asvWXUVfAXf/bTV5V+1E3PXcowL8ksUIfn2b3V7
	ySQ+sURclO8lAZTNhmfr8cVESqBGG6kCEwA5kUugw2x0l/yBWWx828o4HrG11jPeQPNZ6I4gcQp
	FLWOTyQ==
X-Received: from pfme17.prod.google.com ([2002:aa7:98d1:0:b0:88c:18bb:95e6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:846:b0:882:ace7:88e2
 with SMTP id d2e1a72fcca58-88af54f765dmr6515134b3a.12.1791062624500; Sat, 03
 Oct 2026 14:23:44 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:23:14 +0000
In-Reply-To: <20261003212336.1304988-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261003212336.1304988-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212336.1304988-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 1/9] ipv4: Rename ipv4_neigh_lookup() to ipv4_dst_neigh_lookup().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Later, we will add ipv4_neigh_lookup() as a wrapper for
neigh_lookup(arp_table(net), ...).

The existing ipv4_neigh_lookup() is more like ip6_dst_neigh_lookup().

Let's rename ipv4_neigh_lookup() to ipv4_dst_neigh_lookup().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/route.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d7da2f1acbb5..50c842617e45 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -146,9 +146,9 @@ static u32 *ipv4_cow_metrics(struct dst_entry *dst, unsigned long old)
 	return NULL;
 }
 
-static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
-					   struct sk_buff *skb,
-					   const void *daddr);
+static struct neighbour *ipv4_dst_neigh_lookup(const struct dst_entry *dst,
+					       struct sk_buff *skb,
+					       const void *daddr);
 static void ipv4_confirm_neigh(const struct dst_entry *dst, const void *daddr);
 
 static struct dst_ops ipv4_dst_ops = {
@@ -163,7 +163,7 @@ static struct dst_ops ipv4_dst_ops = {
 	.update_pmtu =		ip_rt_update_pmtu,
 	.redirect =		ip_do_redirect,
 	.local_out =		__ip_local_out,
-	.neigh_lookup =		ipv4_neigh_lookup,
+	.neigh_lookup =		ipv4_dst_neigh_lookup,
 	.confirm_neigh =	ipv4_confirm_neigh,
 };
 
@@ -409,9 +409,9 @@ void rt_cache_flush(struct net *net)
 	rt_genid_bump_ipv4(net);
 }
 
-static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
-					   struct sk_buff *skb,
-					   const void *daddr)
+static struct neighbour *ipv4_dst_neigh_lookup(const struct dst_entry *dst,
+					       struct sk_buff *skb,
+					       const void *daddr)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
 	struct net_device *dev;
@@ -2910,7 +2910,7 @@ struct rtable *ip_route_output_key_hash_rcu(struct net *net, struct flowi4 *fl4,
 static struct dst_ops ipv4_dst_blackhole_ops = {
 	.family			= AF_INET,
 	.default_advmss		= ipv4_default_advmss,
-	.neigh_lookup		= ipv4_neigh_lookup,
+	.neigh_lookup		= ipv4_dst_neigh_lookup,
 	.check			= dst_blackhole_check,
 	.cow_metrics		= dst_blackhole_cow_metrics,
 	.update_pmtu		= dst_blackhole_update_pmtu,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

