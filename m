Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885F38837B
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598668; cv=none; b=uZHjlqXjCdxJHl+EdDv23R8xe4g0BHwM6FYiRwXzU6aP1iu7uYj0t+Zi+hEFb2eI3tp0r117xRUSocMmslPvykN01uosbjt7TatuavO26m/Otgm706lx/CRK3qYF/M4IGZA963pfli1gYs9RbVJ8np3gW1EKVRf8EdIvTiTHcAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598668; c=relaxed/simple;
	bh=Cpuib5GeVglP0Y01z2SmECm8VsAM9sKBpA9B6nOovxk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n2zWEiR4LPWaqHFQV5D6LATg3jLNIRL7eaIxHbmS3s6BozvJi2dXwt1zub0ZopGtSJI8n3L+gXRx6etXt4/nbKFi0RKNjPBlHaWdx1IikFt4wElkhcVCo9ONMu6WlXGZ4S8LcimRgYv0AtGufpHDo74KsHtdrXJWwwVfzxCYntA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsaeIVX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsaeIVX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B591F000E9;
	Mon, 24 Aug 2026 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787598666;
	bh=RNm4SZjdyaiejQ1wZkSYck1qZga45LbLf6D6Kee37RI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KsaeIVX2zuhQa/IafI+4g/FEYxsVAiyCvG5ua3evyELEJmm+lZIsqAWZoLnN+MIU8
	 NV41D1QZlx2hKXe9WTlDo3w6W9V+L7x3jcDo7luoWGXqrPHhBeJ9vbo+BDSu+tpNeS
	 6/Ua72CeYFgGZOQ/1Nwhv5jmUOoxFdPQPwEibZWnghR8hn9q3i3kmpxLgc8wIALzmZ
	 4DhvmQel+fCOuZDx+PIkqL/SPXy4u5ehGxHBdhqC41b39AE3FImPjXAPHLWqQ/X8Pf
	 j3bUhqEluR5gLg/qQQDuvRxtuWU+dD69rlP3aA6APoJzRcL1CHc5qFmiRO8zQg55PI
	 P+9G+g3p0o5zQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569533924A4C;
	Mon, 24 Aug 2026 19:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: act_ife: Only operate on Ethernet
 frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759861399.3069565.17574743323928193325.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 19:10:13 +0000
References: <20260821164031.32824-1-victor@mojatatu.com>
In-Reply-To: <20260821164031.32824-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, yotam.gi@gmail.com,
 horms@kernel.org, edragain@163.com, netdev@vger.kernel.org, vega@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Aug 2026 13:40:31 -0300 you wrote:
> act_ife encapsulates/decapsulates the original Ethernet header and uses
> skb->dev->hard_header_len as the length of that header. That is only
> correct for Ethernet devices: on a device where hard_header_len does not
> match the L2 header that was actually pulled (PPP reports PPP_HDRLEN
> while nothing is stripped on ingress), the ingress skb_push()/skb_pull()
> use the wrong length and can hit skb_under_panic when headroom is tight.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: act_ife: Only operate on Ethernet frames
    https://git.kernel.org/netdev/net/c/5b483f7791b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


