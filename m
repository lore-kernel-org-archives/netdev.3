Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F62E5B02;
	Wed, 30 Sep 2026 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728819; cv=none; b=uv0aMKkoITPykv/UXxGPjizJx7PRnYEuhmOr6VbHM8L00FiSmNAcohe7zuOV1TIYyUN07Nt0RCVxf18s56JoHbHFRijP61+E/ETXEi0qP82hR1O7rBLtPONni3waYYcmlqvqG0owL+8ghORkpsycLn8UptjxwIb8Y9Qm4Wf5wSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728819; c=relaxed/simple;
	bh=a3OrJKAFtE9TS0xCtfF2ANwbZXj6VX4annINJy8CroU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ImOmN4GDU/5eBtJiAOUITRm+Vs76A3NmBEtozFXu6HR3QvO6ktY+FtmbK6uNkVqNmoDs+O2t1iZrPl1xbR7iYIzOBpLtYf/NOHqSt9N2knBwYLHwJU4qX0a0Sq/Mm8Nz2jDCKJBQoPErMqWuI4w3rtpiwpZqNf+XJanv5n6sXhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D91FhCXc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D91FhCXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6681F00893;
	Wed, 30 Sep 2026 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790728807;
	bh=e0AF2q4ZnJQPodol5cUCUuhDFNo2qv9lf+h3UkzBQfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D91FhCXc2wugqcJ/TD2kMC0jcnBQjPZY60vsopVG4bL02gy0GsqID7tv03o85q9pN
	 T8K58qaHL5SnAnOWW1+kFpHiNpwLjrJdE6IJ5mfx//3cpEEgSNwBU6yHzohBbKMTw6
	 5Z+qNTZXyiw9G/WarQq9+wfxXPmy39+unAokQFrDy5F8LB+I1iPCWHkFUniGfE8jsw
	 ILmeI+RCyrQedhUopWRlOZ8hkTg1+MLIe11FgoN9LBX98Uz4mwW8tlJgEFr1ibpaqY
	 QkV5Byi1E0cZZdC6kon0Oz5qajfW9Jbns/QmIavzdrdXUoj0I6hIqNBnN9xSOOn1MY
	 y7JM/xsfZtj+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B45773924FEA;
	Wed, 30 Sep 2026 00:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bcmgenet: complete Tx NAPI after one
 reclaim
 pass
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179072880653.1183624.6184127314067437997.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 00:40:06 +0000
References: <20260928121454.901306-1-nb@tipi-net.de>
In-Reply-To: <20260928121454.901306-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 justin.chen@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 14:14:50 +0200 you wrote:
> After reclaiming, the Tx poll asks to be polled again. That extra poll
> finds nothing to do and does not reduce the interrupt rate.
> 
> Complete the NAPI and unmask the ring interrupt right after the reclaim.
> 
> On a CM4 this raises 60 byte pktgen Tx from about 187k to 224k pps and
> saves about 5% of one core at TCP line rate.
> 
> [...]

Here is the summary with links:
  - [net-next] net: bcmgenet: complete Tx NAPI after one reclaim pass
    https://git.kernel.org/netdev/net-next/c/a58cdf56b6eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


