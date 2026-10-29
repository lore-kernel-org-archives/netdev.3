Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290210;
	b=uLG3nd/AvpeAV4ZfH1Oo9RvJShISAQQq3LtcX0ecdkDVpmZindtc5dsr36n3gjhRVZOZ
	 PKVAhgOeKx/i3F5fc3qGIihQZmf82utkP4R51VUgFQgg1Uxo3c2deqfRFGA08IfAekw2H
	 rkeQ9Qnx/588mOhxCsLD8kMn6d0OYxNuC8ieB5DietlGDTH8TwajB7Xn/57W+7BXFw/zA
	 lcnzmsksR4ZkXhAd1rMwo7meBAGlA+glY6oQJYeO+icBJhcG6VhMKeP96KuMORYNEGQVt
	 aNPyk4w2nsnuEq86GFWEgTD45NTOtKvst9HpUNIqu+CJMDKXcDdzB7DcuFo7ZXTAVEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290210;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=5clN1t5rKrwU4MCARI+oepoRiTLsoiK0lgwzMEuuzB0=;
	b=bMCG06ex6+eNJxVlqA5J8gWT96R4rwX/7DAaE4QZeYzq7HM0CPXRZ7de1kj1FXFcjWiX
	 qxHM2V1bB35KjE6g7DmVADnbdsANAc1onrYjJ5c8zRsP0f5UzSdo+YaMjGkaK2mS6f5iE
	 tjqeZloM3Xvq3o7kHFsG2vAhxPfop0EY37qobsa6A0dtEyJt0fMvclJFlSjPGYe01MsHH
	 9Xtltmuxsi1ELei+fEV/xBo8TKWzQ4ihWsSoQWTRUfgf7ZqNCAkWzc1lfMVTviZb7N6Tv
	 083dtzjxqH1rK1OWxAKQXgeXJcdCoiln0PPUoKm05+XmgfxUJUvJ6UjLpFnDPz5taNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hf1b/NCc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F1D60A2622
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hf1b/NCc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704DB1F01816;
	Thu, 29 Oct 2026 16:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290210;
	bh=5clN1t5rKrwU4MCARI+oepoRiTLsoiK0lgwzMEuuzB0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hf1b/NCcfx2EYQgy4UXedC93h71hn+CoQtdGDx0cCU1ZaPKLQJzQw/RNHftyD6JGe
	 90zi9guHF/+X+87MLNMwW76fzTzZOTs3vc5ll34GJUmpsTg0uV0m3ldjRw3yFF3iyr
	 /twbZcwq6fL1LC3YwZ+K4gZTt0ql55MMlgtFk6T4dpVD5mf9ojm7FjGj+Yf+YSa1E0
	 +M/Z0GIF6JkXJe52W9x4fQxIGE+EexDZmmtmveXUKrY1lZslTzI9Kwce5tTL7jEt/v
	 oPWPmAIBVBX0vcp1X2KySWznwmwZK8Hmv+aknuA8fD0fXKCJj2gBNRpkrrVUkynTq0
	 sjiV9qTTCRsDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 66ABC3808221;
	Thu, 29 Oct 2026 16:10:10 +0000 (UTC)
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
Subject: Re: [PATCH net 0/5] eth: bnxt: fix Rx buffer leaks under OOM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179329020904.546068.3559590554460905809.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 16:10:09 +0000
References: <20261027234940.1267225-1-kuba@kernel.org>
In-Reply-To: <20261027234940.1267225-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, eddie.wai@broadcom.com,
 prashant@broadcom.com, huangjw@broadcom.com, gospo@broadcom.com,
 brett.creeley@amd.com, ap420073@gmail.com, joe@dama.to

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Oct 2026 16:49:35 -0700 you wrote:
> Commit bd3beb5c8691 ("eth: bnxt: disable rx-copybreak by default")
> changed the defaults putting users on buggy(ier) driver paths.
> 
> Fix various ways bnxt may leak buffers under OOM. The first patch
> fixes the real bug that was hit in production. Second patch fixes
> an issue I hit while testing the first one. The next 3 patches
> fix other Rx buffer leaks pointed out by an LLM during review.
> 
> [...]

Here is the summary with links:
  - [net,1/5] eth: bnxt: recycle agg buffers when Rx head buffer allocation fails
    https://git.kernel.org/netdev/net/c/db2c610df81e
  - [net,2/5] eth: bnxt: resize Rx head buffers when rx-copybreak changes
    https://git.kernel.org/netdev/net/c/09f10efee6f9
  - [net,3/5] eth: bnxt: don't leak buffers when XDP agg buffer allocation fails
    https://git.kernel.org/netdev/net/c/1b2f02fb4ba9
  - [net,4/5] eth: bnxt: free XDP frags when xdp_do_redirect() fails
    https://git.kernel.org/netdev/net/c/c10f3420d598
  - [net,5/5] eth: bnxt: hand XDP frags over to the copybreak skb
    https://git.kernel.org/netdev/net/c/364b88b54fc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


