Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF0421239
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431491; cv=none; b=l/MvQT5/We3nvwObffmoidGMAti7x+ObqjEr6CSNh/sG/k+y5YhX9Wh4tyI4NQDOGfsGMIT5eE23qr9K+jG3uj9a7d0a7LSdphBBdGhpf9Rs+cCKLZg2pLKW93lxLVkRG8z1IUQKdLXWlRWJvdinooKSxQMq6ExSocKyQ6LLmDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431491; c=relaxed/simple;
	bh=8vZMPg67P3oD6H6NfGOte2pglul9a4gqdSt+0Srym9Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HMxN9xgX5ZfuwMBP8KQtd7EUP28/czE4XUdCVEHSBlYNDtFazng0sylF85BSMov1+U254Sxi+xBYv10XpvMaPdKLzsBbdnQo3ocaCjbMBxoxZOUBxNdPmhbBeiN+A08FOO+pKzmzwuaGdB1O5ax0BARRs3c6FLa6k8+ixutSRgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrgdujeE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrgdujeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55E51F000E9;
	Thu,  3 Sep 2026 10:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788431464;
	bh=W65ZNRPEmcbNMi7U9IIGGMHb8CAjInAzmkGtNRzRCow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OrgdujeEpZ2zTyi3PEuWNgcwgCV/bmsydX4SxC9rBRTKiSiAzz3wFwlaJpwDHC5Is
	 tzbpGhMVNjVjP3jT3iXt0Tedg8sfZkhv15HQwe4pHdY8NJbAYpY1zUP5XEJWaXw/dj
	 toJRQf3Bwmd5GHsZkHo6EcpAUyfi2tBDxY8PwpeDUHBdb3UTW8MsL29UWJQEM4auWE
	 Eh09q9JJ/Yr06BiF4ft8kE/JI7f2pwgpSktbQprw35J9JfNiGgfc6JDnGoSB3bdWtu
	 J25N9MGVavgGSDrI+fyRMSey/MIKu3I5IMVlEAbhf+iM+btkXLvbFmLWtJihkkwOy4
	 jTayLArmL92Kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A033811967;
	Thu,  3 Sep 2026 10:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: gro: Fix nesting of TCP GSO SKBs in
 skb_gro_receive_list()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178843140634.3256648.8035373141485573563.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 10:30:06 +0000
References: <20260901082312.14596-1-zhaoping.shu@mediatek.com>
In-Reply-To: <20260901082312.14596-1-zhaoping.shu@mediatek.com>
To: =?utf-8?b?Wmhhb3BpbmcgU2h1ICjoiJLlj6zlubMpIDx6aGFvcGluZy5zaHVAbWVkaWF0ZWsu?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?b?Y29tPg==?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 haijun.liu@mediatek.com, xiayu.zhang@mediatek.com, lambert.wang@mediatek.com,
 Iven.Yang@mediatek.com, nbd@nbd.name, hw.he@mediatek.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 1 Sep 2026 16:23:12 +0800 you wrote:
> From: HW He <hw.he@mediatek.com>
> 
> Fraglist GRO and hardware GRO can create an fraglist of
> HW-GRO packets. This cannot be segmented back into
> the original form on TCP tethering scenario.
> 
> Avoid constructing such a GSO packet, by flushing an already
> built fraglist GRO packet if a hardware GRO packet arrives.
> 
> [...]

Here is the summary with links:
  - [net,v5] net: gro: Fix nesting of TCP GSO SKBs in skb_gro_receive_list()
    https://git.kernel.org/netdev/net/c/66817a979426

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


