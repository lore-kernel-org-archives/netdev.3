Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D23546E2
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 00:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785543646; cv=none; b=XHzrwzL/gHouVsCF9otBqjF9USMIJ0QWT9FlWMY7utypPKzn53tfe0TL5wHegSxRKrIAh/QCO7dJX/F1MF8RrIlUZQdHn3EV02qdv2Q8R3rPlRbkdFXpE7s28MSEOnBO8ZVwmSQL8Xtr1X8k0I0vuYNXzerrYVKUSJtXuTkbsiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785543646; c=relaxed/simple;
	bh=ExTfHv0XymBEoYYlPRBtrzfnlw467wjziisJxp4n9wc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aTSecng53Bdu7fBiswhebc7JLJDr7FoKRxfLTsaNnM6hjilOF0WwkpuMWK5Dd5YblC5qbXpw5jSp+soADnPmGwQaHJ8m3DFieyMKa4UgX+Avy57B3pH2mp9+yKbbEUgwR+uSfPwn+0+cB72aSWqyB7vuWHmXvP9vN2tbw4u27qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vm08id2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vm08id2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE301F00AC4;
	Sat,  1 Aug 2026 00:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785543643;
	bh=RGFCzrdI6wOQmclPbAe7TM2+R/lGvKkZ7d8zid7c1zE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Vm08id2pTZJZ3ejMq4mx1y32OKFwCdyolNI8PNiEHEhEUxB9CjlokMOMZ05ge+B+e
	 pLEfUcBHYBLM68ypTZTFLdIncZfCMX+hDK19NFd4JQiSyqTRyD/8GaY6J9IJo90tD7
	 Nty65B6rXMvl2SyfGEfe2c+nIP0sqTHu+457jEVS01+DBG88XZUplSuFp6fjbm9Kj9
	 0YuyLcFeUnZXcCM93inRWsTmDJvHohmWpqEWhlRaoPUIsNjSnEqskdO86iUWocFqG/
	 ZyoSMLokcXx+wbdTCs7ljzA2ZSr9VOHtiTvdhwHLRKN081jvOVvuuIOYhUPuYC0fDb
	 PpKFHQroEigfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198B1392665D;
	Sat,  1 Aug 2026 00:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] inet: frags: publish queues before arming timer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178554360589.959828.7486774393820349436.git-patchwork-notify@kernel.org>
Date: Sat, 01 Aug 2026 00:20:05 +0000
References: <cover.1784948849.git.zhilinz@nebusec.ai>
In-Reply-To: <cover.1784948849.git.zhilinz@nebusec.ai>
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, vega@nebusec.ai, zhilinz@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Jul 2026 01:23:28 +0800 you wrote:
> From: Zhiling Zou <zhilinz@nebusec.ai>
> 
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/ipv4/inet_fragment.c. The bug is
> reachable by a non-root user after creating user and net namespaces with
> namespace-local CAP_NET_ADMIN and CAP_NET_RAW.
> 
> [...]

Here is the summary with links:
  - [net,1/1] inet: frags: publish queues before arming timer
    https://git.kernel.org/netdev/net/c/653d7ddf6cba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


