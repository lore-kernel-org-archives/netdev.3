Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228387;
	b=Dpi+9DZ6yU6oBifdGIgnO34O60q636/9nyABhsXQ59RNa4SIPq1qn+tyF08Pb3H4Lok9
	 ACWxI4vFa707WG5IrYdeIhCSiRcACGqgVyayvcN4IMJrO3/jLPU6TxtxlKUc/eKpkWclZ
	 IbOCF5HiLuJK/oaHHlpDLLFREa/eYzGjZgf20piQhcuEYa+JLcOIUMgjsaxW/LJOvz2E5
	 tICJd3tGlxI8pNSZakgNHTWlU7E9v72YGrjWx3taBYDHivJ30bNo9hZC0bZSRGaL60sCa
	 W5BxzcvumJfNOcrkhxov9YKK/hKpw2xNOJWoxiQqeros7LENvfize2u/yby2NnqsYLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228387;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b6AWFR1oqoFKrTZfJ7PAWRxGJO9i0u4VcImjxFTGrIQ=;
	b=fKE0NQ9IHvZoMr4RniipGHZmt8PKSKgnL/7igDJkgi0536NqrxsGPyMOUuT0u0YNr63M
	 cy5Ta/Ffpryqgbvc9TqAjmL1gN0NFtgA2HaeRVmevuFwUm4F49cZQxH5V7oyc0hAILmr3
	 kOcdqTB68u1yaL7qX0/1XAYMPQ4vmRxxniUcSwGjFBvNa8mKObpjBqkmTLQXyUDkCijcf
	 /B0HOdIeLw9/sXN6VToWfIqJwoOAPsod/dX1vFXzK1PVIGbxMV4hQ+kHh2wFMMNYcTB2v
	 tMyFw9oH5lqbRAkKSak7qea6rejoiXf3cbv5Fqd4UkXIM2JsyJSAbBYWFG15wwc9UWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=XLd5XIUt;
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C400606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C400606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=XLd5XIUt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1794228384; bh=q2r6/2kIKUn1CDRxWFWO4inRPPhA5nUO9bCMaRd+9Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLd5XIUt1AVCpOz8xZm4sxv46CVvEB1muwKfQec//8mbXg21yyJXbCd11EyH7ogXR
	 xm1ZWpfpmhJgz616izE3KZQ/nwtLSSQLoBvSej5N9e9Axq8yMwm3xrLk8mB9FvAR7N
	 OfDX8OWqJoaW/RAp44vB95YUg+ih1k4ImPt2BvO1kmHVb0SYxwRhx0PskgScagDJep
	 2yIGHqQ4fjh8ivuO6gzjS5RWhfTub0QgDMs2ARn0+3hdK7ekajrnrSnKe+lL0w8oM3
	 rBSP8msLSVzpDjLl4opabLca7xeNc43VH5RkgBl+ZuLVkUMoi4Gv1HaF3S5+7RB/s3
	 JCqneM1pirP5A==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id 965E844C066E;
	Mon,  9 Nov 2026 13:46:24 +0100 (CET)
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
Subject: [PATCH net-next v3 4/4] net/sched: act_tunnel_key: skip dst cache for skip_sw actions
Date: Mon,  9 Nov 2026 13:46:15 +0100
Message-ID: <20261109124618.933149-5-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109124618.933149-1-acassen@corp.free.fr>
References: <20261109124618.933149-1-acassen@corp.free.fr>
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

