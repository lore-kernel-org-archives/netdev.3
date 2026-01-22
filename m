Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C22EDD50;
	Thu, 22 Jan 2026 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074209; cv=none; b=efT8yTPNkKLNM/dzTQwHnjQZcRtlPwi83Nn9NacfstHnROz7QG9HJrg+tNrRiWLkYlK4jDjms7LL4gewogkotSsmM1Q54fx49ADTnqxbYzlJQwh6M9644/6gcouTbeU3z9oe1VRhjXx6dKBKIhDOLju0ORl5/BA4A2H3jrDPHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074209; c=relaxed/simple;
	bh=I10qtw4AuqjvQ3LR0Jev+D+5WzgJB1bu/X/od3acSiE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H0TiJUtFH8YNnW0Xt8rDRcuCC940oHHPzBjqig9M6+tUJ2IQs4wVkrnJ64/zga4S5xKsYp4amgFRV42VGm7m4cx1ItQtEVglGZIYbjdxR2s+UJYglVF8poEV7UOIRoWWLddvVIW1Y3wpXP9kIv2hYidFRZSySFQfmu0Vl+esTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHAS5bwz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHAS5bwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9930C116C6;
	Thu, 22 Jan 2026 09:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769074209;
	bh=I10qtw4AuqjvQ3LR0Jev+D+5WzgJB1bu/X/od3acSiE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HHAS5bwzQF7B5M67lTzWaShDAspgjfK1A6ehkOIQeBGvMJyH44tKscWd236eQzoLI
	 9Na5oLiRqzN0C6gvBbd+yIBv2E0kAvQpx4dmEwFfMV+Xn8kiS8hAPSIdGH19BqyvVY
	 t0vo/zPSSYTDFmadfWmspgIx+71hxWIHidRkMqj+91PuRSQrDYUgYmiHt/vf9opPq6
	 WBl32qdHA72DHJSvjwrv9xDeXpz+j1tyfFGE+f2Kp80befKfKndQv4YN0buVJ1yeRs
	 0gYwn6IOvFE6nC+0qWNspvOb/5/ibnzo3myWTUHNwW5jxkorwZrLHcXdc+aSD5Vqhf
	 VjBl1DeJjJDSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8B373808200;
	Thu, 22 Jan 2026 09:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: dsa: yt921x: Add LAG offloading support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176907420560.1633383.11427231039185597509.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 09:30:05 +0000
References: <20260117162116.1063043-1-mmyangfl@gmail.com>
In-Reply-To: <20260117162116.1063043-1-mmyangfl@gmail.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 18 Jan 2026 00:21:11 +0800 you wrote:
> Add offloading for a link aggregation group supported by the YT921x
> switches.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
> v1: https://lore.kernel.org/r/20260114151448.253238-1-mmyangfl@gmail.com
>   - fix malfunctionality of port_lag_leave
> Picked from: https://lore.kernel.org/r/20251126093240.2853294-5-mmyangfl@gmail.com
>  drivers/net/dsa/yt921x.c | 186 +++++++++++++++++++++++++++++++++++++++
>  drivers/net/dsa/yt921x.h |  20 +++++
>  2 files changed, 206 insertions(+)

Here is the summary with links:
  - [net-next,v2] net: dsa: yt921x: Add LAG offloading support
    https://git.kernel.org/netdev/net-next/c/0b42aeb46873

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


