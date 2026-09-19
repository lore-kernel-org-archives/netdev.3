Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8BB346E43;
	Sat, 19 Sep 2026 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779090; cv=none; b=JqGa+vfnGjEr71fyja7ewwlCXKp6SV9gI6078yDmzuG4RStb26ihCb/nLE2GWXLoBJoM4ti+oyRdDsluSaGL7dqp8uaL9U487WRT8l1hpAjwJDdyB1QDdwG+szsyy/vSC1ExMVtwa5fy4mJLLQ7LrFNxhrVW44yHXZDI291jU/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779090; c=relaxed/simple;
	bh=G+wFUjo25RFkmsrTR1YarOUQE52i+bs36dIgjjrnS1Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TgJS3H3HFzsbu2r6Al45jb/imAUHJAK+XhGvZZUrQOfzsKXfP6qBYvLGvpxD6BDODhynGkyn3U2kSLBuMUBa9GlS8R0q05DylGb95ZNdCeT/PjNvqWojTg4XIwt1lEKhdvRqP3hnJ76tD8/KXYdrKj3UwhqkMtCkpQJT1m6YAlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWVEiYoe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWVEiYoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1161F00899;
	Sat, 19 Sep 2026 00:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779084;
	bh=gvUYYJLE4mMcSYyKX9DSK63VqyOeWByjSiDHmZOkEJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aWVEiYoedOl1VKIg0QSNY5/upXnyOnqi+ITdNGFheEPntAmOlPJnHMR03BbfV2hTf
	 ia6MsQb/X1ep9b9+vVtCVPVNrBh8wElpfdH0l73f6SrBVQFMX4oNIQGbinI9OUlGJ/
	 lMvbYdy8jdqzl35EnKwFw/9u5FlrpMgrbNRdWkjFoUYqeEI7uiWNfViptMIouZxtIA
	 QnqwoE7GqimRT5yhQkpaUjTRtNp5Yr+jLkgGAVeGioGi88qyHG4RqXuIfvvAukSfr0
	 vm++R8r5qkuPvhgAYMbNF6J8GYb2XQ2LU4MCtcdXVvWfDJga6xZM7nuc950oUBLQ7C
	 XmioQfxRVj/Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B303811978;
	Sat, 19 Sep 2026 00:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: phy: factor out legacy PHY fixup support
 and
 make it always built-in
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977901714.1211687.9118031635858398394.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 00:50:17 +0000
References: <2d722b84-a263-400b-ac91-bf37125eb85b@gmail.com>
In-Reply-To: <2d722b84-a263-400b-ac91-bf37125eb85b@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 08:05:22 +0200 you wrote:
> PHY fixup registration is used from platform code in init phase only.
> Let's move the PHY fixup code from the modular part of phylib to the
> always built-in part of phylib. This allows to annotate the fixup
> registration as __init. No caller uses the return code of PHY fixup
> registration, therefore change related functions to return void.
> 
> phy_needs_fixup() and phy_scan_fixups() wouldn't have to be moved to
> the built-in part of phylib. But doing so allows to fully factor out
> legacy fixup support into its own source code file, and make struct
> phy_fixup and phy_fixup_list strictly private to phy_fixup.c.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: phy: factor out legacy PHY fixup support and make it always built-in
    https://git.kernel.org/netdev/net-next/c/f619d5003ff4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


