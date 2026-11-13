Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530523;
	b=tzbStxH2GVQP67r8wBaAVnUJcvd/VGzpKwPOD2dAi20ul17oYIh6hPcDp1dT/mc1d3GP
	 Fkk/3QqSMyEr4D+vUyyntri/xW3jnz4/N0/ovv2CQJWmMRfZY+lLSz12RO8TX9PUtaREt
	 ry/kWHADkafsOLr2OCjOPPhlc1Ou2oR8vVQEFRMT/ae8tVVgtRT3Gqey9+WNqdTuVdzvy
	 8yDXcejEdCYWpcQCcOZWDTbqz55jhITK2SxeqHzMKUKMKURSrqiiRVndueyahCmo+08/H
	 kf+tGmvEayj1eLF//o0g6wDjQZ0U+5sPhYz7Yh+ZwYt5rwClzFEhbvsgnqLwjaoWnKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=rN0Ie5yME6hsx7pm+x3UNEKpXeb1k8nlYJCB408a9fM=;
	b=zk1QqVJNypDCZRzyHk+RKYR9kWU2Uw696CffEKkilvXfn+iTnMdnft+kLfXp96cdlwAh
	 7fD0zuDht4NkvdENtusEoAZHuG0opmZ9t6fYgPJvfmT8uQtA2U39wu5Lui4Sn0oFeiguv
	 2GUj3yC1x+vmVLKfN2+G9NdFrT/NTkP4puIQJvgj/yeYKQu78ODq3oQa+l7lPiUFwdKru
	 B4zd+vs69O1ytOSmvtqxXVUFxzLQcgq2bhgR+Rllzoie1So18b3ZWRP/9RXs46klkR//a
	 r86JahhV2hFwSW+gOHH3RH17EsErsqbqNstaPQI5o71f1I8/q1bocDKKShMABNAApxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wS4wsUX6;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1A1606A32A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F1A1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wS4wsUX6
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-36f758312e0so137186eec.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794530522; x=1795135322; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rN0Ie5yME6hsx7pm+x3UNEKpXeb1k8nlYJCB408a9fM=;
        b=wS4wsUX6ixKaKqiYjQsFCJYaIJKn2BaV3f3zkmlFUG5frnXleY4I+yDFt5BO59cWXS
         E5JETtLS9PRnKnT4J1LIE09WxVAAseI/wWSe9ZZeOV6x8kziPaEXsCY6VA4BF3ndFAYK
         RWSIBklti8rhZx7Uw73mxUbumVjoZyDIRHpcBnNQhm2oyRlOtVBUnzHH7YKMa/VKxtK6
         XRHkKorE0Qv/+WieykgVMwoTnmMHuUtoJt685pJPRiQLmu8VwLBvHw1reor7fxpobajo
         9lGqkOBDxWRjtpOvgGDO8xvWJO5ml5wtEjHhs/tWxIBi40DGSxddqrSQp+uaaq/lq/0t
         sryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794530522; x=1795135322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rN0Ie5yME6hsx7pm+x3UNEKpXeb1k8nlYJCB408a9fM=;
        b=TsOOfQSxrb8BJqTnX0EDrXFeQSSV03Wjs0sDL9nw4mp6MYKuuIMfq8QQ20/8MtyU+q
         3B0Ug5N6uaZ5wLaKLRh2SFh0sAfxgaynSV5YUvOoRimLyE2voZ8iMtoWEwy6E9vBU3T3
         HYx7q/AKH2ZLwHj0wZ6ricUyqNMblVQ0NSPzZ82maWkgrgCGK2xCdUIeVHYRyKWEAKa4
         LE6zB6w4jGJy+ifpMuAEI3BMyGiSsBTA1Z7o8Mkkf0D1XwwbJLkmhqE9cHnQnfEwZGRA
         qhOvcqhuDd4LCLxagDjxGz040qj4XjyaNyuQfsVbliXV2M8T6/bilZNWxPqD/03juRrH
         G9Uw==
X-Forwarded-Encrypted: i=1; AL+hErGDN6FK2kUFvs2B/E79DzmEN12KgK7ZxNKvolmIFmBZwiFx8CJI0M3ULMv/ZPopzDW9RKCX8nY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Gq1TM9zWWaLGh9a1cunjvez+DYGSHn/FgcdQmqqjclOXZfjHG
	PgT6XfxFoxxJZELbeHSG2sQBUP9n5pcix9RyX2yocXjX7KffBDhlBA0XRWpj1BLJPsk=
