Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331110;
	b=ka26qcuEB8p1IV3d/HIZegX+9f3/zgi+aD7837lwyPogGEejvMMnYGvBxTmkaHmfmfBs
	 VfkYsDqZ5eeDIK4pO0EnEkEW2OkCT3rVrimmNwwZFuWGNn8hmgT2Sz8W9YT+a/6pxOFeN
	 91G6IKe4QIv5MuUHefFpBZmHAcXAsErfAlDctXKTgVvbcox+XHB6VLEttDYjn8t+6mHEj
	 qbljpJFwoIE+xP4td1NsbzJOuF0UhDWfkvUgdJfFn9hQPfi0GHC5XARgl5i7E8F9nU33b
	 1Bqk2kljIF3ORDg8fUtlAn1oMwhsgRKZoKKIdxqbA7DTExRHRadQAKMT0PqPc+3HQ3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331110;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=JIZN06AjudKtw8P7z2AuVD9MjuRSapkzot3fClyAqTo=;
	b=hsTb6TamFgNERdexsjxBE2qnGBoUxHKKMXzNmu04WOAXFYj5d82pZvXvs8OXSChf/vJL
	 A7dwEieYLgOYy+I5DEO6yvyKuMbmL87f4DeVIpgf0OkdRhnizRIuWFM5oyEXarPFxcBON
	 i5JYvyeSYZB5gQasAmf9yk23oA96SeiQrSt6eZaQNl3SkD57/GUpPie+lBeiHiWkBaJ2V
	 0uJ/584OXNSuNVy1SYNK5fkRFYo//zxqmkETUAOdUgkg3aQDAyUR5cvfKZdd8hQxM6e4d
	 I90uniBzP6kiQYts7e+8R52wI63StUKsmlY3u9MXFsD0LmPT0FHx5ZpbjlM2z1J1G2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrN31MBG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F92606A332
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrN31MBG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F261F008BD
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331109;
	bh=JIZN06AjudKtw8P7z2AuVD9MjuRSapkzot3fClyAqTo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IrN31MBGYEHoe3I+Id+zUv7JgXjuZvTiIdovupEvRZArRdaYpDQ5O1CGIaY1p60l3
	 4xXNQTMCtGy30iK4N2vTuFXCXZlxmmGCB+kZSLdALJl8AHV/Y6lzffskqYKDchPf/I
	 ySlqhKlA73pRbp7GsiEf6Fbqk5uwkDluawl+OXOGQBguzCwQWtxqzKx2LC6pGT2wRI
	 HSL62kBQpb7dtei7FegSJMt+lIHoQ5R/CZzvhPK3qtF8jxgeO3AbB6VD98x4Zh+XLN
	 ET+qOGVGNRspJZrt0+LdYxVhx0H0gYCLQfErvU+8JTprP/+SwoB09R1tpbHJHIHdKo
	 oTqACdVzOEWTg==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6deb848ddd7so1358051eaf.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:18:29 -0800 (PST)
X-Gm-Message-State: APuU4Z8Drn92o6Y6aLYs52dffPO87suRCQmaZDxDtnfpe4ipLHPx5N9Z
	TkUwSdRSZ9f23RT9YypOD3N5uf0r+b2xHQV2AWYxqZ3AdMiid0ELq2e27m1GaAbjRT0cj0dRjqe
	sO98GhOqfgktvVrESwrz08+0baNU+49Q=
X-Received: by 2002:a05:6820:338a:20b0:702:f7c2:1937 with SMTP id
 006d021491bc7-718a7adc206mr1234230eaf.83.1794331108296; Tue, 10 Nov 2026
 09:18:28 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110162418.28322-1-yanhaishuang@cmss.chinamobile.com> <20261110162418.28322-2-yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <20261110162418.28322-2-yanhaishuang@cmss.chinamobile.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 10 Nov 2026 18:18:17 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiq-_YiC-5avRy8k9_puGEGshba=Z95meBD=+pCS16T01A@mail.gmail.com>
X-Gm-Features: AclHuK_BQdwGa-Kjt1YUj50YjvkFVskfrGku8EF6VXEo9uSUQ9fr9jS3lAruhgw
Message-ID: <CAL4Wiiq-_YiC-5avRy8k9_puGEGshba=Z95meBD=+pCS16T01A@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net: do not run out of frags in alloc_skb_with_frags()
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, almasrymina@google.com, 
	daniel@iogearbox.net, willemb@google.com, willemdebruijn.kernel@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	narcisav.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 10 nov. 2026 =C3=A0 09:31, Haishuang Yan
