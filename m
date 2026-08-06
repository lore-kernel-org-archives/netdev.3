Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E033AE189
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 01:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979265; cv=none; b=miop9IkSxMHa6mG7ZfoFGR8QcT3z8iRSZO1dbEmc10bfV4ii1ykUZJT6y0qdKaziVr3bv+xeYmeauoNBkBJLRt9a8jlrGv05yOpp0IuBA7bYLjMFLp8ktUNL3A7waY0htPzrxXzTLQ8dYZl00Yw1ZVj4uA3wHMkMiIJTtNPkz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979265; c=relaxed/simple;
	bh=lrtuXkI0YXk5oAyuAnT8/dTPcpV/PQ+AEUw/vCnISgw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eJY6qI8XbsyxqB7y/OjWHFNZ37JOQRkHzrLp5QQDrAl8u/6gDskiE4AHQ8xGuVW6qTdZwTrMketkec2LoZzVOOk5jOvzj/XuK8yJxpNeErZrJ+v8zTvjVR8HUQK+AIcMNRqpaYNj+dKyNciEI9N7rZVfNKuNeY/EwywuGdmO0q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXyG3vAt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXyG3vAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B1F1F00A3A;
	Thu,  6 Aug 2026 01:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785979264;
	bh=rtPRr2rR35ZvPzYzqGnsnNmPxCz40vuwF5WTevo3WEI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WXyG3vAtTPnWMW7iGYWk7HsDQI97asSgAgCETT1pttpGPgAnBlFBAXY9ldBTbhKM3
	 iOyRwF4mUj9X7I/S2MRE82vS6vU9I8QbCY/k1zH62KVgfFgSJYiGYqTS3B71Ip8o7Z
	 YvEDJdMQ9pV2OZY8hVyuCnQtXieD/4EnYUXCFjKJyMJnkv1iavHETm55+lEDDFjXpd
	 poRlVIiCMXWTED+npub23ZHc4fEn5bAbTU73nAnAnVeXqfRt/YA2FCC62MOLvtwndO
	 DNefIvdGet2PoUHc7FZeG2GT+U4goRelOJ1bagPvWDfZyXsSRAfyd9ckrwo/NrfeQm
	 lY+6RMzEHlbyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19905392FFF2;
	Thu,  6 Aug 2026 01:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 0/6] pds_core: Add PLDM firmware update and
 host backed memory support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178597922363.593652.16088321479084285772.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 01:20:23 +0000
References: <20260730-upstream_v8-v12-0-136cd174ee85@amd.com>
In-Reply-To: <20260730-upstream_v8-v12-0-136cd174ee85@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jacob.e.keller@intel.com,
 horms@kernel.org, Vamsi.Atluri@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Jul 2026 04:25:17 +0000 you wrote:
> This series adds PLDM-based firmware update support to the pds_core
> driver. PLDM (Platform Level Data Model) is a DMTF standard for firmware
> management that provides a vendor-neutral interface for firmware updates.
> 
> The implementation uses the kernel's pldmfw library for package parsing
> and component matching. Users can update entire firmware packages or
> individual components via devlink flash. Component information is
> displayed via devlink info, showing firmware versions and update status
> for each component.
> 
> [...]

Here is the summary with links:
  - [net-next,v12,1/6] pds_core: add support for quiet devcmd failures
    https://git.kernel.org/netdev/net-next/c/4b5137bfc07b
  - [net-next,v12,2/6] pds_core: add support for identity version 2
    https://git.kernel.org/netdev/net-next/c/e7960459d977
  - [net-next,v12,3/6] pds_core: add PLDM firmware update support via devlink flash
    https://git.kernel.org/netdev/net-next/c/fb918581d433
  - [net-next,v12,4/6] pds_core: add PLDM component info display
    https://git.kernel.org/netdev/net-next/c/5df545b3a5ee
  - [net-next,v12,5/6] pds_core: add host backed memory support for firmware
    https://git.kernel.org/netdev/net-next/c/b311af86b58f
  - [net-next,v12,6/6] pds_core: add debugfs support for host backed memory
    https://git.kernel.org/netdev/net-next/c/0b5091b64ad6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


