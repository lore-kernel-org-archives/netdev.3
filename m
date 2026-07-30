Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BED269D18;
	Thu, 30 Jul 2026 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393773; cv=none; b=Rj84vcHAnIJ7QHMefvuZNkFY5wwg+jpOPLfTOo/GwU/nO3ecFTEQoR3E15VXd1F6SN3k6a3XGof8GAhsAbnMwjQweYVb9TNK1VOb4hJXrfd3DBD374iobmyntjVn9F+v+ppTkDTkeoekfLyIiKhOYNznghNNZCtsab+M8/i5IPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393773; c=relaxed/simple;
	bh=sml0g70QaU4HVAdwCFEzNOniTZ+HbDLWGhEbzGOrZFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hg9sEITQjwJpOBBLm+orV/mHup61Vse/BQa6v+35MXxnXLI2CgSlzPBu536jrOX93i+xB1CcLuoDAKaEZlQ7hOLiGGN6OsXe/xptUCl8kUtPRXwWhCzD7yAdk7BI1FmBYyj7EttOjEmO5+wKCjFRlEXtILl+UDfd3vVO0AAuH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CYaKIJq9; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CYaKIJq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fd
	7EeLzqIzXnsvsdH/t3dNXTkLibPRunpxRsLnLRThY=; b=CYaKIJq9hXNTxm6+qb
	VSOHSpTig9Ety+R0fGa9RNRDjLu4QQy4tHK+WhGw8OvDv1W/VmE5+mB76qbajYgK
	kEdxZVAKs0tK4p0qP9Ha2bOgRKusjozvmPZsr6aeyrjNyWsSnVkxS3pHa2XRQ+Km
	srPlKCTmQeUAm9J01W5lKkXb4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDXKeA68mpq0UVAJw--.61375S2;
	Thu, 30 Jul 2026 14:42:03 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] sctp: auth: propagate HMAC calculation errors to callers
Date: Thu, 30 Jul 2026 14:42:02 +0800
Message-Id: <20260730064202.792809-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDXKeA68mpq0UVAJw--.61375S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFy3Xr1kWF47Kr1kAFWxtFb_yoWrZr43p3
	Z8ZFZ5Cw1xAr43XFZ3Cw48G3W5Wws5C343tF4Yvw1Sy3Z8Xryrtr10kaykGrW5CrWkJa47
	Aw4jgF13Gr1qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jb4SrUUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC3RsARGpq8jvb0gAA3C

From: Qing Luo <luoqing@kylinos.cn>

sctp_auth_calculate_hmac() silently returns when
sctp_auth_asoc_create_secret() fails under memory pressure,
leaving the digest zeroed. Callers then compare the zeroed
digest against the saved one, getting SCTP_IERROR_BAD_SIG
instead of the correct SCTP_IERROR_NOMEM.

Change sctp_auth_calculate_hmac() to return int so callers
can distinguish allocation failures from bad signatures:

- sctp_sf_authenticate() frees save_digest and returns
  SCTP_IERROR_NOMEM on failure.
- sctp_packet_pack() frees the auth chunk and returns 0
  (drop the packet). In the non-GSO path nskb equals head,
  so only free nskb in the GSO path to avoid a double-free;
  the caller handles head cleanup when pkt_count is 0.

Also update the declaration in auth.h to match.

Assisted-by: LLM # review
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
---
 include/net/sctp/auth.h |  6 +++---
 net/sctp/auth.c         |  6 ++++--
 net/sctp/output.c       | 10 ++++++++--
 net/sctp/sm_statefuns.c |  9 ++++++---
 4 files changed, 21 insertions(+), 10 deletions(-)

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
index c901d373af80..4db3a3a4a457 100644
--- a/net/sctp/auth.c
+++ b/net/sctp/auth.c
@@ -613,7 +613,7 @@ int sctp_auth_recv_cid(enum sctp_cid chunk, const struct sctp_association *asoc)
  *    zero (as shown in Figure 6) followed by all chunks that are placed
  *    after the AUTH chunk in the SCTP packet.
  */
-void sctp_auth_calculate_hmac(const struct sctp_association *asoc,
+int sctp_auth_calculate_hmac(const struct sctp_association *asoc,
 			      struct sk_buff *skb, struct sctp_auth_chunk *auth,
 			      struct sctp_shared_key *ep_key, gfp_t gfp)
 {
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
index 23e96305cad7..a7930cd9400e 100644
--- a/net/sctp/output.c
+++ b/net/sctp/output.c
@@ -517,8 +517,14 @@ static int sctp_packet_pack(struct sctp_packet *packet,
 		}
 
 		if (auth) {
-			sctp_auth_calculate_hmac(tp->asoc, nskb, auth,
-						 packet->auth->shkey, gfp);
+			if (sctp_auth_calculate_hmac(tp->asoc, nskb, auth,
+						    packet->auth->shkey, gfp)) {
+				sctp_chunk_free(packet->auth);
+				packet->auth = NULL;
+				if (gso)
+					kfree_skb(nskb);
+				return 0;
+			}
 			/* free auth if no more chunks, or add it back */
 			if (list_empty(&packet->chunk_list))
 				sctp_chunk_free(packet->auth);
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index b01db33bbc36..b68de2c4dc26 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -4455,9 +4455,12 @@ static enum sctp_ierror sctp_sf_authenticate(
 
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