<yanhaishuang@cmss.chinamobile.com> a =C3=A9crit :
>
> alloc_skb_with_frags() rejects data_len above
> MAX_SKB_FRAGS * (PAGE_SIZE << order) up front, but two things can then
> make it need more than MAX_SKB_FRAGS frags, so it fails with -ENOBUFS
> for a data_len that passed the check:
>
> - It rounds the order down for the tail, so a tail of N pages is split
>   into one frag per bit set in N. With order 3 and 4K pages, a 516536
>   byte packet is 15 * 32K plus a 25016 byte tail, which becomes
>   16K + 8K + 4K, so 18 frags are needed although every page allocation
>   succeeded. Sizes between about 480K and 540K can be affected.
>
> - When a high-order allocation fails, it lowers the order for this and
>   every later chunk without checking that the frags left can still hold
>   the rest. With order 3, a failure on the first chunk leaves room for
>   at most 17 * 16K, so anything above 278528 bytes fails. These
>   allocations are made without direct reclaim, so they fail whenever no
>   order-3 page is free at that moment.
>
> Both came with the commit below. Before it, the limit was MAX_SKB_FRAGS
> pages, which fit at any order.
>
> tun hits this when vhost-net hands it a GSO packet of such a size from a
> guest. Nothing on the host limits the size of a guest's GSO packet to
> 64K: virtio_net_hdr has no total length, and tun_get_user() sizes the
> skb from the descriptor chain. Today's virtio-net drivers stay at 64K,
> but a guest can send bigger packets by raising its own TSO limit, and
> the host must not depend on the guest for that. Worse, vhost-net treats
> -ENOBUFS from sendmsg() as transient: handle_tx_copy() puts the
> descriptor back and retries it, so the vhost worker spins at 100% on
> the same packet and the device stops passing traffic in both
> directions.

This part is really a vhost-net/tun issue: handle_tx_copy() will spin
the same way on -ENOBUFS/-ENOMEM from real memory pressure, including
when the new direct reclaim attempt fails. Please trim this from the
changelog (or keep one sentence), this patch is about frag accounting
in alloc_skb_with_frags(), the retry loop deserves its own fix.


Also, this changelog is far too long. Ask your LLM to reduce it.

 On an unmodified host, tun_get_user() returned -ENOBUFS
