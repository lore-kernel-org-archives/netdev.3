Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F603C3C08
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955748; cv=pass; b=AFdXZeb6NsM8AyteyPSRNk0VKrtIz+JSNyBABTp3KwI6ZWN+wazYvWOPS6ne/qa3tqBuIgSiYpBo95D3Mt3FKVg89CXWPeDiZ/14OD1v5cPldRjM/x09TdDeVnItbMqJLY3P87IXWT6Lvm8QiiRbWp9hvASBY+Phf0vPMwpjZqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955748; c=relaxed/simple;
	bh=CoQ6Hcuqgf3aCQcWhWd6TjBtEb+4REkggXIv2QT2+rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcnUfPIo7x7lI/+mY0rmjoSlv3tdZnhBacZAEEoX3tkr+ei0CKEz4pQ/OOTxcbMnQ9yfxLQlYvG1aj03a++ZM3llT7StQPl2qPaTXSWqmaeEfzcvcR5Khb96pgNRXqDq9KFm49g+6C1VORRatOHQ2BOMDU+X+psj8DkMP86RMPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRIJ53cn; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRIJ53cn"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51bfe810293so14074251cf.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 01:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786955746; cv=none;
        d=google.com; s=arc-20260327;
        b=Jmp3J60g65ffBQUlKFakacED36dB+yMFMZrDFg2uSUnb1xmGj5W/Usb0rwYHeGWBfb
         eyi8TZHdGfFh8pWDRyOJ522+b3qR9ADV1SWY2EGxByY7YyKYTZwoAAkGumH7amySKCHd
         qSqIjx0tfN4xgdTdYrAP6cVsldG8rEZoDEYv17VoJXcuBTHkT9rn6pf3FZJngXIoVPt2
         gLN+IcwysU1JCvUQshEuzwaA655fbXI6i385u+MbjTyEcA/9g6BdPN8lDiiNsJ3nEoqi
         OdumZVyPxebMrv7YBxz2jAzKOBW9uZwdHp0ZybTI09LQeiSkH6ftGUoW/0+1LiBVY9pH
         7QNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e7QRgvBPWorozfbbvrTmoZ8vIJPGMLAmMOzYAjtKsiY=;
        fh=S1BetJuiZzG69JYZOLmz1wMohXBi8Il0wtfuoAgf9FE=;
        b=eBHeKFHn+g07FNB+8LEVBjUEAIS/kvWqUs5ID4booXq03x81LmA94SKPHZIjUUo0m2
         CwEpjE1oSOSHuKW803VZ8m48hriE1o5ofWBbNF32bja223HxdYrctoWu+Eg4hYbQq8og
         pWcONZKOrg6jhw7uXUczLrFyT/tzIkcv3+95TIO+B4sfDfYNU8L0ka2BmfnT1GeE3AvV
         6zXfFpmCeBCrw8iYw8Qov1QWNG1INzR6k/Eh9R1dvTLt2SoMIlh1gjTzROqttSbjNfD6
         DjS/OhhrIC6sTalMXnq8zNfUw/scjnaxpvrQX7HVTCKOaZlnrIdwQkeS8pKktnBRyK4d
         xSTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786955746; x=1787560546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e7QRgvBPWorozfbbvrTmoZ8vIJPGMLAmMOzYAjtKsiY=;
        b=KRIJ53cn8c2zF9lYhRhQo1Pjrc8I+7gx8YQUbAcETXGuXFD476BSS0JN0eE83OEBde
         XrT9/Vg8U5dKteZJIYljWP6TAC56owiJb/FROmG+DYxmKodGVZ1bJCOUHhjPC8+Zhh5v
         Qf8pe/SvglqkbF+vwsT99rPbw5Amrm6PinkPxEBAGNrSqCtOWPLA47Rh/+OElxuZ1ohX
         joFZESD0kvL8DruXtDGISQk65w0PuKVr4wUySfXs5Y9sISGxZsTAE/ucZ3PMwyJxRbzn
         sfgRmoSb40d/oLK4YuTx12+KlfYUemiFvrLzurOTmMtdw++mtih9dbgSZxGN17NZqrqY
         8loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786955746; x=1787560546;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7QRgvBPWorozfbbvrTmoZ8vIJPGMLAmMOzYAjtKsiY=;
        b=DTZ7/Ey5wCpFqU+/yrF7puTCXac5hW7XSXF9aCeyNG/CI2pJPwxQAILLGTSibk/tY8
         b6UJ2+gtGTdT5mnN4T6n78qP/XgQ5NLF863ivHY302ZfiVAVOsXZCUfJAjKgsThWzFGm
         ykK9xpdJD/Dyaa6W4Tm750noA11FZRav70OffMH/IS5MvJnHWUKH72/gq2A3HngosJj3
         HtqGYXJ2Wqe7AXfmWgtqLWhJ+rzfydzqIaU4Qi8RO9NLsDeRUShkSG80ZXVTUS9n7O51
         Wf+bPQpeZMGZNJ6CGvnVola9UriyeAGhQB0WLWeM07NEKH2zonaB2x9SdIZRkKUcSYi7
         7OlA==
