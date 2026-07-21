Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B300207A20;
	Tue, 21 Jul 2026 01:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784597446; cv=none; b=uq7cjKJhm9YQNCVqLr6c5tw4jmHoD5kIHEo5aHJUM247il9biCmwkD2ztrxovJG3pe60y47CrnmF05Xx5+uI3cmkqE5mf4P8/o++fIpF1asSJptI3tGpAgjaFQMC3ckgG60thB9Al5Z7UD/LvYZPEfT2U46LAQvyw57w7RieYmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784597446; c=relaxed/simple;
	bh=hBBz0FL6x39qc45vZ/7ZsZb9yIVNqSdr9TwhtCjSCcY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d7o5KjPECg7U0ahhRJOaIXC+2bmv3x/mO4f27GDCZjKl9jgahcPiJgeVCS3P8qtoQqBd8cOcdEpnTBdGJ8nL2aFCe62KxaSEaVC+nyPK6K2qSss1SjsT1UuDh41KZK50dA9o1i8Oj3fp3XYdPfxjkNSYRgpXnO6xdh1PfUzIVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry7UBgrb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry7UBgrb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D391F000E9;
	Tue, 21 Jul 2026 01:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784597445;
	bh=z1+43vwyhZWXJ/E2VcXAP/J3MK4ywKVO7WtCnWSBsgU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ry7UBgrbmBt3z5byFkZjSQMCifBqbMNUcpxUthCjEXVTJvomajBNnCJhVpGzXMSoC
	 OYF5UxjNREOy/9xw2VP0AkKPRt3pKDCrppdlCiiRwSAIBi77eCl3l2L7/LvxxqTSiO
	 mpDgEHf1L3FMBrg0V6Z6Jpmr1L337XLK5uf6dTbxQUnwhSCInLxVIl+KtnGAoX0UgH
	 BhtiRYyyouHWB8FBcLsh18JNHHrBbwruonzw5CNYuLHUCVkblEvREcz+pOytOajXwm
	 D0Zvkmlo7v+uARENX0vYDegCJXHTvRHy2Nkfz3/BP4RlSjLtoZdeomCuJXBNdn6E+i
	 /VwkyT+ziRI4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A8739244E7;
	Tue, 21 Jul 2026 01:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net/packet: avoid fanout hook re-registration
 after
 unregister
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178459741515.39048.9356471493987145732.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 01:30:15 +0000
References: <20260707104440.833129-1-david.lee@trailofbits.com>
In-Reply-To: <20260707104440.833129-1-david.lee@trailofbits.com>
To: David Lee <david.lee@trailofbits.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dominik.czarnota@trailofbits.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Jul 2026 10:44:37 +0000 you wrote:
> packet_set_ring() temporarily detaches a socket from packet delivery while
> reconfiguring its ring. It records the previous running state, clears
> po->num, unregisters the protocol hook when needed, drops po->bind_lock,
> and later restores po->num and re-registers the hook from the saved
> was_running value.
> 
> That unlocked window can race with NETDEV_UNREGISTER. The notifier can
> observe the socket as not running, skip __unregister_prot_hook(), and
> invalidate the per-socket binding by setting po->ifindex to -1 and clearing
> po->prot_hook.dev. A one-member fanout group can still retain its shared
> fanout hook device pointer. When packet_set_ring() resumes, re-registering
> solely from the stale was_running state can re-add the fanout hook after
> the device has been unregistered.
> 
> [...]

Here is the summary with links:
  - [net,v3] net/packet: avoid fanout hook re-registration after unregister
    https://git.kernel.org/netdev/net/c/50aff80475ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


