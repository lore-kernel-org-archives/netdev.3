Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9603093AE;
	Tue, 27 Jan 2026 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485211; cv=none; b=JCmyahpaJsDLVlj+bH+GlbrUdEzTV0um208VTDzxlSaZiazpqMOduJfjGe4EIEs7MT9pS7UI7LWfi1O0Dpe2L/PHB9b1UN8wyIBWx8xNo9jjgD94nTn7wKzRBypfysFTOKt7he6q9IWk+5ymRBF8fBcxLaJJjZA/0FTg6DF/mvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485211; c=relaxed/simple;
	bh=/Wn3GHD1l5REXXLbsHKtIpOIjuedPFqB6JakCmSbMYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C7gAJ4DgTTyZN2/Zf5s6bAloi3y/jUQY4VGkzxkgha/f7hTcdMTCpxJUdb6saScRw9ug/g7IiSV30kiMJ+wCqVIOiowZIjstO+R2ydGEsLPBfLbiM2Yc+wfjo85w/eAOlm4oMWr9ifCFyAEtQ9SBShJCj5r+pkZJtNlUMNQ5Lzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVGahqPi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVGahqPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF01C116C6;
	Tue, 27 Jan 2026 03:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769485210;
	bh=/Wn3GHD1l5REXXLbsHKtIpOIjuedPFqB6JakCmSbMYI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LVGahqPiuhZIKHEeQfXRuX7h4eiJQBymJAnT3rPA9oynroAILR7jbQn1mWaRZ64rj
	 9aDc+BNPcjltjxfYyo1bLv/6v27ncWlatehId9lWeDYmLYF0W8Lpn/CO2C0zDr9XSZ
	 1nJG34/GUMYQNMEh1cyLir7snVqB7KWucR/FyRnqj4xYphQ9cRjqs91tcqBxc8tXal
	 nN6naHfIlQfMSOMPIVpGAQgVmodvch7KZsKHNUuliC9Qmb5TDMvXgbapcYGQcVmcv2
	 ZZckls99DfUQj+fCShRADIOCvm6JIg76bsYmfddrHUzx4vZkip2TODRMsA6StilD8d
	 lmepvxjCvUhUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EA0D380A961;
	Tue, 27 Jan 2026 03:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] rocker: fix memory leak in rocker_world_port_post_fini()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176948520510.672496.9010356926289272974.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 03:40:05 +0000
References: <20260123211030.2109-2-qikeyu2017@gmail.com>
In-Reply-To: <20260123211030.2109-2-qikeyu2017@gmail.com>
To: Kery Qi <qikeyu2017@gmail.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Jan 2026 05:10:31 +0800 you wrote:
> In rocker_world_port_pre_init(), rocker_port->wpriv is allocated with
> kzalloc(wops->port_priv_size, GFP_KERNEL). However, in
> rocker_world_port_post_fini(), the memory is only freed when
> wops->port_post_fini callback is set:
> 
>     if (!wops->port_post_fini)
>         return;
>     wops->port_post_fini(rocker_port);
>     kfree(rocker_port->wpriv);
> 
> [...]

Here is the summary with links:
  - rocker: fix memory leak in rocker_world_port_post_fini()
    https://git.kernel.org/netdev/net/c/8d7ba71e4621

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


