Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524416;
	b=T/Q2G7kgqYY+izoGIJOzRFI6QyNqC9Za9fSJWk2+xi6xajM44GCbIMjNjA0HnnC3QJGl
	 1HcfNCr1ndeGBhU0yH6YHvsy5WES7wlQTS1FWX8DSnUkgS9cEp5+0dH2/bsuc3oPLpuin
	 VR5Z9r5NNR5KSaPWtUJPEl2jfhkqiThj8mh68jqyuJ3TWAmM5uH2/C15/I3SnZfaBAOgk
	 yhXWGJ/yOR/akyxk+6fCemgfWa24LhvNE/mCbxSDnhCrVhHvn1e0qraSnVvTg57gEwK4F
	 FMKAmQnveKwPfOLtKQtfWBH+6+6DcuPxCZsumd0kHmwBZ4miS9FpniEvPDDwVLO5suA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=EBkgmCwzSSGPUQEDHuaBTutli2Jfo6B14aVph4B8jx0=;
	b=oOVxBP5tOVm4R5D4w82c2BXVj1brnHicPR8vbJqxt/cYJqzUWPh538WYMyZZpP73gFj0
	 x/R97OlaXJ8Kp1JK79BAS65+OlsI1mubMKxiTu6dG6W7PiTA9r/tLDP5Nzb6szqcQe4Hs
	 IYARQy3++8QKr7pkLQWYuUW+n3FLa8qZjiJHAGU833ym97v9i8zLe/Ue5iiWtYnEsCu5k
	 Ztv7yb4hp3eaxMPeHR+EGA9HFK+RE0TYX5pr1tuzPoytoHIf/duYiWTqhacc2DYNehLRL
	 d/M3LQWhT60c/VOstVxjJLEwDHH69KgURw+qgDYPlb0GNZZ4dOB84PhA0tqhi4yKPnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UEmdS/dd";
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC1606A880
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26BC1606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UEmdS/dd
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-36f758312e0so123943eec.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794524415; x=1795129215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EBkgmCwzSSGPUQEDHuaBTutli2Jfo6B14aVph4B8jx0=;
        b=UEmdS/ddxgea87Jmi4D6KGO0cwNBW0iN6pjH4MYdOo/9psUz72Te3wCs/WBVGWCYin
         oLAdMFp7CIubzlvzOBmyRG/Lj4TRocdsaMYZRyRloCp5icyGrXTBcF0NN3YDIdpbziPD
         9dCoQysz795JPTNbOOEjaH/EeLGkosuG4aQkxwOskX09xUil/r1gN92uAD9OMsSjKiDB
         F0lH6/nzBn/sVPwCLsDSnGNtu6ltHUoqDrztZuFogvL6rw+gfNvucXjpxiD1Anf0Up7c
         0j1KXXL6s2KWDR5t1ZzoobkG3mM+v03VwLyiHohMh0pxNELAMXLgF+TZ4oIQZUO8hFiw
         1I8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794524415; x=1795129215;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EBkgmCwzSSGPUQEDHuaBTutli2Jfo6B14aVph4B8jx0=;
        b=fPGqnPgTpDNhTOXD2zLYi3uHPiBpbJsl8R2gVKKjCtpP/GP9W7N0z7MzaSqrjiJAbV
         6etgZCPNHxG5DiHA7Im7uVYZIrXeY9Bziq0o4eZJu5GYOBZOr4QJHpZTt1r3alRFMvuQ
         puLop8JLg4iCRxqNaXAXGanBL7jwoTrL3kbfE5Xj5dRi65NlB3O/P081hz51iSS9X8b9
         rjku5mcjaqZXwfI2MF3/7OHA9ubfJzqH3UD31m85Mqtdp64/fl4kD2g/PyFGf/kboJoJ
         eIBZX6pjulgrJP3/RFFwNzbXU30tvR+NGH/l7xZvKRsVAQHd+ZniJyJZ3NqXEBk5F1IS
         NYZA==
X-Gm-Message-State: APuU4Z/ZcVymAn2W0QC4iFJzxEINBG6+evf1djdFAQbjUHTttx3Sx6YV
	Q/Yk0ptfBZ/9DjDxYqFPq+/McNFtX4mgxZEJFcCrBH8n06zOlH4yBtuL
X-Gm-Gg: AYBFou1QzUQMurkaeTlARijCfT2vUOWnFm1Fhvt1nNYNl2CUEqn4QvUsF54fJEnvG7n
	Gv7MQ0gsEWO/vO4jInf2U9vGF9Kjr+k5F2HFpobWfbQW762vE1njN/ICwJqI37JmCN1UxfU0MUj
	i8bPy81c7e8PQDyFAUPo3pxUgwCHDadzr4mzJ2Q2SgImlqlNPE8nrzLDWiMkS+OgFdZKRLmdyNm
	E7JNHUh6DniOugXOjiG41QyjFWzJOidvYMiikDmfKGSkjR6mJh1KJeTVwIzuad9kZ1A5RvDM4ha
	LUkAAV15EpZmve/GejLBiV5gVRBEJ58SClLgYzxgnK4p95Q9aoU3SDLeLvI5BLGTAawYte2uB7P
	jiDLcnoQPM8waqchGRdiqUJdtBlz5kSj+dv1w7Uixw6AIqljHXSDtgtVrVMAwICQV7oZcKq4JGL
	gEsx//vJl5dWc0KWrfgwbuZdZ6qlI6FNwUch1XnOZEM6JnzO2cdNW9fuOQ0ph3qpKVnZZuMytbK
	bgJuoJnUoEJ1Gy9ObPU6D62l4NBfbam6wSfVGrwOyQrGVOqjVrjPI1XdYd1DL/XSLrr7p1k+27Y
	vGwgURoa08aJZy0hVwO7Kn8=
