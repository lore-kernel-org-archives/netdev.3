Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794212745;
	b=JgrKyKKpQst6ImYRuCN139CBmZ5pFG7LF1PzWcaDcdToMhH30PjtyZMMfZYWC023Wla8
	 SSzlsn2ifhqiR89xmcb3dF7tGNJACq+bsbfsOnyEUB82DxnNFLWPP3xgEGNv5OB/CT2oH
	 ZnDLGNgB92mp0c8692xJN3XDj1DSLi/9kpalbyIcYqpSMocDC207G7dT1JxvRVd+gY/IM
	 oxsmeONVRCSQbC2IhI22zB487lr0WXLYuXGjPomfJlijuaIK2kdNmFbjTaLfHns81j+tl
	 R8n3FZdnChossYYV9Utn9zsNN5oK6gMfimKD32phGnLM1Vgf3F9XKoXKL06Fm5D2ruw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0X4LhfmP/kb8JXQdJU0Iyockx0Jve4fj4xU5jma0V/8=;
	b=vbgUg4oSbz/0scRbaqMYIQfVxb5oLw5SUcwMckdYgnOVp/qZhaLMFid0iEJsnPeFIk6C
	 xaz1Y1hWaz9rKCYoSug6DW9Nd1VP+VhZQA1shlp69xb3ZJzGW88YucL+ts5IG3BcxyInd
	 yoCvgkSbJ04Kd3HxGaEskieBUCUDQz9OPY8GJJXqrG5G4TrwKgyyGLlV047OGDQyZE6eo
	 k72H99IfpVCUkSmYl222pn7RoMLtk67bDHps6NrHLU4Kt0Z4wF8PODFnmv4wgv3HuOTPo
	 zcW/bTIdbh8Bs3kXz6CKL8rPGzR9yHR57vs7YQuhquK/J4ccnsqgqZN9FqBx3rt12lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eCt6kjnM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE6606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 08:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ADE6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eCt6kjnM
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36ff9c9da34so1065399eec.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 00:25:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794212744; cv=none;
        d=google.com; s=arc-20260327;
        b=ZDxZYUFuS7j2Tpl2OmgGTyyRCdHT9MuUwbZRWubo0n5L/3xGmj/0bhiXAAEoAf4aYJ
         TCGJWYe6iiR8C9i0Tm05NBdhbFhAsdgjbfXhttsbpgF47AIXrtRwYZSuaOzG2MgntelZ
         d42CYFdNIzostXqkVdIKHeKRQe1ZKUNEGPCiSqv4YPHxuOatmr54j36eBovOL81L6rzx
         t3CdE1oHlIMVuXq7AcVAAsh7Zj6jH2354TqutJh6AEbM7vMn6iY8RsQCQ2AIfmYVj3Mp
         X1MwanFCR/JJBka4KtX6IPU+4eokvLV0EnRkD6KEyvKLno5Luct0WZ7rBAtDivvM3wGV
         OZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0X4LhfmP/kb8JXQdJU0Iyockx0Jve4fj4xU5jma0V/8=;
        fh=zPcc8iNb8/bCURn2NBq1Itgq5n62yYnYwZZBMFVx97A=;
        b=cKHJ/ECKY8BzqDOrpbXMgzWtDmYoAo7hFzgddM5veT0e2ZIiof8PjFWmB8h1lR569O
         hpGd3fkzF+NcLIIiti6wqp1L54Mz+tDXEvcD2JkCIaR8BNyOwDn9phKPpgomDPoC+Eru
         IguZNkcY7P5IEfRAMUZTsq1RANn8S3+J0KvhATUoqaMGsa7IzEn+nUM6PZtT/ZxgBY0g
         aCU9/HXNeBj3Esp30ym8cmA+HiM/77GZrqCiCeGgoIg6WDaJ4WEMo1wzQ0cOXph0mwS+
         x5+e0AugJqsl0YagFcNQo+BBumyveLOBimQlZnAzPk3AG87kYn7XhFrsqB4VZF/HeH8J
         spXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794212744; x=1794817544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0X4LhfmP/kb8JXQdJU0Iyockx0Jve4fj4xU5jma0V/8=;
        b=eCt6kjnMpDgG1ATD22usmrbzNUIUJfC4+/3SSzvAnI0ltHHz2VtJgZYny9zPt6p6Cf
         VmEMQhU+zbc9ggs/CYP2QkM8fWx+Te2VDOAJq9LN6MZR55qN/5Z+2OjIPsy7ZF9QhYlq
         VMsqj86BaopIctP72SraDac9FY1MdhSuijcv0NrK+BZ6Jg3e7fG83wJOSugK2LRK5uQn
         6SohutqnizbdfYf1KCSZM3Tq2d8XsCXvzXCrVMIXJcXnoUC1vUKCZ0OxKWL/MDd2dTaR
         DOhsDYVpIn1/2Q2RzSfjnaaeWno5AmjoNNhOCfr3qkg3cJic2KvoyL87Shn2Y4CNhyra
         wkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794212744; x=1794817544;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0X4LhfmP/kb8JXQdJU0Iyockx0Jve4fj4xU5jma0V/8=;
        b=NSGLEgJSpOlMsvvBd/CKnNpi4y96/usk3YdHeGOXv9i+QBR8I1xHvvqoYG5R5eHYUj
         c6/G6P9UY6/N2Yq1oUYX5Jzx4M6fsADcz6ioM28sFFtpSYdFYYtPvug6nq6eGvxizjve
         QWe0ZZ5b/1X229gdPx7DhOyGVMb2ZJwFnPwQq+Q0nnASEGUJDsB3cIAF/DAKx5Y31eWS
         nOuKOENYu9SrhsiBaZjYjxALe2z1h47RUQacatfvWHG36ulE9IEnpWnRTS3wVqQ9iu6O
         ZngzNDjSP141GBQtbzye7GICQ2LTDLyjML0swfL307E2nUUlXfhRmPX8eZs0xIHEeIDi
         VbNg==
