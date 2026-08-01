Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F147A35675A;
	Sat,  1 Aug 2026 00:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785543649; cv=none; b=nLezccpz0Qj/1xqotSd02eS0iHfb/brNJXKD/Fm3cloGrVP9syrYjM9LmKvEKnR1dLa7JPBiXucLIlhcGe/5yIhUORG3ejpXEmwwBeW6FoEhzy/UpzSCMBvD4zDFET9OtHdcdl8URT1Ei7KixZt70sqnMQYb4yc9E8wIk8SZFKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785543649; c=relaxed/simple;
	bh=BqDHKHTjz2UKhwAUckq71JqFKFvVPoi9D6qCsu4APa4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nAu+4EgWUhl5e5JF02PpMx1M35i2FwKtkBZnHfTXKPDwi8o4r+yXQ1JjclsOSRZTvGamUxlSfA85rQ0b2wRR+hPvzr+Py+if7JBLKKmSzRxbuSODFl2brFdvhhb7bE9MKIWifOQ4C3hkrM6J2+zD63B6K3PGudazC2Sdcs1XkfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsnNtoHv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsnNtoHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4391F00AC4;
	Sat,  1 Aug 2026 00:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785543647;
	bh=g3ZwdouqsnnhIvmiZwaNVhbGzBiglzEtEgaYhSqekNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lsnNtoHv0obVWLZ+YweVkWsNBL63Nir/JE98uix1PcvgVfLQt8kaHywKPul8fHldz
	 h51b0yd6Kix1oKSajzn5hTTmespb7Dvl3wnespaoVOQ7wJ7aDM2iVLbdiiFQ+yHZMn
	 D0wMuFSiJZpjpKXWwe4f+AfN0ln0jiwvqGxI1MWiDEzXv/Q7jKp3n8WQpNCxjmrIxY
	 Io/PMM9hBrpBYiAF2C7b8plk/P2N6HprX++3ohvGAE27KDugMyTYQoO2qBJNiCPqHs
	 ZgsE36s0Eh/J3Fl0EM7G7ysm8V4VzZ7ZIy2aU6uvGUVRNDwKNB6sV/+jS++dCLNkMX
	 34eRNv+647xLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56891392665D;
	Sat,  1 Aug 2026 00:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: dwxgmac2: configure INTM for
 per-channel interrupt routing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178554360988.959828.9142533311470597917.git-patchwork-notify@kernel.org>
Date: Sat, 01 Aug 2026 00:20:09 +0000
References: <20260729023653.1162763-1-zxyan0222@gmail.com>
In-Reply-To: <20260729023653.1162763-1-zxyan0222@gmail.com>
To: Zxyan Zhu <zxyan0222@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jul 2026 10:36:53 +0800 you wrote:
> The XGMAC DMA_MODE register has an INTM field (bits 13:12) that
> controls interrupt routing behavior for DMA transfer completion
> events:
> 
>   00 (default): sbd_perch_* are pulse signals, sbd_intr_o is also
>                 asserted for each completion event.
>   01:          sbd_perch_* are level signals, sbd_intr_o is NOT
>                 asserted for packet transfer completion events.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: dwxgmac2: configure INTM for per-channel interrupt routing
    https://git.kernel.org/netdev/net-next/c/4d3839943bbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


