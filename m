Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421618;
	b=BiPTDbqHbLs8YQKs5d/MonEFBDhz6wwQRUcxUWW8ajje6qXuodIfCI9smkMnQdSrIKyp
	 tGxCY4kv4Z91ERJUrLcl/aHDB9f8dNVtsF2CJWpVPYI7ud9A5Xg0z+bamJMV+1jACi6Hi
	 XB1xDGzV077baLp0jmIqVtcxh6SVUAcYZZAlObszzlMGwgA1gdndHVQUMcnPRbjs2Q5hc
	 C4lQXVT65TcxNDvwTWZWq4bNaOJqjx6wG6t8qugYDoexueOk/FNzkSZJ5/q6nKPztNzKo
	 uR6uUXrTdufbc6eu7AfaYDcNrTD5jT1N0/BGjyhxFJ3i9tVo+4W0N135vWPPWU6t4SQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421618;
	h=Received:Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=S+Ym8tXJWpZWXVR5/0qvx3lNlnmmr/1Btzux3EG85GU=;
	b=lm0wSmyW8Z9Eayy5RycbahAeOGF5UqLGfPU6KRkBsh1ei7EIP4rFf7xlJU58gv9N/h7S
	 MmTv7v3ysCdnOg4u+4LK36H4iPPOmemNAV4MaXCXLmBRKH2H90OdPTTF4uzq7hrkdNi7/
	 yx6bKm+R9aH1C4AJpjtkgEXhmW/1YjfqBsrQJQzw+DDWH89xEyTco9CJNVhZZZtPEnt1t
	 Tx3W1u5WCLkc+LeXHtIuGmYevvZ83mCj8o+tftV0AnAg1CjYWY6kUNujoGSeUNAblWT1D
	 cP+Lax5V2s6NvqnFfZZVrfRAAGCdpJZhzAkuPipewAQ4EJLjX5TAEiQGFjByvdUwzJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyyKma8D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1453D606C14F
	for <netdev.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyyKma8D
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD003451CE
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421618; cv=none; b=GdPlZX+TAtSfT0qtcTOpI1a3+dNk6oWjz+sE1sE7Nv/L7yiA4F0BEnSn8FaZU23q25YXEgRgPLd9PwcjHJGFZhZcz+hWuMIhtYLu5UJFGg/NH/FxaVzZYuLe86L7O0DmcLTzM8sECd4V1UcqBVAFC9SA1hS/QS7FyzQrHo+UGEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421618; c=relaxed/simple;
	bh=LmeF4ALpaW1uFDGTp5MCHyGcJJoqUOpGzB3A8h5qd4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E84tsLw6g8tEmMMXXAew4b9sgfr0mJv+oe1v0EcHk/UiG47OgSJOkaO+0puut+LFy4H1/GBwHvMMKH/fCyE0GDJf/QkAtBsSdkJRdkQ81W9PrremUoVr227latFZEa1qw9lQ3j7JUbTdv3CndfcZ2Ww5SbrCfcWww0PU4XEvXLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyyKma8D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFD51F000CA
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421616;
	bh=S+Ym8tXJWpZWXVR5/0qvx3lNlnmmr/1Btzux3EG85GU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GyyKma8DEU8LSTI4xyIJlBMuM+HXHkGaNJeSbmUgefuKybsGpD1Oz3fL/0N77Lnu3
	 H5IcY7wSRBUaMST+xRC8fj110MbaTlz3hInidel759VJhyqt6GEq58hav0GWR2ttj2
	 0xtHAh5nS+49iqvgzvFtzk95WDcGlKeYC8MvHuMXMT1/hechZLKrqoYOyq95+5ssxV
	 u49V/SNquRCLfT2H9ZYWIW/YXQiq/+vZkYIdiXZriAHtPzsOpZSdf9ew0qDrg6O0bl
	 X8FEWZ0XjyMkC+wMW42hCfeCgDiim1FnjBXrRsXvnqCNmV3DihemtbbijjY7Ogiyhh
	 BioEpKqzOmACg==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91beb36fcc6so14325046d6.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 07:53:36 -0700 (PDT)
X-Gm-Message-State: AFq9FYLBdbYs97AubKtnG5ggj4ZoxIha7GbEt12O2VRRJmcjBO87RMI1
	HqzX90SvDua/5V3hV7VJd3cq1MztkDQ0XhFXlwrfVq3LO1jksXT9KQGZpbuYmbVm1k0NJeM+lMN
	5P/puAvPcweSC/KBylGHyuOWoYiFRveE=
X-Received: by 2002:a05:620a:17a2:b0:92e:bc28:5479 with SMTP id
 af79cd13be357-93f29b7fa33mr1291629285a.2.1792421615693; Mon, 19 Oct 2026
 07:53:35 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-5RTM.v2.r0.20261015051735@mojatatu.com> <QDISC-5RTM.v2.r0.20261015051735-1@mojatatu.com>
 <87ld7t3kl3.fsf@all.your.base.are.belong.to.us> <CAM0EoMmL1Yjo67wOmOwWtfYLNrVFH7zSbgDtx2Rg+k3-Nu4QOQ@mail.gmail.com>
In-Reply-To: <CAM0EoMmL1Yjo67wOmOwWtfYLNrVFH7zSbgDtx2Rg+k3-Nu4QOQ@mail.gmail.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Mon, 19 Oct 2026 16:53:23 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNigAQTJ37tx_74jqPcCCwsk1XR5-reOo7i-u0xCKqF--Q@mail.gmail.com>
X-Gm-Features: AclHuK8qzzgheaqrj_7NZPjxMNt7VBnt0bxhEsZWkBPMHkeW-T9XNuxRdU9gNI0
Message-ID: <CAJ+HfNigAQTJ37tx_74jqPcCCwsk1XR5-reOo7i-u0xCKqF--Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/4] net/sched/sch_cake: serialize
 reconfiguration with the datapath
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, cake@lists.bufferbloat.net, 
	Victor Nogueira <victor@mojatatu.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jamal!

On Mon, 19 Oct 2026 at 15:47, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> Hey Bj=C3=B6rn,
>
> On Mon, Oct 19, 2026 at 9:07=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
> >
> > Jamal Hadi Salim <jhs@mojatatu.com> writes:
> >
> > > This is a follow-up to commit 7cbfb180945c ("net/sched: sch_cake: fix
> > > autorate reconfiguration throttling").  That change only stored
> > > last_reconfig_time; it did not address the concurrency between the
> > > autorate rate update in cake_enqueue() and the netlink reconfiguratio=
n
> > > path, which the original review flagged.
> > >
>
> You are reviewing a very old version - the last one was a v6[1], most
> of these fixes are in the "no good deed goes unpunished" from sashiko
> ;->
> I am about to post a v7. Maybe review that one?

OMG... sorry for the noise.


Bj=C3=B6rn
