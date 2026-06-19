Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6662F0673
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781895548; cv=none; b=ufQ6xeYQrlV9EDvvjwmj1QY5fmBNye3MGW8LEcv+Fms0I1moOUI8txMmNjudjRJFdObLPvLjq/mVmjtDfC6uMub0k/vunJzv61nuI4gEwV5B8kDLLHNOwben1VLhFYGwRh8AkuHzFBNVJA/Vst+onG9gnCFe8/H2gXM74A97DGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781895548; c=relaxed/simple;
	bh=3xoc+MgBbsYploLvsc8b8bH6RypGtVgGv8FJBKJAIxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7s8nwdsy+gFngTun72PC7/jQJXkF4GXAjSZx173x0vo9kpBgbuLpp0Z9qcay1gLCGZmDfZ7z9/PmRjN2e539F8q/ugBb+wl1o32KHOqEBr44T8VaJDbqczlBT5jrjb4T/BnJcyLaKwhuKXRvs4+tXQPWKncf34m9/uG8M5zF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKA2X3EW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKA2X3EW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6499B1F000E9;
	Fri, 19 Jun 2026 18:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781895547;
	bh=VigYqZblo65nizyYnycHDfJBDmQN4QsVnu3a3OLTcBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SKA2X3EWsck25o+2f/V+052015pnOe+qyVL3ulj3qIaLuVVLXmshYGdzGd14Nzl4k
	 3HG4oyt3Fz1vDRCC9NGurJI7WmFZnUnXt7T5/nFJmAi3fKusyckSBc2W3R6p/up9UL
	 Wlobxz6tvfRB3PRgYSeZQMi6P9x2TQw5npkzxEViV6r9jrNxmJLvG0xLKY0vP+5WO5
	 ZFzLeoFAtCxkAY4p8MKjIXVBzEyaO1swC/ANBx2qbV3qOWJYDJFAootYJtF/iLRUmV
	 eZMAbsUM41mU7gaiRIDTX+pbOKPf3MIGYIsAFuKvfvtbz3DYubP03NEUbicLetCQ4Q
	 +4M49E5eF5XKA==
Date: Fri, 19 Jun 2026 11:59:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sheena Mohan <sheenamo@google.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, Eric
 Dumazet <edumazet@google.com>, pabeni@redhat.com, horms@kernel.org, Willem
 de Bruijn <willemb@google.com>, Max Yuan <maxyuan@google.com>, Pin-yen Lin
 <treapking@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Joshua Washington <joshwash@google.com>, Danny Gonzalez
 <digonzal@google.com>, David Decotigny <decot@google.com>, Brian Vazquez
 <brianvv@google.com>
Subject: Re: [ANN] Google's Netdev-CI for IDPF and GVE
Message-ID: <20260619115905.051eb340@kernel.org>
In-Reply-To: <CADWJPTsg5G21=hybo81+QHv0+g64d3a+6gGUaJSm1i7EttCUcw@mail.gmail.com>
References: <CADWJPTsg5G21=hybo81+QHv0+g64d3a+6gGUaJSm1i7EttCUcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 13:44:48 -0700 Sheena Mohan wrote:
> Hi everyone,
> 
> We are happy to share that Netdev-CI testing on both IDPF (running on
> Google Bare Metal) and GVE (running on Google Virtual Machines) is now
> up and running.
> This NIPA integration work enables executing kselftests against the
> current proposed net-next kernel branch on real hardware.
> 
> Thanks to Danny, Max, and Pin-yen for their contributions!
> 
> The test results and logs are available in:
> 
> IDPF Results: https://idpf-netdev-nipa.static.usercontent.goog/json/results.json
> GVE Results: https://gve-netdev-nipa.static.usercontent.goog/json/results.json

Hi Sheena!

The Google runners do not report device info. The results should
contain a "device" object that identifies external components that
may cause regressions (like device FW version), see:
https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system/#device-information
In practice the main use we currently have for it is to auto-categorize
the results as executing on a real driver rather than netdevsim.
