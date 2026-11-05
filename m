Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920809;
	b=J4aLJ+wDM+zeEWoHUEvHLPhDT4EkFv0xmZblTMz2l84uxa7uw9X95XoL6nfl+OJConQF
	 OLT2uCKaXwhzu6HPH4kGc7m64JCG11xzoPZ29So5Nj7pzSw4HnmDHIToUT9unthV0Qbsp
	 V4gZf+wEo6TUqg2hd/F4u1U9u1HS+njPSWcIs1NDJPkdyl5nK8yfu1Lc0ARKM7wKh44tl
	 LfD/jN853qBdg86wpWqvha+eW3ozv5KLp3Z8DSLteQ5IC7qyEpSYSpkxwOkefkGn/cenc
	 lvtuzQJSmUxsbrIreuOVGdFdM17NVe4DgEzPDAGsAuZzNDXP+INbnoD/qj75GtKTvhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=zq9Swcff8lhyhFk7jolnkD6DEE09C+6F+9QpZgW9m7Y=;
	b=a0KmnbJaOU3ai+8SYux6r/EbhsX43NRSqV/20HErvY1HHeJI6qiNHPQKJeEhjQ7yxbyC
	 pXrqtCpUm3XfzVvrwBUBByQ4ymbty7O8NzRuQqWwVtW58bOQVNxVquubqSZQhwObROaWg
	 /CVpelFuM65dkgfkMIUtGrUE9IGNhHWbwP0KBcWJlH0QRBLLV5XdbnuU3rYxP1EgPu+ih
	 Si8dP2MJBRbEqcBvdZsMKgA36+f2rVrmu5VDK4AQZ9UAfnBHhn0AsafJlp8Ar+43fysYd
	 KfgPS+OEJ8ogxOY9BFK63zy6UxFWDV13PACJ7HFvE2X5TCmhiEOFIW49YOF+3bSUq4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMKYUgSX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2367606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMKYUgSX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691291F0089F;
	Thu,  5 Nov 2026 23:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793920808;
	bh=zq9Swcff8lhyhFk7jolnkD6DEE09C+6F+9QpZgW9m7Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LMKYUgSXLlINkjDthegEATNH5O94tzwkoa+Lrox1lvhy9Ko32MabMeKOEmGHOtp6h
	 p4NJgCwJj62cUGFkNyckw5vj5y5g3farAcCGQJ0HofYGyMldbJxVCTIEmlM1Lco3vX
	 TKgQn0q9kV+rfQlT94MlXzrZDsFHPJqmWY0oREvJ+2lEh9W/h4Dc5V6FYhzGHK3QmU
	 IEaUyib5IpskeEOrAq7PJHhz7egBP+4jSEXN8wQ0RSOL64pk0ah5V9ALBRdRRbZ8Ct
	 ndjH8mHG5O3Hy1pvwjN8m0R5hu/NKQA3HcPeyspXhgSzIYVyABD3eZSgcLXMrUWfB0
	 dAc1EHiWI+T/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E1B7391B1AB;
	Thu,  5 Nov 2026 23:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] ice: E825: PHY restart fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179392080717.233492.8399420640184326961.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 23:20:07 +0000
References: 
 <20261029-jk-e825c-critical-timestamping-fixes-v1-0-72128d1dd928@intel.com>
In-Reply-To: 
 <20261029-jk-e825c-critical-timestamping-fixes-v1-0-72128d1dd928@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Oct 2026 11:55:00 -0700 you wrote:
> This is a subset of the timestamp processing logic fixes that were
> previously posted at [1] and [2]. It focuses specifically on the E825 timer
> restart procedure, including three fixes which we have deemed the most
> critical for reaching customer deployments due to recently reported issues.
> 
> First, the driver is modified to stop clearing the PHY_REG_TX_OFFSET_READY
> register. This register controls whether a captured timestamp will have its
> "valid" bit set. A timestamp captured while this register still increments
> the internal counter. However, since the valid bit is clear, reads of this
> timestamp will not trigger the internal counter decrement, leading to an
> off-by-one error in the hardware logic. Instead of clearing the offset
> ready register, disable timestamp requests purely in software and mark
> outstanding timestamps as stale to prevent reporting timestamps that should
> be considered valid.
> 
> [...]

Here is the summary with links:
  - [net,1/3] ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
    https://git.kernel.org/netdev/net-next/c/ee1aa5830674
  - [net,2/3] ice: E825: clear PHY_TSTAMP memory prior to soft reset
    https://git.kernel.org/netdev/net-next/c/dbc36cb5c8d7
  - [net,3/3] ice: E825: perform a soft reset when starting the PHY timer
    https://git.kernel.org/netdev/net-next/c/24e335fff462

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


