Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34393B995D
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477871; cv=none; b=KQVWb0xdQ1d+mmsiCOO9sugWEWTzOuSyO503peEpBgBl8rpA3oHm5VczxV9iXGe0wcwNI7LUQ/1HBr9buicSl6LtVwQlXh4DKSvLKl0iG7zA+H+0aKXwePhA0TPNJ8G6WQhq81OhiI8Ss7HXC/P/iZP7620R4apm9H9VNQndHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477871; c=relaxed/simple;
	bh=owOAeZOQ4YThIzRg+Yelb1jjAvmgub3xDrlCyUwn36U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=me/Bz+vOx7uhXZ5YSX5Sr63JeVl63YAgt0eI8ckmUNcBvHxSatEzANmZhhnyl3opRhDzQDsqaKcIwBR6MkxEb1YBC1RS55Gk4zsp/8zbTuNEHpIb3cN3OkDern6w8VBag6GQnyPNGXL2ivG7HA9yslZam/9OX6X45YbKwGF3DAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqRsAdEs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqRsAdEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372B11F000FF;
	Tue, 15 Sep 2026 13:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789477870;
	bh=7sGehdYAqz2bfU4hzQBWtS7PD5cC5DuTqJgy9fp9cpA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DqRsAdEsF8Gxti6fcHwAEJ3x8eFQxWdYH5jvPRBrq4KqnhzBCp0M1y1RnCMF8Julo
	 3D7dF3bG5tH0i5ZIsnZ5petMl6JU+D9rkuzOiUq3TF6uaDxPumMlRLCQN/cqGcv4jP
	 tA9zUW5qI8w020QNquER6Mk3vPgDSIPNX74YVgnkG0Yh8n/cqWltbD8YbFuJ9GXZLu
	 K+WLlsmzkm4R44Lxh8DyDHi/B/ECSuDFaxRCeqJZJiXX0deWUZ98pjwAIOqLs8JZ/u
	 jGBwmj+aKLOzn1z4mKM84f9sGzMgv80AEVXh1Y46u71D6XR5VO9qhQMHlaOKFKsqEO
	 rxiwi7ABzEsQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197F739263A4;
	Tue, 15 Sep 2026 13:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] netlink: specs: tcp_metrics: fix the
 attribute
 length checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178947780488.1612679.2340270801161620292.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 13:10:04 +0000
References: <20260912234337.308298-1-kuba@kernel.org>
In-Reply-To: <20260912234337.308298-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 12 Sep 2026 16:43:36 -0700 you wrote:
> TCP_FASTOPEN_COOKIE_MAX is the longest cookie we accept, not the shortest
> one. Cookies are even sized, from 4 bytes up, and the ones Linux itself
> generates are 8 bytes, so a 16 byte minimum declares all but the longest
> cookie invalid. The reference policy kept under #if 0 in tcp_metrics.c
> spells it as a maximum, which is what .len means for NLA_BINARY.
> 
> The IPv6 addresses err the other way. The policy uses
> NLA_POLICY_EXACT_LEN() for both, so a request carrying a longer address is
> rejected with -ERANGE, even though the spec advertises 16 bytes as a mere
> minimum. Were the policy generated from this spec, as kernel-policy: global
> promises, the check would turn into NLA_POLICY_MIN_LEN() and start
> accepting over-long addresses, of which nla_get_in6_addr() would take the
> first 16 bytes.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] netlink: specs: tcp_metrics: fix the attribute length checks
    https://git.kernel.org/netdev/net-next/c/4358a3e8e7cc
  - [net-next,2/2] netlink: specs: tcp_metrics: drop the RTT shift instructions
    https://git.kernel.org/netdev/net-next/c/1a523f29fe4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


