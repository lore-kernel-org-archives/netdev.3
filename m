Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAAF3B71DA
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169345; cv=pass; b=ODJZTtEd0hnV1v5gIYvdyMjX7N0vEAjMM9NDRr/jiThiu7zqSnaSzPq8m3GA3IZveOwGU3kQx79Zph0TAUHmvM6D0NZDXBfYYO7MbJRY431g2vzHJ1ynN/zZh2/XrRARXrtPZmPF7xpCkbro1xC085bEpeOmjjZV7vK1qFjlsqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169345; c=relaxed/simple;
	bh=GsFumLSJL886GKpHbJf15kVOuP8UIgPLqNba42ST3sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/lPdjk8Lwc53HIbLJHkIQzLnZH0klGr1Azz3zrmAqEwLcHWHCQCcyh21HVBmHu8Y1YAkThdntWYJXXVCcNhJ4s7NaHB5Uqfd287OYt+YHxmJFYve3gDCLiJMPOixS7486N0kzMPMh0PX5TGd272vuA5JWmfA/jLPe5k+w7yvqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NK7BHhtg; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NK7BHhtg"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5218927884fso46097361cf.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 02:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788169343; cv=none;
        d=google.com; s=arc-20260327;
        b=hkOlTwJiPbjZrNih3EgM04S0xtcwgWLOxrUP0+x8lNiysF1GMNs5c5YqyaHKATKHAE
         Y0Ziia3atNyfi/RDlbUDZxBrvpejiZcbOnyX3GBdsMhtiM17LDRNpz4v/tdBgS6KnjFK
         hRWiOEptA+egpfGPlcHkUy3UWA0fJ/ZgQSCp7sxXeTP1CBYJxkKZ0lG8WbpZuZctH75S
         olf+nHAJzbXJUIDH5Yujx+CBR1+K6z6Og21Q9TjzZPabR6p3X8/9Zp3+uGMsiWs2Zu7a
         HdT6aE9yh8OnopY+6AGWdQ3KC2y7g2AeQUYk6REfHy+A0IXTmlJ5sxEdn8oiQ+A67tOM
         oCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aes8E7ycjw85I1hPRVRNDb1VK1GawwcAPWMBLAtTYaU=;
        fh=eJbv4K7jxy2NMRDOQWshlTYnJZ5UwW84lW3Dl453JnQ=;
        b=ZjkqChXsZqIzW964XgGqchp+3QrNSKHVNSmIpBZ0h0RvV/Ya2dMZPlml2T4bhfMyva
         nP6ECeE0qEjZflvR3xkN4LQd7DMYd7QSopZ9xeQfwpjTvKvgL22nzxLGMt7D4Y4VCLeW
         8cdpRrxIstbZ7n3c0JTz0rChl1dUzXcLs6dv/hMdB8gYL0/DqIy5Su9k2KhxfRdWjPeG
         uLmCEztK4IHzI/QlX5NbN/VEIU+PDLlWVGp7bFxKnhSRmjK613WvkHuJ4uFYv1IyQ9L/
         4Bkm/+hF4oJefzu35iGPAvfAl2wlgke951QGkUE1j6Kk53yjfy4gnC6mwPsBOkqtevJT
         kPKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788169343; x=1788774143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Aes8E7ycjw85I1hPRVRNDb1VK1GawwcAPWMBLAtTYaU=;
        b=NK7BHhtgC0UyHwgjXi/TCvsS5Dh5V6XgICDYxPaWILlJibgmqnHvMcxXzH56o0g76Y
         jH4JYxdYMQQSOxhJUkH4dOtsDYvi5aQ/quFmUxVFhEQWG/1c+HI6B+CMWK4AsAp8pOcE
         G4p06HRJWrbHX59oXkYqRzJao4hlUhfnTFBj3PM3+c7f8tSO2Lx2A9/aip4NPSLH6l7O
         SEVOAa5+qE63zMNcZVez7mSYA4IVlQhkEZYU7+yjzKQlUG+fnpijYYSNcflGOuHKikR8
         36J/mwQ8yRReATf2RtnnmUm5+PXC5UChisBvt4H0VAiegTRO75QZQAWgPp7+ic9tNlgd
         WxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788169343; x=1788774143;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aes8E7ycjw85I1hPRVRNDb1VK1GawwcAPWMBLAtTYaU=;
        b=EckbX8tVfTlJeX21K2tbvjfkKy9xODRBQ3IWLs0U+iXF0J2eAxTOGwl/RNqa3C2jEP
         HIdNx6VqdQiDm1zsqpu5uwJ4MKr4C9MhrC3RyyHSnz3ZSPSOCa5thfIEu0S6dlzWZi6g
         I4zC0w3rYjh+rPKjhTNH3RAI6rTBLWytBMnn6wD9VIbW7Qsjs0kcQs2cT2lteUbcsEX4
         KMTYmjMKrOVceaDVCg1dv8o1mnI/mxz8pdh3epy5LEVa/fouls1zs6NHA4Ttiq/IST4o
         a9XW9YTu3caWXXG/LE+e6w6/sVa+b4uTY1GMBnXx+T6VX8U/1feXeoQ0FVYAfFBJEjv/
         FLlA==
