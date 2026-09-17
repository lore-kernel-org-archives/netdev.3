Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1D42BEFF6
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 03:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789616533; cv=pass; b=Fx/MwzJ/zJpMT70GUDWEd6fUwXvYpEqiNVOqQ2E3DaL8vOe+W91TF63RIVXI9XJDLdkMXnvg9po7jjqno5Au+KOO9Tegu3adYKm3i2p8Nwq+9Bu5qT0XLCr9ek6Hbu8x0AkAtJxBppSpM4WbfSc+WWOSDwFv0R5fRVabWVmjqT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789616533; c=relaxed/simple;
	bh=Sz3sI/ilZWmI/84i5q1iwrz7voVcYaz5ShOGHorkpzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpookKM/vMYRJS1QaFOOzp8zF19jdGY7h/g8DuTHvU03Be8zbT4UiQveaeZRkqKQ7/Zh+S4qrzhL6i0A+C+Tlo/o2Brl6/GeSYaqMuzYEjkLtCHcq114FsUHO3PdC7ZVJeF4UQGm+bpbs3EAbj2uDSqSkpvte5GH4LPNKOS2aGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRkzMI+r; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRkzMI+r"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b8b3c8c4bbso203400e87.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 20:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789616530; cv=none;
        d=google.com; s=arc-20260327;
        b=i6KE+Jze9uoR/EWqwFwlmZYiC9Ul00FBJgYYfklCflsH3ET7PjgJmDr+6b4To0rn+n
         ojbp36/UOTpydG3Ji9hz2RN/RVeFmGCmxXYbbHg2HyWXKQm2LAZs2DGRx9s4cDwsF8zZ
         +1URGJteFTF7PAaopd99aOjb2WfB4BNgv1okjdUUnWiZYIwiDidNY2FcQy+28WZY4Fcy
         HfQMSgdkaPjKai6hmyWc0yfAA+inMZYat71MbHV2Ty4phFUdWpHNmfahb/+XBRZKQxol
         OA5RlpxvRKZh/ucB7pkIHnQ8qTKgFFI7FvDMGf7R9upw0DGAGDY3+ziTp8j5Eqhw/6pS
         PjqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tgcQWpYvtmoMUF9wgTDko4OITDlrgKk51Rs3CG9w2Tk=;
        fh=1YB2XksteQBUHs7d6WCrCLjBZ63UR712BENzD76GBVw=;
        b=WTGHXIAUkPeXxpLwUR39okszG+Dzk3Oc3HStqDjmCvNmwPgfeyR4Vk9eZWg/LZCbbI
         CkEowpNXZkfLhkU1N45QURxL6Envn6SlNs80X5Ur+spRMNizzfL8mp5DPR5HpFB7raDP
         j/jnUXxDn9TT2nAisFsy6z6zYoLO1BQ1aQgigJ45DiDdCesd47qA9UbGn2Km/nKxZFRc
         b8lTfJkvvcSaQ9hmdjq0nwo1/RV5Vzp1D+iBgY+3TdNr+3pd9DfYR4dV0Sfph7CNA2Ff
         vdVpjcqwlG0TXzytUP83uNgOVWDUqh4ICphWab4Bv/hxZMVaMChAk5APu7ZAB2xmgHBm
         t7vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789616530; x=1790221330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tgcQWpYvtmoMUF9wgTDko4OITDlrgKk51Rs3CG9w2Tk=;
        b=jRkzMI+r6P9dsFTcUWfQw+sw17DM7P4GfGs7NrOpAO3GBuSrfiP8ozNOSx6vjzFxST
         JMdnyZ5eWnRCEUf+SHQJ3sS0Nt4nwoT7EpeSdfG8XAxYyLHnLZWIeJzaop97G6glqye3
         elA1IjyVkmzq4+SidaUdd3U+ucVdTBLFyowPDT/VpOUqoBS+b2ODGlF6SOvocKr+otBq
         LGtl+3QwiDEG3+8IT5NVIU3IZYYBWP/vYdXyhgvW1KUD69EOUiJubzFn8f2M425ZIVkT
         lSkuh1ErUCERwvYDh7tjc0M3ODCMOZnVf01hHt8RJjpTxxTCCpnfwzl6YuamWizG4zan
         nGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789616530; x=1790221330;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tgcQWpYvtmoMUF9wgTDko4OITDlrgKk51Rs3CG9w2Tk=;
        b=JryeHKmnQcYiUEDtCXENeWt836ryJRrflQ63v7kFANuFxO5vRXpdeD+vkyVFHv6naH
         DG5jablUSMml9gkXa9YCJ+7EzaPV1FKuO3IJFvKI5m1S5ysc08Y5DIUrjAD7Hjia8ooi
         G2Mvo8d5M3ToW7deHOZLSmRRqKSvMu0Fn3TBioNemm+DkJT0+q7InrxCL1W2/MAPQnGm
         lNGKG5s+Elk0Dm+by8clXSxSwZaa8pBhx3nif8fu8rvtt8wdJpIh/WXayXBjGOPa1SFB
         PxckaeQElKzHGI/HaEyYrOY4RkqGGUwR3zdTALPLz1RfKCvTcPSpEbRc6E4v9vtlTxJN
         /yJQ==
