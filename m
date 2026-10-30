Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349243;
	b=mjCNGhkr5TGC7wFk8Ynf1PaoajzurvNJBygAyU28iURJdLBx2CCpRwYcFdEA5uWthAeb
	 Mfv+eLrQ0bNlAgXY7dMtMkcS+WO+qsCjomboWm74C7x5soqe6aYv6nKvWKCInU8UP2XTs
	 AdTy7Y4wnTgdU1KXc98n3mdeh3CibNxFVJmRtFYY6qO16N+Wo8jmbXHQxoBM7ck9ZM2Tu
	 Fb5zE6tnJMd6Va3zIi3ZE8gXnmykm1srwNxA/Y/k82e6I5DoreSSA2fqNFr6h3W9og0Ma
	 thFjkCNoqT7t6btbWP3FSH1nYs/CHk2LIsJAwc2lXYxcDPldtJo0ycRvld/QI3abhzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349243;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rwq7g9L7G/Q+SxSTNvORYifWRqmPbMTkylWUOWvbZS4=;
	b=G9xF3uZFt4IPmk3POH5pmqXwjJrWwwN9uZ1ALM4J72bJKdFj+/pMGJkG2sR10GFJawV2
	 WqkEckP7ZE/ItiJ3yEj9YujTmXyYjsXbiMPIsOj/w2hK7WW33byUyaZi5jCmfMfYxRMN2
	 cxh/VS1JkM+5BplurFbqVHO8uqy0jC7g9puNHo75NOJqRRwZ4or34N2MoWvuq28gQQZ1V
	 wdEaDpW1+TVTBbA5Dk9UptZMX8lmGzBb/UH5iJpSYeruyxnzg8KDU7VVGBEzy0f8+Nn6t
	 Zw5nsxZWCKAl494IJBbvkfZbFEBiZ1ySQ+K/9j4Skv3cm0052gHBD8zxi6gdqFUSbLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gi2TsWLq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06B606A31F
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gi2TsWLq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2F71F00A20;
	Fri, 30 Oct 2026 08:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793349242;
	bh=rwq7g9L7G/Q+SxSTNvORYifWRqmPbMTkylWUOWvbZS4=;
	h=From:To:Cc:Subject:Date;
	b=gi2TsWLqNSBUhuYI5wBGndnHEBu20e1mX8wdasuGNGtmvFe6cGCz6g6niRHSKs2uG
	 RSV1kV+3tpKAYqsTlpFLNIJOdy1fz3QgWCFmHnlJIXFFs34xLrND881MX/txkLUFua
	 7bwvp94NBDEz6CybPIAIdnhA58RZiq9f3R4kOLP7z4mtwbIYTANM26nFIAgy7ygx0j
	 HJ3j0AEbgjpMHwKKyyiPugBNXboWcr7th0ZlJvfJxgcswn0yKei3fPNnF0Dp7Y7bBz
	 mlYHG8DnLs6ProgmRn5rDHJAcmL7LIkf6DwO6EE0kCl1jE8VEaWYgvtegsg686yjwC
	 CEojzdWndfAxw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@kernel.org,
	syzbot+a3f21220cbbb6e14ee2e@syzkaller.appspotmail.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH net] xfrm: iptfs: fix skb leak on error in __input_process_payload()
Date: Fri, 30 Oct 2026 09:33:58 +0100
Message-ID: <20261030083358.2653599-1-edumazet@kernel.org>
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

syzbot reported a memory leak of the received skb (and its sec_path
extension) in the IP-TFS receive path.

__input_process_payload() parses the inner packets of an IP-TFS payload
and queues them on @sublist, which is only sent after the parsing loop.
Three error paths inside the loop (skb_copy_seq_read() failure, invalid
inner IPv4 header length, unknown IP version) jump to the "done" label,
which is placed after the code sending @sublist.

Any skb already queued on @sublist is then neither delivered nor freed.
This includes skbs added by iptfs_reassem_cont() before the call, newly
allocated inner packets, and, since the received skb can be reused for
the first inner packet, the received skb itself.

Move the "done" label before the trim/send code, so that inner packets
parsed before the error are delivered as on the normal exit path. The
received skb is then still freed (or consumed) as before when it was
not reused.

Fixes: 6c82d2433671 ("xfrm: iptfs: add basic receive packet (tunnel egress) handling")
Reported-by: syzbot+a3f21220cbbb6e14ee2e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6ae4102e.9c6421ad.36baac.0005.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 net/xfrm/xfrm_iptfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 103cf7c5dbfb..0313a43aa8a9 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -1182,6 +1182,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 		/* this should not happen from the above code */
 		XFRM_INC_STATS(net, LINUX_MIB_XFRMINIPTFSERROR);
 
+done:
 	if (first_skb && first_iplen && !defer && !first_skb_partial) {
 		/* first_skb is queued b/c !defer and not partial */
 		if (pskb_trim(first_skb, first_iplen)) {
@@ -1198,7 +1199,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 		if (xfrm_input(skb, 0, 0, -2))
 			kfree_skb(skb);
 	}
-done:
+
 	skb = skbseq->root_skb;
 	skb_abort_seq_read(skbseq);
 
-- 
2.53.0

