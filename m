Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A133DDAFE
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.60.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791523191; cv=none; b=PFqMSkjbnyWvla+kmPMPi6JgMNn3NQQI7BpedKmiZPOMBdNEEZFmw/HK3a6loC2BH4AGVjaNa6W3L+i4mZvq5bOkcjy0HxCxqQefICALvmCylHV99qOvjQIOQxJIddJ1MgEMzs2X5MepnuGSPA/d02m7291mnWcLIQREQK4mJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791523191; c=relaxed/simple;
	bh=ZbqI8J4DFPb/T/Ips938JEh4mzJ/yVA6/jLdT13EmSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egCMuzKe+GRQEoq2J268PZZ8PaBBy4DDjg5nOnNtTJPr7BOQXQVYXPsVgANyK9GQfqDqb1QEg4BBzt1kPZ9KSQSuzQJkBKvdrH3sug9rn/kuTUhK9gV1JamfSgJvq9LmttCO/nWLKG5VU+UNGkF0PIaruSm6AvBsa+Zm4Uh3NAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr; spf=pass smtp.mailfrom=corp.free.fr; dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.b=g68NteMV; arc=none smtp.client-ip=212.27.60.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.b="g68NteMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1791523178; bh=ZbqI8J4DFPb/T/Ips938JEh4mzJ/yVA6/jLdT13EmSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g68NteMVDnSeKeql3ZogFJYX998iuMBs0HeBUH/5w0S2gueBeoS6XS4q6DJW2jt5Y
	 qbQqQQoQbaZ5z1eWEtWIdF0aYOHPrtgxK96Vu+pJqbM7VnOfRn98sJIncokCpoX007
	 iZOvF3xxY7HsJK2PvzCZmDut17K3ldScjHm+/+kg7o1Q/zs5C+iJMSelnpscVYkrOW
	 EIOs3l1zA+spIv5RwDXh0M2fESUnZp6ohiFMoBUMk3jZxmSH5H8frsO0SdH/wfQjPR
	 GoCSspzsVCTeW/iYfvjwM/Ur12z4IaKk5vPzHFl17iStvcF0kEXlu5M7o7m8tt74+7
	 7FdASsKN8SkZQ==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id 4462344C0A9E;
	Fri,  9 Oct 2026 07:19:38 +0200 (CEST)
From: Alexandre Cassen <acassen@corp.free.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/2] net/sched: act_tunnel_key: skip dst cache for skip_sw actions
Date: Fri,  9 Oct 2026 07:19:29 +0200
Message-ID: <20261009051930.3619697-3-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009051930.3619697-1-acassen@corp.free.fr>
References: <20261009051930.3619697-1-acassen@corp.free.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tunnel_key action flagged skip_sw never routes packets and the
dst_cache helpers handle a missing cache. A replace leaves the flags of
an existing action unchanged, check these rather than the request ones.

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

