Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2197434E4F
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619641; cv=none; b=oqmg8eMB3gKlJEVWG8dQIcskQmcN06qq9fJv5+zCtD0VbhopBL70PxnN93mryrzFCI+Bvh0Jc0DuRyzRVyAc47Sg74iQrfr9+OJOLOvZw+Ur9djDhi48LbKb+8MXdv2Z4XMyK0s+E+oMaZ0UQ6ATCCKkEjrFEweYVOGPUpL5nmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619641; c=relaxed/simple;
	bh=OH+bQYTa6ABwiqIX3zZgnPy6/sKCZ2u+pgB9bqOD0SA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BPfJz3/Ngh3OfuJjMGGJP/2JoawggPvSGMG9p4rIINaQ81V3p8O6nyHk0AUkl8JJYFyG3PjJRCDJOUfSfIkXWwXh1IrfLd21c9tMRoGQ6YqhY4GN5Ht3RXT3Mo0TTUBBvRcgXgxvvPR6bQwQiUOPgCcCFOf05sNHQkjsOxtpAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diQSaNI+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diQSaNI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846D31F000E9;
	Tue, 21 Jul 2026 07:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784619640;
	bh=sPCyNCaLhFZ6a6CMPBE0tykwwYDJX12kQFjF3HzoTlQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=diQSaNI+2SiQ7R5646+dRJEriX9a5l5DN8I5gY67Gs0lXZrcibFvy6Ov6w9Zqt42U
	 alYJIY3uE7q7Ku85aWvQ1WttdH6cnWQbzZ2Hrzm6tyK81Ys76LvdRcRp5v3BMSm14Y
	 3V7OjaLjRD43HzuOYKSfAhtZlrNvG925fPnqrtZpfzlKtJC/EH9ogIbk55lM8i1DwX
	 5QlpuHlWxiKnXdMJvBuNefXHr6xasvW1v5qOWx6WTJd9uu/6SaFe8zylcvvBuryjGD
	 7zqeBwNVnfwmYOFLmeviqWHkam9abN+tLoUQaqGjdFhglKm4h+veCqO0tAB6s9uTd4
	 mlEdVjq0RyKNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C0B3924A27;
	Tue, 21 Jul 2026 07:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] geneve: make geneve_fill_info() RTNL-less
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178461961014.135554.12919312491545775223.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 07:40:10 +0000
References: <20260707145331.3717941-1-edumazet@google.com>
In-Reply-To: <20260707145331.3717941-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Jul 2026 14:53:27 +0000 you wrote:
> This series makes geneve_fill_info() independent of the RTNL lock by
> converting the device configuration to an RCU-protected pointer.
> 
> Historically, geneve_changelink() updated the device configuration by
> copying the new configuration over the old one using memcpy() under RTNL.
> 
> To prevent the transmit/receive data paths from reading torn values during
> the copy, geneve_quiesce() was used to pause the data path and wait for
> a synchronize_net(), causing packet loss and latency.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] geneve: pass geneve_config pointer to helper functions
    https://git.kernel.org/netdev/net-next/c/777434f53e77
  - [v2,net-next,2/3] geneve: convert config to RCU-protected pointer
    https://git.kernel.org/netdev/net-next/c/0ba269933f73
  - [v2,net-next,3/3] geneve: make geneve_fill_info() RTNL independent
    https://git.kernel.org/netdev/net-next/c/5415c41a8378

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


