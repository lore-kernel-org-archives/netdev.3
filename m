Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561437F30C;
	Thu, 15 Oct 2026 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063209; cv=none; b=uG9VaZeQFcoSVmIWNeiGumalbNzwxdpL6C5EEk+X8ZjRHcpm2K+NpuPWgW4l7yHPQpRfhZM7rGn/iZY5ULmFZMINAaPBmEMYGVRDEvOF62Wo+prGi38LFSGYy+ErXhDH45s+bHUEAzYkv2ZDH7BA58UxSbtdWm2eTzow9oPIcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063209; c=relaxed/simple;
	bh=X8Bsj/av7N1bq06bbsG6kmwC3ix6qr6PQZrs/BSo6K8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IEFn+58zAWOwuteOpLpntzfqKdF7PrHUNK9PIk8JaluxrExICULiJH+QLvBOvA19pelq/h0DMLBlyv0FEB4Zt+gzhKNnyb7MQmofjBe89LbV9b0IJPIYFH7HjLpDEg7yWFivF3eKmcjSAb2RdsVFU/x+mmrSKxunaAIh1whYrA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwWjT0QI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwWjT0QI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426571F000C4;
	Thu, 15 Oct 2026 11:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792063208;
	bh=lgrVMdj5yYyyhIyAnAbx5XqHQjZOgNnhgooEuX9XfuI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cwWjT0QIYESreGccxMlsNLkFGFS/oBfxubXleFdHS6Pq/HwS2FrIaAzFHuQ/ngnoo
	 bD2490AiCG6SIPLC4/JCWWDfuCu+hrzoYLl2QkXe8pIKyegK2xbVe85iK3ekU8ImeQ
	 mcNIAiJ/ssTEKo/J6jiQlC2VlNkzZ9IWlIrmD1eQsDOboSoDmI++o50J8CY7rjY/NO
	 7hHQ2uhFTCgHGPsfAXJpvcC3EAAaOVyd+olLdIFqvjFbOqPKrvRsBjeyfs1p9dJ5zh
	 i2PyKVeL7Ojg9+x25eR9wEA6CHiLkdDL4n4NXX7t392130xyJM2vYSjCDYHskkRBq7
	 s4vUfHjP0kwNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A31D392EA65;
	Thu, 15 Oct 2026 11:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ibm: emac: size RX buffers for the MTU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179206320702.3367635.13492497641235449780.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 11:20:07 +0000
References: <20261008035122.3182851-1-rosenp@gmail.com>
In-Reply-To: <20261008035122.3182851-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  7 Oct 2026 20:51:22 -0700 you wrote:
> Any MTU above ETH_DATA_LEN selects the largest MAL buffer size of 4080
> bytes. A DSA conduit always runs with a slightly larger MTU for the
> switch tag (1502 for qca8k), so every received frame then uses an 8K
> slab object and a 4K cache invalidate even though it is at most 1520
> bytes long. Size the buffers for the MTU instead, capped at the MAL
> maximum as before. Larger jumbo frames still span several descriptors.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ibm: emac: size RX buffers for the MTU
    https://git.kernel.org/netdev/net-next/c/73022f605c44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


