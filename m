Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7172228851F
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790211077; cv=none; b=SBOaRUHKMWb6Ktwc8LMULa/OUZjcejBw1wnaoscs2zNb4mT8Emu0dJ+gXTmu5abn/EXnpjcGOdi2iOuDzhaGNcYqs/nXbbnFC/5CFnaCVT3nuGjAdWOhwPgxVZgEXSMldKwTdgKyb2HbvrjTT95jsNY+2R6Vz3JWKNo4jMM91Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790211077; c=relaxed/simple;
	bh=4gu4oFpt2ZXr0aI47XgNEuBF23MdZ5nhe130GzLBT9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NFTbRrnxSTsFUwIkKNUxeun62VkRr7nzNob36czdt+hxWA8tc1JaNAV4QGHwlmlScxOWkp8K+Vb18T2hkdaXRAWFx5vEXCoKz7ZyWMcssZVD2Lp0GRo4Q0qODardVAkza5agDJZrbV29mO544M8HsZnt7a3aqrf0rCmj+UvLcmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2hZAbB3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2hZAbB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D421F000FF;
	Thu, 24 Sep 2026 00:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790211076;
	bh=m4PG4vc/y5GZKlJi93jzUEPxnNBuTZNbeMZnlsrp38M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=k2hZAbB3ldbRaXHoL9WsqqBG7WglpapK8/skLjgKJQ2l3YfDKTQezmSqp7ZBZI1Oz
	 i2yT0AojnXxO/JtGrm5b7tNpHscqpzzD4/N5xAN3yuh7JzgvBI8og2pEVnnvm2Zhvt
	 u+skpoc6uec0jFzIyZ6kqJKmr6tXmhpjHVCe/losF0Gs0H7Z9QnJfS94cd/turFSYY
	 JN0OJ97cVk+s1sCsX/bKIhtj1K7Kqfsn5koAziCrCQ6fgmelLFajYhiodMTQmVi8Dr
	 gYU7o6vrm9Kd1VmAOdSkIfUqeIzZ0N2sxFc+G582vexH4Pi286ASeH+M9n663wtmu9
	 6vkgVCNB1Hu/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BD739E9607;
	Thu, 24 Sep 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: skbuff: fix pull-bound underflow in
 skb_checksum_setup_ipv6()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021100565.1255052.296687664460919785.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 00:50:05 +0000
References: <20260919133604.50948-1-shlomojune6@gmail.com>
In-Reply-To: <20260919133604.50948-1-shlomojune6@gmail.com>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 19 Sep 2026 21:36:04 +0800 you wrote:
> skb_maybe_pull_tail() subtracts skb_headlen(skb) from the unsigned max
> argument and passes the result to __pskb_pull_tail() as a signed int.  The
> function does not ensure that max is at least skb_headlen(skb).
> 
> This can happen while parsing IPv6 extension headers when an skb already
> has a linear area larger than MAX_IPV6_HDR_LEN.  Once the parser needs data
> beyond the linear area, max - skb_headlen(skb) wraps and is converted to a
> negative delta.  __pskb_pull_tail() then passes that negative length to
> skb_copy_bits(), where it can become a very large copy length.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: skbuff: fix pull-bound underflow in skb_checksum_setup_ipv6()
    https://git.kernel.org/netdev/net/c/3b4e0b0c008a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


