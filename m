Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCF029D26C
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786586465; cv=none; b=h24N341uIPXyKikjf+oFHdOguetP792Ncr0o28IE9h6tGCL5Y9S7eojTFoXk6pIdEtsRcsbNB+5Mrz2tUdO5OEqyBa1Fs3w1D6+LcOiGa0Gps8Fy0a5J7dLWjeZwijCCd/2cWeXtjV8BMdHNgK6Y4xMus82UwjDZ3bO/ttcdxZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786586465; c=relaxed/simple;
	bh=St3wQK6dQmheAy0TUb3Yyfx1MRYp68+qAEiAC2WiwqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o7GkT/032uITA0wUO1BBsnxRErQBS/zqA5Vw4FjzcyED29pgiP9YKmmXsSxa3sGZOD+WJV3/ENj39fB5XpMacHn0dCntOK5ByxAYwtXNwypVPSypSFPZJRDbODCe7ZyKCBVOfrLzy/YX4YclxpwHiZyu3Ao6AYsgRF88L/bxrXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtqK6WqY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtqK6WqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7912A1F000E9;
	Thu, 13 Aug 2026 02:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786586463;
	bh=oDooSXLIV5Tj92pi9xACQ9Y8xUulN5SFZ9Gh0I2SRqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PtqK6WqYlXd/xPZ3youNYdkGuoGuys9klhsdKendasq2ukR39eF4lhJ691XmuL79i
	 jtXQtpv4bYAJ+51xS0q+KixyvMUeikD5sliVEjRu1Feaqd+wgUwdDaUiuz+tXfxs7y
	 uzPAMoQawvvHMzarbsLopPLqdY+dUURP52premLDCI3r0gKKSRb8ZFBsFBR1iLPrdA
	 teUQ10XrSSx56p0QwH2voWjHnJRadD2x466Gza+XrWPVc6ukTV7k6qiIJ6Dutj85C3
	 H3WUQJWVZ+WwBe68oB/no9eCUgTm4hToifKnLbjqjZbIvDhrEgInDnB4YqA5oRIkOQ
	 xNcaLz25sKCBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A5C380CED0;
	Thu, 13 Aug 2026 02:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/10] batman-adv: dat: drop non-4addr backwards
 compatibility
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178658641839.2186174.13993982202522689838.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 02:00:18 +0000
References: <20260805143200.722098-2-sw@simonwunderlich.de>
In-Reply-To: <20260805143200.722098-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, antonio@mandelbit.com

Hello:

This series was applied to netdev/net-next.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Wed,  5 Aug 2026 16:27:15 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The 4addr unicast packet support is mandatory in compat version 15. No
> older compat version is supported and the kernel doesn't need to keep code
> to talk to nodes which cannot be in the same mesh.
> 
> Acked-by: Antonio Quartulli <antonio@mandelbit.com>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] batman-adv: dat: drop non-4addr backwards compatibility
    https://git.kernel.org/netdev/net-next/c/0de27651929b
  - [net-next,02/10] batman-adv: tvlv: handle negative tvlv processing return codes
    https://git.kernel.org/netdev/net-next/c/e558ee008810
  - [net-next,03/10] batman-adv: add missing kernel-doc comments
    https://git.kernel.org/netdev/net-next/c/3ebcaccc8871
  - [net-next,04/10] batman-adv: fix kernel-doc for functions holding skb ownership
    https://git.kernel.org/netdev/net-next/c/104570fe64fa
  - [net-next,05/10] batman-adv: annotate functions which may reallocate the skbuff
    https://git.kernel.org/netdev/net-next/c/ed00ac0be85f
  - [net-next,06/10] batman-adv: split multiple declarations per line
    https://git.kernel.org/netdev/net-next/c/a0082bd0f851
  - [net-next,07/10] batman-adv: switch var declarations to reverse x-mas tree order
    https://git.kernel.org/netdev/net-next/c/4549e49abbce
  - [net-next,08/10] batman-adv: handle errors in batadv_init()
    https://git.kernel.org/netdev/net-next/c/085a4112165b
  - [net-next,09/10] batman-adv: correct NET_RX_* NET_XMIT_* confusion
    https://git.kernel.org/netdev/net-next/c/1c852e4a99c7
  - [net-next,10/10] batman-adv: remove negative returns for batadv_send_skb_unicast
    https://git.kernel.org/netdev/net-next/c/02aee8ebea3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