X-Forwarded-Encrypted: i=1; AL+hErENukD8bqcpy0CF8wEO6wgxIL4oiakVEr68w1Ozyvbt7FJ7kxhJaOLYWN6pqWQVIfjCBjcOvCI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zQy4gU5IUScA4T1PTd1pIumdZWkIMARsZZSbadKeRR8ZlnBed
	2hE/mmMQvknYJhyWn14NseKpw1T0Rp1KoQJKTbRD0/0LD2hy0DL7L6Vc3kJ+qynwBXH0oud9lfL
	n9yJ044YPMHBR++MsNN8TUArdMjFlwcg=
X-Gm-Gg: AYBFou2Gz3vCJp0ZDn7X1+4r7YNyjgbvNkxQwzbYSeTJ66LCGm0Hx6jfM0/qSomOVu8
	RHfbuHfoJC9apxmt/Eq/HtQcTmg6co6ruej5aszbycu+ETvMNB2e6k3Du/JfUO/LMTZV6AQCvBV
	QvAewOWWa2IZxSDHh1oPq6whGJGmIy1SfNyeYN+pFEIgy+/8hk3thIUPNaMhwsmlVT/E5/a0wEQ
	+gbImQ+DMljm1Xuya+MrVutEyaDLU26ddG8bDt2QoVKQnTjXRyngsl4DweRY+G2JfNrk3RUmmdY
	/LjRGliilyDlWKNa6N+gBpBIQhth4qz/OzOxDsfeOfKkr9WemLO3oP2f6ZLqBAdjERhFaKjbQcn
	XMP6GQIe7i+saKRfyabaF3tee2lq8Of3oxndGzjspWu5g3+WtY3evlAqoscnFiJUmNMm9
X-Received: by 2002:a05:693c:8941:10b0:36d:f004:ae6e with SMTP id
 5a478bee46e88-372571d8680mr6442806eec.34.1794212744367; Mon, 09 Nov 2026
 00:25:44 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108074733.248784-1-hj351016@gmail.com> <179421246928.994134.4691531527341185507@kernel.org>
In-Reply-To: <179421246928.994134.4691531527341185507@kernel.org>
From: khj <hj351016@gmail.com>
Date: Mon, 9 Nov 2026 17:25:31 +0900
X-Gm-Features: AclHuK9eAUiDtMPLiXAXqngFp10UUm9BXsLJcVw65tcB1NHPhojqGG_5DdAb4cA
Message-ID: <CAGr5VtOkBt1duzjEMtgP-0OUiuxRzfTDz_BC9K=uuZtrK0ZLfQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ti: icss-iep: fix deadlock when disabling PPS
To: netdev-bot+sashiko@kernel.org
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the careful review =E2=80=94 both are fair.

