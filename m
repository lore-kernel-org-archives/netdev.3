Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921D027FB28
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768965019; cv=none; b=TOnSwh9Hc4kB1pKJXSLqEkaWt4E6iZL1GenSYGlVsa/MYQsCdox5GlNIDQoqdv87xY0hTWWiStHx+1JsHpQbHAExcOl93AvINDLS+8AJ5ryUttjbCwkoy4qFPQKe5/CI+4qxx/EFEBsL8gCTbNjnXdyE+rNGIIgZVoeQd1nVidk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768965019; c=relaxed/simple;
	bh=3VTwJZ4911ZPoVYCNM6vAt2rLjlaUZ1X/YoOJItfOEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XziTkpdpJxlIsxq6Sd1AYd+OT+xWKQytS4zdYbT+y4M+vWapzqWkU2AawmzF+cpTP5AjtAu1DLEAHSNY+PzeQv6RWob3+oEesCi6+nQfSF1DSPIJoO/eB30a4+/C6is+goBeRMbW12k5uCnhJJ75Lyx/v4e/1jV+zhikh1m+4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgkenn1K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgkenn1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73718C16AAE;
	Wed, 21 Jan 2026 03:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768965019;
	bh=3VTwJZ4911ZPoVYCNM6vAt2rLjlaUZ1X/YoOJItfOEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rgkenn1KSBwi0yJvValNtMjDF7/ptsM3/df5yHhq3x6Q3PGMb+PosVzsinAHaZcX6
	 idtVgrJOdCfbu951uOWjUwbyIV00JdcVST96gbQO66Zx2FdJPmaM3Pxwf2mO5tPv13
	 2j2fxkm18G5d+AZBJxLHuYmHg1hSvL8qNqcFuWCSkJ+kC9qV6biwDMpyP4ZwyA4h5L
	 NYFElggT5BWcpxAQtWpWtZ9Q9qqiAZ0kFNQLR624kqUnUv58Wuqw5aOYj7BHVvUICr
	 4FqjhaPWA/lMK8xcLtkeM/VCaSqmeuXs76sTzOI6hAbP5U6DyiyncFbBt7EpfdOASy
	 81Ar7Hk7KNj5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11B0D380820D;
	Wed, 21 Jan 2026 03:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: move tcp_rate_skb_delivered() to
 tcp_input.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896501663.707355.4363649836721876878.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 03:10:16 +0000
References: <20260118123204.2315993-1-edumazet@google.com>
In-Reply-To: <20260118123204.2315993-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Jan 2026 12:32:04 +0000 you wrote:
> tcp_rate_skb_delivered() is only called from tcp_input.c.
> Move it there and make it static.
> 
> Both gcc and clang are (auto)inlining it, TCP performance
> is increased at a small space cost.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/2 grow/shrink: 3/0 up/down: 509/-187 (322)
> Function                                     old     new   delta
> tcp_sacktag_walk                            1682    1867    +185
> tcp_ack                                     5230    5405    +175
> tcp_shifted_skb                              437     586    +149
> __pfx_tcp_rate_skb_delivered                  16       -     -16
> tcp_rate_skb_delivered                       171       -    -171
> Total: Before=22566192, After=22566514, chg +0.00%
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: move tcp_rate_skb_delivered() to tcp_input.c
    https://git.kernel.org/netdev/net-next/c/670ade3bfae6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