X-Forwarded-Encrypted: i=1; AHgh+RrYG+CfaHj/EOZtiCpQzkj3FpLLBTZaRn1ES0DI4nJKqvfgkeiZvgnCLTVz4D/0BYyp+L0L+rM=@vger.kernel.org
X-Gm-Message-State: AFuF++lJP1A0SyMTEIKpY9W95lqk5Gy70pp6k5BmzE7AjOMZkurL7sQ+
	ddB/7C/5qdS6PMx7aynS63M8lsSQOy/nMs5ait6GEX5e4MeEvXKx8dNrlkuvn5UuCeWfoTLyMSV
	ztNx7++H2vu/B6BJN9W2PAgXfVecyTi+lNYfizPr9
X-Gm-Gg: AR+sD11bxYObJmwOXYm94TrjZqRBu1fyTYRjVlxNe07hQFqba832xgZ0Dc1XCZxqrea
	xSJDjOhjmI2O888V3TU5CuYPo7BZ1UOV79VrVxQXmLOuX0flsJ7XFQfYKLQfKnnb1+obAtCu64c
	TdamL2B2ROImEJuQIXrqg2yTfeUU7/w7Exu4bgOaw8tz17ww4TSX7CZ9YT5Z6CBVNemZIMNWXlL
	iQs4BCnYbarPr5/26Okj4x+eW+eS/J9IcifI9m1px584jD50dU6ZXe8e0cBpspktkE9FJLMgbAz
	Rfj21Cl+7V5EPl5b5nPeSwrnswDfxv5OSUFXwZ3XmJt8vI1FjZCrwAC9NZ4CNJvrUbNca28WVRH
	JzJoJLHCaMiR4Y1fnDXO/YbTh1txk6fuTXximDlHPRtWWKL1v2CG14OQGAA==
X-Received: by 2002:ac8:6f07:0:b0:52f:ab8f:43da with SMTP id
 d75a77b69052e-52fb9693eb9mr350760701cf.37.1788169342525; Mon, 31 Aug 2026
 02:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828060822.2628276-1-florian@schauer.to> <8c7f834e-5701-4748-9a9a-fed78aa50198@kernel.org>
In-Reply-To: <8c7f834e-5701-4748-9a9a-fed78aa50198@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 31 Aug 2026 11:42:11 +0200
X-Gm-Features: AcwNN1XhZ8DtUPl2WaV0TDG5OJhey4REsDrNdGL196w5BGJaMuaw0J-qgC5r8ZY
Message-ID: <CANn89iKN=uj3+_nESHep7+3rurFw3S9Cqc+7mjFTztYEeXJsSA@mail.gmail.com>
Subject: Re: [PATCH net v2] page_pool: keep frag_offset aligned for odd-sized requests
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Florian Schauer <florian@schauer.to>, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
	linyunsheng@huawei.com, Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 11:00=E2=80=AFAM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
