Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348607;
	b=oxAhbwpfwwFKkPy4RWVe6BHBZg2Cr1GWaNlz3cdH3Wmyx2wbnEAoyQ7gkENXBkiJ7BHf
	 dcEUTInLJl7AdSvVrDioWQpJYVd390n4TeG1IxefLaedi6Y+zkRxFNIr/rg7vibpvYQPw
	 W01gP3l9gbBXMnUwf0qHCAuqnj2Mmwy7Dg7PIpPaLPAUKTcnU9cYI3Po9lu0FY5Sx6LaG
	 njTXrGovoKOi0oCIP6s1giWE2R/rQwVDgbJbedb79u9FMH63x+ux9uVLouyBbunaj2mNU
	 /ClL0OlaAJwjZSaFdu2bmEXfPa98fEOPtWer+7AEKZhXG0b9ky/rPSvfD7KcddWuw0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=TGLwR1Msc2/5rMD5ND1Y/b0Ga8dYyfuPWs81S9wv3jQ=;
	b=RS+4vrUhC9PPAbJYRLoszgEzZjhZCsggX8sMySrny8xRhpFfF3lfXHSLfmcGo6f0LiRn
	 aRNWPUc0qQyuGpU3PqHUHmyErFxLWvlu0pPuTvLlnuijzgPjYcPoz7+pNR+9NgLuH4SCD
	 7+KybxqzJiLGhkeO+e1a8qmPmqNOTum5TaLHuX7xrPCBbNlEG4HIrfvLTFeKF4++EfJ/i
	 GUoBgYuSXbZxyPnG3vsCgm+P7waA5MWjIVGMk+oLRIVi533+3te+aUAeSZ9Ijl6gBAIUR
	 wV61KiK9nz70lZBjq8nkke54UUeGfNzqxf28QvzWapItVq/FcnvTxW4PLYTUsHCgnGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BN0Oeom+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5B606FFEE;
	Tue, 10 Nov 2026 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BN0Oeom+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3F61F008A1;
	Tue, 10 Nov 2026 22:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348606;
	bh=TGLwR1Msc2/5rMD5ND1Y/b0Ga8dYyfuPWs81S9wv3jQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BN0Oeom+eSyE43xeoI1Gor5+Swz7+IkujbxHHBV9Rn0qOxFrpRDCgFXwezUjT8Bfv
	 Bq3ejITt8ogg1NEARHBMzsp8EpMhOeDJVo9AeTjsQqEW9qGlYOsGwyB7Mqu2LtEw1K
	 mhyEDjP+2HsVGppLkIAxJb3fCR8aYjR1lmZh5zSMaYU05j3kKkuDxADqejEYz6mee3
	 /jgN6t5rHs6tjSdzzrZpJKuuuYedhI/MK4W088Gseax9x0Y1xsBIiAHPjbR1nabjcg
	 MJ925uA/qYmKFqN6uSLzheK3tjrB/QQxLCXvQ/WxTdQl1W/w4yygBf9Kz96qY5cCLx
	 RNOB/+k3IyMQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E11439E8A40;
	Tue, 10 Nov 2026 22:10:06 +0000 (UTC)
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
Subject: Re: [PATCH net v2] ipv4: route: don't blackhole in-use routes when
 retiring fnhe routes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179434860518.85266.421970211884178482.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 22:10:05 +0000
References: <20261105182640.2999521-1-me@chasehil.tz>
In-Reply-To: <20261105182640.2999521-1-me@chasehil.tz>
To: Chase Hiltz <me@chasehil.tz>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, weiwan@google.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Nov 2026 14:26:40 -0400 you wrote:
> When a route cached in a nexthop exception (fnhe) is replaced or
> flushed, rt_bind_exception() and fnhe_flush_routes() call
> dst_dev_put() on it. That sets dst->dev to blackhole_netdev and
> dst->input/output to dst_discard*(), but other CPUs can still be
> using the route, e.g. as a noref dst taken from the fnhe under RCU.
> Packets that reach dst_input() or dst_output() after that are dropped.
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv4: route: don't blackhole in-use routes when retiring fnhe routes
    https://git.kernel.org/netdev/net/c/ae89f2724db1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


