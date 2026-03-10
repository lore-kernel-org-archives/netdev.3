Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592536F40E;
	Tue, 10 Mar 2026 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138008; cv=none; b=jajMPm60QldxSfeHtwEajMIxvFo2UelbPdTCDLtig97fZ3yx5weS4y4R9CzYuPuspRP1QK/MHgitcyo1UVQvbj5J1TMRVTKO4VguKiVy+2wmh4rU2dw3rzUPId10AF29lmwpRfELZsOkPCfhTeGbQxegi7OG7Fy9Z0Flgzg31so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138008; c=relaxed/simple;
	bh=Xe9iHX6Mp7PCX/SxX0mgI89tjGBWacXwdFtF/Mh1FTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZISSqiRq430JgbCXQUqnUgwOVqSe/pLryKpZSuFPABtCYFfxDZauvsHPTTgF5FRJysCyZvv7VI+HdSJRvsIn+s5XPuN1QmXPT29FKxFZOL9F0C1Gytc7gNZmAAo3mpFz3DngHZ3h1kk39fPL9A3atlF2+IafieJCcS6dVsA6jeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKHOp9Bz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKHOp9Bz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A119C2BC86;
	Tue, 10 Mar 2026 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773138008;
	bh=Xe9iHX6Mp7PCX/SxX0mgI89tjGBWacXwdFtF/Mh1FTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bKHOp9Bz/9MKzdFrWtH2imUmhtCnFqunp4z2kvy2akBw8Xl9vcGAeKPmloj9UFfzX
	 mZL2FghAFuH1ef2hlcdJEMY6zsE05m1Nv3UBr/4klGI2mDnNE2HGhh/EHWrWIzgt4S
	 pYT2Eo8z4qrdzTyLWxkxi+lUMlCDeiVH1w+Sm7RiahHid7+bcPMnz3e/AMxTk6mWSl
	 bqoCk1Z63QxsQXhe93BPVJrVJSsUpqVFnpsWg+A8GIFOZuN9cz0Gg3wxorUbvdHmMH
	 QA9wuQCx6GyLmCdYSxTf8go9y+FPLCbzwJKwC3Ng57HEEl5oFGh56Q1Wd9xewvLkyp
	 jSZ8L0rmzEgwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE7B3808200;
	Tue, 10 Mar 2026 10:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] mctp: i2c: fix skb memory leak in receive path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177313800505.2175853.17456675187460391225.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 10:20:05 +0000
References: <20260305143240.97592-1-haiyuewa@163.com>
In-Reply-To: <20260305143240.97592-1-haiyuewa@163.com>
To: Haiyue Wang <haiyuewa@163.com>
Cc: netdev@vger.kernel.org, jk@codeconstruct.com.au,
 matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, wsa@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  5 Mar 2026 22:32:34 +0800 you wrote:
> When 'midev->allow_rx' is false, the newly allocated skb isn't consumed
> by netif_rx(), it needs to free the skb directly.
> 
> Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
> Signed-off-by: Haiyue Wang <haiyuewa@163.com>
> ---
>  drivers/net/mctp/mctp-i2c.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net,v1] mctp: i2c: fix skb memory leak in receive path
    https://git.kernel.org/netdev/net/c/e3f5e0f22cfc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


