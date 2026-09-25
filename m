Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8253CDBA5
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356563; cv=none; b=vFR0teQ3S3N/0d8Y9bxLTpS3NXBnXk13Hd3hQyhHtVE/uxpsdrtF856Onnev7XuweGxPgd/yNkF+Q6LI9QGubPTAq3OPLvIH/K6JRRlCtIfAqkC3o7S6Y53KNYcTOyHHoW0RqHxhoBcubs3igBiUZiGy4mFzTNHd1C41bQZBzc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356563; c=relaxed/simple;
	bh=rFSkYHB4lyS3eIWpQyb146mLPvlUYVAg7QLlUkudVxU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=toKvGfPgrg+rgSMr4LyJ2+pNJPhQRuhDRZsFxeCFTXSQfZDkcFIfpbVboLU54fSn53hBQuDesrtRYMSxnMCkMdGQNo2XiOZ5xWjTSa5+rqTPbO9TcdclcoDyjLBqI5Wz05MhAqs6UG7jDWo1HF5j1K6gXdT9M1nIG25A17NA+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfAKA2ZD; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfAKA2ZD"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43f9b11bso10098757b3.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790356550; x=1790961350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TXfpsWTZuW18RFLObSNzJihnyZpsn9pCdpzwIU0PHd8=;
        b=UfAKA2ZDdyzQpsOsy0NnCocVcs2Xz6PpNn+aA5HXqo7PYJSgWLn9WLZ2zdi+YzlMTo
         YMdF0xE6cwEOsGarBtjtlS1tq4WHasy77PPij72mqboqaKEDc/qcSvg6FBRmd2xtiU0y
         caEZF9mZ3gN38YGarCBC1YLV+dCw1yRQVt8t9t/fLRQ1dVu3/dr6agApiJpqyh6q15wN
         hPSuZHVmBHZmZ9EgMoMJ7UW7Yp8qxxZK4fV9Xklx8y8tDQ5Q7XxXnpiG7fLPaHWHGN1Y
         pTmTgdLXwWAJH8bAxGdqm5uBRuhIzOXR0VrYN7KO6UxQNKuyrwW3Zgh5Fq0KCJDgeJIx
         0L2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790356550; x=1790961350;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TXfpsWTZuW18RFLObSNzJihnyZpsn9pCdpzwIU0PHd8=;
        b=WqttPnwBCgFg5ASzwnool+H9VYnNPHtknlkuln3+yvVCn71VYm58dAFmLozosCTVup
         Lrh6ZXHnt4uSaRQ3RJLnPtUPlroQFeTAdNLQCQ63BIc6kKfuY7vpmRhNxOa42tyIxGhY
         +iNcrp75kIfgXtmBIxnfBehilVgTKu8cvv7a0kz+PQ85wyaix8e5k/gcyl0sE8bNZP80
         V0P61zDiRAu4Q25PScD/XaJmHal8l0S92dLZQfMnAuUZwqkaMUfsGPK1UJ6U1Qp1YoM4
         X0snhHZRd2jyFcgG/7o0XFR8h5A9bDv36ouC7S50Ut+VeJ3F/i5PVnYy41g12Dk5/7Zl
         eZCg==
X-Gm-Message-State: AFuF++kSKReElhv3E1iY+fcyFycVW+zYkWyMACLVeQ84gooSD0WVvC3S
	4pxlmFOYN36PfWbAUAG4FASI1zs1DswfY0qbI6loaqmunk2Xk64pL6HM
X-Gm-Gg: AYBFou1ZdYWcyWJC1WL6tQiXuhc8kheC6dCD7O8W8bvHQK5QVf46nOIMZnQg1CLeFVk
	TAD9Kgu74oe4i4lHtExdeqeyXzhRs5edOimpM2Bzibu94l0zCxN5edNmVRgVpz13eM2dctee4CP
	pUYFWOw29S+NiUCBvA+mHjrugjr21jAlIrx8YljOCWUT33irchbsq6NNdoi/uxcUZbhfGEWUY45
	hP/LFQLqf9DCmeNnHo+G8wWiWHRmSefoCd/HA0NAwXwL2BG7NQ846ZRcNzbDyl7ER7S3wWbLke/
	LSpsU1Fzd4Kxzmr6PfKIT/oxoM+8EjJILKxJ54vDg/GVItdaAJiwVhp0M7UoyEkWvMgQ4Po+WC0
	8t1LTG/rrGVK6DCVGU17SDD0h+mi1Eo2UrtR60PbJS1QkrCbpTX+JP1OLWlVmZnYLzbnIdlCWlb
	Pnb5EXNhrWlEnC/E45lLiicPp/G3q00Is0+RCodL3nUqd6A1L/ztawGnWRgqHvBURn4a8hATfDn
	LfCqB7RgH1lzPRZJxaV70zlQ3aEOXZw+G6H7NkyUrrb+gn8SaXjqpLUrJFkWTg=
X-Received: by 2002:a05:690c:6e81:b0:8a7:91f8:1e82 with SMTP id 00721157ae682-8a791f82ba9mr23144447b3.94.1790356550491;
        Fri, 25 Sep 2026 10:15:50 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a861064448sm11276357b3.47.2026.09.25.10.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 10:15:49 -0700 (PDT)
Date: Fri, 25 Sep 2026 13:15:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 clementwei90@163.com
Cc: netdev@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 weirongguang@kylinos.cn, 
 kuba@kernel.org
Message-ID: <willemdebruijn.kernel.e57431dca72e@gmail.com>
In-Reply-To: <179027275318.2160803.4185895144088175048@kernel.org>
References: <20260923025653.59348-1-clementwei90@163.com>
 <179027275318.2160803.4185895144088175048@kernel.org>
