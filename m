Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794207198;
	b=Yutt0I0O2QqQyXoRR9fm1P3fBDLXpSsagzM6WzeeB05ZV4SwoR5oS6eBRsHNEvWWhk2A
	 5KiToZ7FABJVHAW0+lAT+cCfhfNde52eXnAAFFrIGvqOYUmIMpE5gxsdtFDJuK7A10RkR
	 1r/QpWK7Vdcwmv5/9zFxzR4Oud48AY+0D185947g5J8+XjXTPj+XPK1DA/LotVjycmYUq
	 uqHucDr0hXuhD0I4ZKK1rPkLFWmLvvuaj7089fuQXTBsUNnk3fbi2XYNRrHiSEzmsC4e3
	 nfVS+895/B/yn4ofU3N+X0FUAAPZ5OcAdGVSRRNKLpPJa9X4zGulsL69jm/D3+vmMdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
	b=D0IwmQWIU/qCLw2gIDEwKhqp44XkOXaBiKVAfmjW+ZcyAQ8e1V13iNCO5fOvKTTAwBeO
	 zu0CfQigCbd8SYZCZJWgaYBl4OTt+9XspDDbpmIA2LFGwhJx5yXe9E0XEGrdxZgkNZEV5
	 kAeGxc9wgB9IPlOdysU+ZYGYvB6N4yQqfrTuLNJtxSJOc7/gjkV//z4oucvclx8B++xkq
	 Hcd5oBE+vrPGpkdXww952klooX723oB0ctA0H2G+lAl1yVftH9jb3CFQvrYRCTZFE4znF
	 6QpMLcTa/VNvTvLVx95bT2OtP2YpOMnEo0fh3u7zdrcAGUzsOgDVWqMkEzl0+Jte2HA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sgWujCEB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E651606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 06:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E651606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sgWujCEB
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5c1465bbbdaso302616e87.3
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 22:53:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794207196; cv=none;
        d=google.com; s=arc-20260327;
        b=HwgH6dZkE+tvJNrE5kMR6jFMl10qauLd95k50KMXI7TQEKvcOVa45Ps+wVgRF7ldKm
         gfNrjhJv5raGfOmqoAOGcdIw76iX1ITgt7ZBy5EW2uzyNMudTkK9MlwXaF2DTe/rLIth
         gGSVi/mYwILn+QA1t93OO0/OBD0lloW7C4p6NNNWXzjColR8n5C3nMtnXJHFvKdlImhY
         7NZP+PO6bJ7aUn7XaSqw1OtMMzgTOdRFbhTDHJoy5td6cVuXMkbBYg07bc9Icz8NQOfH
         gpTC4cXl+nPRTR5fgSUTJm8sUYYtOIPEdqwLGOZsZZ2Ey2DQfOcepb74amp7CpwjUGcs
         1RBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
        fh=TPxAnmoApUaKEUpADA8dK9sH98Gb4CngOaoeQ0ran5w=;
        b=SC6QHKagMEFDUtZZOWiIqvUCMBmC27l3LHhLi75Fs28o526LXmNkNSWvputYo/D2+6
         dNxrrKFyZhd3p5wiq0h8RMXNgATpsd9jTniP7NuqnKCNoczAU6Ze4cBj6+N0hYUjgqbe
         0BdunsUEyoQ2nf2OC8o1FeeGjDtDN2ui9pdv/86G5Bs1AoZkL6lvu8LyqVGXhVgLh5ws
         pU8efdh9PLatveRF3gOGxhs1j76DxoUlTs/54QTk907vCOMSMMKCjYyReE8m3SpYPnvg
         TNJk9wd0BTR03NUptKncKsRvCOOmUvy2488hGmn24uUJyF1sTkeiOoRk9wxqncjZheRL
         eT2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794207196; x=1794811996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
        b=sgWujCEBcLnI2rCZx2+HrV0hdHuKHGWZkbP/T95hfWdHOsdro1qJU1Fvk+8OO9MdfB
         0BqsBZTh492PGUlz+uiD5cFVvZc+vlVmSZhYzi+w/tlD80Sl6tEzuWFCWZhv/N6pbH35
         rLWt1UHkkGkHK24Z/h6vBhtLRJVzr1jbqDl3LlT+eJtmAmj2BiR6ABZnJcxKkIEwjeuj
         rKb8qVeksOei/N1ZYTOxCXuIYcRzPS0XXno11fSFmwYvkRxmBZ3+yYmHEczZNKiPx5RZ
         oHt9g8LUVuNFkbZtPXFWBtwsCaMo3xAJFO6XAxUED9WmEkoDJbCWdP6YC+ZT/ijPGBxT
         E53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794207196; x=1794811996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdfSMn5qmUAvXVccrNmls1DypVGRaJ++jbiwGI14+kg=;
        b=x5PoZO8k43TNK6BCr9PtLwkVYc5K8g3wmR4SV1vu1POyqnuz4zrQyoJJ/UQvQIvZhw
         w/8QHCBdT6f0gwYwlphJgRADUx/EyOHnsBT/2DpGZrvJvSSrtKqGPyemtMJspDiV3zVm
         5pQYkLli1ea8RPU8cjq/n440kcI3rX1GXCasRQC5l2frkQhbtK3Jl9Nd0iwfbGg0XJ2p
         yJeHrvdlCWTXQ1asiJ58HNdM9imK4qZH+lQJCzDTTVXZouklhZOntsTJrnH52zTrfmvy
         NZjlKjdCZO4bbiPIFz1mQdYufXE4ii+ZAxsv4UBtP6NPobJV6E1DEG3+8KiLfxBT3luC
         ubJA==
