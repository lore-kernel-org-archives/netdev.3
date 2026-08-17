Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970FF3BB675
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998056; cv=none; b=Khrq16O/upQZ/z5zhsO0FU5bXc0wFZswrQ27iT3I2VxngJAIR9sM74+vh7WuX/8zIz9VqfrELQ0kzkZj4ecempU14l8vjwuwk3ChAY7AqHHnLxvFPrisWcuIKPOk/Inp8bqQeyIw5UR4jc9at3RCtGJaOIMG6jXkO9ehQTcrdl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998056; c=relaxed/simple;
	bh=5ZnEFiaDSja/zE5ACujrltFcGSwtwMzRrpxfqh8XKBo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mSeRq9rwHOT9yoM/ZwImwcJ9IJPEerONXqYPQX77W8UAWyvsQ0T4vcWgAF6x0OE7n6rx2VJpn30Rr3gx39FkqhMEtYI1fEZqiqtsypSXgyMRmSauxGEYz0r+D/GGtcV7QVQiY+4IonfXau6PzJW38QqG50jkj/TBupdDOqcbsPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGnbXyK/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGnbXyK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378A21F000E9;
	Mon, 17 Aug 2026 20:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786998055;
	bh=9CK0i9AjoxRCiNN4WMLHgIBR/W62u+/nxWo138c0iZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HGnbXyK/KQyY2qEFYaoT1u++QZ7Nfx61yo7ZnumZ5Tkw4a1jxrTHsvgjeR+j9rRJs
	 TPZezdHHesFG4jCTBYx7icBl9lCEyK72W4FlgRp+iibmZdzuAr7P0Tja3Eyq0IbrFl
	 TgzwurtjYp3E/o+Am8hnKivHVlWhkEc/LX+NdF1Z7JYfnDcwmVGZyL8TzrqOV3C0X6
	 LHP3+epoAFYNVXi/CSHhRSV+Wxn2F/cPUWu5g68uWiANBOR4u1OdnzsPeCJWmCGWeo
	 0GWpxeKb7a34CavLIAniLYw8OHU0MnD4I57JTg053p4kMulOXnsqfgvwbKQIw6oQ/Z
	 5SxVSFMmEJYWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938473926263;
	Mon, 17 Aug 2026 20:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] ipv6: fix use-after-free in ip6_finish_output2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699800714.1721413.1018167525759213009.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 20:20:07 +0000
References: <cover.1786516730.git.rakukuip@gmail.com>
In-Reply-To: <cover.1786516730.git.rakukuip@gmail.com>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, vasily.averin@linux.dev, vega@nebusec.ai,
 rakukuip@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 20:54:37 +0800 you wrote:
> From: Luxiao Xu <rakukuip@gmail.com>
> 
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/ipv6/ip6_output.c. The bug is reachable by a non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
> 
> [...]

Here is the summary with links:
  - [net,1/1] ipv6: fix use-after-free in ip6_finish_output2()
    https://git.kernel.org/netdev/net/c/d0d48d999b0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


