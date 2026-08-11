Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA9D3D5652
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469914; cv=none; b=imorZRhENT0XXbFNBU4q5qT6ZqbP4LmwvgVbBOd8KhPm2s4geEPqzY4kojpEQMgewTjDkxMc5WezE4yc9tVPczMOOgaNNGeCfXYDByxLLCIeVl9YpPcfQ2Jy1l0+wiWk3xDsR4pjIvISGiUbI4bpNDNUwVqergwu07wvSDnMXdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469914; c=relaxed/simple;
	bh=AO8L/nHmwhyFRvynyICoW8OXiUXfxqM9iOetJWHXPDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMp2Wz2Hep4zRcgKtjRWjxESYUVcSD63JNofoM93Q5uW0Q3oLO6iT2dF8PTrRFjiO+lbsWaoWa1OlBjhPRuz+VKVnnHRSUfMCvudJkakWPVUAQYvJobpYi/rWTSS2Hqeq3yIZuaRIIczQJog9k4arBtuk3V0GGpXmK+IyaAZCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4+8fo8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4+8fo8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9681F000E9;
	Tue, 11 Aug 2026 17:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786469912;
	bh=EYPN2D9l4PpCiPaMMDisxJbvXFzXjGlYPKFgl3xRBQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a4+8fo8d4uvoh/1FS3wZ4eiF8JXcHTWNp1uWMQwlKcnRDu/oWm6XqAbzjuHMqpRaq
	 tTPlnhcHcDBLdqeYI15UF3CDEuNhobHz+9flC6WqaxejqfAsHHicLrnfINjWoF+bO5
	 +lUeR+Dx2nV1wsyc3AIkab2G7diXW5S575FI78MN2oOT0jrGmnNzez3unronxSys+s
	 BEPNWASdEoneMmd2HHBubbLr19xiGy3HdvKoIU3r567E6oN3C3JwNnA3sCYb51PdcJ
	 JzehdhwYVQxUujGH8rMY1tL7PiM4elmyY5vEUQhMJLLI9zhogCGhtopqiXgAk5R02k
	 /C/D3BopE8YcQ==
Date: Tue, 11 Aug 2026 10:38:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nimrod Oren <noren@nvidia.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [TEST] CX7 timeouts on reconfig w/ page pool failure injection
Message-ID: <20260811103832.28e5c8d4@kernel.org>
In-Reply-To: <8aa8c49b-736c-42b3-92d3-26bdfeb90a22@nvidia.com>
References: <20260804094518.53b56d24@kernel.org>
	<7caf12fd-f63b-46f0-a5bd-e9887cb25f9d@nvidia.com>
	<20260811080433.26f404dd@kernel.org>
	<8aa8c49b-736c-42b3-92d3-26bdfeb90a22@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 19:57:31 +0300 Nimrod Oren wrote:
> On 11/08/2026 18:04, Jakub Kicinski wrote:
> > On Tue, 11 Aug 2026 10:20:52 +0300 Nimrod Oren wrote:  
> >> On 04/08/2026 19:45, Jakub Kicinski wrote:  
>  [...]  
> >>
> >> Seems like the bigger culprit is the earlier xdp test, which leaves MTU
> >> at 9000:
> >>
> >> # # Defer Exception| net.lib.py.utils.CmdExitFailure: Command failed
> >> # # Defer Exception| CMD: ip link set dev ens25f1np1 mtu 1500 xdpdrv off
> >> # # Defer Exception|   EXIT: -15
> >> # # Defer Exception|
> >> # not ok 17 xdp.test_xdp_native_adjst_head_grow_data.ipv4
> >> # # Totals: pass:14 fail:3 xfail:0 xpass:0 skip:0 error:0
> >> not ok 1 selftests: drivers/net: xdp.py # TIMEOUT 360 seconds
> >>
> >> https://netdev.bots.linux.dev/logview.html?f=/logs/hwksft/CX7-dbg/results/763842/test-outputs/13-xdp-py/stdout  
> > 
> > Ah, well spotted. That's the test timeout, I'll bump the timeout from
> > the current 6min to 10min. Once it passes we'll know the true time
> > needed, and we shall set the timeout to 150% of the expected case..
> 
> Sounds good, thanks.

10min wasn't enough, bumping to 15min :(

> >> I'll try to reproduce this internally and investigate what happened.
> >>
> >> Also, I noticed that the pp-alloc test isn't properly restoring the rx
> >> ring size due to the timeout. In the subsequent retry, it's attempting
> >> to double it again, this time from 2K to 4K:
> >>
> >> # # Exception| subprocess.TimeoutExpired: Command '['ethtool', '-G',
> >> 'ens25f1np1', 'rx', '4096']' timed out after 20 seconds
> >> # # Exception|
> >> # not ok 1 pp_alloc_fail.test_pp_alloc
> >>
> >> https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/763842/test-outputs/36-pp-alloc-fail-py-retry/stdout
> >>
> >> The high MTU and ring size along with the heavy debug kernel likely make
> >> the pp-alloc test significantly slower. I'll also prepare a patch to fix
> >> this pp-alloc cleanup issue.  
> > 
> > To be clear - if the commands time out - how can we fix the cleanup?
> > Or do you mean some other bug?  
> 
> In the pp-alloc test, the ring size command timed out, but the change
> was still applied in the end.
> 
> Currently that test only attempts to restore the original ring size if
> the set command returns successfully. This case makes me think that it
> should attempt the restoration regardless...

Would the defer() not time out as well if the command to apply 
the config timed out? Any idea what the main time consumer is 
for the reconfig? It can't be anything device related since 
the device isn't really impacted by kernel config options...
