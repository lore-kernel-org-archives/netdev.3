Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1B3559CA;
	Tue, 18 Aug 2026 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052655; cv=none; b=rfYSugCMJIwalEhfYRAyixBNTkQj+Gju80JL8WzEAgOCb/raR/DAS6oj9YaX1xympvv6X3nC5ie/vOhZouKcayZpbQGxZLIGEy/XVTrERx5RDnJ4e4hVf1TFOFTxQVbgbMkIiW7FjAjiKA4iFqDKd5FI84pUL8CH5bmathF52pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052655; c=relaxed/simple;
	bh=e3BhWAK8QPswE9r6IqSm4oHoxl2lyLBZjZU2WuZCyic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nVIqbnk77cYvg32OfwGj7WvvgETWC2EJAulkYaUkieq+Qh18JcWcGfK81YRuim8tc4B9TKF9CLsqYhyj26vZZIduoSa8+SVW1lZbBArwIsVBqtaxPgLsDqegkLOfZBA7msLfgxcp5YdDZr310DBSMIIJOKs6DyxasvArBARm1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0D4LsfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0D4LsfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6201C1F000E9;
	Tue, 18 Aug 2026 11:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787052654;
	bh=PeUj6UGi12uuXWU74Z9CoTTYzF8Kj1NrLzA7a/HziFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c0D4LsfGoDhNm9lvVR0ayGrb6sUkaRdWmoV49H9mSQox4HgV+9v25uLG1VVb1uabc
	 3jZnoaI4IhwLqBspzhkMVTtRMn0r0w9LdumXHxEG45F/Gb9kWxS0JLZon4/srolvSW
	 cwOlHCyzMNblqN5zI99NhO2FY9yDADVO9G66Bl52lGELLqeKGS7rzhIanPWz+5T7Ek
	 tBJDPwzdZ5xrXhzCuKdlMPxg3LXUlvOQqpFSgsuXBd+CZufCF8VX+E+fjo9srs4Bpd
	 81GnluKETzDsCYNPMbdvRQhu0vdfrgclsld9O6q8YvQt8GF6zYc/7t+9bnMqf86n9A
	 g2+8aBtflEXwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D73926658;
	Tue, 18 Aug 2026 11:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ip_tunnel: remove unused non-strict
 __ip_tunnel_change_mtu
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178705260614.2037115.14231277874565681763.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 11:30:06 +0000
References: <20260815001942.1089545-1-i.maximets@ovn.org>
In-Reply-To: <20260815001942.1089545-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 15 Aug 2026 02:19:32 +0200 you wrote:
> The last user of this function was the recently removed vport-gre
> module from openvswitch.  Let's drop the function.  All other modules
> use the strict variant.
> 
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  include/net/ip_tunnels.h |  1 -
>  net/ipv4/ip_tunnel.c     | 17 ++---------------
>  2 files changed, 2 insertions(+), 16 deletions(-)

Here is the summary with links:
  - [net-next] net: ip_tunnel: remove unused non-strict __ip_tunnel_change_mtu
    https://git.kernel.org/netdev/net-next/c/66da914db44e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


