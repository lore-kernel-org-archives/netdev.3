Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB50A30D41B
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309466; cv=none; b=RQkFghpFa7cTdUFEFTxo/NY+gLQkiGbEUcVqsbRB4/fdGVGsbqOruIj7eZpv6LQVZ7uvzUrwoXxrS9sdli64ckhMajWyOg8Y214SFqzjOXay7bmGX2R5Amst4fmz7FaXL6qHAkviItNUJmq+FerU2N3kWPvUmQezQhEuonCiW0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309466; c=relaxed/simple;
	bh=XFbPB7grlY3Z60zzfeMquf/B3rEKLlMpFzEBsuH2l2E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T+sR3Ue3sLi/APeULhqLsf53HZQ9UMrtReqvmgSe2YqyakzOVXBhBwcSFt+Fzq1eR0VwHsQafiuPSF9tU+g4rcjJkPaEKzZDSTUg9eQIyPiLIIzye+8lRNa9sfBCe4STKswWX/10pnJ8UTLvItucY/EOLDQQ9tCepVKQHVo1o8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSyS+v91; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSyS+v91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D051D1F000E9;
	Wed,  2 Sep 2026 00:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788309464;
	bh=Qq8N7b/hBAimkFTgqJBP1XdgKoYZVykgWgRpCiwYPVw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FSyS+v91+cGky6Kb2eGd42mPv85XVmRDJ/UMYZsGTCQ0xCmYC7rQgKnt4XSGt4VTf
	 ykFrZ7SkIO5FpURh9DY0yrh3oaOz8Ktvb7iedNuDhknr3gW8pRHzwQ07WE158h8NJK
	 /mhonPZFJZVOFX41wPJqlAe5tk//A0hhCRox9pXofjIe+GkLGr85D1IKrruzbnZ5Pf
	 KfVfDb3WUFkVxyna4tldDm1k95HKj1eEBizVqphZ5YdHiQtRfOEp/umoJg+SUldTPO
	 itpY8w9kT2ZfQFucb3Vqyt0McraKUfTtvOmd3y/GC6f6DFGV2ocnoGQoWTnn5+BDN0
	 WNp63yBZLGJ/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5698C3926244;
	Wed,  2 Sep 2026 00:36:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: alb: fix uninitialized transport header
 access
 in alb_determine_nd()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178830940689.1844276.3615550176287622934.git-patchwork-notify@kernel.org>
Date: Wed, 02 Sep 2026 00:36:46 +0000
References: <20260831194626.119371-1-edumazet@google.com>
In-Reply-To: <20260831194626.119371-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jv@jvosburgh.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 19:46:26 +0000 you wrote:
> alb_determine_nd() uses icmp6_hdr(skb) to inspect ICMPv6 headers.
> However, in xmit paths (e.g. packets sent via AF_PACKET / raw sockets
> or forwarded packets), skb->transport_header is not guaranteed to be
> initialized. While pskb_network_may_pull() ensures the packet data is
> linear starting from the network header, it does not set or adjust the
> transport header offset.
> 
> [...]

Here is the summary with links:
  - [net] bonding: alb: fix uninitialized transport header access in alb_determine_nd()
    https://git.kernel.org/netdev/net/c/70f3995830d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


