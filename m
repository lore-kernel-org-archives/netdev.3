Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CD752941C
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687577; cv=none; b=LBFF3c9syEuU5KhWVJ1zPG80UJ9Q2mU5Pwu+PqwA2oatjSWewHQhoyGD+snU/DezlqGngAj0tp6nBT36A7jzb2bRk3MGoopL0FxDCq5pVaS9pqJexg5H9kgakQm23Ez/ivFgOzn13VIuu4lTl6VPBKuXj4XXt2Tm73y2PoCkTAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687577; c=relaxed/simple;
	bh=iLoI/WYtEnTQ+hPIj5t791MJza2I8kYBB4dp+v4ZDfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjngHH8Kl0dDKZ8LlTO+dZWnIEDUhdOFyiasqRXUVRRSHHd4GvfFHV9xbbidhKboNv7b41pLDeqSeqbMiXvw8dzP2MjYtaye+k8mdfRxfi54k7qXxrcXN5bMqmHtPCbenBmMVGRRQ3KMabR7hzqQH3gmZJIzfg8ETQxyf2gihhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN9a+kpL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN9a+kpL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16A81F00898;
	Tue, 29 Sep 2026 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790687575;
	bh=oEuOrr4Odwmw4VLThA8pRYdxD0Hx44FfU0SF9G6nBNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eN9a+kpLMW0tQi3R/vvHVoIh9sX9z5JfpcR6EafKDxdqiJIwnESsPMK4l6vjSfnSq
	 wmGXRueC1qwyN8hhjx53fQq+tD86/zJs0a6DzgMFaJnOUntlopwfKt1Bz8SxY6jfrr
	 9STy/Ga2+izOYQmCIe+FSLmd/Y8wvo390Plgp1xKZc/lNAzqXdnuemO5qmdV/1+g+0
	 Hrx+zdeuoCMuFjvDfdHHtiOG+MxuJDEMM5HJ2wv7tOPYGE08TFt3YQsU3XYKC/x6Q+
	 oiV4UyQr3P1Fml7oAbjYYskdWDrSvAERiNLzOpRu/81h7lck4pK/sJWyRKlycRxWLG
	 hlp8oaOK3km5Q==
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
Subject: [PATCH net 2/2] ipv4: reserve one IP ID per segment for UDP GSO packets
Date: Tue, 29 Sep 2026 13:12:47 +0000
Message-ID: <20260929131247.401104-3-edumazet@kernel.org>
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

__ip_make_skb() reserves a single IP ID for UDP GSO packets, but GSO
assigns one IP ID per segment. Following packets then reuse these IDs,
either from inet->inet_id or from the shared generator.

Unless IP_PMTUDISC_DO/PROBE is used, DF is not set on UDP GSO packets,
so segments can be fragmented on the path and IP ID reuse can lead to
incorrect reassembly.

Reserve one IP ID per segment, using the same test as udp_send_skb().

Fixes: bec1f6f69736 ("udp: generate gso with UDP_SEGMENT")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv4/ip_output.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a24cc8ee11d3ea3069bcc0d4d12e6867c2c475f7..b1cf0c6bfc79c8d234cc81ff32332116c1ee3401 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1410,6 +1410,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	struct iphdr *iph;
 	u8 pmtudisc, ttl;
 	__be16 df = 0;
+	int segs;
 
 	skb = __skb_dequeue(queue);
 	if (!skb)
@@ -1464,7 +1465,19 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	iph->ttl = ttl;
 	iph->protocol = sk->sk_protocol;
 	ip_copy_addrs(iph, fl4);
-	ip_select_ident(net, skb, sk);
+
+	/* UDP GSO packets are segmented later (see udp_send_skb()):
+	 * reserve one IP ID per segment.
+	 */
+	segs = 1;
+	if (cork->gso_size) {
+		int datalen = skb->len - skb_transport_offset(skb) -
+			      sizeof(struct udphdr);
+
+		if (datalen > cork->gso_size)
+			segs = DIV_ROUND_UP(datalen, cork->gso_size);
+	}
+	ip_select_ident_segs(net, skb, sk, segs);
 
 	if (opt) {
 		iph->ihl += opt->optlen >> 2;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

