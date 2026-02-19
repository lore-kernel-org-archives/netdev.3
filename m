Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631F2C1586;
	Thu, 19 Feb 2026 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520417; cv=none; b=H9IL6y/HEkAF4GH6oNADtS6uhIx5pRN4sPhSwW7gwcMUOziaiETKWRX+Brd7Js/KmOdhVaa/BpyrZpldm9KGwuGx0HyozKe4EEtsHkP/ykmBB1kEoWbNW/qKDaXWoZAzdk0sMvv71nNVVTvYhpTBxdSBW1nuXZe8DQa/3MzZVdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520417; c=relaxed/simple;
	bh=XvPDoDY1pPUq2k4fN+DFMpOuKnftkoMNinTaw9sQDoI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BKpCmVhb0hNSjrmY5ygI0L1/2KcR0HzknuW0RVgbzEBljbc29kKqLxH6gqSd/ZXp2PtrHE5mnPuxS18x7+qnE8n3E4uPyyuHnmn7tVzoe0PYIqelwPuxBbPdPLgIH8ViQ4eVdljd8xwqsr7qnVR9IOPIUAHB3mqlR/CYe43j0po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJUbPMiB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJUbPMiB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739D3C4CEF7;
	Thu, 19 Feb 2026 17:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771520417;
	bh=XvPDoDY1pPUq2k4fN+DFMpOuKnftkoMNinTaw9sQDoI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eJUbPMiB2E1T9Lhc+4dT+CcezwLr274I7dc4UGbegfiNEmILiv46YJAHjjtqMHufk
	 RLEKmy+FSRhTdTCpgjO76/RRqjJDhWD/fHpyPq4irNa+j6ZBS0U6MbWX3cgT7eGj2c
	 E1MpAeqMvxygCgTDyNRRk49QVVvMh13YfnKrc6mOt/ixWj6HTY0igOCPAp2NHBzLvf
	 CxR9/oF8dzPWaTsiUVSURSBL6iSwsgLYwEACVxtQiNwchCl4eFHb2v4U3LpHPAJ01f
	 HK+i9nt9v6puKDD5gjJkiUijyfocBRZJONcmqoEbLpKryUmjSN0n/WxK54RxMqBzog
	 0Yt548Q6n521Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8527C380CEF3;
	Thu, 19 Feb 2026 17:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2 0/2] devlink: support default flag attr
 for param-get and param-set commands
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177152040832.2301686.9442715552350209457.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 17:00:08 +0000
References: <20260206-param-defaults-v2-0-1ce78e2c5a31@gmail.com>
In-Reply-To: <20260206-param-defaults-v2-0-1ce78e2c5a31@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, donald.hunter@gmail.com, dsahern@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Fri, 06 Feb 2026 13:11:28 -0800 you wrote:
> Add cli support for default param values introduced in the
> accompanying kernel series [1]. Here is some sample usage:
> 
> [1]: https://lore.kernel.org/netdev/20251119025038.651131-1-daniel.zahka@gmail.com/
> 
>  # dump params with defaults
> ./devlink dev param show pci/0000:01:00.0
> pci/0000:01:00.0:
>   name max_macs type generic
>     values:
>       cmode driverinit value 128 default 128
> ...
>   name swp_l4_csum_mode type driver-specific
>     values:
>       cmode permanent value default default default
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2,1/2] devlink: Pull the value printing logic out of pr_out_param_value()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=bbe2c8b3229d
  - [iproute2-next,v2,2/2] devlink: support displaying and resetting to default params
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=446dd2c18952

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


