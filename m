Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5106D38F62A
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724768; cv=none; b=SQaw9nHjjb2GgYI7RRDtTINP7XSGirAytFOhEdF/kHRvzHV3YVBGoB/ixfW347W4JLR5mgdjaMQlBpbT2L8Rg+oZ9gP+ABydPdj42MBWVdTvPf9H01EhLgV+Kq0fLkf6sIILSFP5ynbSFxj99kzmzIHZh/S14p6OZp1mErZJRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724768; c=relaxed/simple;
	bh=dxUAeF+9L+zZYh/MVW4v9s4gjmSBtvWgwM44ZUR37mU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iq/6VtIkS09rKdM/hcK2hSfum/7rsB+BMW9+8WsaEQKg6aiSdvcOLtknk4T1p+oAA4XTxJK9yVhiUBH9hKAggFQQMnK1veLZZK3CMR/iQj6YnkXZfpOxretj/5LjKg1VrANFk7l2qNp5PAzd/FoveKPFagbPKkUI/khiivSE3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ciVap5N4; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciVap5N4"
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8a4f18b1b5aso4203906d6.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 01:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775724766; x=1776329566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RhASBS+VhxeS6Kv/exRyy6Gp9xvYpZGnsWFz4lLYWDw=;
        b=ciVap5N4IFjJcfvZwlPP4vL6yl88C8GQ0dzk1OUXl4islcXv1cilwkQPu3ZXjllf6d
         nRdKbdBDP+YMMKt/fJrNgovY+L7vSQzxuVCGBQBjrP5cwbdHBJkoFWd7rKYdomjOOtec
         j2jdcrezBAwc60LwxXou93uWM8QlqPXBhgOxoQsGKdrrKS09mdxa86RuCc9/eUiK/dsU
         CelZzuJ4bE28fKm4TRfKZo/Fg9RTf/OUXhIX6k1kPfRy1wG771tdfTfQ6fKw/poizoYn
         2grye2Xju0HWwplvRS/nN8VzrJ3AppNMU1k/l57+844rtTKEdlEkgzD04fARI65SMOwn
         Hy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775724766; x=1776329566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhASBS+VhxeS6Kv/exRyy6Gp9xvYpZGnsWFz4lLYWDw=;
        b=smfEEbUXrdIwarBt+jW3IcnyeqbMIRTvvF3fywWd/k8IxQRCTcRnfGwb887oQ4vqBI
         FXWmhYruHBnOEwGbFHQBboPCLCbE9O9NtGyPFbT4ORcG9GIYW3ewjSIjisf1I9AzLdkx
         +J2tYX92XhjkGSdrAOIj+v7nPDdeCY9LPEg7pZWEmA1wizHHfM3RC/k9Uwcnv6IiNh8R
         vxhDtHIZO5kSsjmUhjcfy1q0m0oqiA6ORUi0FJGtVEsG4oR58b5CXjhInqbHkf2fSe9g
         zp28Y62+IMso/vO85XgWoDutSjP6OE9XUQbZNFzbpwLPgBLCjfTXKadCjTFgCZGfpqrw
         GDPg==
X-Forwarded-Encrypted: i=1; AJvYcCXmT7X6LmBkhPtuUA79iADdub8i3mJZlRNsLZw7g4yAGLYqUQmPHx3wPwzae6JFlncSiBO+ceE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLFEkhJvCEYQamdYMBE5JT+zURZs0ky36nQSeW4LZR36xjOCj
	ZBo5IiNYDfZspCvhh0gpokNwwULTfonvhAlDXznh6/n3k+64SjnGQcNWyBk1WTufYbzio/cl6rM
	LiaUBY80Zdoo5HA==
X-Received: from qvbqo17.prod.google.com ([2002:a05:6214:5911:b0:89f:6c59:9ea4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5dc3:0:b0:8a1:34df:bbe3 with SMTP id 6a1803df08f44-8ac743c7f3amr44141486d6.28.1775724766066;
 Thu, 09 Apr 2026 01:52:46 -0700 (PDT)
Date: Thu,  9 Apr 2026 08:52:38 +0000
In-Reply-To: <20260409085238.1122947-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409085238.1122947-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409085238.1122947-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] ipvlan: avoid spinlock contention in ipvlan_multicast_enqueue()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Under high stress, we spend a lot of time cloning skbs,
then acquiring a spinlock, then freeing the clone because
the queue is full.

Add a shortcut to avoid these costs under pressure, as we did
in macvlan with commit 0d5dc1d7aad1 ("macvlan: avoid spinlock
contention in macvlan_broadcast_enqueue()")

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 214fd299a5aa6e40579aa2dbcb178b5474b561a4..1be8620ad3971d281fb36fd0770efd67b566ae60 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -763,10 +763,16 @@ static rx_handler_result_t ipvlan_handle_mode_l2(struct sk_buff **pskb,
 	if (!ipvlan_external_frame(skb, port))
 		return RX_HANDLER_PASS;
 
-	nskb = skb_clone(skb, GFP_ATOMIC);
+	if (skb_queue_len_lockless(&port->backlog) >= IPVLAN_QBACKLOG_LIMIT)
+		nskb = NULL;
+	else
+		nskb = skb_clone(skb, GFP_ATOMIC);
+
 	if (nskb) {
 		ipvlan_skb_crossing_ns(nskb, NULL);
 		ipvlan_multicast_enqueue(port, nskb, false);
+	} else {
+		dev_core_stats_rx_dropped_inc(skb->dev);
 	}
 
 	return RX_HANDLER_PASS;
-- 
2.53.0.1213.gd9a14994de-goog

