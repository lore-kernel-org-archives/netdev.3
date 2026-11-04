Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798945;
	b=VQjDfj+syyXXwrAcQyceIU5FjgIPx0ErAXLCohvSV7hoeu8DfdjxGf5Ukp/bO+k0xwiJ
	 LBHjE5by2Fv3JzdEW5zn3znwhNf9gjF0TwxoU0bXQRSceZ2F+WJfPbwGEwcGRWdARuVn6
	 fNiczeNjT1aB/vU4cY+b+dgUcuvptk1pqBAUkrPRxnOkpk6pdF1QGtdLPN60HPZbsbLcf
	 jGaLy51DpcGaxCCJBYJNBcxboUlv/Kgg0kgNJj4ziiamD+Qtl0NEbGdAB40mqyTowNca+
	 pndubPqoUpFJhMRLga0H2ZCPJm4haJlm8W+brjAn/y2N4GHvsxtmuxQHId8FfBHU4RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798945;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=e2yqxeW5iyA3GvtFtAiD65K4HSNLST1MrLwZ5EwDuxM=;
	b=eMLfW9nFF9KUHU9La1UGdXVPNbkWZazyXdhIcVkfzjkE1UEs68/MJs7hlhsSSmuD1dLQ
	 z6SrFBv3PNCEI0OxWSpYoGhrwCm3kR+twq5rahQcOcXKul5KtAjk1TPzNQQTDWwpgVY1Z
	 0eMUn+uVCboT3eiPSpWCGNyqYgs6vBCS4WpFsiyjD4PXchdkU/HsXeNuv6nMmKhfOggcu
	 ywK0w/b0Gryx8oC6B1V15DtVh2Qq/i12B4nsU9uemloHyigT0re5VxTlKpSyDUZjds94Q
	 KjMpT7aQc3+DhmJjgC7zlAairZqKg84WWf/Y2OmCD1JB1YQDosNcMDTWbrqyER+oWOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fkL7mEYC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A83606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fkL7mEYC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D75D1F00A16;
	Wed,  4 Nov 2026 13:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793798944;
	bh=e2yqxeW5iyA3GvtFtAiD65K4HSNLST1MrLwZ5EwDuxM=;
	h=From:To:Cc:Subject:Date;
	b=fkL7mEYCJm3nzPQx0GTKvQ752gU2em3ImtrVVDYI4TqvBwNJhJwM2+AqZsNR8KMHY
	 ZsbDFXeo+G0rhUAewFY+acux3sybR09Z+7yWkNdpLwY9pxptse1X8iEhOxq6aZVESj
	 mO8+kVaD8iU8UjgwbrVPQMjeRKMdAe0/vu/2/UbkOCsUGa5vOV/EQP+MHfE8Tu9HlM
	 l11imL9bHMOAlJjZ1cmHJSL2GPbxeZCx6U75nSsbLlpsLuYjv8F33DzS1wB+5i81cN
	 7kIpJ+2Bk43mx2p770YBVr4rXUFaO2NZgT9xx5cC2pe7JC5Pb7UMigcXcB3heiHq9X
	 k6pWtCbhG2h3Q==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@kernel.org,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH net] net: require a full socket in sock_confirm_neigh()
Date: Wed,  4 Nov 2026 14:29:00 +0100
Message-ID: <20261104132900.1071940-1-edumazet@kernel.org>
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

From: Kyle Zeng <kylebot@openai.com>

An skb can retain dst_pending_confirm after its original output and
socket owner have changed. For example, a raw MSG_CONFIRM packet can
cross veth, have a TCP request socket assigned by TPROXY, and be bridged
into gretap. Neighbor output for the outer packet then calls
sock_confirm_neigh() with the request socket in skb->sk.

The helper unconditionally treats a non-NULL skb->sk as a full socket
when accessing sk_dst_pending_confirm. TCP request and TIME_WAIT sockets
do not contain that field. This produces an out-of-bounds four-byte read
and, if the word is nonzero, an out-of-bounds four-byte zero write. A
KASAN-enabled kernel reports:

  BUG: KASAN: slab-out-of-bounds in ip_finish_output2+0xc9f/0xd60
  Read of size 4 at addr ffff8880bdc3d880 by task tproxy_dst_conf/1771

Require sk_fullsock() before accessing the socket field, moving the
existing helper earlier in the header to make it available here. Keep
neigh_confirm() independent of the socket type so the skb's neighbor
confirmation still works, including for socketless packets. This also
covers the IPv6, VRF, and BPF neighbor-output callers.

Fixes: 4ff0620354f2 ("net: add dst_pending_confirm flag to skbuff")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/net/sock.h | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 0c1a6895d347..3144efad8c36 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2287,6 +2287,14 @@ struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie);
 
 struct dst_entry *sk_dst_check(struct sock *sk, u32 cookie);
 
+/* This helper checks if a socket is a full socket,
+ * ie _not_ a timewait or request socket.
+ */
+static inline bool sk_fullsock(const struct sock *sk)
+{
+	return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_RECV);
+}
+
 static inline void sk_dst_confirm(struct sock *sk)
 {
 	if (!READ_ONCE(sk->sk_dst_pending_confirm))
@@ -2298,7 +2306,8 @@ static inline void sock_confirm_neigh(struct sk_buff *skb, struct neighbour *n)
 	if (skb_get_dst_pending_confirm(skb)) {
 		struct sock *sk = skb->sk;
 
-		if (sk && READ_ONCE(sk->sk_dst_pending_confirm))
+		if (sk && sk_fullsock(sk) &&
+		    READ_ONCE(sk->sk_dst_pending_confirm))
 			WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		neigh_confirm(n);
 	}
@@ -3031,14 +3040,6 @@ skb_sk_is_prefetched(struct sk_buff *skb)
 #endif /* CONFIG_INET */
 }
 
-/* This helper checks if a socket is a full socket,
- * ie _not_ a timewait or request socket.
- */
-static inline bool sk_fullsock(const struct sock *sk)
-{
-	return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_RECV);
-}
-
 static inline bool
 sk_is_refcounted(struct sock *sk)
 {
-- 
2.53.0

