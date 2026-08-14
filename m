Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1D23C3F5B
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677880; cv=none; b=Eie5tKabzxgE2UpihKEAQiZ4pDZeoangzvanFWbLPrCdevD6NPs79+2ynfVRRmRu/ULet7EIzBtwr8C4H0sI2B4Fj3U5IvRYUgqjd/7a5a+LLmTPqKtBV/USdMLgZPnay+eoYptsfUYPysO5PXhutxRBhz3Yl6CsNbg3TIlSwyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677880; c=relaxed/simple;
	bh=zd5F2+RxrxJoe3gmwl/UHtqWRk9bx044/vJtFdXm3UE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DN2xwqnzHZ5Ae1eIfA4wyPlgvBVMqJSEEow6cxoMmbXm2nlzSP8m/g/0UgJn3O/gMZNW0ElL4ISy90P2R/H4PUmW20AxrH77uk0a4N22tM2rvcWnK6ZfEMBjJOVY4UcW48f7JQNo4r+UNjE+XfK5vUuyX3Q64gl33x6bGowA81Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEoaslQY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEoaslQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15A01F00A3A;
	Fri, 14 Aug 2026 03:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786677878;
	bh=IpL7d5BMtv8g6vqtYwjFf3YIMR/ZKNFHOWnIIbPY7IU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SEoaslQYsrqsg9kt3ASSVoTXCia1iQ3UnQl6UK+9HEv1BlbEmGrBVkoVkFB/gEM4y
	 yJekWcAXQvF6e41wyAvKsTrqFVeJUewT4bL5aye7KYKozInCc4+VJlO37lQuodW8u5
	 oC4uqd8zWF82plQB1XP0/v4lsVWLgmqCpvu9fAmtSYWDoVojxrloEnLEBTM1YI52CO
	 PmQ0oS3PZ/FCv2CwTI4OPf8EPi1tDX0sjiP4iDtoaR+zKOiiTvsHv76GDWo0AwOyPc
	 4d59t+RwidgDwcsIkWy2TxyZlEokAY8qrb5zdtnr21PNrGf8bdsht6B881znuPw4RZ
	 2mg+8LTShcOvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568683810900;
	Fri, 14 Aug 2026 03:23:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: tun: bound receive headroom
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178667783289.3150297.10268280469070580698.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 03:23:52 +0000
References: <20260812012139.2134643-1-manizada@pm.me>
In-Reply-To: <20260812012139.2134643-1-manizada@pm.me>
To: Asim Viladi Oglu Manizada <manizada@pm.me>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 01:21:53 +0000 you wrote:
> tun_get_user() uses tun->align both as skb headroom and when choosing how
> much packet data to keep linear. OVS can propagate an oversized headroom
> request from another port to TUN or TAP.
> 
> When align is larger than the usable space in a one-page skb head,
> SKB_MAX_HEAD(align) underflows and the result becomes negative when stored
> in good_linear. That value later wraps when assigned to the size_t linear
> variable, and tun_alloc_skb() can place skb->data outside the allocated
> head.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: tun: bound receive headroom
    https://git.kernel.org/netdev/net/c/447c9303942c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


