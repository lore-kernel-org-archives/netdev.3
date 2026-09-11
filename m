Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D60378D8D
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789090870; cv=none; b=QKMASuN/bNsUALEdRoCphqbiC/KPHewp1+M229xwgQgwLqIAYyNzXt8PbY/akxmC+wZ1016yo7VM+oX6i3G9/0ci//n+MIcndv/FUaklaRNmn507P4RYeRePwd/w7aAiiOtRY6B6eKsjnQL1vvaC73Tvya9Mi46hpXfw/Z3ovUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789090870; c=relaxed/simple;
	bh=tWKKdh7tAxk3wr4JVjMRn0UG2Mks6ncHUYCeSdKJGew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qezXrXkGBEYI26+HobGG6HowEJG4w+6rRB3l50FP1xQrd/WeZ7Y0W7O0cPl+AWGBTWIEA4msut05uT/m+JBT2flLyzA/dz7JhEpXyrcaEJFqUkdNV+L6hq29nFCGkC/IGy18CRFF2WHg0sd5hTkghxE2sl+F2VoED1CvF8SrAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnYuiRLV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnYuiRLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB07F1F000FF;
	Fri, 11 Sep 2026 01:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789090868;
	bh=yEC1aDffHbYqRWjfBZ5anIFcPWnriKs4Aw3t4T9pvlM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DnYuiRLVsK6Phc5nvz0R52tPA9lIBya+VFpBRZeBoAC6oOTq57m9ulU6NpAkNw6fJ
	 DK+5ZOwb5wq5p2OQOLyvs1qk5KEmGq37ac6v4Cv6wjP4KzxsHsaQ+oA6qJl6RmLUTR
	 +R10SU8EbY3Rt3wul39M0MwkkzYUryHRL6TQW6zcWvg13KxQ6rPmRUsl+W+mT9E0le
	 /2zb/SqwsO1Xw1yfquhbfaVib2Rw+Xw0619yCWix96Zcl8AtFqUKZAegbSYwRRWKwY
	 WEJrjG4H4fXrfWewYFjunwUYL7ql0VC4wTf988Fw9gLBkhrk0IisPlv+8HiG+uSe+I
	 kdFLbdhj2P8rA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197AB3810901;
	Fri, 11 Sep 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] sit: convert configuration to RCU and
 lockless
 fill_info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178909080588.2176188.854927325558250521.git-patchwork-notify@kernel.org>
Date: Fri, 11 Sep 2026 01:40:05 +0000
References: <20260907075846.2913645-1-edumazet@google.com>
In-Reply-To: <20260907075846.2913645-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, idosch@nvidia.com, kuniyu@google.com,
 lorenzo.bianconi@oss.qualcomm.com, iprintercanon@gmail.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Sep 2026 07:58:37 +0000 you wrote:
> SIT (IPv6-in-IPv4) tunnel configuration and status reporting have
> historically relied on the RTNL lock for synchronization. Consequently,
> netlink dumps via ipip6_fill_info() had to run with RTNL held, adding
> contention during network device dumps.
> 
> At the same time, the transmit path (dev->lltx == true), tunnel lookups,
> and error handling run locklessly and can race with configuration
> updates. This can result in torn reads of multi-word fields (such as the
> 128-bit 6RD IPv6 prefix) or transiently zeroed encapsulation parameters.
> Furthermore, ipip6_tunnel_update() currently unhashes, re-hashes, and
> calls synchronize_net() unconditionally, even when the tunnel endpoint
> addresses (saddr and daddr) have not changed.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] sit: fix UAF in ipip6_tunnel_del_prl()
    https://git.kernel.org/netdev/net-next/c/5145bb6a2c26
  - [net-next,2/9] sit: charge ip_tunnel_prl_entry allocations to memcg
    https://git.kernel.org/netdev/net-next/c/40a2b90f5190
  - [net-next,3/9] ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
    https://git.kernel.org/netdev/net-next/c/88b84cae6b94
  - [net-next,4/9] sit: annotate data-races around tunnel->fwmark
    https://git.kernel.org/netdev/net-next/c/b5e8eadb1c8a
  - [net-next,5/9] sit: convert 6RD configuration to RCU protection
    https://git.kernel.org/netdev/net-next/c/eaa2098a94cd
  - [net-next,6/9] sit: implement ipip6_get_iflink()
    https://git.kernel.org/netdev/net-next/c/e3434672b7ad
  - [net-next,7/9] sit: dynamically allocate struct ip_tunnel_parm_kern
    https://git.kernel.org/netdev/net-next/c/3cd52b7c0bbf
  - [net-next,8/9] sit: convert configuration to RCU protection
    https://git.kernel.org/netdev/net-next/c/0301127e4d98
  - [net-next,9/9] sit: no longer rely on RTNL in ipip6_fill_info()
    https://git.kernel.org/netdev/net-next/c/f712bf6f17d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


