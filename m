Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790406;
	b=PV05itn2WlsvjoETUkWACK4MyXV/pbzqoBP3FHjRkY3wkU/MWWv4SGkc1NxvXKvV8ON9
	 S3p9xLl2w2eMsfM7OB0Jvtzk2QiKs/NAwLzFvpsCJ1rN5Mih1aB2mQxrnUN+R3fm63H3O
	 nAlJUCpUeIlCPsqqTfn3Gjj1woY8/c1SrCcoJqdriL8S1dzzOOeOStD/BPUEfCe7dLP/+
	 zvj8fln9fn/efQEsfyUL0r92roBd7H1uYfwytf3G0QtxbIHESvm79OUJSrMcYFS4+SqjN
	 4Jo3u/yqwlQ94qXlftRQpMj7nBmT3fI0BQfYDD0ZJYZhqT0aJoW/ld2Yc7Rr2qo617Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=rEJoEG94chYzLx0ixR70ISKHRkSY+g49UFYD27tnNH0=;
	b=BQyIMIE1knTlnPHUdiJi+hW/9AJD628o9A/PFxY22CKmT73qCPVKf42Ww1u0ngjX1cEy
	 t+Rw+i3GIrmEg7nN5L5/yG9wuyKMB6A2KqW7C7zuOsFY2fR06UchiaAKT1Y115AzJMnqj
	 a2Hujcx0l9WPmxszwFrOVgxzAnOvSqb9osqVGMwf9e9SEzjWmROBmKGR8fSJWTgmgBpst
	 0YpHD69lGCC4JdKk6mImlkslIuF2GZU3AoRNrolEQl1apBmog0YTHyeRK97R66PjS27kj
	 TPfQyxby2IX+mp+uL9c1x0v1PXnTR6IrTjrW36VGHJfMys/IH+7lO0NwxF2j3mMS0pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VQRPRmsI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41144606A31A;
	Fri, 23 Oct 2026 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VQRPRmsI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AD81F01825;
	Fri, 23 Oct 2026 21:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792790405;
	bh=rEJoEG94chYzLx0ixR70ISKHRkSY+g49UFYD27tnNH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VQRPRmsIlhjBN0v9uu8DnrEEKaZnDHVq3AWnVanaj7YFZsU+UyYMQPKeQMRvZaUZL
	 aUMNke9StoB2byo6bceZhVFQ/Q8J0RhULe7giIgSehXBfGjlmbW8EJzLJ6Qs88ac7z
	 u8gBLf9WWdZ3lYJXpbu62ofFXFUQmcLDVm2G0bvpmBuffYOaMaDjdmc0X2R9obxfb3
	 x0EfQeAlyZH5NHgvn6FMcbV5nYUbjYiHM4f4uh+QfF8HAwUsowpsNM0VJq2oJVgVq8
	 HVUjMCElm7SueqbeCr6emJoJ3j0UTi/r3OOyVz/X/ZUAJIngHnEHbNQfXiHU+UoFt3
	 Wrso+8LAGVHKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE6F1391B157;
	Fri, 23 Oct 2026 21:20:05 +0000 (UTC)
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
Subject: Re: [PATCH net v3] tls: fix the open record check in the max payload
 size
 setsockopt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179279040457.1276597.15193164800463217600.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 21:20:04 +0000
References: <20261020121240.29082-1-jiayuan.chen@linux.dev>
In-Reply-To: <20261020121240.29082-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, john.fastabend@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, wilfred.mallawa@wdc.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 20:12:39 +0800 you wrote:
> do_tls_setsockopt_tx_payload_len() refuses to resize records while one is
> open, but the check is broken in two ways.
> 
> It reaches for the open record through tls_sw_ctx_tx(), an unchecked cast
> of ctx->priv_ctx_tx.  Under device offload that pointer is a
> tls_offload_context_tx, so the check reads a field of the wrong struct: it
> returns EBUSY on whatever happens to be there, and never sees the record
> that really is open.  Dispatch on tx_conf.
> 
> [...]

Here is the summary with links:
  - [net,v3] tls: fix the open record check in the max payload size setsockopt
    https://git.kernel.org/netdev/net/c/ed642349d87d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


