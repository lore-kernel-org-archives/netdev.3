Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1554763
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455097; cv=none; b=L0vAjbrJpyTX6FfDovgnFq65BrAtgn7ArmsEkBDHuAF7k9EoHYxLujmHrufuHQE/AXv1zkquQ44NNfLlikinNCW1t2Pjrpfwz0lYot0QDOcfKJdjbep2nd20tr9f8gCqcyfn7fZAK5j9dg+8GjEBH7+oR4ydEVQB8k2CCUF+nuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455097; c=relaxed/simple;
	bh=lvuptta3Xj28T/29xjUn5Oq5WoYosmRKl4EvGEpfN5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cg3pRSqkDu8wosBo0QMrpgQTTMR9a9AndMB0cB9AqbBlHqNchpH2D6rW0GI/lCp+xKOJ++LOXsX3rdZdo3GZrauj5BUiAr9V6AAEKlA4eV+80PDt2MbcugAXHO9Od+oefDJ7xVjCTa9F/CI3vdJY36FmbnbPV1B6bwz4gNc/BEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=J4NenWCZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="J4NenWCZ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf452def93so8694335ad.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786455093; x=1787059893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=meZ6vcy5dVy2WOzLtFxTY8KPKlGRsfCdi4ePuXmN4jA=;
        b=J4NenWCZsd5AxG4yqz/fl8bO4kxxjZvQJrPs1P8eUDNmhb07rsvmfO+D1P5v25I1j6
         FiW5UIw3+EbXQ0J+hPbe6HdODywTnD6Ow05oBok0lasyxXbGazAjUOyzttq371L1UftL
         LLDkCYxjpluxkVRaUK7azVX4nobYbdFqEa8mHrAT6DWH6bl0Zm9Z9OPc4Hm8ukf8PDuY
         qTQSQLqQqVv3X8GEmwsZV21jZWlGz+tfrCXxS6Z+obrDiFmbVPoqMOXvfLngscAIhLh0
         QE6kRwU4ui8DvYn0xD9b2cyXKlJRgTL9rEWIhaEgJOrd4weI11z1+jQg/2BON5ZqmDk4
         1blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786455093; x=1787059893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=meZ6vcy5dVy2WOzLtFxTY8KPKlGRsfCdi4ePuXmN4jA=;
        b=NHC300NHRhUbvwO0Gaj40Sr7YkO6aDJbxLUbilAn7iLtH0z5SmK1zzciLrdS4pOjAQ
         G37Ai6uCseeWMEse0ZOQ8lE4FE6qua2IzHX67d+e9tpZZ1VyXBFlG4wko1cyGDkr8ccr
         RHuYsx1KxXDlWdfEL3ohapkpVFGhO+HwqftxOHbJFjuw3v4cKkWbtwM0EmLkH3Oy6qOH
         98adF/049gdDazGhKZGY7aFjWFvi7YPjnuoEKiUuSsH6YSr2MQeaJHBNTufEr06hrzjy
         DF7yoSR9R7YCz2qnwvVwufOJ7KuuaSwyi8P2OMrwkQUZFcICw1Th1RR373bN5gD5YRNq
         8o4A==
X-Forwarded-Encrypted: i=1; AHgh+RrNugYGOe0tScAL/XkmG+UFCPZHRXsA8V1jz8t0dIfLwyoyqq+X8NQ5DdmZQu2d9L1fQ+DGXoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEgCqPTpwEZ6Gu8ShLkXGfjkFWbLVI3fv2AoJeLoFZjT5Cxny7
	vfWTB7PDGT1aGZlttk6LmmgIf5oZrUGAz8URcKDl19CCIlhMtVUFwMr8GFrdMOa1SrN8
