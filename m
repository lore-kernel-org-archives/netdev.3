Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4717993
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778891994; cv=none; b=f5WaAKkShehM7fB5Sej95K+pS59hHWGuwKYwI6eBjnyaFHgh64XMZEAw2BpgKqobe/9dcopHUkaZZVFURoZhgl8DTHQVD7NYB49UMm53M3ItZVhFBXuITXfjQuuZDHCouNou1NjYbK47pneJcKWlZkpuK5P4nYX8NpWxiwLA0WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778891994; c=relaxed/simple;
	bh=6vI4kXZvk0IYP3RH7MFbxQnidjQVlIqxXdx01DpVYT4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q1P4bYwljOIAw10NSJ9hToFW/sV4H6ydEQj6KnNGAdKL9/ioK74PG0hv7K689u5iE+PGOWabnYnCnRrOnwtVfkXxqLcTpRHOrPeLJ5OipoC1rz7xqS/vvEAmrg2D6rVon1UWQ/BNpswZlUyE9m/ludhqPxUTm+mOs6S09znTQxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceP1WYOa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceP1WYOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC88DC2BCB0;
	Sat, 16 May 2026 00:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778891993;
	bh=6vI4kXZvk0IYP3RH7MFbxQnidjQVlIqxXdx01DpVYT4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ceP1WYOa2Gp2NAwGMKUmQbam0CbNXr+ppK2b5xKtKg5V9/8kRuCWB6AaebOPKvpAn
	 yIdiYvrTnH+rf7yc6T2gWLktt5TH+CsEDzfEev1yj/sG8Y0lRgEM5S6J9dO3Z9XCFX
	 g17WoKcrJW3Svaqje+rpgaDWkR9FSCDMURQDSwdS19aHSxjISDxEDgNCsV5KDudKOU
	 jBcFZjKRXlBeqBsOMP8pAmFmup42Vb9LGTi+VqwF7wY8KUH2lzJpvjJawduumsJgil
	 D04sCaJ+nVam1DM7Z3Cxr/oUSBtJbrc7uhIRwunYMHtcKQCdtBm1wIY7vj/AM0zMjE
	 FGgkkFIF3M8SQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199CC3930A23;
	Sat, 16 May 2026 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Reserve RX headroom to avoid skb
 reallocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177889200689.209257.3972061209487026689.git-patchwork-notify@kernel.org>
Date: Sat, 16 May 2026 00:40:06 +0000
References: <20260513-airoha-rx-headroom-v1-1-bd87798e422d@kernel.org>
In-Reply-To: <20260513-airoha-rx-headroom-v1-1-bd87798e422d@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 xuegang.lu@airoha.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 17:03:59 +0200 you wrote:
> Reserve NET_SKB_PAD + NET_IP_ALIGN bytes of headroom for received packets
> to avoid skb head reallocation when pushing protocol headers into the skb.
> 
> Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 14 ++++++++------
>  drivers/net/ethernet/airoha/airoha_eth.h |  2 ++
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Reserve RX headroom to avoid skb reallocation
    https://git.kernel.org/netdev/net-next/c/bbfb1983944f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


