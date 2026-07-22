Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED079315D58
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683368; cv=none; b=WRR2qbcdQzdTBx5ED/dWxNYPs0GFQGGTp8fC4yNTYVQPtGNYfHEXYIAxjA05XeeHXxaarPuASrShWCUmeyOiGf6kUp99x8siUS5Hn9osF6AvkVEOkxHi4868hDIUDxlxGaGjBbM8leHtQuQ7XWBA26jMy31Dun8zd8t8OifS2wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683368; c=relaxed/simple;
	bh=4E7yo/UQA8dLu92H4Vlu3v1XE8uyPaUdY2c1EwbT+vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hm7ad3GPFS9QQICZm12Qd2auJ5N0m9DGNwopzcdgAM+ESZLnaeBZAkFHdGzeOQuHgVJ0ujt91fDI5MYB3ld4EqUC8sVujxT7CpAdtnw913lgiPA/DRyIDvavkmJ9YIaC63v6oW91XVJvgwC8Sh2OI7hUbLMWIBZSEX1UNMiEeHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N21myXoU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N21myXoU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C49B1F000E9;
	Wed, 22 Jul 2026 01:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784683366;
	bh=4E7yo/UQA8dLu92H4Vlu3v1XE8uyPaUdY2c1EwbT+vQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N21myXoUIn73VJowmT8P5lbPluMHPYBoDUMCX5V+pj2U0fBvEHuaU9+Ug+XoGQkzb
	 l7Phd41X4OjBhy6curBamQ0gkZOAU0jLBu7KfyTELq3zJeqncPCUsR1wAIqeWSpA27
	 L0EQW2vzGvMH6qwBWsCqgAr+cqsWRcGihiHCoXCz+szu7UGl6HMM22gicObLxOa7nF
	 dN9abddYQCJxxltSu5dsYmOBaWI15kDhva9TWoDhRzciLwTDbWKYYCNqNROprW5syy
	 PpfU5HoA73JFEhg8R7wPCtxxZCfcoC5Vh/97Tm/c+0nnZ8MsbaP/VGAgx01MXqLBzs
	 Zu9dnIfheUHZQ==
Date: Tue, 21 Jul 2026 18:22:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuan Tan <yuantan098@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, jhs@mojatatu.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, peilin.ye@bytedance.com,
 cong.wang@bytedance.com, gnault@redhat.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn,
 bronzed_45_vested@icloud.com
Subject: Re: [PATCH net 1/2] net/sched: act_skbmod: require an Ethernet
 header for MAC rewrites
Message-ID: <20260721182245.50059a0d@kernel.org>
In-Reply-To: <CAPuPA7KMdDSGKWJXEZzSpgbdUj4_BGGX2+CedgchoD77bPd8sg@mail.gmail.com>
References: <cover.1782548651.git.bronzed_45_vested@icloud.com>
	<3ab4a04fbab887238facc1792e02c33fd68190f7.1782548651.git.bronzed_45_vested@icloud.com>
	<20260630171016.11c02dec@kernel.org>
	<20260630172027.5eaba39b@kernel.org>
	<CAPuPA7KMdDSGKWJXEZzSpgbdUj4_BGGX2+CedgchoD77bPd8sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jun 2026 23:46:46 -0700 Yuan Tan wrote:
> On Tue, Jun 30, 2026 at 5:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Tue, 30 Jun 2026 17:10:16 -0700 Jakub Kicinski wrote: =20
> > > On Mon, 29 Jun 2026 10:46:03 +0800 Ren Wei wrote: =20
> > > Let's do away with the 5 reported-by tags? You can use a tag for your
> > > tool or your team, it doesn't have to be a person. Look at sashiko or
> > > syzbot reported-by tags. =20
> >
> > On second thought, if y'all work together maybe there should be no
> > reported-by tag at all? Can you explain the situation? =20
>=20
> Hi Jakub,
>=20
> Since February, our team's bug-finding tool has found hundreds of bugs
> and vulnerabilities. Several people have helped improve the tool to
> discover more bugs, and verify that they are real. I did not want
> their credit to be lost, so I added Reported-by tags based on whether
> they contributed to finding a particular bug.
>=20
> I agree, though, that having five Reported-by tags may not look ideal.
> Maybe using the tool name instead would be better. I will discuss this
> with the others.
>=20
> We also found many external volunteers to submit patches, instead of
> simply dumping bug reports on the community and leaving it at that. We
> were worried that too many reports might annoy maintainers. That said,
> it may be easier in some cases for maintainers to fix the issues
> themselves rather than review our patches, since we are not experts in
> every subsystem.

Sorry, I was AFK for the last 2.5 weeks.
I expect you to make the changes I asked for.
There are multiple teams doing the same thing as you are,
and nobody else has so many tags.
