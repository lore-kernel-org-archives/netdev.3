Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145606;
	b=Nqs0/iZZIckhvFMJb3GsoUktITGWDlmR6e21cj/Mpcvt049FCPAps0qEUpiwvWFZPeig
	 BrKmAwbmz1cxxq+9KCF0KK49XClRM9yYPjVvcJuW9JdofCTxCIn/ImBgqEa61+C6oDlM0
	 DVK/aHwCsFFBT2X01k4YxRxWj18TwIXIb/A7O9FuDj9XT7Vbv1sNSs0na/CAq5zBfETZz
	 +gVx0QDZvdUcKmEysw0eXha4XPFds3oEgMKYsavJF3BtYEbB1HbHmokzNJ1NCoSmYvHY8
	 DHaCw3I1sr+Zxd7FLT0W01ryKTDajnUL2OAA8VZC33QifOuaJ/t+83/QO2xpiRmrsbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=AjoTn9YrgrNbhfUddAfHwwkSlUQsdqaQqz5hqdt5ikU=;
	b=tYaftOnZIsoM5UYLaoPFjIHBxZEklDMP1PYSAM2McqmlLBWMMbo1iiKZAQKWvx6oesXV
	 rLIKAo1SKdSkciMqhz30kgPk53+IH3iVhRdUZgQLsMNCWBjuXyyUv7CYRu0hjdZcR6F0G
	 EerNk+TaIRxKNaTfbUDt7VsRoIVCWJoEJne2OFF5S/DhpDEyaaED7u0WcxjFLhljuPLdb
	 H3a/Ra5iYLYzd23jbzIuANNvADShIeW8X5Cjm4mh+TSnVM4ugvqFzF5KayzggJMqGLSJZ
	 3v8tvLmJ77ukb13/NepuhyJJ17iCbjCRqMAwTi0S+oxdyEFv2yAco9Lf7B3pOvmR35Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U05wL2rJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140B606A31A;
	Wed, 28 Oct 2026 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U05wL2rJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2231F01825;
	Wed, 28 Oct 2026 00:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793145605;
	bh=AjoTn9YrgrNbhfUddAfHwwkSlUQsdqaQqz5hqdt5ikU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=U05wL2rJO0B5QI6UGr9iHOGgHSOVPDywQ31BATkOuyhyLsmoyhXqfHS4HIWdobico
	 tryMsTiBMpejMe6we37E5Lfx8rt8TJyUVNNb7jWkVMDz37Qamt2/Bldv98xAdg5Idh
	 Na2wjI7jID6laY0sXTgQKVz55bfmbR6MNRS8W388T4gPYsGi2QWU8saK9z6KzP9oCA
	 HWFJpK7vPmvi2e0pPZh/c8Ifrz7oRsLbi5OkYHhbUSPfwyIvuUWvBxH3bgaF0WntQB
	 d6bNbz6eHlzyVLuUPRJrPYC+SU/9mzoMN5gZa30U5guRf7Yxm/JziJc9UTmMPpVclo
	 WQiSHNI/LbfeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE4F73AA9413;
	Wed, 28 Oct 2026 00:00:05 +0000 (UTC)
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
Subject: Re: [PATCH net] net: dsa: motorcomm: Fix function parameter types
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179314560462.400918.4214891622069081090.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 00:00:04 +0000
References: <20261026083252.12684-1-mmyangfl@gmail.com>
In-Reply-To: <20261026083252.12684-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 16:32:48 +0800 you wrote:
> yt921x_fdb_add_index_in12() mistakenly takes the two register images
> as u16, while all registers are 32-bit wide, silently losing the upper
> half. Widen the parameters to u32.
> 
> Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: motorcomm: Fix function parameter types
    https://git.kernel.org/netdev/net/c/5d7f3375cd57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


