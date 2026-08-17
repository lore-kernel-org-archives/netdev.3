Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959B93ACA77
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979412; cv=pass; b=bzPJje+BQWBJ5MkonVa4yj97p84rOroUTk0diDF4sTXibGIvpUfLl/obJX64qlhYN4Ii0s4V6JYznkVo2SXush79OxpudpNR8N/K9SAHMK1ZMxuq+rtKmHh6Y4jXsKvF0fszNSqYa0yPWfzJ/OJE5lmEFRIliMvFNZY0eep+Wl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979412; c=relaxed/simple;
	bh=Pc9B99PvwKk0JzGRy3gbO6+dD48zh0+7+vmuU5I0Cj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pD/b0Oj8TISUzo7btg22X3b5BpUe5fFIaZMsMC64CUmcDmDT5ORADHlLnmTwAw9HYTxARGXMTDJLTb46KTH7ME5VZRjjqs9nzMu4K4+xZwLKYekudWM7DB6L/g66hXzGYcfgpyjRQ09+8gBvbjCgZ7kaPFkqgSVxP2ffO2yxeBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFnTCpgd; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFnTCpgd"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-527e352a167so21811011cf.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786979408; cv=none;
        d=google.com; s=arc-20260327;
        b=cgvK2GH4v5htlrpZj3STKtCXkhPcr1qlDbtHqq8DInx3ZZjmenwyORcRGqAWYI+7o0
         n9LTb0uUn+e/BTM3QlewDuFCjdrhtXIg3Fn+KmHPEwSgVuGV+4ziV0ZcZIbTVjSQgRlb
         +PylKg38aw1XjWjzr9CSVP4xxSvi4EYzDjIY2gs+JTbPQtZ8jgPfz+NGRbKBp7ICc3uq
         qRGO4F6WU1tkwYyx9xrDpARk2a4bADzw/r3chsCl+ys0kQycz6fiLiuohKn29H3PG7ze
         0w0y38VDM/LM6UI7Xq4xGMxemZFw74oAamEn4AkPDN5RdIckOgyNSIHS2GhuRZdT34ZF
         fiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P80KgaQ8/Me7lavJaEHcn5LQzifuFjvx8uVo80XbTXM=;
        fh=FEIC5OOt+v3InB1eGAHIRW9dVC2zeYfUF7rdGmQycQw=;
        b=Ks1rVHVvBiSfb/CN6JGvw31IvebWufLwrSbuj7+MsA3xOYYLyylFlcAgUZfF2YGjGk
         bTmQmY0MiUUYcE/JK3YrK+LG78H0dTebTym0a+t5nFONCrNQ8jdmKctTs44ds49trVPL
         iRRtf6EdlSMGs5L2WFdTo1z79LnRGB9+Dt963x29H14lISusq5ToUSmgc6skzaH43tud
         pKUdZZMGiXE+EgiSlNwYYJMmdWvul6r2h4dOvfpdAjqbcO+070rFK2vwo10JbNr2hBRI
         sypAUngvxK55p0iadN1TdOAqEj1JcpfVWuFVQGD+xesGEgnBeqUF8/qkns1LU1YVp0La
         O9Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786979408; x=1787584208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P80KgaQ8/Me7lavJaEHcn5LQzifuFjvx8uVo80XbTXM=;
        b=bFnTCpgdvDIm1fm5pIIaFZhIgq514H3K/umgN+CtB4SYhCbKz18Bke/EDOZjnISf/y
         2fEM1hweqNart9VMygM8NzIO9ytJ7b1cM55PMfuDMP/VBuN9rA17AR0l3K54asdm1eTW
         SkciLntGz4A5E4bsvv0P50PALTsjipiXT+iek0BveoLhONxU5B0vPX//o5wRBvB5E9ap
         WFNF9hLMuOPTz25tWrhhkggm4cJB9q9ArpoZgPK1UApgJDgesVEKjwY1YZdgKgtEvupl
         8hTMmQXpTAOyeHDzi9kvyQgFw0GWwehBPoZ4CWZESoqtg2E++dvkFJ+57x3hlOQf0saM
         oJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786979408; x=1787584208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P80KgaQ8/Me7lavJaEHcn5LQzifuFjvx8uVo80XbTXM=;
        b=TKPXz4zB86LnJl6p7P/Lf9p0ebjjBj9QEpU8437pdDawof+f+tlaoRyBa0CM+6IkFL
         PQFQx/tvIqqVP1CkuiHj4pKGPQsaMxWuaEzXNl0BlqVZ5A9k5tPQGK6GkuwKFK1ZomBY
         0b4+QIZ7ZCwt3vJV8xbEpS8gKDLH2JHIaecYjH7e07etp8GPDNHOKi2YL/p0h/zS/qfL
         zqT+Xmj7B93UxXgZ8038scO2xfrkzDVKABWh62aTUOrjSwstQQQDChZx4l/V+0DrnlfS
         PD42u/nFMwNo4+0pDt3kHoMEF/r+STmfoYNQa+PmXneiM16PkAw4UiLzJTTjyaE79I+y
         aR5A==
