Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7E4E9C27
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610863; cv=none; b=mI7LrhCMlqs347e0ZfV1+JHSiK+8pPPsOhnSkzq8+hxnUBgo/rw5I0siJSqCFQWXj/cnWdteogPQZe3gprG7JehMXNFJl0C6JMyQpixNTdgmp/jgH2UlQOrEwzZcmU1SOlCrWzYK/c/I6BCUsKtBc3LCwyMyz0EJHs46Ync/fUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610863; c=relaxed/simple;
	bh=ghSZTabWnqxavl/W4iUtPMg/mi1Uq99yCxVqS1s2Znc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GA/ToNDKZ8zxYAbqqGkhI3eSwXEMpRDQM3jlfnGoUdoLONrkB7UdBx28s1LiQyOjB1iijaJNDAA8s4vHYwOoJRjKxrOX83FGEYCzcywF50BJAlR+WDw5pa9Wqlh3QUA/aN26tuoleVFGRRcmcBegOQGa2IgBNqjCzcJ7Zxh9Jog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VBA5bFza; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VBA5bFza"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2dcdc386ddso192131766b.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790610860; x=1791215660; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bUFOamo9O9BYWzyDGfu0crdKrXnEWewsENPgbfRd9Ig=;
        b=VBA5bFzaioQKl+YYYX3tEBHlYs17GUOJnsh7pZvigvrPuuYvmiKLOhWvOLECSVHvYR
         Y6pEkoTPn80CicjSjzwn2Buby8Ck7eOcdwi2tIdY1gcZKECfQiOg/IokYDKP9OTbdqAH
         3bwWH4cJkQWq3bQ5vp3HH91Y55FTEwE+2+Mpnq+z7WFk0wFexNCRIyBqR8BlnUB+Umee
         JX2QpzZfEpStCvuRL0tjO8VT2H2hFHmi6DyhyU2ngduiPu89BIBAGG8pXGkrf4HJH18F
         wrzqbWyQqc+E7ybjCXjyXap/6VqfzhbWhkA3+2iZO9SiyDnMWetW+FOZPDrtSVaulrjV
         FqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610860; x=1791215660;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bUFOamo9O9BYWzyDGfu0crdKrXnEWewsENPgbfRd9Ig=;
        b=X0okeugHtqhayUnNskJE9nYColbLu/hUc6gXnH4daFegJDZ1SFVQvdfrTxd1ZEga5+
         ZiIZmo0885zaK0GkQSt7/P0L9w+38hODtNbx22GtD1w5Vi6aIk8bF8noMPHbzpiUFGyt
         Z54UEsbbxaLsHLvQbTPeck2nYEgaw/C4Sy37K1PotjicN5LMsvwDdinBJAzZfTFxgHk6
         ucF0BD8g5bWean/RjLdwkIRg32h/ry4RDgWEdOOqi+q/Sv07W0Ss1NUtVDOT33viPrCQ
         5yS+IQ0LwpnzS89MNcES5inftnbS2X3XCv6JJndKIhlbhLl/9n0bvVMReIyygEfiRFrg
         eQMg==
X-Forwarded-Encrypted: i=1; AKwUvBxBXqPBZJEAB3GunXSyDV4VQW9PsH/cZ7iA0YEVXQLndvRomJb9xWGm3qzePQ/2bhSqAGnOuxc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKF8DPMLNgCNOAiq93h6U9Lvx+TM3WLXEb1jj2PYWbaG8JhXB2I
	IanUcsR34JOQh+wcYPEWKDk3Eg3XKAa3D9XVVwNb4nJkdl7QFxbTtWF5CYOOTzQpboM=
X-Gm-Gg: AYBFou2smiQnyIjF8Zgd4yJZZ5r5YtYT2yeWOkvPEJTGMbATrKLpBiyltYT6gAVN+Sq
	IaOP/xyVarWpO1CzOQbU4NL64u9sHUKE1vt6YsbGk0hlDsNhVTIpr6KYN/9dfIyXBJo/Xxyx9Oa
	NUbOauhgtRuofOU7YdCNp5OmwAKNDPoySHk0rCjoaroTtioLqZCKGl6Ji0tEKgHcmofP7V1Cemc
	B83weh1C6VTAAhia4UOoOszVQdvvqzIWwVA5MQrTwQrWEPyMM6CpCbUeIhdKQcmax4DkjarhZLz
	XJnCBBDBDKPY+O1Aji6CMrN8FoOhWJTNn2i2WGjU5T805g3h/U/49X9Dap4pxz2/ZH+in1TD3VF
	6WDaUOhm29CygxRROfNB2CnGaz3moOofBuuLdCAvI7R2Xrkavk20WBMrmGHZgWXblq/t4NpoxMl
	xmT8aG0ShULyMPSbBiZS+y+ICFGRLfa4+eCN+/CSB5icxdXXApQxdZ80Ee81hC2zRRGo/49W/1
