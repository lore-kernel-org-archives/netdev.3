Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BA73002A0
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144431; cv=none; b=bxy1FjcuYqa7zGdtiXbQ+qE51VKH/EdTHPpb1ysIsnBOamTzw8I7MnDQUHp87lUDmYYCkAh6oplxeW9vvtBM9HP06SVYLYqYDnactXfe9EX09B71XsBtzcOZScxbZTj/XxNexjFpCR6N+IJ71qbjkFJRvVdyzJrZUb5J2Kbp9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144431; c=relaxed/simple;
	bh=Oug5ivCVBn4PmdMOx6RZF32twK4qEyJI4QZkd2FuICA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jPKjbQd6cqs2YYniu2KJlbWt/C3ll35CUFcTvVbetM1pp9RL8ZNrhfAbFfYDMFVWsrPTnFgkqJ2zD6CLlqSGHa60pg9uxtPwA6vwCjcYv4An+K09lHSZHR9s19gRXrr6O8cmPg9+gxK/AmXALBIlKOGTSmJyOamJkVhkZerl14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEDIAWH/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEDIAWH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D29BC19424;
	Thu,  2 Apr 2026 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775144431;
	bh=Oug5ivCVBn4PmdMOx6RZF32twK4qEyJI4QZkd2FuICA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PEDIAWH/9pkW3KCjf+TkCV/WvhEwRX9TQAnprIuP58SIrKMA+MWM1jg58n2+H/9Ee
	 Wg1cxYSgDQDVONeezbpyE4e/6QHunNpo9BEHurk39WX2cVF0KfIFcna+7Cl6TqKFtn
	 Xwc3Jhm3Du8b9Lc0Y7jfyDV2on9nVprzyY/IkygtKEHuQbR62A4WNbaTfWGyVdbnxl
	 32z9/vEIuiozOtiNnwRlzOA2zySkRYKHD12fBndL/75DVgwyQoqLJmBtYawdFzvJpQ
	 vh1DFY+EtsGG64vAEFAS2XU8BSiNUa0VtG8DxpE2DbrtP4/dOBJTvoXo16UVBwPovP
	 5Z3HA1ZnoHe1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D7D3809A05;
	Thu,  2 Apr 2026 15:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: avoid overflows in ip6_datagram_send_ctl()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177514441328.499423.7535697117190470967.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 15:40:13 +0000
References: <20260401154721.3740056-1-edumazet@google.com>
In-Reply-To: <20260401154721.3740056-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 yimingqian591@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Apr 2026 15:47:21 +0000 you wrote:
> Yiming Qian reported :
> <quote>
>  I believe I found a locally triggerable kernel bug in the IPv6 sendmsg
>  ancillary-data path that can panic the kernel via `skb_under_panic()`
>  (local DoS).
> 
>  The core issue is a mismatch between:
> 
> [...]

Here is the summary with links:
  - [net] ipv6: avoid overflows in ip6_datagram_send_ctl()
    https://git.kernel.org/netdev/net/c/4e453375561f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


