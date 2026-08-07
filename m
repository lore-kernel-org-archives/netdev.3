Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F73F88BE
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142601; cv=none; b=EMS3jSMsybF1m7XysJCTQpsn+cdZRvbvCVpkpH8w1u/eCm78vNtNB1ALxUf2/ciOZ6GL4QhQzUwHw0iobKb+5XjXbOnGSNIn+35BaFT4v48ZyufGV0hcq0WeAn3f94fDbK6F32crdkf+bMD28IJTJ3ISWI9rp9oDlTeJeyHc7gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142601; c=relaxed/simple;
	bh=oo5BQ2YFA1BOj35K9sZFqQ90+w5btbGqx4A0gTKL8gw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DPYt+Ylal7jLknUM7AKHc6VQtXhTVh6WVF7KMZPPZnV26/nTG/CbFIHp0u3LqLkjyM3vzOIWAtLd9l3J0TgL+q5W3ER+IY3gH5LUS4TMDidrmycd8lWvPf6iJH0VHUPWvgOaeB/9Fpxe6YFM/1BI0kHheZH3FjSi3IP8gg/e57c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NPuYhLsI; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NPuYhLsI"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8486ffba174so169120b3a.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786142599; x=1786747399; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nVTmtHFgWt2omJAkKmGW8CxABaT9ZqlHPe4wJSsdn7Y=;
        b=NPuYhLsIzXE7X3+12SbyjEkyy1EV+M0oWMQnjIiLj/gGcZyS5JbPy/EDlv9c0ib8l3
         fddTpC8ezpFWtsC6dJWExmpbjEswukKNxkUlGl/HAl3aSjfjygQpnnPy7YwI+QKrO2re
         6hiGo33fGPYMsLZwFqYi/oNSP4ajymC7Nm4Eo2io3Xf2oBBq6rKWpw72hsWWaP5RlRc+
         dd9pP8ny9j6C4hq9CXlT0NHfqNud3jah7MUMQDDAgh74sh286VDgfF6wfuIU2liZKXLB
         OXD8XdU2YuuTNuDZYnUMXlKz4F9oC9AKUthmiECj8dJ8C7iQAjb2K7tWl5C2F1hAdBh2
         gKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786142599; x=1786747399;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nVTmtHFgWt2omJAkKmGW8CxABaT9ZqlHPe4wJSsdn7Y=;
        b=DrKueK5IXOzr3tw0yQ9dlULvFcUFlIwfDp+pTFupsMOQlp1WUSh5Ny4UJm+4h0yFC0
         Zr+gyC+E9A5xIv9C9PYDC7RTEF2QkLLbR4NeyNVj5GqxrSD2eiIoWqERwG0GL9hVtO3L
         zK3lw4gkg7j2I3zzMWdskMH5Rpg99LUt0Y2tPrekZNqKk5Xkxy8ptwk5PSEGKdirj+Q8
         ULTQ5C9HLDlTCfS1aaq7WRMsrdUkFCOJCItTwDhuW9fHzxkW/4kKqlb3hM8sikUJIHLI
         1SQhYkQeUHhF2bh7knO2ySzwDo09PQM5Js7T6BQO42/a3S0ej+00Z2rj78U1MHwzZTCe
         fE8A==
X-Gm-Message-State: AOJu0YyoeZ+UIQ+NwauWuTr/FLDTxL3hCEfDNPFJOCayhS9GXW39QzD1
	TUApl1/BPY8mgMHBJpgdDzc1z31jwN3dFvIdV+NbcVmV8+JbdlHV0AdYcdx5BwcMfaVo2QdOwY3
	Tn+S6anPPPl2uyvbIiklAF9mxbExK8qt248KvRHItZpS9neAwfJd1RPtBIooDqQaJjQQwvNz7gY
	Pvj9SmsYGvNA9Jh/OOU5iQSKQOweYq6U+zIcvfJxo1q2/uLHHC2N/xZGCufTRb/+o=
X-Received: from pfbcv13.prod.google.com ([2002:a05:6a00:44cd:b0:847:7f5d:6b90])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:c95:b0:845:3033:6cb7 with SMTP id d2e1a72fcca58-84f2dfc8ec7mr25536940b3a.9.1786142598735;
 Fri, 07 Aug 2026 15:43:18 -0700 (PDT)
Date: Fri,  7 Aug 2026 22:43:14 +0000
In-Reply-To: <20260807224315.234152-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807224315.234152-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807224315.234152-2-hramamurthy@google.com>
Subject: [PATCH net 1/2] gve: fix zero-length skb frag with header-split
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, thostet@google.com, jordanrhee@google.com, 
	ziweixiao@google.com, willemb@google.com, nktgrg@google.com, 
	pkaligineedi@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jordan Rhee <jordanrhee@google.com>

When header split is enabled and a header-only packet is
received such as a pure TCP ACK, GVE will indicate an
RX SKB with a zero-length fragment. If this SKB is then
hairpinned and sent back out, the GVE TX path will emit
a zero-length descriptor. Hardware considers this
an illegal descriptor and stops the queue, causing a
TX timeout and interface reset.

Fix it by not adding the zero-length skb frag.

Cc: stable@vger.kernel.org
Fixes: 5e37d8254e7f ("gve: Add header split data path")
Suggested-by: Praveen Kaligineedi <pkaligineedi@google.com>
Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 8271f731a91f..0ece2f6fdffb 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -886,6 +886,11 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		rx->rx_hsplit_unsplit_pkt += unsplit;
 		rx->rx_hsplit_bytes += hdr_len;
 		u64_stats_update_end(&rx->statss);
+
+		if (!buf_len) {
+			gve_free_buffer(rx, buf_state);
+			return 0;
+		}
 	} else if (!rx->ctx.skb_head && rx->dqo.page_pool &&
 		   netmem_is_net_iov(buf_state->page_info.netmem)) {
 		/* when header split is disabled, the header went to the packet
-- 
2.55.0.679.g6767b8d81c-goog

