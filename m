Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655606;
	b=WzyLLO3ymFx4i1ClfLYWrXdqUuHNdw+m0+e7b9+NPaRmHSBsKB+/w3I5j6BRfF17N8jy
	 fWpOZM2swR85ETAcdGlV2+QwoSH5dudqw7ZCDn6P0n8PRy5MysqN9Hc7ZedQSsB+mh115
	 Gg4kE033Qj1aCl+QRWUlvwnlF3zOW7i1VGXH5BlcF7Ox3UnlbifDUlbERkxbJLMCB0mtw
	 W1s292YxqU+CRjHYzmNsxqoJ01JNVvbHqMgkkBSnmuKm9qbe5vsOFFXFs9TU4K3gs5wQY
	 gOuo+/auYViFScHuYlcD0ECL1fGFzrbMhnG01HrGzQdY4pWj6XLblJALZzTj5isbZgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=O2oeX8lZj3P14fI/ikpuPSbIkztT60QcBhTwAcuMZ0M=;
	b=eMvecu76Sl0NDUILMq4uy5er/hCh8Kin9K5q8riFIoI3TNF+6vdGU9WjjFQmCGVYhKTQ
	 GaG02KxV1nqxBxoI9TCtRP0fJGIeDuVcBbc2e+a7y/E1OoTO6v3MPBqfcu4AY5SmGob63
	 WEg21szm05DwxaOeEYXQbkjOlqpnbqGGp0UVs9ryu9k7wD6wF8uhw4Ye4+9etBbn7CNgz
	 z5TGi5AzKiixZX7Up3FLYYcSSbyz5noeFNwGYTBr7NiTWD79MBoNJbqcqUyFssbn0tAcx
	 ZJuq5ZhlAVgyLLVu7OkgJkmqMZe1nd9dPuoFOanaeNb3kQFb+gC+pamaDvnTh7EMcpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0wdCVoY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8AB606A327;
	Mon,  2 Nov 2026 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0wdCVoY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860DA1F00A16;
	Mon,  2 Nov 2026 21:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793655605;
	bh=O2oeX8lZj3P14fI/ikpuPSbIkztT60QcBhTwAcuMZ0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B0wdCVoYprUN2XqoZr8Cvx9UkCoLAcPPzZadA9Tu82JHEr3awSi9tr8Kcd93qHhdz
	 cD4VWk+Pg5Ik+ozxssUkhYQCmDlbiR57VwFVY7nhu+v9htJB6J01/a3d+2588FMnoP
	 XDQQhdLmmwB8CveHve4c/6ZwuIozfYIKNmHLxT9WBYID4hd4jnwuG02BQIfbIMs69J
	 lTdipQZbGrngAePhR8PUdDO8zI9DQW+M8U5LTlDBgBryL5znsB1o6cpgyhyoRWXhKs
	 +ajiPRl4TUyiuF+Pp0nYGWZOqkH5oAg9GTsWZJ1pLzUtg37QeZ2L07ZHogHFdJj1tQ
	 t3CcicIbeeWsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D2D1380821F;
	Mon,  2 Nov 2026 21:40:05 +0000 (UTC)
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
Subject: Re: [PATCH net v3] ipv6: reject wrapped temporary address preferred
 lifetimes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179365560430.674524.10806958346481950138.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 21:40:04 +0000
References: <tencent_7A270291DDE5CD89DAFFE8A745D094D5BD06@qq.com>
In-Reply-To: <tencent_7A270291DDE5CD89DAFFE8A745D094D5BD06@qq.com>
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, alexhenrie24@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Oct 2026 15:30:56 +0800 you wrote:
> ipv6_create_tempaddr() raises a temporary address's preferred lifetime to
> regen_advance + age + 1 when the configured lifetime is too short. The
> result is stored in a u32, while regen_advance and age are unsigned long.
> If the sum wraps or is truncated, the stored lifetime can still be less
> than or equal to regen_advance + age.
> 
> addrconf_verify_rtnl() then sees the new address as due for regeneration
> and creates another one. Temporary addresses are not limited by
> max_addresses since commit 4b08a8f1bd8c ("ipv6: remove max_addresses
> check from ipv6_create_tempaddr"), so this can cause unbounded address
> growth. With dad_transmits set to -1, a baseline kernel reached 2859
> loopback addresses in two seconds.
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv6: reject wrapped temporary address preferred lifetimes
    https://git.kernel.org/netdev/net/c/c3e67bd82b9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