X-Gm-Gg: AYBFou00YeR251NkKXmZYals6/W0TBN/vRwgXI7P4KX2pyrQ7QFDkCwEi2CyAifY0II
	RnjV2AQ7k0jBRYH08Mgspf9O6LXqEtYw3chBvOzvWDOj4HOaCs1A+GXMKEh7HKWB7Cv+z0/CIbG
	j3PurWHXQG0h6p1HUfw1s0MxC7d09WbCWFbo7flpyZkn0+v/d380PU7HWEDe6dHnw/3gdRd0kpZ
	cmfWrM20Xb5RqSrCUYMG7gY/PWNB4hqdYZ6QGmVSQzphL6P7HdNlX2GvS+d6hDGpmpEcvTmGmq1
	GFEei7Yhm+7SYEuenpI74aoTBV52wUCIk2BDyi5fexn3YjO/xjPC4lwDjYuB4544bTRH4dbXLPv
	h48pvEkmHM3hfJqU53QtpE91S8NIK0lyLw/gTqHcOVA42k29dZXMBjIENWtCSNOD/9cnkQbJeNs
	v02woAmPtPLyKrDWKshgTg1wZxtHdF7r3J1yGhNPU+xqvM/H/uyWLT9weXtwcW1m5juhfR4S3lt
	7IZBuupICWK32FZk0rbxcG8oOlV8xQBKp1By3ZUalxZlLp0xtPIY2wIlSk5b5wDgD2BrZDIuGal
	NRyyt/G9V0mi1xgCeoYbfkG5
X-Received: by 2002:a05:693c:8852:b0:36a:1452:8dad with SMTP id 5a478bee46e88-37966f32039mr734196eec.20.1794530522135;
        Thu, 12 Nov 2026 16:42:02 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:71::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316f2sm1934134eec.9.2026.11.12.16.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:42:01 -0800 (PST)
Date: Thu, 12 Nov 2026 16:21:27 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	io-uring@vger.kernel.org, Mina Almasry <almasrymina@google.com>, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 02/11] net: Add memory provider capabilities
Message-ID: <avZXuHWBUTJvJnEu@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-3-bjorn@kernel.org>
 <avOYe27x-AlxmyK9@devvm16445.scu0.facebook.com>
 <87mrrfa6c4.fsf@all.your.base.are.belong.to.us>
 <avTy21_cSnyMdbb5@devvm16445.scu0.facebook.com>
 <87cxsarvwd.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cxsarvwd.fsf@all.your.base.are.belong.to.us>

On 11/12, Björn Töpel wrote:
> Stanislav Fomichev <sdf.kernel@gmail.com> writes:
> 
> > On 11/11, Björn Töpel wrote:
> >> Stanislav Fomichev <sdf.kernel@gmail.com> writes:
> >> > On 11/10, Björn Töpel wrote:
> 
> >> >> +	if (static_branch_unlikely(&page_pool_mem_providers) &&
> >> >> +	    WARN_ON_ONCE(!page_pool_supports_frag(pool)))
> >> >> +		return 0;
> >> >>  	if (WARN_ON(size > max_size))
> >> >>  		return 0;
> >> >>  
> >> >
> >> > What's the deal with that? How do we get here?
> >> 
> >> Hey! Thanks for taking a look at the series!
> >> 
> >> An explicit frag call on a whole-buffer provider is a driver bug: UMEM
> >> chunks can be smaller than a page, and RX gives the whole chunk to
> >> userspace.
> >> 
> >> But page_pool_alloc_netmem() also picks frags for small requests, so a
> >> valid call can warn.
> >> 
> >> I think it would be better to make it return a whole buffer and its
> >> actual size. The WARN stays in the frag API, before taking a new buffer?
> >> Wdyt?
> >
> > I see.. Idk, I'd still return 0 here, but without a warn. Not sure
> > we want a warn for any api misuse? Returning no netmem is gonna be enough
> > to debug things? As for the calls from page_pool_alloc_netmem, I'd also
> > handle it explicitly? if (size > max_size || !page_pool_supports_frag) ?
> > But no strong preference, up to you, was mostly trying to understand
> > what we are warning against here :-)
> 
> Yes, page_pool_alloc_netmem() gets the explicit check. Thanks!
> 
> For the frag API I'd keep a WARN_ON_ONCE, like the size check right
> below it. A silent 0 looks like an empty provider: the queue just
> stalls, and nothing points at the driver. With the helper fixed, only an
> explicit frag call on such a pool gets there... Wdyt? I'll probably take
> that route for v2.

I guess, yeah, makes sense, let's return full size and warn. Maybe also
a short comment will help to explain why?
