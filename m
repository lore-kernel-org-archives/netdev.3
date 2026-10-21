Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541415;
	b=YMf+RO0QtZgFQcMo1bU4bv5wK9iVAaMwQkes+1iETHTSYwPxJM4JTsKo8aChjMVOVsUX
	 fEBiuRp5XECMfyIGfneVt7RRViZIi/zahCtVAXEim54pENDrWZBoIWkRkNuyrzXMr/LK/
	 ndCY8Z+9eXK/n142JQmG8twEvCF+gYZr8hhQlEu0wb+Qx5pMi4ZwgxoQNaYjFegVuLNUS
	 e6pZITy6kMAGOOBR5HPVQdVriHo9WiZeE5BYOVMn9Le43n+3QYt8qPB4MQIIsqYf/uHtf
	 3DX1q3HUB1ft2Nkoxn3Sib+4Y/C08pIraes4bYnjt77pFrhLpQ2Nc3nKiHEV0f8SmUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541415;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=wofT5zkebqyVszVlAt1/ONTLPuvX9LaDgUNffCT1rws=;
	b=Vc64UabodNAmFSfTEbtOJsS3vsnlHY12jndKJ59Ovae2cNOmDqVJZF8dm9rn1aAgz0iX
	 PjNCQaOyPO9GXOOz04vZ55BaXmUHn7MPRKnehbtgT6EXeOe8QRzZpQgPsBcAAbB7O/AMW
	 jZGY+gj8V8bEde/1OPVBIb/De3igzNzcWkeyHWPJtjKD65AJBPIjn5ls8cEAj4QiSvHDb
	 gg+aE62AxK2PYJjPd9Obg5FujbcA6gKi/fOfdeXa5Y/WzNua1CTYpkLEp15uIxiMf/ztx
	 qf+XTuCbjr3sOeK/c07qULIqydtFGy6IhUplHbqRFEQ1ay8bkzMb2RoS4CAsCMqfPNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtYfjjAq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC43606A31E;
	Wed, 21 Oct 2026 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtYfjjAq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455101F000CD;
	Wed, 21 Oct 2026 00:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792541415;
	bh=wofT5zkebqyVszVlAt1/ONTLPuvX9LaDgUNffCT1rws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HtYfjjAqAkOchhnCE/U8yb6mVONCWharGasG5A++W2fDi3VgEVM7mb/V1N9jvIis6
	 jKdYQ4jkWqGrj3OtAFE2VsR/pUnWQhwqcJ1CeWTzPNhm/JJ/JDsRjCZwZaLS7tFzUN
	 yTTpnWUG58OcC6oWjg88fJGgS0WBQmLHOsfYgobIDrMLCfSXG2rgjyxz+t6VARO7cj
	 L9qyo0bN1jJbfK+qA6BqFKeynBiTlHCiR5JMCe/Y+VFXUacwYu9oRbTnGkb5sMyHNc
	 /G0YnUt2vBTWQiyKJ/8v5kNOEcESxNAb6h5NlvKcefi5y0+a7EKBf1r6CL7Y+xpirA
	 TvVnDChQ/YB0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4563809A0C;
	Wed, 21 Oct 2026 00:10:15 +0000 (UTC)
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
Subject: Re: [PATCH net 0/2] net: stmmac: Track and report the TX DMA
 threshold
 per queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179254141377.280032.3757273474047179369.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 00:10:13 +0000
References: <20261013114503.57487-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20261013114503.57487-1-ovidiu.panait.rb@renesas.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 xiaoliang.yang_1@nxp.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Oct 2026 11:45:01 +0000 you wrote:
> On the Renesas RZ/V2H platform, which has two dwmac4 controllers, we
> observed sporadic iperf3 TCP TX failures on one of the controllers, with
> throughput dropping from >900Mbit/s to ~1Mbit/s due to TX underflows and
> the resulting retransmissions.
> 
> Commit 3a6c12a0c6c3 ("net: stmmac: bump tc when get underflow error from
> DMA descriptor") made dwmac4 raise the DMA threshold of the queues that
> report TX underflows, by increasing a global module parameter 'tc'.
> However, this logic does not work correctly across multiple queues and
> controllers, and can leave the TX DMA threshold stuck at 64 bytes.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: stmmac: Track the TX DMA threshold per queue
    https://git.kernel.org/netdev/net-next/c/9dd534187819
  - [net,2/2] net: stmmac: Report the TX DMA threshold per queue
    https://git.kernel.org/netdev/net-next/c/aee7b59e6e7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


