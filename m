Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308272;
	b=c5xFXwLoweG4C6veXm+uXF+h+LYJkh+h9YOm+0w+S+G4ZfqX7E+tHFEOVxQHpDtYrssQ
	 wXpSOSBkfjnIQnPUXRk+ndKtCsPQndu9SnkHfFFmqMzcWN1Z0rl6VWPVzOOSycCFWEHq6
	 cg7SbpQp0EEIsFCzJ9b6iNhJ50EIj2Ak3cBpsRJG3Hs3D6u6nnoxcCmNQZeXKZ2G9T1Cl
	 DI5SafY9VIl7GYXVmnwDZ6pFyaJ1dp03eP0+4Fk1Is9g0Xn8kESALvi/iyR7u+KO7Yk0+
	 yyT8niJbzD2sJyK+/qkiBy7P5mIPgluBmX2mmU90E/lahnVrXPBeT3t4+a01YF0q2kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xzTZOWrqKv6fNEBwqt4RIGlP144euiJEy1QT6Ind6Eo=;
	b=u/0xE0fcRo9eskxH5wjmC/4XSl4Yv1zeTYQ3zIpzsJMCTzurWixpZ8rg6TU3AHbtdJ9c
	 rBifVqFAoRj0axuxHUwWvJX0F01dUMlleXbgyio1NQR9d0slNOFhLF7S1iTm0IozXdLtE
	 cnSkwpC6HtIS2GjvtCU581hhlf16N+LTmiVfY1k4aFxrR0St/707YfDy9JCPgh2MknCJm
	 9d0PTlG/7F4eISNsyXcHS91+jBg7TGYuVlXYu+H8VGGs1wpRg9tIEKvpCAZczI46/V+oh
	 ABm6ZNs1VlCc5NPs1MPqkyC9Jt2nl4KarGcX42CaqYtSoFVT7OUuyb0543F3ye5aKBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nuro.ai;
	spf=pass smtp.mailfrom=nuro.ai;
	dkim=pass header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=a4urQiFo;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CBA606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1CBA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuro.ai header.i=@nuro.ai header.a=rsa-sha256 header.s=google header.b=a4urQiFo
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-847ac7ccd85so66250a34.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1793308269; x=1793913069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xzTZOWrqKv6fNEBwqt4RIGlP144euiJEy1QT6Ind6Eo=;
        b=a4urQiFoVINK9O9VOI3lbcGVtqq/7F9FLOoHBPfOSD/usbAXLimX9QiG6ZluHBqVBa
         EkKOk5r6E5GRzW7BVbU2iCKarQBtvRMHCaHfPY9hT/U1MVh+T094bBtSoPeQoO8+cbrw
         ybcO7WPu8XFxFP239b+3hgqR1pUzpkvPedc1xgiTQyaxsBwrCbBocrD5/cg5sNCDUpNI
         RLlWimnVWqDZBG2d+w7/skprg0t5DmXvuOKjtn0qi1k54L0dftPv+jyMwZXU4RCU8Qln
         BvpbIqdZr+2KEHS7cXzpfFTd8ilHCyUkaZ6RNKkLBzntIrArnwEvzUHOMAmYmBw3lhVU
         TAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308269; x=1793913069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xzTZOWrqKv6fNEBwqt4RIGlP144euiJEy1QT6Ind6Eo=;
        b=s6ubZjpnETIJ5wQ3QTJccGUwwJTkQMaj0KG/+IwuU1oGa/7Mss70AKZ8eB1xjTmipu
         ojlJNCzyDeY4FMG6bwbsqx+saZXhOO+noOS4TVVbE6aEekWSHWCktCpELiJk3N2Ibd4r
         YWrosLtr5ugE29mrhs/5QsZmp06S6c1ZIBpDRgFzO/sf3M1mOXACIzCc9qs/oHT2sFPA
         hMhcmtbHApXa9CNv2FB+7tewGdWoNlZfsQp8cxWPT8MAJw+mvQfHXxtsCo0gSVqJE7zW
         U4MEpMdI6B9JYZwrTRvj088wFNoTXJcfDeETaChQ+WP066apa8iugO7+yvJYDvi4koey
         uOIQ==
X-Forwarded-Encrypted: i=1; AKwUvByVr07bYQetdrjP5kKtoDevDZxXt/S1eS8m200aUfQwfQStJeJAvn+3Aebd9xkzTxXkn4XUR3U=@vger.kernel.org
X-Gm-Message-State: AFq9FYK95CA32sNa1lv3P4zSmv53A9mXJpG8m/Ie8PJiySxr0i+ku4nT
	d4a/9p3DaW1RIjukpyCCTOEu8bcVWBpUjukfWp8X2Qt0yVByfVRZlRbSCaV7T3XVURk=
