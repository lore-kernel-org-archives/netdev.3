Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B0A52B1DE
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687575; cv=none; b=N/rIuLgx+FCyPtQoxw8yDQQvddOrTk2GTwjVeuZDkLfAHnNJjwS1A6cQe9+TeGPulCdMgA3g5GCrpb7qUf5VicQ8sSvv6ful2UTpS+nGwhjhaV8EOQ7807fBluCKwT1T27z2bQ488/cx7WbC3TGHupijqyaeD78c4/iwkzpFpsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687575; c=relaxed/simple;
	bh=4s4YPMYIhHL64pIcYQYE7bPA32jnOfEduyw1bZe4wMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tj/WdTbukHLztVlHI88+49h/aKLZNrt6u7NOwyISmyEKlSSFrc/jOe+xAI9uqlx6MKq8fJWf0anV+6EMP/gHTO5RgaMUBnljgte4p3QCxdTQgHLit1/Tlmx6qa7EecLBXRDy8IP17oGaPzlPDjj3znIYCZU4HdMbudn+qssLbAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D79xdHqw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D79xdHqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024A71F00893;
	Tue, 29 Sep 2026 13:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790687573;
	bh=BkOMrqIhAKc9/CWWqJxzvR42v3Z6hAbSzZdjKGa0FzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D79xdHqwCFx8S6jAX5sGexHxOayMwSRg7RuuUmgH6d3YPNlz/fJWjye81PxTvEXTM
	 RsRvz8gFLUpLCDT1p2euiOBe1+av+6AkLJjpJIdn+3si0uiZYWgG+DQWTVwB49tVKS
	 FXSVARAnCRy3LEq29lRjZPq8iwdRnsMCFFq8EDNSev+BWvRDT2tGgP4NsvziLLyNTf
	 lnHmC1ZUrzw1nwvycXBeE5ozT7Pow2KfRXroXWE3o/76ebl8CSfts51MaSXQyiN1XJ
	 a2FvT/0c+QHAOvuEqZLX6LmMAv6bUbmRTYJYmo8xpoY4dMLt7SMsayuyu9NSVcqtcN
	 QJ3YlKJKK3c2A==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net 1/2] ipv4: fix IP ID reuse in ip_select_ident_segs()
Date: Tue, 29 Sep 2026 13:12:46 +0000
Message-ID: <20260929131247.401104-2-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260929131247.401104-1-edumazet@kernel.org>
References: <20260929131247.401104-1-edumazet@kernel.org>
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
a harmless off-by-one (UDP GSO has a separate, older issue, see
following patch in this series).

Use atomic_fetch_add() instead, like the TCP path.

Fixes: f866fbc842de ("ipv4: fix data-races around inet->inet_id")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
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