X-Forwarded-Encrypted: i=1; AKwUvByvg/9HbGnW2m2V90M7XEeB5zw4+4BDZCJZekysuSD7ncRY6zSB8E0En7vRGbAT2i3sTP4RECA=@vger.kernel.org
X-Gm-Message-State: AFuF++nI0brKy9neJpJSEQC5/Cwpoy5hrKhVLMtSBa+815rWAf9k3f0S
	cy/4oLXlcU5Ty44/11iSq3zSOfI++ECMaR6ukRMHD1VijuYhf+y6igPHF8KJ/bH3ptm+DMwpSVE
	QV46cgPz/J0/9CirkMp6R0tKHCzp5SBs=
X-Gm-Gg: AYBFou3smsnG50ZH6uOgh5cErOeMo+TDyFOpELOtNrDIKsut1seRyx/2pyeCSfIM8r7
	mfHqAob0MLktwTcWs8Twj+OcmfDR+RLgDp4l1GNQGnDgJCtS7yRf3FMnL3sjhDXjYV9lt5S05kV
	U3qcdBSXLQMPpeDo3q8YoEcI3vSmb9DGdSfg8y+AS0A1z6dFEY22LQA+IQQbtlI9PNBN2uxUt7v
	2ZqHxQq3k0w4BV7h/mz2DVteODseBlTLMdxB8wdayer9q6MYsXYARuvTR7o5Jib8lUHMNky1r4X
	fkDM/28TzOFKZPVUXwBge80UgTfbZvQNXHTizoOylTXIaNzdQ5yEbyjE/jox416yi2IdChRKjVy
	dJhz6ZDpfpKj5JHxYgwxmvYXbQnUqQiQBVurJdS6ZZFh9LEnQqCVdR7WSM8Oj9OwQo74Yzg==
X-Received: by 2002:a2e:9a0f:0:b0:3a3:61ec:43c7 with SMTP id
 38308e7fff4ca-3a5e73ee380mr3727621fa.24.1789616529905; Wed, 16 Sep 2026
 20:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916124153.43457-1-kerneljasonxing@gmail.com> <CANn89iLB9pRvcz_u+YCDdEzt5G=bgq5=Jk7P_xjgUfF7En-ghA@mail.gmail.com>
