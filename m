Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496759;
	b=gphIcQVOh+fGRpSYHZ6lqeudIhvlMBdS2E2NOvcv+v7+1r+VmkCDO+HUSMrPp1AYu23C
	 3cc15TIhir2yn35tiGH9uA4oOsHErC6hokBEiISUQKZ8z38E+2abYxg+4vkqtgMNtJKax
	 hmSi0Djz+tuxl8mp/Bw2GiWFCTzp5enOkoWzv/N544JeZCNeDafmwWPMynKxgRs/L5iFu
	 XM6e4zscPlnwhzHgSYCKILopvEPwMex6mmswLbenLO5roBNtOrrBC8ZCsEFyBM+JsvBNG
	 rfe2jPgwFnmcXldRd5zzb0ZHbf01Sf+puKOHiTo0vKNjAUCAuytFs0MAQwQwEcJJCUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hm6Nx8LFz/1dKXtVqVksLWNReVFuahQkEvS1g9mf0Es=;
	b=b8jBppotyP4+7OANd09q5zjmCSiyEud+ZtflQqN4lyz7OlYJ9OBLaDiRxAAO2XWqDKLp
	 VE3gzT4BKyUfjzz31SZskaqTPQ0fF2xIVZuzmxe9AWQoud+ywvePGAXtsB9qu6PYWjYS1
	 avJL0+aHquJe5/ZvfxIc8r8GFYUGTfViEffLiZrjzjzLlziAzVTOwapFaqKDY7pevM23C
	 K9eZGh2PYBv6L5oF6GfZ1olVQGgzVJQhrMaAG/bddxb635GSSX9yfhY25M9xd1UkPsMfL
	 E62MOl7zcNB9lNEZuQxJMPQNTI0OI2N7bSF1X8gJA6qZCkhRXLwUucfYDTiZUohpELw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=e3ovriLm;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE60660A3810
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE60660A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=e3ovriLm
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so2643820b3a.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 07:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1794496758; x=1795101558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hm6Nx8LFz/1dKXtVqVksLWNReVFuahQkEvS1g9mf0Es=;
        b=e3ovriLmxLzQP5H39l4xfylrYSVh6tg6Mk0fiT3lHbaOMtu9kOFigL0bel3zj0qKhu
         T4a4PHz54beDsBmowoYncaAc+5+hMK5emSHXoEUhCY7Cl1m9Bh9z4HTiGbp7sKNG7I6i
         z3DK8OtBGoKUjnT/rxqIgsyR4bjf3o4eAGGvF8kAdWk4oq35iIUrfSvbFte7d5QB0nXA
         5vb91svtT0bhsC9KlTt2vRgwC0U4a4yopZ22wVWkA9qlhzueScFlgmoREui/VPLous3P
         hihalzHICcrRk5dom4/6PSQi6EnbqriOPlk0RM3vN26CikUwVFDkyQQiE5PDN45noqen
         jgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794496758; x=1795101558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hm6Nx8LFz/1dKXtVqVksLWNReVFuahQkEvS1g9mf0Es=;
        b=s0sBecu/31vZ/CSBS7P7uzxOiZO+7LRxoQ7WoHPuKKNuqdBOWUEeuBg7xfbYuJL7pN
         1ES+mBz9KEJZKRqUqtODBug9765cS2UXweNwDtl0Go/wWaPgdamxjYssEQhkamLhX8ti
         F1mdrNgAm72nP1z5MY+Qanq78bM/iYqRAh+xXMfx6v/9FCykW+rRw0mW042OXAlaIqal
         i8/MULuXb1lzf3IYEbLC5sewtUrcNYuYnrTzzngxhQhgvY1qLswIFz2e9ay2tdivpnp4
         GjsotFbmWcw7ROIAO13EwzdZ0D1HJ+oIU/9H3klp9/JUwTHjF9Iv5qQcVi7IwdUfXIpy
         VZZQ==
X-Gm-Message-State: APuU4Z+0gvH3yegyjiGhcjUpi+mQlBDoButIl52h3wfvQIb5TduH1xVc
	MxWJonqTWvBgPOfYKzPGljdq+2tQfukSbcipaumwT/QFSwDtd2pMKWLTWHOuFcI1tvKyO/DzaXM
	DXfNMcDAC
