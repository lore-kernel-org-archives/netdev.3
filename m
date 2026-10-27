Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793065205;
	b=wQTT5p9+rwCY50VKIdeVpVZsRKPABIcJBPii3GjqEzmKd9r8TxIpBtVPHSnTuD/MBdcC
	 MvILu2YSwsWxBHu10HQHQ6nJ5MIOKiorg3m+WI8Svrf2nxAjA67aCHPWE/GdrcNepsoH1
	 ZaxgvDHLp9AsSEuJWv41V3YcrLqk2gmBYr8j1+savfPm54fs3Q399f+FWL+2ZBSIkV2Aq
	 7hLwJKLYQBTd8LpluGLHONzYno95AFcUZbGbldpJMCJpgX32FU6PFV/M1T/ntBUOpPJw6
	 Ly1fl7GQVMjUi8ShqPYYYi/wfZa5VC/uN98ononIPnPxdatGhAF3lHJxIX3SBQEybVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=nv9HsnuR2s0zivEyLhnXuDkQch7VTmwqkDtdEVxYw4I=;
	b=lJkZIMrn8A325QmETu0HXvGvdpfE0eBSDjyW5FWWeWBIbgE8OmAav8uNnz3amBBs51b4
	 AgXblbpn3oNtKjSo7UpUKqaTKu1xUjj/ONkCV097yy603d0A3nD1JJlE4iKHIxTEWXQdk
	 J4iKX87Nyru3zV/lwxREBElzC7ghAUgo7fsjpq2upKdqsrT9z09Zs2I//Ou/r6H7SyqgH
	 CRfaza4hyVmbnPuuUonB0YaV+sM+n/odgEPGzA/+mnlt2KbVdjcsK/cf1Sq0cUSJkWMtL
	 ykuy1A6n9ZfM8cmheYqYYJ3G1dJXxX737XJd1QOgIhe4d5xP8OZOB4nDY14u1BNll7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="BJSl/v8f";
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF66606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CF66606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BJSl/v8f
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3aca98f01c1so3499020a91.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793065205; x=1793670005; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nv9HsnuR2s0zivEyLhnXuDkQch7VTmwqkDtdEVxYw4I=;
        b=BJSl/v8fACwisdyVujv+zmjEYi8Z9NBnfwloLZFTkZYLavfzOxQ8MPNG/bxGlNU9lr
         cDjZvV2WIeaDMDnaqZFMYlcGolnkIgCZSp49B6y6dKWwbwzivfOmKR8xKI+JRpOtNZXi
         OizIFZ275RxgSbajkf6xbLcoDPr3icF8NPSGSDlGgeQwlWandyst/P8NR48zunQLN4Hu
         wYKWj5pa75zHVQUuCfldrezVJ3JivKKLzm4rCp7U0EkrEIhqMGV6EAjm/WuF7fd115o6
         J0L9u5mS1aG9jg6wc4Vj+Yeyq37nimkysmbldjR+g4KbWg/NTwhbnGI9W7oFJy6nP4zN
         HBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793065205; x=1793670005;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nv9HsnuR2s0zivEyLhnXuDkQch7VTmwqkDtdEVxYw4I=;
        b=c3rJnqaFtgbXAfrm9w8kEPgd5zGlcOzzc1dpxriF0PdLrYQUMgIfJYNzeoZFCgVf76
         ZInMdOqY3HXpKkSLLIkHuBdB5rmMU13z3BJ7uvnk0aCO0pqHe0z2qnsuTgKEE4bc85w6
         Anu+cAPfyRc6y/hsZGGShd89W46iKNwGm66+bmoL3OTOAjI+L0G+CcSuJf92v8zhJc5S
         WaBzmMUGccM+hBYO4HWY1kju2xhKPVJnsmFplJMF2CBTod15G+a1KYV/CEFagFdy1vbQ
         PrhG+AnHBiCj4IEjkH9x22w/1knJBAHlXsRgYbaay/yNo6UV52SAWxnyEfxE9VIqV/wx
         qyeQ==
X-Gm-Message-State: AFq9FYJIIObATcLRj8ZBJVS/3ma0tqmbsZS4qhjp25VtB51py07sJ9xJ
	Djc/WmoN0pHR00MSNQO4ibZgOWngTow4tKU23+hcwaLItY/zZr7VtWntzcwpsyZc8wy7+VSvFJ2
	eY64Enw==
X-Received: from plkb13.prod.google.com ([2002:a17:903:fad:b0:2ea:775e:19b7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2645:b0:3ac:c03a:38ad
 with SMTP id 98e67ed59e1d1-3adea093f10mr7705773a91.5.1793065204454; Mon, 26
 Oct 2026 18:40:04 -0700 (PDT)
Date: Tue, 27 Oct 2026 01:40:04 +0000
In-Reply-To: <20261024004835.17862-1-user148783812897@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261024004835.17862-1-user148783812897@gmail.com>
Message-ID: <auAA6ww0o6W07hGF@google.com>
Subject: Re: [PATCH net v2] net: limit priority VLAN untag depth
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Kamil Sawicki <user148783812897@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="us-ascii"

On Fri, 23 Oct 2026 20:48:35 -0400, Kamil Sawicki wrote:
> The priority VLAN receive path can repeatedly remove VID 0 tags and retry
> packet processing. Unlike the read-only VLAN protocol parser, this path has
> no limit on the number of nested tags it consumes.
> 
> Each skb_vlan_untag() advances skb->data and resets header offsets. The
> offsets are stored in 16-bit fields. With enough nested tags, the network
> or transport offset can wrap. A later protocol handler can then derive a
> large pull length from the wrapped offsets and access memory outside the
> skb allocation.
> 
> Apply the existing VLAN_MAX_DEPTH limit to the exceptional VID 0 retry.
> Count the tag already stored in skb VLAN metadata as the first level, then
> stop before untagging a ninth level. Keep the accounting inside this
> uncommon branch so the regular VLAN receive path is unaffected.
> 
> A single VID 0 priority tag before a real VLAN tag is valid. No normal
> deployment was found that intentionally emits multiple consecutive VID 0
> tags; permitting eight levels is therefore conservative.
> 
> The issue was found while researching the Linux network receive path for
> Google kvmCTF, with OpenAI Codex (gpt-5.6-sol) assisting the analysis. The
> affected path, reproducer and fix were manually reviewed and tested.
> 
> Fixes: 36b2f61a42c2 ("net: handle 802.1P vlan 0 packets properly")
> Cc: stable@vger.kernel.org
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kamil Sawicki <user148783812897@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
