Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E05332E12E
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787503249; cv=pass; b=HsUQ8oC0enBOxA1rKke25HD6i7oiRAPna0JlMVwTygafXOGFOY3mwVXq4fhd7iWIs637S12UhWeO+HQePsMeUzmXlKsMItLb4LYvWto+6Oovy6pl1N+HhXgc7SiyqBJeIP9Q7LR2G9MpjXYeq/D0lImZpLr3iAyrDpSdwMh7Bis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787503249; c=relaxed/simple;
	bh=2qrJ07HmFhMiDarJWqhbEJyNsikA2+xhGbEddsDBpHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L697GcdILahpajlcgjCmCqDLtu/grlJTU9/vhWK7aKoZfyO1EKWO4GezmkU4/uqx9bCiezZbcCnT8umXHfuAO/paU+sy9SWovyvKa04Kk3VRKO5hB0KdDOG+qq2RftEHRSZK6UW+deMx+BqVqfm1kq+Y6sBSVpeT6qkilApHpUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMdamEA6; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMdamEA6"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69edc72e513so96408a12.3
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 09:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787503244; cv=none;
        d=google.com; s=arc-20260327;
        b=ffiKJ5jCISM8zDOWxaiis5eHMvY40mZgktV+k7Ro1jqUl8ZHATUKj4Zm7Q0Z6868C3
         hn2w9O9JWSkP9wAdBTLK/WHSHPZMafCmKYsKwcorqXaisu3lnm3wb8USsxXXrWJiEJEN
         FSqpRnmDOeogIOjAdeh4BihlvAPdJXUzyU+ffmqUwpZoRYTe+/fobRlGcfoyQuuhsXwa
         etSRwJUnKbQrNkKSOo+2CR1YYmC3YcDgcQf1DQjg5IUm92ThOiyDK7CHVPUIMeE165Ip
         Jhlej8u8Fvj2ZrgA/o0bnqS4KijlLxoCwUAiHgfbyKvt77H4dQGYegzTVSxhgQAGozv1
         KB6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m/sDxPalhg584dD1gtugx9nNfFRP6hf2NhTD5B4YszU=;
        fh=H9+DKFHtbCWtPKwgg1ypUGfdd+C0e0tXx81ylehmiaA=;
        b=Ii7TK/707lUN4VE21ljX5IwvPqv8x3biHQJBb+wcoMtYo5qLff9ERteL0H7kmNjvQz
         mljWoH+hpFsx5xkXhclDIecjoXJCLW9VFCl+r6hIqgA2lhhONJssklpZxSONnuX6URll
         quV7LFbZDhe/rYN+jFVJ7Lhu3QebmAWNgZ4EA71Xv/g1N5O4Cq842eekjtSzH9zneJss
         /Ez4hZ67dm/DR6aI1mGfqFu0kiQbulmT3gmlaM7BuTty3C2/WkjGDb2yL8VasP0Fw9I9
         t7iNKObIEgRDk1GwmhibLbDq6NcOG6cCWedumC70n1b6tFVNbyfrPBp0HuKX1IntZBhH
         /+SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787503244; x=1788108044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m/sDxPalhg584dD1gtugx9nNfFRP6hf2NhTD5B4YszU=;
        b=AMdamEA67Y2pefFwgzzT1EqkPGd0eUCauP2Ytvmu2kR3FE0W413s/JHoqavNimSNZD
         NcuTIy0XImGP5o16PxCuT+bhCdyOxanR9OaWZyct2NOmJpQYKaNXL4MT84aIw5rgVElP
         ioBR+1IAA7f8bwpEnOlWrgrQmVaWIko5hSZmEMR/6Wuha96S4DdSzy/nSxdGuX81UvaM
         vtKT72LEuj0yl8ifX6EQMecUMlgXR5yH2d0nytp3Loc7NNpU1w8ZUwdJGsEpzLyKbC9z
         EXJZQqWlmQ5CQpcJOLxrxNOnLgSWdd+31gwthJAUFVSwsnOgcdQoPtYtOKXN5kf+nB8V
         nc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787503244; x=1788108044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m/sDxPalhg584dD1gtugx9nNfFRP6hf2NhTD5B4YszU=;
        b=pL2x8rPmaL2wNCwaYLPdWThVpnRZqz6H+jTuj3pzr24G8XlKH4XlVJKJO5WcCmetuM
         2fFi6WV7tlzKrsY/1Mhu8OVnExxZJ2CamiLRbKWna9ZHX0hmoOX/e4ygiDcKNpTpQm1N
         WKo+T2qWutPcK5MtWZ/0suK0x0lNOltyK6vDTsad0dIAQq+2mVgpvkqqr46BJcbEAKLy
         q6NN+7tygw1BUsKqEATd2BVau5xAw1sE7PaS6Ue6PXdtnR7oDTUW4Kn78XUxDPlJ9fjO
         8cadkDvmFvn9uIgBV4wMaQJrebt8h6PYmNcv576EaZLdDPIznlKbvv/MwFb86ZlNZo2V
         HF8A==
