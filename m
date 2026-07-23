Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6E5486B8E;
	Thu, 23 Jul 2026 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827250; cv=none; b=N1+Hnk/jREg3O3Rcv3b0UC5+nWjVKQXAxEQW2Oqv39jLe0FzJCDge9bhwUgY2Db4MHFbv1jfcsY3JYwjAahg8LEyEsWxlBFIq4byDgF9cVEbgCoGba1calKggrbvNFr/3E0u7pq36nUPawWP8d8+fBtieA2u1b0MKqJ9i87NuP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827250; c=relaxed/simple;
	bh=1Dn8th9yqY3vnS/OeBDlqrm4o49wB5Vd5CDDlD9YlTY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O52IloxJEnGwtBeJTIVL9RtYj74KmukxiBhHReL69h+oeLe7IRv306vovdDDvnaOidUw//DJy6NXsvxdNEZ2t10nKKujlwvzvGYImL3zeykKmu3hsr0DlSYfM2OEuhWI6cCp1dk+lSkZZrAU2mS0gv6ddrd85ignyEpQWdFfh68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BD31F00A3A;
	Thu, 23 Jul 2026 17:20:49 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198FD39244C7;
	Thu, 23 Jul 2026 17:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: fix integer overflow in tipc_recvmsg() and
 tipc_recvstream()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482720565.2793774.13858678723222545565.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 17:20:05 +0000
References: <20260720214103.47732-1-blbllhy@gmail.com>
In-Reply-To: <20260720214103.47732-1-blbllhy@gmail.com>
To: Cen Zhang <blbllhy@gmail.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Jul 2026 17:41:03 -0400 you wrote:
> In tipc_recvmsg(), the copy length is computed as:
> 
>   copy = min_t(int, dlen - offset, buflen);
> 
> buflen is size_t but min_t(int, ...) casts it to int. When buflen
> exceeds INT_MAX (e.g. 0xFFFFFFFF via io_uring provided buffers), it
> wraps negative, wins the comparison, and the negative copy length
> propagates to simple_copy_to_iter() where int-to-size_t promotion
> makes it SIZE_MAX, triggering a WARN_ON. tipc_recvstream() has the
> same pattern.
> 
> [...]

Here is the summary with links:
  - [net] tipc: fix integer overflow in tipc_recvmsg() and tipc_recvstream()
    https://git.kernel.org/netdev/net/c/47f42ff521b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


