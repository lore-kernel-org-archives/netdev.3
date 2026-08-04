Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168E8282F25;
	Tue,  4 Aug 2026 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826287; cv=none; b=fRxhc4pSqtIYFqxg5GdIvd41Cbr6mUBjUuwpXGAlpNsimCXparTm4I0Mz0fV9E5hiQWcR4yZetony62QbZLZQvilTLu4meS9mtaAlSXYE4ymAgO/QBj7mNnLUlUzkeSBuXiKe+i9yHcWybynpBujebDSW3TFD87+CSU65uAFGvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826287; c=relaxed/simple;
	bh=EzlRoXHNd6u5cDCP/QykzzKnMy0WX8Vs0VbeFDkFo18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LthLZfPCUCqAbmM9+KDJmzWmi6RkvefV13kINGJWdIgRs4gWb07Q4OFoxW+rd7vsNhFd6mZMJ4BZrorbVMexAt8UnHKMY3VrUT2HUq6B87gDLVEwrIPNanA4ul9m+jXK2fGRx84OoUQYaKHex6MLI9879e6GUTfZaTG9CYKIjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XZBLmMZQ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XZBLmMZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yZ
	UXJGIBE/VUWMsPXw1LmpjXamBT5vScx1IemiCBVfg=; b=XZBLmMZQNlQy5bFzv1
	qijk+HOSx615V0SdqoJ8YpJNS/tpm/oZXmF9BNmQkAqFrPmEBUKrldvBLktXgLcO
	tVem38m2Qn5ayDSoX1tFY5ntGBbMTmHKFQajKmx8+l4j/xizVH9cGAv6o3msG973
	eNuGmMK8XGHjk/T9TCuvviXv4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_su8i3Fqau3mNA--.56151S2;
	Tue, 04 Aug 2026 14:50:38 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: l1138897701@163.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	idosch@nvidia.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v2] sctp: auth: propagate HMAC calculation errors to callers
Date: Tue,  4 Aug 2026 14:50:36 +0800
Message-Id: <20260804065036.618869-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730064202.792809-1-l1138897701@163.com>
References: <20260730064202.792809-1-l1138897701@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_su8i3Fqau3mNA--.56151S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar4xZw1UZw1xuw1UWw1xXwb_yoWftF1kpa
	15uaykAr18Jr43XFs5Cw18Ga13Ww4kG3y3tFy5Xw1Sy3Z8WryrKryjy3y0g3y5GrZ8Ga47
	Aw4jgF17WF1DAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piPCztUUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC+h4JTWpxi75Q5wAA35

From: Qing Luo <luoqing@kylinos.cn>

sctp_auth_calculate_hmac() can fail when building the association secret
under memory pressure, but its void return silently leaves the HMAC digest
zeroed.  On the receive path, sctp_sf_authenticate() compares this zeroed
digest against the peer-supplied one using crypto_memneq(), potentially
accepting an all-zero HMAC from the peer if the allocation failed.  A peer
can reach this path with a configured but non-active shared key id, so
association setup is affected too.  Although the allocation failure itself
is not attacker controlled, the incorrect acceptance is a security issue.

Fix this by making sctp_auth_calculate_hmac() return int:
- sctp_sf_authenticate() returns SCTP_IERROR_NOMEM instead of accepting
  a zero HMAC.
- sctp_auth_chunk_verify() propagates the ierror so delayed COOKIE ECHO
  and other paths see NOMEM vs BAD_SIG correctly.
- sctp_packet_pack() drops the packet on failure instead of transmitting
  a zeroed HMAC that the peer would reject.

Update the declaration in auth.h accordingly.

Fixes: 1f485649f529 ("[SCTP]: Implement SCTP-AUTH internals")
Cc: stable@vger.kernel.org
Assisted-by: LLM:code-review
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
---
 include/net/sctp/auth.h |  6 ++---
 net/sctp/auth.c         | 10 ++++----
 net/sctp/output.c       | 12 +++++++---
 net/sctp/sm_statefuns.c | 51 ++++++++++++++++++++++++++++++-----------
 4 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/include/net/sctp/auth.h b/include/net/sctp/auth.h
index 6f2cd562b1de..eeb3297fe97d 100644
--- a/include/net/sctp/auth.h
+++ b/include/net/sctp/auth.h
@@ -83,9 +83,9 @@ int sctp_auth_send_cid(enum sctp_cid chunk,
 		       const struct sctp_association *asoc);
 int sctp_auth_recv_cid(enum sctp_cid chunk,
 		       const struct sctp_association *asoc);
-void sctp_auth_calculate_hmac(const struct sctp_association *asoc,
-			      struct sk_buff *skb, struct sctp_auth_chunk *auth,
-			      struct sctp_shared_key *ep_key, gfp_t gfp);
+int sctp_auth_calculate_hmac(const struct sctp_association *asoc,
+			     struct sk_buff *skb, struct sctp_auth_chunk *auth,
+			     struct sctp_shared_key *ep_key, gfp_t gfp);
 void sctp_auth_shkey_release(struct sctp_shared_key *sh_key);
 void sctp_auth_shkey_hold(struct sctp_shared_key *sh_key);
 
