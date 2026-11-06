Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998812;
	b=GonG3KdfLzNPTllQdQPoYAUy2tTGmYXA0XwnxMNACG1U35ZIYN4YRP3B6rqwP+/l3tgX
	 GHmO68ThXI2Kb4uETUZVVqV6AoyZ7TWM5MbjjScEL0VZzta1nJmxoYImmQ2nHlbb4zMiB
	 e4w5AbJgHviDXAMImX1iIvWRURcCCanLmGRmZSEeatw4UXkFPnmZAC65rmZVGI9SA0JgU
	 2dAe7SclMR+Ya+dZAkYR9TQ9kEs5g8nMCw5exVlQvPrNiV7ySNluLcr8B01ML4TNt4UZl
	 TNdUDLFi6wlne50ZtDE1uxsoyk7wl3PnPN+NOUIporlHCPUCCYFJFGfk8QB2aAslXww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998812;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=6RqsR257TmrFrvV2AMqgQxs7+trJZ5nLhwY+PPk9b+g=;
	b=vBLAuR89Qu+MRsvNw7ED4fbwK1/m5QKEeHZKKfGMhj7ld9e2GawP9uxgBavUDwRnxZQA
	 HsB5aQ7dEHB5vZdhu0UCifk+w8RFN/9doSp6CJTb06v9jzfWu+7bBEGda6bpGv/evb8za
	 aIshBTvhuF1Ec5GjTVaWhPVJQr122YNvGRs9Pru6meiqsj3jOFv/j6+dhj3tUZrQg2ZRt
	 HykB/JFNmr+2JmoCtabslRZjN3GPxR5q6Je//+SJB9KqZM0R69Oks5QM1BiF0N3iJtBq/
	 jKjw/Br0PvS2t8KkGFtLqRlaOJEaUl/RpY8NdDFeWWOevZiQt1F92gLFg/eUkR4JWvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nz6iVCAF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207A0606A32F;
	Fri,  6 Nov 2026 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nz6iVCAF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70821F008A3;
	Fri,  6 Nov 2026 21:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998811;
	bh=6RqsR257TmrFrvV2AMqgQxs7+trJZ5nLhwY+PPk9b+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Nz6iVCAF+6b72Oo1qe4T79oRBJQnjofu2cyX86Fjb9Fktkxk5+NgtuiG0dBrkUCN+
	 M9KHO8nNjvKaLNcpXbdXUbn/bAvC7LZgGj5JS+8hMHFwwLL3Dys6y8apt7mfz+9kP6
	 T7VYNpBlpczMg9L9+hZlfkj2V7J6rZjMVu1unheoIs74oqu7zcWOx/SL9xAm7Mg5Bx
	 bjOD9qkHSco3TTjYLeTFeOcgre8x1q2O19j3fQOMedMO+9eYyMsU7p2zjntQjCmeHQ
	 mujbCAUC0E+zAMmV6XfUAiTSt4xurAyBD65f8rqV+l5UGDrxxaosmL3ZGwDfds4vi5
	 ewwCWglNbxaKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B3183A549A5;
	Fri,  6 Nov 2026 21:00:11 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2 0/2] devlink: do not dereference a missing
 param
 item or shared buffer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179399881016.868572.6139366787589932780.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 21:00:10 +0000
References: <20261102131505.611343-1-xiaolinkui@126.com>
In-Reply-To: <20261102131505.611343-1-xiaolinkui@126.com>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Nov 2026 21:15:03 +0800 you wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> Two devlink helpers look an object up by id or index, warn when the
> lookup fails, and then pass the NULL result to code that dereferences
> it. A driver mistake (a param_id that was never registered, an sb_index
> that was never registered or is unregistered twice) therefore costs an
> oops instead of a warning.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] devlink: param: do not dereference a missing param item
    https://git.kernel.org/netdev/net-next/c/944f5b9f00f7
  - [net-next,v2,2/2] devlink: sb: do not dereference a missing shared buffer
    https://git.kernel.org/netdev/net-next/c/0e729906cfee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