> about 620,000 times per second, the tap's rx_dropped counter climbed at
> the same rate, and this went on with no traffic until the VM was
> destroyed.
>
> This patch only fixes the frag accounting for packets that pass the
> data_len check. A larger frame from a guest can still make
> tun_alloc_skb() fail in alloc_skb() and vhost-net retry it; that is a
> separate problem in tun.
>
> Keep rounding the tail down when the remaining frags allow it, and use
> one page rounded up for the whole tail otherwise. This is never larger
> than the full-size chunks already used. When a high-order allocation
> fails, only lower the order if the frags left can still hold the rest.
> If they can't, try the same order once more with the caller's direct
> reclaim (with __GFP_NORETRY, so no OOM killer), and fail only if that
> fails too. An allocation that succeeds today takes the same path; the
> extra attempt only happens where it would have failed.
>
> The tail case was triggered while prototyping >64K TSO for virtio-net,
> with a one-line guest virtio_net change raising its TSO limit; the host
> was unmodified. The fallback case was pointed out in review of v1. The
> fix was tested with that reproducer, with page allocation fault
> injection on the vhost worker, and with the KUnit test in the next
> patch.
>
> Fixes: 09c2c90705bb ("net: allow alloc_skb_with_frags() to allocate bigge=
r packets")
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
> ---
> Base: net a45dbf182137 ("ipvlan: make outbound skb headers writable").
> The tests below were run on net-next 303d91a15925, where
> alloc_skb_with_frags() is identical. KUnit on net 30c71476d842: net_core
> 20/20 (kunit.py, UML x86_64); with only patch 2 applied, the new test fai=
ls
> with err -105. allmodconfig W=3D1 build of net/core/ (arm64) on net
> a45dbf182137 with no warnings.
>
> Reproducer: x86_64 KVM host (i7-14700) running net-next 303d91a15925 with=
 no
> local changes; vhost-net, a tap NIC with mrg_rxbuf=3Don and rx_queue_size=
=3D1024.
> The guest (net-next too) has a local one-line virtio_net change setting
> netif_set_tso_max_size(dev, GSO_MAX_SIZE), plus
> `ip link set dev ethX gso_max_size 524280 gso_ipv4_max_size 524280`; then
> a 10 s iperf3 guest -> host.
>
> Tail case, without this patch: iperf3 fails, one vhost worker stays at
> 99.9% CPU, tun_get_user() returns -105 (31014 times in 50 ms, kretprobe),
> the tap's rx_dropped goes up by 34M during the run and keeps climbing at
> ~690k/s with no traffic, and the guest can no longer ping the host until
> the VM is destroyed. With this patch: ~100 Gbit/s, no drops, and the vhos=
t
> worker is idle afterwards; tun_get_user() handled 246783 packets, 237937
> of them between 480K and 540K, and none failed.
>
> Fallback case: CONFIG_FAIL_PAGE_ALLOC with min-order=3D3, ignore-gfp-wait=
=3DY
> and task-filter set on the vhost workers, so only the order-3 attempts
> without direct reclaim fail. Failures of tun_get_user() during the run:
>
>   probability   tail fix only               this patch
>      0%          99.0 Gbit/s, 0              96.0 Gbit/s, 0
>      5%          92.7 Gbit/s, 240418         99.8 Gbit/s, 0
>     20%          72.3 Gbit/s, 1152801       101.6 Gbit/s, 0
>     50%           0.1 Gbit/s, 4077173        99.5 Gbit/s, 0
>    100%          iperf3 fails, 10573852      98.9 Gbit/s, 0
>
> With this patch the order-3 pages that the first attempt doesn't get come
> from the retry with direct reclaim (3546571 of them at 100%). Not tested:
> the retry failing as well, i.e. real memory pressure, and other callers
> of alloc_skb_with_frags() than tun.
>
>  net/core/skbuff.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a7d555b3d2f28..da9025e6f0c3c 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6906,15 +6906,41 @@ struct sk_buff *alloc_skb_with_frags(unsigned lon=
g header_len,
>         while (data_len) {
>                 if (nr_frags =3D=3D MAX_SKB_FRAGS)
>                         goto failure;
> -               while (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << orde=
r))
> -                       order--;
> +               if (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << order))=
 {
> +                       unsigned long pages =3D DIV_ROUND_UP(data_len, PA=
GE_SIZE);
> +
> +                       /* If splitting the rest into smaller pages would=
 need
> +                        * more frags than we have left, use one larger p=
age.
> +                        */
> +                       if (hweight_long(pages) > MAX_SKB_FRAGS - nr_frag=
s)
> +                               order =3D order_base_2(pages);
> +                       else
> +                               order =3D ilog2(pages);
> +               }
>
>                 if (order) {
> +                       unsigned long smaller =3D PAGE_SIZE << (order - 1=
);
> +                       bool can_shrink;
> +
> +                       /* Only fall back to smaller pages if the frags l=
eft
> +                        * can still hold the rest. If not, try this orde=
r
> +                        * once more with the caller's direct reclaim.
> +                        */
> +                       can_shrink =3D DIV_ROUND_UP(data_len, smaller) <=
=3D
> +                                    MAX_SKB_FRAGS - nr_frags;
> +
>                         page =3D alloc_pages((gfp_mask & ~__GFP_DIRECT_RE=
CLAIM) |
>                                            __GFP_COMP |
>                                            __GFP_NOWARN,
>                                            order);
> +                       if (!page && !can_shrink &&
> +                           gfpflags_allow_blocking(gfp_mask))
> +                               page =3D alloc_pages(gfp_mask | __GFP_COM=
P |
> +                                                  __GFP_NOWARN | __GFP_N=
ORETRY,
> +                                                  order);
>                         if (!page) {
> +                               if (!can_shrink)
> +                                       goto failure;
>                                 order--;
>                                 continue;
>                         }

can_shrink is only needed when the first alloc_pages() failed, but you
compute it for every chunk, with a 64bit divide since the divisor is
not a constant.

Please move all this in the slow path, and use a shift. Something like
(untested):


                if (order) {
                        page =3D alloc_pages((gfp_mask & ~__GFP_DIRECT_RECL=
AIM) |
                                           __GFP_COMP |
                                           __GFP_NOWARN,
                                           order);
                        if (unlikely(!page)) {
                                unsigned int shift =3D PAGE_SHIFT + order -=
 1;

                                /* Can smaller pages hold the rest ? */
                                if (((data_len - 1) >> shift) + 1 <=3D
                                    MAX_SKB_FRAGS - nr_frags) {
                                        order--;
                                        continue;
                                }
                                if (!gfpflags_allow_blocking(gfp_mask))
                                        goto failure;
                                page =3D alloc_pages(gfp_mask | __GFP_COMP =
|
                                                   __GFP_NOWARN | __GFP_NOR=
ETRY,
                                                   order);
                                if (!page)
                                        goto failure;
                        }
                } else {

I find this also easier to follow than the
(!page && !can_shrink && ...) sequence.

The tail part looks good to me.
