Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792495207;
	b=PpiidSf5olfEb6QNHiA+InRhlU29ceIO5xzjVkQUMtUrM28uG5mvhAIk4FiwkxE3i6lU
	 EaoBKU9Aee2NqpyrCyDWY32UMkbJaWpBMajDbC0n592k/nt/s6OAJ3Wc3SKfXJwLvRLNA
	 JFEK1jPSpD8UyjNxU9+c7on0/WI842zFiKwN0vbE3F+l4/nwMPE0yrbmTqJ4tekZwa5k0
	 t7DEn6ItET7lV6U5C//YwLlWqkx4p+T+3as1075MvPme+8y3BbLmXONRD9VkXIJeBAgXt
	 x2mSlRMAuQ/UIza6sYhGlpLmlOdjk8LmbBueXAExfbewayR4+LRTP8G4EDMyzZ6S6Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Oc64R9Hyc3/pNZgRVj7KfBCvPj3SMFX1Y/jTiXNLTuA=;
	b=QdDxNHHV3i3CV+3dzNhkaiuA45XFRYHc6fnyAHYWjUxyDQ1qUCzgaVKFsmW9J92M0FGc
	 X47N0Z21bNc3KB8j57AgbdAWw2O6/w9bBQSzBXDtwWr4o1dUB+11HWvtdZC4eTDJcwO7e
	 epXctWeIKhKmydiv/RCG6mORWEWwfsjtcbxGREzT/N4KPADjfS00DKUqX42oUQZVIrXC+
	 J+TdCWtUc5kLpGzuVaYA6cfKlQ8RVSeYlO8R6xqjUt+IruGo+i/iLVvnRZf2JgKbPj4jR
	 u3Ng0B99A7YZyM4IDplqLM8RkCrJ3+r9ZW8Sm8ZLXHRaV1dEPeHrDAvE/q0Te5mm5/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOkup+1O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB36F606A320;
	Tue, 20 Oct 2026 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOkup+1O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BE61F000C6;
	Tue, 20 Oct 2026 11:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792495206;
	bh=Oc64R9Hyc3/pNZgRVj7KfBCvPj3SMFX1Y/jTiXNLTuA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UOkup+1O25xsdt7D90F5OeB0H9xXIpME9HLDenCJqZBGiv+NXXMmWf2QRMPuwTXP9
	 T+yjep3pVcA+Ge5tz+TeP/iVN19HFV2rgRwMwQAPQkx0QmBP83s1qGOpctvNZc0aJ6
	 /VrA57c3zcAzpwEYnqVp/ocKLI4TqfsjlHDA51uNAoDbZU1YxqEnOFQuPq6V1dUDnf
	 o/dIS4RiHree8F3nl3nKJGC8aM5DGuWcRR7063iR0cEgnodJgvsN039y/BsTrnRQ1O
	 3Slw2PKbKt42sl180/jHEg22i1oi/5XHL+Go9xwqzmYHUmbQ4K3xeNkt08Yz4Cm58S
	 JAfKxMvz+juIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773633808209;
	Tue, 20 Oct 2026 11:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net-next v3] net: ag71xx: align the IP header behind DSA
 tags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179249520528.3674783.11516366226063085265.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 11:20:05 +0000
References: <20261014001334.132962-1-rosenp@gmail.com>
In-Reply-To: <20261014001334.132962-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, chris.snook@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Oct 2026 17:13:34 -0700 you wrote:
> The receive buffer offset includes NET_IP_ALIGN to get the IP header
> aligned behind a 14 byte Ethernet header. Most ag71xx devices use DSA
> switches whose tag sits in front of the EtherType, which moves the IP
> header by another 2 bytes. Every access to the IP and TCP headers then
> traps and gets emulated by the unaligned access handler, around 6 times
> per forwarded frame.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: ag71xx: align the IP header behind DSA tags
    https://git.kernel.org/netdev/net-next/c/f09123082704

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


