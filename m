Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE8B313523
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117207; cv=none; b=sv8GSvTNevZJggTg1hIu/0ulCSP/PjGKimNao8C0SxRWfsYkrP1TXQPiCVRaBfvmlhVSTKvYOk4NnAhOVL1NTlRSBb6UJXXPWP9J46dt8pRrg7OTVYk7Nxkc2QQ/CmK19uFqcDuOe3kC2cqj97f3NjZZG1Kvkuf0yMN/BMeM6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117207; c=relaxed/simple;
	bh=Wd4/feDx4laM6DYNniYJbpBwthxmAvZoPymMlrMOQrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SYGN1M6vfttQjEf1SCEsFh85tSHwARyHpH+LAfz2AKI3AVMMle2Us91U6oukOOeC7Lfh1HomVo6w0uui2UeACq4LYF1gn7IiEEBGUqjg47auuSDE+DBlxX8TpQD8SVDH1NEOd5cozjTU8Ik1ackfEtHwE+kpDE+PjHrvLizyMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPhcQU9f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPhcQU9f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3931F000C4;
	Fri, 16 Oct 2026 02:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792117206;
	bh=dGngXH8UacWK/sRPDesVwBZAVVuIQpnFQi+Yvvg5myQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XPhcQU9fcxmtV9bRcv1V+4WxEBk2ed6b5unfO7IXjO0r8Gmq1ELULRy4U87XqSiEG
	 pLNQLFvSACAAkH0lIB1iSP2UvU6uJ4/SgaKyXeFMvJUYLS01nL4snZb6D9i7EpDDuC
	 OYpCpjhNo9KAiRMJfaRP+GlntYRLukj2u2KZvXKp2tBhP+rLcHIKJqkzYxj8+WYtot
	 8pA5Rtlx8Ppm/0O5dDXcghWMnVtSui+N52v5kcDxaux5InG/DYqqklQhJxHCXSm92O
	 vEoFjGz9cp4CFufZ4mXeoFZNLrrrsBBmimVI3OB3uXKSUu/vMdgEfUP8FsZTLAAYfb
	 LiqgGZ9RZzvXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16F63808209;
	Fri, 16 Oct 2026 02:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/1] devlink: fix reload error on netns teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211720477.18595.3783846730219507235.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 02:20:04 +0000
References: <cover.1791555658.git.petalzu987@gmail.com>
In-Reply-To: <cover.1791555658.git.petalzu987@gmail.com>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, vega@nebusec.ai, petalzu987@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Oct 2026 14:25:30 +0800 you wrote:
> From: Zixuan Chai <petalzu987@gmail.com>
> 
> Hi Linux kernel maintainers,
> 
> We found an issue in net/devlink/core.c.
> 
> This bug is tracked at: https://bugtracker.nebusec.ai/f/11365
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] devlink: fix reload error on netns teardown
    https://git.kernel.org/netdev/net-next/c/6b3e73774815

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


