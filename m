Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178B83563DE
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963246; cv=none; b=PDU3S+lo6RHjBHs+1TXlaGqHjReEPm7IguPu4615Mur5ElXEDoZX0L01ZKulfOU6MDeRNuAR484ZHPejhi8xYJVNLNwQpaHBDw6cmQ8ENAVb6kKB2jl1Ir6FKqWh35SWTQTX5r0k0ijZIev/Nvu7B4k4gIjuNq6aJfKllVoSers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963246; c=relaxed/simple;
	bh=WwDkITX4aV/z3ZUwIm3L0HArYb8mXkVPRrHn037T9Vw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZUWdGx2LV3Tg4iF3une6qOyGgNU7cPmTeTflhruljZdAh+N9fDcFvAjEdrriBvzFpQwWTYZDyLlQEZbKCm7R57qraCLHEc4MHntTHpP73m9Df2wXfT2qDG2gtlADzTzJy0FR97IsEHPDzmRfWxYbPpWLpE5rrbNiwS5I9wbvb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTK+LUqC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTK+LUqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB741C16AAE;
	Wed, 21 Jan 2026 02:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963246;
	bh=WwDkITX4aV/z3ZUwIm3L0HArYb8mXkVPRrHn037T9Vw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aTK+LUqCbeoloufUyrGzUjO1mu1Yb6F2flnIR+U6OEF7Q3b697i5cb4dGsgUil+N1
	 4A+sUz4AWGes8aG75HM34wrLfaXnzhTpx1h8nRrisZ6ZEAfQeJWz6GMbKsemth8rCJ
	 0ctRH01JUOze2q2aNvv0lpfUgjEYUmQKBAW0ssA/f6/GpqprvlYcDt29AZt3fycC4z
	 viU75u6RyYep/VmNEPhFqTQPNXps2lUmW4wSeRTXE8lFtgOs13tONZV3SMWkboZpiS
	 UCshPkXJV8HGr4cu+Sepevmig4kT/Qxf/20P9uwLEYlbzm5aqWKkLrXAEgGYqFuK9e
	 5gGGXhh7D/pJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BDAA380820D;
	Wed, 21 Jan 2026 02:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: add kdoc for napi_consume_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896324310.699622.6761389403594615905.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:43 +0000
References: <20260119224140.1362729-1-kuba@kernel.org>
In-Reply-To: <20260119224140.1362729-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 kernelxing@tencent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 14:41:40 -0800 you wrote:
> Looks like AI reviewers miss that napi_consume_skb() must have
> a real budget passed to it. Let's see if adding a real kdoc will
> help them figure this out.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: kernelxing@tencent.com
> 
> [...]

Here is the summary with links:
  - [net-next] net: add kdoc for napi_consume_skb()
    https://git.kernel.org/netdev/net-next/c/cd18e8ac030e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


