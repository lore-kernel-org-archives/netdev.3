Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B452A275870;
	Fri, 19 Jun 2026 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830816; cv=none; b=lYavd8jro9JDTEt3Y+2ZfTdOcdqLIdFYCsVPczRZvhCS6sLBmeK/ac1j9tEpYrSFZWilePuMdmyOMgLxn7xrJ+EFn+2uvEeqnsJgKkyO5FQHq0OTckQ5K+hNuWuSQH1v/fL1ZNWm6mf+rt3Lv5zIfpyHVq9kxMhHXheswrPlQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830816; c=relaxed/simple;
	bh=Dzr2lu7db8HJGgS7abNaDmcpYQrSr4zFu5mGHvmRm+g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NMJbvHfE6KciF3oiIdVKJiNWamD1VZmmXkuS8pbxy9ISTL0Rlq1PrAF5eHez38J4K73T/AJQ1KwBv0OfLw1UtY5P2EEEcZiRYrc6SrrvhaDjZT8BSEMw0ZL/2iEWigAVFGRbZNg6zAaV7Kt8fWLkGvxf5x8Ebpnm3NortN+2UCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Esw7hyB9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Esw7hyB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC441F000E9;
	Fri, 19 Jun 2026 01:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830815;
	bh=ryWbyGXApqhl6vmfED+Rh4w1DRsyT4L+xzSDyv8c/Bg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Esw7hyB9M9sft345veXwg6nC94M7zkW7piFgTp5FdnPhgISlu1jW9gqQvBaCxyXmY
	 UWV7vfTySqHRfWEReLkxpMVb+juRagHwHyVfLSVr+wf+RMv+dxQIxpY8XY0o++CTVS
	 80/QFfxPGsIC0vRL2E62XdS6saB7Bn77tVCjsGneSCV9ZonS6UVQrLXaAt1QUD3e6C
	 h/xp1Q7G2zwRgHkOX50sMGf/6Gi9FK6d6nuRjJF5bB+ysuzO8xMPBRrAacWqAG87Ts
	 9iFtOixPtZRila53GL9Wu2mlKjHH9iLcy+eK8nrpTBrxlrbsrFDGx+QedL6x6HQxxU
	 8dmjJWp6VHSQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A2F3A78A7C;
	Fri, 19 Jun 2026 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpaa2-switch: fix VLAN upper check not rejecting
 bridge
 join
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183080863.3146201.970396959346690558.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:00:08 +0000
References: <20260616105430.3725910-1-ioana.ciornei@nxp.com>
In-Reply-To: <20260616105430.3725910-1-ioana.ciornei@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 f.fainelli@gmail.com, vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 13:54:30 +0300 you wrote:
> The blamed commit refactored the prechangeupper event handling but
> failed to actually return an error in case
> dpaa2_switch_prevent_bridging_with_8021q_upper() detected a 802.1q upper
> on a port which tries to join a bridge. Fix this by returning err
> instead of 0.
> 
> Fixes: 45035febc495 ("net: dpaa2-switch: refactor prechangeupper sanity checks")
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net] dpaa2-switch: fix VLAN upper check not rejecting bridge join
    https://git.kernel.org/netdev/net/c/ed2294f94e34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


