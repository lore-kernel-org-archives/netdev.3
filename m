Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915B22D7A1
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720791; cv=pass; b=nTo6ZSlWQnZPujy0cC7zdFzwof27qdao8ynrWzOqO6KmvU7XioZcDvlEnO92OkSFM76rogzI+tuAQfCqYBGAYr9NUmEHkZvQNgf8fD6s5SL213M2Eh1VWoOcnevTyE2HnD2jKjpoA7cY4ykepBaJc2o4xt7QPnTwzHLoJnce/EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720791; c=relaxed/simple;
	bh=hdzmpEyx7wmQQes5tKR6PInw0TXRMu3tnEXMX3bv/zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TielkRXBopgck83cdVO6tcmriYLOa96vyGj5p8lwvdGqSR2TsV+bbIMfsXWPjWu3RPFRMUKNvmyoHDellay2/DZJ2IEnNV824gl4ZnW8SebW4j5i0x98phQgmlv5yqPs+AVJEO5Eusgn9xkB0YrEMWVt1Kc0W7tsN1t8MbGpZrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxff5bxN; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxff5bxN"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664e3ed58bcso5219229d50.1
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 18:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785720788; cv=none;
        d=google.com; s=arc-20260327;
        b=fXKuKZJdFZazgq2uvlXOdo3TpFGo17XvF3sYbhDVxs3bRreQiF0IVX9qh0a4ri+DuQ
         zkAzITbkKEq1Hyg6zhceu/gsVYBfK2PI3o4vl3tUwnG/U0y9DqAUSbrrckpug8zz6Fod
         GdcHofzDaROAUKWwuNVqk31UV3PmwmP6cDNAhqRu8d+9oGkDiRW55NmnF5BR+5WKS5xo
         DvgaSLTuGsz6QNSMc1zzqNL2xZSFKqhU6zFz9CX2dYQZg9yxc49HYfpCFya/CcSORrjc
         lukUEOxjsVtnEiGJ86PUEy6Nfg/yiNBIM7Ve7WhNuwkRQuU8U/aTPjWRSP+DIjyewdoh
         yKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MtK1QoBX9EhvBSeTPFcat/a++KIi/D9hUCf5F/tRn3Q=;
        fh=AKZ8T+V1eYOFb+xfE+aWrfKh2H/XVsBhQ9A13J59vaU=;
        b=oifO8lBPin7CKEp6HaUkgFvOJ5vQ52r93MscWYmPzcYu+DIqHEV7UE9+QlZ+ZBw6TJ
         yysbdJYFX1tbalDRQ+HKACM0OTMRXSkUCVb9dFUFAhwXpYcOOrpKkFFAT481dvoNzt7A
         /Mh1M7qcIpNKGCPsUy57bTfJn1pcX2ZVw0di9DLUvGYOv6rGde15CaBbv4GjuFbaCWc0
         4xeuaWDKeAuM9Ar3sb0YzP5ZBxsZ+b110hfb4smmSZBgTeJSDy0vIcSyp1BcgUNNeXNY
         u0HrBeLchIFUz8rUdr8Kg4kW9ayqvh+1BmgwC12EuOE7sm8Qa9k4XjbRNoqUBbXEce47
         IA9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785720788; x=1786325588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MtK1QoBX9EhvBSeTPFcat/a++KIi/D9hUCf5F/tRn3Q=;
        b=cxff5bxN1mY09Ynidyu/GMTgRqPWYllE/6HBQFWqHZcbPtqslT5JTtOBdmC9TBuZOf
         1bBgNZL8QMdvjEK/ElzPsc4OKbrdzEFp51sDg2rONC/2owAbQezeCmizO0SAAyTf0DqV
         M/9SeWk2k2+8x7E0bml1Nv6c4g7VYcisoML9qADMIz92rSaODAuwE4STfQz5MpZYBGTo
         NIh5yFzEpOWEh7007NfpNxZ6bD9ifWSOw4iyqR1OyMfXnNku/WBgWgsyhlgMJZUvp6cS
         whaG8TLhzQR1+w8HdXXwThdc/OqrtgXUXkXv2VDutoG+tcVznTkYcgda/Dl4ei+lngSq
         lEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785720788; x=1786325588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MtK1QoBX9EhvBSeTPFcat/a++KIi/D9hUCf5F/tRn3Q=;
        b=qlL+lv+7zGNptRLRrdAGn3XoYIO+dX/ISxhMc+r4+qH8kO6BbBejKRpdeB6Mbk9CuW
         tnLZAbfBzup+IYcz3nNmqLsLO2ta82IsvQaCQvgpc9WWDkC5BCFwEhHSQj7ykDalRfrX
         mTrvhxl77T6XQJBUKz6iqeDh19DOpbMQhe57b+WzeRx5QrHVQOZc0Bly+JPLsnL+ZyTi
         TkG3YIra0HIKKcHPB6LYeamN3109i5AoTlhjdDPG6hCnYXFIfrpMjPPaNVv5XNsC7aLZ
         d/rBYOjEhR9PTCYY3cOJCYO8B/eCuaT6Zl68fSL7L5JFtefcpJ2sWMW8nU5iumvE70wX
         97eA==
X-Gm-Message-State: AOJu0YwUFVMPvrDZS0ssJJslCcDpu4gEImPJRfML8fQQclWU6RPvOzJJ
	grHOoCNQYt1RKgf1zTT7/JObLeJuMO17kDx9H7ueJExtm6d7L2XDneWoHBTgne4OIl/h7u56kcx
	rQPgUBrMPsh0Cw73XqpoR7wv4e7rZkQs=
