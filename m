Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E39288C2D;
	Sat, 26 Sep 2026 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790387479; cv=none; b=QrxloEVoh0HDgs58DSMVPmP1jw0sRVMCfaxfXDQ+be6kiMIVVtukGGRTQZj4oaBLKA6cmBYKScR4nU5hArC2oYIM6e+ttVMZL5boRjmXRH6ivOHfzlvOr8kR4ua2mraq7taT1sv8vGQHT33HX9xvgw9/zECY8p4j/lh/VDQKcUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790387479; c=relaxed/simple;
	bh=iRbh/GNTMBnAySZz6qHQEI5VRTmYvgSqj69I9Y9gLzY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A/AtCugz9icgpnSBy3RhGnf8LNTgDVZBcPzzVI8lej5A2UJAGlETi9U6FM+yeq441K2RF9NCXzgD8j1rVi+F/Q4lnJamtZs78XGiVlzpXKX7KVc9/9bVtqaTbfv3OAPLX+xfn00Eji5GYlX27RfDnhspP3pPw//tz5u2X+D7+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkWJQp+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkWJQp+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE141F000FF;
	Sat, 26 Sep 2026 01:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790387477;
	bh=n70V3vdtX6ryAsqYNi13UkyqF4WaKk+bYDJNpQ4nOnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bkWJQp+FjkW+hC1+S34vjASvOHnKb7rpwr6dU8KWmutF0gKK6/ljnY5pNt1TlxvhK
	 XP1vL77Q+4el0ebhWClBzu4us5rp/TWW8LV+w25m1EI3ZHMEoiqqwJzDFdMH0yHcfM
	 hGH5GlgVW6t9WVTWpa8vu7oz7vwD+YiA8f54xwwV7g8D0QALsHRXwRBVVf0swY7LJx
	 39XwILRrF/9R7gL4gwqaNbrcf3mDQoFoqfHFkrc/gCzLhyMSMtcSpWeFo9IRmvYW7r
	 X8aiEtOPOuN22hoc0DBz8M8zey93jWjjMQMFlG78i53pZY5U6OzJCPSXQpQPiOCxD2
	 wKVarVTyPUAdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CCA3809A08;
	Sat, 26 Sep 2026 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ice: dpll: fix kernel-doc parameter descriptions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038740515.3239957.17007030778615072789.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 01:50:05 +0000
References: <20260924232138.69492-1-ayush37735@gmail.com>
In-Reply-To: <20260924232138.69492-1-ayush37735@gmail.com>
To: Ayush Yaduvanshi <ayush37735@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 skhan@linuxfoundation.org, jkoolstra@xs4all.nl, me@brighamcampbell.com,
 linux-kernel-mentees@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 04:51:38 +0530 you wrote:
> Remove stale @count and @cgu parameter descriptions from
> ice_dpll_init_fwnode_pins() and ice_dpll_init_pins_e825().
> 
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - ice: dpll: fix kernel-doc parameter descriptions
    https://git.kernel.org/netdev/net-next/c/a72690652227

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


