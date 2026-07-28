Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F542B325
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238842; cv=none; b=J+t9npZzpd7mqwBpT/mfD8o7Tf54SW1+Q+Lqm4GUV1Lg0AcHqM+3FyZdTgnOVzYq/nuhuhbPJpF/HrYhlJyzR0NFLFsRZpenEXsMau5weQWg6PThadwRYidiqQVMtrosxFdQaM/At/iqq6ZwtjvqUgBNykaI4RikBxHPPRkAXvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238842; c=relaxed/simple;
	bh=cWJSDSYbCzzvb92hPopw1U6H9R4HT7KxZQ0W6gA9ue4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iYuBh8ZddwFzCbTfwEaDoDCbQpTYQAwfi3GktsWiXJRNYoKSVcQNjG8CbhONRpzHYQTvqQKg2Z2wNrtJHaoLH34ZUA+jCc1qc5G9Wp66ud8fgF1wtCkERWhCEJ3+lghlQxeT4ehIaawZKGJ7X1sIDF/+Gi55kTGphgQ9pv/QLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izw9BOfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izw9BOfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702151F00A3A;
	Tue, 28 Jul 2026 11:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238840;
	bh=PH8Fd08Oc17wWM1BlqpgIR1OBNIaSfLtDwk+VUX8yjw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Izw9BOfMB/CQ3QFT66v/wodsqtj440se3VFctFlmGvxnDsyOm0TPDuGMkvi80lTuk
	 XVpMrVRHjElHi1i6SmcVuEV7mXhyfA7Zn6OLlwYXl9wTgHLFBic/iAoI1zamivyd7z
	 eyhViS+Csqsjn6/ERveBSenRhuBf3DIlGkAeNT5IQ8NDn3nCrwUT3/Q5TwyuJwmaS7
	 pGOHLZRStdDkXo/WICcPep/094lprhtBSBJulfr8XlKCtCMHOQFLc18w2Nu9W6mpHq
	 kMbHZTEsZd/c0StARR/JOBuw9jTTnqziD1r3v6F97aimGeTHeAXNcbqEV8X++tP28/
	 tJ2K81tGOdp0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93930380CEC4;
	Tue, 28 Jul 2026 11:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: udp_tunnel: fix memory leak in
 udp_tunnel_nic_unregister()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178523880539.1689306.5682755020016332533.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 11:40:05 +0000
References: <20260724091137.1792543-1-edumazet@google.com>
In-Reply-To: <20260724091137.1792543-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+eca845fb8c18dd6b44c1@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 24 Jul 2026 09:11:37 +0000 you wrote:
> syzbot reported a memory leak [1] in the UDP tunnel NIC offload code.
> 
> When device registration fails (e.g. in register_netdevice()), netdev core
> unwinds by sending a single NETDEV_UNREGISTER notification. If work was queued
> during NETDEV_REGISTER (utn->work_pending is set), udp_tunnel_nic_unregister()
> returns early:
> 
> [...]

Here is the summary with links:
  - [net] net: udp_tunnel: fix memory leak in udp_tunnel_nic_unregister()
    https://git.kernel.org/netdev/net/c/080695e6f005

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


