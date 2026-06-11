Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF5BBA45
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781136413; cv=none; b=Mk9jXlEI6CaN7pqZ/z96oyEL4ZYaF4Qe5c8zMxhCPbvD9BWA6nKl5vKjTeBZNAS089CmJ2Bz+C87sSNgC122eyIcM4ugRI9JZ28BFPJb+9UKn06p2DpLa6yKnW0P2vE761tz6ix8csSLFWDoNRF4aJL9WYeNBmjbsB0Je9LfNw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781136413; c=relaxed/simple;
	bh=opwZYFjw1C+K7yD2fdnvkd6ySXHpFRZH5+JJUntkwbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eESxzUnsCgaRQm7i/39TuMT2/LOcV0f4niQ6zfopoAyRHUHy+y6tqx6yzQdVTwzhGNqKM6wi8Fo2qefR2cww1vACck+rqH5HfNyCcz5ZDSpwuxW/qB+acV0COVdnxwY617eK/a5Xt02ZF5MLFqImb9ahbVzZ7tuNaj/fn9V8dOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot4giLfA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot4giLfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DB51F00893;
	Thu, 11 Jun 2026 00:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781136412;
	bh=9kwRUtaezQXlpiw8kRXkY9fNBNAuiSaFjv6pGKaMjPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ot4giLfAAIKSXZOebXDUIsfBfKi1qD7nxMMC5U3025K4AccnFcgNv4D+cioc66JFB
	 8ECik3qkF2fG4I78eHFsDiq7Cr1v+TvNL8nLxxJ5LErUPsgQhfh5j7nBEG6LHSZm+7
	 ioqmzEu6B5ngV7Crr900Z81bn5yleYBvfBIf7QuMrooQSxcIMkr/A/0ygKBzabb1BV
	 vKqyLNYcxz+NYdm72P0mSwc2zZac+5vtkGjMSndybaaQ0jJJXFiJ0cH/FcDjxexYuC
	 8Nw/h1vZkgfpJ35r1dQub68cdyVWj/w0O7+vzKbfd3/vZVBd+HcLN74Gk9PyTIhc0n
	 +UvKjw3h9cICg==
Date: Wed, 10 Jun 2026 17:06:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next v2 0/2] selftests: drv-net: so_txtime: trivial
 fixes
Message-ID: <20260610170651.1b644001@kernel.org>
In-Reply-To: <willemdebruijn.kernel.6915d686a22b@gmail.com>
References: <20260609180803.1093428-1-kuba@kernel.org>
	<willemdebruijn.kernel.2888ce77104d1@gmail.com>
	<willemdebruijn.kernel.6915d686a22b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Jun 2026 22:48:34 -0400 Willem de Bruijn wrote:
> Willem de Bruijn wrote:
> > Jakub Kicinski wrote:  
> > > I noticed that so_txtime is only passing on NIPA setups which are
> > > looped within a single host. The cross-machine cases just flat out
> > > fail. The initial bug is obvious - the test does not deploy the binary.
> > > But even with that I think more work would be needed to sync the
> > > time / adjust the expectations for a dual-machine test.
> > > 
> > > Willem promised to follow up on the fundamental issues with 2-host
> > > setups :)  
> > 
> > Yep.  
> 
> With these fixes the tests run fine manually on a non-dbg kernel.
> 
> The CI failures are on the netdev-X710-dbg remote only, correct?
> 
> https://netdev.bots.linux.dev/flakes.html
> https://netdev.bots.linux.dev/contest.html?executor=hwksft-X710-dbg&test=so-txtime-py
> 
> Those flakes all have a delivery later than expected, e.g.,
> 
>     # # Exception|   STDERR: payload:a delay:30747 expected:0 (us)
>     # # Exception|           exceeds variance (4000 us)
> 
> Does this remote have KSFT_MACHINE_SLOW set? This should only result in error
> 
> From contest/remote/lib/vm.py on nipa.git:
> 
>         slowdown = self.config.getfloat('vm', 'slowdown', fallback=0)
>         if slowdown:
>             self.cmd("export KSFT_MACHINE_SLOW=yes")
> 
> But I don't know where (or whether) I can review this config.

Ah, that's probably buggy. You can sort-of see the config written
dynamically here 
https://netdev.bots.linux.dev/logs/hwksft/X710-dbg/results/684641/deploy

I will fix the SLOW part, but I don't think that's the main problem, if
you look at
https://netdev.bots.linux.dev/devices.html
the X710-dbg is actually the only setup that had enough passes to
qualify as test supported. The blue cases mean that for most of the
other NICs half of the test cases fail. X710 non-debug probably dies
because we're waiting for a fix to a NAPI deadlock an earlier test
triggers, ignore it.