X-Gm-Gg: AYBFou1dMGTbKpcHCjuDvd9vci4jyY3mlWvfu/3KRIfW1xK1sdrvz31WjQD0GpzyezT
	E6QAe2oWO6HxeCGnULW4sQtc/J3hTm7KCzRdEcagWi8LxPttFAFMH38XU19DV+zNIdAj4GhuTfz
	CMPwPaKe6BZ9tTzm/A3wGew6GQvmOZiwPl9YDRkPT/gtZSpGraqMwGO/IPauto9iicCJifPFl+Y
	S73qYU+LWbWeHTkvnJABYPPrxWdC3wDNFMh0s7EOoXZDFyqZeCfYfHbqnr6OkGp1PBzGfdr77UE
	KOqk6OpteeueStHZL0+yM2UzsKjtykIESVH+w25FfX3YHPRWhFf0mozKAnLUUy+Yi0IE8mzm2Yt
	fwuJ6XXr9hFfou0wD6U4SwfpeW+68TZ5L3WSIYlzOZhqLG6furK6M4I30PuL0Sds0grR/TSaG6z
	05NcqsaiUEN8xQcZ2e+rzLkY1SQ547BE5PMZJDqylAHREpJOy3diwCbsd+tjagKpUtUwmvCZMiK
	pwFOJUADy9lHaDFO562gVzTZJtkn/NIXgN+1+eRronk3I8k8aBGkrSsvDClkmWJk4GQlAtdOx8M
	17RJ40LTp/ixRVtcxZooszcHhnkouF5EqpVxYI5x8gpdoC7HVN+QS3qrpr537dwzDNezwA9cq2c
	qIw7tRB5mYf8odFbw6t4noxtFnSBCwN74Lx8XiIWgkw==
X-Received: by 2002:a05:6a00:2d92:b0:8b6:12fd:7271 with SMTP id d2e1a72fcca58-8bc1cc6819emr5635604b3a.25.1794496757969;
        Thu, 12 Nov 2026 07:19:17 -0800 (PST)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3a55sm3561480b3a.3.2026.11.12.07.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:19:17 -0800 (PST)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net 1/1] ipv6: mcast: use resolved interface for source filters
Date: Thu, 12 Nov 2026 15:19:04 +0000
Message-ID: <a5d3d0505baed01a213ea7953f0fe78cb025ee22.1794492711.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1794492711.git.zihanx@nebusec.ai>
References: <cover.1794492711.git.zihanx@nebusec.ai>
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

When no interface is specified, ip6_mc_source() resolves the multicast
route to an interface but searches socket memberships with a wildcard
index. A socket joined to the same group on multiple interfaces can
therefore update its source filter on a different interface from the
interface filter.

Use the resolved interface index for the membership lookup and for
dropping the membership after leaving the last source.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/ipv6/mcast.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index ecef55f26189..63770b3a7bb2 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -362,6 +362,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 	struct net *net = sock_net(sk);
 	struct ipv6_mc_socklist *pmc;
 	struct inet6_dev *idev;
+	int ifindex;
 	int leavegroup = 0;
 	int i, j;
 	int err;
@@ -375,6 +376,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 	idev = ip6_mc_find_idev(net, group, pgsr->gsr_interface);
 	if (!idev)
 		return -ENODEV;
+	ifindex = idev->dev->ifindex;
 
 	mutex_lock(&idev->mc_lock);
 
@@ -386,7 +388,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 	err = -EADDRNOTAVAIL;
 
 	for_each_pmc_socklock(inet6, sk, pmc) {
-		if (pgsr->gsr_interface && pmc->ifindex != pgsr->gsr_interface)
+		if (pmc->ifindex != ifindex)
 			continue;
 		if (ipv6_addr_equal(&pmc->addr, group))
 			break;
@@ -497,7 +499,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 	mutex_unlock(&idev->mc_lock);
 	in6_dev_put(idev);
 	if (leavegroup)
-		err = ipv6_sock_mc_drop(sk, pgsr->gsr_interface, group);
+		err = ipv6_sock_mc_drop(sk, ifindex, group);
 	return err;
 }
 
-- 
2.43.0

