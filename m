Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE73A1DB
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210799; cv=none; b=AXH0x51ZwVicWElr8Ql1owQq7FgqlZpLVT9PZMQ7eJZHnAAIDQ0fSplm8XKbklYoQm/l3785dp2YcAq4PyXMSfcMnBWQcpeGf0SPwyf4uhbwJwjK7rS1vQzZZd0K1U8BXI1ghkBMZl4IORYsPuaUwx5NmpXzl114CHZE9+ReTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210799; c=relaxed/simple;
	bh=+gQxlRDwEQJipj2AvzePmkX5oEsySNzw+jhj3cDDx20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KJbPI0qD3mieEDt3wy5Bxrzke50npl9PL1NJPvQearVGion6upkhakC5aHm8yho2nZrSY/pQS+bLe6JT3Nt2iJM+nsENGhE+bmVilzppQOcIrma9zjwPayjNNZOKC5YZ804y1jn0pXY5CIrTP02sZRYxivZs+gy66yCeSitJFAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/e8xzMo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/e8xzMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D70C4CEE3;
	Wed, 18 Jun 2025 01:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750210799;
	bh=+gQxlRDwEQJipj2AvzePmkX5oEsySNzw+jhj3cDDx20=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u/e8xzMoT7PdyZG1hr3NNvJfGcJtf92nyX6lmRfxm2JRkXWHe7dtLGn+ja076cYvi
	 KZ/mRRu8BmyqewPnYRJHObtfGwCTzFAHfGB1h9vO6Z6/lE98qsjnBGFkVnW9Ewkdfk
	 HZWKHJYSTrc5ZRCSiQcptiKV8z3e542WxwKskWo+5ytRJFrauxFg36mCEwxfwlt5gU
	 JlBbEAg8Bap2CFYwxKO0C3A7zTtenQpC7AuHNzmaNlf/+ZI9YvdEdkB/0BH8TsL02J
	 MLJnmiI6dV2FKgLHYZ56rwK3TS8GGTvw5aufQmUX5ukj/B+T9CvRuFHK9zlpMQMwtH
	 iHg5ieNKOnSxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC2838111DD;
	Wed, 18 Jun 2025 01:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] mpls: Use rcu_dereference_rtnl() in
 mpls_route_input_rcu().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175021082750.3761578.17866878135605007692.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 01:40:27 +0000
References: <20250616201532.1036568-1-kuni1840@gmail.com>
In-Reply-To: <20250616201532.1036568-1-kuni1840@gmail.com>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ebiederm@xmission.com,
 kuniyu@google.com, netdev@vger.kernel.org,
 syzbot+8a583bdd1a5cc0b0e068@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 13:15:12 -0700 you wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> As syzbot reported [0], mpls_route_input_rcu() can be called
> from mpls_getroute(), where is under RTNL.
> 
> net->mpls.platform_label is only updated under RTNL.
> 
> [...]

Here is the summary with links:
  - [v1,net] mpls: Use rcu_dereference_rtnl() in mpls_route_input_rcu().
    https://git.kernel.org/netdev/net/c/6dbb0d97c509

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