In-Reply-To: <CANn89iLB9pRvcz_u+YCDdEzt5G=bgq5=Jk7P_xjgUfF7En-ghA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 17 Sep 2026 11:41:32 +0800
X-Gm-Features: AcwNN1XnXIfnECNgwiKnnIX4GJeLLa0rOIApmw5WWupINA267mV6Bh0OLdSNNLg
Message-ID: <CAL+tcoBLNZkmJrikxKWs0_=idJxnxh9opAugFK6DvMqe8v9b1Q@mail.gmail.com>
Subject: Re: [PATCH net] tcp: preserve timestamps across receive queue collapse
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemb@google.com, kuniyu@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 9:06=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Sep 16, 2026 at 5:42=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > When tcp_collapse() rebuilds skbs under memory pressure, the copy
> > process doesn't include the right tstamp and hwtstamp from the
> > old skb.
> >
>
> Good catch, the problem is real: memcpy(nskb->cb, skb->cb, ...) copies
> has_rxtstamp, but nskb->tstamp and hwtstamps are left at zero, so
> tcp_recv_timestamp() ends up emitting no cmsg at all.
>
>
> > In net timestamping case, if such an skb happens to be the last
> > one consumed in a recvmsg() call, the application receives no RX
> > timestamp for that call.
> >
> > Fix this by copying both tstamp and hwtstamp to the new skb right
> > after the initialization.
> >
> > Fixes: 98aaa913b4ed ("tcp: Extend SOF_TIMESTAMPING_RX_SOFTWARE to TCP r=
ecvmsg")
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  net/ipv4/tcp_input.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 0f60a1dbf927..c5756db892f2 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -5835,6 +5835,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head=
 *list, struct rb_root *root,
> >
> >                 memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
> >                 skb_copy_decrypted(nskb, skb);
> > +               nskb->tstamp =3D skb->tstamp;
> > +               skb_hwtstamps(nskb)->hwtstamp =3D skb_hwtstamps(skb)->h=
wtstamp;
> >                 TCP_SKB_CB(nskb)->seq =3D TCP_SKB_CB(nskb)->end_seq =3D=
 start;
> >                 if (list)
> >                         __skb_queue_before(list, skb, nskb);
>
> However this samples the wrong skb. nskb aggregates data from several
> skbs in the loop below, and you are copying the timestamp of the first
> one, while 98aaa913b4ed (the commit you are fixing) established the
> opposite invariant:
>
>   "When skbs are coalesced either in the sk_receive_queue or the
>    out_of_order_queue always choose the timestamp of the appended skb
>    to maintain the invariant of returning the timestamp of the last
>    byte in the recvmsg buffer."
>
> tcp_try_coalesce() and tcp_add_backlog() both implement "last one
> wins", please do the same here, something like:
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 0f60a1dbf927..81d587654d3d 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5854,6 +5854,12 @@ tcp_collapse(struct sock *sk, struct
> sk_buff_head *list, struct rb_root *root,
>                                 if (skb_copy_bits(skb, offset,
> skb_put(nskb, size), size))
>                                         BUG();
>                                 TCP_SKB_CB(nskb)->end_seq +=3D size;
> +                               if (TCP_SKB_CB(skb)->has_rxtstamp) {
> +                                       TCP_SKB_CB(nskb)->has_rxtstamp =
=3D true;
> +                                       nskb->tstamp =3D skb->tstamp;
> +                                       skb_hwtstamps(nskb)->hwtstamp =3D
> +                                               skb_hwtstamps(skb)->hwtst=
amp;
> +                               }
>                                 copy -=3D size;
>                                 start +=3D size;
>                         }
>

Right, it works and adheres to the same semantics as before. But
honestly I feel a bit strange because using the last skb loses the
latency delta between the first one and the last one. Even though the
delta should be so small as to be negligible.

> This would be the fourth copy of these lines, but let's keep the fix
> minimal for net, a helper shared by the three call sites can come
> later in net-next.

Sure, I will cook it after the patch gets merged in the -next branch.

Thanks,
Jason

>
> This is testable from user space (small SO_RCVBUF + many small
> segments + delayed read hits tcp_prune_queue(), see
> LINUX_MIB_TCPRCVCOLLAPSED); a selftest addition to
> tools/testing/selftests/net/rxtimestamp.c would be welcome.
>
> Thanks.
>
> pw-bot: cr
