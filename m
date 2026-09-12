Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E6933E345
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183925; cv=none; b=c6wXyXM3fnE7r7RtXmU4aPel8FmGzPVcff5hRqwliWg4Vld/ya2/aby1L99STRkS+wfsAUGbej0JmVwCIpMq5SKj6K2ueFMJfxKVJZZEm+oqrLltd5AboRvY+d9ydcw4mT/WOcE84TGfuy5Axis7uaRR6dumyKvVwMX6+vaCOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183925; c=relaxed/simple;
	bh=kAi997qdy2ovmm3AfFVJSykrYNXUxKxyQ2JZeYlp77k=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=gudqGnzxZaGyXzklo5YLfOHsH8ABkCrNPI6WUXATTzPHeb7pEd67MKwDaUD/WbGFc6NztHBqZLtGIf4JwefGPDofO2rjgJmx0Dvd8qieyQ4e0goP5sw7DbholYmjhZ5rk9BLyj6wvj5kS/CHSe1RSVErchHXkItTmb7O8/aB45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEtOtDdq; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEtOtDdq"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7fccd4c3f36so511954a34.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 20:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789183923; x=1789788723; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kAi997qdy2ovmm3AfFVJSykrYNXUxKxyQ2JZeYlp77k=;
        b=KEtOtDdqtPxO+NB5mn9hqI+StiWNtUuHPhRdPsDIeQzkIO48DbF7cp0EObvQudZO1K
         ULco0kA8rrZG+5xFs/wgUc4W/DYz/7T02F4V0+dCvAiyHSeQtOCObTThN4w1q1sG6qMd
         0OnG+O0UcxaDrfVAkSk5KfC/34uWUyQXJGwJTQZqYQ7DVSronymiqO6zzPsMPfjRNNs+
         7ukikb864uQVzZED5/6CZzloFLVycqu44qzI4Bq2n1NGK3YcaSxZA7YBg2/y5Owfe/93
         pjLsbDrYIM0YE8PmHMRyJJiUQZLB0SIY3mHHxzuPe0a8Ck0wW+q35UmAv6TMnDJO7mr+
         K8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789183923; x=1789788723;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kAi997qdy2ovmm3AfFVJSykrYNXUxKxyQ2JZeYlp77k=;
        b=Rmq1rfdfS6cFd+12O4uBG1bUqUue1UU2hyEOog5f/ReZdhXil5aeOOSKfURTyBkbIg
         KqS0vMj2hx63EQs+FS3y4C/3H98qk7QB57wnk/3payGlYE7np9Ko3JcieH+t6SHHQZ1n
         XfM4e87igXGJmXK1M/YajCoDweA3DQr/nH8NAEe4cuy/npbwVr5MkrR4Zelov8hflV4n
         4SGO71ZHDiYxvCU/3/Wcs7lXJYrca3A1R4v8CAqwTAv7NAGeSHKYCB9xf5rokPDYK7/t
         /284ONbxYUjfkLSEZgqzsFbBqtTFE5vU5oRI7irNh5gpJvxgWhtRq0w/bzXik6kt2w3U
         oI8g==
X-Gm-Message-State: AFuF++l/th+LkW+IozYSCpEcq5ZntHGWFPIoNDkenB6KG3ee+5Qll+TN
	QMhGXjPDhn0qFn1lC/3ImOKhv5pm/Q/eMgD1iLl42UkScVvCuqiuQCOvh1MVcA==
X-Gm-Gg: AYBFou1FeLjHspoh6UjHiHBiSO2NVF+nSgsAEtJqS+FZwJQ9kzkKm/KyTYydU19HNVo
	WExHXNkb62CJs1FBus13cJqQrQqdKDtDFxWCsvbLa3BDweXmeb2Km72BewDxqMFUWtiMD3W2W9k
	ow4z4ht5dReUwsRa6+EkEgi6u/rKF5PtplGEeY5c/XbA5iIFaZlxojhjPPUMS4XxYJLf6MM6Pn1
	FFP/iBHUYbkUHEzJNmoR4l4mEyBaF4MDiWwL+Y9rMwnG807k4QZd9wtpjK9GsxMYPwOqxRbEI8v
	A8Fvl8J082Z4lCi8KB3oWra8SpyAHjRTLc431XO1OeMkpmMvrilbBjDvzrYHcSy0wSyGKrcRsRG
	R/tN9ufigH/PTxwzk6CmhEebapbUKeFFhfeb9RxHN6ukGf3aNupca/h0r22JGGJIV7QYD2tB80E
	abGqkVFyE7iBAvxu9uI47TW7gfTkW5b8JSJd+kDRXAs9RuX+mcGnx05f3IOcnq9hzjSL4EPqECp
	1inAmeY191XGukllKkOMu7Fk/Dzcz/trI2DHuNVemE4MbzRt/DtzjbGshHI0WajmdNnWb6f0MIU
