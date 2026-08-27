Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D653F1040
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787860964; cv=pass; b=d3hTJ7uQcnN6g3OoFGBu2IxkRmU3F6m3wCP7Eysy5wvihjPrEwAjNMrUlAwXm9Qxjhft1tHUMSc9Mx8Qbpf2qM5GswP6MviDubYidYaZlcWLmoSqDwAvBVfMiu9+QcmfQCRYViOEPuigIGJ3eVdH/Jy1VXjwqWS1r0bdqkkgOKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787860964; c=relaxed/simple;
	bh=Gygare9T6CERZXPoIwluERpWehdX4GdG0W9M12E7ZO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDdr5uMNs7M9QpDCXUxQ9t53UVnusT3qwUQGsGiFP4zdlCSaYB6Wa4HtbC3ivwEE1nc+Z8lyhAoE+Y3L3o4ZCUlfVgQFJ/k9ADJxOQYBxJRVVlx/okyAc2qTSAI5seqvwteHpn6d/7AYQqCmPdRiWcPd96x5JDgDYhkSVaGJw1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdctvGZJ; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdctvGZJ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51bfad59921so2362761cf.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 13:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787860962; cv=none;
        d=google.com; s=arc-20260327;
        b=A58bO6v7EGmyiwLeZrvr/+UUJODef0Axb6IEoYHSOAqR4KgaNV1nZ1iz18EmWbYhXO
         H2yGoM0o/rey05+gPiZMhid8OzwnhRN5pUzDn+8x29KBVh8brm9t5kRtRw55Z+rleTWA
         9JI97KsvLZvn4w24hthkcNwSzXMDCvBH57LbaK84Q/EQ5v+TsMkpxOlPFQIwXmTbXapO
         vW0TANMqjBC/dBXvLe3JxF3aKOXS0dotl5uMb3FHivwJUF6nWwRT/r5iicDRUn10nrt6
         kj2+WuX9oJ28P1By+dl1ai31vI6Y4NtODAc0nfpmhhJvg2rQSTdZ4P7/cxk+wphRNlj8
         DKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VO3Vl8WbPYlIIMqC8oegKtFGuaQbaHs/G6Gq2j3nKbM=;
        fh=D+6VCgrs8f40IqRV65XLAe44vxwmA+Ap+hcZSo/U5fw=;
        b=NrEbnFHtP4rAbcfKDXhskyaoZMpFnn46Ej1NGwnJpXXzj6AmwG6d03jFF14EhWfAxL
         EOErDged/wmHpwTkGsOGfSqchQCcTr8zp2QDeDisQuZ2ZWucrkMwu86lTiDBUrTUhqm9
         gFr8ERlyX1n1RcZfzFEP7mkq9Ajrf0aOYKW1sMxTS7rDSAr8zA72n3uW9L0YMlKmxypP
         n8PXfHT7wTcs/1OVNch7cVbJxgQ8qMvw7LOnrYbP5tyX7tO46VTQ0N/kHgEDmrXyBRyo
         N5WAdkjFB+9Tpw1leUROWaRFYc+uNYsZ2eZPEQOAivQ35IyeM6TQtx3NJ1jeyEgeFxBU
         0uNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787860962; x=1788465762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VO3Vl8WbPYlIIMqC8oegKtFGuaQbaHs/G6Gq2j3nKbM=;
        b=gdctvGZJOcwytpjQbiiS6ygUe+sZxztzCX7XiTmZxCQRV26W4WyKxN3lmC/taCi3vj
         m7erKSsuIFAw76ac2ILKuuPdqOevthTZ3srFEbeBoKdiZcf1K+FTI87Jt5Qe67E5LfmK
         oEvZIq3pYsrn5z5WVxE8+8DR13dXedu/mWaz+RsaGMmgvAFVjisF0R+xt1e5EvRkFB/r
         wIo6qK8l4WJZU+7ufeu10pGeqpSZy2E75KBdKnlaV0Gn5ejicg3H53s5la5dM6Yssq7U
         GazoLfO9lMVUcvBkMRjJICkdKIkeU+iJDvjzncRQzLDIMGqXbDjths5HLWxa9Dw2tcsb
         tJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787860962; x=1788465762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VO3Vl8WbPYlIIMqC8oegKtFGuaQbaHs/G6Gq2j3nKbM=;
        b=EA7AcmUrFSee2bg/fVZgZPXL+9j90ZjTIfyVE0olSwoXRViD9wCbtrhPv+Jt6m5u8H
         KFnzL2IOjQrcgJZhs3DSN7US7yvr2Yl4Ka60AFZf6UlX4YEfpfvrq0AJ0QB80bfuXf+8
         B1iFQEhAVc4pxL1hR5pNGoHNNTsacfrPZiUyiWAZvRSH3h3l1R4juyI9snI6GV6qQIkL
         38PoeEDlNsIj52mkyo72btJ/fj0y4Mni70yjhfuDEI/cpC2LVwD5QmLLnT6SyDVnVCXE
         Up9jqC+DtQJ96NFkMOfFJAifQS0iXLE1IdI4B4lbj93maO/HSPwb9rGbtKO3zuHa02r1
         aHhQ==
X-Forwarded-Encrypted: i=1; AHgh+RpOPI6mKZKIwT7IQwhs84jLBdYNDOXeD3nbA4EUwEnMXrpQz52W2RenvVgZ7vdMz4sM4zWASQs=@vger.kernel.org
X-Gm-Message-State: AFuF++kdZdUUjein3q2JREohtyKUCazPmAyMZeXoH7Nhc0zr3nvdXYG/
	L0QnEvLY3PFqmCf/eyR6FrhKkDOfesLAyENG0AwHFLPSTyv6J8z2XUHu81FBJydPZ9W2cH417Dh
	oTbTskgTBf5lW8jT62n3MfTJ+ls+2yGMdC+lgCjpF
