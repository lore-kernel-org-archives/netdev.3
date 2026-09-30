Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FCE4D9F8C
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779240; cv=none; b=tu46cLMn9Idly2hzSl0ESPWjIrnGBnfj25LfCtN6PnjmQjkY6QauIBX9mEy5WOYPQJk2dlqpDP//V0bRNlEYdb7BoZ2RLubNvTjlzpRUxdLH0DCeZE86jXLVuvjI3TwKxBK1atApwH1EGfYq42wySdEEAAN0mNRir0v8FrBXr3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779240; c=relaxed/simple;
	bh=9dWtae5Naf1RsdxtjuEhMLE+wHp+mQlOLP9BvOpvWuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UId5E/g006NwPezfy997xCpa6kjUI3mPf3AHEDnB2DMD8NJvz173gz572Owqet2u3y1cjYEgktVY2dLsw6jtgMXtER0t9q8hWY1eD1JZl3FCOn+kQ1MI6oKULz5eCPfFUFqckN9kq7mCcMEWKXh0a2x8E/K/I1lI5fKqkUij2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WP1COI8t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WP1COI8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEA41F00893;
	Wed, 30 Sep 2026 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779228;
	bh=5iHLI8/koOskDF/OgNF2QQiv+z4nEcoUaNgYXoz2oAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WP1COI8tMjH0oSllMdb52s6XeHwH4oiNygDPKklFSMJdIMESTV7uaTsIQQ3Yosof9
	 YEjpPMH/Fcu4tgztyf9n9LSAJJ40mgqb6vxyNUwRNCMact9FjPMwYBq1D4Sjsol7G0
	 UNNo8ejI/y+jX7G/JetsE8OHUnytehdumbG+ynbj7Z9j0FVBKyv6UnDdc/cUOIqyj/
	 BSJwF0GusN/g0KBrhUnsmpMPAaWA+lh6qt8X8CHRdLgekuocND0+X4A9pb5kO+/s0L
	 LCGsHaQ/r2bUw14xDiSErm7FUUH+czHFwQo+6hfkYNX4xAnQTJ1LmtJnZSyWZwpdcc
	 CxvXab1kXaHTg==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	Eric Dumazet <edumazet@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH v2 net 1/2] ipv4: fix IP ID reuse in ip_select_ident_segs()
Date: Wed, 30 Sep 2026 14:40:17 +0000
Message-ID: <20260930144018.1174068-2-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930144018.1174068-1-edumazet@kernel.org>
References: <20260930144018.1174068-1-edumazet@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_select_ident_segs() must put the first of the @segs reserved IP IDs
in iph->id, as GSO assigns id, id + 1, ..., id + segs - 1 to segments.

Commit f866fbc842de ("ipv4: fix data-races around inet->inet_id")
used atomic_add_return() for non-TCP sockets, which returns the first
ID of the next packet instead. Consecutive GSO packets can then reuse
IP IDs.

SCTP GSO is affected. Other callers use segs == 1, and only see
a harmless off-by-one (UDP GSO has a separate, older issue).

Use atomic_fetch_add() instead, like the TCP path.

Fixes: f866fbc842de ("ipv4: fix data-races around inet->inet_id")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/ip.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 6f602df72ee621ee4ee45e70beef0a1b5145367f..6a3e8271a73b3669e97c4b389e916dbcbfa9f6ae 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -598,7 +598,7 @@ static inline void ip_select_ident_segs(struct net *net, struct sk_buff *skb,
 			val = atomic_read(&inet_sk(sk)->inet_id);
 			atomic_set(&inet_sk(sk)->inet_id, val + segs);
 		} else {
-			val = atomic_add_return(segs, &inet_sk(sk)->inet_id);
+			val = atomic_fetch_add(segs, &inet_sk(sk)->inet_id);
 		}
 		iph->id = htons(val);
 		return;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

