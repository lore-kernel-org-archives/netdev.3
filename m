Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33903EC2FF
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192055; cv=none; b=FZ+fwjpyioYwfPTx7+4h7l1Qj5ysCHYztKZYDjitLJyG1Mg4rilp5TRMrR6T+Bult23pi9de2lzVEsZrXeUdWo6OrwxYUu7Y0LTBi3ep+XkUy9815Gia9kU8/ig7fKdMgewtLLt91ZXkCmFnx+9eYIyFzyJVnrxaBGWwsaMowRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192055; c=relaxed/simple;
	bh=NjXv47orKv15xAXnsS9oXuIOzeJCeKSAHy/Z1btpha0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rTZqGrT5u1+WDmbTYfXix8IYBooAbaQ0B/+ODggSQ5IPTAC4+x2yLAYm5t2vhoAgLfmacsIiEzBspt48qJ6Xz9zs0ETwEuS5yk6dhch9gLdxRLRlaBxCyVJh4+hqMdtTRYQMBomI1qObIgUTXVXwvEwYvZ3DydLyROdgfzLuo+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXh5xKKV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXh5xKKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D741F000E9;
	Mon, 27 Jul 2026 22:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192053;
	bh=T7ENtVEd0GzmtisQIa3FmH28XLnwD5IKKwoskG3iKlg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UXh5xKKVAzLirFE5pjxb+JO/fK2m5nUbRZzYuEanjSr3vdfCG/4q6yT/kDC7W+w7R
	 1KQYoo3smURDNCBmRe6ey8Gfi5LchyZHtSZV4J6fKpNHZfwYGzqaI4pqKkjJZzVk88
	 mwAdolzsBJ5a6krY6RnPPCXk3JGVD7CH3jHs57PLjWPAKpWKPdhvnTuPwbWiyarEdX
	 bo3axCbnMP7FHXLwvvr/D9nL+2/lqb6QLPre3QYc7ijgBG50nigKl5ld7Hqsj21RbA
	 mQU8Qxf69C68/r/McuCBH4SyF68hN4fN3lxscHge4scJVt8AtcLMG0rCUSaDv4zvS3
	 b9AgeiEWN1Hmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1990E380CECF;
	Mon, 27 Jul 2026 22:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/1] tipc: avoid use-after-free in poll trace queue
 dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178519201863.1443317.8809298946831933407.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 22:40:18 +0000
References: <cover.1784794294.git.zihanx@nebusec.ai>
In-Reply-To: <cover.1784794294.git.zihanx@nebusec.ai>
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, ying.xue@windriver.com,
 tuong.t.lien@dektech.com.au, vega@nebusec.ai, zihanx@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Jul 2026 00:38:40 +0800 you wrote:
> From: Zihan Xi <zihanx@nebusec.ai>
> 
> Hi Linux kernel maintainers,
> 
> We found and validated a bug in net/tipc/socket.c. The bug is
> reachable by a local process that can create TIPC sockets and enable
> TIPC tracepoints. We've rebuilt and rerun the reproducer with the
> updated fix, and the crash no longer reproduces.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] tipc: avoid use-after-free in poll trace queue dumps
    https://git.kernel.org/netdev/net/c/b4f1719dfea0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


