Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797D3EBF18;
	Thu,  1 Oct 2026 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847009; cv=none; b=p8nh0Mo/xEO36Liqd+VmVM4OdloqxqP4ZXtmVerg6PzXCPP3vBtHkO0Or+43zqlHvs++bO6xup3r5cJ2e2rq6t++3ZwDS2ENLpXx39BseDH6628qgAxfRj59epLQH10kWy/0LPl4H8R7jfpAcdFPCtiPs8YwOnBW//+OXdFudys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847009; c=relaxed/simple;
	bh=tKFmQz/0PIHFJJ3Fy23nm8bb/L6AaRvo4oQWJ+Syu8s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sv5oDp9FKZz2wHrRvwu1kzu6EFKuY4jSJf4OCb4J3ikRb4U9o1LtevEErlhA7I85221cah4MyEGCv6Vwjbl66N7/fGlMZUBM4/qn0Alr/zqVXFl++TsNlXvzQEJoYHJYg6PSE1wBB7E/PgvCYOeXvSdI/U7fqv3fx5EDuxvQJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beL2mUp3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beL2mUp3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828801F000FF;
	Thu,  1 Oct 2026 09:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790847007;
	bh=BASQsGTAf4/JG9/5xVbsFJZDHdyR3Pn4iHMnd9rEmIs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=beL2mUp3MEQ2SzIRzIxpVDe+gwf84TxZZF2/q4ZJhsXxRStFUo2sf00kxm14aW2fc
	 wCLoPiLmoFP5ul0zQ4PWi6YF9J8NJC2JAfCh+QxnMqlbCB4+eSReVi10xn7OKz/WyW
	 B00rKffEBAU0s2rSxqB94G6cYdsZsg8z2m/PUz/ttzrKerG2k9+aekBCUkzuddBDJq
	 HiL/lpfti1LjKXNPSE8vkvgBlThE+JMgpi/cZ4Z2G/MTET03dlKD7/bdoMHF8wmaNs
	 SeSOiDf/CT92Hj58gMn1aP46I16SVziqckkAaXAsZHIZvYpxuDaIYFThx9tyASoWY7
	 bud/bWcOg3fxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773E1380DBD7;
	Thu,  1 Oct 2026 09:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: axienet: allow instantiation without
 a
 device tree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179084700627.2358019.13742661894584329814.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 09:30:06 +0000
References: <20260928074256.462345-1-maimon.sagi@gmail.com>
In-Reply-To: <20260928074256.462345-1-maimon.sagi@gmail.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: netdev@vger.kernel.org, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 vadim.fedorenko@linux.dev, richardcochran@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 28 Sep 2026 10:42:54 +0300 you wrote:
> The ADVA TimeCard X2 is a PCIe timing card driven by ptp_ocp.  Its FPGA
> contains an AXI Ethernet MAC with an AXI DMA engine.  The plan discussed
> on netdev [1] is for ptp_ocp to register the MAC as a child platform
> device described by a software node, so that this driver runs it rather
> than a copy in ptp_ocp; Vadim Fedorenko agreed that a platform device is
> the way to go.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: axienet: use device_property and fwnode APIs for probe-time config
    https://git.kernel.org/netdev/net-next/c/f5185ec79dac
  - [net-next,v2,2/2] net: axienet: add a MODULE_ALIAS for platform instantiation
    https://git.kernel.org/netdev/net-next/c/418149559ef3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


