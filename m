Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793229607;
	b=4LD6WTEcCLPr1JyW4OUhcvda5rgjYvE74Rl6ejOevG0NUepFVLjhSlj/a4uNkypElp0j
	 iCxEB8htmK+vVEjIwR8KaNd31KsqLnHvGoo1r9k0vSqd5X55QC+1BYDedpz/hxwmEppDb
	 oiq9v0ItYfmSwxhFORs9+4YG2+ueV+Rl8MWk/LCS9pomm2+7hq/eY8KNe0ZDCEqscRQ64
	 4Gg1eI+c/pIZldMl5r5ptynvvKYL/Or/l0Rb0cDf/+N1aj5V96RhXmK1vA3ImtzgOmhV8
	 K6+XwmU+rV4mVea47/f2nna8rkkam0/SPY/9NHFvqKFnVRsJDWjLFVXCzvaD5dwCftg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793229607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=TjmQtvnN43zZUDJG/7xJ9SFIGrsJ4RvePX25KDOKzQs=;
	b=PRagjZD6Zttiw5u0xKMnwKrpvDQ0bS8vRMkNoWwhjqLa719J82z/dpKZUKp8A1+t7d6G
	 lOecIUNhQBhjTETgoVWHPn4krv+jtonsCcQRithn5j6t5dsmTxxkou36pukZeSNup5Gpe
	 GM4LGqW9J1xA8I2PNdcBER0QH5b4rm6xO3h9fChalFF/uOncJoO7I6b6V3HZnHaz1HvK2
	 e5dJpCujlZfyHgU56vR9/PA7N05NcxPhKPJLEvwP5p+B54GpQYL+1rLSzXCL7EvhpjCqO
	 65fb9imlndkuaQeEVVl1fgWoLScuKwgAgK2Bn9WZ3lmqBePHTmXDkKh7NKvNIznPFZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDaBfe0G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED144606A31A;
	Wed, 28 Oct 2026 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDaBfe0G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65841F01825;
	Wed, 28 Oct 2026 23:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793229606;
	bh=TjmQtvnN43zZUDJG/7xJ9SFIGrsJ4RvePX25KDOKzQs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gDaBfe0GFalv5ZrHmRzJP3doiYt4nX+OW5efjTCjDa9E+SZxMxNHny9vdofSYKhId
	 sgHJ/aygXYNzsXbqVQBHTseQHexaAHvkrUSJ6aIT3he4RPvHJE+3jYVmngbiLCFwHY
	 WB77JsPs9Y9kjmKP0enSpCKs62l9jJpwdTax09qObG07ZMGUHJ1w6UVMOFQYI1yCub
	 VZN44QeujanPVzgXh+w566zbj5BbigNFk4gwCylkpNGrGegQCejEwDK5TBLFnQviwU
	 YIVPoLU1j1DySzzviupd+V/eY3bMCbhGSVDa4XlFhBkCR89/OdfislNpV3nL89MoY5
	 A/Lz4wJluLV4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE5FA3AAFC4A;
	Wed, 28 Oct 2026 23:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net v3 0/2] net: bcmgenet: fixes for a failed resume and
 the ring rebuild
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179322960556.1474710.2129340443455558093.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 23:20:05 +0000
References: <20261022-nb-genet-fini-dma-net-v3-0-6e9fc89c0156@tipi-net.de>
In-Reply-To: <20261022-nb-genet-fini-dma-net-v3-0-6e9fc89c0156@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 justin.chen@broadcom.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Oct 2026 10:54:05 +0200 you wrote:
> This is v3 of my resume and ring fixes for genet.
> 
> Mostly findings sashiko raised during my recent review sessions.
> 
> Patch 1 is a resume that fails in bcmgenet_init_dma(), which leaves the
> interface up with no datapath and the next ifdown hanging in
> napi_disable() with RTNL held. It is one patch because nothing that
> resume leaves behind is reachable on its own, the second suspend never
> returns until the hang is fixed.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: bcmgenet: recover from a failed resume
    https://git.kernel.org/netdev/net/c/1c1f51c3ee9c
  - [net,v3,2/2] net: bcmgenet: restore the Tx coalescing setting when the rings are rebuilt
    https://git.kernel.org/netdev/net/c/ff8a7c0c0676

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


