Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98111246774
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788399067; cv=none; b=JDIxhe8GLu9u5gzgbBWoMi6uAKsW7lUxSorZw/KPB7Kh0pIvERC5/J/3U3Nwp8q5BQO4lMSwz5lB76TSlWblfvFzaAUv8UJjMa+TfuFfqWR1JY2xzn14TaIZe50dZ3KKbS7L00p8V0b7ntE8BkOeFBkDb9nnJqqDa/Ujt7aSaCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788399067; c=relaxed/simple;
	bh=DPGWbA+vnzkk2+ZTuLDbgWwKruW1j0XH2iUGz8QLN0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mysOppjNPCu+rfBCKTHUeh6M3Seqm+RZtSdtjIyTANqHd5TGBRyEBzQnyASn+FxalAlx9Kz+6CaIWVSfW7RekzYdN5AQFMfR8gWdSNCOLI/NnxC0qVt/aATw1EWwpBWkuxiZPiTJaOaxxFIo+ZA0FQdws8SdM4z4pjP6jmF55v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHA0qEXC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHA0qEXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721F11F000E9;
	Thu,  3 Sep 2026 01:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788399066;
	bh=ZYpGb8esRD0ZNzGC5KVPUkWKYcCi0oDpAOv38Xj4LgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YHA0qEXCyjeoS1BXyAuVyZV4Impv3mbVPRR55hNObM1zMWD9yuDrepFnjA85g0s4G
	 EQxVm4lo2JroTK02XLEAOUOwa3fIaCza6pi1HYGy5MIpfGAy7SCZWf5kIDWfSLg6pC
	 A393Hye1cjSK9xYZkl0GukrOMSzEXaVxvWLaNKY6WgDG9y6AQ/PVcI+bRYmB8AHoNS
	 zHtFRVX9bxJiuS1LDQx0G+/oPqKv3d/3mQpLpdI4L5swUB0z2lq0Lr0bXvJuOhCghJ
	 uw0Ayc+PNdbqC+dvY6aVI/1fzQXhDKebz9GAfwtq7x+Lq1Jce/dWZrGOpq1maOr0DI
	 LgNb9ImPbUcfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5691D3927054;
	Thu,  3 Sep 2026 01:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: do not clear curr_active_slave prematurely
 when
 releasing all slaves
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178839900790.3032478.12838182899037096575.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 01:30:07 +0000
References: <20260831203042.164466-1-edumazet@google.com>
In-Reply-To: <20260831203042.164466-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jv@jvosburgh.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 20:30:42 +0000 you wrote:
> When releasing all slaves during bond destruction (all == true),
> __bond_release_one() unconditionally clears bond->curr_active_slave to
> NULL in every iteration.
> 
> If a backup slave is released before the active slave,
> bond_alb_deinit_slave() triggers rlb_teach_disabled_mac_on_primary(),
> which increments the active slave dev promiscuity counter and sets
> bond_info->primary_is_promisc = 1.
> 
> [...]

Here is the summary with links:
  - [net] bonding: do not clear curr_active_slave prematurely when releasing all slaves
    https://git.kernel.org/netdev/net/c/af602c7aa5fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


