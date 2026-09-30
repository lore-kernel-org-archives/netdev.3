Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A4403AE1
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779242; cv=none; b=QlMVJjfoGaP1eXNfMGETotRAw209598NrZw+q/NtXBwbUyDlgf2P/CTvj1NAPdWdjctN8PIFkn5bCbI9IXX11ELhNkvNFDtc+6oVpHgIajYs+XZywLM+o0KXJpZCjxR5u3WkpWynDoxlvQ98qu8G00bDtdjttcMwuif+FJYTG6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779242; c=relaxed/simple;
	bh=At/M13nJI5mcLWzXDLzg4YNQErSnaS2Nb/vZAkP1bNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gu1lwJ+p2fUAfc04+Sd24MovaelmFbGdlbWPg4WepkLex1tvZyRPEKE79qGE9sfOXV+hM4piOi6uCTzMPryd8ig+jQcM1ZlDMt2g9k1QTxcpiPSjqZz9woXLbFDxb1zeAJuiOSANcbAQ50codgPGOB1wfYfJ5d64KmDG5YUxrzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDoYbXMm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDoYbXMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EF21F00898;
	Wed, 30 Sep 2026 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779230;
	bh=Oo9+HJ59BmiP7cUcelsYKYk4avZNII9FPaH2J4b0iEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FDoYbXMmr0wwZ2wuq1r0bifkm9Ly498DReOAPDfMsQr+5c3aAMMjexraY+WdEwQtX
	 A9WY/ofQvNFV7yQeLDiiyTK4V44ROEsESTW6ybJ69y780BuRZR8/vKAtMIeCpaprfi
	 z5THRsFgzb5Rjf3pAIHIBYP+okWvCt89uymN16l39N61v/yhOApR/RT934XL/9b85K
	 /YyY9gAA1q4gQNfVbQDQFKf9uudKmEQTK0b3KDYX8TpAvFnWENS1fpt4A2F7pxk7IX
	 1uG3iiXfs1kezMz3Z2KTILNUkz0vSqD/tXoo6CcCjdguBThFVqtThtUmdn2eVt4peM
	 mFgNM1BiwTHNA==
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
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH v2 net 2/2] ipv4: reserve one IP ID per segment for UDP GSO packets
Date: Wed, 30 Sep 2026 14:40:18 +0000
Message-ID: <20260930144018.1174068-3-edumazet@kernel.org>
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

__ip_make_skb() reserves a single IP ID for UDP GSO packets, but GSO
assigns one IP ID per segment. Following packets then reuse these IDs,
either from inet->inet_id or from the shared generator.

Unless IP_PMTUDISC_DO/PROBE is used, DF is not set on UDP GSO packets,
so segments can be fragmented on the path and IP ID reuse can lead to
incorrect reassembly.

Reserve one IP ID per segment, using the same test as udp_send_skb().

Fixes: bec1f6f69736 ("udp: generate gso with UDP_SEGMENT")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/ip_output.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a24cc8ee11d3ea3069bcc0d4d12e6867c2c475f7..47a78f297a7f5f50633c2157b3bcaea3df5fe0b4 100644
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
+	if (cork->gso_size && sk_is_udp(sk)) {
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

