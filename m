Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215772;
	b=5YH98PsHA450z1/lfum1iqNHzvsiCAVRIOm7l4tw2B/uBhmFkBbRTGVvu8gGRM1iVq0g
	 D56PGWoWz12tpFBgQQFXBxAZYG8WYBrcgnmbw3KQ+ShjXiCwc1BHVqokPGEulZr6AYNhm
	 sHYheg64kkxTtwsVDniMTQv26mQKkIHj8RENa2ns+zTizFz1+LI1qYJlVQNDPeSYgXAPJ
	 8d3SI3g3TalqncErD2elfeWlOPhRlpAv0+yLOQKBB8BE6jUccjyUKuJkcSiSK8vvNRnIm
	 xeLkibQ32H2KGI9ZuvaQb8EGQpPsb60bJTTZ4GNtqKba1U108oWJQ/cDGPlL82kli4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fhIxlpuFJcBXrphNeNwx+YcRvaFe0jopB+8JEZHNr+M=;
	b=0rONM9e5K/ujELriaxgsizKGN0+3NreOmQLOGjaYYjPeT4qRHwSGn6AEKh4pVUPiJZhm
	 z7kXGO1uqeGuEXhUpUalHWZHGrb4p1tEHCzXT7JteimasdZbtMSigVK8Z/YK1XZJCEJNU
	 wIGLDpxSP85hnKZVPbmvRpJKRcXSVm9fBZxYfftttxoLWCCmwrKZvpIj5Pn+ku6oO/rFC
	 uZca2Dh+3FElsrvUIrAD9RX+BFXl4fQv/BBKrMeiH0tsRbp7kgr2E16jt93uJPR98WYkQ
	 5GSmopaBVl5kSIpJf0HNA6wh2vlg73UxN1p8ie9iaWByy2TQfWvUblV6a3OkmjCohZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nDyVVPpZ;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F06606A31F
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 19:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93F06606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nDyVVPpZ
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e8ba4757baso11211175ad.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 12:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793215771; x=1793820571; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fhIxlpuFJcBXrphNeNwx+YcRvaFe0jopB+8JEZHNr+M=;
        b=nDyVVPpZ2XLMVcMcMfu3Ju2+6ZjLyfZ3SxeUgOM8o0tSDQfHLG1jgqSLCFvlis7uOZ
         wo1/C87w0qBPcfvh051AN4U/I9OnnvEZhF0Jwep420UsCNWlevoCr154K8dmYSBfTmmx
         XHhcoFj9eBHEsvE3CefF/Vyiuyo/+XOpSi1R0OFeX19g2CroLgDWu11IZUyTN6kqH7Om
         G+EXIQfNuZHLnlDEiLVdX/4+GIiZoT1r4ndYW0cMi7NcGxiajgEZbMOlxbacOCTAWEbp
         J6ZtvDRUsYzYQb/jJaoSuC7KS8zTLk8JspOkALI1Y1kUkqwoTwLL3QLe7Xkyu14EXDz4
         eULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793215771; x=1793820571;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fhIxlpuFJcBXrphNeNwx+YcRvaFe0jopB+8JEZHNr+M=;
        b=0CtXcbZlCJzjqYQZKKtcGIYGwjbNgComRzEYq/7FcW9rgwjLgRW3eyTcHCtC4JZ/LD
         0OdC6SVS6Hb/J3fznzNkt0QIcHJExC+cA4LwgpCOobAt4ZDG081AQc15DFinJc8jqQ1c
         0f8VK3VVVZcx+qLee5AkUaMMawkHfFzLi3Rav1fnEgLnJ1pdvet7mEhFuPNnWbzeBN5C
         wsN8hbZ3dFGGFHTiMbzf1BN72kEWnoR+YOtNfVNl5/Sv6blUcFZo73aNB2bgRe+Q73GM
         k7L6MxjCr/eJLmXWKn8pxL698o7m8Dm0odEmpvMTeAvoMP3qNHQx9qL50BipROBBj9t2
         gw+A==
X-Forwarded-Encrypted: i=1; AKwUvBwS3dj3dzMieYJypbc9diHWiV1vd2PI0vxB+LhOXmTZGlHWocUUQPIdw+PPbMWMiEqC9+4LcHI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6DYaRi2Ug3AIULfSj6ek9vFXnUbNdW44H+/T0kryuQkBDbVFx
	BzGVdxrQufFnqvGAKbEZX/cGPiy2tvxvEq9mMTftrKweNxpzbiAHT2f5JCnKl3mKKKW3JO9FjBS
	qIMBRdg==
X-Received: from plic6.prod.google.com ([2002:a17:903:3706:b0:2e8:7c6f:de6a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1cb:b0:2e9:5714:608e
 with SMTP id d9443c01a7336-2eb00487c87mr32243115ad.49.1793215770650; Wed, 28
 Oct 2026 12:29:30 -0700 (PDT)
Date: Wed, 28 Oct 2026 19:29:30 +0000
In-Reply-To: <20261028160226.2170244-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028160226.2170244-1-edumazet@kernel.org>
Message-ID: <auJNDPw54Ojurqqq@google.com>
Subject: Re: [PATCH net] tcp: fix reordering addition overflow in MTU probing
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>, 
	stable@vger.kernel.org, Wyatt Feng <bronzed_45_vested@icloud.com>, 
	Ren Wei <n05ec@lzu.edu.cn>
Content-Type: text/plain; charset="us-ascii"

On Wed, 28 Oct 2026 17:02:26 +0100, Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> Commit efb8763d7bbb ("net: ipv4: bound TCP reordering sysctl writes and
> MTU probe sizes") widened size_needed and the MSS multiplication, but
> tp->reordering + 1 is still evaluated as u32. RTAX_REORDERING accepts
> an unrestricted u32, and tcp_init_metrics() can install U32_MAX.
> 
> In that case the extra-data requirement becomes zero. A write queue
> with probe_size - 1 data bytes and a FIN satisfies the sequence-space
> check. The coalescing walk can pass the queue head to
> tcp_skb_can_collapse(), and tcp_clone_payload() can produce an skb
> whose advertised payload exceeds the data in its fragments. Local
> delivery followed by TCP_ZEROCOPY_RECEIVE can then walk beyond the
> fragment array. KASAN reports a slab-out-of-bounds read in
> can_map_frag().
> 
> Cast reordering before incrementing it so the arithmetic handles the
> entire u32 metric range. For U32_MAX, the required size exceeds the
> 32-bit queue and window limits, so the existing checks skip the probe.
> The calculation is unchanged for all other reordering values.
> 
> Fixes: efb8763d7bbb ("net: ipv4: bound TCP reordering sysctl writes and MTU probe sizes")
> Cc: stable@vger.kernel.org
> Cc: Wyatt Feng <bronzed_45_vested@icloud.com>
> Cc: Ren Wei <n05ec@lzu.edu.cn>
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
