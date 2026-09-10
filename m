Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E253932D5;
	Thu, 10 Sep 2026 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056068; cv=none; b=V/fjxRSTWDmOhhnEyQIeyPFY5WXxXcqLy9/Ug6Q49yUTJpyx7WcY8hGqdNVw0HPsVHN/xEvGM4jAazqHS62WF/lLzpXsoKcT/611M5f02ZILTib50E7/A9g1ip0OGM3GKiYZkmdqt8rUJ3zGcYMKUGy5Y1llwhnwpNjFlNHMZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056068; c=relaxed/simple;
	bh=nYOAiLHnVhlq0Tdrl7niE3XueZXcWVh056mMHWJfyk0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M1Cu1MnpntnjTSECysEVPqkPsay53f3DYMvLxpNZ3xd/UdQuKGjEimf/zJ+NozDvm8z4kYBO/IPnX2L5C7RrSrac5GdDV+3/mM5hR6mg2sv8GcuBosA0LM5wF9PWasPHnYQQ6vCSLhyUk88uHTz+YuZFz28lF/65tG5PPDu+2lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf+e+K0k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf+e+K0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAE91F000FF;
	Thu, 10 Sep 2026 16:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789056067;
	bh=sI4wy2pepgKMEe5fr3L5f858dFoevafAETpn/X5YMxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bf+e+K0kAEflDHSKsl2nnEEvlmjTek983URq0ruZpPMhHFYBfC2JllZk1QqLKmaii
	 U2QGO8Byd7k3jfYLMn4GUW+pVCPdvgxJh+D1PYUtcWbU50w77L+gk3A5s6BoDlzvUC
	 qua3+a7NT211Gr847B0a44NoxQBD1xYtZPsHSodbyL+EhZv5EOEFbc2QX2rNFQaEmQ
	 gC4UyRouBY+rpLRwl3uUpQcQoX2F7kbUKflqHqZGPaL+MwyDMEHeqe3xngvN7HfGw0
	 qxm0xC/yA2DIrLT7dE3a37ePlCk28DhyYJ+9+dlIPENBnMWSWfLr4NAFTr9+posi7R
	 nEGRA5k7ck0EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D097D380CFFA;
	Thu, 10 Sep 2026 16:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/1] ipmr: unaccounted multicast table memory
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178905600438.1516091.3467977714685054154.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 16:00:04 +0000
References: <cover.1788784801.git.zihanx@nebusec.ai>
In-Reply-To: <cover.1788784801.git.zihanx@nebusec.ai>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kaber@trash.net, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Sep 2026 11:58:38 +0000 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated a issue in net/ipv6/ip6mr.c. The bug is
> reachable by a non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/1] ipmr: account multicast table and route memory
    https://git.kernel.org/netdev/net/c/b7ee18725f22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