On the [Medium]: agreed. Draining outside ptp_clk_mutex is what breaks
the deadlock with icss_iep_cap_cmp_work(), but it does weaken the
enable<->disable serialization that the mutex used to provide, so a
concurrent sysfs enable can now race the disable's drain as you
describe. The deadlock and the ordering are in tension and a clean fix
needs a small restructure rather than just relocating the
cancel_work_sync().

On the pre-existing [High]: agreed, and thanks for spotting it =E2=80=94 it=
 is
a separate bug from the deadlock this patch targets. icss_iep_exit()
unregisters (and can free) the PTP clock before the perout path is
torn down, and icss_iep_perout_enable(off) never drains iep->work, so
a late icss_iep_cap_cmp_work() can reach ptp_clock_event()/pps_event()
on a freed or NULL iep->ptp_clock. That deserves its own fix (drain
the work in the perout teardown path / order the unregister after the
disable), which I'll send separately rather than fold into this
deadlock fix.

Since this is hardware I cannot test (am654 icssg PRU) and the clean
fix touches the PPS/perout teardown and the ptp_clk_mutex discipline,
I would appreciate the maintainers' preferred direction before I
respin =E2=80=94 in particular whether to re-serialize the
enable/disable/drain differently or to move the drain into
icss_iep_exit()/perout teardown.

pw-bot: cr

