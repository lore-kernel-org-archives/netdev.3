Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0536B906
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271865; cv=none; b=WeF6qe3UxXm6F6V5f9hW+yKy+/fHt6m0kZZ5ARYYKv55yv8Rh20jZohBVqcjFS66XvH3kM8VXuVwAfdJgd9HYtIjZxtUCKUwhYJICC3ID+nHThqNEYhAKRwXYkkrSihsIbi/KCBvwOnzL3WERmYvJXTtYBRLrXLcQN6ubsxPd9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271865; c=relaxed/simple;
	bh=wmPMHC1jQw44i1T64FaGGEqSLUNX3bHOWA29+TTe87Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IEU42FgGrL41KlHGMyySMo4PFxZXrJZ0dK9cE2Pdpa2YxJH10zra3zZvbz+HBiEacmXrm2ZPixQoT/EslkA4vZAuv4LRjgTb2cs0HN1+Q9xg7u2gv75G2gavM4o61KiWwbEyASnx9euLJRlPWZsG6NEyN+hPY28Hx4KASI/PP44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jv2gXnRK; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv2gXnRK"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81f3b227a4aso12200797b3.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788271862; x=1788876662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HxeaBvDlKAqKYcHDBk+Xfrsk7n+I0JQxkCoAoHuqNkY=;
        b=jv2gXnRKtv8Efll3v+KfvtOq3NaHFg4BnQuJSuvHAuQW8fWCDYZvy2kEcVx4hy3+4u
         1RPLIMQMjJqC4XdoU7IstCiIX13+zXOkvUNSbHIkpeBYq5r0Zl2JgTUCMAb6TUUH1J/h
         82BmbnpcD2FOpVJHJ2Lv4M6apGuRbGi11dM/xD/sDuGLnQAnufUCPIB6163Su4cGTuZ+
         dVnBGfP8Hy+QlLaHYAVG9L15iypGZDQqkRhlG0RJrlhV/jwvUtdHvYHDZjX+McN0qyPF
         xnYrCc8IccL4PYEmRCYMCc266ZJsaeMoy+6ldsUkglaKFG8JoIpOEI5Ny+5cm+wgpZmx
         eivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788271862; x=1788876662;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HxeaBvDlKAqKYcHDBk+Xfrsk7n+I0JQxkCoAoHuqNkY=;
        b=Vkldu6HsM3hVkgAAUOx66oDXghOJLDYDYGqLZgAVPT30Q1rgWSP4cGX+tk21P87Z0D
         gSvFRGlU4PADa2TW3Y2coWG2o/qCTXS0sKhPiYJZb1ruGxCYHxc3968zh+yFMAyhbyGW
         C8Zj6lN+fV41vkSrglDpWsMw6WbjarQAqd7bCQmmlWirumXFsrKVcj8ZFRNIF2zdaTJR
         rQK4P9rXLTMK1BR+zCRg6qD0l4NuIzo8yFQSwsNte5dPWUMS82jhGqHPaSG/LYJKcv76
         oek1QI6wLZPC/7/EUHFdnl2AZmGTPrORLMLwLsoL0ez6k7Hw3LoSTel0/7WlNb+DJ1lu
         wUvg==
X-Forwarded-Encrypted: i=1; AKwUvBwVgiJHgDBu8lHsRuRC/Zyv5MjEDLLK/COpuzhefcHhwlDZ4IFa/phoXUEDW3X1cHC7NLnArr8=@vger.kernel.org
X-Gm-Message-State: AFuF++kqWNny/2nQ7tqCinqB4JhrQlpt9m2ywBg3epgQyLAc6is1/QCE
	xwhtOMOXwd1gF7U0YIhVDRA7VXq0IzjUtI/Faa9bU/wJPOu0WGNKh8/6