X-Gm-Gg: AR+sD13uFj7KaIEZhdI2ARs9glAvEmDCoCwceoNegn973MXhX8ErdhNcTcl/VGnd2SY
	3z14QTKrwmCALqSWZVAHkfxvHazXTUqyy5U30FyxTXkyqZuSbteePJZJlXT9K17yqzmewlKorKG
	zoIrKUnrCHDHoVLE9y0sxZonlZq9hK7jSSkAZwBlPJNRNNqPhwi1ceiB0JxfUNGF2fTdQwh0hhi
	9Ilq3xx3/jikButNcYEiGQNYvLFgthqjHCeAPYS/BWgmhlDV4fOXGksfivzIgh5Ac9Az9SUEPz3
	iP+B0BCKz2lvT7AZxvxr5GpUaEqDcJT7Lt3AdKyCYRrddnFmbQb3NjDbG81EFOwALfHwc6EpzJ7
	jmaumPu8PoPFFoAImIGR8GrMx
X-Received: by 2002:a53:e031:0:b0:667:8471:41a2 with SMTP id
 956f58d0204a3-6694f9ec735mr7732211d50.25.1785720786742; Sun, 02 Aug 2026
 18:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
 <20260731032357.6114-3-sun.jian.kdev@gmail.com> <80687d9c-9c27-494c-b3f2-efd0230b1895@gmail.com>
In-Reply-To: <80687d9c-9c27-494c-b3f2-efd0230b1895@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Mon, 3 Aug 2026 09:32:56 +0800
X-Gm-Features: AUfX_my1NUSs3oqdmWxM7iAAroMNTq7trteihXH_7Nm5heweklKCXTUafeNBAzw
Message-ID: <CABFUUZGTJptpOKKAeU3ThibmPpXize4Eud2=EBX-vqaX3YH4pg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] veth: fix skb length accounting after XDP frag adjustment
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Krishna Kumar <krikku@gmail.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	maciej.fijalkowski@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 12:14=E2=80=AFAM Mohsin Bashir <mohsin.bashr@gmail.c=
om> wrote:
>
>
>
> On 7/30/26 8:23 PM, Sun Jian wrote:
> > veth exposes non-linear skb fragments through an xdp_buff. If an XDP
> > program adjusts the fragment area, veth_xdp_rcv_skb() copies
> > xdp_frags_size back to skb->data_len but leaves skb->len containing the
> > old fragment contribution.
> >
> > After a fragment shrink, this makes skb_headlen() larger than the actua=
l
> > linear area. In the reproduced UDP receive path, __skb_datagram_iter()
> > copied 1024 bytes past the actual linear tail to userspace, starting at
> > struct skb_shared_info. The copied bytes included the affected skb's
> > nr_frags, xdp_frags_size and a kernel pointer from
> > skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
> > amount and truncated at the end.
> >
> > Subtract the old data_len before replacing it and add the new data_len
> > afterwards, keeping skb->len and skb->data_len synchronized.
> >
> > The fragment accounting must run before the linear tail adjustment:
> > when bpf_xdp_adjust_tail() shrinks the packet into the linear area it
> > releases all fragments, and __skb_put() requires skb->data_len =3D=3D 0
> > by that point.
> >
> > A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened b=
y
> > 1024 bytes from its fragment area. Before the fix, all 10 runs produced
> > corrupted payloads. After the fix, all 10 runs matched the expected
> > payload exactly.
> >
> > Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept =
non-linear skb")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >   drivers/net/veth.c | 23 +++++++++++++++--------
> >   1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 00e34afd858e..348391e87e14 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -865,18 +865,25 @@ static struct sk_buff *veth_xdp_rcv_skb(struct ve=
th_rq *rq,
> >
> >       skb_reset_mac_header(skb);
> >
> > -     /* check if bpf_xdp_adjust_tail was used */
> > -     off =3D xdp->data_end - orig_data_end;
> > -     if (off !=3D 0)
> > -             __skb_put(skb, off); /* positive on grow, negative on shr=
ink */
> > -
> >       /* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> > -      * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> > +      * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contributi=
on
> > +      * from skb->len before updating data_len, then add the new one b=
ack.
> > +      * This must precede the linear tail adjustment below: a changed
> > +      * data_end implies that no fragments remain, and __skb_put() req=
uires
> > +      * a linear skb.
> >        */
> > -     if (xdp_buff_has_frags(xdp))
> > +     skb->len -=3D skb->data_len;
> > +     if (xdp_buff_has_frags(xdp)) {
> >               skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> > -     else
> > +             skb->len +=3D skb->data_len;
> > +     } else {
> >               skb->data_len =3D 0;
> > +     }
> > +
> > +     /* check if bpf_xdp_adjust_tail was used */
> > +     off =3D xdp->data_end - orig_data_end;
> > +     if (off !=3D 0)
> > +             __skb_put(skb, off); /* positive on grow, negative on shr=
ink */
> >
> >       skb->protocol =3D eth_type_trans(skb, rq->dev);
> >
>
> I am most likely missing something here but what happens if we have
> frags and we attempt to advance data_end while leaving some frags
> present (e.g., bpf_xdp_pull_data())? Looks like, in that case we would
> issue __skb_put(skb, off) with off > 0 and we would hit
> SKB_LINEAR_ASSERT() because skb is still non-linear?

Hi Mohsin,

Thanks for catching this. You're right that bpf_xdp_pull_data() can advance
data_end while leaving frags present. I'll investigate this path and follow=
 up.

Thanks,
Sun Jian
