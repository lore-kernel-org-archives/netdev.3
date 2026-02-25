Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522526158C
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984803; cv=none; b=PoSP+TEk53dJPh7rFFbtSudTz4fgXSR+W+vkGB1uM2V+7QxXf3UfMmsQLDQgRmPHqf+6HE2pqLJE9ROBZLfeXdKfXNC6RXtzUC8U8ZmtxBtb5kdIQvxavvmzWzu1oENikeU9iYWqSMVLtHaBdsuDaXMPqIH9F6a0NkcFt03przg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984803; c=relaxed/simple;
	bh=uGgycGnX6nonbU7yysQu+YyQxpNi8h7uZ84r16J5/mg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TStp6HAlzV+rM3pfuLrqtl/YqucSUFlIfd7Ylo76CnqdwJlFrI/W4ZbAMeUMJxpuZHmNVeFcp2iWdG5EA8kiKcV2Ko19qhHqo4JFYzbySPg37iMuc8CqeeInFow0tGk3D58YzwxOpeMVZAAllnnUwYgZFiqeHu1EpUafD1sSjIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKOArsrv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKOArsrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AADC116D0;
	Wed, 25 Feb 2026 02:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771984803;
	bh=uGgycGnX6nonbU7yysQu+YyQxpNi8h7uZ84r16J5/mg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VKOArsrvIo/bcMIESGdkQuH/y3wGSq6x7cZMR0XkAJ3RZjNWBhJ5DqG0r2aB3uFOs
	 /vLo62BWI6F7ZKNWE+GxCW3/goVZqWjqBPCOqhU1UEFeM5SBlIz4B+thI6C7ywhqGu
	 BSgkryp/LskV61FTHleZj+tigT9cJrZCRb9+ouJYGBJuy2VaxKFzsfa2b76W8aO1C6
	 uVlKZ2uWiazbGjbEdIa1nupThNF2iCTtO+33TS76EpXfFvFtImWbHlWJePZ29GJAd/
	 I7jBnQJfNc8A/61uD7mbCsx1EcAIe2WQ6O1UOGC/MG3gJU1LmxbTtEZmkuK2WlHAYu
	 +453QWLX4C3ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEA63808204;
	Wed, 25 Feb 2026 02:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: reduce calls to tcp_schedule_loss_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177198480780.34120.17584245289434634599.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 02:00:07 +0000
References: <20260223113501.4070245-1-edumazet@google.com>
In-Reply-To: <20260223113501.4070245-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 11:35:01 +0000 you wrote:
> For RPC workloads, we alternate tcp_schedule_loss_probe() calls from
> output path and from input path, with tp->packets_out value
> oscillating between !zero and zero, leading to poor branch prediction.
> 
> Move tp->packets_out check from tcp_schedule_loss_probe() to
> tcp_set_xmit_timer().
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: reduce calls to tcp_schedule_loss_probe()
    https://git.kernel.org/netdev/net-next/c/fca59a2dd0b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


