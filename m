Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48D3403EB
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787074079; cv=none; b=ZtEGnsQjngJA1pVeyrB5jym3UamWjC3KxbBjqTVyjaS1Eiod5b4J5gsZ62eXoMQwhIPKOAFSt6NEX07QtwvpZWv7FDSYX9DMH9Y0HDyhiYQxb3tzlJAg0sR7cCr90skA4Gk8zaENdpB/Xku2tARhvph217Bx1UCeCTiclZynQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787074079; c=relaxed/simple;
	bh=zSFiXdOdxNRFU+jEWpNPnwtE8w+rMGT+3jyDOGlY49Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HbuCr+W4xmaBTHdKnU7ptWDhNizIG18OGYNQlGNZIGRLsgU+5b5R7NFvU3OObVptXG2IbzL0uNp6R4EjlC/7Kd8D9MZ9g0x2P1Wse+6andJmmaQfDovxTMDZMGSjf+ZrzApwLFRTPvIOm5yHNxbsWJQF3dLwPslkWNE0UujfESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lslSdLs8; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lslSdLs8"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1a9764f0so478671cf.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787074077; x=1787678877; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aPJMKBRJs0alVlI4MxR/f1MY7c+B1Gw+ufiwV1NU81I=;
        b=lslSdLs88yzyH0XeYIUypGtlQcKwRS/V8PdD5nMKd17JPZufLAhtff2hm27pIRneQE
         pGygyksTiYJzcTCuufPkn3/BhW+ENZhEQLrJdrq8v9HTi/+XDnL99RaOGfIeqbi28Dvg
         tNJdnaqlj49A5x/SmG2M1RCwnm24P9rQ6y2O5y78xyVwHlr0KVFwhyM7d9sMFr998a5e
         2jxZraNMmu7QY3zPWcTgZBULo5mqfsGq5QViEOHe5JkCz4yq9qYCXK/e1yBGnhe3Jwu8
         0UBq5hYrAnSxVxhDvud0IxwTZmPmngSDuL5GxRqS37/rlLVefCIAeIGvtAZ63ZSdgRwn
         aiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787074077; x=1787678877;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPJMKBRJs0alVlI4MxR/f1MY7c+B1Gw+ufiwV1NU81I=;
        b=a0I7c/1NRX858AL2usyv/Z3rVHIClsXe6KtXEAnzRZb+A1sQhtNlSHywLtRfZ4ZZwe
         mlH+T9epun1IX3vmZa/2D2hZmPMDYXDPtsM0hyR2DiX35rijszfwJm5+5dg4SvinQd5J
         K/zFEsnz/Adm2kfq0AtnDq2hWygEokWUd59RfzFCLUPt0JKtl2XHFHSBYITpp27FfyJK
         W62UHnH4dtJBw03e6QgSTnSprccHltXHm1AQV8jJ/k/l5zxlBHTDGchbq0VWOig7p1oJ
         HEB1UPtamrTVxU9XYhzoTI62GM06YoqSwMmsX9Kh4e5X+X0Es6BpJDXhAtowUIgkVsyh
         5DZg==
X-Forwarded-Encrypted: i=1; AHgh+RqzxIcGpXMfvwelScpUIBoMZKtSufbVCFhJOP5Qpk3aWU+pq37dvhYFZrztqKx6jp3bqNa007s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCOWlJMpQ04Sv9lXBL7MBmWGbi1uuOYFsBSbVRX3XomIa6iTOA
	r0nrPfGJzx0XdvCRr9LdOOHFde+B5WEiM29niVmKnw4VQoxS6Dz1SWmu5e0HPuCSRbhOyqz6irb
	7SlHYc1bJLmP1jw==
X-Received: from qtww9-n2.prod.google.com ([2002:a05:622a:6849:20b0:51c:c33:1f98])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:40f:b0:516:d812:c35e with SMTP id d75a77b69052e-52d855011efmr357621421cf.21.1787074076580;
 Tue, 18 Aug 2026 10:27:56 -0700 (PDT)
Date: Tue, 18 Aug 2026 17:27:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260818172755.4083692-1-edumazet@google.com>
Subject: [PATCH net] ip6mr: do not clone dst in ip6mr_cache_report()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Zero Day Initiative <zdi-disclosures@trendmicro.com>
Content-Type: text/plain; charset="UTF-8"

IPv6 input attaches a non-refcounted (NOREF) dst to skbs under RCU.
When an ingress multicast packet misses MFC lookup,
ip6mr_cache_unresolved() places the skb onto the unresolved queue,
escaping the receive-side RCU grace period.

If the underlying route is deleted and freed, and the MFC queue is later
resolved with a wrong parent interface, ip6_mr_forward() invokes
ip6mr_cache_report(..., MRT6MSG_WRONGMIF), which executes
dst_clone(skb_dst(pkt)) on the freed dst entry, triggering a slab
use-after-free.

Report packets queued to mroute6_sk (a raw socket) and netlink
notifications do not require an attached dst entry.

Fix this by:
1. Removing dst_clone() in ip6mr_cache_report() and ensuring report skbs
   do not hold a dst.
2. Dropping skb_dst before queuing unresolved skbs in
   ip6mr_cache_unresolved(), matching the fact that multicast
   forwarding resolves outgoing routes anew via ip6_route_output().

Fixes: 67f415dd2906 ("ipv6: convert rx data path to not take refcnt on dst")
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6mr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 604a58838901a74712d08505c6bbbdeafd28149c..3f2ed9b77deb51799f34e3826ae271d8d3e2a2dd 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1162,10 +1162,10 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
 	msg->im6_src = ipv6_hdr(pkt)->saddr;
 	msg->im6_dst = ipv6_hdr(pkt)->daddr;
 
-	skb_dst_set(skb, dst_clone(skb_dst(pkt)));
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 	}
 
+	skb_dst_drop(skb);
 	mrt6msg_netlink_event(mrt, skb);
 
 	/* Deliver to user space multicast routing algorithms */
@@ -1246,6 +1246,7 @@ static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
 		skb->skb_iif = dev->ifindex;
 	}
 
+	skb_dst_drop(skb);
 	skb_queue_tail(&c->_c.mfc_un.unres.unresolved, skb);
 
 	spin_unlock_bh(&mfc_unres_lock);
-- 
2.55.0.737.g08866a6d13-goog

