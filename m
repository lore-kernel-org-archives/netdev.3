Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D323876B5
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460675; cv=none; b=KpQCc+gOmfPUCZJer4GEgw+RHMbKK/UBbBp/xgXVY4qYEPso3AG8gVOGU128Bgdcieq3Qxt5CR4Yy0i7yKpI0e1OwqJtOaxp7fEXAp5OdodLuqfSHySv8aWoPXujVOOdN8jEcHnsi4spmadK1yXdV7APT9ZOoYz6AS89AGCzMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460675; c=relaxed/simple;
	bh=HaYfx+HsB82cXyF43oq75mkYY6O6aax0nvb+1TP9Row=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuK3/H5OeeohoT9yASkxXphdynPRMyyb4yyJyQFT93NETmQDsGiG5sL34aUcveicXJtdJI7imCz4fpERigFY6F33qWbTrlJ54mVcxQgRcTh4P0ojfLYnbeouSqd9CIK5VusOPftiYzCc4PtO4ykIwDwxxTar9etx2DRRZrmkCRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTTdl/r0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTTdl/r0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5621F000E9;
	Tue, 11 Aug 2026 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786460673;
	bh=9DgPRv9z4hfip5vT/a5/QI3qjOCYApz9zA2l92w2VcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QTTdl/r0NFF8eRv+Ra7G/H4SeUiaUKbpc/ZoTHbO6Sm4YUAUTa6zOGZiQvNFbE6+H
	 1APpN2rSqTg3qUdGeZNQC6zT7jZLaq5iBr8s3KZixWz9yCwv6qsU0i2dqbKcL4eLpP
	 ufk09zXq+rJ4jnC/Dw5X6tR3dqgiyXBcraM1frJ+nnG5Re9WRk2ZD2igkkJjzD8USx
	 T6ReOKuN69ra06rtohWlZyCNH760L3GgKkcoRsgQsBZbzBnomWE1IJ7sxXvGf5hBCh
	 Qn0m0UJt6vRw5XMepBWSBkVY2aF0j2EDTLOL6oInUPxVzSTLOwL8pZjcvsYNvpk2E/
	 njWLnOu6alyCw==
Date: Tue, 11 Aug 2026 08:04:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nimrod Oren <noren@nvidia.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [TEST] CX7 timeouts on reconfig w/ page pool failure injection
Message-ID: <20260811080433.26f404dd@kernel.org>
In-Reply-To: <7caf12fd-f63b-46f0-a5bd-e9887cb25f9d@nvidia.com>
References: <20260804094518.53b56d24@kernel.org>
	<7caf12fd-f63b-46f0-a5bd-e9887cb25f9d@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 10:20:52 +0300 Nimrod Oren wrote:
> On 04/08/2026 19:45, Jakub Kicinski wrote:
> > Hi!
> > 
> > The CX7 testing in NIPA is looking pretty good, one major source of
> > noise, tho, is that the pp-alloc test sometimes locks rtnl for
> > a minute.
> > 
> > Here's a failure in that test itself:
> > 
> > # # Exception| subprocess.TimeoutExpired: Command '['ethtool', '-G', 'ens25f1np1', 'rx', '2048']' timed out after 20 seconds
> > # # Exception| 
> > # not ok 1 pp_alloc_fail.test_pp_alloc
> > 
> > https://netdev.bots.linux.dev/logview.html?f=/logs/hwksft/CX7-dbg/results/763842/test-outputs/36-pp-alloc-fail-py/stdout
> > 
> > Then the next test that runs also times out during setup:
> > 
> > # subprocess.TimeoutExpired: Command '['ip', '--json', '-d', 'link', 'show', 'dev', 'ens25f1np1']' timed out after 20 seconds
> > not ok 1 selftests: drivers/net/hw: rss_api.py # exit=1
> > 
> > https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/763842/test-outputs/37-rss-api-py/stdout
> > 
> > pp_alloc test can fail, but spilling into the next test is a problem.
> >  
> 
> Seems like the bigger culprit is the earlier xdp test, which leaves MTU
> at 9000:
> 
> # # Defer Exception| net.lib.py.utils.CmdExitFailure: Command failed
> # # Defer Exception| CMD: ip link set dev ens25f1np1 mtu 1500 xdpdrv off
> # # Defer Exception|   EXIT: -15
> # # Defer Exception|
> # not ok 17 xdp.test_xdp_native_adjst_head_grow_data.ipv4
> # # Totals: pass:14 fail:3 xfail:0 xpass:0 skip:0 error:0
> not ok 1 selftests: drivers/net: xdp.py # TIMEOUT 360 seconds
> 
> https://netdev.bots.linux.dev/logview.html?f=/logs/hwksft/CX7-dbg/results/763842/test-outputs/13-xdp-py/stdout

Ah, well spotted. That's the test timeout, I'll bump the timeout from
the current 6min to 10min. Once it passes we'll know the true time
needed, and we shall set the timeout to 150% of the expected case..

> I'll try to reproduce this internally and investigate what happened.
> 
> Also, I noticed that the pp-alloc test isn't properly restoring the rx
> ring size due to the timeout. In the subsequent retry, it's attempting
> to double it again, this time from 2K to 4K:
> 
> # # Exception| subprocess.TimeoutExpired: Command '['ethtool', '-G',
> 'ens25f1np1', 'rx', '4096']' timed out after 20 seconds
> # # Exception|
> # not ok 1 pp_alloc_fail.test_pp_alloc
> 
> https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/763842/test-outputs/36-pp-alloc-fail-py-retry/stdout
> 
> The high MTU and ring size along with the heavy debug kernel likely make
> the pp-alloc test significantly slower. I'll also prepare a patch to fix
> this pp-alloc cleanup issue.

To be clear - if the commands time out - how can we fix the cleanup?
Or do you mean some other bug?
