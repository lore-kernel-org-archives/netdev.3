Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7C57E0E8;
	Sat, 16 May 2026 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894999; cv=none; b=asUpmasRITejC9l9w+zjtonz3kSv/kCLOgPcyFLv0PSpCD+0KKHNm2JGo2XXRgM3v1hNsuFFEjVRFKcUnnQoiRC+IwUXrOWUE7xaPnDLAbmzh/IolZEy0quvb7rwJw9XMQ329i0cldjCb5BKwmfSRsbBxxzdPrtAV4h/9G/dpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894999; c=relaxed/simple;
	bh=iUACppQ5PGr72bnwhiXqkoF8CjKsiqAvUhNVwuY4HqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MPc8OMo6nHfX3KAn5bUQMTuq131nj0Qmi1lWSdpavsGUe/7NnN2CRtGoFH/cfVSY3AXRDbIhxpNvE0W62tEti0sa3NHPk8cszH3ctIQu+/UhhmVYQdF9uAZZZEX6mSpiPJPT9sv6j00awdg59T1n1ogWCW+dPxykgZ+bzcDAF8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhRZUOl0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhRZUOl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCEDC2BCB0;
	Sat, 16 May 2026 01:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894999;
	bh=iUACppQ5PGr72bnwhiXqkoF8CjKsiqAvUhNVwuY4HqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YhRZUOl0TVjmnFtUbTXLFj/BKRAmukmbAjK+KH/KkRb+JUL8T3M41O3NZM6dEl6nA
	 b5qQLrohbvw63VFbKbunAnlQAeTRoUmJBoxfqRJwuzChrZCZmDnZeuRhDWO0E+AD5o
	 trxUqv47Soxr7p1zS/Bno6cWg/7qdvMBYx/my2Q2lj+fHeyu9Qlf4PxXJnhGThCoH8
	 Nq+VEvTcpUNhIn+CPUqaqw6e1QI/eKZFsPT7q2x/A+3xbEA2GmioajZT4pzjaKlK9+
	 modBkALVR91OnIIjlEl67hCmKvSRmMBkPgC0FkamFPvq6UM4FMvm3ri6V4PvVkSfRn
	 wK9AxafY07lgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BFF3930A23;
	Sat, 16 May 2026 01:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] ipv6: addrconf: bail out of dad_failure when state
 is
 no longer POSTDAD
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177889501264.218220.12063160525349190248.git-patchwork-notify@kernel.org>
Date: Sat, 16 May 2026 01:30:12 +0000
References: <20260513025509.3776405-1-lilinmao@kylinos.cn>
In-Reply-To: <20260513025509.3776405-1-lilinmao@kylinos.cn>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 stephen@networkplumber.org, hannes@stressinduktion.org, sd@queasysnail.net,
 idosch@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 10:55:09 +0800 you wrote:
> addrconf_dad_failure() transitions ifp->state from DAD to POSTDAD
> via addrconf_dad_end(), which drops ifp->lock on return.  The lock
> is re-acquired after net_info_ratelimited().  A concurrent
> ipv6_del_addr() can take the lock in that window, set ifp->state
> to DEAD and run list_del_rcu(&ifp->if_list).
> 
> addrconf_dad_failure() then overwrites DEAD with ERRDAD at errdad:
> and schedules a new dad_work.  The work calls ipv6_del_addr()
> again, hitting the already-poisoned list entry:
> 
> [...]

Here is the summary with links:
  - [net,v5] ipv6: addrconf: bail out of dad_failure when state is no longer POSTDAD
    https://git.kernel.org/netdev/net-next/c/627ac78f2741

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