diff --git a/net/sctp/auth.c b/net/sctp/auth.c
index c901d373af80..6de66f56c41c 100644
--- a/net/sctp/auth.c
+++ b/net/sctp/auth.c
@@ -613,9 +613,9 @@ int sctp_auth_recv_cid(enum sctp_cid chunk, const struct sctp_association *asoc)
  *    zero (as shown in Figure 6) followed by all chunks that are placed
  *    after the AUTH chunk in the SCTP packet.
  */
-void sctp_auth_calculate_hmac(const struct sctp_association *asoc,
-			      struct sk_buff *skb, struct sctp_auth_chunk *auth,
-			      struct sctp_shared_key *ep_key, gfp_t gfp)
+int sctp_auth_calculate_hmac(const struct sctp_association *asoc,
+			     struct sk_buff *skb, struct sctp_auth_chunk *auth,
+			     struct sctp_shared_key *ep_key, gfp_t gfp)
 {
 	struct sctp_auth_bytes *asoc_key;
 	__u16 key_id, hmac_id;
@@ -636,7 +636,7 @@ void sctp_auth_calculate_hmac(const struct sctp_association *asoc,
 		/* ep_key can't be NULL here */
 		asoc_key = sctp_auth_asoc_create_secret(asoc, ep_key, gfp);
 		if (!asoc_key)
-			return;
+			return -ENOMEM;
 
 		free_key = 1;
 	}
@@ -654,6 +654,8 @@ void sctp_auth_calculate_hmac(const struct sctp_association *asoc,
 
 	if (free_key)
 		sctp_auth_key_put(asoc_key);
+
+	return 0;
 }
 
 /* API Helpers */
diff --git a/net/sctp/output.c b/net/sctp/output.c
index 23e96305cad7..3d7ead9d40e1 100644
--- a/net/sctp/output.c
+++ b/net/sctp/output.c
@@ -517,8 +517,14 @@ static int sctp_packet_pack(struct sctp_packet *packet,
 		}
 
 		if (auth) {
-			sctp_auth_calculate_hmac(tp->asoc, nskb, auth,
-						 packet->auth->shkey, gfp);
+			if (sctp_auth_calculate_hmac(tp->asoc, nskb, auth,
+						     packet->auth->shkey, gfp)) {
+				sctp_chunk_free(packet->auth);
+				packet->auth = NULL;
+				if (gso)
+					kfree_skb(nskb);
+				return -ENOMEM;
+			}
 			/* free auth if no more chunks, or add it back */
 			if (list_empty(&packet->chunk_list))
 				sctp_chunk_free(packet->auth);
@@ -619,7 +625,7 @@ int sctp_packet_transmit(struct sctp_packet *packet, gfp_t gfp)
 
 	/* pack up chunks */
 	pkt_count = sctp_packet_pack(packet, head, gso, gfp);
-	if (!pkt_count) {
+	if (pkt_count <= 0) {
 		kfree_skb(head);
 		goto out;
 	}
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 708fa07d5fff..e19881c90b49 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -637,13 +637,17 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
 	return SCTP_DISPOSITION_CONSUME;
 }
 
-static bool sctp_auth_chunk_verify(struct net *net, struct sctp_chunk *chunk,
-				   const struct sctp_association *asoc)
+static enum sctp_ierror sctp_auth_chunk_verify(struct net *net,
+					       struct sctp_chunk *chunk,
+					       const struct sctp_association *asoc)
 {
 	struct sctp_chunk auth;
 
-	if (!chunk->auth_chunk)
-		return !sctp_auth_recv_cid(chunk->chunk_hdr->type, asoc);
+	if (!chunk->auth_chunk) {
+		if (sctp_auth_recv_cid(chunk->chunk_hdr->type, asoc))
+			return SCTP_IERROR_BAD_SIG;
+		return SCTP_IERROR_NO_ERROR;
+	}
 
 	/* SCTP-AUTH:  auth_chunk pointer is only set when the cookie-echo
 	 * is supposed to be authenticated and we have to do delayed
@@ -654,7 +658,7 @@ static bool sctp_auth_chunk_verify(struct net *net, struct sctp_chunk *chunk,
 
 	/* Make sure that we and the peer are AUTH capable */
 	if (!net->sctp.auth_enable || !asoc->peer.auth_capable)
-		return false;
+		return SCTP_IERROR_BAD_SIG;
 
 	/* set-up our fake chunk so that we can process it */
 	auth.skb = chunk->auth_chunk;
@@ -666,7 +670,7 @@ static bool sctp_auth_chunk_verify(struct net *net, struct sctp_chunk *chunk,
 	skb_pull(chunk->auth_chunk, sizeof(struct sctp_chunkhdr));
 	auth.transport = chunk->transport;
 
-	return sctp_sf_authenticate(asoc, &auth) == SCTP_IERROR_NO_ERROR;
+	return sctp_sf_authenticate(asoc, &auth);
 }
 
 /*
@@ -826,8 +830,11 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 	if (error)
 		goto nomem_init;
 
-	if (!sctp_auth_chunk_verify(net, chunk, new_asoc)) {
+	error = sctp_auth_chunk_verify(net, chunk, new_asoc);
+	if (error != SCTP_IERROR_NO_ERROR) {
 		sctp_association_free(new_asoc);
+		if (error == SCTP_IERROR_NOMEM)
+			return SCTP_DISPOSITION_NOMEM;
 		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
 	}
 
@@ -1889,6 +1896,7 @@ static enum sctp_disposition sctp_sf_do_dupcook_a(
 {
 	struct sctp_init_chunk *peer_init;
 	enum sctp_disposition disposition;
+	enum sctp_ierror error;
 	struct sctp_ulpevent *ev;
 	struct sctp_chunk *repl;
 	struct sctp_chunk *err;
@@ -1904,8 +1912,12 @@ static enum sctp_disposition sctp_sf_do_dupcook_a(
 	if (sctp_auth_asoc_init_active_key(new_asoc, GFP_ATOMIC))
 		goto nomem;
 
-	if (!sctp_auth_chunk_verify(net, chunk, new_asoc))
+	error = sctp_auth_chunk_verify(net, chunk, new_asoc);
+	if (error != SCTP_IERROR_NO_ERROR) {
+		if (error == SCTP_IERROR_NOMEM)
+			return SCTP_DISPOSITION_NOMEM;
 		return SCTP_DISPOSITION_DISCARD;
+	}
 
 	/* Make sure no new addresses are being added during the
 	 * restart.  Though this is a pretty complicated attack
@@ -2011,6 +2023,7 @@ static enum sctp_disposition sctp_sf_do_dupcook_b(
 					struct sctp_association *new_asoc)
 {
 	struct sctp_init_chunk *peer_init;
+	enum sctp_ierror error;
 	struct sctp_chunk *repl;
 
 	/* new_asoc is a brand-new association, so these are not yet
@@ -2024,8 +2037,12 @@ static enum sctp_disposition sctp_sf_do_dupcook_b(
 	if (sctp_auth_asoc_init_active_key(new_asoc, GFP_ATOMIC))
 		goto nomem;
 
-	if (!sctp_auth_chunk_verify(net, chunk, new_asoc))
+	error = sctp_auth_chunk_verify(net, chunk, new_asoc);
+	if (error != SCTP_IERROR_NO_ERROR) {
+		if (error == SCTP_IERROR_NOMEM)
+			return SCTP_DISPOSITION_NOMEM;
 		return SCTP_DISPOSITION_DISCARD;
+	}
 
 	sctp_add_cmd_sf(commands, SCTP_CMD_NEW_STATE,
 			SCTP_STATE(SCTP_STATE_ESTABLISHED));
@@ -2118,6 +2135,7 @@ static enum sctp_disposition sctp_sf_do_dupcook_d(
 					struct sctp_association *new_asoc)
 {
 	struct sctp_ulpevent *ev = NULL, *ai_ev = NULL, *auth_ev = NULL;
+	enum sctp_ierror error;
 	struct sctp_chunk *repl;
 
 	/* Clarification from Implementor's Guide:
@@ -2127,8 +2145,12 @@ static enum sctp_disposition sctp_sf_do_dupcook_d(
 	 * a COOKIE ACK.
 	 */
 
-	if (!sctp_auth_chunk_verify(net, chunk, asoc))
+	error = sctp_auth_chunk_verify(net, chunk, asoc);
+	if (error != SCTP_IERROR_NO_ERROR) {
+		if (error == SCTP_IERROR_NOMEM)
+			return SCTP_DISPOSITION_NOMEM;
 		return SCTP_DISPOSITION_DISCARD;
+	}
 
 	/* Don't accidentally move back into established state. */
 	if (asoc->state < SCTP_STATE_ESTABLISHED) {
@@ -4455,9 +4477,12 @@ static enum sctp_ierror sctp_sf_authenticate(
 
 	memset(digest, 0, sig_len);
 
-	sctp_auth_calculate_hmac(asoc, chunk->skb,
-				 (struct sctp_auth_chunk *)chunk->chunk_hdr,
-				 sh_key, GFP_ATOMIC);
+	if (sctp_auth_calculate_hmac(asoc, chunk->skb,
+				     (struct sctp_auth_chunk *)chunk->chunk_hdr,
+				     sh_key, GFP_ATOMIC)) {
+		kfree(save_digest);
+		return SCTP_IERROR_NOMEM;
+	}
 
 	/* Discard the packet if the digests do not match */
 	if (crypto_memneq(save_digest, digest, sig_len)) {
-- 
2.25.1

