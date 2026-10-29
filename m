Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290810;
	b=xd4G3dD4dJKCjE+pmVEV/InFnoQ3yX8bi/s5/qps0rrkMC0R3dznwLSQ90f0zK2xyyf8
	 WZ9mJ79jpaIb12VCEbuDXmAkjV0tlw0BoMlMOmwnPPcuEKTxVV75igPwrJaTe3np4Uhl8
	 Ba4x/I0As4+vxDgZhYdedA+GXQqJX+hq5j0eGZvssncmLxB9y44cIw6jv1QRu7f30vff1
	 0GOAp/9jvUGPpLh9UNn2utBCbtKPvHnThhTWZJM4sec++J7F7ZbC6drzGAGcuvpUhA9f6
	 eTpRVdKEwGmIXFFDAoHHWmmyikqKrRLBh0/5pzSo/kMNUBhYN2Vj/M11btMln71KI2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=4C6hsmeN2PkWMEDVIxj8iTbAB8aBZ30+zylPHR0Py+k=;
	b=G0gch5I1hKSQLFhgTpzqdRKauuuwQAG/PJNPpdMP24B5kAU7QQsh+hGSSlKyqLY+/yNx
	 ISUjdu5fzYBDrqJhdrRcFiQsPZW2CyJG/C92Rn4Ug9fgqpw27I8VIE8BbP0uOA2HqLvAU
	 F0OgDGkJ8OD81HniVXg3JSHNZRt5KCXe0MEI+6W9u3i53TrnQ0AqozSkseIZUwqoR/CoN
	 hn9qngWJGH+LXZ+9/m2sktB9qv4TOtLu+MxUZAdoebqPcDRiKxfXNB5bb6jz5JSbntBA3
	 oqJygBsXFSrZ0JFw4c2EMJcDkYWFMjFvM3V5bHhcPkuNVuoJ2pkCTwGYizzfzv4veyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k5iP+bHQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA51606A329
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k5iP+bHQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483E51F01816;
	Thu, 29 Oct 2026 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290810;
	bh=4C6hsmeN2PkWMEDVIxj8iTbAB8aBZ30+zylPHR0Py+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=k5iP+bHQ+Nnkxyg2MmNgEROJ8DOxmZXrJ/ZpGfBTP4dI+Vc73lfkHlMTjp5lpeCea
	 TTP6XnyF806iYsuyI0dJyPO1tNIUeQhDMaLSpgSYxI3mXRgypBzlxxWixdnZIKYIYL
	 lqXRglibyZNXP1uRDfVmPANzh3DURNxA6ZQ41pVA20hl02u5RZPTJqv1HAfhMgY7ZZ
	 irtsdD7k7vlLqZ7aIG3Bxvqgslwz+gwmS1HWs56mTst/V/ZUGJPloUkHSHp2latQeV
	 QnZhkblLCUMq9uKoVJ68S/nSGVQcVlp/ZeXs+rJ7OE9BkJME3aLBOEEewlxe4jxbJ+
	 5mfPFdIluH0Qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401013808221;
	Thu, 29 Oct 2026 16:20:10 +0000 (UTC)
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
Subject: Re: [PATCH net] tcp: initialize mapped children before route lookup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179329080879.553408.2308928351934303474.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 16:20:08 +0000
References: <20261028154101.2153360-1-edumazet@kernel.org>
In-Reply-To: <20261028154101.2153360-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@google.com, ncardwell@google.com, horms@kernel.org,
 netdev@vger.kernel.org, kylebot@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Oct 2026 16:41:01 +0100 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> IPv4 passive opens on a dual-stack listener go through
> tcp_v4_syn_recv_sock() with tcp_v6_mapped_child_init() as the optional
> initializer. The callback currently runs after the output route lookup.
> If that lookup fails, tcp_done() destroys a clone whose pinet6 and
> ipv6_fl_list still refer to the listener's state.
> 
> [...]

Here is the summary with links:
  - [net] tcp: initialize mapped children before route lookup
    https://git.kernel.org/netdev/net/c/b7ff0e7a9ae3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


