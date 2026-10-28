Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207635;
	b=F3YZt0cmHqJTfc0F3FAB6FULYH/9OgwYIMpSfKz5/WCevnHdhBXRm+kVS8VPjt3G80ye
	 zQtrJd79jtfa4BZ+dJTV280n1nBWawG58SPN+aAkWCfIvz1cFE6Ib/8J7EkF5R/3wrTaW
	 RIPlbWc6Q343htnscfVVdt9gFbH5egkJ0A27KLjL79l7p92iazHRYcZihHpLMDMwVd99R
	 ZltwOUOCjA7+4afrvbgAksSQ60NCzaYdgzjL+MvB6nQ1IZnTvoWcs9oXQOB9cV49MN7x9
	 3THsdtWcj9FFyCKpjpO3ScGnlEH8sL5MLnCvK7uMzPGkWHwAhYj7PCnbSeZOnVdrBsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207635;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8ygq7n7ygg1HJ4wA7Hep+kUYmpc7u7VZNcY/7P4cm0k=;
	b=wclyMuoWGCMv/EsQyNZZP0DZE4fJ52crHLb6sBROA1CWcQ49Envfx3oqslpFiuOVcZcS
	 Qg73z5c21oPym+HZ1xIEO66oIPhOx9EuZhLaD6amrvgbku8oon/BPRg/vll9+tdFGc8bJ
	 rtdt6hhUF/RntzlxbFtpQzjQYP/2PDpdUNvDIGsQR8+kozdebUhW9phzJfUJdfzh5mPZu
	 /3sjU0zr5U1U72EZHztPNxrI9Arm7dDEQyRTrsMoNsUDh0Kis5GL/cVWtXaQsHqzHnRim
	 OMDi/ILc0TRdM8CTglB6Wmth0UUP91hjjxjpHlu180jpOOTHhfYxUOGe1q5UKruOkDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMe9zc88;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9661606A320
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMe9zc88
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989BD1F01828;
	Wed, 28 Oct 2026 17:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793207634;
	bh=8ygq7n7ygg1HJ4wA7Hep+kUYmpc7u7VZNcY/7P4cm0k=;
	h=From:To:Cc:Subject:Date;
	b=EMe9zc88uObPMB/EGrnlhFtTZgC24YsFW3tpYy2+uonHXL0Jc7lb6/JuO4KAr+GQ7
	 gkHch+dxkvRSSYllrkXmrqT45w9xCkiQJ2Ce1MX/Fd7acDFu0iQ6F3ijY6B9NOIL+V
	 XhFCbrL0pTuikPglqgcGnWZodsrD4xVHIToOoPU2Tj133zyLDoqI1Bzhz4Mgn4sFew
	 stv1x2SpMoacRiOXU9dJ+E8PXDhVbubn+ua+VwZPnH4GyHHMlPuEQa3wm3cYZqwx59
	 Nq8Frz2aRKzWDgsMZ0d+/FD4C+8v/E9/NX4ep+PG/pL7JcJtZA8kwXT31BilTaIyql
	 oI9Bb6ryyJSNQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	edumazet@kernel.org,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH net] gro: do not GRO GSO packets with inconsistent payload
Date: Wed, 28 Oct 2026 18:13:50 +0100
Message-ID: <20261028171350.2205175-1-edumazet@kernel.org>
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

tcp_gro_receive() excludes empty non-GSO packets with the unsigned
len - 1 check, but its GSO branch only checks that gso_size matches
the held packet's MSS. A trusted TCP GSO skb can reach GRO again with
no payload after TC pedit increases its TCP data offset.

If the skb is fully linear, skb_gro_receive() then enters its fragment
transfer path with nr_frags == 0. The do-while loop copies skb_frag_t
entries backwards beyond both fragment arrays. An unprivileged process
using its own user and network namespaces can trigger a KASAN
slab-out-of-bounds write and panic through veth, pedit and GRE.

More generally, the payload of such a packet can be shrunk to any
value, making it inconsistent with its gso_segs, and a GSO packet
with gso_segs == 0 contributes no segment to the GRO packet.

Do not aggregate GSO packets with gso_segs == 0, and require the
payload of GSO packets to be consistent with gso_segs and gso_size,
the last segment being allowed to be short. This rejects the empty
skb before either TCP merge helper, and covers both IPv4 and IPv6.

Fixes: 5eddb24901ee ("gro: add support of (hw)gro packets to gro stack")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
[edumazet: check payload against gso_segs, refuse gso_segs == 0]
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/core/gro.c         |  5 +++--
 net/ipv4/tcp_offload.c | 12 +++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index ff828a3dce3ca649e149a840bd6e3dfd9ddaf0c4..1b033855a20db6b8b996179f0b81e38393d3864a 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -513,9 +513,10 @@ static enum gro_result dev_gro_receive(struct gro_node *gro,
 	NAPI_GRO_CB(skb)->count = 1;
 	if (unlikely(skb_is_gso(skb))) {
 		NAPI_GRO_CB(skb)->count = skb_shinfo(skb)->gso_segs;
-		/* Only support TCP and non DODGY users. */
+		/* Only support TCP and non DODGY users, with a sane gso_segs. */
 		if (!skb_is_gso_tcp(skb) ||
-		    (skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
+		    (skb_shinfo(skb)->gso_type & SKB_GSO_DODGY) ||
+		    !NAPI_GRO_CB(skb)->count)
 			NAPI_GRO_CB(skb)->flush = 1;
 	}
 
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index e74d99ca9face6ecb853e928b538bd66a377038c..b84fcd07c7230fc3230fdbc3a79d68d1e79b058e 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -315,14 +315,20 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 
 	mss = skb_shinfo(p)->gso_size;
 
-	/* If skb is a GRO packet, make sure its gso_size matches prior packet mss.
+	/* If skb is a GRO packet, make sure its gso_size matches prior packet
+	 * mss, and that its payload is consistent with its gso_segs
+	 * (the last segment can be short).
 	 * If it is a single frame, do not aggregate it if its length
 	 * is bigger than our mss.
 	 */
-	if (unlikely(skb_is_gso(skb)))
+	if (unlikely(skb_is_gso(skb))) {
+		unsigned int segs = NAPI_GRO_CB(skb)->count;
+
 		flush |= (mss != skb_shinfo(skb)->gso_size);
-	else
+		flush |= len <= (segs - 1) * mss || len > segs * mss;
+	} else {
 		flush |= (len - 1) >= mss;
+	}
 
 	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
 	flush |= skb_cmp_decrypted(p, skb);
-- 
2.53.0

