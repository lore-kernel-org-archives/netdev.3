Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352807;
	b=XLXUcCsZZlBwmz2KodOgkqExogMFrd438OsepSB94qQRRdQ29SbZwtap0FhPjUvaHwD5
	 9MVUQ9cDeEzvClMnUjSsV8AcnUlKHcfaKLLD0VOQO0Bjz2mgT7xBrYngg/Cd+/q3OibFW
	 GDhZqydJ5ENBbF2gJaohoQ66zeZxoJwW+IO6iT1ZOSMZJZvwn6c75fJ0rn3jhrx4G0Xmj
	 NDUALa1KA894jfpmUH624gWt+48Jl/BXq0eXONc2WU7hz2iFiX/9WEN8Jqg/W2UjL79c4
	 OEZCqCPCW2OSYSI9x/9B6CYtz6qZSytFmAJNSg9XaHTo9/qzbC5oHUg2vTPsP/JdW/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=nEvSxNZCLWYmC+XyBsoHId+g+UapOJLZXmumFir3Bt4=;
	b=a3ErEieZ3TFoRNC/G0Po6FWjMDnTTOhqbWSXZ+d20kjoaXZ70+amPxUGod3R4E9znW0a
	 3WNJG+R1F3hHFt8zT+DOjGWsVqJbbcNbj/D1TvgzDZ/qf4uU3YAD5e0TAm1oCcx0hmXI4
	 fEtOV44pEoopZRUawOOK/C9WICfytEDicsJ5u8ac54rgLs0+E+FxEYdk1+wSu34nrHAoq
	 zl6jTAD65ILaPBzfr/mspVbokBM5oQIz6V1/8evdSg2b6tlGuRNAvbvZ7dUX1EeamOcqy
	 mJqQTZ5v/LyqIrnnEzA1SEdU4vkdJiEGMiuGXKKqnz6jqR2cboVLMP3XAzvyv71LHiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XCN/0Zhe";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2312606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCN/0Zhe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DA71F0093D;
	Tue, 10 Nov 2026 23:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352806;
	bh=nEvSxNZCLWYmC+XyBsoHId+g+UapOJLZXmumFir3Bt4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XCN/0Zhenb/5dPm93XvRlyhtQ2ezNe5OwzYq/1LXifa9dF/jE6Zu4mlA6/M+M/m0d
	 xJJGY+NIRqX4oaglHsHWboDNQP4YWJlA4iQw/FWJY4j7R9a336Ytelcbod6bUdlijp
	 Vs1Rft/QSPLj0rrqBRA6pXMT0pG08gLjj6Sf4xbpkvamfDSIzyurdj9OG08LGG8ZyP
	 wCNeYeDdvgENzEAqTl/0g7JTUXNRlNVrNmC55ynX9D147wmkRiwPOT1HsnyE9yAQzq
	 4zxJVkYDIC96oybnkkKmdFH/n/Fn39BcJwnsPCqhyHuanyxO0GiHkswmkZQz7HWgxS
	 tN/AvYh9ZCG8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E15F39E8A40;
	Tue, 10 Nov 2026 23:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net v2] tcp: do not coalesce segments after FIN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435280518.110597.1258531195351650489.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 23:20:05 +0000
References: <au3HMfqNW3_DRMqS@v4bel>
In-Reply-To: <au3HMfqNW3_DRMqS@v4bel>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 john.fastabend@gmail.com, sd@queasysnail.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 6 Nov 2026 21:25:21 +0900 you wrote:
> A FIN consumes a sequence number. If another FIN segment is coalesced
> into an skb that already carries FIN, end_seq advances to account for
> the additional FIN, but tcp_flags still contains only one FIN bit.
> 
> When the preceding gap is filled and tcp_ofo_queue() processes the
> coalesced skb, rcv_nxt advances to the skb's end_seq. When the receive
> path consumes all data in the skb, copied_seq advances by the data
> length and one sequence number for FIN. If three or more FIN segments
> have been coalesced into one skb, tcp_inq() can still return a positive
> value after the receive queue becomes empty and the SOCK_DONE adjustment
> is applied.
> 
> [...]

Here is the summary with links:
  - [net,v2] tcp: do not coalesce segments after FIN
    https://git.kernel.org/netdev/net/c/1c46780dec48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


