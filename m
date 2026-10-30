Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334213;
	b=BJvt84a/GnE6y2wdM3btfxRc1vQFpPtqqs74TZw6NW106PtzFTQ4Jb/s28r/qL0KYxln
	 21ncaFY6FqhiRnD/hRG4tn+mXsV98QHlA+JMCwcdhBWKNJeQjZLGaHhMA/+N7jWLduEhA
	 OUblNoih8U6sK5C2JXuYRkF2wL+sgoWPI6q6LtehS98Fkdpmc7oe83FUkjYGf+1iLvGAe
	 EfjR1J9VIXLr7Zsxzz0xarNADcGFZKlA496yfXC/HicSjMSmBQ5/uAJG1znA3SklWfTR/
	 RPh7t0iStmKSUrERHh0cdFjJsOuoTShSwkUg9Jtz0t6JTljeL8OKjeGwYgrsxajlHwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XN4XDyaiqYlOIplV7CClfO+XYVm+Kn4edMfOjEe2lFQ=;
	b=xe169T9SaAWM79BgkV+owVIaD81WRbBwQkj8EvfNSgqs2XDCSLvDZCP+AZH0SwvKhwCH
	 k1Zemt3fy8gXUL1UftLtRtsjOL8D9zCr35t9qCO6TyFUieRx24ezq3OLO5zWQG8d4r1u3
	 +GA6BnH7QhwO26MQdpGspB1BmT3EmoH8j3YUSTOC//PPeKUdVHBWLjk2DJXU+DS26ADyy
	 jYwivYk/WDtw95p9MVj2D0MxM+aSHX2V3G2WdlsopscXiGU9cb99Nw2PgEqaosWwKCRHi
	 4/uY8Ljn6d46c/CEUG1bTTbmko1s8A7aBvtuOLE3HK0SYYt0L98vXv6IEaD50qQjOkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0E606A322
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30F0E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-833e671ee9fso426744a34.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334211; x=1793939011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XN4XDyaiqYlOIplV7CClfO+XYVm+Kn4edMfOjEe2lFQ=;
        b=ANIEI9sToLAfxOGi/SRXmKNrOGQ0pQwNEc6Bxv3gSkzZIDTnM0ehWisyZ0bhcM2pKb
         qrnN0mWXr9cShlyNIowE2rTxKk1Uz9eBzITffwyFInRW40agW2AWluvC6HzKW7r3V0Il
         zH2IUY5LsrZiaaZ6gbaa+18oNSnnf//A6HkIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334211; x=1793939011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XN4XDyaiqYlOIplV7CClfO+XYVm+Kn4edMfOjEe2lFQ=;
        b=Bs59aRyMSRhddpLucc9+reKNuMxuDVjrWawh4d0Kj2IpdQudxnT1e9LTc/bqPkeMxI
         6T1luXCceSapo4yx12tsHl80qa17lYpg2f4s2WyENanLz1sxj95K27Am/f/yDTJ0bsal
         oDOzUz1o8hivMrMXiVBhf9yLaZfYResjR1DZrfKUya3qRjjeWvoHtpeMLDbaHwTqjlfj
         44Lc53xVq4kQWPwxEU0xC985wMdlq1jJVGYRISx4tD4qVgdSa6QkRQaClibVwVFXzGe3
         CqtMFLbotEporMsFhY77aQY4mNnmlClC5jhrgykC0T5yKyfxCBLyYA5OgbwoK8fxC0Bq
         Xh7Q==
X-Gm-Message-State: AFq9FYJwmjFV8PQuBpOsuC9U59p3W43Khc8qXE8d7pKYMz38yTRrwXrt
	1P70XaYAHhGE5lNrjcZmYedIKUsn8MEBgguoQO0iZTiA89AL0NFjzBW5vGaIIbr+mi9lf8Vm+ER
	9KE61NvU=
