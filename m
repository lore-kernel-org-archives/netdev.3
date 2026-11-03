Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695438;
	b=k1aSDLkXOAKBsnaf6AbnmSur0vi+iHcrR3HT5EptOjnS8bBah3VCJgOz6oPUxDscaoGP
	 3ltSOAFvgKNFENDgFjcj+j81lzE01dSTpb05BsWA+Sd11M1KBmY9uvhfMUMLY2G+Lznq4
	 ySlmKfHgabd1e2j0s0FTuil2dEvkvX9Kk/RbhG5fJ91yuCGZ6RzQgOJ8TLhV3kUwKEpHW
	 hG3uand/D2cE+PG/eLZ6I0NxO1rXZztshvN3MYrY57UZgSbrxLB2wJjFhlbMa+4+L5453
	 6QWp9tJbu2cATOuIbZbJMIeNzyuI7b5gvxw14fk+KjucxVqaX3eZbAT4+wWwtD8vETQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695438;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=dwUVwHlLq9+4ar10B3+uww2PxgckiO6ewtLyyeNYiio=;
	b=4uFruGZLkTy0LuS9i+F049e8vOg1cKDMtL95uK9VzB2HVe2RLTvk1A63bO+QNm9sQbPz
	 m9xqSksml3YiTHwkkRYpALVwIX3EPFAVs5Vk1/AuO3rUPRkcQ6J16Zn1/pgj1bewgvVFH
	 /Zm8QQzMd8HLySWROkMwuzDfUKocMgNn3JjhiCZDlpXxOW8hILJ3uVAOJynlxEbsrGeu8
	 DG/Lj7OzMFo08broelZ2hvYRv05MRTxsoF98ibfMXffX3H3Rr/yw9esBW8V1mnNVTqJ63
	 Crumffh+Z9ruky5lvwSavJMkCAaziMZbdAA8Wj1QipklRTjGUv0SV1GqmjLBEU6s4Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b="RZp/ZV91";
	arc=none smtp.remote-ip=117.135.210.8
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A82606A940;
	Tue,  3 Nov 2026 08:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04A82606A940
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=RZp/ZV91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dw
	UVwHlLq9+4ar10B3+uww2PxgckiO6ewtLyyeNYiio=; b=RZp/ZV91pw+7iro0Ga
	9Mdar6EmvNWVqdfAbgZwB8+WwPvjbgXnmjyFJ1VyuGL4sYhJshZyZW5UpFjNqoPD
	hn5bKeIbUVc9i8/KSIGl3QTLKPJpnFr6FcD7xcDdJ/47gQREkEaqyPjgVoe2lb3y
	FM32cjLeEfZ2uwerdzsj1AT+Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD394uLnulqIw9mCg--.27301S2;
	Tue, 03 Nov 2026 16:42:52 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michael.bommarito@gmail.com,
	gnault@redhat.com,
	alice.kernel@fastmail.im,
	kuniyu@google.com,
	nicoyip.dev@gmail.com,
	mail@david-bauer.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH net-next v2] l2tp: bump tunnel stats before dropping the session reference
Date: Tue,  3 Nov 2026 16:42:49 +0800
Message-Id: <20261103084249.1337657-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wD394uLnulqIw9mCg--.27301S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXrWfAr1DtF4rXr1fKr4DJwb_yoW5ZrW3pF
	WUG3yDKr4DKr1UAr18Jay8X3W5CrWSvayrCF90k34SywsxZa4kJa90yr1Fqa4DCrWvka1Y
	vF1vqw15XF4qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UA9N3UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlAzftmrpnoz9NwAA3q

From: Linkui Xiao <xiaolinkui@kylinos.cn>

l2tp_udp_encap_recv() derives the tunnel pointer from the session it
has just looked up, so the session reference is the only thing keeping
the tunnel alive.  Both error paths of the function drop the reference
before jumping to the invalid label, which still dereferences the
tunnel:

	tunnel = session->tunnel;

	if (version != tunnel->version) {
		l2tp_session_put(session);
		goto invalid;
	}
	...
invalid:
	atomic_long_inc(&tunnel->stats.rx_invalid);

Reorder the error paths so the statistics are updated before the
reference is dropped, removing the dependency on the tunnel staying
allocated after its last reference is gone.

Currently this is safe by accident: the only live entry point is the
UDP encap_rcv hook, which is invoked under rcu_read_lock(), and the
tunnel is freed by kfree_rcu(), so the tunnel memory outlives the
dereference.  Making the order explicitly correct keeps the function
safe regardless of the calling context, instead of relying on every
future caller holding an RCU read-side reference.

The put on the version mismatch path came later, with commit
4d10edfd1475 ("l2tp: Fix memleak in l2tp_udp_encap_recv()."), which
plugged a session leak.

Found by inspection.
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
Changes in v2:
- Describe the change as hardening instead of a reachable
  use-after-free: the socket backlog path pointed at by the v1 commit
  message cannot be reached, and the live receive path always holds an
  RCU read-side reference, so the old ordering is currently safe
  (Sashiko AI review).
- Drop the backport tags (the Fixes tag and the Cc to stable)
  accordingly and retitle the patch.
- Correct the index line: the v1 patch carried the blob hashes of an
  earlier draft of this change, so its new hash did not match the file
  the diff actually produces.
v1:
- Link: https://lore.kernel.org/all/20261027063657.1359170-1-xiaolinkui@126.com/

 net/l2tp/l2tp_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 7e042a3e648c..b7183b527fc4 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1083,16 +1083,12 @@ int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	tunnel = session->tunnel;
 
 	/* Check protocol version */
-	if (version != tunnel->version) {
-		l2tp_session_put(session);
+	if (version != tunnel->version)
 		goto invalid;
-	}
 
 	if (version == L2TP_HDR_VER_3 &&
-	    l2tp_v3_ensure_opt_in_linear(session, skb, &ptr, &optr)) {
-		l2tp_session_put(session);
+	    l2tp_v3_ensure_opt_in_linear(session, skb, &ptr, &optr))
 		goto invalid;
-	}
 
 	l2tp_recv_common(session, skb, ptr, optr, hdrflags, length);
 	l2tp_session_put(session);
@@ -1100,7 +1096,11 @@ int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 invalid:
+	/* The session reference is the only thing keeping the tunnel alive
+	 * here, so account the invalid packet before dropping it.
+	 */
 	atomic_long_inc(&tunnel->stats.rx_invalid);
+	l2tp_session_put(session);
 
 pass:
 	/* Put UDP header back */
-- 
2.25.1

