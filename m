Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CE117A2E8;
	Sat, 28 Feb 2026 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772241602; cv=none; b=bv2JpMVGe2HqozoKZbzk72DtoYfyZLHsiEa0oeayMZGua3VQPgYDs8NCELR5LvI5nTmcyoSUZXc58NUeSZWZJqJmbGS6oCpIcE02i5GdBtEmsQPfOLRZKy0d8DLtWNnKNq4yzYEjvqSLZvT+o64ULk6Fea4pSjqEFJw2NnpMGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772241602; c=relaxed/simple;
	bh=EiwlR/eM9+H4+ygHvMdGfwZfAtoclx5i9DXON7FhfL8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eKzemAY5Cu10IFxuAZjNaF0PA1y/i7tsA8pmFkINpsR3c8Nziqrfd1EStmzWK5SBht2L9flLZd2loOPczzQXlTpZBZ6EIJ9pUrNHyszrdvmfUequHGUXKJWdk6vxYFkglldJcxqomHulRHtr4r1d1btyq512jEY3Sj/PcZ7IIZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ91OSk3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ91OSk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA9CC116C6;
	Sat, 28 Feb 2026 01:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772241601;
	bh=EiwlR/eM9+H4+ygHvMdGfwZfAtoclx5i9DXON7FhfL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EJ91OSk3r4eabGqizOXWU9S5YG1ZQ33VIrKemX8UPVnXUlCxdfly0YSdzoGmbXVgo
	 BNLQ8mBxADOjN4B3TT0Z1mrxYhOQ7rjePpHNM1+0DBm8QrtN50Ay6mDbTuJSL/dsIm
	 gSb/sXCgLZhXIBGHhMwTz0TNLv9LmMjYj8R7oNQQyq2ZqouSDdHiFdRK2Zyx12ZEke
	 b/IDdrTu4mxFO0z93WWYAV4HUJapjt6LqzaSfvbdhsbLE6jnKhzH4OQMY0twQF9byM
	 V5A/N2nr0K4zDpS2HJzPpXzSGfevObz8WRP4GLFxEovFhzC42ThoWzM1S4J2JVmJRk
	 8EXXWngcRdT1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEC239EF96A;
	Sat, 28 Feb 2026 01:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v8 0/1] net/sched: act_gate: snapshot parameters with
 RCU
 on replace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224160529.2828438.7441940830994363185.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 01:20:05 +0000
References: <20260223150512.2251594-1-p@1g4.org>
In-Reply-To: <20260223150512.2251594-1-p@1g4.org>
To: Paul Moses <p@1g4.org>
Cc: victor@mojatatu.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 15:05:39 +0000 you wrote:
> This series fixes a schedule lifetime race in `act_gate` between the
> control-plane replace path and the running hrtimer callback
> (`gate_timer_func`).
> 
> Changes since v7:
> - remove unreachable `!cycletime` error branch and dead `unlock:` label
> 
> [...]

Here is the summary with links:
  - [net,v8,1/1] net/sched: act_gate: snapshot parameters with RCU on replace
    https://git.kernel.org/netdev/net/c/62413a9c3cb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


