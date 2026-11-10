Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303606;
	b=d/btrdvx/dnRlfMx8gkWml1KiW7uhINVxmnCnLojcTKtA2i4xDTUe6WJKZ/zcas6zMOj
	 VtwMiBOH96MowhIGg53xiuttT3akfn5lW8xJS1dKIUOWWA2u13yzf703en1luwFo31jT2
	 Md5szqJVW72sCsvwZKKCXGmxuXXalefLio35g+M5kVQ0G3wOSu16PBpHH9HNFnr5rAxSo
	 jFyrrERkklkgaypVabkfy1S6Cl2Cg1aaGUIBnOOfjnhK5qs/zL0bR6PmwWfjJkzrVw+F9
	 CiWNA01f6817P17jGWqoGHtvAyRxHBvSDMb3J1C6bIYCEqcWmKxQuobrbZQeuxLEcVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=tFQNt3ivtoe7K1Ptp4p8DNZgJcuNMHi/yPPBNkB1AoE=;
	b=gF/jAl6+36A8rQb1b41WU3kw+meqwKyGkYCvlZe+hJ99fjq2cRWI7a3VqGup6G8kCavY
	 pha+UqOEscfUk/XTmAgCNgSqxR2g69qe+uVqFrAFKnWPv7RrUdcOeBpJiiTJB4Q//TEdN
	 V0HuXMhGFpDrTEOohZyXJuMfWjOibL4wJL55eWo8GW2/BSSYlhUgLegNoVgRJi0JJ0sQ/
	 Ps3/6LkC4Nw7rproircait6Lgvhs3MJi0A8lSWa78nHZ+m4ehkjnAlWFFjybuAIv/WBZ/
	 Xh6Z7rMpPjtSbOWAM+N6phg70MQTqv8VK09fgIve+X82pig0HSW2NO3ScCq2QqGtLmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKSrfZmB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB36071E42;
	Tue, 10 Nov 2026 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKSrfZmB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE0C1F008BD;
	Tue, 10 Nov 2026 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303606;
	bh=tFQNt3ivtoe7K1Ptp4p8DNZgJcuNMHi/yPPBNkB1AoE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GKSrfZmBDYxyv2DaFV1a/UMIsjykf2nb29nJ+IVaI9xUOOMQES3pHFG+jEMRNROjv
	 3w792sXfmswAHsf20coZHv84O9uII3PSxR3RqY7uDQh/utigJ88XXtiwriJEJjIlmM
	 iiLQTu1A8rSeMyh2Yl+5No/92GbMx8itLas103Nt5wClx0Pdls9eE7usSnCVDqZJMi
	 jo8cWpRq620MRQcHt4J/+EYou8wkALqdL9mMhqHsOlOxlDGIv6uqYagbj46iMEMMdI
	 Z2V+OJMy1gtLWpI9rPIXOkTDe+5M7tzVqTBeWmwwv7KiX3oyOsiet2VTPmP2j1ZZ7J
	 FRY1EefGap5Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2106F391B0AB;
	Tue, 10 Nov 2026 09:40:06 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] ipv6: Add NETCONFA_FORCE_FORWARDING to
 netconf
 messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179430360493.3827472.16080431818953682646.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 09:40:04 +0000
References: <20261104-ipv6_add_netconfa-v2-1-6f660990062f@proxmox.com>
In-Reply-To: <20261104-ipv6_add_netconfa-v2-1-6f660990062f@proxmox.com>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 04 Nov 2026 10:46:10 +0100 you wrote:
> Since force_forwarding was added, changing the sysctl sends an
> RTM_NEWNETCONF notification of type NETCONFA_FORCE_FORWARDING, but
> inet6_netconf_fill_devconf() never emits the attribute. Listeners only
> receive NETCONFA_IFINDEX without the new value, and RTM_GETNETCONF
> replies and dumps omit it as well.
> 
> Also send a notification when disabling all.forwarding resets
> force_forwarding on an interface, which previously happened silently.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ipv6: Add NETCONFA_FORCE_FORWARDING to netconf messages
    https://git.kernel.org/netdev/net-next/c/2d916a8c307c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


