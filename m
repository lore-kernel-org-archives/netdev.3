Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69CD191F94
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785976850; cv=none; b=CQLe+fm4kiGYVPh52OuZg7zB5GoMKKgFYXLROb7RABAgKxsD/90zg6LNVWwWUgc/RcSMlpXgwflS6RZOOwzJnNpUVrgTTDI9qIpJdcJO87aj/AnMBmNWy4VYD8WCeIQxGm+vfZMRnA/54+4k9RFVw1j8HXVZck0wVvN3vdeZu9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785976850; c=relaxed/simple;
	bh=2hWKkVW1mVMKRvN8IsCNAbx1YBd4O3nNsu6jxPp+v0U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mR7Gex7koJkvUgWMTTlzJ5MxVjwr3qCLfDjREgPb/e38t2wHrKlsNqgXQuoEF+VAEaEKr++rQZQgBlnU1NfS5vpDaYt6wYQ6WCsoPQuwZH3/b217Bt4H64JLthGAWAC8Cbruu5v/dx2K4RDVHXDzcDz8+6FtJWbYhDpuENbrixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfZVWgaU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfZVWgaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB681F000E9;
	Thu,  6 Aug 2026 00:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785976849;
	bh=2ksGjppUh5bRS1QrWpeTe9G5YiFZ+opI1hYB3Y1KQdE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UfZVWgaUXAXI313GsKt2z6cmtwhZnKIb13z23ozmeNUtYETklnS80Q2uZerhIwwsA
	 4wnSKVqM7yCOkIeYkyT9wFb7vQjzx6h4jSlYnkVTieqoUonXH6ki01y/HoJL/Ntyl0
	 0w1VpLO2UYClWiS4GabrujsfLP+ph3TDU4V+5F4BYuDe41Wpnt7wk3NpT8aH+K4qLD
	 O0LjgdvhC+JB/ObwA4MkFzyfDnWVzpMbReG3odmD4zK5NtXyZ0ZkNJ306hWkG6mM4U
	 gmJFKCdCeEw85jgvGyYwDhV0xt6gA6+uxDIb6wi6xeUqOs+mFxKQQq7uR6k8sF0SFD
	 20HLNpqqLgpiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5695A392FFD8;
	Thu,  6 Aug 2026 00:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] net: tap: set skb->dev before parsing virtio net
 header
 in tap_get_user_xdp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178597680889.580024.9182848996324127687.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 00:40:08 +0000
References: <20260802224612.264563-1-dongli.zhang@oracle.com>
In-Reply-To: <20260802224612.264563-1-dongli.zhang@oracle.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 denis.pilipchuk@oracle.com, joe.jin@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  2 Aug 2026 15:46:12 -0700 you wrote:
> The commit 4f61f133f354 ("net: tap: NULL pointer derefence in
> dev_parse_header_protocol when skb->dev is null") fixed a crash in
> tap_get_user() by assigning skb->dev before calling tun_vnet_hdr_to_skb().
> This is required because virtio_net_hdr_to_skb() may invoke
> dev_parse_header_protocol(), which dereferences skb->dev. Without the
> assignment, a NULL pointer dereference can occur.
> 
> [...]

Here is the summary with links:
  - [1/1] net: tap: set skb->dev before parsing virtio net header in tap_get_user_xdp()
    https://git.kernel.org/netdev/net/c/3874892dd27d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