X-Received: by 2002:a05:6820:811:b0:6b6:1868:9811 with SMTP id 006d021491bc7-6c0bc3ce018mr8649547eaf.21.1789183922687;
        Fri, 11 Sep 2026 20:32:02 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c09690af1dsm4358827eaf.1.2026.09.11.20.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 20:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 20:32:00 -0700
Message-Id: <DLD0RM0A2YPJ.1HFYZFHZPR2WI@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: <netdev@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Kuniyuki Iwashima" <kuniyu@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "Stanislav Fomichev" <sdf@fomichev.me>,
 <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Simon Horman"
 <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "Florian Westphal"
 <fw@strlen.de>, "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 00/14] skb extension for BPF metadata
X-Mailer: aerc
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com> <DLBRCN9O0MAE.9NCB79Y636SS@gmail.com> <874ifw2faz.fsf@cloudflare.com>
In-Reply-To: <874ifw2faz.fsf@cloudflare.com>

On Fri Sep 11, 2026 at 4:33 AM PDT, Jakub Sitnicki wrote:
> On Thu, Sep 10, 2026 at 08:56 AM -07, Alexei Starovoitov wrote:
>> On Thu Sep 10, 2026 at 7:02 AM PDT, Jakub Sitnicki wrote:
>>>
>>> That said, as things stand we have already established in v1 [3] that f=
or
>>> our existing use case - attaching metadata to <1% of skbs - the
>>
>> so you'll be using this bpf_skb_ext only on <1% of skb-s ?
>> How about we add a bit in skb 'special_cleanup' or something.
>> If set it will trigger a new tracepoint during kfree_skb/consume_skb.=20
>> Then use bpf_rhashtable, populate when necessary, set bit,
>> attach to that new tracepoint and delete from rhash where key=3D=3Dskb.
>> bpf_rhash is specifically optimized for 8-byte keys.
>> I suspect it would be faster than this approach.
>>
>> Overall this approach is fine from bpf perspective, but if it can be
>> done with 1 bit + tracepoint approach that would be better.
>
> Thanks for taking a look.
>
> Yes, our existing use case attaches metadata to only <1% of skbs.
> Even if we implemented all other use cases we have in mind, we would
> still only go up to ~5% of skbs by my best estimates.
>
> So the gated-tracepoint, if we can call it that, makes much sense.
> Plus the idea of having a separate RHASH for each user is very
> appealing. No coordination between users needed, just like for BPF local
> storage.
>
> I did some digging what it would take to make the gated-tracepoint idea
> wholesome:
>
> 1. kfree_skb/consume_skb cover only the normal free path. We would also
> need to hook up to GRO merge/recycle and TCP coallesce/collapse. IOW
> everywhere where we call skb_ext_reset/put today.
>
> 2. cloning - we would have to hook up to __copy_skb_header, so where we
> call __skb_ext_copy. Plus some handling of fast clones would be needed -
> perhaps a way to resolve &skb to its fclone twin address?
>
> I think it deserves at least a prototype before we make a call.

code is free. Pls produce patches and benchmark them.

> Code-wise I'm thinking it might be easiest to take advantage of the fact
> that skb_ext already hook ups to all the right places where we
> free/clone skbs and add the new tracepoints there.

fair enough.

> If we did it like that, we could then just gate on a bit from
> skb->active_extensions, and just handle activating the bpf_skb_ext in a
> special way, meaning it wouldn't result in allocating the skb_ext slab.
>
> Let me give it a try and get back to you.

Thanks!