X-Gm-Gg: AR+sD12L4Ikz/YqTZF6/MIwWlc985YqiLUJohvdZvprIVmPVX195kTBoA0WGnQBwgUs
	BLRx0+dJ2lv5mm9wsHb5u6o+S5lxH1K8I+fma3epumCTGQ0wS4h6zaf8msDH6ueBk/W0tQxUeRd
	aMx4Toa3dsqGHJN+9p8FEeX8OmeB31jPmrzeXK5f2dm/BPR8V6sxXy1RWZrQgSkz8ncLxQ7Rcu7
	y/Myvg9VB6Ug5yZLKs4fZiX6Z8iPKteNucN9euhSjON4U1tzPb3Ss+t1E52nGlYEXjAtH+8Q1Ho
	4lwL9YdIqdLBc57Z/SxIL2lYkFJEDb78ycwu/En8B1lOxU7a8UbbdijomRmVVmIqECF/msklpDp
	OaaGCMMsmy9cSh+obRQoC5MEPCGDzIHdSKpaW0yvYmzw7xTdqE6PbxB3xMv3J6HfE1VEuFk0urv
	1P1CdDieR2zLlQn7YIgD8sJncNNalSSi6la3v5mFd9gt4sSa0LDPkcrVzr+fIoqPlQ/UhkHFHER
	Cr6
X-Received: by 2002:a17:90b:48c1:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-392f3f482c2mr79744a91.5.1786455092999;
        Tue, 11 Aug 2026 06:31:32 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5195a4dsm4213218a91.4.2026.08.11.06.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:31:31 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tom@herbertland.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v2 1/1] ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
Date: Tue, 11 Aug 2026 21:31:11 +0800
Message-ID: <30807a062ccc5c9c8a5ec2c5eb805ef279c50bdd.1786452593.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786452593.git.zhilinz@nebusec.ai>
References: <cover.1786452593.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6_tnl_xmit() may need to expand headroom before it can push the
outer IPv6 and optional encap headers. It currently does that with
skb_realloc_headroom(), copies skb->sk ownership, consumes the original
skb, and then continues processing with the replacement skb kept only in
its local variable.

That is safe only if the helper cannot fail afterwards. But this helper
still has post-reallocation error exits. collect_md tunnels reject
non-NONE encap after the replacement, and ip6_tnl_encap() can also fail
later. In those cases the helper returns an error to its callers while
the caller still only has the original skb pointer.

Both ip6_tnl_start_xmit() and the IPv6 GRE paths free the caller skb on
error, so they can end up freeing an skb that ip6_tnl_xmit() already
consumed.

Use skb_cow_head() instead. It provides the required headroom and
writability without privately replacing the caller-owned skb, so later
error returns cannot leave callers with a stale pointer.

The Ethernet users, ip6gretap and ip6erspan, clear IFF_TX_SKB_SHARING
and already call skb_cow_head() before entering ip6_tnl_xmit(). They do
not rely on the removed skb_shared() reallocation. This also makes the
IPv6 tunnel path consistent with ip_tunnel_xmit().

Fixes: 058214a4d1df ("ip6_tun: Add infrastructure for doing encapsulation")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
- Explain that ip6gretap and ip6erspan clear IFF_TX_SKB_SHARING and
  already call skb_cow_head() before ip6_tnl_xmit().
- Add Ido's Reviewed-by tag.
- v1 Link: https://lore.kernel.org/all/7f099879785257f4d57d6caf9b6308fc76c7aaea.1785734738.git.zhilinz@nebusec.ai/

 net/ipv6/ip6_tunnel.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index ebf83f090376c..6a1b901ecc9b8 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1236,19 +1236,8 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	 */
 	max_headroom += LL_RESERVED_SPACE(tdev);
 
-	if (skb_headroom(skb) < max_headroom || skb_shared(skb) ||
-	    (skb_cloned(skb) && !skb_clone_writable(skb, 0))) {
-		struct sk_buff *new_skb;
-
-		new_skb = skb_realloc_headroom(skb, max_headroom);
-		if (!new_skb)
-			goto tx_err_dst_release;
-
-		if (skb->sk)
-			skb_set_owner_w(new_skb, skb->sk);
-		consume_skb(skb);
-		skb = new_skb;
-	}
+	if (skb_cow_head(skb, max_headroom))
+		goto tx_err_dst_release;
 
 	if (t->parms.collect_md) {
 		if (t->encap.type != TUNNEL_ENCAP_NONE)
-- 
2.43.0
