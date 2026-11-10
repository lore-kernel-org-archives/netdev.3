Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334988;
	b=Fyc3M4PtB5/UYtXiyRFkaeRoF/p2IFrfgsowKVNvSH9L7AT7lnFUFA2jrVTO6gfS5cRQ
	 CnqF9pFpBqDKMh/UeiKYqeX8C2IwyxkOrOb4Xc52b60aB5nxsuF1w+USdEqE20JeREaJ/
	 73yZ9ZuLA81mFZzanrFxtLmbakpPwx2TR4uwZt4SQKLLm6/rwRkYSIWNfHZoBdOAA7iy6
	 JgBk243m9KwuGTr/RUCNKa/XaMrK87cg9+VH3+rSVG7z/e43Lpn9saj18uX85kci4a2dy
	 1vmqih9/ogu/bY8ZAtDyjEPB6cL9UsGtLYnPiNujC7P7Du9yC7Nq2uFT5lZhEB8PTAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334988;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=gFIVP2ukIR57mtsLtodnC+ROcqefNTEt0BFqlHtqGTU=;
	b=V7TLrD1wzNviifayqX9/vAPZNVeBTCoGssG1Uy39I/ALRalpiihiePGkpwh76FBU/5AT
	 PrBxalrxsmJ02W6v0OI7CVCefs+yCssSljEdEe3KI5vWatNTleMq3jn3U2mR18TArhgKm
	 +WPbBS04xRCyYgcKlOQsUhmh2ATjAH0X+X0JZvEFQMgyC1wzoWt2Nzq/0haQvYglzaEuC
	 VWzV9SfcrMJpetIK9nLTTkidc7bjG1BpdA/g5XZM1oORA6+YE4HtYcdpP6E9AwBMdAyRt
	 XPzjd1yBMah6PAOPImJLSj1ZQ6ZuVYf8/G5ojdlEu/py6WrTOOnxT7LB/jxeojFul+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L1Rf1BVO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691B760A2626;
	Tue, 10 Nov 2026 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L1Rf1BVO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53051F008A1;
	Tue, 10 Nov 2026 18:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334987;
	bh=gFIVP2ukIR57mtsLtodnC+ROcqefNTEt0BFqlHtqGTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L1Rf1BVOphEmQaZiEKSRL11F60pJRSY1sAr2vINQtkQYjbS7fn2enAgbCpLjZ9efl
	 xb7z5mk+YibdtVDBvH4CMqtDhmCPX8AMSOs+KQWv3yqpISW4quaSmeGjsVJqhdR6/H
	 pCj0lhslhAIFRqhnxNmR43STVcnkT/mp8b8NlbUU9OlMbGjJ4fiSoRPD21NFDUS2xG
	 jNzMa+lVTPOCnmUpnntyNI0/n5/qft8eyZRM5bUERiIpLUr4Ml6DzEVYI+O3YKE2aa
	 /Xjn4JdLbaHD4/oriir7GaFLvN58NSeF6zkoZwvbuIxy/TyzXyTbXgk/3rtc8oEj7R
	 tgjtgvWLFKQgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B1C939D608B;
	Tue, 10 Nov 2026 18:23:07 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: gro: avoid parsing headers from shared
 fragments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179433498617.4118637.14513799023465794368.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 18:23:06 +0000
References: <20261031050752.31869-1-kylebot@openai.com>
In-Reply-To: <20261031050752.31869-1-kylebot@openai.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, edumazet@kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, outbounddisclosures@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Oct 2026 22:07:52 -0700 you wrote:
> When an skb has an empty linear head, skb_gro_reset_offset() can expose
> the first page fragment directly to GRO header parsers. For an
> SKBFL_SHARED_FRAG skb, those bytes may still be writable through a file
> mapping. Headers validated during receive can therefore differ from the
> headers later copied into the linear head and used during completion.
> 
> For example, changing an IPv6 destination-options length between the
> short and full header fetches in ipv6_gro_pull_exthdrs() can make
> ipv6_gro_complete() pass an out-of-bounds offset to udp6_gro_complete().
> A userspace reproducer triggered a KASAN slab-out-of-bounds read there
> on an unmodified kernel as UID 1000. The same completion path can write
> the UDP checksum and length through the invalid offset. The packet has
> trusted TCP GSO metadata and spliced file data, so it reaches completion
> without an skb zerocopy destructor or a second GRO packet.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: gro: avoid parsing headers from shared fragments
    https://git.kernel.org/netdev/net/c/44818c9a826d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