X-Received: by 2002:a17:907:c24:b0:c20:1bc5:7002 with SMTP id a640c23a62f3a-c2ac22daf39mr1111903266b.3.1790610859621;
        Mon, 28 Sep 2026 08:54:19 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae76a68aasm480717366b.35.2026.09.28.08.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:54:19 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>,  "Daniel Zahka"
 <daniel.zahka@gmail.com>,  <netdev@vger.kernel.org>,  "Kuniyuki Iwashima"
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
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
In-Reply-To: <DLOOI89GKM5B.W4XPBNJUXRV1@gmail.com> (Alexei Starovoitov's
	message of "Fri, 25 Sep 2026 20:27:31 +0000")
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
	<20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>
	<DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com>
	<DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com>
	<20260925121849.2ac5150b@kernel.org>
	<DLONQQN0RB03.1NVWVFHGRRWV4@gmail.com>
	<20260925132004.171b751e@kernel.org>
	<DLOOI89GKM5B.W4XPBNJUXRV1@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 28 Sep 2026 17:52:03 +0200
Message-ID: <87jyo5bcgs.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 25, 2026 at 08:27 PM GMT, Alexei Starovoitov wrote:
> On Fri Sep 25, 2026 at 8:20 PM UTC, Jakub Kicinski wrote:
>> On Fri, 25 Sep 2026 19:51:37 +0000 Alexei Starovoitov wrote:
>>> On Fri, Sep 25, 2026 at 12:18 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>> > Instead of improving the existing infra we're adding more BPF-specific
>>> > glue and another bit to the skb. Matter of perspective I suppose :/  
>>> 
>>> skb_ext version needs a bit too. SKB_EXT_BPF is the 8th id, so it takes
>>> the last bit of u8 active_extensions.
>>> skbuff_ext_cache object is sized for all ids, so it also grows by
>>> BPF_SKB_EXT_SIZE for xfrm, mptcp, psp whether bpf is used or not.
>>> 
>>> As I said earlier skb_ext is fine from bpf pov. If it can be made as
>>> cheap as bit + tracepoint I don't mind it at all.
>>> Which part of skb_ext would you improve?
>>
>> Mostly allocation speed. Either a small per-CPU cache like we have
>> for skbs or let the scalar matadata fields live inside the skb.
>
> makes sense to me. Speeding up generic infra is always a good thing.
>
>> That said, the selective tracing approach is also tempting.
>> It'd be great if we could have that for sockets.
>> Could we possibly think of a way to build that into tracepoints
>> instead of having the open coded
>>
>> obj_maybe_trace_bla()
>> {
>> 	if (obj->trace)
>> 		trace_bla();
>> }
>>
>> Having both:
>>
>> 	skb_maybe_trace_free(skb, SKB_CONSUMED);
>> 	skb_release_data(skb, SKB_CONSUMED);
>
> with a 3rd enum argument for different use cases?
> As a way to generalize different bits / different users?
>
> Also makes sense.

The benchmarks from Friday were wrong. I got bit by KVM halt polling,
which was randomly inflating the runtime cost by preventing batching.

The correct results - as in reproducible and with lower variance - are
the other way around - BPF skb ext is cheaper CPU-wise than gated skb
tracepoints. Please see:

https://patch.msgid.link/20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com

Despite that, I agree that the tracepoint approach is tempting from the
UX PoV.

While an skb extension seems like a natural continuation of the XDP/TC
metadata pattern, I think that model is not a great fit for skbs
traveling through the network stack.

For XDP hook, there will be usually a single owning process of the
attached program, I think. While TC, cgroup, tracepoints can have
independent program owners, each wanting to associate their own piece of
metadata with the skb.


I can iterate on on cosmetic aspects so that we don't have blocks like:

        if (reason == SKB_CONSUMED)
                trace_consume_skb(...)
        else
                trace_kfree_skb(..., reason, ...)
        skb_maybe_trace_free(..., reason, ...)

... in a couple places where they appear in v1.

Thanks for feedback.