X-Gm-Message-State: APuU4Z+T5ZncKqVrs9ZhZIDvD+7NzMvg60KTauC7UfyamC6loj6NlN0S
	cCvPvSX5cX2EPfU4hBNdBX7SrYLG0M1K1THWjo+h0j+xFxxlJ6QaxdXJfy684SfiuDRetR8CY4t
	+51aOai085VER3hgaZjoGOPjijlT87qU=
X-Gm-Gg: AYBFou0aBU9hr3npypBD69uCxoRKEEzkyWXl26MvLPoaEiL1KKPIF6xd2tH1v1le9h8
	emaPrvBDzBkTp4lXnx+1oUOqd+m4zV7DVTNuR0Mz0ARToClRk6OFfKbsug2pg2NgETJnuej9OLt
	C4aIARcwocqFn9+47Z3OA0OI8JlrUChmwiXkOXdDUpsXSyJxpqwr/nj19Jvui0iOO5FGG7aPVDU
	TCi8Hh1Lb1Op5o4KI8bTcvGFLZBqq6MJSARvIDGQgmAxUm59zRikB3tBuere+/9mA+i+awdXohR
	ntoTbShH/I5ITlmLF8MS0TJX/yMtT3ih61Fi+xHcaG3vKT4hde1UfUpdMpwwgI6MFcL6LGpmLtq
	Bgi1yd3AQolRRp6uGhZLYOw/+fCBGBcABoQRdLAhdYeuP6Kxpt9Ea0071rMlvv06JGxXBAW3iFY
	8955yrlTbVDc7Uz/3IMzer1CprTwlP74u2afPWQyfYY65LOkyMpwE=
X-Received: by 2002:a05:6512:3e1c:b0:5c1:4a48:c2db with SMTP id
 2adb3069b0e04-5c14c01f805mr810751e87.43.1794207196170; Sun, 08 Nov 2026
 22:53:16 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109025425.328445-1-jiayuan.chen@linux.dev>
 <CAL+tcoDvFNAZubOjw9+Z1eyaVeiBzt_Xg3KMNucY879bg-ZLow@mail.gmail.com> <dbdb9385-89cd-4e4f-bfb8-b72510e8801b@linux.dev>
In-Reply-To: <dbdb9385-89cd-4e4f-bfb8-b72510e8801b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 9 Nov 2026 14:52:37 +0800
X-Gm-Features: AclHuK9hO_h4FFhel_M7AacjBweA615sygy6vgIfEMNG5ukVHhzyCYoysXzMOxw
Message-ID: <CAL+tcoA6_gROiprd7YgxvwbaiuzEUPfuWTNMjKu6vDkbUJ5KPw@mail.gmail.com>
Subject: Re: [PATCH net-next 00/14] net: annotate data-races around sysctl knobs
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, Nikolay Aleksandrov <razor@blackwall.org>, Paul Moore <paul@paul-moore.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Julian Anastasov <ja@ssi.bg>, Allison Henderson <achender@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bridge@lists.linux.dev, 
	linux-security-module@vger.kernel.org, mptcp@lists.linux.dev, 
	lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 11:33=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 11/9/26 11:11 AM, Jason Xing wrote:
> > On Mon, Nov 9, 2026 at 10:55=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linu=
x.dev> wrote:
> >> While testing the recent sysctl range fixes I noticed that a lot of ou=
r
> >> sysctl knobs are read with plain loads while the handlers update them
> >> with WRITE_ONCE() and no lock, so KCSAN reports them as data races. I
> >> then used an LLM to go through every ctl_table under net/ and list the
> >> readers that were left behind. This series annotates them with
> >> READ_ONCE(), and adds WRITE_ONCE() to a few custom handlers and netlin=
k
> >> paths that store to the same fields with plain writes. Most of it is a
> >> plain READ_ONCE() at each read; where a function reads the same knob
> >> twice to make one decision, it now reads it once into a local, so the
> >> comparison and the value it acts on cannot come from two different
> >> writes.
> >>
> >> There are no Fixes tags. Done one knob per patch this would be well ov=
er
> >> a hundred commits, so I grouped them by subsystem and feature instead =
to
> >> keep the review manageable. If maintainers prefer, I can split it up
> >> further with a Fixes tag on each one, as several smaller series.
> > Over the last year, I've been thinking about the annotation stuff
> > especially around sysctls, which, I suppose, shouldn't actually affect
> > the real workload but does affect the outcome of the syzbot.
> >
> > Out of sheer curiosity, my question would be what is the point of
> > trying to change all of them? Or what kind of benefits can we get from
> > the big series?
>
>
> Three things:
>
> 1. A plain load may be emitted twice by the compiler. ip_error() compares
> peer->rate_tokens against ip_rt_error_cost and then subtracts it again;
> if the sysctl changes in between, the u32 wraps. A few readers have that
> shape and now read the knob once into a local.
>
> 2. Tearing is not involved here, all the fields are at most word sized.
>
> 3. The rest is the memory model: a lockless read of a field written with
> WRITE_ONCE() is a data race unless it is marked
> (tools/memory-model/Documentation/access-marking.txt). That is what KCSAN
> reports, and why most of the series is plain READ_ONCE().
>
>
> I think the benefit is doing it in one pass.
>
>

I was curious about the REAL impact. If this thing really matters, we
have a lot of work to do even not only in the networking subsystem.
Sorry, I still think none of those points are convincing enough, but
that doesn't mean I object to this series. Anyway, it's just my
2-cents.

Thanks,
Jason
