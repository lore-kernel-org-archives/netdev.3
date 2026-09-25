Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5CB3B47D2
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368054; cv=none; b=LPfh8BMWQG9OAzYSx4fGwa+0A7uIesBf3ZMqbW4yiaXc7XqfeNeZcT84A8uAEG6mJea98USlbRp3jsYAdpqHV0LU5ft6baX+XzwJEoB7GFSRwcVhITzKEZ8eBq+am04L48ytszymGnSJmpl48Yn7N6a9DqBQitF8R3jS4Ht3GxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368054; c=relaxed/simple;
	bh=4+qo5Knm2rVMf0fpjw0aemqkmtfHmnDAmknaI7U0X3g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=L0s9ExURvsR3gVHW4aVifJa8uLQ5TBS+phr5G3iff+WGrVqFVZpKUlGcgJLpeB5+GBJKOhKWpyvho33hopuarNC3QUeRb9j5e2oYhCKmJok6XVq89S/lukvtYzDtVM/RQRlU/BfBAmbYwBHgr7aAAMRUqb/zmuCKy2wjVP/pOUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fD0Y8VKd; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD0Y8VKd"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bcdf41a3so569253a91.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790368053; x=1790972853; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c+klwDm6bym5EZ1ey5reNAgDmCkyKu9xoOUaR/FGAl4=;
        b=fD0Y8VKdg7z+4rrghDcyEhiAwtz9DlwmKuZL20Cb71/4xR6Ywn3g6X3uA4YLboDkAn
         pBkHBi2tAnPyehgWAc+6FrdfDkvB3sTd6csQjTsRFah4PUOp7BJRFE6PHOTzJn0rhfzq
         s9b7Paq1otOFXfTsP4CToSIVwNP9MqfEpdkKmCw0XEdhOUqSm7qTFF3y5Uiu+uaNP7Bo
         6Ge9HLlEx3rnix91WmjJE/GtbK134fbcorgo/3mxwwgWnklQNg1/n8ixPn7G2jO0U6+0
         NI3XlY91S6f5kCpnQ9Bg/CAwe0Ii9kOOTEiUpqkYZyDyS3rxNoW3xcPSPQ/cin2Le0nX
         bKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790368053; x=1790972853;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+klwDm6bym5EZ1ey5reNAgDmCkyKu9xoOUaR/FGAl4=;
        b=bGDc91dd+O0h/esAuwxl8VCNeAKi9fcvvudRYj0+X+vKYTBTb5Pd+Y8WoAhs/YnZXi
         2zi2Dt/+0IP9C6sh30+ds9ob7jqucNEVXS6zVUcCptUNNmk8Q/GiLHEHCougJuv66OJ0
         xzRrGG6+81wF7G78YqnZd5ed3IkiXdGOpjgxoBuouzNLJ6b2MRo5rJflfa57flJP8UaW
         g9KYrAplbBVBeRTZ13x/A5yg0ZDw9Fb3alRrqiBj9EYjzKm0300ip2+XJn3NcIwwd3Zs
         LXd27qGkU7Z/yJtUTugU2YJeUv9LIv03NWKmmbddfBn1b0WWjuCPkiPxN2VBr5/ERS6+
         CCLw==
X-Forwarded-Encrypted: i=1; AKwUvByJZJeyRbYn9vQA1CcmYXf2vb3XQjN1AZueWUaUqMS7tZyZdYBmIZ7M4TNUiComhC7mcaAFvgA=@vger.kernel.org
X-Gm-Message-State: AFuF++mnCzzcTuYHO0W7XNuwJveJbkPPFgLvWku2vtgT1rvqXzNi+nsc
	HE8nLxWk/C15tZ9pTR7C/qm6W3EbyUaNZ/o/tsR08ChjrDalL9aOCuec
