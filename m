Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001A5158A4;
	Thu, 15 Oct 2026 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060207; cv=none; b=tIJcUhqfKSF+HQ5KSmATdbMA+BebmHFa0N0Noj4DWHQSOjSpgvGN+OmROqin7axVeEVqd6WUzRbNjij98q2kgrL7Xn8m29BcSCaRn8rjZjemVfAEkrjbfAIiWrMiMhzidbIsZdaU4uNLx5vpmTGonU00aQRslqnCmBTAitU8vRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060207; c=relaxed/simple;
	bh=7EvitX3BJ94ffpUm+lBVRv61JBMXYRUOJagatJP/BOk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=St0o85ksDP1ZD6IGiFCRFb4Y4yPUBT9dYOSlhpX0JJ5CuJJWQ0npIh/Qjm2GTt60bpOPCk+iwAzMZhHz+9C2220z/kh4OPB3KCX93LBcY8URGhioL1ECHwRyQciGqLQpwInIQp6oEAjqcAZDW2d7GoP3/pd0sDzvkAHm0KZzbdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgBuLDKu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgBuLDKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0832B1F000C4;
	Thu, 15 Oct 2026 10:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792060206;
	bh=Ec8Nq8Ziew+rsd5KftGgRyX1fdV4oox4vV7rQjn16lM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CgBuLDKu8HhNwPy0oS6TNIIxj7j6II2Z8hrzSkzxPoJfIX61a+lz+xbHN6TWlUhMy
	 4UmpWLu7pi7863nuE1WHf075eFp40xXssXTROA5mjTJogTk0ke4F7ofZzGnesjFgDx
	 z0In+V5a2dwVR4y1SrmWarcHc/kpNnhHtoh28PQR0Xu272oo+YO5X5593MoKfAD2Fk
	 Rc/PGG2J5I19fzDxqB1igCMp1W+tT9HUa/YIiOapV6bVZ05/yl3yom3zhGxSJ2q6VM
	 IVbxOFKekETdzMa+tQQ1miBMi6aiSoAyxRsWzcBAeDU5vRKwtVBXrj+lhr5+ZJah9T
	 cse4J3HC5tmTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16AC392EA54;
	Thu, 15 Oct 2026 10:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add Gustavo Luiz Duarte as netconsole
 reviewer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179206020477.3338898.14395758446439244093.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 10:30:04 +0000
References: <20261009-netcon_main-v1-1-6d298ab5a0cd@debian.org>
In-Reply-To: <20261009-netcon_main-v1-1-6d298ab5a0cd@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: gustavold@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 09 Oct 2026 06:39:25 -0700 you wrote:
> Gustavo has been the most active netconsole reviewer, let's add him
> to the MAINTAINERS file.
> 
> Add an R: entry so get_maintainer.pl Cc's Gustavo on netconsole patches.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: add Gustavo Luiz Duarte as netconsole reviewer
    https://git.kernel.org/netdev/net/c/1c1e8c24d537

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


