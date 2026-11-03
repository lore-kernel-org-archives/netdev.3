Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709011;
	b=GoJtLtkhyuaou+OKTcQ4CaP6pkqppgo77D1FYONo5XQlQh2N8Eu1qdh703q1vfRyGMQE
	 JOVl60xaZy0Q4oR2Wk28KIyVakPUvwxFi8xn1Mxim4hwAf7qWM5EoEZ+evtsV9WKwHfPH
	 xa/CkWsG7my1XlIgH3N5Z3DyVsqBkz4aIBYXcsG4yfdvD0aB6Ka2IPdlKQoKgQVf1LFs0
	 qhwL++CqTkTEil7n+ysysUinu+yO0r+L6QgstiMzm8Fv29QEnpz5VlwmQA9MW7PPr2er7
	 ZxsW24eQGI5eUL50AVYO/MmocRZVGGkBWFtcmpYOyTtmOVneC1C6kZ0E853pRLQ3gEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709011;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=2LnMDXHrO+yTBk7B4toyYht3V0YzWFUzNXnDJyE8l4M=;
	b=l5OLcXaV0ciKCG56iZeHKEha5UKVwPHovFIZW04m0HuLiuuZBl6CQUp4aOMUjcIIoFBO
	 egSIilmlBUI0bXvFwqNLaGpP7HjXX05pvrb+FpSxQ8pl4KzvClnISYAbiGzAl41uXMK6I
	 Rqm+uPTxsCubql5rQGT9NnPlnQq5dJyxNGqHSYQ9XfaFzz2bLXMEsZVgt0WLipkhd+IFc
	 aG/qxlWoNT0FjUsCInyrlGnJfVKcxOlq2/JStumZDbNaUT8guHse9HZirk3qnawlBsR7u
	 XHD7b90cLTfmph+h/sUrE75u+T6JZqBCDAnb+KA67238WyVAwLzLJ1+m8ByAnI6H7ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtI4nABK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9502606A333
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtI4nABK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546891F000C1;
	Tue,  3 Nov 2026 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709010;
	bh=2LnMDXHrO+yTBk7B4toyYht3V0YzWFUzNXnDJyE8l4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YtI4nABKFCULJ3C9m335xSW0aNt4SC8pS+NT++ySundAUx3RA+WiZ8jApPTeiLsqu
	 o9F4gikPSqGXJROba3X42Bcmy+/ZRj1X2YyoYSuacJfmTIsmfr8+cAvm+Z10x/lcMR
	 max7D9hds5rqHbJ51j4YPp2i/sstd9J15SqF0RivJ9IH0wNLO0oJ8khh15qNyjea4d
	 z435GJ39p4LSQ4OqUTA6yeoucpD0uWIDgnmgE7nJlKoYUAo5FnLDZgk1qojOwUOnfi
	 wtPfbPACZpMJwCyNISeEYu0Y+/iPqJP16NajvgLe+/NXhNhC1X7S8GSJo9D1PEEp5Z
	 CTFm0UhMCUBsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 404193805CDE;
	Tue,  3 Nov 2026 12:30:10 +0000 (UTC)
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
Subject: Re: [PATCH 01/14] xfrm: retry inexact policy lookup after node
 reinsertion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179370900905.1097976.13813090912870365680.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 12:30:09 +0000
References: <20261102100451.2505200-2-steffen.klassert@secunet.com>
In-Reply-To: <20261102100451.2505200-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Mon, 2 Nov 2026 10:03:59 +0000 you wrote:
> From: Chengfeng Ye <nicoyip.dev@gmail.com>
> 
> An inexact policy lookup first records pointers to candidate hlist heads
> and then traverses the lists.  A concurrent policy insertion can merge
> inexact tree nodes between those operations:
> 
>   lookup                         policy insertion
> 
> [...]

Here is the summary with links:
  - [01/14] xfrm: retry inexact policy lookup after node reinsertion
    https://git.kernel.org/netdev/net/c/868f63c8bfaf
  - [02/14] xfrm: interface: validate the IP header on xmit
    https://git.kernel.org/netdev/net/c/86de3a1118a1
  - [03/14] xfrm: zero-initialise km_event in the replay-notify path
    https://git.kernel.org/netdev/net/c/e35a12dffd5d
  - [04/14] xfrm: espintcp: reorder operations within espintcp_init_sk
    https://git.kernel.org/netdev/net/c/f9a11716c844
  - [05/14] xfrm: state: reject mark with bits outside its mask on add
    https://git.kernel.org/netdev/net/c/c8c2c8a2bbe4
  - [06/14] xfrm: state: reject mark with bits outside its mask on ALLOCSPI
    https://git.kernel.org/netdev/net/c/07d7b25224f5
  - [07/14] xfrm: policy: reject mark with bits outside its mask on add
    https://git.kernel.org/netdev/net/c/b3056e57b065
  - [08/14] xfrm: state: exact mark/mask match for SPI-keyed control-plane SA lookups
    https://git.kernel.org/netdev/net/c/6362f459bfc4
  - [09/14] xfrm: fix use-after-free of migrated state in xfrm_do_migrate_state()
    https://git.kernel.org/netdev/net/c/3eb841b771e8
  - [10/14] xfrm: fix hw offload state leak on xfrm_do_migrate_state() error path
    https://git.kernel.org/netdev/net/c/da94223774ea
  - [11/14] xfrm: include mark in MIGRATE_STATE SA collision check
    https://git.kernel.org/netdev/net/c/a46232c697c8
  - [12/14] xfrm: pass extack through to xfrm_init_replay() from xfrm_init_state()
    https://git.kernel.org/netdev/net/c/24bc5e549913
  - [13/14] docs: xfrm: include mark in XFRM_MSG_MIGRATE_STATE EEXIST tuple
    https://git.kernel.org/netdev/net/c/dcf413245c8c
  - [14/14] xfrm4: use a full socket for local errors
    https://git.kernel.org/netdev/net/c/5def91015ba7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


