Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9EF1922F5
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817776; cv=none; b=OJlJYiIW2XtHspj8mruSU0h9a+w+tK2B84Dlj8JC9S80PfAqeWUmeuXPvPyLy3fJVBNIf4OKRk8g7DBB3B/Gk6Eo//n8RA/VJaOrs89UOazA6j3ynSiNaPmh/46Z/80DS4ZjAQ5hdkO8ttEkuRsZINffnx4Vfo9bRTorscbBjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817776; c=relaxed/simple;
	bh=r33b6RIqiOlwBawGevUKHiUVS5mqB/L2gwdOO1KkkbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H7tBAnVqbfVdXvnsbDzdKyY5lPK8SscZxFyVeIABFNpefqkHTYWLwNY3aaRmfe+zlFYDftTTno5PbZJ80OhR93zoP1UIO4TN9n6tWKtHoz/SdK5dBVKVif0ln5sXMGH8rNwXs/CkrG+kXpUvpnUxkezjMGGTJwtow2YAraG+IYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QeEScb38; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QeEScb38"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-91931144870so138017885a.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784817773; x=1785422573; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FKJOCAs/lYJxJhjEEgOD4qlXSETQjOLKZsuJcDjdOdY=;
        b=QeEScb38jU+4R2lXz6AUNnuWEWnjEjWJHTtppTbu+2pzb/zYAV3vi36H8q/pw1Ihj1
         yJOQYCp/xblX7SfAarpblmkbCM6hw94siPfNpXE7NG0eRdKiB502LfYpx9UStycacfBB
         wx1d+FeEDvbM+/7HfakaxXRMp9GBAHaQ1fbo/qCxZwfR86f7GnpXIBbJSCQgwINKVMyy
         eKAIpLkCQQDtF0cTVLOI7IkJy4wHb+m61Y6XNNQJzvEvFxiGHwBwZTPL2eKBiuRswxpM
         w9Gq2ZDvnEONoJCbc9B/cN7V2z9R7zDxF8RZVXZUZVkDjjb/ARjdU+fgzRHYtjPTnUFS
         sdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817773; x=1785422573;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FKJOCAs/lYJxJhjEEgOD4qlXSETQjOLKZsuJcDjdOdY=;
        b=GOuJdHyGGS6ish9JZisiOS9N2tMfZ0eYnUwhcbThhBT/9IUxuOa8gsx2hbutBuXF3C
         0JGD90s7av9REK9WHx8FGjQd5HLa8XC+Tt3IrTFCm9LjpNdBbhZbklgyNDT4M0wmaRG3
         5k1VPFbS/GI9qQdZ6zEAm+exFxL3euEmplpX0tbNn/o2MaMqMcRlBJ4qefIL/b381zj7
         EOc6jAxM/n88zxoccJErA6TPk3NWGO/Om0st4HbE/skVi8WIpVFWgyJIdVn2HMUhi4Ja
         X9lAdRWEMJFV56lSy4Evgv42LJ067nYnWjl72H7hY0Md/HyKKLoG9yO9sZS8d8aatcx9
         rYrw==
X-Forwarded-Encrypted: i=1; AHgh+RqZd1gDwIHADREYaTC8ByaoywxYRLAzSt0cWhbQujhvvHMhOmpyNM0IxSk47bDY7erczoXWz2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnJC0F4LGMJ3X8UhQszoAve47bHXRUuYcJL2OoDx682f/wzoj
	LqatsjDzvLyrG/9gkOnvyURN7t5mkwHpi9NvVy2Z3u5pLbg4NITdHUzApBJGUR0OHBa7mYE8joX
	+GRbfl7ybvndmRA==
X-Received: from qknpy20.prod.google.com ([2002:a05:620a:8794:b0:92e:e424:6d38])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7106:b0:930:f306:8275 with SMTP id af79cd13be357-9310384e7d9mr335259585a.9.1784817772312;
 Thu, 23 Jul 2026 07:42:52 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:42:45 +0000
In-Reply-To: <20260723144249.759100-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723144249.759100-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723144249.759100-2-edumazet@google.com>
Subject: [PATCH net 1/5] vxlan: re-fetch eth header after route_shortcircuit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Before route_shortcircuit(), the eth header pointer is cached from eth_hdr(skb).

Inside route_shortcircuit(), pskb_may_pull() can be called, which may
reallocate skb->head.

In this case, returning to vxlan_xmit() leaves the cached eth pointer pointing to
freed memory, leading to a use-after-free when dereferencing eth->h_dest.

Fix this by updating eth = eth_hdr(skb) after calling route_shortcircuit().

Fixes: ae8840825605 ("VXLAN: Allow L2 redirection with L3 switching")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 67c367cc566233e809b0f70e0d939dd1c1ac0d9f..9060a1259ac283d4db4b7a854ce74203496e9313 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2796,6 +2796,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	    (ntohs(eth->h_proto) == ETH_P_IP ||
 	     ntohs(eth->h_proto) == ETH_P_IPV6)) {
 		did_rsc = route_shortcircuit(dev, skb);
+		eth = eth_hdr(skb);
 		if (did_rsc)
 			f = vxlan_find_mac_tx(vxlan, eth->h_dest, vni);
 	}
-- 
2.55.0.229.g6434b31f56-goog

