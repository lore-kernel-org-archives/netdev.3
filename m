Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598449;
	b=5YJ55G5BqCcjdSsTk5Q0kqRnfTEm/4h0Z0ddPFbUDQvHZnbnRuumcL2ijMIO41SWWnGw
	 ghS6DbWKhUW5SZqmM0PHykReB3+n0/26eONkgFXIeRIXCq1dIWuaYS84/aqyGQni548g6
	 v4x5YCGdrMt24mkuDKz+6MECIr6xaik5xey0NotGCRys34m9WWiFj3peRvusq52qIRPuD
	 ysGM56dCd1neR9DX3kHRmEbZUPd8ZkGMsz/tzBwxfHMQzMIVJ4zk0X5uZ1KQDWRCfHIdf
	 /obWZg19uus+qY558DyduAwNi6By79v2GjZnVeAzGG23bUAb9SjYIEATHGusJDDSH+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=amJUpy0muk67Lmtq4mgK06dOCjsDhS8b31fd7d7HHbw=;
	b=kZa6yraGcBmEhNqOqfIB0EFqoPC4qZzE/6CHRyS3NOiEtDFGE9ZOtlQoiCJAn3l/cHr7
	 YXjb1X/6D+pOpYx/qbLoB07g3MvKqCh8hPbgudPP3Cnulgjwel7k2He8+ssM1XmKwQ/YT
	 Q5L1w//5RGxrVwKhqkMdA4aLZSG7sn4H+QPevjca8hikcHCO6WbiPwozxweKGk4P0IjPs
	 AsKt+u++Fvpe6xl61l8JywNFjqvp/Uryj86ub9Pq7RaxwzZba6gjV6LrloZI9/GMBwUVk
	 dZXNpgd2Nj3q1L6vfOQcsWZ8pqM7GPTRynqJnhBLkrdzc74gQUXRIixhCf481jVg9PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Cr25mBJN;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93BA606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 19:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D93BA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Cr25mBJN
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67bec5dc8d4so913284d50.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794598447; x=1795203247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=amJUpy0muk67Lmtq4mgK06dOCjsDhS8b31fd7d7HHbw=;
        b=Cr25mBJNTaPYaFybl/WgcQYQZD+BXuInesiZbzsy2EXZcc+TdZKQ9R/KGTNt9/J0dq
         Ef6erL1FBd5HvgdjNNoM8g566RL2k0kDjzqAozFT6RvoXADFn3bi3aw/ko/gUQOShvCT
         pnqh716dNkuYPCobelnggPblORQ6SN/GDojTO562hoUJRyLPTZaA72U71sho/DeWNDd+
         4Jw8LqPGtLIgjdy03iZATRPhlJzmifJFqT42vzcTZk2HKDOEsM+GFAAzIYkzA/cQ137c
         D3Bijroi3RKdgeGtVzCVhlQ4QrWOHHJou89exmajFNOKS3uaDG52PXaMKRnLy/fJihtM
         ALsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794598447; x=1795203247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=amJUpy0muk67Lmtq4mgK06dOCjsDhS8b31fd7d7HHbw=;
        b=a8fQ57uNYbfdOTvhRPl40JMpELizOZvkm/B9Hpw0L1j/qoHgTk+Hk1Hn2sXKwUIK0Y
         j9Dp8BfBBXYp/EC2RR9GfGKR9m35uYbe4TGP1Y4pAL3y71R5ALkpa8r6TRS5ttRL7KRD
         S2uNf5ZLhqAHN6660+D1wsRvptv29O1XdCwrt19YFCIUDR5UkDz/kCQdVf18v0Sh7DIa
         hyzCLtQ5P+9zsK7CsQEVUEUXVr3ZxzguGPl0opgTPQx+Kh4/kG/pX+vmTC+pyXp59hNa
         RC4hTs800dd+lvkCA6kJ9HImNt32CNL5h9/YQq1iuPclvi7dUgP65eBLfU70HO+UasRL
         V+8Q==
X-Forwarded-Encrypted: i=1; AL+hErFuZhbWlE3GP6vGX+JZIx/85kEizDHs65ICKpwNcKH0xHcewxRwCGzKT2vzSt98Dka+ZUzGXDY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JeP6agJpvRvMQgMNmyvVb3P7MijXHL4Ujcq79e/p5+lNvIHsJ
	WkHB8uelNSVvDAWEpEYExXyHogezZYfFQpLcTTpMbfRo58Etd7gaDxx1q+w67j8krQ==
