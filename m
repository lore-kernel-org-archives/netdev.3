Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB83FBB5A
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759024; cv=pass; b=dYVJ6ZGHRDrlarygwRdds8JJxIKb5kHnAAKvAP6Z8zaarcleRM+nPP6xY5zHFimz7MGuSkbeP6UPhl8dyv5e4nk6utx2AHgzKXANHvG7g1JMW5WPZzW4zYWAmUDlwgQeEYtSSOIWNFthwVs6Nr+ReKhI3hYAWZ0eu7e2id28bJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759024; c=relaxed/simple;
	bh=t+UZJG+GzsSQuOgLA31dorYvO2F8pVYT+Y4HWV4K/Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5Tl+PCNuwcoVqFfreT73kZWoxPQ8f8XFSJsutg1P/GiTYiITrhcV03wAiag0cnupnJeTs2w9wREKwodFXD3oHFci5XstG74pmQXtGUre3/kOB9m5EWuggROekhWmFGKo6Od8EByHZ10JqcM83q6oYc8KVbzdL7PtTjP/cM8vlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sq08v3ls; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sq08v3ls"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52f1a320162so2573111cf.2
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 08:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787759020; cv=none;
        d=google.com; s=arc-20260327;
        b=TgULAZKo6ygj9E1AoGJF0a5hACgTxhF1vt1eL/MLjiFdIdUBMshxLEqL3RJeAXW7Vr
         E5WvTnNxfjH5uJmprXN1ippBCz2FKgKg+N2ZMtdvVZkbFQX5GPAMDCQJ5mk30DC3Wwoo
         hrVVV0EajAyLo2ITxAL8li9XzQFSdt2QY37t+BpFRnBqn47/6ffqj+wfL1ttBoCfCxnJ
         kZWxtbVYIhbAs4npRbw8zezuirV1UEOlmUqhsQqw9pK9bHDsd2bHqdS7Gji2142D9PPj
         83Yr7F3oGL+Y2x27eQumswGVB5LMbGhq4HURIT3s3gxJYqE3X1OVjnfZf/l6ZGrBRmt5
         002Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UVSjhIziBnajqA7H4PUHZrhD1u9T6d8YmCozPYiqoT4=;
        fh=DVkc13UHsqV8qzu5NP4fkecl1AAN9dpekIPJV2clEgQ=;
        b=LPI9CzbsoHs2Je2GwZuWbrJaTk04A9YwWOgj8akbuXRBC1YX8/GCW8NVRa1Mv/1o+L
         zmE/ufICfxSw1fKyByjy+JhKKzlGXmBPpRAgoUleRDhnze1TfOFmwaKp6//02xT+6TgZ
         FXtuNjqLe63va8bJ1ci/8tKiGhgx40k0Anh/zGY0245Lo7F9s04G2KnS+FlBAzJ7Kd2K
         WR/UukG9Y0mrvsvFCp4nIz0qRn8w64DlCDnzRi/R2/oEl0qWIeF59wVVWA3HS4NkcOF9
         SUREtATqIUFRp/jy1myaSAqSe8hs+Y6N9B3hjODcYpSMjRijB8ZDa74HYCGhVhPO6NiT
         Se4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787759020; x=1788363820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UVSjhIziBnajqA7H4PUHZrhD1u9T6d8YmCozPYiqoT4=;
        b=sq08v3lsVH1MUXBCYBCk+GmN3jJsBgpTgxTV9kvMCJy24rFlGhmv6zRYHL2E/GnWvV
         L4YCrmvdMQpFlBnCeUs6xMZR5r7lnAQbYUzki5lLAMqeIf20eQDnXuhjjm7rFfxIeOeO
         1LvuwkbHU3sPG4/3I5FwkRe89FK8Jk2iRkta+7sZud2GT/nvMNmaSMz1G9YWkQDAnRtn
         rMm0P2zYz3djEBL2fSIPTvKtik1D1qaZLRbW3O/ctNId2HomrvHulnxXQBPV4OSk1Yg9
         O9DuxOkS5sk3k2TqOsKiAo1mDI0zXFGPBBaXBqHlZGJpiV2YYcCFpxUGi0/RPARDJ9oL
         ZvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787759020; x=1788363820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UVSjhIziBnajqA7H4PUHZrhD1u9T6d8YmCozPYiqoT4=;
        b=KRb4r608+AtpmKyj5rU2SB48jgVhc6hepcoAGzTgSaiOocekN91rWAoIJIpdyykejQ
         BVb4wghz60zGDwpwl/OMgeGNmOKhH6wmk/VY8GIFZaX+qGFhKz4eRKphg1dew6QW83UD
         IdfNHBdI8orDaVCleo5P5W7Xj56m3uoAnzc27UBRFkqp6CM7IQCllamRR0B3okqQ48DB
         +GPewROPPuA5U12dVlbGQuYCOJn2xesek/eYWiikYSsqb5HSHHWKm3x9MKPfJ+udcBZ+
         ednJ4zckKg2L3aTpB+ovEgi7GGQTBegYZVZMeDFyMTPNL94bURFCzkmWTcfO78hqo1rE
         WPwA==
