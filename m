Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269C637998C
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787332460; cv=none; b=Okfnv2cu69apFVcW7f3cuOY7P3ju2ximISZjJj05A56ciV6mxbO8SmMyVjMmfYdwfNfCER1JFlO76XoVQmd/YUTr0uyMXs2uY7ZooUaIl7Bu3wW7w9lTf2eqtwuP16M18Pu0/8x3XN9S6BYz9UWsPNRtes3CVnk/CI9LUoIzOb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787332460; c=relaxed/simple;
	bh=9BVSPsZivGTwwObNabS7lnqHvPIO0yZeCN29g2/gWZU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DexzeZCg5u0TVNXOSKbJI1tvmIl0MPkURQ1NUiQwcfp6V1eejiN1PgtfRSzGwmjquej8RLPQ0XITI57VuyDfsxZ8486VbZxl5JQRM/sh5My3XjjW9pLo/AHAvEH1v8ivqadmzC0G4YWO68fLEX7abqeM7JOpiCW6Vw1iyLy5r4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=isrGfETZ; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="isrGfETZ"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2026082117141229a955b0ef00020734
        for <netdev@vger.kernel.org>;
        Fri, 21 Aug 2026 19:14:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Amp7TonfLQQCmQ63ymRvTi5wVBJ8saros+nDhb1Tf6M=;
 b=isrGfETZuR5SaCfX4BVh97wtJzmgVEzYpQjSgefKxhHm2ej9FvvEQCB+U26g0gSPVVLr8i
 jf/W5DKhgYn9GaMUjGi+287Yd6GX64x3eQcsHhRYWBFL1UOgFSliHEF2RYXm0DR+v1mtteVe
 tfgAHPCMEivxJMS7UxKHmdyZn+DLs2XvzbGnabU8+8iwa9fr11pOEDC9WXNumQFZ2GIWlElA
 SrdOdAxwmir7d1IAKhqr+rD8YaQfdhQ8Ff9kSDqvcZy1qQeT1cbOoaD59exCvHtctIU1c8yK
 wda6R0j6hkiXpdw9ILBPXyVxHMuPjZH3y5M6Oz+3JQZNlllPkYYu71Kw==;
Message-ID: <8e80acdfaeefa59f455f5e894d177a4a6c8bf3ff.camel@siemens.com>
Subject: Re: [PATCH RFC 1/3] cpumask: Honor irq_default_affinity in
 cpumask_local_spread()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Yury Norov
	 <ynorov@nvidia.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes	 <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner	 <tglx@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 netdev@vger.kernel.org, 	linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Date: Fri, 21 Aug 2026 19:14:11 +0200
In-Reply-To: <20260820160947.GZ5F-O0o@linutronix.de>
References: 
	<20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
	 <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-1-3f79a99cadaf@siemens.com>
	 <aoX4HuUxL4tNWvpq@yury> <20260820160947.GZ5F-O0o@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Thu, 2026-08-20 at 18:09 +0200, Sebastian Andrzej Siewior wrote:
> On 2026-08-19 14:38:22 [-0400], Yury Norov wrote:
> > > --- a/lib/cpumask.c
> > > +++ b/lib/cpumask.c
> > > @@ -81,8 +82,9 @@ void __init free_bootmem_cpumask_var(cpumask_var_t =
mask)
> > >   * @i: index number
> > >   * @node: local numa_node
> > >   *
> > > - * Return: online CPU according to a numa aware policy; local cpus a=
re returned
> > > - * first, followed by non-local ones, then it wraps around.
> > > + * Return: online CPU according to the default IRQ affinity and a nu=
ma aware
> > > + * policy; local cpus are returned first, followed by non-local ones=
, then it
> > > + * wraps around.
> > >   *
> > >   * For those who wants to enumerate all CPUs based on their NUMA dis=
tances,
> > >   * i.e. call this function in a loop, like:
> > > @@ -110,9 +112,9 @@ unsigned int cpumask_local_spread(unsigned int i,=
 int node)
> >=20
> > Please don't touch this function. There's ~40 users, and we don't want
> > to inspect every caller for their intention.
>=20
> While this might be okay for the NICs, the usage of PMUs shouldn't be
> changed. So yes, Yury's suggestion to create your own function and then
> move the drivers one by one makes sense.
> You might also want to verify that your setup/ design works on some
> "newer" multi queue NICs even after the number of queues is reconfigured
> at runtime.
>=20
> There is also netif_set_affinity_auto().
>=20

Thanks for this pointer. 4 users and yet another implementation that
ignores the current userspace settings...

I'll put this on my "to be revisited" list. Thanks!
