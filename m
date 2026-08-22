Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004BA25228C;
	Sat, 22 Aug 2026 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787432461; cv=none; b=sJYgoJWvDV5Yvd7dF5YSUyt2uTh8a7dzxz3h7wm/gLMdbg/6YxqYmlC02zIQDRibvS/XSVscRZcCrV5HPqPEEJtDDmZjH9bB5AP98aJYB/NPFiecazDztoTkI5yw5gffPWegissl4/V9Urk01U0LUCvSY5AItVKvXsJrnSRh4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787432461; c=relaxed/simple;
	bh=tAiGPIF5mxYF7nO36+AWFjDBMRHsgpVxlWZKnbb9O+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LVGyF9AZrb6RGgmU76pSb/28ct6cSMZmQ2hnWGF3LuLI1o8UTu8RJbeCxIA+yYFvlpzB7stHaLeliDvaCX+nNTSUXtXhKvEvlBOwBYW3S9CH7B07I0nK4Ilu21DG806pgfKyGyt/5frLgMkuzVaDgeCcqGcIkPwH9xTdfbj7A7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdRyfj93; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdRyfj93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F921F000E9;
	Sat, 22 Aug 2026 21:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787432459;
	bh=LGDmQ6cRbjMqxOx1LEurkxiARKkNGjBPY8XmdJnrS3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jdRyfj93vxhfufbeVuk03gqS/sWPCW/dXhFCoburWg6VFmZG7uN2160yqjd5q5eXm
	 yOm+pG2qslkox75oD4Q9GIoJChDJKXtkIpXgdAFJSPq8O4RzE568oLDVkYUzVDDsVs
	 EN59JXq4604UdkRm+qWABeSk9P6yeeaVqwSzBk3ellX9x//tmRW/wBGmO9XkRmwmBi
	 bMBUW+MboEZdmGlyV/Rc1/kYNR8TsMNVbd6h3MfE3w2jJvdv4MWZ2WZc63NQer/7g/
	 pXB9aa3a1mXI/zAeAIWyFvr9d1gUFIB3+KXi9xploBPwPYkxHbNUXidS7nkVvjBAPg
	 gfBQ2fXuiv0IA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AD1380CEF9;
	Sat, 22 Aug 2026 21:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net/sched: sch_cake: fix autorate reconfiguration
 throttling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178743240841.1826211.17628425791592872645.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 21:00:08 +0000
References: <20260820154503.892214-1-ooonea@gmail.com>
In-Reply-To: <20260820154503.892214-1-ooonea@gmail.com>
To: Giuseppe Piscitelli <ooonea@gmail.com>
Cc: toke@toke.dk, jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Aug 2026 17:45:03 +0200 you wrote:
> CAKE's autorate-ingress path intends to limit shaper reconfiguration to
> once per 250 ms, but last_reconfig_time is only checked and never updated.
> Since the field stays zero, every qualifying capacity-estimate window can
> call cake_reconfigure(), causing avoidable rate churn and scheduler work
> under bursty traffic.
> 
> Store the current timestamp when autorate actually reconfigures the qdisc
> so the guard enforces the intended interval.
> 
> [...]

Here is the summary with links:
  - [net,v3] net/sched: sch_cake: fix autorate reconfiguration throttling
    https://git.kernel.org/netdev/net/c/7cbfb180945c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


