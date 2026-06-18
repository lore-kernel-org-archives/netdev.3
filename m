Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C123451B3
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781753189; cv=none; b=kSwvT0QfNmGTc2QBmoFMVXnf6nH29Szg/bNMly4seFc28eKpxD9TLwa6nQ1sJGM7P5mji075tvsQRgkozGNANY0YeWEdVhblsjmts3/oiC33660ggsGmTOz5nxG5wONaibAf04NaJjqy6fkZRnj/if/6ixZZJ40Cw9ebCTKdrEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781753189; c=relaxed/simple;
	bh=vid/sm6/IeBG9LzvhFjv+T8WZYOVQS/gQ1qdCV3bZcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSmbSBVQ+cJSNVRIrm3w51gLqlwLLYAqqMt2EucnvPp7LkBe8nZClAuhNBRZ4J5PCAQXiEw+nbAyfAgtkgzMzwr9nOLJMAwMDseresmTERy3xSg65rXVVHdM5nWGRV9USvYGr3u/34S5qj6WYN0N/x1SBqTz9SsQn9QckcH8pdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=B/csGXp5; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="B/csGXp5"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so287030a91.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 20:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781753188; x=1782357988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sT93w6Eb5cH11K0eUOOesB0AAvx2cBMFNxA9SXtx0iY=;
        b=B/csGXp5BPNigWHV1YEgdMNAcrorgACfJ4AU2OAwqi9YtFTYABogNQTqOrfDNCe9M+
         TdTnRTjvTw9lfZk9exHBsME3eK9fPAGeNL08zX57FgDK7F/FhZqDvSfg1gsu47VZ3cn2
         gc71qQVmY711ELZeAqMOyjJSTGx+Wvi0YJOMZ17Go/NmlIGSJoHqLWlt2s1FmIxtrikW
         bq6rNeRaQhSUCov+RzPpPTYdYW83kWTaE+g9/un3tJ2vGtk2p9ZhCE/+3rQiqt1R+XMr
         rWcdDkmhEt2nSZca6xDVU58DbCzd0kVeT1A6bb5K+j4EiCVIykOwx6PDt0sMIHACtkuG
         J4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781753188; x=1782357988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sT93w6Eb5cH11K0eUOOesB0AAvx2cBMFNxA9SXtx0iY=;
        b=hSWhEhJDHLH4IodesIiUb2HCbbAd/YU7ZIGSmRolruaxnw49wdfYzP6SF4POePYJEA
         EH/K9BfT4vwpTlUEYE0r4lpRk0gBXyhjrs4HuPA1HJwiTL2qTmq39wkdsiZyJQmft45W
         tObfxvUHqeHKuax16k8/2IBDdSxDJjwpey9dc7codcOTRh/GYT1xxF5txsY9WIXnO/n8
         vtbswvEgAnBtd0R9fHhkjGSBsT1Qd3bNzr0Z5KTXMySZwyJ54EFelD7IL1VS5TwJYXQV
         GQbOzqxucUCsShlUMztVw+a4jNgG2b/EYkklfMGuSJGYMyKSwDuiL3y0t+vbkhs5bP5s
         OTrg==
X-Gm-Message-State: AOJu0YyYh4w17t/BqTIuCbGOlfMebDcLU7Oe12MapMJ2zR8G0CW4PNzH
	sdVcgcteCtvERNz+Avcbg8q8sSEr1mrRUFlt4gdlYjKde3fOLCRhzMni/j8Nl7oXUoyGIMyEHcn
	D2qOjPg==
X-Gm-Gg: AfdE7clIR/3eh4PAlvc1OFKdE3R6zxvMNhDbDtYMKRWThlY0CW3ihRLAZCqWOgtHvNN
	Hv5ruCc7JAYNSvS6V6qTsS/g0uKoU7TKRUSDgb9QKIP4ovSgtmyh74qB6nipTWNSdJQ11FgzeLL
	0YrZh+PACJ9idQeK8aL2tEMfGLjTmM/JrOlwlm5n9jvaasSYBZcolyBDovrwPzNPZQgmosxoUdh
	Z2D3C/AWGHSBgGFk3ej7yHV8fu2qOVQ9rYk3W2WYXLrJzz9Wr+5qA4f5U+EC4fjEf6mulgW+ys6
	vFNEQrj7+oLKkKkp9UrR/HF/AmPx5EwvHjTUiQHYL7HiQG84jnB2ecfsGrSS0M81uUVyNGDdBdw
	lFCJEGqjq01B9lzXTjDxqKZ/IIhMEVMevEM3knsoQqhdBhIPSllPTNWm/sNZrJ/gPqEyCzw==
X-Received: by 2002:a17:90b:5543:b0:367:b8ad:f0e9 with SMTP id 98e67ed59e1d1-37c9366d7ecmr6379373a91.16.1781753187647;
        Wed, 17 Jun 2026 20:26:27 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c522c3a41sm7702830a91.17.2026.06.17.20.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:26:27 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Weiming Shi <bestswngs@gmail.com>,
	Kyle Zeng <kylebot@openai.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v3 1/2] geneve: gate GRO hint in geneve_gro_complete() on gs->gro_hint
Date: Wed, 17 Jun 2026 20:26:21 -0700
Message-ID: <20260618032622.484720-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

geneve_gro_receive() reads the GRO hint through geneve_sk_gro_hint_off(),
which honours it only when the socket enabled IFLA_GENEVE_GRO_HINT
(gs->gro_hint). geneve_gro_complete() instead calls the low-level
geneve_opt_gro_hint_off() and acts on the hint unconditionally.

On a tunnel without the hint, receive aggregates the frames as plain
ETH_P_TEB while complete still honours an attacker-supplied hint option: it
inflates gh_len by gro_hint->nested_hdr_len (u8) and redirects the dispatch
type, so the inner gro_complete handler runs at nhoff + gh_len, an offset
receive never pulled nor validated, reading out of bounds of the skb head:

  BUG: KASAN: slab-out-of-bounds in ipv6_gro_complete (net/ipv6/ip6_offload.c:196)
  Read of size 1 at addr ffff88800fe91980 by task exploit/153
   ipv6_gro_complete (net/ipv6/ip6_offload.c:196)
   geneve_gro_complete (drivers/net/geneve.c:965)
   udp_gro_complete (net/ipv4/udp_offload.c:940)
   inet_gro_complete (net/ipv4/af_inet.c:1621)
   __gro_flush (net/core/gro.c:306)

Gate the complete path on gs->gro_hint too via geneve_sk_gro_hint_off(), so
both paths agree. Tunnels that enable the hint are unaffected.

Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Reported-by: Kyle Zeng <kylebot@openai.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/net/geneve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 9afff7bcaa0b..7cf7aaac8ee1 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -954,13 +954,13 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 	struct genevehdr *gh;
 	struct packet_offload *ptype;
 	__be16 type;
-	int gh_len;
+	unsigned int gh_len;
 	int err = -ENOSYS;
 
 	gh = (struct genevehdr *)(skb->data + nhoff);
 	gh_len = geneve_hlen(gh);
 	type = gh->proto_type;
-	geneve_opt_gro_hint_off(gh, &type, &gh_len);
+	geneve_sk_gro_hint_off(sk, gh, &type, &gh_len);
 
 	/* since skb->encapsulation is set, eth_gro_complete() sets the inner mac header */
 	if (likely(type == htons(ETH_P_TEB)))
-- 
2.43.0

