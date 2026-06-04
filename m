Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D1472772
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582429; cv=none; b=Elo8JlKPpa/v5g1aZ7H+u8+3Z9YjGEf3Jw5YsNtaoYFsWKo/yoyXIA3t0FtjRO6tMf0oV2nGFErDMy5F65YfhpPA6BMaw9MlID+dHdSBSlOw4Lxs52xsRC+2oEYEmeWT7HxwbM7P9zlfQm0Da2XO1b7E5VFyj5vPzVeSZdtRHWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582429; c=relaxed/simple;
	bh=ll1d6D/mCvvNOaZJ2ZWt1HhXCi/uNGg//rlXeO7ijV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V1gyQ83byWCXrLU0LRdsxz5qeVUdYFBXvN+UaMnIz4VI3ZnQchypA2XIOzdMnIvW1rB/3mBnfoSBCIaTj2pqTnkdFJI/8xIplquvPDAmijfQHnpaRjoz0j4doLrOLqwxELejyQUNoEHUz1wPAZNWJig2//lC+YmoTg0Jpl8Rojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=azdgDWMF; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azdgDWMF"
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-66043ac620fso1417244d50.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780582427; x=1781187227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aveLMHlnviqtytDsiSdbRJSwTX2GOpu8oXn6tzESZ2o=;
        b=azdgDWMFeTGglODFO7+4gkEKacghbhYeMxhhE9KvYnu7g771y2tzRvW2IFdDSa9fVF
         ATPJsojfXOetlZyAbZ7rAFckAj6Cw1IdfvGvmRSnFgfsqig9h8Y5GOrhR8E7zM3vEIzI
         gTAo6WlTqmjQJf191tmGqMSfj5pRF7yn9hweHqa/BE3wXbnrjNvDjrI9VPYQjzQdFrju
         FMgU9mqBncMXPBXV82bhTgyLrZNzzExko2YsJtPttQ+JIZDLYFKYZWabJtnCvEl/gr/y
         Px60RDeKbEme822JlaKIp1434RM0JCjaboXSi57cmrsKk3WvK1eVw7fLt+1+n/g4aFfd
         iMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582427; x=1781187227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aveLMHlnviqtytDsiSdbRJSwTX2GOpu8oXn6tzESZ2o=;
        b=IvVAQzOk8QMyFJwubnoxkiDtIBTe4wdbb0YDnyNY+X0mEeEctaIpHcc5TFWhq8loBJ
         XT8FWii4TYeX/aSSqqrRIA1fdgdYTbrTZLKcdEeEJ/wGqLjTnn30Dx747Gwa4m5K2O0x
         DvKcVZstd3jPKypqZ/siDSggV6E6WtzFeWUY8rg+TKL7q8P/qVR5tx217y+xyxyJFNBL
         qpqwygsKvmLaebHjm4OQ58srzQ797vjpUEZglR8qTB78CbazsoVcZkW/m3YK3OugNlgC
         //3g9toIAf+KlrFbHBsiLML9obmR1DUfRYozdmEktLVmoCGlH+ug7vrBpTL3xVdvtdYk
         g9Dw==
X-Forwarded-Encrypted: i=1; AFNElJ+VvjU8/0OFXvwkg7eHPMxHyEFciVMoZ4dUp1FdYsIaBOXRejc+Kx9WTVrd+gAzw2k7YnJW5Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ3my39AwUAS3K8wWxKOOOwiXpiAxiWLIux4QIXRSwf9NbkIu/
	Yd5UkdjgcNwiEjhTDLYZ0fiGs1ny1WLDwYC6JvpYTMV7JCr4sCiRktYrT4zLEdjzH8gULqjEKAr
	ny2LOrvKi+rSF3A==
X-Received: from qtbki14.prod.google.com ([2002:a05:622a:770e:b0:517:82a8:c7a5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1288:b0:651:cf29:430b with SMTP id 956f58d0204a3-660df4810acmr7057208d50.12.1780582426617;
 Thu, 04 Jun 2026 07:13:46 -0700 (PDT)
Date: Thu,  4 Jun 2026 14:13:33 +0000
In-Reply-To: <20260604141343.2124500-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604141343.2124500-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604141343.2124500-2-edumazet@google.com>
Subject: [PATCH v3 net-next 01/11] bridge: add a READ_ONCE() in br_timer_value()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

br_timer_value() can be called locklessly, the expires field
could be changed concurrently.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_stp_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_stp_timer.c b/net/bridge/br_stp_timer.c
index e5d453305381baa34225a144ac99e98f2a62d810..83cc9c6a3943508eb94d20ddc1b7e737a58d7abb 100644
--- a/net/bridge/br_stp_timer.c
+++ b/net/bridge/br_stp_timer.c
@@ -160,5 +160,5 @@ void br_stp_port_timer_init(struct net_bridge_port *p)
 unsigned long br_timer_value(const struct timer_list *timer)
 {
 	return timer_pending(timer)
-		? jiffies_delta_to_clock_t(timer->expires - jiffies) : 0;
+		? jiffies_delta_to_clock_t(READ_ONCE(timer->expires) - jiffies) : 0;
 }
-- 
2.54.0.1032.g2f8565e1d1-goog

