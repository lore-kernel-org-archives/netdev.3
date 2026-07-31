Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA4D3E63B2
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506718; cv=none; b=Yym5zOPMb5vmgC/xvQU8TOVcdmmmyoZSeTbzKjqjUnEWopYhhR5AJ7izNcN1o8FvjXjYyc3FB3WIyFipqArGOi6uImhtD0VAk4IC6kSpic98F9lBkHskr6SzwIDd3xV0iiUuaoovR/Xy6CZEIoZL2SpjTR1es+1qvmc4aaUacQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506718; c=relaxed/simple;
	bh=DJaYyC6I0eeyH0VOiP3H/RmtqxMs3E0alLK7QJv8A1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1eVK7OeGBimOWxBwuteTS9V91QwubNg6I89/+HW8v9HLcXvK49XlVlhWehAEosW7AkdxuK8gK3m23w7/XDdRrDq+Q/EY03yJ8cty3/8HZVQhZ/OITYrKWJiD++M0O7ggCMNmgBsRzWON8P1JEi5obBHoAl0A6JA/LFrQ+Mfwj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Jw6tNxcd; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Jw6tNxcd"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f23e851626so6982306d6.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785506714; x=1786111514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X8TedcA+moJqV+IYfTUJ+9XUuKwi4pJEzGmzELAhbYo=;
        b=Jw6tNxcdLw7YHz2NMVwDfSy3Y1CeuWtXdx2j8CdFNx/rn2tTrlwfRf9YcB4q/miofI
         WteDB06GeRAj+0I6lDCzBpGnrf+36PxwMnGW5wqI66zcMP+G2fRn+RCHTS5vtJEdseRy
         eOZpSrB3ky7IJVF1+SkLn/ZphhZEgZhujmIiqqNk5XZ7Aq8zCtCQLFq4MLYU//2pDAd/
         UXwlofJ3Na7V4b6gC6ga/Cmw8JF3T0s/2c/RVvB6O0nn1bXRjEJsEXGoEqApPvDqIlgb
         zVuvvzpVQESiCIB/V5NtWS6vhAJRP5clIjJs/JEGfz5MUdjamBdLOtGdcF8Ol7QYIgaO
         eFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785506714; x=1786111514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X8TedcA+moJqV+IYfTUJ+9XUuKwi4pJEzGmzELAhbYo=;
        b=TdxKlNevXmRcM7JKlcs962Sgpd5k97fsNOxImFyPiYVKTmeh7+ACViOMpzbNCG0vqM
         GOEVar2z1Iye3EzwSQBuuBgUCZHIBSSRvEz+bEawh1Eq8QQIEWV5mZa6wA3mqoVr/bkz
         W5rSUsf9h/tvOaX3u8vtJl2DxHfK/cLc+bXGiJDt0DUx3WrQw42zW63RQvijaXsVR0B8
         snH6YLRdV6wuzHA5P64zC5VwUVSJ2fwF3p3VCcba10qY8/mM6b/lINFjChTenOEuHiIC
         X3lNIV2MktQ2BXztnmg11E913Mxu+I0o2MSdh2zbXJ4tVcPf0JF0uYNYstrdLxND+YMz
         AvDg==
X-Forwarded-Encrypted: i=1; AHgh+RpLdpv4EOreNFoELenkQzYtALICrucN7AxAdXWeKp/Zrbvx6ZgxbO62Qo6l7k4P6617+pj0l8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+fOLhcWUioDtlyDkhiYOjUwo20lpdMvy43+8SPgNYJSW4KqkN
	ZnTZApzYEZDXYzpN3GVRiP29uaz/a4hfbV6Jw5iMiLMyPtCRhOOPrEesH5ttSFNeaZE=
X-Gm-Gg: AR+sD13rXr9msin/6qS/UqcjvOpK3RdSEK1FB/pqou9CiWH9KmaoM6i6QmdNVyAZuan
	iPmyAbZtQgjzJGxb1u3R8ZKT8M4iixBEes8qVQayKY7VFmObdQLwmUALA1NjuTuYNNsUQy4DTNf
	WGLfbUKB+JwC/Sbx3rbm7oOESanB/oOcYBPgxt25i27osWvm+POFBQsqs5OsbgPewmMuNBirRfA
	Uqw9NcTRlUPOQRXuHC60vQoVGQgAcsj+HGFvrR6nrSYZuISYjLUWQIXAawxXPo9z5N0ozFg6J+H
	Uit16x3HXXlgv6c9TXHg8rFtgg0kEu30N2F++RFI1UxHG9eT7o/jgqdIZuzsR7aS21wyTEE923U
	VjWLEjJ2tdgtfggly04NGEVGvT+ZtzzrgDisriyNteroRVAA9NAsOUjaFkdOpxxnkD9M5SGtcDX
	+Gk2hjs2jwFPUbnhnsiSnUs4KmXwqlT/h/RWMxPbvRxVNixqSCOREqE0y15ZQ2rdprUx3WehXVc
	Kq8
X-Received: by 2002:a05:6214:3a02:b0:8e7:8d53:2417 with SMTP id 6a1803df08f44-90842242e52mr44508206d6.27.1785506714177;
        Fri, 31 Jul 2026 07:05:14 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-908434bb4efsm11018806d6.21.2026.07.31.07.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 07:05:13 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	kuniyu@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: inet: prevent lhash2 lookups from escaping into ehash
Date: Fri, 31 Jul 2026 14:05:12 +0000
Message-ID: <20260731140512.566464-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lhash2 and ehash tables share sk_nulls_node. When a listening
socket is unhashed and rehashed as a connected socket while an RCU
listener lookup is walking it, the reader can follow the node's new
next pointer into ehash. inet_lhash2_lookup() and
inet6_lhash2_lookup() do not validate the terminal nulls marker, so
they can return an ehash entry under the listener lookup's
unreferenced ownership contract.

