Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336009;
	b=WQ72T8CNnAxlr7iv3bXfW5jkyWUMwm4tK7I2Dor240/G24ioQhCvMcH2svXcJagvaVkO
	 MHrUMm2owvyfEui3gzzYA3co2MVCAqZoeJluZ12wM/d5o9z+s9Y3ndYPlXZSCdaG1vxGw
	 FX75bGQRxlLai3APltPfuj76FQvPO/zwOt744y1gpjLyVxpHBSO1Gig/MJD5x9kMMpJ4c
	 Uf7SDIBwpIlGphRSc3BHr6s6gQB2QEzeJeOH9X2A6hkM7S9gy6sOtWAhzKjCx6JL4BfTH
	 WnerkriCD2Zh6GeZSvUp4QfUfPjlB2FVcFCbOfh/ynJ8m1RxzQ3huaDVyAfuEvRgi4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336009;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=4+1Tsq8nYIjmil4QjhvYH8s+1A1/eonDKZveiRe56qY=;
	b=10O0P7ZrgNa3l9oLU/HDB8p2nhdBUFbsxxY4G4MMoK1nltem0s9qLR82kbBIqLY1s+s7
	 ihjJv4NhTF7mO8SuwbMvqhzw8uKoPKKmPwFIz+QWnxVisVwLcpfEdF3wGAyKznErFXgMD
	 IBpuGixde1LVEQWd9eWI5V27uFy9l0Nu7Om8ATYgv+DwGW2pBBCLGOpTQ/NGEJYEsi9S3
	 767JdEtI4cTZHAKgB8nQKxxQqN9gtawQTSeJH2hZdcujspBzzvc1C94ZZzH9Joj5XMqEH
	 wuoyVWMtLCNJd3nKpaDcLJy75H4guHngZBYf9tqkRk7MKnclDrPs0GIM964Jmaf+VXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ta1a7Ygq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C6B60A5BC9;
	Tue, 10 Nov 2026 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ta1a7Ygq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC92B1F008A1;
	Tue, 10 Nov 2026 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336008;
	bh=4+1Tsq8nYIjmil4QjhvYH8s+1A1/eonDKZveiRe56qY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ta1a7YgqDfFIKub674USszRkP4081wNq3URyD5ACm3kWUnFA3QcCfIumRqMiixB5g
	 4HSkSWWf1OuqxAa9+rhzt6S6fJEakbkOVNOFWcxe+1lEGcQGKGYUyN8IyrmTepOoa+
	 X2V7PyVCi5r4/rp+F8Iz12Z/wYHpTXhj3a9ZdNXGQcIxI4ar0Xb7U1awHTvROoDIfD
	 dD9ce63CGFeCuw1YsBwzmcqOpHPnoX16I24ktEIdH9sCtUi61s8F8Voxnkn+wilfLZ
	 NZOqYVPH3r1rv6U/mg+gVJYOnQzK4uk7hCB6hlYZwW2lkRuX53lRZLPPXZiSiLidUA
	 mzG7jF6W/GQDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B16C39D6091;
	Tue, 10 Nov 2026 18:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: ptp: fix support for PTP_EXTTS_REQUEST2
 ioctl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179433600717.4186528.13915971392066859083.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 18:40:07 +0000
References: <20261104052504.1886335-1-jjc@jclark.com>
In-Reply-To: <20261104052504.1886335-1-jjc@jclark.com>
To: James Clark <jjc@jclark.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, jacob.e.keller@intel.com,
 kory.maincent@bootlin.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 12:25:04 +0700 you wrote:
> Commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to
> ptp_clock_info") modified the PTP core to validate the supported flags
> of external timestamp requests, rather than relying on each driver to
> check them.
> 
> stmmac_enable() and dwmac1000_ptp_enable() ignore the flags, and
> neither stmmac_ptp_clock_ops nor dwmac1000_ptp_clock_ops was given any
> .supported_extts_flags. Since PTP_EXTTS_REQUEST2 always implies
> PTP_STRICT_FLAGS, the core now rejects every PTP_EXTTS_REQUEST2 for
> this driver with -EOPNOTSUPP, where before that commit the same
> requests succeeded. Only the PTP_EXTTS_REQUEST ioctl still works.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: ptp: fix support for PTP_EXTTS_REQUEST2 ioctl
    https://git.kernel.org/netdev/net/c/b66fca408bf8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


