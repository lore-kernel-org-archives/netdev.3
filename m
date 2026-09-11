Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9867149E14A
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126546; cv=none; b=Ly4v4in056Xqq5tSXiDNhfSkNEWD0WR/MNn35sJ1ggc+f7XGnXovERWDZPwaAW+UPAj71N67Ue/3y2razBbbdfcUAoUR3YrtcAYpbULLYRvugWigTYgxTsaJVfCvS5aE4jw02SOVhfK9xWfkEWsnPSLstlIn0PrlM3btiklGBMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126546; c=relaxed/simple;
	bh=B9iEp4dj/QmdlxEghaexXBcq38CvoyNFPGzJi9N0xkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j6jqXFF7saePZXQSrIr2/sPgqg0z1zqM2U/MualCvTJzLSkWqn5erQ7oKt0gXu8mOtw/lxE8d035vRXJnGQQtUoLk+TFPFyE1Q0wFiyiZBKL+lHq908xxQtGl8YvxHSYhADQ8dcKyJ9V5qmp7SwXX1hfHYyYP/1aGAixJuo+YM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ck78qSwc; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ck78qSwc"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a9b7b89514so778244a12.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 04:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789126542; x=1789731342; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7Nwd8FSMQuusOD/Zw8yh1D6XaRZAPE+DLVPwG34kX8s=;
        b=Ck78qSwc+Ycp9Vn7eKGjg4U3AbwBmZu23diweKqpiUsto8DtkMPnH6pCnxP7vvFxih
         0e5KFaj2anhegVJUPPU9Mec0DTGEKxNHV0M6aO8qXhtvTrfj308Fon77PxxkuzEDDsI7
         x3fA9WFnqkj4IFO7/CP1QrcpdSnzTIkvuY4P+mOp6rRLjilSTqBqM/sgQ49KZEx/09mQ
         58ZoMCPz8Air8Gy5hkwCQ19PLlCkyKRR8dyOKb7ngC1EhibFXbXrE24KYH4kr82S3Uz4
         NQEh3brj5zAFZnqu4KHwtvvTZQcTmooMKsU3s8DDqJ6ibDlSdDU4Cf7i7BqTFMjpnwoC
         gcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789126542; x=1789731342;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7Nwd8FSMQuusOD/Zw8yh1D6XaRZAPE+DLVPwG34kX8s=;
        b=k2A+77cSJM8J66naxfJU0M2n8pWxvdpv2tUUp12MY+/cm2mnIY4POxmN4hn/pxKJFI
         da8iXnhCKOFXcaE3XH5Ysv4K2RrY4zFitQIP9/92XF+es6fJYfxlFhP0K3dKNi3wcBAH
         mIuSjV9UYZfpeArLxrJis1GqDb22z3tvK/LGr90+gTZLk9DWuYLOvpuTi1yin9Wo5s2G
         Af4zezR6pc1IKKWHYD5f47mEX+dKdAf2eDTxhfHj+K6Xj5GKaxzPSIpDA66/77BTRJ8n
         K7HuMj/eaAhIFvmeKmDCTPRzhEEYSjqtfQsS2dQxidYeu01evjXay3lwU9XWjHz9EUUs
         dG8A==
X-Gm-Message-State: AFuF++ntJ77TDNKhQSw19Axh9WWAW//LdO+CN8w5B6xRwCCI+bsYvu/c
	MP8NLZssMCckNfBkCSrB7LjqC4uDC2f1BFMoi/abAiHklrX1OjOVOCVXAB26VBL9QGc=
X-Gm-Gg: AYBFou3VrnuVygTmh/efe1kumUHYPQw0lMd/uYgtDnKQ3v7p/31Hsg91NE/Ul9+tpGT
	pxXUsrb4wJgmFigbCZSn9k4Ous7C2vdPmmKg5fAm7c+oUrKtNt/4SPxWJs7UE+RimHQdhnNVuHP
	gcWYZS96xuUXim68BFbSL4znKdyK1gr+61ZvkJ46ihvJOU5QWGncT7PcCtgLhB2FoaKjgEkPuuW
	+5hGd+46GQtq1FKRWcVrL1OTPHykbdyw0EQTvHzf6gjhI8d0mGMOLhe+OiPS62RXH0DeUf1j4b9
	xRdRIytvZH3rs0hkiIPpWV6wY1MM54DysUY4KAtYvkgPAKm0bAAZeHMUl0QrnFmTsM7roMPHMMe
	xv6u1uEn/jbKJiaRy8nA1U2Gw/60G+kOjcKG+E3YhsOrMopX26btwECAZ6fJztJczoW4UQJWXSx
	4ZJZb9DWU2Rawdhgr8zKKjUNaNzW6SManM0TAU98/zWtnSIP7YLE1LwDwAG7DDWY7bpQtBesDj2
	WtTVNRy3uA=