In particular, returning a TIME_WAIT socket makes the TCP receive
path consume a reference that the lookup never acquired. Repeated
races can free the object while it remains linked in the hash tables.

Skip non-listening sockets before scoring them. Also restart the walk
when its terminal nulls marker does not match the expected lhash2 slot,
as the established lookup already does.

Fixes: cae3873c5b3a ("net: inet: Retire port only listening_hash")
Bug found and triaged by OpenAI Security Research and 
validated by Trail of Bits.

Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 net/ipv4/inet_hashtables.c  | 20 ++++++++++++++++----
 net/ipv6/inet6_hashtables.c | 20 ++++++++++++++++----
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ba0faa9ae..563c8af44 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -415,16 +415,23 @@ EXPORT_SYMBOL_GPL(inet_lookup_reuseport);
 /* called with rcu_read_lock() : No refcount taken on the socket */
 static struct sock *inet_lhash2_lookup(const struct net *net,
 				struct inet_listen_hashbucket *ilb2,
+				unsigned int slot,
 				struct sk_buff *skb, int doff,
 				const __be32 saddr, __be16 sport,
 				const __be32 daddr, const unsigned short hnum,
 				const int dif, const int sdif)
 {
-	struct sock *sk, *result = NULL;
+	struct sock *sk, *result;
 	struct hlist_nulls_node *node;
-	int score, hiscore = 0;
+	int score, hiscore;
 
+begin:
+	result = NULL;
+	hiscore = 0;
 	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
+		if (READ_ONCE(sk->sk_state) != TCP_LISTEN)
+			continue;
+
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
 			result = inet_lookup_reuseport(net, sk, skb, doff,
@@ -437,6 +444,9 @@ static struct sock *inet_lhash2_lookup(const struct net *net,
 		}
 	}
 
+	if (get_nulls_value(node) != slot + LISTENING_NULLS_BASE)
+		goto begin;
+
 	return result;
 }
 
@@ -486,7 +496,8 @@ struct sock *__inet_lookup_listener(const struct net *net,
 	hash2 = ipv4_portaddr_hash(net, daddr, hnum);
 	ilb2 = inet_lhash2_bucket(hashinfo, hash2);
 
-	result = inet_lhash2_lookup(net, ilb2, skb, doff,
+	result = inet_lhash2_lookup(net, ilb2,
+				    hash2 & hashinfo->lhash2_mask, skb, doff,
 				    saddr, sport, daddr, hnum,
 				    dif, sdif);
 	if (result)
@@ -496,7 +507,8 @@ struct sock *__inet_lookup_listener(const struct net *net,
 	hash2 = ipv4_portaddr_hash(net, htonl(INADDR_ANY), hnum);
 	ilb2 = inet_lhash2_bucket(hashinfo, hash2);
 
-	result = inet_lhash2_lookup(net, ilb2, skb, doff,
+	result = inet_lhash2_lookup(net, ilb2,
+				    hash2 & hashinfo->lhash2_mask, skb, doff,
 				    saddr, sport, htonl(INADDR_ANY), hnum,
 				    dif, sdif);
 done:
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index b111b51d6..a9dfd47dd 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -184,16 +184,23 @@ EXPORT_SYMBOL_GPL(inet6_lookup_reuseport);
 /* called with rcu_read_lock() */
 static struct sock *inet6_lhash2_lookup(const struct net *net,
 		struct inet_listen_hashbucket *ilb2,
+		unsigned int slot,
 		struct sk_buff *skb, int doff,
 		const struct in6_addr *saddr,
 		const __be16 sport, const struct in6_addr *daddr,
 		const unsigned short hnum, const int dif, const int sdif)
 {
-	struct sock *sk, *result = NULL;
+	struct sock *sk, *result;
 	struct hlist_nulls_node *node;
-	int score, hiscore = 0;
+	int score, hiscore;
 
+begin:
+	result = NULL;
+	hiscore = 0;
 	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
+		if (READ_ONCE(sk->sk_state) != TCP_LISTEN)
+			continue;
+
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
 			result = inet6_lookup_reuseport(net, sk, skb, doff,
@@ -206,6 +213,9 @@ static struct sock *inet6_lhash2_lookup(const struct net *net,
 		}
 	}
 
+	if (get_nulls_value(node) != slot + LISTENING_NULLS_BASE)
+		goto begin;
+
 	return result;
 }
 
@@ -260,7 +270,8 @@ struct sock *inet6_lookup_listener(const struct net *net,
 	hash2 = ipv6_portaddr_hash(net, daddr, hnum);
 	ilb2 = inet_lhash2_bucket(hashinfo, hash2);
 
-	result = inet6_lhash2_lookup(net, ilb2, skb, doff,
+	result = inet6_lhash2_lookup(net, ilb2,
+				     hash2 & hashinfo->lhash2_mask, skb, doff,
 				     saddr, sport, daddr, hnum,
 				     dif, sdif);
 	if (result)
@@ -270,7 +281,8 @@ struct sock *inet6_lookup_listener(const struct net *net,
 	hash2 = ipv6_portaddr_hash(net, &in6addr_any, hnum);
 	ilb2 = inet_lhash2_bucket(hashinfo, hash2);
 
-	result = inet6_lhash2_lookup(net, ilb2, skb, doff,
+	result = inet6_lhash2_lookup(net, ilb2,
+				     hash2 & hashinfo->lhash2_mask, skb, doff,
 				     saddr, sport, &in6addr_any, hnum,
 				     dif, sdif);
 done:
