Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794596072;
	b=BeWMz2x9AfQBF23qhaaSzrWCKqSWa8AWYiTSvx4/NFbB1eq+b73FjPdjErejAgEjD1e/
	 RkDBfnOYHTQGUYYdgg4fiFqlh6NnYrV3bshQCGKTEms9WJofvn5AA5FU+T4K6341gEkaq
	 tDpvOKrw26BjtuVjjw2Hvy2QXUoPQoWDM6TouGQxFSBJFOvw2HKscV4TbYhBHg3OExi32
	 agOYQyALK+qqFId1T8F9EZ1jYbBcxvgvES8pPI1WzDcmGQ1AmB1yMsbtzHLuKPTF8nwrS
	 TEee6UsX0jAfUW6JrkUnUjdFw2jpn1fpmQnZg2NazwN3XRRmRHuyB/WOz6bY01iBtfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7R1hXZXnbTwKM70quTRieOgRc26BuTodcH8VZYBkreU=;
	b=ypIjnpH0rT1t7zOkYhKApeGpunltvmaMLdOUxlOH8nIcigWMhlDGZggj57cyWzsgaZCB
	 RLFQVBRb+N6eeuWSQq/DmsB2UaVDcDmEBYGy8/65/Tg+AmsHdJa9eblcI3GjIAVj1/tUF
	 m1W2zRGDGidMXkrx9nV7PwiVAcTitgrrZMWy3VDe2Txk/3pia43tUzhkjr1H++NiDeniL
	 QTj5dIyuXhysioSMZ2GD7tcW6ebXrPJMI6fj+M/gFv5IUUjtqyGSc79XgoaHyLjDijS4r
	 Y3YhJEWcENsPcJ/I3x3GG+e6SRGhZrV3gaKvgZEjrqBxXGnircpAc4NK/IGk4nj5B0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eisEEVVM;
	arc=fail smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55B606A881
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C55B606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eisEEVVM
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b791a4b732so643a12.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:54:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794596070; cv=none;
        d=google.com; s=arc-20260327;
        b=MikqRGoN4X67L9CSz09steaHYfTYOZT/RRUvA7cgaW2IVq9bql9XHQzVezAc6KB6ib
         mRsSLjPgCxJigQnAxtFGVCSvjjr2FECYt5BkWPs/0sffDcEEUYjGC+xdWxVzB2riFi7E
         bcq9ENdqlHbk6ppMoMn21sPSrVbCJ5shT6dzlUGck5C/36DHQvrMhcYgfN30uWvicD+s
         OrAU2kpH3Pnhkg6Q1ayJL4wiCoQPuHFz/qKIupy2muwvsk7x+SyaOdaM9PXWbczk6/AZ
         2MiMEFPsw8XrllQZeAZW7GRJPwylNNbXnqvfeJKu1yGrVqL1gOI76uP4A9sTLv5k9kay
         RTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7R1hXZXnbTwKM70quTRieOgRc26BuTodcH8VZYBkreU=;
        fh=EPc7AMc13GhD09rfxPBgeUsXDPl0QnTCW+j65aYONUo=;
        b=aSNsvr/gJs8Nyz3Rfwx/2hxOEvHQx1AfAqeYDbpG0b6Ej9T7OqMqHNuGRVleNqLNmJ
         QPs07CfzZBUJg+H/CNrLRu41lX3Mm1nWbtuRPksxcTcpjIJJZaCfE+bJihgl5zBnwDHI
         OqlVhXHA9ho72qY+TExeUnZpraDtBk46c0AkpT/iEbIC3ft4CTGsitIQMS2LNQWYXLcq
         r6QPV+1Tt74vYQvjU1LGS/evg4KgEB95jq0VijxCKXbqgsdVZuEk5m+DVvhodByP8lVz
         WmiZ6usF46Cd970Zpn3FVRd2Xu5RoaZ8Gsj4MwS4XxhwZkzeaAymhWg5+06wnEVSkk0e
         PA2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794596070; x=1795200870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7R1hXZXnbTwKM70quTRieOgRc26BuTodcH8VZYBkreU=;
        b=eisEEVVM8PCaj/Wxux+iAJmBT1k8bHNU35jNjvPdKn5A1HLZOH5LQ1EY3BcJG6WJSd
         zQJHCca5ZSW272RR8ZqEnxlJfsFyhdrMZusl8QaA4c9HP+xH6avVjT/oc3dDYcv5aBdd
         PX2GBBsx7FbYnffDffV/A8+nFo7zh1u9hueKZ40B79RrQ6sNRvq4xDRAPGyAjZ7E+JEP
         dHQD/L3wxxC2OFdsSm7Io+s1kd8AHRbV0NiLsOq1oDTCRUWH6uhuvzES4DspcfRe/mVS
         XpFUSQpVCuB+A/wp38W4sFKkIzI7LAQear5+guYAQ2EbAMwuzP8+PeaJ1TbqOdpbCAyr
         OtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596070; x=1795200870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7R1hXZXnbTwKM70quTRieOgRc26BuTodcH8VZYBkreU=;
        b=S0NAh6ZZbGR9eDmUNLBWVuqmGuJQ4/z97iJ5mZ2wjF/GYV9zGep/pC/QBeEnB2jWwu
         ocVKVpZHsB7uzpoOizf0xqv7fPJx+roDXjPJ/myGHIuQvm+1ok2c6v02qrE+QtLE/udF
         Efod+gX4qYkeOpB5djSroSiums8OEoJFJBTzqjG0/+Jm1rE5z+uLLJm+YVx8kbhPz/wd
         2LAiJbt5v5kVcUrZ7xmYn9XUoXcoP8hOPuuhMWWX60v8AZsq3xoFvBEVwoaxir7bixBz
         r0bsbTWoMP5U9ERgREOCYbyYXn8Om8CT7rU7OSK7j0Ri6FjAC/KVYvyC2eHvZ6vU08hY
         VIVw==
