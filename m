Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6FC2C1788
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595159; cv=none; b=s0141EiXOF/u1sy9Sy+Nz7P/3zY32kO3l9+RvC4DXsZ1bu/+mPXrZ2WXTiuk6kCSL17LyIwFxfXMy3HnZ3ENrCh8ELIPX3C0UK7YNSfP3MjHnzxCKA0T34TjNkUJ674X1X+ak5KUU+Ms8MJlI5qyX4UchPJNVbkkg2eJJWSR5aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595159; c=relaxed/simple;
	bh=wOJaN8GAxx6NH9MYsunfI2Xi3Kx2+d7D/S41XA8A0fg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OI+22mUqGF7XZYULjNTF1HBBCI8R//HnEjZi/9busBCGm/G0gGHndcGmGFHX0gCBOeCCMl+eRJfKD2Snabeyao0FvnSmlVaMOWij21rnZSdKCw+GsRWDDE2ACWjiW85c2EKi9+VN4o11GzNh5kPbDmi2KagkDwi/XBPI8s3RCdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LiJfUkKU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LiJfUkKU"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7dd5d43583fso20387037b3.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780595157; x=1781199957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pd1goQ0s/WMqKfzdr3UizRBsE1LqwR+ptuqSVy/nbuI=;
        b=LiJfUkKUmu6o/r8np52BreFesjWRQIFJ3XrXJoGQDZf+kPjtNk53B9Z+0zRag4G4B6
         grFTXSCjufcjRwSgivKa9U8WKaNttUc5EWcCCFkGRePpeW6nvQ/mJC1mVYuANP2dWg+F
         lA53V8RPhbo5CrMvdPwnO+FZRTHZV9EDCDxnkFfH3oPgalFgLxghfyYInPo1+r8c+0iC
         +DfzAqvCSpYCpptPcOJGoFXmG5DUFj0iXE/7KyhdcGsQXxd3JeDuA+m2mWrGVWXkg/S9
         w/+ejDi/QhfwchQJEDXgl1JXrnW9qagVH4LwGF/IL4gqiTyJWzQ0yyKYgyf5PEaYKvV7
         PrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780595157; x=1781199957;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pd1goQ0s/WMqKfzdr3UizRBsE1LqwR+ptuqSVy/nbuI=;
        b=Fi3bfdLTsfJc5XgMWpU1Wy6kRAB2K4fA004lC+VRW8UcQ6zMnvJXdO/7Q8hunPyN37
         dG372zV5YyVajLuwOUCn4cqlt9oghW8A5KYIRFAdLDp4vZNYHXHlstsnwqHWJ9JEd4ix
         7y/iz1C5yF1rxkeMthk5mdxy8hNHbeVgf8mf2K097Bz3slFXzHTeE4dqQn9xF6jpP6/u
         3EH1Ac2+4jfuZURv2VIw3flbSyuCcsh9gOa8OL2kHwpbMREuNcbLWAfq3Rz4Nab8HaFz
         ZRxilVxMT8mU2iRNkKTzvo67ub3G9gxKb4chH96yqoJmngao4ZsyLdcAjvXCBrLYYck/
         ++tw==
X-Forwarded-Encrypted: i=1; AFNElJ/276tGAkLUp0si0djmenGi8IzPai4A+P6a6A0xuKRtTelMyTsgZU8BWaAi4Sw9e4TISLPCxtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/6Gf54H8LiBTHR9DZOzwnZsbVNEZqn0IhxJEqvqyjOsQ/FTxP
	y1DdY+9hMbiswfzakmlvoV1WvpXaqCdPIKVbrsOADAeUlxB2RCML3JrNUmgRHboRnMDoVTE9aNJ
	RYh0SDgKN2N4r/A==
X-Received: from ywbgj4.prod.google.com ([2002:a05:690c:4284:b0:7ba:de28:5507])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:45c7:b0:7dc:aa85:5c67 with SMTP id 00721157ae682-7ea49584a3cmr82999407b3.11.1780595156715;
 Thu, 04 Jun 2026 10:45:56 -0700 (PDT)
Date: Thu,  4 Jun 2026 17:45:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604174555.2801532-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: remove obsolete EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These symbols don't need to be exported, they are only used from vmlinux:

- inet6addr_notifier_call_chain
- inet6addr_validator_notifier_call_chain
- in6addr_linklocal_allnodes
- in6addr_linklocal_allrouters
- in6addr_interfacelocal_allnodes
- in6addr_interfacelocal_allrouters
- in6addr_sitelocal_allrouters
- inet6_cleanup_sock
- ip6_sk_dst_lookup_flow
- ipv6_proxy_select_ident
- ip6_sk_update_pmtu
- ip6_sk_redirect

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf_core.c | 6 ------
 net/ipv6/af_inet6.c      | 1 -
 net/ipv6/ip6_output.c    | 1 -
 net/ipv6/output_core.c   | 1 -
 net/ipv6/route.c         | 2 --
 5 files changed, 11 deletions(-)

