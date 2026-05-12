Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE254963AD
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579346; cv=none; b=JO9+mY88B76dpLZ+zR9JTZ1aJJvK3gDuE4YjMpol2/+ffaGjczQjj2rDXStCM9143a22ooxgf1RtjxaCYtH+WVrDniZ0cpTI5LLHtlhGWuVYPrp+NkCTxzWDbsYkNGV1urfymNfsDHwrNuii9XrzsaYMzvTrIEty5yVD3reFvq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579346; c=relaxed/simple;
	bh=8D9RWI7T1YMFEt7m0jIFY4JJvYnA1SyrvvgRB9LpkdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JovsZOho9n/LbaOktNH+yFC4f3L46oEj53mYljmeLzMZ4SDwlImPCZBHe/DXsCLdcdqb1xm+7b81iZqrrGajXNybuuVfhh8yMpRjehUDnYzJxHNyt6h/uSD0XVUmz7cTbUBAo3MQbpYwSnC289eMivW6inYEL8PHusbUtaRtzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V3qkS5sB; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3qkS5sB"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d812c898cso129742491cf.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 02:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778579344; x=1779184144; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOZsG67LOHJdRdsAuNcWorxZMozNPyZMrt7hSZoTtTE=;
        b=V3qkS5sBvim7g1boisajDAubL+ZLgcueRf0KIvZH7HWZX9M4xZmt+DGeoXNYy0fyMd
         sTo8x4pPyuJzF+fBQaK4T1Y/zt6y7EPV2yw/tH9H6qSpbs5IfX3gbFwFXQNKgnNUBiR7
         TvaZ+baHPQDxELvts05VoAVMQqXTE6hdyKCDbR/Z9QxIHz4MSzSS0l7MDF6jHVTfqjeb
         BXRHLJBW7pw9g5hi058TcWICFu97bjEL97O8myiSclxCwcHu/KwVK6jiCuBfLdNkVVhH
         xEnf9huqruE4xZY3A1SE5/Epltact2lYiglQ7y6TW7zhNN+HV+73GG7t3CpeAM5nAGTX
         /1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778579344; x=1779184144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOZsG67LOHJdRdsAuNcWorxZMozNPyZMrt7hSZoTtTE=;
        b=LJvgiAhwqgTEpWFRQvnkpPbar3exedGpJcSAEsJoUiO+YZFzlZ7xbJj+RBROkAGqC1
         fPv69Fys5oYHAZwxcI27sG55024iWV7bbf9DGeCwAP+wnpIxVzKRpi/CD5KFiIAXDxyt
         h45x6/fsDT56bsMWYr0h5BMBfyNXtj2Zxt3+yivAUBsd4lzFBeXBW2vzyGxqeLdXv0l6
         jrYLYoUi2jOam7bwgOG6DtGICcKvvdPvsJLT+32V0Xop9LT6xPcl+NWs/QL0FWyGGNad
         lwoXn0+oQQDj0pffGemI8LG/DypFyTH6ZRq0E8ZlIhRlV3FTYbsJTvhwNJAH1UWr1cZG
         0viw==
X-Forwarded-Encrypted: i=1; AFNElJ8aHfrrtsx/VsSgbddnkbyqLXhHIhOih4+RPmhFeM9jeuCimYe+gB5ocnFINx7v5ZKUbvPG1Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVzNtXuuuCp4ys9lNY7oD/La4/vhfIdxMZ6Pi6zVpgODVC8am1
	WSISXl/XuLy4CjH6hpTflbZqaxAc4dM7DB3NdkF7yIfk1sRH1ydT2nyN4OTg+Pby/w95M0bMMZx
	Jci4Vl1va0sRm5Q==
X-Received: from qtbfw12.prod.google.com ([2002:a05:622a:4a8c:b0:50e:5fa5:fee2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:19aa:b0:509:35d1:ca3c with SMTP id d75a77b69052e-51461be04f8mr397083411cf.5.1778579343820;
 Tue, 12 May 2026 02:49:03 -0700 (PDT)
Date: Tue, 12 May 2026 09:48:59 +0000
In-Reply-To: <20260512094859.3673997-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512094859.3673997-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512094859.3673997-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] net/sched: fq_codel: local packets no longer
 count against memory limit
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 95b58430abe7 ("fq_codel: add memory limitation per queue")
claimed that the 32Mb default was "reasonable even for heavy duty usages."

In practice, this is not the case.

Packets that are associated with local sockets sk_wmem_alloc
do not really need additional memory control.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq_codel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 1b1de693d4c64a1f5f4e9e788371829dea91740e..71107dc52be799a14f370f2ad74d2eadd93992c1 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -212,7 +212,7 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		q->new_flow_count++;
 		WRITE_ONCE(flow->deficit, q->quantum);
 	}
-	get_codel_cb(skb)->mem_usage = skb->truesize;
+	get_codel_cb(skb)->mem_usage = is_skb_wmem(skb) ? 0 : skb->truesize;
 	q->memory_usage += get_codel_cb(skb)->mem_usage;
 	memory_limited = q->memory_usage > q->memory_limit;
 	qdisc_qlen_inc(sch);
-- 
2.54.0.563.g4f69b47b94-goog

