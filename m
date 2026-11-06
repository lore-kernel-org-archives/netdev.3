Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958023;
	b=abZVx7deO9josr7CLKJ13/q6AMNbdzeBSO5BvqkN/HLGgXnyofuC+HIicvBFoaVbBzPk
	 BJNb6OSiDbJLkbo53+XEpChuZ1tYkI+9VA1YtrQ2pOg+1PPNl68pr6n/5Wr2sp6PkKZmB
	 DhWXqrOIxsUSI1JyOkcou3u9I0DorkZ6p74ekbDmFeP6ByojS0VKRVLVRtxyODzwx5lP7
	 lNXtIn4eLW4nYXH6F1bXdjJa3eqKtcgCIuONoKDQi/szIe0tbv7QksKotUWE50fKG/L72
	 LWmErkohWFNPHLMMHAg0fO9vRHzxUeE2PFofts+OzGpkic7PiqmBeuYoA3zRk5eZzPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958023;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=VJy/31DrL9o7BAtBd/bUoeYF+vPcq5nyrybnUYKjAG8=;
	b=ZdNoY8iXc9ubwgGcnF1BUljGZ2sSPAfeBTP46LUvulEGd8UaCO0CeN7ikyziMkyiy9vX
	 XNzdz7spTJ2VxkN3GStqgw5mjARjK/R6a3EKXQ3p2zNkTQqFNIGv9gfWFDtDB/KLTJIt7
	 mBGfFm2mMoLSjR1P8jY7YW8IvnHAKHjnBIBcCn6ciuenrjRd2LEJzD/jWX0/aOfVLxZK0
	 BsCwSFRrKwJKY17oaD0Yda8q9f5eU4SLUYU5EvfKJfKY/cDsCoawsxbfTd8LicKyxOvO5
	 7DPU8oEucFqLvjas9vB9MiOuZe/2eEsWqIxBB1zSWYkPrStSvBgYpkvr3a36Rs1ARvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CyCDJDu6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9C606A920
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CyCDJDu6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505431F0089F;
	Fri,  6 Nov 2026 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793958022;
	bh=VJy/31DrL9o7BAtBd/bUoeYF+vPcq5nyrybnUYKjAG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CyCDJDu64khWqNvki1ZO1K7A5zpbPWM+PYeIVV9vCqA2qfRqgqdethRzgSJnt8NIF
	 6U5hfF43t6oxRoElI4V9E8+35dHay2049pdQ4U5eZZD5LYZY2TdlIRJm5s4EQKk2H3
	 sOgoY+EJOCPVPKACP9BmyOrTWmiR8aGj3erhpfTdFHntUiMtftVJvrd4how8dab5IO
	 jG5zmgaw8ySHN1bpIEkuIFo2x0HDmrfb3ZVm3Q4FCe/EtefZgEA4erLx5KwepjGUMk
	 Fglhx9RXIPKQMOblgHlcvwfeR8/uTtlWqjBAjUM9HdsCf+k65/bqxt2Y2IUTjA752R
	 0MVA+nhn0Rx9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 45E9F392447B;
	Fri,  6 Nov 2026 09:40:22 +0000 (UTC)
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
Subject: Re: [PATCH v2 net] tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179395802105.491229.7639452799219614935.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 09:40:21 +0000
References: <20261030111528.2850082-1-edumazet@kernel.org>
In-Reply-To: <20261030111528.2850082-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, mason@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Oct 2026 12:15:28 +0100 you wrote:
> snd_cwnd has no practical upper bound: snd_cwnd_clamp defaults to ~0,
> and RTAX_INITCWND, a locked RTAX_CWND metric, TCP_BPF_IW and
> TCP_BPF_SNDCWND_CLAMP accept any positive value.
> 
> Congestion control modules do u32 arithmetic on cwnd that assumes
> much smaller values. For instance, ssthresh() handlers compute:
> 
> [...]

Here is the summary with links:
  - [v2,net] tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND
    https://git.kernel.org/netdev/net/c/475ff14ba558

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