X-Forwarded-Encrypted: i=1; AHgh+RpPyXz9KkI/PvOcO+SbVf74/OtJDoarAi5I2LXIlpCaRJNlEsOlG1CPavaa6gHPsIAAe4d8Q0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9NjVVXchaP9hQN1QkBiqmTAddfdya9mJpAa3bkDtynnfSR7I5
	7v8bgAvrc/NxM+FeU5TOso/tWazPtSNLJpIoBfFASwYIpQaoiTBJolWWH5T/P4HIuLrPgb3EdUH
	4iJFjXqlniX8M1LEmLOQ22rl0dUCuwHVuXDqZ8eIK
X-Gm-Gg: AR+sD12ziDlYjr09L90NGYz/XeujhCzkZF77uJ4im1c7eYZHIttaVv6Jx/X0c57P1qR
	/azkxNNCJR6fUC7FcFkKhKQUgpkOmNJ6FJztuT3z3uCKovXB8Yk7ZeEzn4HdhGapXoBdTXm6I2B
	pfNMlaVoOYkofJK7pHpqp94ebtAhiUes8TECC8905nuUpulRs1qQgQTaI54xoLjdJOWFsBp/A+u
	G4itbkIXOODliQ3Myi7sy45fF4Dp0VMgaSP5J9fwYqDyFU94LqQ6fwx/jj1CG8eTWBLAr0LTY1J
	9MQLBYEveu9zps/Iuc7hB2uEAa6Kw8X9U6Xk9o1hucYfRPlokzs+5f/p7vFsnTnbflluIr08qEe
	mSlACa6nci5npwlC316VEP3+77ku+6isarDtBOsqddijATFcULgGVHkpD427M5tXU9UspqwHNTS
	A1RWoyIRAJ102PvLE=
X-Received: by 2002:ac8:5952:0:b0:52d:771a:231f with SMTP id
 d75a77b69052e-52d8542108fmr237934991cf.12.1786955745391; Mon, 17 Aug 2026
 01:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786610865.git.edragain@163.com> <2c3901162c65a1d85cc1756a83a458db834d70c1.1786610865.git.edragain@163.com>
 <20260817082803.GA242453@shredder>
In-Reply-To: <20260817082803.GA242453@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Aug 2026 10:35:32 +0200
X-Gm-Features: AcwNN1UTqxccvcu8_h2KNjHvZGDUw7DFsSuZfee-yTlIKPMinCvO_iVWlimKwRY
Message-ID: <CANn89iKamqEOMfNmbF9nLGT=+6rPmj3KexW+spPpp4DzJ7G8TA@mail.gmail.com>
Subject: Re: [PATCH net RESEND 1/1] ipv4: reject RTAX_ADVMSS values below TCP_MIN_MSS
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ren Wei <weir@nebusec.ai>, ncardwell@google.com, netdev@vger.kernel.org, 
	dsahern@kernel.org, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, vega@nebusec.ai, edragain@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 10:28=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> w=
