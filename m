Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217534AB1B3;
	Thu, 10 Sep 2026 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055472; cv=none; b=WbjvqE9tA2UZI2QNA3xJDwb45mBfxx2eLCH1kg9zHuZA+A8DE77rJLAEvAPOFZpKaT/dwO7Vq10YFFOT+j2hy2AqrpcPiEP7VMmXSHu61kxtH2Sn0SIe16TCt+KbLPtc0BzqZjjEuqmi/t6SQmLnBxJmFtDny0mmaH7t4qHtXgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055472; c=relaxed/simple;
	bh=GQmQZw5reL4CquF9W000iik15PzE0oQ4asdRXnon6sY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gAyEKVUzYGB3Dh/pb9mA3K9b2uLixKu93qKTasNEpFz69PXje9BgX7Q0rG79kx7ahOF0WMzvX0wqZ2OZMxqO7gKNZi87XVKt27c2dCCMqtGuZRirFstmIkzsjkWLAeU9PtDLfj8epsz1gWh06k1KPp5+AXnFFzctQ+VZj917Pec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGajMRZ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGajMRZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41C31F000FF;
	Thu, 10 Sep 2026 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055469;
	bh=GgJ0+lwdFGcpn2epWAnc3+bajMqURy+xLEeGPvX5QYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bGajMRZ+3h1+IsdWNNh4YGnCftpOsjyJt5Gn81b1x1c6Hj0C6vf07kaWoovbCORGb
	 DVU/rJ4MRT3YVYBEm7X60JQYmuVBkWpEMLqjCwE+TXxL3tV/tqS5npMm9K3sG7Tsk4
	 B57q5r+yvnFZCS7CqG/2NZjMVFGj3BBsofHdt/v9me67UMtsiMjumdxrehAdKzilO5
	 CyoglRLmOn+DsWMB56coqKPBox7uLvoaxgq8n6mC+Aob5hyK8nIjyMtFoMvjbjvAgC
	 +wPglKZFCZOkv2qIO/NHmKHimMtFz4CDbN0v4QSrFn9GiQuzjZE8NJIlp8IiThAVVA
	 oEEob9q4qU84w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568EF380CFFA;
	Thu, 10 Sep 2026 15:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] ipv6: fix fib6 walker UAF on seq stop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178905540687.1510486.7835518380237448288.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 15:50:06 +0000
References: <cover.1788837093.git.zihanx@nebusec.ai>
In-Reply-To: <cover.1788837093.git.zihanx@nebusec.ai>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, hannes@stressinduktion.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Sep 2026 07:42:55 +0000 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated a issue in net/ipv6/ip6_fib.c. We reproduced
> it as root using a BPF ipv6_route iterator racing RTM_DELROUTE.
> We've tested it, and it should not affect any other functionality.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> [...]

Here is the summary with links:
  - [net,1/1] ipv6: fix fib6 walker UAF on seq stop
    https://git.kernel.org/netdev/net/c/19b4ed644d68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


