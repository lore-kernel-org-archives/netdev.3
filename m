Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206B37F72E;
	Sun, 12 Apr 2026 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776027038; cv=none; b=tC3mUsQj2y3PD14pigcKnHIq5lq5Z+/vCXciB4gHHso/CAdcYtVr0xttjpZ/d1//qWlkA5r3+mm+BmsT1+Cc7zV5gLE7Hnxc7CoATRFwgO4nbnWrC2MXA+QGlQc9EuQNt3zkT0CGiieVj+U3C3l4mc72+Yjm+VCQDHymUV46fuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776027038; c=relaxed/simple;
	bh=w1bwdPfCZ0VJWoj41Ih1dh8BxW9pX3m0wzHksJTVOo8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KpSgNRGP/GfEDQ3hafhzY+3j0qpPyARaQYsbBmI+VB8QrvyzBqH1hlXWuzoE3FZN6YN0IjzytoxLcUJ7zNtvT09c/4aR/QWuxijPtY35cGi1m4uynBKdyyWLKCHfREYfN6FWcnJN4g5PJ/LaE8As1+IXYW6HOkAwqFQ41hwUTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buhfVgRr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buhfVgRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80C2C19424;
	Sun, 12 Apr 2026 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776027038;
	bh=w1bwdPfCZ0VJWoj41Ih1dh8BxW9pX3m0wzHksJTVOo8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=buhfVgRrAtHFsoPUIxIt6WaGq5+prXzwODs+UfwMj6UANutuibQo/il+m21X9oxDS
	 VTbz9h6lHj98tq1rn1MTQFbXfUPUDKFwjhs9zuw8vAuuxG6afVQzEb0RaiflN3MIdW
	 RkMkNI8947UIkbsB/wsK46yLGp0RdkyxwSrMur5Si9x/iG2KYV2yTDZ1T6EqkZ/VU2
	 OpTEij4DVtKcxP4RkWcPfUETR7wPWyVLfpm7ElyBQDgWydn+7R4wKSr2usZgQ9EsZh
	 Y/ANL9n0Nvs6r/rduCfNJP5Syf/aWJS3WpS/oZ49/oo/FN5ZBvgoIPFwxr8Z1KBGyB
	 JzD9i2OETjCzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD2B3809A8C;
	Sun, 12 Apr 2026 20:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ppp: require CAP_NET_ADMIN in target netns for
 unattached ioctls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602701104.3405581.2910022095376672585.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 20:50:11 +0000
References: <20260409071117.4354-1-hataegu0826@gmail.com>
In-Reply-To: <20260409071117.4354-1-hataegu0826@gmail.com>
To: =?utf-8?b?7ZWY7YOc6rWsIDxoYXRhZWd1MDgyNkBnbWFpbC5jb20+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dqfext@gmail.com, kees@kernel.org,
 kuniyu@google.com, bigeasy@linutronix.de, gorcunov@gmail.com,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, qingfang.deng@linux.dev, gnault@redhat.com,
 jaco@uls.co.za, richardbgobert@gmail.com, ericwouds@gmail.com,
 teknoraver@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Apr 2026 16:11:15 +0900 you wrote:
> /dev/ppp open is currently authorized against file->f_cred->user_ns,
> while unattached administrative ioctls operate on current->nsproxy->net_ns.
> 
> As a result, a local unprivileged user can create a new user namespace
> with CLONE_NEWUSER, gain CAP_NET_ADMIN only in that new user namespace,
> and still issue PPPIOCNEWUNIT, PPPIOCATTACH, or PPPIOCATTCHAN against
> an inherited network namespace.
> 
> [...]

Here is the summary with links:
  - [net,v3] ppp: require CAP_NET_ADMIN in target netns for unattached ioctls
    https://git.kernel.org/netdev/net/c/2bb6379416fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


