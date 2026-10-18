Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D83445AFE
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792314419; cv=none; b=Uy1fI6Hyiyfjsee7ZnnviAjKKOapY8GadgUXftVWwWkL0pmPWYh4BXlZSaBGjMymRgVheCPGyASk3XwD2q8bXkbnxfg6qv5Q1xatQglRJNmRlin7aJoKxCMg6/a7qd3oCzz+R/R322reTH64PtnUjg00TytXcxAIM7Y35Ffyey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792314419; c=relaxed/simple;
	bh=5xsFvYC6ZccMND/DkkmxFEIShpZpqmArxia9I0EJPL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcYRw6DcNeJKGPpk8P8FWU0+zlklj4aAgCBG7Cjmdt14zL3u3FI1nCfpvpUnx4KKt/fUp+qdXvILLUQx4nePWVpdflRoC/ph4nrNZMKwbW7iT2uuRnHAeopVlx2jLpiqipoJJ6mM9kTOeVYjR/qLYPWLeo48Zq3w4+p8PD8lEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cupt4/6T; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cupt4/6T"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab866b377aso131079a91.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 02:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792314416; x=1792919216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BwvEsrwytKYnczWN73dPkfnDgfTOzBu/1wqCOjQUI1Q=;
        b=Cupt4/6TG4jsLLZamRD7BMz6QT+k3Xow8C+ahYJ6v80i8tpcL9CVvPpS4BCvLro5cj
         Khh5/2uXfB1Iu6/Da5J3FWIVW0u+QsRw2saVn9EXJ+UmWkghMIBHyWOGImp6AQof9QFG
         +WKKRZg2HXFcgJJafvFdGZUMf1zhg4CLB32hnwSNnXRbh0U3kjSYKVJHIABMJRS6EgYp
         CYkY0hXEbuctFDoQT5VR4APVIOaNbhKUDOEQixZG40f0+d4TRagp24Vaka998AtWBSQe
         kQhEuDzyJp8eV3ueCCGT4X8evUuH0S+ReyqJNJdrB97wDU1t4xRhar3OuADxrEIkAo8N
         xXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792314416; x=1792919216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BwvEsrwytKYnczWN73dPkfnDgfTOzBu/1wqCOjQUI1Q=;
        b=vKGdsstTPZaUeRIXlRBj/FWSGWYeeHgz8QFoFPAEc9E8SXOjGGrMG+eqOSaZfYxaTL
         ytaCTFtKDzyliVsxergS1v4OWBm6APpyGAhyUguoSM8UxDwAITtuFCrj8tLn1jUTQxoR
         VqiO3NriSCwZS6DvabrtvlnMBoXzUME5xF2B1SzWXEZQKu3kuVxBdvToO7uUJ1ozjjp4
         i37tkcNRcHxB06YH2MuFkH78yGIRhoB4NFUb2mAuVAKaS6hiK8HvNe3BZJFTJEqMFHJ8
         y2wNNQqNk/kAOYHsUL9rL6PgLiNS9rdOh/SsBg5TzLo1YGOBvMMBqWctUVYGTpylhn27
         Bn8A==
X-Gm-Message-State: AFq9FYIEE5bbSvO37XkxaRoGIWXyHfs1XDWo72x2hSCwMxR/OEzZKEdU
	ctfve27XMK2Rid1+ZvSIpk+4IZFD+/OrsuscEsQX2KrvPYvYLnSXNOvW4YSwog==
X-Gm-Gg: AYBFou22edM51PPqJPlxb40RZpmiLvKz83Hw2qcafdQ3fsjn7O9XgsVFChENb1orSjD
	FQIQAsMOGZzYQ8TW0ByHbTI0mNQJOeheI7eP2Dvd+H/9OF+SOjFyCprQdwyspvIQOECqsp6LEg4
	t9m7IqTjD92Mwfj/IKMfytDPAAcQU31dteuzMOIS7NQZ2Udi/vJx5y1qxBDCd96TO3n+4yrpS1b
	J2eBk466rjZSq04ZDtS+I1riuDV7zzcjRa7OEuemJauRYCKcsfSxbX96GIrH5AueCYsMLb+vX3E
	/oOgr459Kv2bpz+VYONvXvKqtUuAneW1qQzBNNtLakA4s1N4Q65Lr2CPtVHILcw5zGCAGHHurL9
	mP7FwjvlukHKf9elyEsqJRErEPG6JiRbEwvU8wTOdwDKSe3cjB1/LxDqIRVW8J0TgLoQCyWMvcf
	QSnIf2ubX3PNGrJgdJu68TFG/hoEd5YKAfQGnZfWc1y3kzc43HSgEKbAqYoeTGeonlI9gjrH1TZ
	ai99ejZFOBXWNrFY1vhlDfpiSx3eJpoczgJ3y7d7YPTzV8Qeg0HCNqljOITOD0MLus/
X-Received: by 2002:a17:90b:55c6:b0:398:bad2:c10 with SMTP id 98e67ed59e1d1-3acef1351f3mr6411270a91.6.1792314416632;
        Sun, 18 Oct 2026 02:06:56 -0700 (PDT)
Received: from localhost.localdomain ([113.102.237.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947928b4sm15580675a91.11.2026.10.18.02.06.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 02:06:56 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	chopps@labn.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 2/3] xfrm: set the address family before the early invalid-state drop
Date: Sun, 18 Oct 2026 17:06:37 +0800
Message-ID: <20261018090638.55686-3-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018090638.55686-1-q.h.hack.winter@gmail.com>
References: <20261018090638.55686-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The early drop in xfrm_input() for a state that is no longer valid runs
while family is still AF_UNSPEC, so xfrm_rcv_cb() cannot find the
afinfo and the receive callback is never invoked for such a packet.
Set the family from the state before the check so that the drop path
dispatches the callback like every other drop does.

This is also a prerequisite for releasing the tunnel device reference
on that drop path in the next patch: without a family, the release
cannot tell an ip_tunnel from an ip6_tnl.

Fixes: 4ce3dbe397d7 ("xfrm: Fix xfrm_input() to verify state is valid when (encap_type < 0)")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/xfrm/xfrm_input.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 94de4f698c33..517369ba9efe 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -487,6 +487,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 				      encap_type == UDP_ENCAP_ESPINUDP))) {
 		x = xfrm_input_state(skb);
 		xfrm_proto = x->type ? x->type->proto : nexthdr;
+		family = x->props.family;
 
 		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
 			if (x->km.state == XFRM_STATE_ACQ)
@@ -500,8 +501,6 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop;
 		}
 
-		family = x->props.family;
-
 		/* An encap_type of -2 indicates reconstructed inner packet */
 		if (encap_type == -2)
 			goto resume_decapped;
-- 
2.54.0 (Apple Git-157)

