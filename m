Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FDA3DCDA0;
	Thu, 30 Jul 2026 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406856; cv=none; b=DtT3nBLs/ol4T3j5Ff60VoO97T8lqV4s6ECH776p2DkEekUHvuIFU0njS0b2ifKenpznfEVjKm6ZFpo8jmVNKCdQeMTO0CZzeEqb7DVv0FZEHgeIv2F+D+AGauNoZbkwBeGSmFJ3YbmiqMOD8QXBC+oIokcYG4XhUPwsYgVZY4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406856; c=relaxed/simple;
	bh=KL1/LZoHOJqVNO4AHYBhT1eEcuozt4REC7is1N5Tcuo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HZsUH50/4RSXZbP5V/GmoLyVK4T+9JqwAiXGtuKPkgiXpFpLbz+tZOfpTZSPI+rt3DQPKRL9IWQQUtpoheMVV+flTyIqcfytJbovFnzu9WyBQj3+O1rbu6A7TV+/ouXl+o6iTPadDEcfjkCBi37NcVc9tQi5cQ1mc6sJ4XIMSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvXj4qgg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvXj4qgg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D711F000E9;
	Thu, 30 Jul 2026 10:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785406854;
	bh=QYnzgTOpSxQ9JWoWctqG9Dt6Dwfz7ZXVm2oZ9mhXf3Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BvXj4qggDAcLJA0FI5N6BMtmVZ8WVNvI4OLj52PUOLX0tCBd5OfgTcDI+0JEdJC+r
	 CsmZDCvEEj/w0I2E9wsVrmruJQ0p5TUQbO1HxTOyXtTLGgHqqkrwPnNpBG1CAA0dIH
	 c/r6X9r00PCp0W1XKZcby6nVO5YtRUCNL09rp2lRL7Lt2sqNlkdPNXtSxp4Wt0PW3W
	 8QJp7jGyz4XAx5lLfyP29T/fuQfFYoZUgfJNh0dNEIUNoBQ5WqPR1RY9GYOvhzwoRx
	 g3JnkJN/beLL2RszL+JFsW9JlY6JeqOY2k9xs0y2qJjqTtEu4lq1kKLYyMJHpFmKj+
	 KF1AHG0GurWDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A3C381196A;
	Thu, 30 Jul 2026 10:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] netpoll: finish untangling netconsole from
 netpoll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178540681839.3485979.3015916874436032065.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 10:20:18 +0000
References: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org>
In-Reply-To: 
 <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gustavold@gmail.com,
 asantostc@gmail.com, kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 24 Jul 2026 08:04:08 -0700 you wrote:
> This is the final series moving the netconsole-specific functions out of
> netpoll and into netconsole.
> 
> There is nothing else left except struct netpoll ->name and ->dev_mac
> fields, which are netconsole-specific fields, but they are still in
> netpoll structure (no other netpoll user uses these two fields).
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] netpoll: export carrier_timeout via netpoll_get_carrier_timeout()
    https://git.kernel.org/netdev/net-next/c/d93608b0a20e
  - [net-next,2/9] netpoll: export the netpoll_setup() helpers for netconsole
    https://git.kernel.org/netdev/net-next/c/bb996303efae
  - [net-next,3/9] netconsole: take over netpoll_setup() from netpoll
    https://git.kernel.org/netdev/net-next/c/672ecd3bb145
  - [net-next,4/9] netconsole: move netpoll_local_ip_unset() as netcons_local_ip_unset()
    https://git.kernel.org/netdev/net-next/c/6a55e81d4159
  - [net-next,5/9] netconsole: move netpoll_take_ipv4() as netcons_take_ipv4()
    https://git.kernel.org/netdev/net-next/c/3aa9ff037ba3
  - [net-next,6/9] netconsole: move netpoll_take_ipv6() as netcons_take_ipv6()
    https://git.kernel.org/netdev/net-next/c/80fcfc3538f3
  - [net-next,7/9] netconsole: move egress_dev() as netcons_egress_dev()
    https://git.kernel.org/netdev/net-next/c/cf6de67ba41c
  - [net-next,8/9] netconsole: move local_ip/remote_ip/ipv6 to netconsole_target
    https://git.kernel.org/netdev/net-next/c/a1116396476f
  - [net-next,9/9] netconsole: move netpoll_wait_carrier() as netcons_wait_carrier()
    https://git.kernel.org/netdev/net-next/c/dc50a5c9cdea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