X-Gm-Gg: AYBFou0Wd5xIgIByrVpHTUCZSJ04NofXgxASwfhPk5h/psJHj53o4jR7w7QCvdKfDsN
	CGRAPtpYSIIH2OKjpx0rwO7NMyBb9uT0x6V/1jofcojH6Qb/Dfz+uC9dDaFo1dNNS25yJDTWAb7
	M1jWN0o6SW5YkgJLK+OYitcAtHgBMPRmZXHFOBKWvZqaaDL6gpofPbiBql+fPFE4q2UeWadzdry
	9MN+nxQaaqNzcZjtWZGkPgZjDSdjdSth/JqZbw5cW82LzgGZ6MaP2I/jI5i35Mgu1Rm5NElcvcj
	u20ac9ao3wkjrp8Vug552rsZeiY/35gMlmVj/Fjf7rpsTClqZoDLQocDw6haYbpYns2vkvq8hiI
	sMYBDe6D98LIKipR/hTFVpmxRyLYcVXGpByBUoHbDOb9MKF19aKD6eRN7FjLdVqlmJTmKhSu0sE
	NIBq5c/X6PgAVPDTJbsjOcTOEKInhmcYi/2kcQLeSTVSooJgcZuRQ9DP2EaIJdGBdlNI9HeKv00
	SHNYsp+h6zS5FjA59DDdk+/kwSOCrztm8nh1dOPLhzGL/W1NB7JOLZzFZKoXTVqQalmmSuDos/4
	eoX1nzMv2DKhCnvpJnVEUuExIBFhWUAteWsxQ+r3P6aN+PKGDz52aO3/CBFhIdE=
X-Received: by 2002:a05:6820:1381:b0:708:f388:af75 with SMTP id 006d021491bc7-714f24d6463mr371100eaf.46.1793308269535;
        Thu, 29 Oct 2026 14:11:09 -0700 (PDT)
Received: from jkain-desktop.corp.nuro.team ([64.124.43.154])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d351e77c8sm498519a34.2.2026.10.29.14.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:11:08 -0700 (PDT)
From: Joseph Kain <jkain@nuro.ai>
To: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-kernel@vger.kernel.org,
	Joseph Kain <jkain@nuro.ai>
Subject: [PATCH net v7] net: stop defer_count outliving the deferred-free list
Date: Thu, 29 Oct 2026 14:11:01 -0700
Message-ID: <20261029211101.2089535-1-jkain@nuro.ai>
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

After the llist conversion, rejected frees retain their counter
increments. A producer racing the counter reset and list detach can
also leave a count for an skb already drained. Deferred freeing can
then remain disabled while the list is empty.

Undo rejected reservations and subtract only the number of skbs
drained. Allow admission up to the configured limit. Retain the
halfway notification and also notify when the reserved count reaches
the limit, covering reservations published after an earlier purge.

Fixes: 844c9db7f7f5 ("net: use llist for sd->defer_list")
Signed-off-by: Joseph Kain <jkain@nuro.ai>
Assisted-by: LLM
---
For 6.18-7.1, apply the drain change inside each NUMA-node iteration
of skb_defer_free_flush(), using sdn->defer_list and sdn->defer_count.
Initialize n to zero for each node.
---
 net/core/dev.c    |  8 +++++++-
 net/core/skbuff.c | 17 ++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 18dc88990510..7843ef511d7e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6937,16 +6937,22 @@ static void __skb_defer_free_flush(struct skb_defer_node *sdn, int budget)
 {
 	struct llist_node *free_list;
 	struct sk_buff *skb, *next;
+	long n = 0;
 
 	if (llist_empty(&sdn->defer_list))
 		return;
-	atomic_long_set(&sdn->defer_count, 0);
 	free_list = llist_del_all(&sdn->defer_list);
 
 	llist_for_each_entry_safe(skb, next, free_list, ll_node) {
 		prefetch(next);
 		napi_consume_skb(skb, budget);
+		n++;
 	}
+	/* Subtract exactly what was drained. Never store an absolute value:
+	 * mixing one with the relative updates in skb_attempt_defer_free()
+	 * lets the counter go negative, and it is read as unsigned there.
+	 */
+	atomic_long_sub(n, &sdn->defer_count);
 }
 
 void skb_defer_node_flush(struct skb_defer_node *sdn)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4aea06d5167d..b1d3fd783283 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7388,8 +7388,14 @@ nodefer:	kfree_skb_napi_cache(skb);
 	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
 	defer_count = atomic_long_inc_return(&sdn->defer_count);
 
-	if (defer_count >= defer_max)
+	if (defer_count > defer_max) {
+		/* Undo the reservation. An llist_add() does not release one --
+		 * the skb stays charged until a flush subtracts the batch that
+		 * contains it -- so a rejected free must undo its own.
+		 */
+		atomic_long_dec(&sdn->defer_count);
 		goto nodefer;
+	}
 
 	llist_add(&skb->ll_node, &sdn->defer_list);
 
@@ -7398,8 +7404,13 @@ nodefer:	kfree_skb_napi_cache(skb);
 		return;
 	}
 
-	/* Send an IPI every time queue reaches half capacity. */
-	kick = (defer_count - 1) == (defer_max >> 1);
+	/* Half capacity, plus the skb that fills the queue. Equality alone can
+	 * be consumed early -- if the producer holding the kick value publishes
+	 * first, its purge drains only that skb and the reservations published
+	 * after it match nothing -- which would leave a full queue with nothing
+	 * pending.
+	 */
+	kick = (defer_count - 1) == (defer_max >> 1) || defer_count == defer_max;
 
 	/* Make sure to trigger NET_RX_SOFTIRQ on the remote CPU
 	 * if we are unlucky enough (this seems very unlikely).
-- 
2.55.0

