Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359411;
	b=qwD4AH0jOEvQvHuxZ5hk0VGIC9jF8M0IyK7mmzx63yD8WxSNYECvH4z0vuePruNnJlFQ
	 jGie8EpbUp9nEtU4kGYQQLIlP0B8YRPapWolBtlls6AUeOhNfXP/2GcnVTXlACx6fYICD
	 awOcojt5gCg98RqosBGkm/ztH6eBH4gRxCpI9obG2iZ2ZfGZyMiEwJuk3dOLGQ8o7iLgR
	 DlgaiQIZA5HX9QFSJY2zQgopoFo/q6FjVamjrWUmG3Gp4pdoozRaPJx+QpNiG1Wx28Vz9
	 xHPoysvzKRbNlxA+hlYXBsjP1lUjPslRkyfacIf3xIXCw/cL0/qJjT0iGbTSQJY1rmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=YR4V3X5b2s+Tjtlnuj5PMV26SvACtw9rddGQn8LR0C4=;
	b=QBz+y4RBEeLKjFCh8+V3e/wIcWmJ6earBz2TJKFzZlzPc5DDrOZtV9U0wBtark/V0RQo
	 ZiOHfZOp/hBaZooyKgl/z5tDS8WonzbGDpgDbPh5gVhXB/3pxyue5+Ql01RSz7B5tj79r
	 YVkd3QaFoTdeMm2FzGBo/AtoYemN02QpG3fevtwKQh+WyKTiIAs76Mq6yrElLgevRaHTN
	 CdvtHymYZJlCxFA3H02sEGDwtKShBIG6O2kps7GxkA/4Q4ZHGywUZAmTbuPhwTvGt4ef/
	 IFPWFEgxlg/9sNphqAJcrzvIOKjxVlZd+TLMrRrxTvwX+sD9SpqOX7S0ZrzyMxbi/FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ntY2pzcb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5F7606A325;
	Wed, 11 Nov 2026 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ntY2pzcb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D031F00A03;
	Wed, 11 Nov 2026 01:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794359410;
	bh=YR4V3X5b2s+Tjtlnuj5PMV26SvACtw9rddGQn8LR0C4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ntY2pzcbeejKIh1B90A2gHIhhiHEW059+k1v0gUNlTGGxAMRqCQJQlf3AZztvn/OK
	 JeHbXwP9W53ZQEC2NL98Wqw4eEVZyg/wpytvGwzFAI0vBBQa9Co0ntNX8tnrhxdp+c
	 eklNxrqNrF8IAh7ZQKIDRfqXMiX/5AQ5NHKb52fYrHTmSSEq1jpdmYgZEzYbR9pvFV
	 B5zqelFzJDkwUX+WPAWA634MrXVf6TenaxhMBAlOGBJYw0+Yk2HiDLXMOXGh8dvP2m
	 VOgys/ao024z34EsIxBrL2A9cgYvUDA1Hf920fTANFB82CQnuYRXItRdaHk062yZmw
	 2B86cvkGaJ7HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B1DA380CFE6;
	Wed, 11 Nov 2026 01:10:10 +0000 (UTC)
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
Subject: Re: [PATCH net v2 0/2] net: bcmgenet: fix tx stalls on 32 descriptor
 rings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435940916.149955.1533526014657695981.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 01:10:09 +0000
References: <20261109-nb-genet-txq-thld-net-v2-0-efd8f4be96f2@tipi-net.de>
In-Reply-To: <20261109-nb-genet-txq-thld-net-v2-0-efd8f4be96f2@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 justin.chen@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 razor@blackwall.org, kerneljasonxing@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Nov 2026 22:53:00 +0100 you wrote:
> Found this while fixing the clashiko findings on v6 of my MTU series. After
> those fixes this bug would be easier to hit. At the moment it needs a larger
> CONFIG_MAX_SKB_FRAGS than the default.
> 
> Queues 1 to 4 hold 32 descriptors, which is less than the Tx path assumes
> in two places with CONFIG_MAX_SKB_FRAGS >= 31.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: bcmgenet: cap the Tx queue threshold at the ring size
    https://git.kernel.org/netdev/net-next/c/1e09af397bc7
  - [net,v2,2/2] net: bcmgenet: flatten frames that cannot fit the ring
    https://git.kernel.org/netdev/net-next/c/fbfd7cfd2019

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


