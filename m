Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AC236E466
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040079; cv=none; b=imlr+OsfkYFIaA/ZG3LtZLSeY3abuyqwINEFOQNbQ+1+oXGF8skYh3oJKL9XY+oW1Kp48IHDfbQhShQJ2Hp9qzeYg08jYJnfoJPeCRmZT/ll3jl5lijbOy9xT7KtzdGxheoMoktRJDDe5noBZ3CWBk7gocydSgXeIQeqOC074bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040079; c=relaxed/simple;
	bh=NKGuqBQXSTwGERfFBUT5cB4oBC4C2dn3LS+jSTGmTl8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hSMXjMfbpkQMgJcCxO97gFdeiGHslO8Aiu9sQpMP/U4bdqh2SmBKyQWVFM5OoIy/h25zffFFV1mr6cahM5fg+pDUSJmcUDBaDBcwU9Q08uLNbii6KHxC8/pWBcb8pf18wfaVF5mAEzCigf+yUE0VduEKFI/pVIvww1/Zeh2eBRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKKTbwrj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKKTbwrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7A91F000FF;
	Tue, 22 Sep 2026 01:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040077;
	bh=NrB9YHNtF8OwQSZIE6NqUHnLzMYtGLfCUlUAztkZ9MQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fKKTbwrj22JMu56c5J1h34Wa04+Y9YXHF5YYm7W3VbbREK1n5QETLo659PuiGZ5R0
	 IiSjOxUlzGaplxo/ZZLt3NmL+5yI/aWB6DO+hBcwwbNg2+zkfvcEEMbq5eTVcA629a
	 maUoshJXRfV6JAB1/RG5VtIWgNxsd6lom78E+AEARqeLGMuaNdeU4P6ENZdTF6jXBF
	 pZTtWwehWZX4LgVj7SOb5qBCAK4NYxpWhYfPe0pR/bHU1pv4B0HnBuPjD7Pj9R6jga
	 HqWe+R8UR6bLuIFhaIMV78e1ypau7zCAoaOR4fN20N3EyKW2xu3091OvkcRlyfl3T4
	 lYAXEYKKu4BHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568583930205;
	Tue, 22 Sep 2026 01:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ipv6: Fix dst leak for uncached routes.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179004000917.3321385.6467403658630926082.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 01:20:09 +0000
References: <20260920191558.2990636-1-kuniyu@google.com>
In-Reply-To: <20260920191558.2990636-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org, liuhangbin@kylinos.cn,
 luoxuanqiang@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Sep 2026 19:14:32 +0000 you wrote:
> ip6_route_output_flags(), ip6_rt_put_flags(), and ip6_dst_check()
> detect an uncached route by list_empty(&rt->dst.rt_uncached),
> which replaced the static DST_NOCACHE flag check in commit
> a4c2fd7f7891 ("net: remove DST_NOCACHE flag").
> 
> When a device is unregistered, rt6_uncached_list_flush_dev()
> unlinks uncached routes tied to the device from rt6_uncached_list.
> 
> [...]

Here is the summary with links:
  - [v2,net] ipv6: Fix dst leak for uncached routes.
    https://git.kernel.org/netdev/net/c/be31fe6333f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