X-Forwarded-Encrypted: i=1; AL+hErEGO4V4icGlD1Tggw+AHXahqppaBzAbL0uBsXZN5CHD4xt+BWZlLpI2X70+NmObxKLpu9JZe5g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9inBtRAujY1zd03mXZphcGa6DNFjAc/u+tKuUdaKj1YKqfYS8K
	XcpmYGvJUZFwsPyBecIFCNXtNGbVFDMcM5mdTmVgEg2reIekDLDghOiBklKuOSK3a9Zsd1nhkBr
	UBDPF+IPrMdPMNRo5a3F6oZP97BvidkDu4dMh2BEA
X-Gm-Gg: AYBFou2uzdWQnEwb9dzpUbIbXC13dNqlCNcHTcNLb12+WWxc27lEf03+d6uTRFCWewB
	6xwIukfxi6qY8wrnjXzAdN7wNiIuvOsOA1uzhZ8LnzQlJ4lL5BT59lnuIrJAQ4BNn5j5NJd5CIp
	YKVkSWoQrvQ3a0ucLUbTIVdBzUIf4n9eFhvaCkhMoWBNnug4K9D47pM/DuqSAURAX2bz7Qm9Pzj
	PjJzreH+ytYdtLTB0B2RNQDKhU0KLjHcmvzO2w5kKgE8m8/4gg94ym8vFAPsouO6lS6fmYYgnJx
	WKRurk06conAxF7ZWLZsOQ3XmIBqHXKaStdAFNuk8U45tjApDIxSrNBBA2K1UFB+geCehRbeIlP
	lbfIUXpRB1+fg8jWblbKvvVkhFY19RF1PUh2ACYegZfjqc9QWziQv/0brno3ewZD173g=
X-Received: by 2002:a05:6402:a512:20b0:6b5:76b2:5e18 with SMTP id
 4fb4d7f45d1cf-6b7e0367708mr7837a12.2.1794596070008; Fri, 13 Nov 2026 10:54:30
 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110102039.1002605-1-bjorn@kernel.org> <20261110102039.1002605-4-bjorn@kernel.org>
In-Reply-To: <20261110102039.1002605-4-bjorn@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Nov 2026 10:54:18 -0800
X-Gm-Features: AclHuK8hJZjvI7zpL7vkOt-X_2SsoIeZHCGx6Ao6kGKYFChdzs729uK5-y6t5Js
Message-ID: <CAHS8izMhFEMu+v4zAm6VqjU=Lz=vMn58Ft6HKya1L-uNY0hL-A@mail.gmail.com>
Subject: Re: [PATCH net-next v1 03/11] xdp: Copy buffers with restricted lifetime
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
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
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, io-uring@vger.kernel.org, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:21=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> UMEM stays mapped writable in userspace, and it has a fixed number of
> chunks. The stack must not keep its chunks in an skb or an xdp_frame.
> Mark the providers whose buffers the stack may keep with
> MP_CAP_RETAIN, and copy packets of the others on XDP_PASS, on
> conversion to a frame, and on redirects other than XSKMAP.
>

I'm not understanding why that needs special handling. Devmem stays
mapped and writeable and did not need MP_CAP_RETAIN. Also, today the
stack can keep any pp page in the socket's receive queue for arbitrary
time without _RETAIN. I'm espcially confused you're not adding _RETAIN
as a cap to existing providers, but their netmems can be retained.

> The head chunk is writable by userspace, so it cannot hold
> skb_shared_info, and virt_to_netmem() cannot find a net_iov head.
> Drivers pass kernel memory for both to xdp_init_buff_netmem().
>
> A static key keeps the check off while no such page pool exists. A
> frame copy is linear, so a multi-buffer packet of such a provider
> cannot go to a device or CPU map.
>

Did this actually improve perf? I recall that when I benchmarked the
performance improvement, it was questionable.

--=20
Thanks,
Mina