X-Forwarded-Encrypted: i=1; AHgh+RrU1jWf+Xlc0ASPVkPC/CuOxsuJvQNxKNMUjL/V+OFqvyuqRd8RE1OyFP83Rf20QpCipKeaRso=@vger.kernel.org
X-Gm-Message-State: AFuF++n0bNZ4w//joQE8ADlIl3/TvSGIPeHktJuge9+uMtBtqUdt8x8C
	UjTgCIgVTzBMOIxOvGtGyt7G84gvwR7ExpT5oRfKhwIqbcWCd8ravf8z7dnBiKmrnp/1Mx75DDd
	G66/MCSoyVrsx1ZegvsTgWdrQislaHV23QQTNY+oP
X-Gm-Gg: AR+sD12uCJKy1IkGYFdckYpx8UUCqwXKOtH//IytMfHsvHuyWCxP2zcdXjAoI8h+zvN
	xagRTZLbWYVJVYcGROua2OCcr0EMvi9HJD+sGdLxF+5Him4Uy6tobL0koB98kdP/iNDI0PkIEjj
	YqmderawvAvmLgx/vgtMowOXrElisMJnSK2E7HBIIdQuPU7b8+CfqhhN+6W9CQY6kyrHgGOCsB1
	QVuVkmj1NM5UvRdLcekCi+WTB6I+ZqhhE8DlaMjxz9ImtEq1ulAxAscENbNKaubJKRSKY5VnpOf
	3pswuFPpWnBc8OsW/EFeUgkBdU5XuZk/O48gW0Cv3q3Ij95gMzWIGs0K0df5GTyhF5oeS8K8V/r
	gGgt7himFI1bkEG9BGq+wXays8hsqILqrJ3pIA164ngAGk6hEqRWUtx+SwH8=
X-Received: by 2002:a05:622a:1e15:b0:52b:4c5a:5844 with SMTP id
 d75a77b69052e-52e4232333emr81680181cf.20.1787759019324; Wed, 26 Aug 2026
 08:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826135252.3091193-1-florian@schauer.to>
