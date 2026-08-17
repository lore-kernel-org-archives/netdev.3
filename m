Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E41377558
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786990920; cv=none; b=OwoJlctNd9SJCLE8V3htUrAkKct26CsmmMQTWc2lLuYvONaYi6WvVZxenJfHIabvGru7LV6ItRJHyMnW55kj2btlHPP9aIS80wTOI4E2Z9hGK7VpyZ+69dNTQACNkycs1jmp97g5ipXvidTsV2W1eKSqRunEB6draPLbOT49L5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786990920; c=relaxed/simple;
	bh=rRiMjKPrlvCtbE53HdHCzteFjE4x5ALF2uc3Rq58fu8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lnU4yE6mFTL7PxnmTSYLe3sd6qn6yxezNPiR1webHWEovrFIg/vZXaiUW6izfQdxDBw3ehNr3GguA95EOs3zsPyWRhHBtgqueINk7YWUOVADKbhVslzGfed8Up5oGq040jTbqJycgIkRTyb6vh82LVqPINphOLwmFSIDSnxPUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQktAc+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQktAc+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A0A1F000E9;
	Mon, 17 Aug 2026 18:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786990918;
	bh=V0KDU2fp/xI+tOPmlO6jiYiw6my2qXuHaI0B51GLmKw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HQktAc+NPMUqyVmMl49bwIbw8xNJlQvl3Ro7aWEOfHl5Xmw5av2myhCtzZ3ZWx5qF
	 XvZk36BCClrGb77pn5slooP6alXL1b7nkk69YQHCX8WltlYwRqsUesx6v1PzJqy686
	 vx9INIKkDULrKEfOg/W2R1b2yTFS8hHH+N9vG8upk9qNIiuVocBqt0j49frImHZLKl
	 nLOs5bDxDNaLb+NlVR1l9m46e6i43t0BDkjjtJH7iwizVUfXJtPiIsCmVSj6MsSDBl
	 VIfQ0PZtGYfYUCOgtQ2Cu1/nH4p8lcisb+HA4F3+gBaQ4mR2HcgyrPZXQ8/x3y9N48
	 lkIAcCWstRM7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19826392625F;
	Mon, 17 Aug 2026 18:21:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] eth: bnxt: preserve IRQ affinity across IRQ
 reallocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699087078.1673675.7656095963128444661.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 18:21:10 +0000
References: <20260813193248.2578626-1-kuba@kernel.org>
In-Reply-To: <20260813193248.2578626-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Aug 2026 12:32:46 -0700 you wrote:
> bnxt currently discards the IRQ affinity when changing ring count:
> 
>   # ethtool -l ens9np0
>   [...] Combined:	8 [...]
>   # ynl --family netdev --dump napi-get --json '{"ifindex": 2}'
>   [...]
>    {'defer-hard-irqs': 0,
>   'gro-flush-timeout': 0,
>   'id': 70,
>   'ifindex': 2,
>   'irq': 170,                << IRQ 170 is for NAPI 1 (second to last)
>   'irq-suspend-timeout': 0,
>   'threaded': 'disabled'},
>  {'defer-hard-irqs': 0,
>   'gro-flush-timeout': 0,
>   'id': 69,
>   'ifindex': 2,
>   'irq': 169,
>   'irq-suspend-timeout': 0,
>   'threaded': 'disabled'}]
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] eth: bnxt: decrease indent in bnxt_init_int_mode()
    https://git.kernel.org/netdev/net-next/c/2b49709667de
  - [net-next,2/2] eth: bnxt: preserve IRQ affinity across IRQ reallocation
    https://git.kernel.org/netdev/net-next/c/fb0502649043

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


