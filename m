Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485606;
	b=Og6w8urG2CACXroiOgNi6qiyESmzUsk5asUibAn8geMwYyqPi54Qh5pe7zeeO55sAgce
	 BpVvS3YZpy8cAvYkgzK0fY/ctruGwaPnBett8zQFZeCkvzMrgUPoIQ7M6zuC7fR/euThy
	 S/NLdeHZXBdxVSoIr7lrTYP4ZjdmynlaqWwIHwQo/5lL+e0cliV80FelAstOriYfcO3ta
	 Sn7uq9YBDoVagyA59slK1S6S7qyX+UyRoa967rjQg492FUce15jMNP0Fiq4fUljQlOkR8
	 0fFwkK1tFuO0tL/KsZyNg4DjtvNlxr7e/OvyXkxFHJOOidJQpCimpaUFEAAy6QKttng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=AzngUIOSj0Q717ZcOQxFXapOnqXzYvlnqdx3gTXyi0Y=;
	b=380QgKimpOuQEJm7zrntm/I8+TqNWEtVS7gU3cl+PaurR7tz7ctFfK92xq45pRTg/vzO
	 ouIICaTaY0IXi2k6/eY+3dA9QyJtnPp/ISkmUQND1S6Ma5Ec3WuHv+P610kBFnCta3eBN
	 2Srg+U7uNh5zePeqJNrUjbYtCPnzgVNbqpJrHWv5TUkQ9ABmoor+SogyTzxWWCCeWOC92
	 Orwk0E7/Kz6K2gFoxfgfwlaxQZHezSy/+wOZJUkKpqz0fYekiYZk82G6GowS9o7kxgnpw
	 sT8E14uGM/yR94b/imW4wwUNdAPa2i8tzHznRsTBnxxKIFuN93Hblls6IeDPZxkkXpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NnoFEyRB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D12606A31B;
	Tue, 20 Oct 2026 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NnoFEyRB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807B91F000C4;
	Tue, 20 Oct 2026 08:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792485605;
	bh=AzngUIOSj0Q717ZcOQxFXapOnqXzYvlnqdx3gTXyi0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NnoFEyRBYgYZTZ+5wPXGLZ44qskz3Bl3kq8LbLxK/25QTFljIR3szM6AXU2TkixFc
	 KeQokBZuK6+Q0piSjcU26FmJdR/EX7v1eaPyHTSIuCMeMXxh7i20g0GHg/KC33dUGK
	 byqpSW6rhvnHoSqvG8S1ZUXN0rGMbXFOSbYrV6MGbB9pV7hnt+HOZG8ZX/cNWjZLFJ
	 yFscZuLNKyNZRWTK7f94zkbp3/R6Fe9fayJ185dXs0r2+60cFjSQD6ByOgFxxyYy0K
	 Kif28MH5g46+DK7DA2u0PbqPaWJMCnvV5aPdpPOc0ZEYu4W8k6GKoIhWv9Vz+4I19b
	 0GGzDc/umgLKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774213924FF9;
	Tue, 20 Oct 2026 08:40:05 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: gro: don't chain linear parts larger than
 gso_size into frag_list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179248560429.3584560.3501678808812864967.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 08:40:04 +0000
References: <20261013130250.3643916-1-her@sorah.jp>
In-Reply-To: <20261013130250.3643916-1-her@sorah.jp>
To: Sorah Fukumori <her@sorah.jp>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 lixiaoyan@google.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Oct 2026 22:02:48 +0900 you wrote:
> skb_gro_receive() chains an skb into the frag_list of the held packet
> when its payload cannot be attached as page frags: when its head is
> not a page fragment and still holds payload, or when its head and
> frags would overflow the frags[] array of the last packet. Since commit
> 5eddb24901ee ("gro: add support of (hw)gro packets to gro stack"), that
> skb may itself be a GSO packet whose linear part holds several
> gso_size segments. skb_segment() cannot split the linear part of a
> frag_list member across segments, so segmenting the aggregate in
> software, e.g. when forwarding it to a device without NETIF_F_FRAGLIST,
> hits
> 
> [...]

Here is the summary with links:
  - [net,v2] net: gro: don't chain linear parts larger than gso_size into frag_list
    https://git.kernel.org/netdev/net/c/679f6929a66d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