diff --git a/net/ipv6/addrconf_core.c b/net/ipv6/addrconf_core.c
index fa27a90ab3cdd4daacbc88e2fba2f3b2419d503a..29095c90aa16b19fcb7a7fff1d5b99c2150563aa 100644
--- a/net/ipv6/addrconf_core.c
+++ b/net/ipv6/addrconf_core.c
@@ -107,7 +107,6 @@ int inet6addr_notifier_call_chain(unsigned long val, void *v)
 {
 	return atomic_notifier_call_chain(&inet6addr_chain, val, v);
 }
-EXPORT_SYMBOL(inet6addr_notifier_call_chain);
 
 int register_inet6addr_validator_notifier(struct notifier_block *nb)
 {
@@ -126,7 +125,6 @@ int inet6addr_validator_notifier_call_chain(unsigned long val, void *v)
 {
 	return blocking_notifier_call_chain(&inet6addr_validator_chain, val, v);
 }
-EXPORT_SYMBOL(inet6addr_validator_notifier_call_chain);
 
 /* IPv6 Wildcard Address and Loopback Address defined by RFC2553 */
 const struct in6_addr in6addr_loopback __aligned(BITS_PER_LONG/8)
@@ -140,16 +138,12 @@ const struct in6_addr in6addr_linklocal_allnodes __aligned(BITS_PER_LONG/8)
 EXPORT_SYMBOL(in6addr_linklocal_allnodes);
 const struct in6_addr in6addr_linklocal_allrouters __aligned(BITS_PER_LONG/8)
 	= IN6ADDR_LINKLOCAL_ALLROUTERS_INIT;
-EXPORT_SYMBOL(in6addr_linklocal_allrouters);
 const struct in6_addr in6addr_interfacelocal_allnodes __aligned(BITS_PER_LONG/8)
 	= IN6ADDR_INTERFACELOCAL_ALLNODES_INIT;
-EXPORT_SYMBOL(in6addr_interfacelocal_allnodes);
 const struct in6_addr in6addr_interfacelocal_allrouters __aligned(BITS_PER_LONG/8)
 	= IN6ADDR_INTERFACELOCAL_ALLROUTERS_INIT;
-EXPORT_SYMBOL(in6addr_interfacelocal_allrouters);
 const struct in6_addr in6addr_sitelocal_allrouters __aligned(BITS_PER_LONG/8)
 	= IN6ADDR_SITELOCAL_ALLROUTERS_INIT;
-EXPORT_SYMBOL(in6addr_sitelocal_allrouters);
 
 static void snmp6_free_dev(struct inet6_dev *idev)
 {
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0a88b376141d70217d96976b7230fd4a34519d43..b6a794f6c042ab8de2ba4f0fa56ad9ebe7f9d243 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -498,7 +498,6 @@ void inet6_cleanup_sock(struct sock *sk)
 		txopt_put(opt);
 	}
 }
-EXPORT_SYMBOL_GPL(inet6_cleanup_sock);
 
 /*
  *	This does both peername and sockname.
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index c14adcdd43960ddd8856a7ab2f9775589a4f79c0..9f1e0e4f74641550ddc08136e93a0cd283fa4c92 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1332,7 +1332,6 @@ struct dst_entry *ip6_sk_dst_lookup_flow(struct sock *sk, struct flowi6 *fl6,
 
 	return dst;
 }
-EXPORT_SYMBOL_GPL(ip6_sk_dst_lookup_flow);
 
 static inline struct ipv6_opt_hdr *ip6_opt_dup(struct ipv6_opt_hdr *src,
 					       gfp_t gfp)
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 64b1eeb79b572b8b412c60f832c4a7984ac8276f..418f21d24fb80fec094be8097fbab3e85b31b9a1 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -42,7 +42,6 @@ __be32 ipv6_proxy_select_ident(struct net *net, struct sk_buff *skb)
 	id = __ipv6_select_ident(net, &addrs[1], &addrs[0]);
 	return htonl(id);
 }
-EXPORT_SYMBOL_GPL(ipv6_proxy_select_ident);
 
 __be32 ipv6_select_ident(struct net *net,
 			 const struct in6_addr *daddr,
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 636f0120d7e38d6d7f07b43ee6673c56e77471aa..8259c7527aa4cd1ff5709ea24cf4ab7b729c52b6 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3044,7 +3044,6 @@ void ip6_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, __be32 mtu)
 		ip6_datagram_dst_update(sk, false);
 	bh_unlock_sock(sk);
 }
-EXPORT_SYMBOL_GPL(ip6_sk_update_pmtu);
 
 void ip6_sk_dst_store_flow(struct sock *sk, struct dst_entry *dst,
 			   const struct flowi6 *fl6)
@@ -3255,7 +3254,6 @@ void ip6_sk_redirect(struct sk_buff *skb, struct sock *sk)
 	ip6_redirect(skb, sock_net(sk), sk->sk_bound_dev_if,
 		     READ_ONCE(sk->sk_mark), sk_uid(sk));
 }
-EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-- 
2.54.0.1032.g2f8565e1d1-goog

