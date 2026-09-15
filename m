Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D893B47F1;
	Tue, 15 Sep 2026 01:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437073; cv=none; b=kTsNGnElZ7N2lOc4NaFI67PWMDd9m/B/607jzfwobhHS82r3jLwH/vBmz8n8gffCAJKbgc0C7IX3bt39SUe5oqY962FXE4+u0Oe7ZU44hPdb7AKfx/F38FojEa+QXgz5RgO6LK9F9+s7UcY5n3CZVzhKxJOJySxCUpBIJUSdgQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437073; c=relaxed/simple;
	bh=Q4bkzVl6r9PRJl0J6kzF5I/7BEigO3LKXoLOSGpfTNo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kiGWNUoUVM3skTexEVj6YzGwK6BSz1f7UDwUrZqTN/WzTxVwTXBGsPUr8gDjw0qblGSrR1w5rtOegxHQRhrLRsuzQmGLZS2TaddbzJ7W0D15FWBNSHFj9xBBGIPOg4p/kntzIHCfepR+GE3N0YEN+GRlkBGsDKDSLUbLwmvsHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4w44pNn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4w44pNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3408C1F00893;
	Tue, 15 Sep 2026 01:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437072;
	bh=SG2c/gPvWKjBdqql/rYjD8xuGADQEmPC+awuQtNQqLw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=C4w44pNnLQqBB4d9+73WNYJpD2K0nhLkSV7s8u2Gh5fgxWzC77JjevYqFHG7iMFEE
	 3A2p8SPTkr/4PuJpLHBKN+Vc+uZKRsUSpgonYjl32o31qOZGfcMj9UYE0pA+aT0mG7
	 cvPp/080wcmYHWJi3afrXmZcZxWbtvCDDNjgZFfhvdniIQ2fhqa2Uth+cUTX5LdQfG
	 U5mrBiLcDYO19T6unOcIMQOkDN8GVvl43ldI4vSKn5/44ipycuTvQl2ct+zX9CiRpX
	 UVSjet1QHWURHITCNNtqyMhzcutrcPtHn2B7rTmBq5DnDlOO17/VS/owki0BJRnOL0
	 +h96LRwux3TCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567D43924FFE;
	Tue, 15 Sep 2026 01:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] octeontx2-pf: report port connector type in
 ethtool link ksettings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178943700688.1306524.15634504647242366321.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 01:50:06 +0000
References: <20260909040621.397255-1-rkannoth@marvell.com>
In-Reply-To: <20260909040621.397255-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Sep 2026 09:36:20 +0530 you wrote:
> From: Hariprasad Kelam <hkelam@marvell.com>
> 
> otx2_get_link_ksettings() already reports speed, duplex, autoneg, link
> modes and FEC from CGX firmware shared data, but never fills
> cmd->base.port.  As a result, ethtool does not show the physical
> connector type even though firmware provides it in fwdata.port.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] octeontx2-pf: report port connector type in ethtool link ksettings
    https://git.kernel.org/netdev/net-next/c/afabe5e67b67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


