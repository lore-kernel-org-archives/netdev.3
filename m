Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278DD420E89
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758603; cv=none; b=P1L/f8bD90VIytzc1VAp8AaUT0RapU9ENDsWcUuaUgUXzjyKhx1bVRnLWWWCSDA5t9M5IGa0PMsy+lw0Ym1QW902zVKqgP2Obh0cILM3rbVaJ85aEmjhvmPBZcJzz5DVENRTI8ojsxXYaRuuOQ10uCPXG5YQJc/r92Vrgy/tbSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758603; c=relaxed/simple;
	bh=KRo8BqXZbY7QVPrkWY+7m9Y76muhXbcl9oTt8JcSLZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X0k6d+1GbbONCxX0pa02U6AEaPEHouKkIOpsFK3QPz2qlC7Pm5tVRVx2RvxQyziUrrDsMu7mZY4m1x9xr6it91GfkQ3YKNVnphlm4Ayo/c3h7zPfAle1JE9F37O3+qsarqi4VT3mLTAF8GkLXGA6C8P982Hy6OfuNYxBcKYJPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rLknt0+9; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLknt0+9"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848474825ffso7950760b3a.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 15:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784758602; x=1785363402; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lP2vHby1eDwBtKihRSSnShKlcm4qY1KhKGcFEWBrgR0=;
        b=rLknt0+9IGYdFi31Q9DxuHWB+q7mcpWCMSjG+ysPxGv5BwsALp7YLdovhBeJe5gywT
         8EFiwEuHCHTdSTnsmbHxVY8VbMb4zI6n+DJbUcEEmzTKy1FzGHMe198B3ENf/1XPlDlK
         y5VgwTUXTp7AICSlGEUQ+hyJmwbCCFJZ3Mne1KPw7BKHOSVSZ3ngOaSabmiw0zo9TXDi
         L651/ybc/VKDr5uIQiZ+mOFEdRyQ4VWfxScG2AKF0O25QOGEygsUY5KZ42jv8jGCf2ae
         MhPVfQVz0u3Gthx6EZpAj3UvHiAYdfBVzgfZb2HFv29YZ4+v+AYyKyhj55zVuPIMVZmt
         bqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784758602; x=1785363402;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lP2vHby1eDwBtKihRSSnShKlcm4qY1KhKGcFEWBrgR0=;
        b=a5vYDJ+47P/q3uq8v8H44pcqdBeWrWlvtXL8KGNl/Tg2xvsuYHAN00Ux7xDmSqa3Qk
         jK0Imw9wEIPXEqqHZupAoEa4cWgFvqwpjlzzMZWCb0Uo/YksA7sDL4aRYZaWYn7ysUAb
         l1irW7G4rWiS0GBDYC2UUD/L2/ATqjqNP4rJOKV+CE6LNeX/URRe2kh9DixAy3ilKwXF
         Ps7aI1gr49GanBOAF+ECqlte4saBbcmmlXbqlqr2ApWt/umunF2mouFcMuKP9ZzykBAt
         zGtLEkictHekg5imOhFZ01TCKjEj2fBQiA8iYmUP7A2AEyvq9mrwq65DUbTL4Ac2m5An
         4vRw==
X-Gm-Message-State: AOJu0YxYLZowEarrrnOSMJGLE6Qvk54cz8evsZFx6o1DfehcE8yHnNvu
	ltUXcghHv8GMsJV/SFum6YQi51vrw4pjFS8bwKQhtpOAPzaW5stlxi9jLUQdvz6n5meoUGPYAF6
	r1ljQnPlgMj195pHr+SJ8lc4i4lTxFNWsVhWRpe1tJTa1OXexUGDwswLKsPAOiXeEkwBw3ei/nE
	yL+W/YKdJIksPaWzxGLLK7MHPK3uWqndSKLcGb6jp50uS0qfw=
X-Received: from pfbcb7.prod.google.com ([2002:a05:6a00:4307:b0:84b:9a71:ba78])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:8889:0:b0:845:dcc8:9da with SMTP id d2e1a72fcca58-84e2e92aa9cmr122192b3a.22.1784758601149;
 Wed, 22 Jul 2026 15:16:41 -0700 (PDT)
Date: Wed, 22 Jul 2026 15:16:33 -0700
In-Reply-To: <20260722221634.186886-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722221634.186886-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722221634.186886-2-joshwash@google.com>
Subject: [PATCH net-next v3 1/2] gve: use xdp_build_skb methods for XDP_PASS case
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, 
	Tim Hostetler <thostet@google.com>, Ankit Garg <nktgrg@google.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Newer common methods have been introduced to construct SKBs in the
event of XDP_PASS because many drivers replicated very similar
functionality. Update GVE to use these common methods for copy mode and
zero-copy mode.

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
v3:
  - Newly introduced. Ensures that XDP metadata is passed onto SKB in
    XDP_PASS case.
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 02cba280d81a..907a0c15bf30 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -736,8 +736,7 @@ static int gve_rx_xsk_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	}
 
 	/* Copy the data to skb */
-	rx->ctx.skb_head = gve_rx_copy_data(priv->dev, napi,
-					    xdp->data, buf_len);
+	rx->ctx.skb_head = xdp_build_skb_from_zc(xdp);
 	if (unlikely(!rx->ctx.skb_head)) {
 		xsk_buff_free(xdp);
 		gve_free_buf_state(rx, buf_state);
@@ -745,8 +744,6 @@ static int gve_rx_xsk_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	}
 	rx->ctx.skb_tail = rx->ctx.skb_head;
 
-	/* Free XSK buffer and Buffer state */
-	xsk_buff_free(xdp);
 	gve_free_buf_state(rx, buf_state);
 
 	/* Update Stats */
@@ -899,9 +896,17 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 			return 0;
 		}
 
+		rx->ctx.skb_head = xdp_build_skb_from_buff(&gve_xdp.xdp);
+		if (unlikely(!rx->ctx.skb_head))
+			goto error;
+		rx->ctx.skb_tail = rx->ctx.skb_head;
+
+		gve_reuse_buffer(rx, buf_state);
+
 		u64_stats_update_begin(&rx->statss);
 		rx->xdp_actions[XDP_PASS]++;
 		u64_stats_update_end(&rx->statss);
+		return 0;
 	}
 
 	if (eop && buf_len <= priv->rx_copybreak &&
-- 
2.55.0.229.g6434b31f56-goog

