Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487409;
	b=A1nXFuoCJgRWcAezduSVSSQoHkOmerGx53y0TQSfr+Hgm495dQpNADIWCHUJneu8dCOH
	 jx/RUU4Lea6xoZ8hbkQARGzXjMWFvcwpuiqHpPAap+y7IrSUOsi5bwuqBRQeqr6VGqMYe
	 gDrDGO9Ezgp8zdOEQ2cv3KQR+e33lHAG5w6jiVF3coSeyIGB2PCQ1xI+BAogzI1g46mSE
	 4bIbtBcedcueVWiQm7TUMZvCzajoMdor8amMt6nppO8yexBBnz0W4tRzY+vfoGpFSvwFx
	 kmORgDNTyvoXIT2lD1AuGtv9Vryrr8eB+QkA2tgt0o/QRTpacveIBdX/j3+Ve4nEbxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=fU9U0uIRH8WBIkNkp2Lbc2R5Qf6sT3RKPiKH0b8/2Vs=;
	b=vRPjnMUr++a45/N4FtPBmQ8FVIQCdtXSfVh9Tdgy2yhfpwq3wzWX8Ifx8XEnJlkaA31X
	 qimAcJn6T5o5WCvcORPqz6RtuNWj5qKJplXuCBX/spkHJB8Fm5/YxXpeOYeKUXafLwqS+
	 fdmR1lugt0wz89Tc14XUzoOtMMWhbr5lfdapdz6ukoXib+lacal8zfOPJKb2GYbahJhmL
	 W50tkSeKX3TgJ91lDobt6FkyFriOsmKL/Z7KnV2rYwV8Tc+xYfaxnBjzd5cmsIYzKqDLK
	 h7VWfZ8c1c1k8XTemAUWfrY3qplAqqAMKA5foH99DI4Wvb5X5AmpB0ofqc/gruxA0SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WciBHmUQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69804606A321;
	Tue, 20 Oct 2026 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WciBHmUQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C271F000C8;
	Tue, 20 Oct 2026 09:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792487409;
	bh=fU9U0uIRH8WBIkNkp2Lbc2R5Qf6sT3RKPiKH0b8/2Vs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WciBHmUQqiu0nh62RO0RHj3LQpuTIqMpjvLXuY8JNdeZgPgZImvIBf9mwKavTHsA/
	 tXkiXW8lOr8MJTYGnPhC7WMHWn5vA56Q5Tu57sGHY9nxT9eogVm27Ht+m8Q31Rmnk2
	 WkLWwWuQB5RQ5H0RR/i/cn6SuJCAh63oTN6PGH9ORKB7Fsd3yQAtSE+Y0iNIr9nqzv
	 djJvT4BFK5glKfeGGmnXuiSX7GcxYu0mGabOOnN0XW0ZL2qpPhLwSB4hyr35Dhyi4S
	 wqfmA1JSH29xmdp5zwxPBHs9mWei9PD0G/jXXZtx2HoEceQIJ4GnSlabs628lDP1bD
	 crM5BJPrzKboA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F160D3808209;
	Tue, 20 Oct 2026 09:10:08 +0000 (UTC)
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
Subject: Re: [PATCH net-next v3] tun: use pskb_may_pull_reason() and remove
 SKB_DROP_REASON_HDR_TRUNC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179248740778.3599760.15657338483590300771.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 09:10:07 +0000
References: <20261014054615.1656074-1-littlesmilingcloud@gmail.com>
In-Reply-To: <20261014054615.1656074-1-littlesmilingcloud@gmail.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 14 Oct 2026 08:46:15 +0300 you wrote:
> tun_get_user() is the only user of SKB_DROP_REASON_HDR_TRUNC. It sets
> it when pskb_may_pull() fails to pull the Ethernet header of a frame
> written to a TAP device.
> 
> pskb_may_pull_reason() reports why the pull failed: PKT_TOO_SMALL if
> the packet is shorter than requested, NOMEM if pulling the data into
> the linear area fails. Use it for both header pulls in tun_get_user(),
> on TAP and on TUN devices, and remove the now unused
> SKB_DROP_REASON_HDR_TRUNC. The pull of the IP version byte on a TUN
> device with IFF_NO_PI was reported as NOT_SPECIFIED and now reports
> PKT_TOO_SMALL, for example when only the virtio-net header is written.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] tun: use pskb_may_pull_reason() and remove SKB_DROP_REASON_HDR_TRUNC
    https://git.kernel.org/netdev/net-next/c/47b393b997ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