>
>
> On 28/08/2026 08.08, Florian Schauer wrote:
> > page_pool_alloc_frag_netmem() rounds the requested fragment size with
> >
> >       size =3D ALIGN(size, dma_get_cache_alignment());
> >
> > dma_get_cache_alignment() returns 1 unless the architecture defines
> > ARCH_DMA_MINALIGN, which DMA-coherent architectures such as x86 do not.
> > There the ALIGN() is a no-op and pool->frag_offset advances by the raw,
> > unrounded size.
> >
> > A single caller asking for an odd size then leaves frag_offset misalign=
ed
> > for every fragment carved out of that page afterwards.  The pool is sha=
red,
> > so the damage is not confined to the caller that caused it.
> >
> > The per-cpu system_page_pool used by generic XDP hits this.
> > skb_pp_cow_data() allocates its fragments with the raw packet length:
> >
> >       size =3D min_t(u32, len, PAGE_SIZE);
> >       truesize =3D size;
> >       page =3D page_pool_dev_alloc(pool, &page_off, &truesize);
> >
> > leaving frag_offset odd for whatever is carved out of that page next.  =
Its
> > own head allocation is already aligned -- SKB_HEAD_ALIGN(size) plus the
> > XDP_PACKET_HEADROOM its callers pass -- so it is a later user of the sh=
ared
> > pool that pays: page_pool_dev_alloc_va() returns a misaligned buffer,
> > napi_build_skb() installs it as skb->head, and skb_shinfo(skb) =3D=3D
> > skb->head + skb->end is misaligned with it.
> >
> > skb_shinfo()->dataref is a 4-byte atomic_t at offset 0x20, so the
> > atomic_inc() in __skb_clone() straddles a cache line.  On x86 with spli=
t
> > lock detection -- fatal for kernel split locks by default -- this panic=
s
> > the machine:
> >
> >    Oops: Split lock detected
> >    RIP: 0010:skb_clone+0x154/0x1e0
> >    Call Trace:
> >     <IRQ>
> >     raw_local_deliver+0x1ed/0x2c0
> >     ip_protocol_deliver_rcu+0x54/0x1c0
> >     ip_local_deliver_finish+0x85/0x100
> >     ip_local_deliver+0x67/0x100
> >     __netif_receive_skb_one_core+0x85/0xa0
> >     process_backlog+0x87/0x130
> >
> > Reproduced by attaching any generic-mode XDP program to loopback and
> > opening a RAW IPPROTO_UDP socket, which makes raw_local_deliver() clone
> > every locally delivered UDP packet; ordinary DNS traffic then triggers =
it,
> > roughly once per 2500 clones.  Observed on 6.12.101 and 7.1.8.
> >
> > Tracing page_pool_alloc_frag_netmem() over one such run shows the
> > amplification -- two odd-sized requests, nine misaligned offsets:
> >
> >    requested size & 7:   0: 17035    5: 1    7: 1
> >    frag_offset & 7:      0: 17028    3: 1    4: 1    5: 1    6: 1    7:=
 5
> >
> > and skb_pp_cow_data() returning heads that were aligned on entry:
> >
> >    head 0xffff8f4c86aeac00 -> 0xffff8f4c53a9a9c4 (&7=3D4)
> >    head 0xffff8f4d6a8a42c0 -> 0xffff8f4c4f7b7a45 (&7=3D5)
> >
> > Round the fragment size up to at least the alignment struct skb_shared_=
info
> > requires, so fragments are always suitably aligned for the objects call=
ers
> > build on them.  Architectures needing a larger DMA alignment keep it.
> >
> > This also makes the remainder computed in page_pool_alloc_netmem(),
> >
> >       *size =3D max_size - *offset;
> >
> > aligned, since max_size is a power of two -- which fixes the matching
> > misalignment of skb->end.
> >
> > Verified with a controlled A/B under QEMU/KVM: same tree, same config,
> > same compiler, same rootfs and identical traffic, differing only by thi=
s
> > patch.  A SEC("xdp.frags") XDP_PASS program on lo plus UDP datagrams
> > larger than max_head_size drives skb_pp_cow_data()'s fragment loop, whi=
ch
> > passes raw packet lengths to the pool.  Measured at the return of
> > skb_pp_cow_data():
> >
> >                            unpatched   patched
> >    skb_pp_cow_data calls       40800     40800
> >    misaligned skb->head         1120         0
> >    dataref at line offset >60     80         0
> >
> > The last row counts the accesses that actually fault:
> > skb_shinfo()->dataref sits at head+end+0x20 and is a 4-byte atomic, so
> > `lock incl` splits a 64-byte cache line only when that address lands at
> > offset 61..63.  All 80 occurrences were at offset 61; the panic reporte=
d
> > above was at offset 62.  Eliminating the misalignment removes every one
> > of them.
> >
> > Same class of bug as commit 3bed3cc4156e ("net: Do not allocate page
> > fragments that are not skb aligned"), which fixed the older
> > netdev_alloc_frag()/napi_alloc_frag() allocators.
> >
> > Fixes: 53e0961da1c7 ("page_pool: add frag page recycling support in pag=
e pool")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Florian Schauer <florian@schauer.to>

Reviewed-by: Eric Dumazet <edumazet@google.com>
Thanks.
