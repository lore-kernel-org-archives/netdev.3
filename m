Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551016;
	b=s1RDMwHX6wg6wUKydW03qBOz/mBJJw72ztJ8LuEOC3HJ5MlMYieFamBVaeP5NTB3B/qb
	 iggP/ZRzyQRBzx1+hdWvNH+zqYAK2OCkAaRMgDsVEkpZ5Gk5YEi3JQQ86rt41xYoYJlLK
	 fAY4ZBymbBjs5bf2tAetUpqNondWCaUh04tC/kakHszLMoLXfcIdwVd3s0L6qVB8y7X7d
	 Lz7e9Lu3R42oYNBe06PddM3Kfllxo1kza11RuK/SQYykK54gofC9KMaQtX5Ijx5+iDETO
	 dhJm8RCp9F0Zl338jI5M7bnOriplJpQ7CSMEiOrEBtDHMeZoMBmYVARSsTrjDaN9ytg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551016;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=1ja6KA72erx3up5TTib9TXT/aw3D4jKO1OlyUl+CVso=;
	b=r6PSIUYbl1KCZzkmBaaGKnZhFEvMA4YwStkCSrXtqBAABQzIfzQAmyX/l2J0OwqsrD9D
	 2nwA9NHpH2blmHXC2Eul7MDZv8KtuyGTwjCFr5UQKGH9RyocjItWwdhEY0jyAdH6zoiMD
	 V8Ih+rUnidYpURStsQt1BbH6syjWlNNmB4lyUT4S+Azq6yVqSvxLrcYZ+uyNhs0p4+ZEQ
	 AF2PLp7AJe8FuebRe6NtI7WEGUOo8zib6LQI25/lnv6kyCSFg8ruSxzR3X/tywvtqx5Ls
	 fN5SvmcXN7nJy8XK2hY/l18wnpc5sG7UujV5uyxIzIVHth/xDN8a48EC9XfeAgSZt7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiMN0S1q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC66D606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiMN0S1q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE6B1F000CA;
	Wed, 21 Oct 2026 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792551015;
	bh=1ja6KA72erx3up5TTib9TXT/aw3D4jKO1OlyUl+CVso=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JiMN0S1qk8YYpP6TFLLMFTtLn4rUBYkFu+oeJzHp0NuUdOcyrIerNTTfhBa4h9iPy
	 cdaYnR6phYFRBJxjG5URXDSJUEfPtVcY3sHYLlH9aVA7vozFmMB1gkKhjrkQDf2bpi
	 JampapkZm5Dfv0XKQZW+dlhuUrXD++YQ7Hgcru0ecBNPaiJ1rM/cggi8zdyUKfS+aE
	 iXYlCHbbs+B/Oc9Xd6pIUAlXh7yFS3BkXKbMh4AqbYgkFwINqjLIsyLpTN58unQej1
	 tdbuzs6UkDoqg5Y79g1rIWBMcxla4PisYSyPDQHi9iUm4BJH+6kvVhv5B5R4tAPoCM
	 u3ifpnESqKJ/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7749C3809A18;
	Wed, 21 Oct 2026 02:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v2 0/3] iplink: bond: fix partner LACP state
 decoding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179255101407.346551.10071782343489919182.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 02:50:14 +0000
References: <20261019203843.3127235-1-dave.seddon.ca@gmail.com>
In-Reply-To: <20261019203843.3127235-1-dave.seddon.ca@gmail.com>
To: dave seddon <dave.seddon.ca@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 19 Oct 2026 13:38:40 -0700 you wrote:
> G'day,
> 
> Thanks Stephen for the feedback.
> 
> While porting iproute2 to Go, I noticed ip reads the u16
> IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE as a u8. For normal
> LACP state values, this makes the partner state print as 0 on
> big-endian systems.
> 
> [...]

Here is the summary with links:
  - [iproute2,v2,1/3] iplink_bond_slave: read ad_partner_oper_port_state as u16
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=0067cbc8166e
  - [iproute2,v2,2/3] testsuite: fix test_on_not on multi-line output
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=075f1b6f6a79
  - [iproute2,v2,3/3] testsuite: add bond slave LACP port state test
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=4f49441d2be0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


