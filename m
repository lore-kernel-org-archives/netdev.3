Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CE2AE68;
	Tue,  6 Oct 2026 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245428; cv=none; b=ubvefBWEengemSF8kLfcFbjyCRIS7qbkIklxvI1VmsIHjfxQwqJQ98iLMuP55J7+aV3fJ5p4uBQllwx+aiPe9b50sFz8SpClKcZm+HxxnPwZgl7r4xlAiM6FUBD6fIRMXU93+Hu6vNQm8k4CtKOwWxtlzlRxw1x+33Q2dFdd6wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245428; c=relaxed/simple;
	bh=yVeApQAFp+bK3eAXzs7nKcHwaHKRqbvfKdqzJ9aL7EU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EoWiu8TKVFJhXwZnDdzjFdMvXu2u3hdMx/x5z6d5vpgOcfaWy9hMITbuCKgtsxRwzgXSHZewpT4OHbgVPlYXh1P8xfrDmm/rwi9txRVTHvVaP2RGiSWJPQOlmcqnzuaj+Bn/Q9LdtcJngtbFGNRuJSZHusioOk4JldiIRqRkpwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIO/BQuh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIO/BQuh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46901F00898;
	Tue,  6 Oct 2026 00:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791245426;
	bh=zTnAfSCB06cvyYOXdeCVy6x2QhkJ1JtR879dQnP55ec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lIO/BQuh6OLaWAGKTMli6PTy0Y4xQadSnGYMB/xvvJBl5Vq+r5RfwqmEB5Dp35LNJ
	 WKU4+utwUBGECpAwNMduWfSlqRCZG9olwBTb701z2ms8/gCCOeXJQLajjxYBoJse/I
	 3ynykuoiyuZNor1nMxLbcuTdfhh95coROBFBEzuxTM54FYcgqtK+pfGBhb0vbrEJ3E
	 MtVvS8k3zzE30OV50Uh+18xRDnFQC4tGcA8ugXUwnGhWXq9q7JNhSw7uY20A3CXY3t
	 1C0lM+CtmWdtPxcX38u7sGwRU6Wa6cr18TaFbtTIIFdm42oeEOXt81XL/aDh1VqP6S
	 cEVP6tWQulp6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4443392667F;
	Tue,  6 Oct 2026 00:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/3] net: move the netdev_ops checks into a
 helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124542529.1947351.12475654404297764079.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 00:10:25 +0000
References: <20261002094211.2350702-2-nb@tipi-net.de>
In-Reply-To: <20261002094211.2350702-2-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Oct 2026 11:42:07 +0200 you wrote:
> register_netdevice() already does two ops sanity checks and is about to
> get a third. Collect them in netdev_check_ops().
> 
> The call stays after ndo_init() because drivers set features from there.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: move the netdev_ops checks into a helper
    https://git.kernel.org/netdev/net-next/c/57f66330c6bb
  - [net-next,v2,2/3] net: reject ops-locked drivers without ndo_set_rx_mode_async
    https://git.kernel.org/netdev/net-next/c/05fe748456ea
  - [net-next,v2,3/3] net: reject a netdev that implements only one hwtstamp NDO
    https://git.kernel.org/netdev/net-next/c/810a662abcd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


