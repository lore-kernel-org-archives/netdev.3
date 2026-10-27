Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140208;
	b=hwEv/OTNppgm7FQemnx8Zo4ecWPxpWLFdpUmw+0fI4yAajB6YZJdC2EseVneMCNYMemV
	 FA/ccb0vZmNOeB9O1NLWUb+hy78/TBV2EubA/YJiwYZENQ/Z3pGlFkD20UwWhoUsVHWVz
	 3WPVpJXoG6x2il+tz71UNANf3SVT+LSN4DxFNeTQaCOOzDFGtsmqSZzrJSJ3RhnYFXjO9
	 PN7grFf430KNVmYsCvCACG3V4S/MRRknzKseZlpA1b7JrQ3cDfmYK4KRug/iwCcB41CMQ
	 QUTOSAVITR08JFDlQ0/RRyyDqjtJleLmu+ZjboaLGuT2kcAIyE9SxcaZ2HaAjjVbEkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Icmy+kcn+FXvIaWbc4wQxTRCPswqqvM2uKUM5JzYh9k=;
	b=3NqyP1YTfigqfoWP8y978SDcxVVEjXVZ0Z6erYA+mWzSmKL1rnULj2M83map2hblmmLi
	 sj8hES+kyeQrrFWbBFMf/lis0wt/+XnxzKP0+FI6UP9me1Z2jpdSxXiT/dXJl/IPvTPVy
	 pm4AGJGkFyeeDgNYj2YKu3icmG0uH6ZL5ir2PTsOxTaky1JI75f9zrYKDsAs3JcyLhLJy
	 txcH60iKWZsCyxsH7D/WwSxbL/3Oa23GO5DXewGQlDPOXwPihAtzw08PIAZY9uvRNFaP1
	 X2HpzRRLozp+G375mLSkYqcX87NkuLBFAeehlSatW/YntHKYpPIxzJDhEZm56ozimbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0MyecWY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54525606A32F;
	Tue, 27 Oct 2026 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0MyecWY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC851F01829;
	Tue, 27 Oct 2026 22:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793140208;
	bh=Icmy+kcn+FXvIaWbc4wQxTRCPswqqvM2uKUM5JzYh9k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l0MyecWYboY/ZSxKM0kTOT6dTz9bmxA2vyPYkRxgHRaPM9LrALwkyTp5hMAO/HQgj
	 jWMh+hzefOKF/FLB9l4xhU4u+fJuEnUwMxugNoT6HhEUJnF0zxY/CiZA/WaUC1Ll3l
	 DD2jg1U6tAxOFDH5G52Mul6ShYib5JfCUT9tXlcfqj62c7zG+yOG3lLFKrtYJX83/S
	 bcO1WY6Lnpr/6dGykZEsY/X61j0jaMTCAj+zRR50wxOgeGB5PgbHBqIZsE8yEV68Kt
	 GD41CUZOGH9dgQg2W423YKlIo8BZF8I6JdbUUfrui4J4el/XqynG7HZE238V3AQAWO
	 6dlRobN1UC5/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 27B673AA940C;
	Tue, 27 Oct 2026 22:30:08 +0000 (UTC)
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
Subject: Re: [PATCH net] net: lan966x: release the in-flight slot of a stale
 TX
 skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179314020694.360855.7049106598198872614.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 22:30:06 +0000
References: 
 <20261026-lan966x-ptp-stale-tx-slot-v1-1-9f7c895eb1ff@microchip.com>
In-Reply-To: 
 <20261026-lan966x-ptp-stale-tx-slot-v1-1-9f7c895eb1ff@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 14:46:54 +0100 you wrote:
> lan966x_ptp_txtstamp_request() counts every two step TX skb waiting for
> its timestamp in lan966x->ptp_skbs, and refuses new ones once
> LAN966X_MAX_PTP_ID are in flight. lan966x_ptp_txtstamp_old_release()
> frees the skbs that have waited longer than LAN966X_PTP_TIMEOUT.
> 
> Before this patch, old_release() does not decrement ptp_skbs, so every
> skb whose timestamp never arrives, for example because the switch
> discarded the frame, keeps its slot forever. Once LAN966X_MAX_PTP_ID
> slots are lost, two step frames fail to transmit on every port of the
> switch.
> 
> [...]

Here is the summary with links:
  - [net] net: lan966x: release the in-flight slot of a stale TX skb
    https://git.kernel.org/netdev/net/c/074caa30a627

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