X-Forwarded-Encrypted: i=1; AHgh+RpDwAv4cycNnQPRBGMPrCMVzpRMGxnnjvYbbhWHHpb3XzsN/RzcFgFwfkiGQ3O08O/p2Rcoeo8=@vger.kernel.org
X-Gm-Message-State: AFuF++kQT7EeyR2PECXtL/MpBmt6npwTllDCqDneBudrcLN+Y88doUGp
	i38fr8OuLBY00LbZCUYhPMZsovVgZPuGvzCvVQ+juBKaYLNm9YGMFt7/Rxffqd/DZqMVLHqIZa0
	+urdsuvaUMgyhnjdbWn/gU2YHeCOEJv0=
X-Gm-Gg: AR+sD12vspaddM0sWEMfJTHs6MTf0w9WWJc9wmY4AdGUg7Ic+zWe3y6/MtZOnt5FLup
	xUnnBz1DdXGmmYksrXfmWDjQUYKL+44FwY8omtB0mnCD6ITj18fACxvfW9lcCRQRfteMdrvgcof
	M3mCQnYqbJYUUtatnlZ61IUHFxNuIj73PQ9ZWw1ugGuHpVVWu6yFSoSCprqNkHuqlOppa26BI7Z
	TalpVgNNNXxYDTKFgDXVhjrCe6V81ON3nQxc/p6fHc/+ow03031unqQGBFVMWXgemyunHMwd4vP
	dckmFVeNw2W6IZlEZ9pL8HvM3ITjnaiOo0zrYGMPNtxyjAfDXxWYMgeUeiai+VJVju2QNEJgZe+
	gH10Hwz0P
X-Received: by 2002:a05:6402:450d:b0:6a1:f95b:8cfa with SMTP id
 4fb4d7f45d1cf-6a42f1b47d8mr12742404a12.1.1787503243685; Sun, 23 Aug 2026
 09:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822184658.3787672-1-nicoyip.dev@gmail.com> <aosW-q9G-rQlIXwu@strlen.de>
In-Reply-To: <aosW-q9G-rQlIXwu@strlen.de>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 24 Aug 2026 00:40:32 +0800
X-Gm-Features: AcwNN1U2ZcUxHGp8iN_ot6HPNtjh2GGRM3ivt46qhGCudofB78avg11NKAz3uLM
Message-ID: <CAAo+4rU8b1H3NFBm_OHqmkr-086w2ZAzrWoFZYvbifBk+358rA@mail.gmail.com>
Subject: Re: [PATCH] netfilter: nf_log: clear per-net loggers on unregister
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Gao feng <gaofeng@cn.fujitsu.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 11:51=E2=80=AFPM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Chengfeng Ye <nicoyip.dev@gmail.com> wrote:
> > Logger backends unregister their per-network namespace operations befor=
e
> > unregistering their global logger. This leaves a window where a sysctl =
or
> > netlink writer can rebind a per-net logger after the old per-net
> > selection was cleared, but before the global logger registration is
> > removed.
> >
> > The race looks like this:
> >
> >   CPU 0                                 CPU 1
> >   ----                                  ----
> >   unregister_pernet_subsys()
> >     nf_log_unset(net, logger)
> >       net->nf.nf_loggers[pf] =3D NULL
> >
> >                                         lock nf_log_mutex
> >                                         find logger in loggers[][]
> >                                         net->nf.nf_loggers[pf] =3D logg=
er
> >                                         unlock nf_log_mutex
> > Later, a sysctl read or nf_log_packet() reads net->nf.nf_loggers[pf]
> > and dereferences the stale logger.
> >
> > nf_log_unregister() only removes the backend from the global logger
> > table. It does not clear matching net->nf.nf_loggers[] entries that wer=
e
> > rebound by CPU 1 after per-net teardown. Once module unload completes,
> > those per-net pointers can still reference static data from the unloade=
d
> > logger backend, and later readers can dereference freed module memory.
>
> Why can't this be fixed by unregistering in reverse order?

Right, that would be much more clean, I will send the v2 right away.

Best,
Chengfeng