X-Gm-Gg: AYBFou0+Et5kcYRgWeo2+Pix71T0nTRuA7/5UgiZweIsEZQyA71TcUHRixHn1GkmN8Z
	zDib6th89BzazdxP695hcRiKuulKmfy1F7dkaLskKVh7/d1TxE1AMbiiFgWVX/z2q3zSZzdczgq
	maaBiHCL2DROGT37sdWMuAzR42UVg9KmlfliGIdl0QrQHMGvTs+lCgA8pu8+HH+Gx2kwi1poREx
	gR8+8nAP22ZzpHGK94O21ZO2IYYw/ecpKfza5pKHxOxq5REpFjpOtyoWnG+PQ+O7e5bHo13X1QG
	MvB4rxUIKAG69TLPSYdTdHoBoj4mujLhjFyC+reDIeve5VA0XR7Taw7drd3sLEJPU+TUo5hjvNM
	fnLQoI+7/iA0dtGmajuVBocIVb+g+jUgXx23KAlhgh749B0MbCbEeYdjeaAjms3OFo390GZ/4o3
	O04BWpUs3Yb+94lBWxkSbHuYG1N909sONhJ5pTjq5s4QESk6pd0bG2ILxfdgjKgQI6C4lLXBXYu
	EvpR8vlhcE8CP0eIG6PcrdBagV7gSjWNP5UXU5BkvoZOLetdDaVWyrTuE4xBfhXsPg901T/UmuK
	pCZH
X-Received: by 2002:a17:90b:2649:b0:3a0:b223:683e with SMTP id 98e67ed59e1d1-3a0b2236bfbmr3345723a91.48.1790368052779;
        Fri, 25 Sep 2026 13:27:32 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0bda430b3sm5363181a91.0.2026.09.25.13.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 13:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 20:27:31 +0000
Message-Id: <DLOOI89GKM5B.W4XPBNJUXRV1@gmail.com>
Cc: "Jakub Sitnicki" <jakub@cloudflare.com>, "Daniel Zahka"
 <daniel.zahka@gmail.com>, <netdev@vger.kernel.org>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, <bpf@vger.kernel.org>,
 <kernel-team@cloudflare.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Simon Horman"
 <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "Florian Westphal"
 <fw@strlen.de>, "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com> <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com> <DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com> <DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com> <20260925121849.2ac5150b@kernel.org> <DLONQQN0RB03.1NVWVFHGRRWV4@gmail.com> <20260925132004.171b751e@kernel.org>
In-Reply-To: <20260925132004.171b751e@kernel.org>

On Fri Sep 25, 2026 at 8:20 PM UTC, Jakub Kicinski wrote:
> On Fri, 25 Sep 2026 19:51:37 +0000 Alexei Starovoitov wrote:
>> On Fri, Sep 25, 2026 at 12:18 PM Jakub Kicinski <kuba@kernel.org> wrote:
>> > Instead of improving the existing infra we're adding more BPF-specific
>> > glue and another bit to the skb. Matter of perspective I suppose :/ =
=20
>>=20
>> skb_ext version needs a bit too. SKB_EXT_BPF is the 8th id, so it takes
>> the last bit of u8 active_extensions.
>> skbuff_ext_cache object is sized for all ids, so it also grows by
>> BPF_SKB_EXT_SIZE for xfrm, mptcp, psp whether bpf is used or not.
>>=20
>> As I said earlier skb_ext is fine from bpf pov. If it can be made as
>> cheap as bit + tracepoint I don't mind it at all.
>> Which part of skb_ext would you improve?
>
> Mostly allocation speed. Either a small per-CPU cache like we have
> for skbs or let the scalar matadata fields live inside the skb.

makes sense to me. Speeding up generic infra is always a good thing.

> That said, the selective tracing approach is also tempting.
> It'd be great if we could have that for sockets.
> Could we possibly think of a way to build that into tracepoints
> instead of having the open coded
>
> obj_maybe_trace_bla()
> {
> 	if (obj->trace)
> 		trace_bla();
> }
>
> Having both:
>
> 	skb_maybe_trace_free(skb, SKB_CONSUMED);
> 	skb_release_data(skb, SKB_CONSUMED);

with a 3rd enum argument for different use cases?
As a way to generalize different bits / different users?

Also makes sense.