In-Reply-To: <20260826135252.3091193-1-florian@schauer.to>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 17:43:25 +0200
X-Gm-Features: AcwNN1UPcaNMSfJEESXZg0-2cY-GKNHw_shclvxV2PmWjE2AEs75WcK4lyzHWtU
Message-ID: <CANn89iJ7p5P-Ryufr1MBCcYEnzDTMBJbLjNiTNGsVuktMNQOcA@mail.gmail.com>
Subject: Re: [PATCH net] page_pool: keep frag_offset aligned for odd-sized requests
To: Florian Schauer <florian@schauer.to>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 3:53=E2=80=AFPM Florian Schauer <florian@schauer.to=
> wrote:
>
> page_pool_alloc_frag_netmem() rounds the requested fragment size with
>
>         size =3D ALIGN(size, dma_get_cache_alignment());
>
> dma_get_cache_alignment() returns 1 unless the architecture defines
> ARCH_DMA_MINALIGN, which DMA-coherent architectures such as x86 do not.
> There the ALIGN() is a no-op and pool->frag_offset advances by the raw,
> unrounded size.
>
> A single caller asking for an odd size then leaves frag_offset misaligned
> for every fragment carved out of that page afterwards.  The pool is share=
d,
> so the damage is not confined to the caller that caused it.
>
> The per-cpu system_page_pool used by generic XDP hits this.
> skb_pp_cow_data() allocates data fragments with the raw packet length:
>
>         size =3D min_t(u32, len, PAGE_SIZE);
>         truesize =3D size;
>         page =3D page_pool_dev_alloc(pool, &page_off, &truesize);
>
> and later calls page_pool_dev_alloc_va() for a new skb head, which
> napi_build_skb() installs as skb->head.  Once frag_offset is odd that hea=
d
> is misaligned, and so is skb_shinfo(skb) =3D=3D skb->head + skb->end.
>
> struct skb_shared_info begins with an atomic_t dataref, so the increment =
in
> __skb_clone() straddles a cache line.  On x86 with split lock detection -=
-
> fatal for kernel split locks by default -- this panics the machine:
>
>   Oops: Split lock detected
>   RIP: 0010:skb_clone+0x154/0x1e0
>   Call Trace:
>    <IRQ>
>    raw_local_deliver+0x1ed/0x2c0
>    ip_protocol_deliver_rcu+0x54/0x1c0
>    ip_local_deliver_finish+0x85/0x100
>    ip_local_deliver+0x67/0x100
>    __netif_receive_skb_one_core+0x85/0xa0
>    process_backlog+0x87/0x130
>
> Reproduced by attaching any generic-mode XDP program to loopback and
> opening a RAW IPPROTO_UDP socket, which makes raw_local_deliver() clone
> every locally delivered UDP packet; ordinary DNS traffic then triggers it=
,
> roughly once per 2500 clones.  Observed on 6.12.101 and 7.1.8.
>
> Tracing page_pool_alloc_frag_netmem() over one such run shows the
> amplification -- two odd-sized requests, nine misaligned offsets:
>
>   requested size & 7:   0: 17035    5: 1    7: 1
>   frag_offset & 7:      0: 17028    3: 1    4: 1    5: 1    6: 1    7: 5
>
> and skb_pp_cow_data() returning heads that were aligned on entry:
>
>   head 0xffff8f4c86aeac00 -> 0xffff8f4c53a9a9c4 (&7=3D4)
>   head 0xffff8f4d6a8a42c0 -> 0xffff8f4c4f7b7a45 (&7=3D5)
>
> Round the fragment size up to at least the natural word size so fragments
> are always suitably aligned for the objects callers build on them.
> Architectures needing a larger DMA alignment keep it.
>
> This also makes the remainder computed in page_pool_alloc_netmem(),
>
>         *size =3D max_size - *offset;
>
> aligned, since max_size is a power of two -- which fixes the matching
> misalignment of skb->end.
>
> Verified with a controlled A/B under QEMU/KVM: same tree, same config, sa=
me
> compiler, same rootfs and identical traffic, differing only by this patch=
.  A
> SEC("xdp.frags") XDP_PASS program on lo plus UDP datagrams larger than
> max_head_size drives skb_pp_cow_data()'s fragment loop, which passes raw =
packet
> lengths to the pool.  Measured at the return of skb_pp_cow_data():
>
>                           unpatched   patched
>   skb_pp_cow_data calls       40800     40800
>   misaligned skb->head         1120         0
>   dataref at line offset >60     80         0
>
> The last row counts the accesses that actually fault: skb_shinfo()->datar=
ef
> sits at head+end+0x20 and is a 4-byte atomic, so `lock incl` splits a 64-=
byte
> cache line only when that address lands at offset 61..63.  All 80 occurre=
nces
> were at offset 61; the panic reported above was at offset 62.  Eliminatin=
g the
> misalignment removes every one of them.
>
> Same class of bug as commit 3bed3cc4156e ("net: Do not allocate page
> fragments that are not skb aligned"), which fixed the older
> netdev_alloc_frag()/napi_alloc_frag() allocators.
>
> Fixes: 53e0961da1c7 ("page_pool: add frag page recycling support in page =
pool")
> Signed-off-by: Florian Schauer <florian@schauer.to>
> ---
>  net/core/page_pool.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 1234567..89abcde 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1065,7 +1065,14 @@ netmem_ref page_pool_alloc_frag_netmem(struct page=
_pool *pool,
>         if (WARN_ON(size > max_size))
>                 return 0;
>
> -       size =3D ALIGN(size, dma_get_cache_alignment());
> +       /* dma_get_cache_alignment() is 1 on DMA-coherent architectures, =
so on
> +        * its own it cannot keep frag_offset aligned.  Callers build obj=
ects
> +        * on these fragments -- skb_pp_cow_data() turns one into skb->he=
ad,
> +        * where skb_shinfo() must be aligned -- and the pool is shared, =
so an
> +        * odd-sized request must not skew every fragment that follows it=
.
> +        */
> +       size =3D ALIGN(size, max_t(unsigned int, dma_get_cache_alignment(=
),
> +                                sizeof(long)));

Perhaps the comment would not be needed with something more descriptive.

size =3D ALIGN(size, max_t(unsigned int, dma_get_cache_alignment(),
                      __alignof__(struct skb_shared_info)));
