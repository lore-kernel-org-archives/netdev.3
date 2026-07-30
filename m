Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D73C4172;
	Thu, 30 Jul 2026 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400250; cv=none; b=Bvf9oW33rQEWmzOaFFrATKRu1cM+U/SK5D4sr1vccQxrBZmuAeCnh1JpBa2XhLF88EW+8QP1qYkdTsfhFdoqm3ljzQT7TF1Hs/iNUVwy9bWumv1XZAL8Ig+aw7MMN8qj5jNU36j8qvNL0SsGfH0oQ5S5YwsYrhNvklkAiNOUifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400250; c=relaxed/simple;
	bh=UuRCFFeH/IUnTfDQ20KQQvvzIyHyZBix6vfaz29FuXw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R5u1dP4Jz13cvrH98BZ25tTWZ1mvIy86Fwl4SmGniAkn4Y5A8OPMfFmOLBjhybsAjJBeZ7AVlYnegPUCFKO1F0OxdJq04QhAJKMOCei2POp7V2PX90zPozskl6f+Y+b8apMvQOEkIeQYHJlX6oUWSNtekqe7Nb/iKFX75ZaoJts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjJGdEXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjJGdEXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602701F000E9;
	Thu, 30 Jul 2026 08:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785400245;
	bh=KqSjPDiKBb5JjFGe4//EInLM6Xma/la71BA6M9AhHqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BjJGdEXKjzGtOJgwQtKIe2WczpxiPJDSx4Eyw+BJaDh8HihF8HWYoxlt0NtOEZMhU
	 B1yiYQDhizL2v0pci4jRD/UWjsZVLikRh8ggQO/v30KvzHh1vb65FQAsjURQRlEUGF
	 7AaaJSRyBv186jZQ1R2Rg2ZMyZeIXB5S15vAGMsupVes989GvzCrcApspO0KoonD35
	 mHdujHuz3al/b9L3EZM646uPvvaPdHprT7OYvN/K2tfGBgpNGVlFezbx2ua+Cn4xtQ
	 J/llsOSH6lWPY3ZeMvy0SO1sGZwgmM1tWVXEfCtM5MbFQ2/FLoPqq5Mumx3Yp8tdz7
	 jJGba5KDBl0mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5699A38111DF;
	Thu, 30 Jul 2026 08:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH net-next v5 0/2] net: lan743x: add RMII support for
 PCI11x1x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178540020889.3434657.8742979644517480094.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 08:30:08 +0000
References: <20260723050827.694832-1-Thangaraj.S@microchip.com>
In-Reply-To: <20260723050827.694832-1-Thangaraj.S@microchip.com>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 23 Jul 2026 10:38:25 +0530 you wrote:
> From: Thangaraj Samynathan <thangaraj.s@microchip.com>
> 
> This series adds RMII interface support for the Microchip PCI11x1x
> Ethernet controller.
> 
> The PCI11x1x device supports RMII as an alternative MAC-PHY interface,
> selected via the STRAP_READ software strap register. Patch 1 reads the
> RMII strap bits from this register and sets the is_rmii_en flag. Patch 2
> uses this flag to configure the PHY interface mode, phylink supported
> interfaces, and enables RMII in hardware via the RMII_CTL register.
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,v5,1/2] net: lan743x: add RMII strap status detection for PCI11x1x
    https://git.kernel.org/netdev/net-next/c/fc2b13acef67
  - [RESEND,net-next,v5,2/2] net: lan743x: add support for RMII interface
    https://git.kernel.org/netdev/net-next/c/c2e2921d7ade

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


