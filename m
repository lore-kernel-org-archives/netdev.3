Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00437C908
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611682; cv=none; b=GnQ4Sh5RUunabHwmCbYL1NQ0vMwTUdpF37OAHh2QJZ7nHMFRmu3zvz4vSEKDfS34jsAFTqZjViqYmSX2G8hR3uxZG14rBDTFFdTKsEfN8gHrBKqzkUkvM8cY/XvTHHpiWqoF5xSSb+laVqqJMziu8dS0RrAI1Pr8DJJk1v0cR94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611682; c=relaxed/simple;
	bh=Yn/fYfDnrR3kRYTE0BXWIbIbSDRCFYpa68P+x1m6HAQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I+wlRiDOEzJoiInqEY1aEjxlJpZzkaMuycROs9DM1XLTsuY8ZKOUjsPfBxuedBqEPHefl97mLo3UuPL8E3JA3qpEq0tHUwxCjfPwvB/skz2SAg6uYEGA1Ii9MNIRJmFbGZJqU8axR6iHSWXAT9fXqkBiYp5JUyT+EQYZijQ6TTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJFg83k/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJFg83k/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847D01F000FF;
	Thu, 17 Sep 2026 02:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611680;
	bh=li15oYlICv8i8lV73C2z5ZeiWResEhyWp7ANMJzmvVw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jJFg83k/QimEjwIwIdCO3QX3CR6n8s7nMOdUg42L7OhXQkihh9KQNbM7IN7/cgShB
	 Wj8hPRIL+aftxB9QkeihBOstPqdcNkS0grc5Cl8i/AXWvajOe7GQ7ToRw9Dd/If1Ay
	 2jziUUU0zVVbFSkygAD7tYpvPuSHHoCe1o2SZkNJvI0BO7pf7OuQZ1Ke3R9QPovSFX
	 jq088U6pYWRZpWS/Gnn1Q0DBc/IS3v1RVQXQxzU6mlRf9Vht/2U4ctdFDz/UGfDRT3
	 d7LZCcF2TlaqPJmmMiPqvWeSUqCcXr6GgT+oQFLehufYRnLf1Z8/KRAMdNlh24cDyQ
	 jZhfdwz1pyKVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C2A39E9609;
	Thu, 17 Sep 2026 02:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: stmmac: restore previous state if
 tc_setup_dwmac510_mqprio() fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178961161438.3379718.7817224106290688172.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 02:20:14 +0000
References: 
 <20260911-stmmac-tc_setup_dwmac510_mqprio-error-path-v3-0-a76b1e2547c1@oss.qualcomm.com>
In-Reply-To: 
 <20260911-stmmac-tc_setup_dwmac510_mqprio-error-path-v3-0-a76b1e2547c1@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 0x1207@gmail.com,
 olteanv@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Sep 2026 10:58:28 +0200 you wrote:
> Restore previous mqprio qdisc configuration if
> tc_setup_dwmac510_mqprio() fails running the following configuration:
> 
>   $tc qdisc add dev eth0 root handle 1: mqprio queues 2@0 2@2
>   $tc qdisc replace dev eth0 root handle 2: mqprio queues 2@0 2@2 fp E P
> 
> Propagate FPE preemption-class mapping errors in
> tc_setup_dwmac510_mqprio() and tc_taprio_configure().
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: stmmac: propagate FPE preemption-class mapping errors
    https://git.kernel.org/netdev/net/c/90e4b849dfa6
  - [net,v3,2/2] net: stmmac: preserve real_num_tx_queues on mqprio setup failure
    https://git.kernel.org/netdev/net/c/02fffd1939f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


