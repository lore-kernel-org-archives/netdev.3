Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040C244667
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896605; cv=none; b=UGgZ6h5NXcO1eLs8DOEcyresLS3BA2TAe+2jYt8sAEY+P2uUvLKhZI3fA0f4aXlcwnudSBA9laiS2LXjI7DwLrgIq1L2elffG1mM6mfiHr8NjOeT6veeo0VM+UD/BKlH9eXRCfVBAFPhONzHfHgL5WgpLESzqS6mudQ+LQNXbQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896605; c=relaxed/simple;
	bh=aWfuAsYCfFloIS6pQ0klxVXZQxCiS3hVR7W80FyVQ5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fdDohXXLOp3D5YneKqhOTtIP1Wme577RBbSQlnpALkGCFpP+wNVOtc1/w30qj7Zc+Mz3JHKiTqShVeIHy2vS2DPebUq7cPENB0MmGI+zxSxc8TJ6X8l20z8Q2hGwL/0P+n2YPUD101JTttY70q51m6oIP1tPCmqsIp4efZVz+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiYjVSLp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiYjVSLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06755C116C6;
	Tue, 24 Feb 2026 01:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771896605;
	bh=aWfuAsYCfFloIS6pQ0klxVXZQxCiS3hVR7W80FyVQ5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eiYjVSLptAyS6/2S78kqQn6CflTyIQz5yDRaTS5y0fHSELcjVWtfv8LIyktM1LOc0
	 y0qfr9Aog0NYvBb30f9rUXNHwWul1VYU23roMR5BSsyHSvebqO+FavNqVnzBVcAxOG
	 WqLP3mBbub/tsCA7/c1p5pq2xiSSwrl5vo915VzGWdBfJ8vJT+IzWd1v1/H7rfcYbi
	 Et587Krp1X9GFEoB+GC/CdKFHj0fGeePfwqKZ/yv3k/XYo9hDkx8ssh9LT77PeMU8m
	 MJkdJXylyHKiHBI3Um0UXN3T79KA6UJUYcmktN/i1m25ZbQQQhVCiQMaeYLQjP6J76
	 zABo/OJYp7nYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC623808200;
	Tue, 24 Feb 2026 01:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: do not pass flow_id to set_rps_cpu()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177189661079.3265070.18042719522936306030.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 01:30:10 +0000
References: <20260220222605.3468081-1-edumazet@google.com>
In-Reply-To: <20260220222605.3468081-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, krikku@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Feb 2026 22:26:05 +0000 you wrote:
> Blamed commit made the assumption that the RPS table for each receive
> queue would have the same size, and that it would not change.
> 
> Compute flow_id in set_rps_cpu(), do not assume we can use the value
> computed by get_rps_cpu(). Otherwise we risk out-of-bound access
> and/or crashes.
> 
> [...]

Here is the summary with links:
  - [net] net: do not pass flow_id to set_rps_cpu()
    https://git.kernel.org/netdev/net/c/8a8a9fac9efa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