rote:
>
> On Fri, Aug 14, 2026 at 01:05:34AM +0800, Ren Wei wrote:
> > From: Yong Wang <edragain@163.com>
> >
> > ip_metrics_convert() only caps RTAX_ADVMSS at the upper bound and
> > still accepts undersized non-zero values from userspace.
> >
> > A route installed with "advmss 12" can later reach the passive TCP
> > open path. When SYN timestamps are enabled, tcp_openreq_init_rwin()
> > subtracts TCPOLEN_TSTAMP_ALIGNED from the route advmss before calling
> > tcp_select_initial_window(). This can reduce the effective MSS to
> > zero and trigger a divide-by-zero in the rounddown(space, mss) path.
> >
> > Reject non-zero RTAX_ADVMSS values smaller than TCP_MIN_MSS while
> > keeping the existing "0 means use default advmss" behavior intact.
> >
> > This matches the existing TCP_MIN_MSS based validation used for
> > TCP_MAXSEG and fixes the bug at the route metric input point rather
> > than adding a redundant guard deeper in the TCP stack.
>
> Eric / Neal,
>
> Both sashiko instances [1][2] claim that this patch doesn't completely
> fix the divide-by-zero issue: it is still reachable by lowering
> net.ipv4.route.min_adv_mss to 0 and configuring a route with an MTU
> metric of 52.
>
> Given the above and the "We assume here that mss >=3D 1. This MUST be
> enforced by all callers" comment above tcp_select_initial_window(), do
> you prefer to fix this in TCP by enforcing a minimum MSS value?
> Something like [3].
>
> Thanks
>
> [1] https://sashiko.dev/#/patchset/2c3901162c65a1d85cc1756a83a458db834d70=
c1.1786610865.git.edragain%40163.com
> [2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2c3901162c65a1d85=
cc1756a83a458db834d70c1.1786610865.git.edragain%40163.com
> [3]
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2c5b889530b5..670c20876f26 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1782,6 +1782,11 @@ static inline int tcp_full_space(const struct sock=
 *sk)
>         return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf));
>  }
>
> +static inline u32 tcp_dst_advmss(const struct dst_entry *dst)
> +{
> +       return max_t(u32, dst_metric_advmss(dst), TCP_MIN_MSS);
> +}

Sounds good, although we probably need READ_ONCE()/WRITE_ONCE() annotations=
.

diff --git a/include/net/dst.h b/include/net/dst.h
index 307073eae7f83456aa80dfa8686f839b302ca004..5ab5f2691ad8af2d27f6019f092=
adc1c02f8bf08
100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -110,7 +110,7 @@ u32 *dst_cow_metrics_generic(struct dst_entry
*dst, unsigned long old);
 #define DST_METRICS_FLAGS              0x3UL
 #define __DST_METRICS_PTR(Y)   \
        ((u32 *)((Y) & ~DST_METRICS_FLAGS))
-#define DST_METRICS_PTR(X)     __DST_METRICS_PTR((X)->_metrics)
+#define DST_METRICS_PTR(X)     __DST_METRICS_PTR(READ_ONCE((X)->_metrics))

 static inline bool dst_metrics_read_only(const struct dst_entry *dst)
 {
@@ -128,7 +128,7 @@ static inline void
dst_destroy_metrics_generic(struct dst_entry *dst)

 static inline u32 *dst_metrics_write_ptr(struct dst_entry *dst)
 {
-       unsigned long p =3D dst->_metrics;
+       unsigned long p =3D READ_ONCE(dst->_metrics);

        BUG_ON(!p);

@@ -169,7 +169,7 @@ dst_metric_raw(const struct dst_entry *dst, const
int metric)
 {
        u32 *p =3D DST_METRICS_PTR(dst);

-       return p[metric-1];
+       return READ_ONCE(p[metric-1]);
 }

 static inline u32
@@ -197,7 +197,7 @@ static inline void dst_metric_set(struct dst_entry
*dst, int metric, u32 val)
        u32 *p =3D dst_metrics_write_ptr(dst);

        if (p)
-               p[metric-1] =3D val;
+               WRITE_ONCE(p[metric-1], val);
 }

 /* Kernel-internal feature bits that are unallocated in user space. */
