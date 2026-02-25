Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7239E258ED5
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771981201; cv=none; b=VrbA1cpUmtAZ1WWLH9fmjjbtZ7Ya77RC3q+6xxcHiH3nSHXedSfPA0tQ8qbeXBI5BGuVf8fTXJ0wxBPPuLmdF/UNDQ3yjYKashIpmPN/49/llFLhlFncvdoeNDoRfF18meq7O1blJEffoL2vsfz9dI1PEyLpfCJe/7/mGh3nvTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771981201; c=relaxed/simple;
	bh=rQByn2RHfTtDy+xHPGd4jmIRmh5lvJsv+dB9vMFlqzM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KiKFheRBa+84jtJu9cdQ5Chr1b4GpkL0uOWhwkTZf8twKzxWx6vSqXNZfugp9JDGJcvvOqMMLEVn25qvkNxvIbbJDpAXf03So/sBsHG/6M+z+3HHCvnKulbk7cMVew+htP50ScHdkSwiN5pQNcEEhBEqHTWhgcAh1EM3JDa9OOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyP8FhL1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyP8FhL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AABBC19423;
	Wed, 25 Feb 2026 01:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771981201;
	bh=rQByn2RHfTtDy+xHPGd4jmIRmh5lvJsv+dB9vMFlqzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fyP8FhL13dWqhCcSa1ySWn+HL8dF8GsnQM8L9oHp904LT5TsC/laqLIail00GYoBw
	 S0pPqW6yRfSPAJ9kbf0IyCkhSmkySuLoCGrzBu4K/HXaUhDMWy9WmanVfLX5NEJbb1
	 MkfiqynV6sel0A6hhB82iR5QQ1I2sM4czCU3JFVX9B3jyuKeqYfgYU+2FjajXBh0Ib
	 5ytNK3KgUsks0um/eMrGX4Xw58zPoSIVtUNlA0tDpVbOAi5Euo1G412jU7pNwGHinv
	 tnuqC8Mc1qxwO98AP7DtxN/tbdXWub+L2T3E7YcugKS0AwJA+YpvUBjfw1zSWyg44e
	 euKm4tktD0r4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F7C3808203;
	Wed, 25 Feb 2026 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] udp: move udp6_csum_init() back to
 net/ipv6/udp.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177198120655.17446.13290913764225933803.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 01:00:06 +0000
References: <20260223093445.3696368-1-edumazet@google.com>
In-Reply-To: <20260223093445.3696368-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 09:34:45 +0000 you wrote:
> This function has a single caller in net/ipv6/udp.c.
> 
> Move it there so that the compiler can decide to (auto)inline
> it if he prefers to. IBT glue is removed anyway.
> 
> With clang, we can see it was able to inline it and also
> inlined one other helper at the same time.
> 
> [...]

Here is the summary with links:
  - [net-next] udp: move udp6_csum_init() back to net/ipv6/udp.c
    https://git.kernel.org/netdev/net-next/c/f033335937d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