X-Received: by 2002:a05:701b:454f:10b0:1b2:4998:a0df with SMTP id a92af1059eb24-1b5030db655mr763014c88.35.1794524414765;
        Thu, 12 Nov 2026 15:00:14 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:60::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm2014845c88.14.2026.11.12.15.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 15:00:13 -0800 (PST)
Date: Thu, 12 Nov 2026 15:00:09 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	andrew+netdev@lunn.ch, edumazet@kernel.org, horms@kernel.org, shuah@kernel.org, 
	almasrymina@google.com, sdf@fomichev.me, leitao@debian.org, dtatulea@nvidia.com, 
	asml.silence@gmail.com, bobbyeshleman@meta.com, daniel@iogearbox.net, 
	razor@blackwall.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/5] net: devmem: size TX net_iovs from the
 dmabuf layout
Message-ID: <avZC2hp_0ODMQ4SG@devvm16445.scu0.facebook.com>
References: <20261111224740.2744522-1-sdf@fomichev.me>
 <1b764043-2efd-4e65-adb9-a47c0136446b@redhat.com>
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
In-Reply-To: <1b764043-2efd-4e65-adb9-a47c0136446b@redhat.com>

On 11/12, Paolo Abeni wrote:
> Hi,
> 
> A few (late) questions/comments to check I'm not missing relevant
> points,
> 
> On 11/11/26 23:47, Stanislav Fomichev wrote:
> > TX bindings use PAGE_SIZE net_iovs, so a frag covers at most a page.
> > A 64KB skb needs 16 frags, and MAX_SKB_FRAGS caps devmem skbs at about
> > 68KB, which makes BIG TCP ineffective for devmem TX.
> 
> ... with default .config. You could set MAX_SKB_FRAGS to 45 and reach
> ~180K...
> > This series picks the TX net_iov size from the dmabuf sg table instead:
> > the largest power of 2, up to 2MB, which aligns every DMA segment. With
> > a 2MB hugepage-backed udmabuf a BIG TCP skb takes a few frags. There's
> > no UAPI change since TX addresses are dmabuf offsets.
> 
> ... still this option should be more effective because the limit would be
> higher and the skb would use less cachelines for the shared_info,
> 
> I'm wondering if making a comparison vs MAX_SKB_FRAGS==45 would be
> complex and if you could do that, too.

Originally I did not want to include bigtcp to keep it apples to apples:
same tso size, just 16 frags in skb vs 1 (in ideal case).

I just tried running mlx5 with 45 frags configured and it fails to start with
the following error:
mlx5e_attach_netdev() warns "MLX5E: Max SQ WQEBBs firmware capability: 16, needed 23" and returns -EIO.

(fwiw quick review with llm claims that mlx5 only supports up to 20 skb frags)

What I also tried just now is `gso_max_size 524280` (on top of this series)
and it ups single flow throughput from 200Gbps to 240Gbps (presumably
by making the receiver go faster with 512K TSOs vs 64K TSOs) and halves
the sender softirq..

I hope this gives you more data, not sure running with 20 frags is worth
it (vs 16)? LMK if you disagree or want me to run something else.

> > This doesn't make skbs larger. TCP still sizes them with size_goal.
> > Only the frags get larger, and a single frag can now cover the whole
> > skb.
> > 
> > An skb stays under 64KB unless BIG TCP is enabled. With BIG TCP,
> > MSG_ZEROCOPY from huge pages can already create frags of 64KB or
> > more. So drivers already have to handle them:
> > - mlx5 has a 31-bit length per data segment
> > - gve splits frags into 16KB descriptors
> > - fbnic doesn't enable BIG TCP
> > - bnxt has a 16-bit BD length. It is broken for such page frags today
> >    and will be fixed separately.
> > 
> > Tested on two mlx5 400Gb/s hosts with kperf (udmabuf, 32KB RX
> > net_iovs, 2MB hugepage-backed TX buffer), series backported to a 7.1
> > kernel on the sender only. 1 flow, MTU 4200, receiver tcp_rmem capped
> > at 16MB so it doesn't drop, median of 5 x 60s runs:
> > 
> >                                before    after
> >    frags per skb (sender)       16-17      1-2
> >    throughput (Gb/s)            208.6    211.2
> >    sender sendmsg CPU (sys)     40.8%    19.5%   (-52%)
> > 
> > The receiver's CPU is the bottleneck, so the gain is CPU, not
> > throughput. More of the transmit runs from the ACK path, so the
> > sender's softirq grows (52% -> 59%), but sys + sirq still drops by 16%.
> 
> is the receiver using GRO H/W offload/big TCP? Which are the gro_max_size/
> gso_max_size limits? In the `after` scenario, is the 2nd frag used for the
> headers?

hw gro, no big tcp (default tso of 64k). The headers are still in the
linear part and most of the time we get 1 frag.

I'm assuming 2 frags are happening sometimes because of tcp sending
something over that 2MB boundary. So that one single range has to be expressed
by to frags.
