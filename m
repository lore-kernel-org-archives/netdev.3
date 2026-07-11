Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA94499AC
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783767646; cv=none; b=Nv8WJizIzI5GowDvawWd+QPVxCW9TQdTGyeEPGY4sn1ASP2P4Lx6hRqiwR/oHgkp0UyLYKJPeB+qjN/Fb2Oju9HHfvikHnyKL1jMXq2rqFtozKPwtqryOcohFZeHn71QtftDG2jz6QQsRdzRZuLJ4z3H5jHrhrDwtCkJsIE/LhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783767646; c=relaxed/simple;
	bh=cNaHUI2LVXU09ub01/WXrdVTJ3jjfOTk87t4x2noWbM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rq780pkYuLqqwSHy+IGZkMbfKQU8ZOXRvs34y5b/NkZNdxZiwirceRQ8jiaqvrZS8zIYR0nUfa/WDHZH3U4F9VHrh3O8VFzazOHF/xSM8fUpziREQpF1D6wr1M3wmfGOyeMnXrtT2DdjNaHRTU/jV7TnhOQqd4zrObprEEM9DGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu/93jWZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu/93jWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB771F000E9;
	Sat, 11 Jul 2026 11:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783767643;
	bh=SbzgYMuutQnnGmX8JNSResR+rVeXyjB/U5f+sBhClIg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nu/93jWZ17eny8jgQdgrwWw57BWmyRUL0y9agv7lLP+6EyXWaCDGqE/Nb04oLsDU+
	 rV3NvOuE8gemDJ7/Mw3Xlp4ER1KzN1NTHFr/jkWvGYuRA9ve4lNuemx996hh8d477e
	 HJJK5KeFPRbO/3rLpjOU+anzIe32M5gvTZRSxzrJhWj6a5eD7KSPy3HkVAbGrWygeP
	 fgyPBZgrtiRJh2KEdITUfUpM1w5UTeT6sXkqKF1bZnu0KNu51Y9LjVDauh27N+7MtQ
	 JreUmGR9aLSpl/FCBlm1sL5B8R97bvrRYLyUgbaBvK959148qSZwBTuspklVhbt6FD
	 PrpKcRL6rCkhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1995839244F2;
	Sat, 11 Jul 2026 11:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/10] xfrm: propagate -EINPROGRESS from
 validate_xmit_xfrm()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178376762064.1079343.12663869106490571320.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jul 2026 11:00:20 +0000
References: <20260710090349.343389-2-steffen.klassert@secunet.com>
In-Reply-To: <20260710090349.343389-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Fri, 10 Jul 2026 11:03:14 +0200 you wrote:
> From: Petr Wozniak <petr.wozniak@gmail.com>
> 
> validate_xmit_xfrm() returns NULL both when a packet is dropped and
> when it is stolen by async crypto (-EINPROGRESS from ->xmit()).
> Callers cannot distinguish the two cases.
> 
> f53c723902d1 ("net: Add asynchronous callbacks for xfrm on layer 2.")
> changed the semantics of a NULL return from "dropped" to "stolen or
> dropped", but __dev_queue_xmit() was not updated.  On virtual/bridge
> interfaces (noqueue qdisc) __dev_queue_xmit() initialises rc=-ENOMEM
> and jumps to out: when skb is NULL, returning -ENOMEM to the caller
> even though the packet will be delivered correctly via xfrm_dev_resume().
> 
> [...]

Here is the summary with links:
  - [01/10] xfrm: propagate -EINPROGRESS from validate_xmit_xfrm()
    https://git.kernel.org/netdev/net/c/6860b467f569
  - [02/10] xfrm: fix stale skb->prev after async crypto steals a GSO segment
    https://git.kernel.org/netdev/net/c/3f4c3919baf0
  - [03/10] xfrm: nat_keepalive: avoid double free on send error
    https://git.kernel.org/netdev/net/c/226f4a490d1a
  - [04/10] xfrm: fix sk_dst_cache double-free in xfrm_user_policy()
    https://git.kernel.org/netdev/net/c/c283e9ada7fc
  - [05/10] xfrm: cache the offload ifindex for netlink dumps
    https://git.kernel.org/netdev/net/c/c4a5f0071cc6
  - [06/10] xfrm: reject optional IPTFS templates in outbound policies
    https://git.kernel.org/netdev/net/c/ea528f18231e
  - [07/10] xfrm: clear mode callbacks after failed mode setup
    https://git.kernel.org/netdev/net/c/2538bd3cd1ff
  - [08/10] xfrm: iptfs: propagate SKBFL_SHARED_FRAG in iptfs_skb_add_frags()
    https://git.kernel.org/netdev/net/c/430ea57d6daf
  - [09/10] xfrm6: clear dst.dev on error to avoid double netdev_put in xfrm6_fill_dst()
    https://git.kernel.org/netdev/net/c/136992de9bb9
  - [10/10] xfrm: policy: preallocate inexact bins before xfrm_hash_rebuild reinsert
    https://git.kernel.org/netdev/net/c/f38f8cce2f7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


