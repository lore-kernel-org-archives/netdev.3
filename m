Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9939197A7D;
	Wed,  7 Oct 2026 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791333608; cv=none; b=kczemsXU9FN1ZzSSvOTxhVkzx7Vgaagz9hGlY3McdsTPm2wF5VFk8RO9Avq+aUZQbyemVkF3BIZDRExKr+cmPLfQY3Bt6gW0AKCEbmR39C9aOzTcpUfi3Bn7Baa2z4dQU88nhSveIRAKcT7fDWt0MlR80yvDoj5ZmlfnlH51Iug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791333608; c=relaxed/simple;
	bh=bPj+xiEOU2I4W16dGduZNoecsYU0ollQLnfwL2ktQnA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jlbpZqZ3UL45HU2L1ticPSbZfg2FoeDaLDRGjZKavxg/gjXvKAxnp9mH6osdZ2qCk1exZjbFCqowOI/jan/LDzynBb5hVoI409l80W4PLZ5MIqPCB6BySGKqe053mi3CkGE3AfeyajDxDFoR2qG3MTetvIWz7TIWztTaHEWJcB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkDFqrxo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkDFqrxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446691F0089B;
	Wed,  7 Oct 2026 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791333607;
	bh=irTfcU6rL27I5iXINR1Jh6Eku2bLzFSdTDH3S/J1T+Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IkDFqrxoMJKn2TI8GEusPG35vwNI0bzF4v+awxdMdLMOnYBCRqDSb8D6G1PhbVSXN
	 4iB/J/czMxJ0T7tw3qbRYdzey+mbDjsEqSEud9to6Q2tgqikpt5FdmIUklsGH/yONl
	 EattCGwZLRJTMoL3v8HQA6boPSUno6QTMShTGCA8laiPIxNca5ADJ/JsgYkgBXaEuc
	 BA+ShG6N/2CmAGT8AjUsMgI8dksl+oblt+h1B7+xO6bFhTjKSnczoie9WdyXzGwwIt
	 R0529D29zFPJiAy6rJLVzoLhawUzuP0VwThl3rHyf3KFZu8G2UTgtN3MS7sMrwhIvN
	 r60jeuZ3OR56Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A5E53806541;
	Wed,  7 Oct 2026 00:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: team: fix transmit skb ownership
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133360603.2844451.1453790919795765460.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 00:40:06 +0000
References: <20261001182326.572045-1-bestswngs@gmail.com>
In-Reply-To: <20261001182326.572045-1-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 co+2cf741c3005abc20@bugs.sh, xmei5@asu.edu

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Oct 2026 02:23:24 +0800 you wrote:
> The queue override path can pass an skb to a lower device, see that
> dev_queue_xmit() returned a drop, and then reuse the consumed skb. Fix
> the handoff decision separately from the transmit result.
> 
> An AI-generated review of v1 forwarded by Jakub identified a separate
> broadcast-mode leak: bc_transmit() returns without consuming the skb
> when no port is txable. Fix that in the second patch.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: team: stop reusing skb after queue override
    https://git.kernel.org/netdev/net/c/b7454f1940c5
  - [net,v2,2/2] net: team: free skb when broadcast has no txable port
    https://git.kernel.org/netdev/net/c/489114c9ecae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


