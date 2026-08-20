Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6E3E120E;
	Thu, 20 Aug 2026 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255462; cv=none; b=Si+uloZzXuI8FrnlUiRxsrSBuG/I59uBnZR4wY1ba4GLSj14YnCu0Hk2j5RCX/D/EjOiIugoanZrESImYqQx2sQj8m2QtbLzWNtmkSefockH9g9jeEQxDaDHdS7nesu8eHDBmPjIe2wHqC+l32myKoL8kbGTzjwUuLgg6yMKdAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255462; c=relaxed/simple;
	bh=wuwKj++hBmQ4RvHLHuky/RnLsdU6N0Cl0ZCg7sQbQ7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DdmtteuBIVXIsCUt2af4IS6fLaE1/KxcysVmwnn+naYwbjWuRAAEqAFqOIeXD8SSxayVi0rH5XefGILBmMqHJgoD4dLBu3PutlMOIR6B/WdD7739+yF104oKsMp168/cBeZ0OEnzkDTdKdI6reK2olrvlmxrMQ7CNVC79bacX4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpdXyeDq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpdXyeDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBEB1F00A3A;
	Thu, 20 Aug 2026 19:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787255460;
	bh=CNHKtVZsFlNF+ExEc5jU2C2018Jh8S7YHVTFAWYAc4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GpdXyeDqk1J5hkmXgXcj+fbsdtDWjUDj7pWGPwtodFEnUMuXdMzoCbhReTwqumVJ3
	 3qlu2MMcN9cm8R8PE2QBy1nx8aa2JgohSRhUCyxAtQqkXDTCavFyb7a0+71bvZMt2j
	 bxm2ZCSiJlFh0ucAEIelYFBP4yPWCJFbQUVvQkFElcI8trfPiTkmrDKQ30q+A7kzWV
	 3AfUseCB3EAtGiFlN6ylYXh4qH4MNQHsGSsiTcDyA56MK2mXgyODL4KXN8Qc6YnaJs
	 uVgIpwTMy3LfQu1WSH45ouh5FotaGLbtrEWoB5/1H3v1ZmULO7dr5QQpA/p2YaIa7J
	 d1iZsJoBHxsBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56892392445B;
	Thu, 20 Aug 2026 19:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: avoid divide by zero in rt6_multipath_rebalance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725541088.453960.4449690139122804509.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 19:50:10 +0000
References: <20260817013237.2797-1-blbllhy@gmail.com>
In-Reply-To: <20260817013237.2797-1-blbllhy@gmail.com>
To: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu,
 tgopinath@linux.microsoft.com, kys@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 16 Aug 2026 21:32:37 -0400 you wrote:
> rt6_multipath_rebalance() calculates the total eligible nexthop weight
> in one pass and programs upper bounds in a second pass. Since
> RTM_NEWROUTE is RTNL-free, a concurrent
> ignore_routes_with_linkdown update can make the first pass return zero
> while the second sees an eligible nexthop, causing
> rt6_upper_bound_set() to divide by zero.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: avoid divide by zero in rt6_multipath_rebalance
    https://git.kernel.org/netdev/net/c/d2c26c2911dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


