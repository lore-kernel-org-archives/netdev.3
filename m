Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AE01F94F;
	Sat, 13 Jun 2026 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781393424; cv=none; b=prCYkf4d8/jfP7ESZZMQii1jnBHme3vXtF4JE774pDiKjngVrHNR5Yz5fORpNSU4flQfu80DLAxkyTtDN9YBiMezbFv7xipBmLe619jXcAKUHfe0ctqjDJMUAixhtMKcMeZq+UHP4q60L1DQDVXcQsD82MUxPyK5q0eSpVazHZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781393424; c=relaxed/simple;
	bh=p1Zs6BdpxgmGOKhWk4MDbzVaKdaCBt8g77Jgq13WDuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l5nG9v5A06r551Bzxdyi4LVj6d4VvnV2A9aONV5+aBhjViyZ/gMhz4Yac8nrkipB6Q80OLI5WNJaFes+sdfl90ryE0K/YHnG2PDTai+Nx8De1t412CNcS+J0mVq4QfqHjV0xoxbrOS1Ck16FHK2hCcCBivzcB4A2FIweYG46YSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGj8n+m4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGj8n+m4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1AC1F000E9;
	Sat, 13 Jun 2026 23:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781393423;
	bh=43DXCZF7tMWiNvnV9UsOmeWxbF5bjNRH2NsRA5nvcAw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GGj8n+m4SP226rwFzWFqrUvjCEB0Fz3d+rMb/umUEf3AWOkBF8njkCg1FEAupHWrP
	 2OLDQrHi+EDSn6Xvrfr/pFg9uuBlr1vu+fYOYJVoYtb2/Pj+iIQCvP1UzRGmlWKM4c
	 0E09iclqSOWknxYvDZUHXu0hZzYLCBQ5umcqW3aLjObRiljvii1SEsSwfBCj8nrJKU
	 SVZ4+Wfm3hBhpyaz0ZfpJ/gJeWRrPGHw6dl6VEEnGbyeIcgBZj2NDRW0j/HGcjMBIg
	 jcQxRy9L5MMyFFR8HZZ+/wrA8C/GV/SoltZ4aR7QaxykiVdKbIj5iOMH8pZJTD4uJ/
	 1hdWgEHpK/HOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5688E3A54A32;
	Sat, 13 Jun 2026 23:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v20 net-next 0/9] octeontx2-af: npc: Enhancements.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178139341889.1625883.8369703910835658331.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 23:30:18 +0000
References: <20260609040453.711932-1-rkannoth@marvell.com>
In-Reply-To: <20260609040453.711932-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, donald.hunter@gmail.com,
 edumazet@google.com, horms@kernel.org, jiri@resnulli.us, kuba@kernel.org,
 pabeni@redhat.com, sgoutham@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 9 Jun 2026 09:34:44 +0530 you wrote:
> This series extends Marvell octeontx2-af support for CN20K NPC (MCAM
> debuggability, allocation policy, default-rule lifetime, optional KPU
> profiles from firmware files, X2/X4 MCAM keyword handling in flows and
> defaults, and dynamic CN20K NPC private state), adds a devlink mechanism
> for multi-value parameters, and moves devlink_nl_param_fill() temporaries
> to the heap so stack usage stays reasonable once union devlink_param_value
> grows (patch 3).
> 
> [...]

Here is the summary with links:
  - [v20,net-next,1/9] octeontx2-af: enforce single RVU AF probe
    https://git.kernel.org/netdev/net-next/c/6056a11b8dc4
  - [v20,net-next,2/9] octeontx2-af: npc: cn20k: debugfs enhancements
    https://git.kernel.org/netdev/net-next/c/4655902deedf
  - [v20,net-next,3/9] devlink: heap-allocate param fill buffers in devlink_nl_param_fill
    https://git.kernel.org/netdev/net-next/c/c0e67fd12313
  - [v20,net-next,4/9] devlink: Implement devlink param multi attribute nested data values
    https://git.kernel.org/netdev/net-next/c/eb7b4d458e0d
  - [v20,net-next,5/9] octeontx2-af: npc: cn20k: add subbank search order control
    https://git.kernel.org/netdev/net-next/c/7ac9d4c4075c
  - [v20,net-next,6/9] octeontx2: cn20k: Coordinate default rules with NIX LF lifecycle
    https://git.kernel.org/netdev/net-next/c/aac055dbc0fa
  - [v20,net-next,7/9] octeontx2-af: npc: Support for custom KPU profile from filesystem
    https://git.kernel.org/netdev/net-next/c/c0c9ac88156a
  - [v20,net-next,8/9] octeontx2: cn20k: Respect NPC MCAM X2/X4 profile in flows and DFT alloc
    https://git.kernel.org/netdev/net-next/c/ad804b325075
  - [v20,net-next,9/9] octeontx2-af: npc: cn20k: Allocate npc_priv and dstats dynamically.
    https://git.kernel.org/netdev/net-next/c/e1938b10fa26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


