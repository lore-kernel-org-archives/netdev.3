Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5236E34C808;
	Thu, 22 Jan 2026 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054433; cv=none; b=BEwJX1u4gU8HiOcpJe3/d71AGJrjG2K8eAm4TperJ10Lag4yhFOKDk4Lls5/foDBEFDVXpHtgk/I0RBZt2Me1/0jqsphsZEJ/DPm7MsTgiNezQQbKI0RPdg963gCG8s7J3CNQWt1BVOBwt92WnwTkVFbHuV/lw29wlpRR17ziIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054433; c=relaxed/simple;
	bh=mSx+MPmqMjfYtvpJ60q5NcIP8RGlUFeJQXmLd1CF/mM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q5DPfzXgnghU9j++bdZxgn0XcIkV4k2qFhlwVxvAFlKlBneYomwtPhR3TunRMZ90yDIea3sTgdh/soV4ZZ9yy8V4hYTpPHLsqCgu5G/dH2FXb3uI6ekYOCehMwN7MttIUONkjjCbd0EN+P5sESozzkv2NMZ3fOi6QFpA1Z8uEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4J9nrp3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4J9nrp3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCD4C116D0;
	Thu, 22 Jan 2026 04:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769054432;
	bh=mSx+MPmqMjfYtvpJ60q5NcIP8RGlUFeJQXmLd1CF/mM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P4J9nrp3FyKQgTkoMvZnhGdKrdaEYfTpWeZhKq+nmqmm9ROzDd8MlL5Fn65yjxV9H
	 2c0P+AfTEiZkT/JX/QYrOL0oQw+iQb+/AmpdFejC8OgFhbZ6puMT7CXuY9oZra7y7h
	 E/JNyfH/djAB4iQ3VCiiDhjpp9Kyr0HblqAipWLxtbWdkPrXAD3N/7T5niXi66L4bf
	 qjWD7OkPTrahskhQ8r52rVIvS+mbF1tUUc6UasDXiGvTWDoWxFNrjWxzKTTRtmS1nY
	 4PgONzch+E5a4XzXj9BrTYY7SPfxpWmqlJAx+RmcnUEkNjuqxkb2SkKa2LVSDrkb+j
	 IbLh5F0TRZ62Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BB363808200;
	Thu, 22 Jan 2026 04:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/4] Phylink link callback replay helpers for
 SJA1105 and XPCS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905442909.1550373.15597701384450224076.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 04:00:29 +0000
References: <20260119121954.1624535-1-vladimir.oltean@nxp.com>
In-Reply-To: <20260119121954.1624535-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 14:19:50 +0200 you wrote:
> The sja1105 is reducing its direct interaction with the XPCS.
> 
> The changes presented here are an older simplification idea, broken out
> of a previous patch set to allow for more thorough review.
> 
> v2 submitted at:
> https://lore.kernel.org/netdev/20251118190530.580267-2-vladimir.oltean@nxp.com/
> v1 submitted at:
> https://lore.kernel.org/netdev/20241212172026.ivjkhm7s2qt6ejyz@skbuf/
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/4] net: phylink: simplify phylink_resolve() -> phylink_major_config() path
    https://git.kernel.org/netdev/net-next/c/7bf588dc62a0
  - [v3,net-next,2/4] net: phylink: introduce helpers for replaying link callbacks
    https://git.kernel.org/netdev/net-next/c/96969b132bf1
  - [v3,net-next,3/4] net: dsa: sja1105: let phylink help with the replay of link callbacks
    https://git.kernel.org/netdev/net-next/c/0b2edc531e0b
  - [v3,net-next,4/4] net: dsa: sja1105: re-merge sja1105_set_port_speed() and sja1105_set_port_config()
    https://git.kernel.org/netdev/net-next/c/ae73535c9d0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


