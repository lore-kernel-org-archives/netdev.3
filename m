Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62C03E0C45
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871338; cv=none; b=hhiBcYNnmd73QcZcva2PKmcm8tiSI4HdDxvYOxHtlBRZYWK5wWnQHbuWvA3sTFZL1eg/OJJstPhW1cbmitw434CT9WehHPHr4TkV7HdrVXgl0a93PFCR0XONpW32+PqdMfl4Y7Oms/bGS7qk5s1iiUjb0RKvlCr9tYeP/GDYnBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871338; c=relaxed/simple;
	bh=1BH9ex9syB2HdC+b4bdVGobcKsiHCXlnvvtpXdswW/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gefSVJsj70GJAFl9/6cepRpiwONqVE7SBnw+20idH2HcJYwKTDjPZLJKfWmHtRCY+pVsCTkJBGNCz40xRVjc428da9ou1RKGWNL8ta39z5QhIXJPP0Jk8Kbx5OG4VWeGYbAkBRVG5yzle9yFaOzewzAQqpfvJwwlNVnl3arnnnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=OvDiuJYL; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="OvDiuJYL"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 283A620748;
	Wed, 27 May 2026 10:42:08 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CpsW8LRZRySw; Wed, 27 May 2026 10:42:07 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6FFBB2069C;
	Wed, 27 May 2026 10:42:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6FFBB2069C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779871327;
	bh=d3QjTWQjHLogrIkLjBpLCGpaIgakelfnr3OmxyNNkCU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=OvDiuJYLYhUe4/hyTw3iRss6LYWdqv8bEtrTLdmtkfxaQPxN91s3nVbNckFY6eNUf
	 9REt6A8CLcmX6X6QHjVjUlQorb9mVmo7hQLN0LRex9DFjcdVpW47XLeajP1ppfWR+C
	 nwMiEOL/0EboWbo+0C9wlRSTwnv6OKJRKJEx9WqFchIxIGkKQi1L/V4VY0zu+2p3N3
	 1/xhonh02exnVqndUHYPveCNI6wQaAb6tMv6OV+yCLgbBj7dXHMgejdfkW769VJPhG
	 3uW8Sv3+zOpC7nJJLWqzz4mFpOSxBgfQ3MM2N9s5EsZFrzGAh+1nV6DPqHmJTZc45W
	 OlSoKqHJZ/VqA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 10:42:06 +0200
Received: (nullmailer pid 3493997 invoked by uid 1000);
	Wed, 27 May 2026 08:42:01 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 4/9] xfrm: ah: use skb_to_full_sk in async output callbacks
Date: Wed, 27 May 2026 10:41:22 +0200
Message-ID: <20260527084148.3489759-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527084148.3489759-1-steffen.klassert@secunet.com>
References: <20260527084148.3489759-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

From: Michael Bommarito <michael.bommarito@gmail.com>

When AH output is offloaded to an asynchronous crypto provider
(hardware accelerators such as AMD CCP, or a forced-async software
shim used for testing), the digest completion fires
ah_output_done() / ah6_output_done() on a workqueue.  The egress
skb at that point may have been originated by a TCP listener
sending a SYN-ACK, which sets skb->sk to a request_sock via
skb_set_owner_edemux(); it may also have been originated by an
inet_timewait_sock retransmit.  Neither is a full struct sock, and
passing the raw skb->sk to xfrm_output_resume() then forwards a
non-full socket through the rest of the xfrm output chain.

xfrm_output_resume() and its downstream consumers expect a full
sk where they dereference at all.  The natural egress path
through ah_output_done() does not crash today because the
consumers that read past sock_common are either gated by
sk_fullsock() or short-circuit on flags that are clear on a fresh
request_sock; an exhaustive walk of the 50 most plausible
consumers under sch_fq, dev_queue_xmit, netfilter, tc-egress and
cgroup-egress BPF found no current unguarded deref.  The bug is
still a real type confusion that future consumer changes could
turn into a memory-corruption primitive.

This is the same bug class fixed for ESP in commit 1620c88887b1
("xfrm: Fix the usage of skb->sk").  Apply the analogous fix to
AH: convert skb->sk to a full socket pointer (or NULL) via
skb_to_full_sk() before handing it to xfrm_output_resume().

The same async AH callbacks were touched recently for an
independent ESN-related ICV layout bug in commit ec54093e6a8f
("xfrm: ah: account for ESN high bits in async callbacks"); the
sk type-confusion addressed here is orthogonal.  This patch is
part of an ongoing audit of the AH callback paths; an ah_output
ihl-validation hardening series is also currently under review on
netdev.

Reproduced under UML + KASAN + lockdep with a forced-async
hmac(sha1) shim that registers at priority 9999 and wraps the
sync in-tree hmac-sha1-lib.  With the shim loaded, ah_output_done
runs on every SYN-ACK egress through a transport-mode AH SA and
skb->sk arrives as a request_sock (TCP_NEW_SYN_RECV); after this
patch, xfrm_output_resume() receives the listener (the result of
sk_to_full_sk()) and consumer derefs land on full-sock fields as
intended.

Fixes: 9ab1265d5231 ("xfrm: Use actual socket sk instead of skb socket for xfrm_output_resume")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/ah4.c | 2 +-
 net/ipv6/ah6.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index 4366cbac3f06..6fd642d2278d 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -143,7 +143,7 @@ static void ah_output_done(void *data, int err)
 	}
 
 	kfree(AH_SKB_CB(skb)->tmp);
-	xfrm_output_resume(skb->sk, skb, err);
+	xfrm_output_resume(skb_to_full_sk(skb), skb, err);
 }
 
 static int ah_output(struct xfrm_state *x, struct sk_buff *skb)
diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index de1e68199a01..76f7a2de9108 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -337,7 +337,7 @@ static void ah6_output_done(void *data, int err)
 	ah6_restore_hdrs(top_iph, iph_ext, extlen);
 
 	kfree(AH_SKB_CB(skb)->tmp);
-	xfrm_output_resume(skb->sk, skb, err);
+	xfrm_output_resume(skb_to_full_sk(skb), skb, err);
 }
 
 static int ah6_output(struct xfrm_state *x, struct sk_buff *skb)
-- 
2.43.0

