Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755E19AD8B
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076017; cv=none; b=njglZOGCePAOHszR1dFRl73awu7Z8Gp6wd5C+sDRaNchboeJrQmZS0OJ7swW1dvMyiJPXFcg0bGxyz5GCIJKowqhZk3Yr9YLj9R+AXGlHD0WNavi2ExMr+ocj+PhOxg0sawyEc5YEbtgmuXXRUduXgIpDgmILzTbxjOG/24m1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076017; c=relaxed/simple;
	bh=2zmgXg8tJ0GzwYGuMnLjz1ZeoPrFhYj5IT1BMlHijNM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pwpXLDfx1UUtyJlzdozKzmIW3+7kusCTHBsLswWLnz6fSiNIuzXjeYuh1okCcv1fII+o6H7K8lClx/7dYLw4PMCZIFF6+vU8t/L5AOWCGQVrQ4tt9k+jDusJMNf3+Jx5jslWypUgtRbjG2rc5uAVG8wkfqhXKu+nA3bOrw9hr7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR7dRM2l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR7dRM2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B979C116D0;
	Thu, 26 Feb 2026 03:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772076017;
	bh=2zmgXg8tJ0GzwYGuMnLjz1ZeoPrFhYj5IT1BMlHijNM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mR7dRM2laJxdyx6iZmCw4IkMUwjaMrUDPl1CCXLdLrm8zC2sion63uMHd5bIfr1lk
	 iiqyl/oRlv1UXoa1FPMww9Dm+MktLVle0I2Lw1WPR7MgbbDR1QgPzbx1k1ED0PA4h8
	 rmAOVB+0agDoHHyUFRZzMCw06EB+gatJXGKAaNCbyXIIVe93RvtqgOrYZcNcQWoKDL
	 leMoE/3yIecGQ79VBg071sVO3NPmiwdzWkvK9v60kMVinl2WqE1GQEXQNsqMpmaNAB
	 MDjFEHwNuIJHwF6JzNEj6GqLja9aCrQoVuxa08wYZ68Iab0mkAyAvxaZtowR5IUfOj
	 +dYKsaD1J2Ivg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C44380A94B;
	Thu, 26 Feb 2026 03:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: stmmac: fix interrupt coalescing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207602178.1018003.6114992445042344713.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:20:21 +0000
References: <aZ1o2dmfpeiubCik@shell.armlinux.org.uk>
In-Reply-To: <aZ1o2dmfpeiubCik@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 09:01:13 +0000 you wrote:
> Hi,
> 
> While cleaning up the descriptor handling, I noticed that the accounting
> of transmit "packets" for interrupt coalescing was buggy in that it
> takes the difference of the two indexes into the circular list of
> transmit discriptors and merely subtracts one from the other without
> regard for the indexes wrapping.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: stmmac: use circ_buf helpers for descriptors
    https://git.kernel.org/netdev/net-next/c/819101c3c158
  - [net-next,v2,2/2] net: stmmac: fix transmit interrupt coalescing
    https://git.kernel.org/netdev/net-next/c/dd53a0e85969

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


