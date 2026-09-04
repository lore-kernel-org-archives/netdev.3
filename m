Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EEF3CD8D4
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561074; cv=none; b=AQRis7WdihN12PNmM3cjSbbeFLZRljfGcSEgxuz7ESXO7MNcjZP05Q4Ly9YcssLRz+8ugoijspcCUwo3texcr533QBLKRlli3sGFI17A/sKgXvq/SU8n6faJYoTf2RNi7UmHsX/RjkU+6Oa04/0EEeLhGMmLuX2vJAmi/IncjXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561074; c=relaxed/simple;
	bh=As/tkWvHiXIraVL9fsZCNTseDztDKlb9pLBdYgr0oaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kWWclWvN+gztEBGuQ4YL9eEni8PwKiwLVnewMUZV2hkNEm5JKtYDpL8RUCp3kW/Pdk/zJbQuojgkIiUoKu9or3miJXymVJIN87smne35FPeZG+96OdkxKRNPT/eMBYflJmQimtwxfBNFnGqhXPhLnoPVubufg1woLD6EvVulPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcGv+hyS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcGv+hyS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B78C1F00A3D;
	Fri,  4 Sep 2026 22:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561073;
	bh=Ib1VEJVTduGtWzFOeq5g39zmm40dWSxKXPjWcPJaj8c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IcGv+hySXfmNeIueX/RUfvIYvJ9+pSuaubcH+stDakdt563gzuOcsihWf3l1b+Fgi
	 mxiLJWo8BhlMwc4eTJ8IinDGMbZe8jU7RMN1teeKR9WOWVbzsbnx7CdubbuHVvzxTg
	 8Ee3u/tfSEFRYZ3NP3W3Q/o6geutG7sL4g8kn9o9xpl64xAJJlRLMexoOG4+T4F+/y
	 Xv8FVaGmXRlfU9Gl964HnZTB8duqbSFzd4b7GDchHpwWgmXSrPK8U8eBPN89w/f6xK
	 vK3QUIgRTQWphldU0gw3xh68mfedBIWz7ncxgVsB9pU+JsSb8lKOY6ibmCrFExibd7
	 mSaDsp3ZTR1Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198D73924A7E;
	Fri,  4 Sep 2026 22:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] eth: fix bugs in ntuple filter reporting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856101364.996222.265036419252545786.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 22:30:13 +0000
References: <20260903032611.3000029-1-kuba@kernel.org>
In-Reply-To: <20260903032611.3000029-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 florian.fainelli@broadcom.com, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 20:26:06 -0700 you wrote:
> Looking thru some reports prompted by:
>   Add new way to add BPF LSM hooks
>   https://lore.kernel.org/20260831110934.241898-1-a.s.protopopov@gmail.com
> 
> I/Claude noticed 3 drivers with buggy n-tuple filter dump. PoC built
> based on intentionally adding the same bug in fbnic under QEMU confirms:
> 
> [...]

Here is the summary with links:
  - [net,1/5] net: dsa: bcm_sf2: bound the CFP rule dump by the caller's buffer size
    https://git.kernel.org/netdev/net/c/cdb719f4b859
  - [net,2/5] eth: nfp: bound the ntuple rule dump by the caller's buffer size
    https://git.kernel.org/netdev/net/c/f1986bf87b07
  - [net,3/5] eth: nfp: drop the replaced rule from the list when reprogramming fails
    https://git.kernel.org/netdev/net/c/108bb2142e3a
  - [net,4/5] net: dsa: mv88e6xxx: bound the policy rule dump by the caller's buffer size
    https://git.kernel.org/netdev/net/c/b1fffc273112
  - [net,5/5] ethtool: document that GRXCLSRLALL rule_cnt is a caller-provided limit
    https://git.kernel.org/netdev/net/c/47a582b2b0e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


