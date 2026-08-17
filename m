Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615735C188;
	Mon, 17 Aug 2026 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996865; cv=none; b=parm9sNnV9n64A94CeFdWffmJeQNwZULSJuoAIdU0bi1LgdjqkBEv4iOiYD3jYlrBl964L2XeENu9pfGcCVj7s7G/N6q3+fDISuZJvUm7arylRuxVEVgZHW5u5p1luU4NJbz6w4F0ebeRq/tiLEFAoVOd1RNQcUqGrhZeUanRS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996865; c=relaxed/simple;
	bh=B7/K0cZaKP2A76iwO2WVx28fFXkEUtAhjsn0hYBZkgc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FvbGVkI/uTbqhn3481S6okOhweXDrVjxq3dcTNjziN45PUoJ9UE+3F/o6fxWgC7PSZ1s0NUQ8itL5pKXVAFlYEPs8ltJYZK3Zw2lssBizjCGPueSUzBxcytWeVOqwKE0YhvW8kSqxnigTIhfd5FZ5NAQ1e9kJCOd0Co3hPA5k4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4ZEjHhk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4ZEjHhk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FF71F00A3A;
	Mon, 17 Aug 2026 20:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786996864;
	bh=mY9IMExLPSNZ7VWT+QeQ2woonBHgeryalP0Xg13zfxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D4ZEjHhkuBcM4ckTDy85/Zmqx07rT+f+OnlS6CmG+NV003l+IMNyY2k+lFtM2ofaP
	 fIxmjCOaMCu+HHe/tQbXeODfFQGf8CxlMSfPGnxhLqt/ziDd152OYVzCQR0FZjSjXW
	 T3Py876UkZDFgcNkcPsl3Ikkm1fSiJqU+zydh6mKjii5U6qdr2PpRFrm5G2IEtCBtx
	 HptaqpwsCrVcBDuwLCJY/v9Vp12Fb+biG2AuLu0MvYvL/qWHTDkgEW/PkcJGnl3sQI
	 hRMyp4UG6M1xnVhGOVT/pvzQG+h1PoQH1nbfT3XiU8Cty/V5Wqreij0bbY5X2+7ije
	 wLLBig9ejPCww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9390F3926263;
	Mon, 17 Aug 2026 20:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ptp: netc: skip PEROUT disable if channel is not
 enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699681614.1714062.8810905823945131454.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 20:00:16 +0000
References: <20260811083614.3589967-1-wei.fang@oss.nxp.com>
In-Reply-To: <20260811083614.3589967-1-wei.fang@oss.nxp.com>
To: Wei Fang (OSS) <wei.fang@oss.nxp.com>
Cc: xiaoning.wang@nxp.com, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Frank.Li@nxp.com, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Aug 2026 16:36:14 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> When userspace calls ioctl(PTP_PEROUT_REQUEST) with period = 0 to disable
> a PEROUT channel that is not enabled, the driver incorrectly enters the
> disable path. Since the channel's struct netc_pp was previously zeroed,
> pp->alarm_id evaluates to 0, causing priv->fs_alarm_bitmap &= ~BIT(0) to
> silently revoke the alarm 0 allocation from whichever channel is actively
> using it. This can cause two channels conflict over the same hardware
> alarm configuration and corrupt their periodic output signals.
> 
> [...]

Here is the summary with links:
  - [net] ptp: netc: skip PEROUT disable if channel is not enabled
    https://git.kernel.org/netdev/net/c/273480bb836e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


