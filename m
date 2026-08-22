Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916F2BE7AB;
	Sat, 22 Aug 2026 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428877; cv=none; b=dvx2prhGpq87bEyQB+mUIQ2GpXOCNZ+wWvMjsXhAt9N4ZdtZ7JPSNVg9DKHN+Kkpl60Vm5UaqrbbCPXpLm7doC4gw3YRN1phxlhfLyksqfFluGKSkCIwrYzRmKUXHjOJlmv+cai4wOAgaAU9K8CPBGdFqpugde8PtkbfaPLa4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428877; c=relaxed/simple;
	bh=S2jwfBr5iP6+eSGEwrj8cJzmzDBCNA4Cqy4vMGn1ukk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=slftQE4pxLGQUGRYHUJ4VNJ4GPpEZgk4NWxFrnBgOMsbhLfINtJ0/jDBPLAETMJUQGLokrBubAtRCuXS9kaWjDRNz9x3YvVGNcI4hi66CAU8z1WD1y4jRjcnAJZx/76iDTFQ9CEE6T9qwuRnPWrckAF3mIgiVRd+gVwoDApbVAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ct2tinfk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct2tinfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509501F00A3A;
	Sat, 22 Aug 2026 20:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787428874;
	bh=Jx8mm8pDub3gkd5EkdOP68KBoJTxso8FPjKZkASyM1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ct2tinfkxmmCl9LqowHjsq08Lrd+7jRueZahErNpehJhrHyjhUBWg6x+LKAbz61Jb
	 wFtHngDkrTHGIgKKfZPti6J6KNHPa7CqG8ZS+hfIEuWsnhY6dMmtBbA1N7FxlEPtLY
	 x1YhnlgamNhyt9AjflVmldMe+7oYrwrr9NDUjFf22mZANZC/BLqRJ62q50YzkkMU+6
	 D3UvsTZ+qqqS9V5IBrVjK0zCiv4MD7byUZwwUt1f1vTQ8730KPRFNnmbxcFy3gPL6w
	 sH4l/g1qqcRK2idmqItKn7DRGsEUhEl78dVIhjId+QyCsmYK23hf1yU8uMmpJWPu/9
	 uE0IbMDtLNxFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A7C380CEF9;
	Sat, 22 Aug 2026 20:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ptp: netc: fix period truncation and potential
 divide-by-zero in PEROUT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178742882288.1812309.16792261693312598878.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:00:22 +0000
References: <20260821032449.1235065-1-wei.fang@oss.nxp.com>
In-Reply-To: <20260821032449.1235065-1-wei.fang@oss.nxp.com>
To: Wei Fang (OSS) <wei.fang@oss.nxp.com>
Cc: xiaoning.wang@nxp.com, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Frank.Li@nxp.com, horms@kernel.org, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Aug 2026 11:24:49 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The max_period bound in net_timer_enable_perout() was computed as:
> 
>   max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
> 
> which exceeds U32_MAX when integral_period > 0 (e.g. 0x100000002 for
> the default 333333333 Hz clock). A period_ns that passes this check but
> exceeds U32_MAX is then silently truncated when stored into the u32
> struct netc_pp::period field.
> 
> [...]

Here is the summary with links:
  - [v2,net] ptp: netc: fix period truncation and potential divide-by-zero in PEROUT
    https://git.kernel.org/netdev/net/c/777dbc9914b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


