Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236C288525
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523012; cv=none; b=tEz8h53FNcQ3Dm3bcLEwrHJPmwezPcKYGQnx+YeQaWI6XnsSYYAxjaG7HIBoBvz9qzz7OXRkigL7AH+EGZikg8KOwyMLQ6ybYKmtDwevlJ9J9AJ2rR8L4KAtLonLpPRpdvmzliLJj8TN2gQgTcsVUc7t2CV2NHK35uvhOILDO6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523012; c=relaxed/simple;
	bh=BYF9Zjff8mjBKZ8IEj812hKhG4E3/Lvnh7sNGnAj20w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LKOLJwLn3qtawHc1ma5f7jgKHahhqbwwXgf6Dpylr2g63OW2gV3Y9TctUDJeuULIjwe9vzs3jd0E8Zdpk5htVMVEf2/u1NvPa4BPgNNEwiM065r3ZQHarc5eTfXaoACxjtTC0EyE9p5H6kL1cbXiGU/mVux/X3u3Xgq590si37E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRziB+Fh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRziB+Fh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5198AC116C6;
	Tue, 27 Jan 2026 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769523011;
	bh=BYF9Zjff8mjBKZ8IEj812hKhG4E3/Lvnh7sNGnAj20w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jRziB+FhoVYa56NfbCCZe1m4aYQXfBWISPncfW4/AyD9XAgsEyBgMkDnbm0sxmxWn
	 AYaV+j4eaiGELLmkp7W9FUvi5b7dVbBygtSyqFSdkgPxkoSv+f6/eMUGmMUKFEW+8/
	 2wW3ghAkLmjbRuDS3c4LkEfS5Lzl9K4Xug/rOalCDvKM+1mEAGVXIiOS6pgIl27LLI
	 hpPvh0FlyXeGPDyAcyOxD+CVnjDAuBEYoBbfK2QX4QBH7iBRyLJkv7snVdVwyg9bTM
	 GxzlSNjhDMZBR/P4Di8/O88dUn8VvqKNYYkJd6TDcDORhz4NN9QSoeNv7JM9Dkqrhy
	 SKnNCbR7NVXvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBDD380A97F;
	Tue, 27 Jan 2026 14:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: move sk_forced_mem_schedule() to tcp.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176952300535.857293.13184901882217765162.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 14:10:05 +0000
References: <20260123111605.4089200-1-edumazet@google.com>
In-Reply-To: <20260123111605.4089200-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 23 Jan 2026 11:16:05 +0000 you wrote:
> TCP fast path can (auto)inline this helper, instead
> of (auto)inling it from tcp_send_fin().
> 
> No change of overall code size, but tcp_sendmsg() is faster.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 1/1 up/down: 141/-140 (1)
> Function                                     old     new   delta
> tcp_stream_alloc_skb                         216     357    +141
> tcp_send_fin                                 688     548    -140
> Total: Before=22236729, After=22236730, chg +0.00%
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: move sk_forced_mem_schedule() to tcp.c
    https://git.kernel.org/netdev/net-next/c/a18056a6c11c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