X-Forwarded-Encrypted: i=1; AHgh+RrPcYKzV4YuXmf2PgAATVcdQEakpsgIcYIW3VPGxc2BGb16ypciHIkrEWKjHsu8sIh/8SWRM2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGQxjrHSxgyX4FvAj2EwNgAizMArYuGtZs/P10LvEBr2VUxh8q
	GEYBhXwdWd0XdKT6sqRiti2jdatgx7FC/cOHzA/cxrvWTVILYaARVjPTVqx0YdPq0ThnsjnCxEr
	qnoA3UoCAAeGqJzpgy7kqDVIDlpOl/0enTrWZmQqq
X-Gm-Gg: AR+sD11r82WT3e3URL8tMvwH874HPqBileyr/xLTzFqUvgnq7Uxy9z5hFgu+ZnNmrlp
	OkAV5XXulsPt7btSwtT1eAvejdHFVbIOTtunWczqe1yAgbOl1arIZhWFVlSnGKQvPpWlo6cXJlr
	zjJOo5o9LGz8wRQ2HXo8jM0PrCmHyR2vgekDHvW3fR5DfmbZTcQUZU5Rwnmeq0a5e3vpQOwkW/k
	z37QqSReq+32S+VwSgBrxgb1m1Q+0a4jBb83RADYu84gGuRl+k9z9vcZT0rdoaOQ7act/SWPnVD
	kI/4SyZVoRW9U3Xq3SPqcZgfbmbaSNeHUiufJw6s9wW7hoBMxxDUHgnlrhTyjpUF4B5MLuYTuqM
	dadmnbFQT8oY1MUcRmmcxU5e/JRykQm0Q6tjPwb6SxD6Mt6yi+Py7YWEx/ynPtCicxhTrku6V8y
	DPoaSHMZtF1RF6JUs=
X-Received: by 2002:a05:622a:4d9a:b0:52d:94c5:2212 with SMTP id
 d75a77b69052e-52dbd5fe649mr15814841cf.3.1786979407638; Mon, 17 Aug 2026
 08:10:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814060616.2164504-1-edumazet@google.com> <20260816124359.GA62850@shredder>
In-Reply-To: <20260816124359.GA62850@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Aug 2026 17:09:55 +0200
X-Gm-Features: AcwNN1U-ltEO2KFt7Pe5WgINbsotoXM1Cacm3OUZrvpIHe1HBFhfM9jckMUS7D0
Message-ID: <CANn89i+h_ThBFFDSqUDf=2NajwrnTRowjvveNTLWQU3OpgNTeA@mail.gmail.com>
Subject: Re: [PATCH v2 net] inetpeer: randomize RB-tree node comparison using SipHash
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Michael Blunt <michaelbblunt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My apologies, I missed that. I will send a V3 to fix this.

pw-bot: cr

On Sun, Aug 16, 2026 at 2:44=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Fri, Aug 14, 2026 at 06:06:16AM +0000, Eric Dumazet wrote:
> > @@ -190,12 +221,13 @@ struct inet_peer *inet_getpeer(struct inet_peer_b=
ase *base,
> >       write_seqlock_bh(&base->lock);
> >
> >       gc_cnt =3D 0;
> > -     p =3D lookup(daddr, base, seq, gc_stack, &gc_cnt, &parent, &pp);
> > +     p =3D lookup(daddr, dhash, base, seq, gc_stack, &gc_cnt, &parent,=
 &pp);
> >       if (!p) {
> >               if ((u64)base->total < 2ULL * READ_ONCE(inet_peer_thresho=
ld))
> >                       p =3D kmem_cache_alloc(peer_cachep, GFP_ATOMIC);
>
> Eric, this is a leftover from v1, so the patch doesn't apply :/
>
> >               if (p) {
> >                       p->daddr =3D *daddr;
> > +                     p->hash =3D dhash;
> >                       p->dtime =3D (__u32)jiffies;
> >                       refcount_set(&p->refcnt, 1);
> >                       atomic_set(&p->rid, 0);
