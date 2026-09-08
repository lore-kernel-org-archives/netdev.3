Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C713DB63D
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902066; cv=none; b=c3dR+tNkiFYrFCuJT5mNFBom4YgslJlUdt+nLs0WFiq72Iemn0kLYbQH23ZCy9J/Ptbl8dVZoyV63H9fV4C8tx+t4LaD7go3L4dIJhUYy/J2FEnrOiTHcXCegPUozJQbL7Qf3brwuWHHRJ8N8zosriqcGs5jIaKuTpi1nl519bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902066; c=relaxed/simple;
	bh=zRdhCI7ZmpwZsu3DsiJe/Rdz6orJDWlJ0MYUng5TSio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r9O1NpNXHafRYRSZN/m+fdiF655U83Dw3ByTzVzItMWMLptS6W1Knj3XiTqYeCk3Av42qXGwoYTdVLYj4TG1Sy35y9IR0BKgfFzH11+GqQWo/kdY8aRhD25K0R9dQGGmuYkam7MVfYFUR61ULC892Q9QjnTyQ+Ezo125i7svqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+Pz8syw; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+Pz8syw"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d55d8cd938so83913645ad.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788902064; x=1789506864; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tNmXwy74a0wCRfv7+569hLUvGoECmTyrUxdRigZ6xQ8=;
        b=G+Pz8sywWi7iCZ7nkVPTB7yA76jhKmhKKwu1i/OQnWaL3lyDLa0KfBlXHh0ow9w6VS
         1L17fq8RV9R/v06EFeGdve5plMIvkvW8Xn7McbSkVgVwh9p9yfKskYFx0OcD/MoxVpLQ
         2CxCWceLvOEvN611rfEFnDNJI3WJyMJY5e7pNKzoJFtaI/CtIs7FzUsy1fHcC+AXzdg2
         PpgKClEBN7IgPnijlAdVMgsEioy7MmWnqi4QiWlEcELNqXyJs5JpvRmN7S2yPs3bZyzU
         RaOk1vi630bdOjCqgq6SG5ra45e9bmKuWD1nDS1g78Mc9oe1BNLu61UqCY3cwtPD4XQM
         jRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788902064; x=1789506864;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tNmXwy74a0wCRfv7+569hLUvGoECmTyrUxdRigZ6xQ8=;
        b=qlCqc9yacG4SO+roj0L1qwQjrAxK7HhAt95VSss6QUxKlb0wMfshbJy5yh4+UHkgqj
         ie9xTRI32GHF/zd/bWpo26sNJEjGvYNgoDDRQvCvFoY/5amQzVp84dA6OBguFPXREyLX
         YJ32ctyREKmGrl3QiJN3yFTfs9/q6KZ0P7sybtBXcodyW1RqchROVWZ0K5DBWau3HSdY
         DVWVK4xjIKp7x4q5/5DaNipfX6tRhciw63Xuquw+XyOs6ten5bbjsUe/rQEsYlCvxOZy
         oIzprk6dLDYK2DXUEKEllmCL5vqkD5l1naKNtQkI/+1BnCt9tex+eaIm0RcA7slAYb1S
         XktQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2H2lUFTMDgq7xDnBxjFPvDm74vD+VHtVNM9cbcTnlNNd6OrPnI+0vo/0SrO5D1SCTyaCKjWQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lrYqscKakb6PoAm/xJSZ54jKxV4FfmdnXLCgjyp4NQW/pOhhHq
	bW4uURkiRtWJZfau1uRa7tGFjZC9uvzo5K0INN/ipMSv0xI7B6tJd0osaPLaVFinJkosszc9+x4
	nJs3ZxQ==
X-Received: from pltt1.prod.google.com ([2002:a17:902:d141:b0:2db:1aef:28b4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c47:b0:2db:eb5:47ea
 with SMTP id d9443c01a7336-2db12106896mr471595185ad.0.1788902064223; Tue, 08
 Sep 2026 14:14:24 -0700 (PDT)
Date: Tue,  8 Sep 2026 21:12:47 +0000
In-Reply-To: <20260908211419.882954-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908211419.882954-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908211419.882954-4-kuniyu@google.com>
Subject: [PATCH v2 net 3/4] neighbour: Don't render blackhole_netdev via RTM_GETNEIGHTBL.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

The cited commits started to initialise blackhole_netdev with
neigh_parms_alloc().

This is visible in init_net as the ifindex==0 entries via
RTM_GETNEIGHTBL:

  # ynl --family rt-neigh --dump getneightbl --output-json \
    | jq '.[] | select(.parms.ifindex == 0)
              | {name: .name, ifindex: .parms.ifindex}'
  {
    "name": "arp_cache",
    "ifindex": 0
  }
  {
    "name": "ndisc_cache",
    "ifindex": 0
  }

For RTM_SETNEIGHTBL, ifindex being 0 means wildcard.

Let's skip blackhole_netdev's parms in neightbl_dump_info().

Note that lookup_neigh_parms() does not need the same change
because the default parms is always the first entry and matches
with ifindex == 0.

Fixes: e5f80fcf869a ("ipv6: give an IPv6 dev to blackhole_netdev")
Fixes: 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: Xin Long <lucien.xin@gmail.com>
---
 net/core/neighbour.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 0db78a0dfb51..02bf940ce00a 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2624,7 +2624,7 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 			if (!net_eq(neigh_parms_net(p), net))
 				continue;
 
-			if (!p->dev)
+			if (!p->dev || p->dev == blackhole_netdev)
 				continue;
 
 			if (nidx < neigh_skip)
-- 
2.55.0.979.g7e5102b832-goog