X-Gm-Gg: AYBFou3U1svpsfTW/EkonoSBhVcaIyXvgz/Rhuc9UJZCHPGDiHvk6KJh4w2HNXX24bj
	/MOw+tDCauR60qumtEsjsPoTqCFiRg7JG0G26CMTrDWUk0S+rpuxWiE2uevC8E8Y6VtikFOjvgq
	M2ER2z+hhqi7bYSuZkT9UOcQ+RcTUm/iTmIAtgNns7eevR/9fBsmBHwFrm4LSlKniryeEIVC+0b
	3NC1dQT/wcgjm2VMIX4YSNYgwnjvQJEWKCU30gb4ft4lNzxMK7+oH0RCL9ndUgFblOKCbbzkqYv
	bpPBG8oA4TyqbtMEkyxZ+KBusET3FHXDs7m7dCyjryJTqAfwdEeSYkTjEXiYs7xPrDGuNCrKDnc
	O9k3XH4eZARxnuP1pYDkwZnvM8wz44bz6hCB8VDhav0MJvyEftnTIhCdPAc0xqfO3R9WDHMfVrg
	Of+te36qh2HnyrFXS7yO11+HtYzwkjvUlqR2X5qLEtR0y8CWRyePuoxUMEzkisKYeO77vCY+0l6
	GaW+9EapYMfQIn7E9o8PLqWY4Q4mckIZD4dXiHI3UHDLyBIlLbv7lg3rhUlfVh4xAYId9yJLXUy
	JZch7aZL0z3bu9g99Kslb9B+2RI80zrejJ0W8gMLERRzAsS7EMvTYpOi5tqKTLuWX+5/31C4oMP
	V7uKyixEgSJXibkI4rFTH6SmzLSWiSA==
X-Received: by 2002:a05:6830:4c0c:b0:815:e061:e72e with SMTP id 46e09a7af769-85d365b33c0mr897995a34.23.1793334211180;
        Thu, 29 Oct 2026 21:23:31 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354985cdsm1218751a34.10.2026.10.29.21.23.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:23:30 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] net: skbuff: preserve fclone lifetime when freeing stolen heads
Date: Thu, 29 Oct 2026 21:23:29 -0700
Message-ID: <20261030042329.74461-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

skb_morph() can give an skb from skbuff_fclone_cache a page-fragment
head without changing its fclone tag. IPv4 reassembly can produce such
an skb, which can subsequently reach the GRO stolen-head path.

napi_skb_free_stolen_head() puts the shell into the ordinary NAPI skb
cache without dropping its fclone_ref. If the embedded companion is
still live, KASAN poisons it along with the original, and later cache
reuse or eviction can overwrite or free the allocation underneath it.
A mirrored batman-adv DAT packet retained in a plug qdisc reproduces a
KASAN use-after-free in plug_dequeue().

Use kfree_skbmem() for fclones in napi_skb_free_stolen_head(), retaining
NAPI caching for ordinary skb heads. Also use kfree_skbmem() in
kfree_skb_partial(), whose stolen-head branch has the same assumption
about the allocation cache. This releases the shell according to its
allocation kind and preserves any live companion without freeing the
data that has been transferred to the receiving skb.

Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/core/skbuff.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f676411724..7f08139ff3d5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1495,6 +1495,10 @@ void napi_skb_free_stolen_head(struct sk_buff *skb)
 		skb_orphan(skb);
 		skb->slow_gro = 0;
 	}
+	if (skb->fclone != SKB_FCLONE_UNAVAILABLE) {
+		kfree_skbmem(skb);
+		return;
+	}
 	napi_skb_cache_put(skb);
 }
 
@@ -6263,7 +6267,7 @@ void kfree_skb_partial(struct sk_buff *skb, bool head_stolen)
 {
 	if (head_stolen) {
 		skb_release_head_state(skb);
-		kmem_cache_free(net_hotdata.skbuff_cache, skb);
+		kfree_skbmem(skb);
 	} else {
 		__kfree_skb(skb);
 	}

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
