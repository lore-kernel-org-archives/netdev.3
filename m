Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505208;
	b=TJbt2hXnYXYGWxJDzo8S4j7I7ff2FnXwf0Z29+mwjEc2GQi1uMzuVnFqCBnSInsHQ455
	 riDxp331g2AWCOt4kTJA8gB3TyBLWMiSzN/tkGX9zaoFBIA/myVcOscz47P9gsKIlFjOZ
	 K1t2NiI8c+zvT2Wc3pT2CBAh1vEBnoG2BiVboyB4RULZwHwmgBWbgM2sBRqzD7epu9sTX
	 2ddv2WoItQ0mhqg+aD6WXqWWQDNjL1bpUX7u3DvppbinynoIHHvPTR6vBFbo63weH8Yb/
	 /7z1sgMgoaRHuWOkaNRnIHeyHjJnOS/Uzt9KIvKkCmdzC6/3OpgYDeFlSNLYaBE0W9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=XqxvGKuVPssJZSZRPlK7a+uKuLMjgN9I+a+B7IeQ4+I=;
	b=Nv6c8ARINHVFWZRAXhTfRL//nCgBDNeyIR+AFUI2x5KerEvfQMoSkmJr/EuynNsGTxDr
	 BINKMgjntsC7zYwlnZFDh82vu8oHCKZGXsTK6nNguXmYPpZxIm+ScTgkSBN19QqBGNQD3
	 CcFmh6Om2/Cy0+7HkuwW25N1qTEuV0Cs1rwWDSyNJh3foUqeBHKt1lAqgxp/bV4ZTmVnu
	 qu7Z0QE9UcMZIj2AJlCw85eJvQPT2Q4j6daJhNibN+PL0wCZsKJMm6fES/K2R58jUFtn8
	 lJYRmQmNUjovEa/Z8PORQ1rJnjCUCFTrwRAbl/YKMouq28v2WoB56RrCkk3/c+5ihww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRnyO6Gb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84214606A888;
	Thu, 12 Nov 2026 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRnyO6Gb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8521F000C7;
	Thu, 12 Nov 2026 17:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505208;
	bh=XqxvGKuVPssJZSZRPlK7a+uKuLMjgN9I+a+B7IeQ4+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hRnyO6Gbz3V9n+cZRavTV1Msfpts/Rlk+bsAuKFYyQBLZfhacsutiQ0lYMdlZS+RF
	 72e1Bve9i/LCOVhhmiNFRtearJ1NABZN/FmiuLhuyhHefhbzymMBc/NKy9ohFb55Jx
	 2QtK29idhBjafdj1d2KXOF+CZ1smJ0nDg/5JPatfWNSpcaeD/OiPpLOwYZ1ngqL0Yp
	 AY03QsF0j9U1WYjyudE3ukEbMyLFLiElwdi1jhR5OEUvwxbnQOxVapuod3F2PHw7zq
	 5hJtk3iVAWXQzOzTRGlrvrJ3Baf7Reo95wWNWZfUXjRcmFtNdknLRPREbu8GZgk/Cs
	 Dl1xNs3EsxxMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1527380AA78;
	Thu, 12 Nov 2026 17:40:07 +0000 (UTC)
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
Subject: Re: [PATCH v2 net 0/4] net: ti: icssg: Fix device_node handling in
 prueth_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450520678.558080.4368477021495049038.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 17:40:06 +0000
References: <20261110064118.1138-1-laixiangwu@cmss.chinamobile.com>
In-Reply-To: <20261110064118.1138-1-laixiangwu@cmss.chinamobile.com>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
 rogerq@kernel.org, jan.kiszka@siemens.com, diogo.ivo@siemens.com,
 haokexin@gmail.com, horms@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 14:41:13 +0800 you wrote:
> Hello,
> 
> This series fixes the device_node handling in prueth_probe() of both
> ICSSG drivers.
> 
> Patches 1 and 2, carried over from v1 unchanged, fix a device_node
> refcount leak on the "ti,mii-g-rt" and "ti,mii-rt" syscon lookup
> failure paths. Patches 3 and 4 fix the port scan loop that is shared
> by both drivers: a port whose reg property cannot be read is skipped
> instead of being routed based on the uninitialized value, the node
> reference is taken only for a port that is actually accepted so an
> out-of-range reg value no longer leaks it, duplicate reg values are
> rejected, which is what the existing "port0 and port1 can't have
> same reg" check intended but never caught, and that unreachable
> check is dropped.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/4] net: ti: icssg-prueth: Fix device_node refcount leak in prueth_probe()
    https://git.kernel.org/netdev/net-next/c/562687bb3da5
  - [v2,net,2/4] net: ti: icssg-prueth-sr1: Fix device_node refcount leak in prueth_probe()
    https://git.kernel.org/netdev/net-next/c/17d181b3789d
  - [v2,net,3/4] net: ti: icssg-prueth: Fix port scan issues in prueth_probe()
    https://git.kernel.org/netdev/net-next/c/677ad7add2fe
  - [v2,net,4/4] net: ti: icssg-prueth-sr1: Fix port scan issues in prueth_probe()
    https://git.kernel.org/netdev/net-next/c/e74ec6f501bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


