Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E613B6BFA
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786401662; cv=none; b=lPORbGqbZjzop0PljWYJS47jZJh8DBao1ajLIwtdEKhEa+mfLxE9NUIm6/enbivbWdtipjaWB7/LDh4r9sEeVEUMe0U/AuY3E9pPwSn8+elHiwcV3qttEA5O28E9WX8a2ddS5gnXvqZFHj2u4P6Mp7mFjn1tDRZ2xXhOJkDCer4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786401662; c=relaxed/simple;
	bh=seXDRCOBCW4B46+8wGTvi8FuDkVuWFTypDof6WattIE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sglAVCpx6XJQCcBa29y9sIGWte6SDdj7VBbOU4aZwLyfaBUq4L6jIBCw0s7/Oh10sqmwozDXcUvJOhZ8LWQKL0tieGwSE/ALKmQfHQdw/yQjE7ZIcRLRNysryAgrvMSsdRkp1ucXdnGN1S9wJ27HKSlteytL/eCjSSXkhDqOKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+A/r5wy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+A/r5wy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3151F000E9;
	Mon, 10 Aug 2026 22:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786401661;
	bh=zFWexBW0B+zDdQCsKO2KPeEP7hxQ/bqQSPBkhxBKyPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A+A/r5wyY3OV4NHFT554qDsm/IV2FaB++yQ1M8/mSbleNmbK+pury2jHFYn6UTwy+
	 ekaiHUEoTolsqfof03FClJawF64GWDdz8wJ+7yK0F7ggAHiFN+W8xM+hoRow9lEqmH
	 fGY3/HUag7m7GwABHuWln3vV26bNFWNygyjw4kU4jUK/mvSuJLziNOufTn24BS73p4
	 it8/wOUdgRLBUfKu5S/XkMqOAgdcvaJo0UJxYYTQlGkNR2FbWTgt7dbB8pt2/B5IGN
	 Jlyrqusm8afSOqsooVNbHGYQEsD85PnorCax9UfCB0RITYvshzg16t6eEXM2FBD52z
	 gevLGcn8DJb+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197C53926265;
	Mon, 10 Aug 2026 22:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ipvlan: inherit needed_headroom and
 needed_tailroom
 from phy_dev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640161764.238814.13057537742776520230.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 22:40:17 +0000
References: <20260806103857.115541-1-edumazet@google.com>
In-Reply-To: <20260806103857.115541-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+1f9fd0f4b601cf88d6e6@syzkaller.appspotmail.com,
 xietangxin@h-partners.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Aug 2026 10:38:57 +0000 you wrote:
> ipvlan devices inherit hard_header_len from phy_dev during ipvlan_init(),
> but leave needed_headroom and needed_tailroom set to 0.
> 
> When the underlying phy_dev (or stacked lower device) requires extra headroom
> or tailroom for headers/trailers (e.g. macsec, ipsec, wireguard, tunnels, or
> veth with rx headroom), upper layers calculating packet headroom and tailroom
> fail to reserve sufficient space.
> 
> [...]

Here is the summary with links:
  - [v2,net] ipvlan: inherit needed_headroom and needed_tailroom from phy_dev
    https://git.kernel.org/netdev/net/c/e16e960d55a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