2026=EB=85=84 11=EC=9B=94 9=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 5:21, <=
netdev-bot+sashiko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 (1) =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] This patch moves cancel_work_sync(&iep->work) in
>   icss_iep_pps_enable() out from under ptp_clk_mutex.
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it is a use-
>   after-free / NULL dereference in the teardown path that the new guard=
=E2=80=A6
>
> --
>
> net: ti: icss-iep: fix deadlock when disabling PPS
>
> This patch changes icss_iep_pps_enable() so that cancel_work_sync(&iep->w=
ork)
> runs after ptp_clk_mutex is dropped. This avoids a deadlock with
> icss_iep_cap_cmp_work(), which takes the same mutex. It also makes
> icss_iep_cap_cmp_work() return early when neither pps_enabled nor
> perout_enabled is set.
>
> > diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/eth=
ernet/ti/icssg/icss_iep.c
> > index ec085897edf09..3b2a88c2dad88 100644
> > --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
> > +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
> > @@ -534,6 +534,17 @@ static void icss_iep_cap_cmp_work(struct work_stru=
ct *work)
> >
> >       mutex_lock(&iep->ptp_clk_mutex);
> >
> > +     /*
> > +      * PPS/perout may have been disabled (and the compare hardware
> > +      * cleared) while this work was queued or waiting for the mutex.
> > +      * Bail out rather than re-arm CMP1 and emit a stale PPS event on=
ce
> > +      * the event source is gone.
> > +      */
> > +     if (!iep->pps_enabled && !iep->perout_enabled) {
> > +             mutex_unlock(&iep->ptp_clk_mutex);
> > +             return;
> > +     }
>
> [Severity: High]
> This is a pre-existing issue, but does this check cover teardown when per=
out
> is enabled instead of PPS?
>
> icss_iep_exit() unregisters the ptp clock before it disables perout:
>
> icss_iep_exit() {
>         if (iep->ptp_clock) {
>                 ptp_clock_unregister(iep->ptp_clock);
>                 iep->ptp_clock =3D NULL;
>         }
>         icss_iep_disable(iep);
>
>         if (iep->pps_enabled)
>                 icss_iep_pps_enable(iep, false);
>         else if (iep->perout_enabled)
>                 icss_iep_perout_enable(iep, NULL, false);
>         ...
> }
>
> Inside ptp_clock_unregister(), ptp_disable_all_events() only sends
> PTP_CLK_REQ_PPS. icss_iep_pps_enable(off) then returns -EBUSY because
> perout_enabled is set. So CMP1 stays armed and the work is never drained.
>
> ptp_clock_unregister() then unregisters ptp->pps_source and calls
> put_device() on the ptp device, which can free the ptp clock. After that,
> iep->ptp_clock is set to NULL without holding ptp_clk_mutex.
>
> Later, icss_iep_perout_enable(iep, NULL, false) clears perout_enabled. It
> never calls cancel_work_sync().
>
> During this window icss_iep_cap_cmp_irq() can still queue the work.
> icss_iep_cap_cmp_work() gets past the new check because perout_enabled is
> still 1, and then reaches:
>
>         ptp_clock_event(iep->ptp_clock, &pevent);
>
> For PTP_CLOCK_PPSUSR, ptp_clock_event() calls pps_event(ptp->pps_source, =
...)
> without a NULL check. Can this touch a freed pps_source or ptp clock, or
> dereference a NULL iep->ptp_clock?
>
> On am654 with icssg_prueth (clockops perout_enable), this looks reachable=
.
> Enable perout with PTP_PEROUT_REQUEST, then bring the interface down, whi=
ch
> goes through prueth_emac_common_stop()->icss_iep_exit().
>
> [ ... ]
>
> > @@ -607,7 +619,7 @@ static int icss_iep_pps_enable(struct icss_iep *iep=
, int on)
> >       } else {
> >               ret =3D icss_iep_perout_enable_hw(iep, &rq.perout, on);
> >               if (iep->cap_cmp_irq)
> > -                     cancel_work_sync(&iep->work);
> > +                     drain_work =3D true;
> >       }
> >
> >       if (!ret)
> > @@ -616,6 +628,15 @@ static int icss_iep_pps_enable(struct icss_iep *ie=
p, int on)
> >  exit:
> >       mutex_unlock(&iep->ptp_clk_mutex);
> >
> > +     /*
> > +      * Drain the capture-compare work only after dropping ptp_clk_mut=
ex.
> > +      * icss_iep_cap_cmp_work() takes ptp_clk_mutex itself, so cancell=
ing it
> > +      * under the mutex deadlocks against a handler instance already r=
unning
> > +      * and waiting for that same mutex.
> > +      */
> > +     if (drain_work)
> > +             cancel_work_sync(&iep->work);
>
> [Severity: Medium]
> Now that the drain runs outside ptp_clk_mutex, is the disable still order=
ed
> before a following PPS or perout enable?
>
> The chardev ioctls hold ptp->pincfg_mux around ops->enable(). In
> drivers/ptp/ptp_sysfs.c, pps_enable_store() and period_store() call
> ops->enable() without it. That means a second writer can take ptp_clk_mut=
ex
> between the mutex_unlock() and the cancel_work_sync() above:
>
> CPU1                                  CPU2
> icss_iep_pps_enable(iep, 0)
>   icss_iep_perout_enable_hw(off)
>   iep->pps_enabled =3D 0
>   mutex_unlock()
>                                       icss_iep_pps_enable(iep, 1)
>                                         icss_iep_perout_enable_hw(on)
>                                         iep->pps_enabled =3D 1
>                                         mutex_unlock()
>   cancel_work_sync(&iep->work)
>
> Two outcomes look possible.
>
> In the first, a stale work item from the old session gets the mutex after
> CPU2. It may have been queued by a CMP1 IRQ just before the disable, or i=
t
> may already be waiting in mutex_lock(). The new check in
> icss_iep_cap_cmp_work() only looks at the flags, so the item gets through=
.
> It reads the new start value that icss_iep_update_to_next_boundary() wrot=
e to
> CMP1. It writes start + iep->period back, then reports a PPSUSR event for=
 an
> edge that has not happened yet.
>
> Would the first pulse of the new session be skipped, with a bogus timesta=
mp
> sent to userspace?
>
> In the second, CPU1 is delayed until the new session's first CMP1 match.
> icss_iep_cap_cmp_irq() queues the new session's work, and CPU1's late
> cancel_work_sync() removes it before it runs.
>
> In the non-clockops path, this work is the only code that advances CMP1 b=
y
> iep->period. icssg_prueth_sr1 is one example, since it calls
> icss_iep_init(iep, NULL, NULL, 0).
>
> Could PPS stop for good here while pps_enabled is still true?
>
> Before this patch, ptp_clk_mutex serialized the disable, the drain and th=
e
> next enable.
>
> > +
> >       return ret;
> >  }
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261108074733.248784-1-hj351016%40gmail.com
