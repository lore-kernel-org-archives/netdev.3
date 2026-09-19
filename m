Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2927404E;
	Sat, 19 Sep 2026 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776686; cv=none; b=KFSIqxPG1DSH5WwHd9dd6/VYFa2hvZg7ufbU0TTbES1wu7euZ6/H+lCfFbaYNdvq6/pTjG0Zabo2v0CVmC8p8QwmIi3OHMgTUDWCQdy4eROj57YyL+WTaECERm6Lca/dbKcq7HsyHa+loU7+WO3cez0qwBia2pKkrtXA5SrB4bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776686; c=relaxed/simple;
	bh=Hpht0b0H7ad4Hv3e+h/HNkBRIkCCLJQ5sog9dQa74v8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fkrwbNI8ebVvYuJJJdp1MgpRRAnL3Sm93/ZnONlD62Fob7+iDkIJFEvc/gc7zaLLQxCiUfyUyuH0EO+mbfz7CP+WEQ053nLxAjGw/MZO7q5M3w3/iKTxqmzAyx+c4LGfdjhp8S5YZaMIj739KoANf646H++kf9OniNILSx22X/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+VbrFWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+VbrFWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28BC1F000FF;
	Sat, 19 Sep 2026 00:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776684;
	bh=PlotTYYxNbOD7JGn3qwtelHeSilEx9+MP5lTp1SKrmU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W+VbrFWAfcOXbLNFQNmXcajaeTS+ndailzaqT3XyNa+e6QXh71IDaS/LP7EuLtoOI
	 uWt5gZl6TTEyLschk9/Dv1K0jjx6jD9KSSPEmX1KH7V8looGA9gb+8IXKd21+7vlsc
	 4V/qpyGEkqmf5ao1YKiTew88JtW2/jJI4xxEobjskHRMkjGjH96yJIKDb8jsGW/wI0
	 W8eWBOzszIkUrln6B2YsMPuD7XeWK2R6YWRokH4GgjHBJ2K3/ZYNAuRrkmaR+4biH3
	 VZ5v9AIGTDMPVxapSCaaZ8FYdHRwcBWcW1PFce06AkFRmfjZ8QvscVVy2+gYdw2jrw
	 AWVklRZlOYnEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198FE3811977;
	Sat, 19 Sep 2026 00:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: a sockopt_t quirk for the options
 that write past optlen
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977661763.1197442.5618718493004846350.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 00:10:17 +0000
References: <20260914-getsockopt_phase6-v2-0-e48befc9602e@debian.org>
In-Reply-To: <20260914-getsockopt_phase6-v2-0-e48befc9602e@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, david.laight.linux@gmail.com,
 kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Sep 2026 05:20:06 -0700 you wrote:
> This series continues the migration of our protocols to sockopt_t, as
> described in [1].
> 
> There are some protocols that use optlen as the header size, and the real
> buffer size comes from a field inside the header. This means a bug, given
> that optlen should be the full buffer size, but there are indications [2]
> that we have programs that use the bad behaviour above, and we want to
> avoid breaking them (or, honestly, avoid being cursed by Linus).
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: add sockopt_expand_out()
    https://git.kernel.org/netdev/net-next/c/0093f7db9c47
  - [net-next,v2,2/2] ipv4: igmp: convert ip_mc_msfget() to sockopt_t
    https://git.kernel.org/netdev/net-next/c/e12e04f5ab54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