X-Gm-Gg: AYBFou23xhurI45F6fraLL8oW7QXGm1dFQE2fK+vZp+pNyqTs0iXDaqZb16Re6Kdykt
	FMIPlaRGvjUcoUvcEoo9r53/4oFPgjxV62q7s8Q/6acZiBchhYYVyYEiQ8Re9PckAh0Uv4kW37V
	yhQuSUvZnXQmQH5CFDJ/zgdQMLqzu3eImjQ9gGoNCAiwdEG+bhlG8AUzil5qURijzG6j0t7cBDZ
	chAMwF3gfuAOY8Rof5/n+32romfSp2RKnX5N/2Pkl3V8YGXMMerEbh3/JhfUoFOr6Et0LoDZ99x
	aXH9LY3UlbC/qiaImk9eMohI5167ukfYrr0qAcdI9L51nOeRWGB8eO8PdzMvkDHNJJlKeTZVayo
	8+FtMgahg/Ru+3V6FmulvvsFu7UeCTtF34aEvRUcNwNgV0YViu7g+gSO1dKDUK3N19xFr8bkBql
	HRahFqJ/S1eD7NoTjn2X+82FikM5MIJf3c/z+3tsvAuoNqRwVVf2wKkKU+9Z7ksynF8+kqmL7TR
	ZrMvy9kQn8m700TRHAX34MZTb5ttCRWxgin7zoGPQ==
X-Received: by 2002:a05:690c:386:b0:855:2d6d:2db5 with SMTP id 00721157ae682-85d69e03e9cmr131893827b3.12.1788271861366;
        Tue, 01 Sep 2026 07:11:01 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e65f146edsm76395397b3.32.2026.09.01.07.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:11:00 -0700 (PDT)
Date: Tue, 01 Sep 2026 10:11:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zhaoping.shu@mediatek.com, 
 edumazet@google.com, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
Cc: haijun.liu@mediatek.com, 
 xiayu.zhang@mediatek.com, 
 lambert.wang@mediatek.com, 
 Iven.Yang@mediatek.com, 
 nbd@nbd.name, 
 HW He <hw.he@mediatek.com>, 
 Zhaoping Shu <zhaoping.shu@mediatek.com>
Message-ID: <willemdebruijn.kernel.4214410e062b@gmail.com>
In-Reply-To: <20260901082312.14596-1-zhaoping.shu@mediatek.com>
References: <20260901082312.14596-1-zhaoping.shu@mediatek.com>
Subject: Re: [PATCH net v5] net: gro: Fix nesting of TCP GSO SKBs in
 skb_gro_receive_list()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zhaoping.shu@ wrote:
> From: HW He <hw.he@mediatek.com>
> 
> Fraglist GRO and hardware GRO can create an fraglist of
> HW-GRO packets. This cannot be segmented back into
> the original form on TCP tethering scenario.
> 
> Avoid constructing such a GSO packet, by flushing an already
> built fraglist GRO packet if a hardware GRO packet arrives.
> 
> Scenario (Tethering/Forwarding):
> 1.Driver submits a single TCP packet, P1. P1 is kept in the
> gro_list as the first packet.
> 
> 2. The driver submits a TCP GSO skb, P2. P2 has already aggregated
> multiple TCP packets by HW_GRO, and its non-linear data is stored in
> frags[].
> 
> 3. P1 and P2 match the GRO rules, and since there is no local socket,
> they are aggregated by skb_gro_receive_list(). The resulting skb,
> P3, has a frag_list entry that still contains frags[]:
> P3: [ Linear Data ] -> frag_list -> [ Linear Data ]
>                                     [ frag[1] ]
>                                     [ frag[2] ]
>                                     ...
> 4. Later, tcp4_gso_segment() or tcp6_gso_segment() calls
> skb_segment_list() to segment P3. However, skb_segment_list() only
> segments the entries in frag_list. It does not segment the frags[]
> inside P2, so P3 is not restored to the original packets, which leads
> to IP fragmentation or packet drop in the following path.
> 
> Check skb_is_gso(skb) and current GRO method, make sure fraglist GRO
> applies to consecutive non-GSO skb, others adopt regular GRO path.
> 
> Fixes: 8d95dc474f85 ("net: add code for TCP fraglist GRO")
> Signed-off-by: Zhaoping Shu <zhaoping.shu@mediatek.com>
> Signed-off-by: HW He <hw.he@mediatek.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
