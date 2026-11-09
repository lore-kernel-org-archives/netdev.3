Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266407;
	b=NweYO7y4TCOIGYruxJVuZCZXHMTdaP8cjBbu2d7tLEZmlAlV/fDkI85kZJjiAYpzNF+i
	 9AEcMSLMgzvUU+nc77M0o1ql/IirHMoRK+Rsj+LmyZKD7O++ex+f5vMs36PATmNkQPKjr
	 QaFQFt5+u4wgnXxDPGuTacpHVrf6wLOFKwKfQ+XAd7g02l61uHTLx4JECKcxkjgIGwfcO
	 sbXyiTWWZKIbxyWjfF+g3LCGfURAuxHBAp6P+IbOCI+khu4cpI6PsST2GG+zLLqbu07UP
	 26n2Oa2cActIU7MzkmYnqO08pgII3wyh3MGL4/CarNsrQG/XfWDWOTYqM/9L1VM2zGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=wFAP8r9CaQQlfx6iSws7XcCoEgxpI34vrJvw4H/11RI=;
	b=RELOZnUI1h/XTO/f3Zmxajil3awhEKrK+e0H0BPpvoRXXCq6FqMlDEpMRX+8rgjhNI06
	 jIdDlcZHgje1uZ63p9kxYbdDBZgOloBIZ2ofmcHxenq6HNVacCOUyFx3H5O2zlQu8C5GH
	 2LtAJHKZ7u3HefGnjiue5fOzA96UmPhXdaDQQZGeq7R9MScJKd2q5rFH7AaFAzick468B
	 /9pJHRhjMVUjV/se7wF+28bKNcfxq7UAgwBInDhdf0yvH4PrgAtf/dneSU14ifsa70XEC
	 bDvu/U7xRDJ1xnesswg8pXYG5r6rMQ7szTey5bucb6QY0zNGCEGe7K9JQdoeAjFFAZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="at/Voxot";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0B606A326;
	Mon,  9 Nov 2026 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=at/Voxot
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6871F008A2;
	Mon,  9 Nov 2026 23:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794266407;
	bh=wFAP8r9CaQQlfx6iSws7XcCoEgxpI34vrJvw4H/11RI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=at/VoxotQ1gaLG12naEs/Lrq+/DMK+KU9jEfKRUMqib+2IZ2fTtdFlgB4Tmykv5N/
	 INWqsvL0dGsGPVgWf1/0dDeA4WQqEbSzdNRzcXaYwmSIUsOtWElcU0/yVSAVAglMjM
	 atyCGMckMdf0jJG9GeBhcF0f3E7Px4H0/HeD7YctZV/bjpCgg4WS2XsMMJHnWHXdeV
	 pF1MyyI+vIVcTIHTPm6U4kIhfj23ueMGbyVFYFKt8lwI1SmE5fPlE393St0lcVC9BG
	 /c07Z6nOQKpb87LJXNVmvQHd+WzGitxGCKQ292zho4IQLrD7ZaeUaaPiMfFrqfxO4p
	 9txLQFRDJqO2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 210B3391AF99;
	Mon,  9 Nov 2026 23:20:07 +0000 (UTC)
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
Subject: Re: [PATCH] ipv4: keep XFRM headers out of corked skb lengths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179426640593.3539542.14588290897473786391.git-patchwork-notify@kernel.org>
Date: Mon, 09 Nov 2026 23:20:05 +0000
References: <20261030042229.74068-1-kylebot@openai.com>
In-Reply-To: <20261030042229.74068-1-kylebot@openai.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 linux-kernel@vger.kernel.org, outbounddisclosures@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Oct 2026 21:22:29 -0700 you wrote:
> __ip_append_data() allocates space for dst.header_len in the first skb,
> but includes that space in skb->len until __ip_make_skb() pulls it.
> Fragment accounting uses an MTU that already excludes the XFRM headers.
> As a result, the next skb can have a fraggap larger than its capped
> datalen, and skb_copy_and_csum_bits() can overwrite its shared info.
> 
> For example, five AH tunnel states can reserve 500 bytes while leaving
> an effective MTU of 348. With 40 bytes of IPv4 options, the second skb
> has room for 288 bytes of fragment data but receives a 500-byte gap
> copy. The overwritten shared info is subsequently consumed by the skb
> release paths.
> 
> [...]

Here is the summary with links:
  - ipv4: keep XFRM headers out of corked skb lengths
    https://git.kernel.org/netdev/net/c/0f47fce51a98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