X-Gm-Gg: AR+sD12AQQ3qLggrWKewgQioaAZPj6Lv/Cp9EL4WlXgLnGMH7el2YdyDrJqWHsdIdrZ
	354lt6gUYU7RT9K8Ugu4CfMZE/Oy94vJUERn/P8AjZ+bqynPEVRC73ACJLfLpzdVioMcIXk4jNg
	oyCArcfPyJPCCsf659sH9ZHDpcNhf4DUkgL1NFUhGCAhoD71i5j51ybElhRiGf3w3czEWRhNGjJ
	U4Abcn7g8DEj/Ya7lVEcQKKjRsjGjs7Bq+lLgPafWPzqt0PHcoybkKP2Zbu15GZg/n9brC8OMBK
	CKHHa36j6zHMXMx/YM7U5VrmVtl/0Defv6jzcLR5dhoDVq+vMCtISUEBgDTiTnej39ckBnPK+Xs
	8qqwU+X0Duk1VBIG5PcHc4dLEM1bmLAEM9zD9m/3WS+AMZwFsIU8MzMwIg4rk
X-Received: by 2002:a05:622a:5592:b0:52e:12e8:54f3 with SMTP id
 d75a77b69052e-52fb93b34a9mr25288261cf.8.1787860960890; Thu, 27 Aug 2026
 13:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826103711.3302915-4-edumazet@google.com> <20260827194259.4022994-1-kuba@kernel.org>
In-Reply-To: <20260827194259.4022994-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Aug 2026 22:02:27 +0200
X-Gm-Features: AcwNN1VvRZ_v_Af8sNRO3g8UUz57s_VMKiTswrTT9tGvDexdzZLVGPhnaHeCNsM
Message-ID: <CANn89iJmape+9Nkf=U2vjydp89UPLvoyGh6wPusMFE_yLUoUeg@mail.gmail.com>
Subject: Re: [PATCH net 3/5] ipv6: mcast: fix delay calculation in igmp6_join_group()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 9:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ipv6: mcast: fix delay calculation in igmp6_join_group()
>
> igmp6_join_group() reused the remaining expiry of an already scheduled
> report work as the new delay without bounding it. The patch initializes
> delay to unsolicited_report_interval(ma->idev) and re-randomizes it with
> get_random_u32_below(interval) whenever delay >=3D interval, matching
> igmp6_group_queried().
>
> No Link: tags present in the commit header.
>
> Only the changelog wording looks questionable to me; the code change itse=
lf
> reads correctly, so the diff hunks are omitted.
>
> > 1. If the timer has already expired (timer.expires <=3D jiffies),
> >    ma->mca_work.timer.expires - jiffies underflows to a very large
> >    unsigned long value (~ULONG_MAX), causing mod_delayed_work() to
> >    schedule the report weeks/months into the future.
>
> [Severity: Medium]
> Can mod_delayed_work() really push the report weeks or months out in this
> case?
>
> The delayed work layer converts the delay straight back into an absolute
> expiry in __queue_delayed_work():
>
> kernel/workqueue.c:__queue_delayed_work() {
>         ...
>         timer->expires =3D jiffies + delay;
>         ...
> }
>
> With delay =3D=3D expires_old - jiffies_old, that modular arithmetic give=
s back
> expires_old, i.e. the same already-past expiry rather than a near-ULONG_M=
AX
> value.
>
> __queue_delayed_work() then calls add_timer_global()/add_timer_on(), whic=
h
> end in __mod_timer(timer, timer->expires, ...) and calc_wheel_index():
>
> kernel/time/timer.c:calc_wheel_index() {
>         ...
>         } else if ((long) delta < 0) {
>                 idx =3D clk & LVL_MASK;
>                 *bucket_expiry =3D clk;
>         } else {
>                 /*
>                  * Force expire obscene large timeouts to expire at the
>                  * capacity limit of the wheel.
>                  */
>                 if (delta >=3D WHEEL_TIMEOUT_CUTOFF)
>                         expires =3D clk + WHEEL_TIMEOUT_MAX;
>         ...
> }
>
> A past expiry takes the (long) delta < 0 branch and lands in the current
> bucket, so it fires at the next tick; the WHEEL_TIMEOUT_CUTOFF capping
> branch is not reachable for a delta that is negative when read as signed.
> add_timer()'s kerneldoc says the same thing:
>
> kernel/time/timer.c:add_timer() {
>  * If @timer->expires is already in the past @timer will be queued to
>  * expire at the next timer tick.
> }
>
> So for case 1, is the actual symptom that the randomized delay is lost an=
d
> the second unsolicited report goes out on the next tick, right behind the
> first one, rather than a report deferred for weeks or months? The stated
> symptom implies dropped membership reports and multicast traffic loss, wh=
ich
> reads differently for anyone triaging this for stable.
>
> Case 2 (a delay inherited from a query with a large maximum response dela=
y
> exceeding unsolicited_report_interval()) matches the code, and the clamp
> added here covers both cases either way. Could the first paragraph be
> reworded to describe the lost randomization and the reuse of the stale
> expiry instead?

OK I can rephrase the changelog to:

1. If the timer has already expired (timer.expires <=3D jiffies), the
   stale expiry is reused by mod_delayed_work(), causing the second
   unsolicited report to fire on the very next tick without a
   randomized delay.

2. If the timer was originally armed by a query with a large maximum
   response delay, delay could exceed unsolicited_report_interval(ma->idev)=
.


Hopefully, all the AI agents will be happy this time.
