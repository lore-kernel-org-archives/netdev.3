Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828780;
	b=kcjsl2mafHX3LtIoc7qkFthEFQzDXGEuIycwIsJF509sV8831EiBa1CIePlYxxc/njzj
	 X1Aw23Coo2xZ6UgEI/fWHBNJtmaJgAzS6XQf5/tJDFBDJsBf5/gWTxufN7kzGRclT1nEH
	 DKqCGsWH8LRsbfwyRETKm48UlWKEkKcTQQiEMO7BJ9qOhGAXmwsxkkB7tjIVvUc1rSV6u
	 EQZQD/3kwi8J5hRYqTDKQo3WN7dMZDjPd1MzGNP15IZar9wbS5Gopo9ujVyQTT+Fm+IBF
	 KUEvw5m+XV0iYw5+vBjqX4iTrmlNg0E1oyO6JH/TSXNfXQsO17gO24cIdXDUQGObs1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828780;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b6AWFR1oqoFKrTZfJ7PAWRxGJO9i0u4VcImjxFTGrIQ=;
	b=iEoW/u8EU71ViEv+vw8kuVN8ry+Nihay8n9RiIUyz8WcJBiMaaCElugbbVHnvhq66ROT
	 /PjiT8BuNShZmmIKcUqYYL6X2pq9mYvRHbdEk6WRvfKkgZS1Di17nDRs+miR+w6vjgI8y
	 B6ztQ4hHtRu8TVhN2T7DKKMPVB6jjbPNXiOo5VWlLwQYk5e98ISEFl6BKbcC58US0oozL
	 Cdj6HXn4dVaemlT0kPVEV3cItNUoR6/VV2LoTCliXx2VyK0OU81PE9uzGxtlRBl4ReKmy
	 Z7hHa6Wx0JxejWQc8gL9FXhbBK4xJId8b+233C85pKAUOLHSbhVJ+28s9JVXmCyrkPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=mArb0iwI;
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571D8606F283
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 571D8606F283
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=mArb0iwI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1793828777; bh=q2r6/2kIKUn1CDRxWFWO4inRPPhA5nUO9bCMaRd+9Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mArb0iwId3beTnjIRnEsd7JEBXe58N77nvbDSGhU6fPLe4khKliNvV1561MG/RKvB
	 kTIlRY+hnNb9HJ4AAtGmvLqC2dvRLwkyugHuZejvQ/c89pI9uNJcBVUZpG9CIta0Ih
	 Cf2JeVgi/2IdU6ZX+yJb/SttcByujuHheEHCkL6cHR/exW6yMrneBeFPOGM6Pd/DgT
	 hNm4UnzhYq0usIR1qm4VTwflVjTGZ4EJyUHGuuVy3c/mZNnIbGF3GpPMCZJrRfg9Qf
	 kkN0W5HPOYFKFB7n8kHaqbsGHW4Cm4ld8SbXQLlxETGJwK6aZAlysg66nZoIicrSxQ
	 pXwSISvPhvFzA==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id B21D044C0591;
	Wed,  4 Nov 2026 22:46:17 +0100 (CET)
From: Alexandre Cassen <acassen@corp.free.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 3/3] net/sched: act_tunnel_key: skip dst cache for skip_sw actions
Date: Wed,  4 Nov 2026 22:45:57 +0100
Message-ID: <20261104214607.556269-4-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104214607.556269-1-acassen@corp.free.fr>
References: <20261104214607.556269-1-acassen@corp.free.fr>
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

A tunnel_key set action allocates a per CPU dst cache for the software
path. This takes about 5 KB per action on a 128 CPU host. An action
flagged skip_sw never runs in software and the dst_cache helpers handle
a missing cache, so skip the allocation. Since the previous patch, a
skip_sw filter alone is enough. A replace leaves the flags of an
existing action unchanged, so check these rather than the request ones.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
---
 net/sched/act_tunnel_key.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 503834853306..28d9cc080101 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -481,9 +481,13 @@ static int tunnel_key_init(struct net *net, struct nlattr *nla,
 		}
 
 #ifdef CONFIG_DST_CACHE
-		ret = dst_cache_init(&metadata->u.tun_info.dst_cache, GFP_KERNEL);
-		if (ret)
-			goto release_tun_meta;
+		if (!((exists ? (*a)->tcfa_flags : act_flags) &
+		      TCA_ACT_FLAGS_SKIP_SW)) {
+			ret = dst_cache_init(&metadata->u.tun_info.dst_cache,
+					     GFP_KERNEL);
+			if (ret)
+				goto release_tun_meta;
+		}
 #endif
 
 		if (opts_len) {
-- 
2.43.0

