Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4813BFE3F;
	Fri,  2 Oct 2026 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925608; cv=none; b=DbNrsuRbTPsnXyuYZAyYmvigSAV6tycI1kXBhGG56LjSfxzF7CSS19FDb6hihGXxeS508ZTNDkHzgumKzu8hR43DWPVYN5ElVNTMc04bdTrXYfaagbshq8Zk07tTVRMsx2dlArBIAo3TFE6pe9y0L4o3RsAh7TzwBmoIdN0aZ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925608; c=relaxed/simple;
	bh=tPzhPp4Q0QB/YbRaVMxgIOdsN2JAnmE/9DFUu2lTg7s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bM/KQ7GHy7zODWdEdH1SPuyNEmZs+GCJUGudkhKGRWrCvxA1ILT/VnCZjlOgUiOEjxoMMKA+/oofxqkzzTKE9IEtqn2bQTzqJ3UMTbYnO2kzfgynyWUOjp5ZKSsIS1ljCNhCeoV0fU2QDknwr0T4cdHSkOHdTaTeIGYVOsXxcAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2hY/6Na; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2hY/6Na"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB751F000FF;
	Fri,  2 Oct 2026 07:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790925606;
	bh=7m8lXQnUCXbFURU3BXp9HDrDdUur2zjNaFycgsPpG1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b2hY/6Nay5aTJkmzAv3QA6hyIHPlzlVpDu/4vYYjDHa9Ck7b5OPn849cKX+CMjQhF
	 A1dWZ7RPIxUCa+t0zGG6SjbpkyhH56u6Px8uPpXqHE1BSXgqx7UYQ10y9nNl4DTVii
	 LYB1Xpy1UQIR+pIkuFGLhoGNVKJ7qBcMIkVFGzJmmZiBT3V8gmOnUeerzMnDwGr6cf
	 ws9HIpjpXsiQ8f6a8UPuuEnON/9pbht55bIZWJWnRkZIniOVZM3seycYFSxMx2snHI
	 rnvAm6ios9vw0UxMhqgsnsH34xvKsPgrXgkJKOPzYzRZupXmcLT4UgLWsZ8jb1FBEW
	 KdFsDTQMb/RzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44F03811967;
	Fri,  2 Oct 2026 07:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] lib/dim: fix 32-bit overflow in dim_calc_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179092560553.3252757.15314199438024209993.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 07:20:05 +0000
References: <20260927051743.71460-1-jain.sm@gmail.com>
In-Reply-To: <20260927051743.71460-1-jain.sm@gmail.com>
To: shashank Jain <jain.sm@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 talgi@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 27 Sep 2026 10:47:41 +0530 you wrote:
> On 32-bit kernels dim_calc_stats() multiplies the u32 byte, packet and
> completion counts of a DIM window by USEC_PER_MSEC (1000L) in 32-bit
> long arithmetic. Once a window carries more than about 4.3 MB, bpms
> wraps, and net_dim steers interrupt moderation on a meaningless
> throughput value. At 1 Gbit/s line rate a 64-event window passes that
> size when there are fewer than about 1,860 DIM events per second,
> which is common while NAPI keeps the interrupt masked under load.
> 32-bit users of the library include mtk_eth_soc (MT7621, MT7623),
> bcmgenet and bcmsysport on 32-bit ARM, xilinx_axienet on Zynq-7000 and
> MicroBlaze, and virtio_net in 32-bit guests. The overflow goes back to
> the mlx5e code the library was moved from.
> 
> [...]

Here is the summary with links:
  - [net,1/2] lib/dim: fix 32-bit overflow in dim_calc_stats() rates
    https://git.kernel.org/netdev/net/c/0843b2389064
  - [net,2/2] lib/dim: add KUnit test for dim_calc_stats()
    https://git.kernel.org/netdev/net/c/636035157a81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