X-Received: by 2002:a05:6402:46c5:b0:6a8:398d:f57d with SMTP id 4fb4d7f45d1cf-6a9b56af267mr1529753a12.27.1789126542478;
        Fri, 11 Sep 2026 04:35:42 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b5914700sm628921a12.12.2026.09.11.04.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:35:41 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: <netdev@vger.kernel.org>,  "Alexei Starovoitov" <ast@kernel.org>,
  "Jakub Kicinski" <kuba@kernel.org>,  "Kuniyuki Iwashima"
 <kuniyu@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Stanislav
 Fomichev" <sdf@fomichev.me>,  <bpf@vger.kernel.org>,
  <kernel-team@cloudflare.com>,  "Daniel Borkmann" <daniel@iogearbox.net>,
  "John Fastabend" <john.fastabend@gmail.com>,  "Andrii Nakryiko"
 <andrii@kernel.org>,  "Eduard Zingerman" <eddyz87@gmail.com>,  "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>,  "Martin KaFai Lau"
 <martin.lau@linux.dev>,  "Song Liu" <song@kernel.org>,  "Yonghong Song"
 <yonghong.song@linux.dev>,  "Jiri Olsa" <jolsa@kernel.org>,  "Emil
 Tsalapatis" <emil@etsalapatis.com>,  "David S. Miller"
 <davem@davemloft.net>,  "Eric Dumazet" <edumazet@google.com>,  "Simon
 Horman" <horms@kernel.org>,  "Jesper Dangaard Brouer" <hawk@kernel.org>,
  "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,  "Florian Westphal"
 <fw@strlen.de>,  "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 00/14] skb extension for BPF metadata
In-Reply-To: <DLBRCN9O0MAE.9NCB79Y636SS@gmail.com> (Alexei Starovoitov's
	message of "Thu, 10 Sep 2026 08:56:37 -0700")
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
	<DLBRCN9O0MAE.9NCB79Y636SS@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 11 Sep 2026 13:33:24 +0200
Message-ID: <874ifw2faz.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 10, 2026 at 08:56 AM -07, Alexei Starovoitov wrote:
> On Thu Sep 10, 2026 at 7:02 AM PDT, Jakub Sitnicki wrote:
>>
>> That said, as things stand we have already established in v1 [3] that for
>> our existing use case - attaching metadata to <1% of skbs - the
>
> so you'll be using this bpf_skb_ext only on <1% of skb-s ?
> How about we add a bit in skb 'special_cleanup' or something.
> If set it will trigger a new tracepoint during kfree_skb/consume_skb. 
> Then use bpf_rhashtable, populate when necessary, set bit,
> attach to that new tracepoint and delete from rhash where key==skb.
> bpf_rhash is specifically optimized for 8-byte keys.
> I suspect it would be faster than this approach.
>
> Overall this approach is fine from bpf perspective, but if it can be
> done with 1 bit + tracepoint approach that would be better.

Thanks for taking a look.

Yes, our existing use case attaches metadata to only <1% of skbs.
Even if we implemented all other use cases we have in mind, we would
still only go up to ~5% of skbs by my best estimates.

So the gated-tracepoint, if we can call it that, makes much sense.
Plus the idea of having a separate RHASH for each user is very
appealing. No coordination between users needed, just like for BPF local
storage.

I did some digging what it would take to make the gated-tracepoint idea
wholesome:

1. kfree_skb/consume_skb cover only the normal free path. We would also
need to hook up to GRO merge/recycle and TCP coallesce/collapse. IOW
everywhere where we call skb_ext_reset/put today.

2. cloning - we would have to hook up to __copy_skb_header, so where we
call __skb_ext_copy. Plus some handling of fast clones would be needed -
perhaps a way to resolve &skb to its fclone twin address?

I think it deserves at least a prototype before we make a call.

Code-wise I'm thinking it might be easiest to take advantage of the fact
that skb_ext already hook ups to all the right places where we
free/clone skbs and add the new tracepoints there.

If we did it like that, we could then just gate on a bit from
skb->active_extensions, and just handle activating the bpf_skb_ext in a
special way, meaning it wouldn't result in allocating the skb_ext slab.

Let me give it a try and get back to you.
