Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED96C4A68AA
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106344; cv=none; b=XrOtHvdy/+bdaJEdKOwAAnGGCKNBb6poQRjHMCWG2Mx7/8zsC3/juce4Ui5RXrokBs3EmQbQ3HCMfEw45aA6YNlTt+p77KZsZAyWtrPf/aMxJUOeo+f1gYG/GZS3Jazf/xkTFjgzR7pPBTtKNWhWA5L/6l67kXnYYvlAVcFNEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106344; c=relaxed/simple;
	bh=UljtQ9XO6rbJkLCDeJXSzP2hU8m8OSu/SUn/z/6iVUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Akf2yDfHlLjvjkTj/sqwZTflQHOwNT09R+3ZQblBx7Mcdsybg5z/8U0YFv50uE1xwdrTrOUVmARhRFfckCcVpdQ63hbq3ulKLS/edy/Q3pyCTpVgceSQtzwujl954yPwt0rf2zxp1c7QWcT7OJwLR3rAFnLYitSkoSnKyEeRrDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vDKzk+Jz; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vDKzk+Jz"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2dc92350888so3047525ad.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790106342; x=1790711142; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWYEebvN53sOkHrhhlwZSz3/5d2DYKttJmC/W8rasEc=;
        b=vDKzk+JzBBTn6rAfjEqBMyPU2CXYQYNh/ugXqd8cMGmLPm1jN30z9cZYqEM9IJcpo8
         Hu8D7nZ3GFr85WwKsQXfhIBDDfr02V3PqsXNM2xnqbJzJcq6EsO5SOfLOjclN3dRO0Gi
         7morU4+CIzeCDD++Ned6Oj19jkgZQCYAX2JmICR/KjYYQFtskRSyjGIUbqh9Q00TypkD
         +pbPYJr52TPfLqP08nwLIWflBMDl2rECoIxmMbCH7tLq53NMvs0xKjdO1xIhArLftL/m
         wUQQUKwcAqQgN3KaIWzWKR33FZjfXECy6w8/f6JfrFwHQB3ofm7Z5PMtncbC6lphsT0U
         jOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106342; x=1790711142;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWYEebvN53sOkHrhhlwZSz3/5d2DYKttJmC/W8rasEc=;
        b=GEPYaK0j0YJfGmd/490NcD2lRWA3n0aPVH/nPuu7m8eJT/2ZUcXt4dF0/W+KmMAHcl
         /rmhzN8DY+AjsQcGPxwOXyFgiwK6kUgcyob2IX55oFCZx7M7eBdNSEytS2jYTTy7aHyp
         tpTUIL8lOl2+4yiPVBsX4qoQi6W8NxenDmlXIX+eqM+YcYSSDJsg7m8PNRlsKaNN825N
         uoO/NLsiJevfSrNGSBz90mfjbXNgsS1osioQbqQy+jq0l1uFXjFNHnNQOHHR0vVFBmYL
         51zJ9d1WTBax3JLSwTK/J7izREvwz11gwkcJriMUi6jZnKHPPjnWEVQ9k+XhJpnjCrLF
         ZQBQ==
X-Gm-Message-State: AFuF++kqdzk3IWxpc+Qa7ad47dB8XSNCbf/77B4cD+kks7k25Z9VgwOR
	8Vb2bZ+wtxfVDK2e/yq4cbNvHVJlZ+oqGw9N9WIN89VPUmgv8mGrh9hM4qweBHKTf2rsnYAIAJC
	osEsUVj5clbQf8mh5tjdAtrTDtdxtwEJGChtiBAGfOOx31t18YyBe/WaPfwxhlpZS8LMDVUIbbS
	fGroxaJF998nJByuqi+k/2kCF+OqTpm9ujZ+pGKDjeaBAASvM=
X-Received: from pgde21.prod.google.com ([2002:a05:6a02:315:b0:cc2:1a89:e586])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2fce:b0:39e:6c68:c77b with SMTP id 98e67ed59e1d1-3a07e6b5895mr430876a91.49.1790106342068;
 Tue, 22 Sep 2026 12:45:42 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:45:26 -0700
In-Reply-To: <20260922194533.631387-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922194533.631387-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922194533.631387-3-joshwash@google.com>
Subject: [PATCH net v2 2/9] gve: fix XSK buffer leak when rings are stopped
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>, Ankit Garg <nktgrg@google.com>, 
	Eddie Phillips <eddiephillips@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

GVE does not free XSK buffers when resetting ring state as a part of
stopping queues. This causes all XSK buffers which are posted to the
NIC to be leaked.

Free XSK buffers attached to an allocated buf_state when stopping rings.

Fixes: c1fffc5d66a7 ("gve: implement DQO RX datapath and control path for AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Reviewed-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index c3f4a76b0fac..3a88b7e98b16 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -113,6 +113,12 @@ static void gve_rx_reset_ring_dqo(struct gve_priv *priv, int idx)
 				gve_free_to_page_pool(rx, bs, false);
 			else
 				gve_free_qpl_page_dqo(bs);
+
+			if (gve_buf_state_is_allocated(rx, bs) &&
+			    bs->xsk_buff) {
+				xsk_buff_free(bs->xsk_buff);
+				bs->xsk_buff = NULL;
+			}
 		}
 	}
 
-- 
2.55.0.1082.g2b9226bbc0-goog

