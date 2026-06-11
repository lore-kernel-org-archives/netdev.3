Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06138E8CC
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169013; cv=none; b=JYifO/h/X4zKgllqVcJfyczNP58Z+SpludIidmi/ueVhsyojQcw+TE0vPMoNQxMF/K17Qv2B2WMkg9rRMkLRgT1dW+d1WN4PrDe+RO0nW+Ygdl7Ha782j9a+03xT/JEy38TnGZdDbwAJakqS5F2ci/haPOmM8Sf4gC0YynRz+8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169013; c=relaxed/simple;
	bh=FKp2R7xEjxfeilDtdneSFcF1hwesXQL4dDnnST/uJmo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M9y5RThblrrzCVw4HIn4zUfe63IHNmfX2tTYR23Zye+qeblu/4mylcA2IVsgi2GEwnL/SD/86rkBh6haqPSyvcX81OTGdciN8+bmfUzFLkdZ/ble4+itEbMpOopM4fOJBqGRT3/s3xfa4cS8VsdB5HMxoT07qD+KatxvAEGwDeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAncWElG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAncWElG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC2D1F00898;
	Thu, 11 Jun 2026 09:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781169012;
	bh=qE7FzmRRVvm60PE/alXPVW7Lx3wWBn/D6KTestFWJlw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bAncWElGHHyb2XSqgTGKHAmHRMRMYcZtMjHxcuAXDdpVTBbhoivTnLsHBse+IfU2A
	 odVMQyiHuP8CpsXesqaW7s3TFlATBh33TkNI+UR4lPC1sBtO5pJcIbekJGTp5bfPHX
	 w1ZbATlCOOwGC/sEL6GBGTmW3eJlavpSCkFztVE3ZKh389m2VIptRBc5TJtntv+bpz
	 nzi4L6inIXQiw5qpBp92F0weqBRTQhlrRgfM2Hw0s0GuavtGgL0snWVyOmAwq3yOaf
	 tE+TUrQdu/AXBm1jWVZuah4oKzGgPEJnoK4TGy/71gul/AQQ4SLjXG4binafwaLTcj
	 b0+FYuS0/xcvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567D53930E2D;
	Thu, 11 Jun 2026 09:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] net: txgbe: fix module identification
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178116901014.3848526.5054934386911041430.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 09:10:10 +0000
References: <20260608070842.36504-1-jiawenwu@trustnetic.com>
In-Reply-To: <20260608070842.36504-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, larysa.zaremba@intel.com, fabio.baltieri@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  8 Jun 2026 15:08:39 +0800 you wrote:
> For AML devices, there are some issues where the wrong module
> indentified then configure PHY failed.
> 
> The module info buffers should be initialized to 0 before the firmware
> returns information. And DECLARE_PHY_INTERFACE_MASK() does not guarantee
> zeroed contents, so explicitly clear the temporary interface masks before
> setting supported interfaces.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] net: txgbe: initialize module info buffer
    https://git.kernel.org/netdev/net/c/0487cfca4651
  - [net,v3,2/3] net: txgbe: distinguish module types by checking identifier
    https://git.kernel.org/netdev/net/c/f2df54ddbfb0
  - [net,v3,3/3] net: txgbe: initialize PHY interface to 0
    https://git.kernel.org/netdev/net/c/47f848aac4e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