X-Gm-Gg: AYBFou15g1utPXUg0+ZZNH5//mytkT3+iLyCGwyKCO2SfJK5v2bW2aD7Rk7YLrGKl2M
	M+FmA4R2yjJy6umKx275aX7Kqwac8Qd1w16FkpfEIgwUV8WikQJ8s1ZDQGdUC9oQA33ObUpWPjH
	RdyYa2QORngxlWeN+I51MIyN5zFDexFzfUgVCvPnDFu7uqn5omhgWtZLW0nKz8bY8yXWK7RBvlH
	XXRzs9xFUahy2Oj/qJAzWBVNpxp+D4i4oz0twcGOaQjqkWhxJeQp0gpP1JWdExdYCgzMcghzkEg
	0YH2uMglam/Gf3p8uegjZsS3few1NJrm7YCkF/JLQJvsEp7BEO6tN52hvQ5EjTNZLHVekZZQoKp
	anDBXkikMOb/aweI0ePmkfbOlN9hLA1aOGFrNMdURxgOVwZuBDQdGW1xeeiuzGgIiiseXUijHaN
	EgdnGlouN5VblJCGO/pZLfcOFKVeYOF47dopocYtqZ/zaZNXwHBq3M1mSNNHKnaz3zEvfnTYXsp
	H3sJaxqf+oW3mtui3UMpQp7cjJjta+ajhokI6xoBFzwzB/2YbmGIaOr9TVLW90Y3DJ9eoT1nV/J
	dAIRat8bpHZZzi0SAQRJm5XKangEiwNS/Kn7PJpC1cwNa9Z2EY8=
X-Received: by 2002:a05:690e:810:20b0:67c:2752:e528 with SMTP id 956f58d0204a3-67d896a2a02mr1517407d50.63.1794598446787;
        Fri, 13 Nov 2026 11:34:06 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a433a15sm2868680d50.2.2026.11.13.11.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:34:06 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] neighbour: do not update an existing proxy entry on SIOCSARP
Date: Fri, 13 Nov 2026 14:33:55 -0500
Message-ID: <20261113193355.3820232-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Commit dc2a27e524ac ("neighbour: Update pneigh_entry in
pneigh_create().") moved the update of flags, protocol and permanent
from neigh_add() into pneigh_create().

However, arp_req_set_public() also calls pneigh_create(), with all
three set to zero. As of now, SIOCSARP on an address that already has a
proxy entry clears the flags of the entry and makes it non-permanent.
The entry is then removed when the carrier goes down, and the host no
longer answers ARP requests for the address.

A similar issue happened before with the protocol. It was fixed by
commit cbada1048847 ("neighbour: restore protocol != 0 check in pneigh
update"). Perhaps flags and permanent need a fix as well.

The issue can be reproduced with:

    ip link add d0 type veth peer name d1
    ip link set d0 up
    ip link set d1 up
    ip neigh add proxy 10.9.9.9 dev d0
    arp -i d0 -Ds 10.9.9.9 d0 pub
    ip link set d1 down
    sleep 1
    ip neigh show proxy

Before commit dc2a27e524ac ("neighbour: Update pneigh_entry in
pneigh_create()."), the result is:

    10.9.9.9 dev d0 proxy

After that commit, the result is empty.

This patch will add an update argument to pneigh_create(). Only
neigh_add() sets it, so SIOCSARP leaves an existing entry alone again.

Fixes: dc2a27e524ac ("neighbour: Update pneigh_entry in pneigh_create().")
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Tested on net: with this patch, the entry stays after the carrier goes
down and the host still answers ARP requests for the address, as before
the commit. "ip neigh add/replace/change proxy" still update an
existing entry, and SIOCSARP still creates an entry when there is none.

 include/net/neighbour.h | 2 +-
 net/core/neighbour.c    | 9 ++++++---
 net/ipv4/arp.c          | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 79a5a548a129..d6d691fec124 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -394,7 +394,7 @@ struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 				   const void *key, struct net_device *dev);
 int pneigh_create(struct neigh_table *tbl, const void *key,
 		  struct net_device *dev, u32 flags, u8 protocol,
-		  bool permanent);
+		  bool permanent, bool update);
 int pneigh_delete(struct neigh_table *tbl, const void *key,
 		  struct net_device *dev);
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index d6e9c7c59a89..ae2db3912454 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -783,7 +783,7 @@ struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
 
 int pneigh_create(struct neigh_table *tbl,
 		  const void *pkey, struct net_device *dev,
-		  u32 flags, u8 protocol, bool permanent)
+		  u32 flags, u8 protocol, bool permanent, bool update)
 {
 	struct pneigh_entry *n;
 	unsigned int key_len;
@@ -793,8 +793,11 @@ int pneigh_create(struct neigh_table *tbl,
 	mutex_lock(&tbl->phash_lock);
 
 	n = pneigh_lookup(tbl, pkey, dev);
-	if (n)
+	if (n) {
+		if (!update)
+			goto out;
 		goto update;
+	}
 
 	key_len = tbl->key_len;
 	n = kzalloc(sizeof(*n) + key_len, GFP_KERNEL);
@@ -2155,7 +2158,7 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 
 		err = pneigh_create(tbl, dst, dev, ndm_flags, protocol,
-				    !!(ndm->ndm_state & NUD_PERMANENT));
+				    !!(ndm->ndm_state & NUD_PERMANENT), true);
 		goto out;
 	}
 
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 1ca4ced280ae..3bc8db6ccd68 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1099,7 +1099,7 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 	if (mask) {
 		__be32 ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 
-		return pneigh_create(tbl, &ip, dev, 0, 0, false);
+		return pneigh_create(tbl, &ip, dev, 0, 0, false, false);
 	}
 
 	return arp_req_set_proxy(net, dev, 1);

base-commit: ead6fa9a0ab194f02a2f36d634b193e9c5f9a1c6
-- 
2.53.0

