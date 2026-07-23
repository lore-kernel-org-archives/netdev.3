Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C53472795
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823658; cv=none; b=EI6N4m7/RCh4fyUz1rszfL4FxmHZQ32WaJoXhRdEhe8Jp682zBqxo+Md8cFF7dJS4gs2CYAw2Up+tWGY/D30SXd2B95pcP5zRp3HK9p2EnqbPUIVJ/QBcAT+IwOuLAvV7sfiByRJoqVvAzRd13SK55qVUuoj6TMP7px7A+fC4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823658; c=relaxed/simple;
	bh=jaIjMAx/tWGxQ7X8EZ+cUn8viL2RFM3lavUZRQ/kfyU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DcVIZlMR9j6T5pG2qoYz93mnBUzfbafehg/fMKFKuoVbD/HoTUDvZpEj3cWBN9IjrEtXjZOdjD/WpMe9bcM1iwTfW6UdtaxhMXD+89Zy+hOMEE/TUVEaADMmrrHVbbp0DLti9+YDUJhMmV1tc7QfolEdIuHHmvVyMIB7iNE7aBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85701F00A3A;
	Thu, 23 Jul 2026 16:20:45 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A6D3924478;
	Thu, 23 Jul 2026 16:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: slip: serialize receive against buffer
 reallocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482361139.2769750.521735330873222606.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 16:20:11 +0000
References: <20260718073631.1674-1-726ksm@gmail.com>
In-Reply-To: <20260718073631.1674-1-726ksm@gmail.com>
To: Sungmin Kang <726ksm@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 18 Jul 2026 16:36:30 +0900 you wrote:
> sl_realloc_bufs() replaces rbuff and updates buffsize while holding
> sl->lock. slip_receive_buf() reads those fields and writes through rbuff
> without holding the lock.
> 
> An MTU change can therefore race with receive processing. An MTU shrink
> can expose the new smaller rbuff with the old larger bound, causing an
> out-of-bounds write. A receive callback which already loaded the old
> rbuff can instead continue writing after that buffer has been freed.
> 
> [...]

Here is the summary with links:
  - [net] net: slip: serialize receive against buffer reallocation
    https://git.kernel.org/netdev/net/c/ee7f9bb9320a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


