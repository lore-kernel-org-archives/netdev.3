Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7053AE6E6;
	Thu,  8 Oct 2026 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482415; cv=none; b=qH+/ZZRK6MvcRJX52M6YYaEXv2sao0qFAO0x76fLBpMHa+OXY3V+ldPJxYi9UU4C17dpV9PZ4JfsV1L8Rm3YqT8UrKCQ+7lgAlkielYRlgJ3y29D4LkIB+tz14uiE/uFTXrJiMh7je1O6+FwBEYDoNkqTlCHu1OWjBbWNyzN8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482415; c=relaxed/simple;
	bh=2CjK0K2b986h6JRaq/CyXMkZyrPEGgtobGFzaN11A38=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rfyjObtsASwtocE08k4qwNWMCCCfyBDnDzo/Yw3oZLIbfkjSn2EVUdIiIyuE6BFVGcYM6YwJQQQPKIX+YdVlm/lS7/OnI4a4fR73gbVb53+Hj9mCS8aJ4fpBkg97BtED1Ms0w0hV6sY3D3suh2DHEQK/5xhsoP8xQVSD0vRR8wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsNajnK2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsNajnK2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8E11F000FF;
	Thu,  8 Oct 2026 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791482413;
	bh=nU1749sScYR3U2UNU/EtGIVwIs0uZeZqOSt1JX3BzNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OsNajnK2WzSYdh33X1cP9pQT/YNF0GCFpdzckEQCqf0VMAZLjAhJXVwmfq6zxX2z5
	 foFpmo/SkRnQDIeF29e5lOZ513PoYFD1mvTy3Zwho5nIzpqcEJuUhtcTgj7S9h9zDO
	 DXF6P2szDyI5kPwxhH1eUWNeuyRHW1iO80vQw15HZdIKPnAn/KvZHQDs8wPFXJN9zw
	 EtFeYUA2ZHOxdYybrAFoiGkpQrVjaZY0S3wLsy6obDSLN25XaNF2EuIo3YNOQYmutU
	 oRmtunma738gBCB1DU0DT4t6V124xzQylBhRXBwLzOihJnn80/g+uUddLNpYD4PT71
	 AvWdLPZSLoQzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B447B380CEC8;
	Thu,  8 Oct 2026 18:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] vxlan: generalize and refine drop reasons
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148241226.372666.5348049606508908025.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:00:12 +0000
References: <20261005201417.906344-1-littlesmilingcloud@gmail.com>
In-Reply-To: <20261005201417.906344-1-littlesmilingcloud@gmail.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Oct 2026 23:14:13 +0300 you wrote:
> This series makes two vxlan drop reasons generic, so that other tunnels
> can report the same conditions with them, and makes the reasons vxlan
> reports for two other failures more precise.
> 
> Patch 1 renames VXLAN_INVALID_HDR and VXLAN_VNI_NOT_FOUND to
> TUNNEL_INVALID_HDR and TUNNEL_NOT_FOUND. Their values stay the same;
> the names vxlan drops are reported with change.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] vxlan: rename the drop reasons for use by other tunnels
    https://git.kernel.org/netdev/net-next/c/7629d6db839f
  - [net-next,2/4] ip_tunnel: make __iptunnel_pull_header() return a drop reason
    https://git.kernel.org/netdev/net-next/c/6c0509aa8900
  - [net-next,3/4] vxlan: report the drop reason of __iptunnel_pull_header()
    https://git.kernel.org/netdev/net-next/c/0518c33e1d7e
  - [net-next,4/4] vxlan: report a circular route as SKB_DROP_REASON_RECURSION_LIMIT
    https://git.kernel.org/netdev/net-next/c/d476bb7c0efd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