Subject: Re: [PATCH net v1] tun: fix inverted error check when re-attaching
 the filter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> =

> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
> =

> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchw=
ork
> know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> (one such reply per series is enough).
> =

> - [Medium] The re-attach path that this patch enables rebuilds the queu=
e
>   filter from a stale userspace pointer, and reads it in the wrong=E2=80=
=A6
> - [Low] With the check inverted, a successful sk_attach_filter() in
>   tun_attach() (drivers/net/tun.c:755) no longer returns early.
> =

> --
> =

> tun: fix inverted error check when re-attaching the filter
> =

> This patch inverts the error check after sk_attach_filter() in
> tun_attach(). A successful filter re-attach now continues on to publish=

> the queue, and a failed one aborts the attach.
> =

> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 5a302709a68aa..09720883b9a10 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -754,7 +754,7 @@ static int tun_attach(struct tun_struct *tun, str=
uct file *file,
> >  		lock_sock(tfile->socket.sk);
> >  		err =3D sk_attach_filter(&tun->fprog, tfile->socket.sk);
> >  		release_sock(tfile->socket.sk);
> > -		if (!err)
> > +		if (err)
> >  			goto out;
> >  	}
> >  =

> =

> [Severity: Low]
> A successful sk_attach_filter() now falls through. If a later step in
> tun_attach() fails, can the filter stay attached to a socket that was
> never published?
> =

> After this point, tun_attach() can still fail here:
> =

> 	if (!tfile->detached &&
> 	    ptr_ring_resize(&tfile->tx_ring, dev->tx_queue_len,
> 			    GFP_KERNEL, tun_ptr_free)) {
> 		err =3D -ENOMEM;
> 		goto out;
> 	}
> =

> It can also fail in xdp_rxq_info_reg() or xdp_rxq_info_reg_mem_model().=

> None of these error paths call sk_detach_filter(tfile->socket.sk).

This is a real point.

This patch fixes the intent of the original patch by inverting the
check.

But the state change should also be reverted if tun_attach fails later
on. The only similar example is xdp_rxq_info_reg further down, which
does get reverted if xdp_rxq_info_reg_mem_model fails.
 =

> By comparison, tun_attach_filter() rolls back when it fails:
> =

> 		if (ret) {
> 			tun_detach_filter(tun, i);
> 			return ret;
> 		}
> =

> The fd can then be reused. One way is to retry TUNSETIFF with
> IFF_NOFILTER, which sets skip_filter and skips the re-attach block.
> Another is to attach to a different device that has no filter. Neither
> clears sk_filter, since only tun_detach_filter() calls sk_detach_filter=
().
> =

> tun_net_xmit() would then apply the leftover filter to packets:
> =

> 	if (tfile->socket.sk->sk_filter) {
> 		drop_reason =3D sk_filter_reason(tfile->socket.sk, skb);
> =

> TUNGETIFF would also leave IFF_NOFILTER unset, even though it was
> requested.
> =

> The commit message says "nothing is published at that point, so the
> attach can be aborted cleanly". Is that only true when sk_attach_filter=
()
> itself is the step that fails?
> =

> [Severity: Medium]
> This path now installs the rebuilt filter on a live queue. Is
> tun->fprog still safe to reuse at this point?
> =

> TUNATTACHFILTER in __tun_chr_ioctl() copies only the sock_fprog header:=

> =

> 		if (copy_from_user(&tun->fprog, argp, sizeof(tun->fprog)))
> 			break;
> =

> That leaves tun->fprog.filter as a __user pointer from the process that=

> issued the ioctl. On a persistent device, tun->filter_attached stays tr=
ue
> after all queues are closed.
> =

> Later calls reach the re-attach through this path. That includes
> TUNSETIFF without IFF_NOFILTER, and TUNSETQUEUE with IFF_ATTACH_QUEUE,
> which always passes skip_filter =3D false:
> =

> tun_set_iff() / tun_set_queue()
>   tun_attach()
>     sk_attach_filter(&tun->fprog, sk)
>       __get_filter()
>         copy_from_user(prog->insns, fprog->filter, fsize)
> =

> That read goes through current->mm. The caller may be a different proce=
ss
> from the one that set the filter. It may also be the same process after=

> the instruction buffer was freed or remapped.

This is a very good point.

It is a separate bug from this one, and should be a separate fix.

The BPF program should be copied into the kernel immediately if it
can be attached again later.

But, as the below text explains, flipping the test may now fail
TUNSETIFF because sk_filter_attach fails, where previously it would
continue since sk_attach_filter error is expected (even if it did
complete without the filter installed as intended). Ideally, both
fixes are sent together, but I won't hold anyone to that.

> =

> Before this patch, the rebuilt filter never ended up on a working queue=
.
> When the re-attach succeeded, the queue was not published. When it fail=
ed,
> the queue was published without a filter and TUNSETIFF returned 0.
> =

> With the check inverted, there are two cases.
> =

> If the address is not mapped in the caller, TUNSETIFF and TUNSETQUEUE
> now fail with -EFAULT. If the bytes there are not valid classic BPF, th=
ey
> fail with -EINVAL. Does this mean a new opener of a persistent TAP with=
 a
> filter can no longer attach unless it passes IFF_NOFILTER?
> =

> If the address happens to be mapped, whatever bytes it holds become the=

> queue's filter, not the program the administrator installed. On a
> multiqueue TAP, could different queues end up with different filters?
> =

> For this re-attach to work correctly, would it need a kernel-owned copy=
?
> That could be a saved copy of the instructions, or a refcounted struct
> bpf_prog or sk_filter.
> =

> -- =

> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20260923025653.59348-1-clementwei90%40163.com


