Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436810;
	b=zegHGpsWJSA+5P7PxwiYnXcuisrtV7AMEf9GrJnOaALG+P9VGPyoE7/RHC6kiD1tdOd1
	 70yybeunnFnselSq9Y5RmRKBx0n9ijxV2YKy7BAUoylfK+h+WRx83T9MLBxsbz18c2GBL
	 0B7z9SX8idY3pTsFL/QEC/KIpPtSHOndjQQCJAhdKOJ8NSGJg/+z87Id1o2e2Kxa26erh
	 Q7OyQnEqqNXv+AinMbw/b3YHAvRqJqT3APsOYJ9+gJ3QnUMNvSvICGPKDHRFZBcpFEArx
	 tW0M0jnZEK7LH57SZcvBstHE2VaEQPdTfTJpdID6q08FMM7JZIjHLzMvJQWEfi760kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=7wWjtPjjZSppAgYUk9uSx1cHsbNwsbiGqpMJOnAUj5k=;
	b=jinvOvjMrlbby7FXW1rneIovV6t6bzTo9MZbfSxo0AJ7qdHbMcPYnaPBE5zfA3qy1IvE
	 BoVf1YlsVOH3UMWvF/xxNJPqq8VDni0T2RLKNCq/wUr9v9DPXicGwBL6DlJxpXNCbYM0+
	 1tpTdsp2P9S84veOZf6hIa6Q8+W4MugEeeGVsYn9E45IYSMypbdLwfY8ny1BN7fRACzCk
	 cez7hknH4QIjpC2eLjWYAmRCNufPKeD5MaBJnAgr/Y1LUZyhWxVhJ3MGZlDsNQvj5Vz6m
	 kkZX0V5bntaFR2ZURPYFyjnH40wUQAcJmsjOwHfe6cIkaWf044UFqqJCELUTz1Y/2fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkGVRmKd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9836606A33C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkGVRmKd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DE11F00A07;
	Wed, 11 Nov 2026 22:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436810;
	bh=7wWjtPjjZSppAgYUk9uSx1cHsbNwsbiGqpMJOnAUj5k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kkGVRmKdNToLGwRoNcrjyHvuQiltPr6uNg4oMicDo/9X6fdoizW16eXwS5o2Yyi0o
	 NQoV6J78Bl31FS1YZod6mEsv3QJtm5zMZrI6cXbVlWXXrpCr0g6kzJOk8w6i8/ejGX
	 R4L3imX31nxN022U+ZUtVYpRY9E/pqVEykTtfCG3XnC3InZcc2nlbVoMymaJnJkQoy
	 sbFbWF1EfnOfySJPc6aOVejXJFIHQ2Qnj7ATTaSEVJP/JDziFMpqYsamLonZ28KyfK
	 FdKEt8DNUcHoF2cOvgVdyVQ3tzLmWjqBb93795+MSKm0QgaG1mE+xtmled27wvdaDk
	 EowvU1Nlx07/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5DF89391AFAA;
	Wed, 11 Nov 2026 22:40:10 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: opt loopback into instance locking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179443680892.1682529.2463544220659930779.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 22:40:08 +0000
References: <20261109173902.1225585-1-kuba@kernel.org>
In-Reply-To: <20261109173902.1225585-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 09:39:02 -0800 you wrote:
> netdev netlink iterates over devices when dumping queues/NAPIs/qstats
> etc. and takes rtnl_lock or instance lock depending on the underlying
> device. Currently even if all the "real" devices in the system are ops
> locked we still have to take rtnl_lock for lo (only to find out
> that it doesn't even have queues or NAPIs to report).
> Opt loopback into having control path under the ops lock.
> 
> [...]

Here is the summary with links:
  - [net-next] net: opt loopback into instance locking
    https://git.kernel.org/netdev/net-next/c/69716ab31a4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


