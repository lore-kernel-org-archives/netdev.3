Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65822CBC6
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770175816; cv=none; b=TZ/focKNUeLcmhPxW3BeWpLqXwyjQ7eeOQcnbEy4yUjP/R3xO9OkNPwGjOuPTOGYUIyy7iHqiZsMyY+ZI/pZy14oRZht6GCwFE25aUH4o6aG9J9d3rLNIgFhhzJhLkbAF+TuntE0IbZbieWZIT7qQaNTxVLBXjmiPXkdGhUgOrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770175816; c=relaxed/simple;
	bh=/7rWsouQd/jqxw0V+wgRA7iz+OxD0C5mRKlIlPbjuro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ELPdSdayPaHUS33viQMBV059m89v4JD0ZXPXWLfS4Fk1GGPZ9p4T34EqxWnWvjGMIdqQwlDRoZQ1TiG2NvuaCo9OnYxfX5tiE9gvcssse3vtWXqpOExQZY0d41/rMe/Z6NSeSCCuh/MI2TS2X3L1l66zed2slX5S3ICGp2Hjuoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAfr20jp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAfr20jp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D81C4CEF7;
	Wed,  4 Feb 2026 03:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770175816;
	bh=/7rWsouQd/jqxw0V+wgRA7iz+OxD0C5mRKlIlPbjuro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JAfr20jpi++yqdOfLTalT5xXllIrcfyDjwz5khycSiAp045mLifydLCQUTxW6rJMZ
	 fF/ukcNr0w20qw7a+R/erJVmR3TjMoz8AM8nH8FQwKSSBNv4/ONklir288hSg9NfqG
	 uPYfDAEDBqk7FMDT3bFHIDjB7c7Bm5OsoAETIwVIo9GLip4wl9AlnF5KTy+a64Prta
	 TvAzcCoqdFSoibgQC2bMXdzAF0mU80WNbFhYGP9W4Uu5Hlo7JXkP+2DEaqI5yAJDSD
	 flUaLxCzCJYvJXNGa6axjKiFPcGyO4wKD+knFdNrJCy2tBsa6mS+G2tLI00gzAkKEl
	 FFAeMHNdCj9Xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 90D413808200;
	Wed,  4 Feb 2026 03:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: add proper RCU protection to /proc/net/ptype
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177017581115.2166000.2077826690076413877.git-patchwork-notify@kernel.org>
Date: Wed, 04 Feb 2026 03:30:11 +0000
References: <20260202205217.2881198-1-edumazet@google.com>
In-Reply-To: <20260202205217.2881198-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 fengwei_yin@linux.alibaba.com, dongchenchen2@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Feb 2026 20:52:17 +0000 you wrote:
> Yin Fengwei reported an RCU stall in ptype_seq_show() and provided
> a patch.
> 
> Real issue is that ptype_seq_next() and ptype_seq_show() violate
> RCU rules.
> 
> ptype_seq_show() runs under rcu_read_lock(), and reads pt->dev
> to get device name without any barrier.
> 
> [...]

Here is the summary with links:
  - [v3,net] net: add proper RCU protection to /proc/net/ptype
    https://git.kernel.org/netdev/net/c/f613e8b4afea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


