Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D48A253B42
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766634; cv=none; b=IKVSxpd6iWj2IjaS83EHDxOV1dfSgMDHOgCqoN3RP2UDL9pYURPMeFYav11jQ5aLtuaW9FruzR0SSo1zLdU3U2xredD4ynBZEbudKIA4mbQd60RJsGLPXdq75vaqcSlnahLiY6iduWDxf32Sw1HxhMEu/34E9+QjyaAXuDw4J9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766634; c=relaxed/simple;
	bh=MgQXU3NvInopRALJi49ArFGtD0M3nYYpIfEqjLN2j7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m4zpUGH8qZbDeicxaYaNpUZPcD6hpkg9SxibR5rGK8YDz1/AB2DV5CXyIRPFU+lcIF3vaHEH39PcYyadHM1C2OoY3M69gXMnt8XnlDJgIm30Xn8PR7kiV7k1MltZgWiqwUUFISeqSr4ale6+qzzEfjRkzEIW1BrlaAGCqqWiA6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOMRCFJb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOMRCFJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C84C4CEF7;
	Thu,  9 Apr 2026 20:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775766634;
	bh=MgQXU3NvInopRALJi49ArFGtD0M3nYYpIfEqjLN2j7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UOMRCFJbnoMC6XKE6c7MUnuZB28St/32S3gvwR/XyAG5VQM6uDq7B6cyCo3iGRl1l
	 BKNzFnK2PYnefFeCkTxF8FZ6tuf+CcRcRD9yWLmw+EZy8ddlTxNvLdr1kpACVr1rTj
	 im5a+fudT2a5pA7zDOckL6kIhK5DgbaCcs+kHeK+3bEYtsQELoPvHHlxqCfKQ+4UH+
	 qMZnTRC6hlQEhIQ4Rwhd4FiF9O8Z+AHqalnydFsJmGFvvm4mKPIUo0rdJc1GLyu/pY
	 HcdJyI+sfhz87W0RzX1NbO0HFXVBCXsn8XCiWpPCboInUONaJzFqxSyjqE1iSll3yH
	 z6IMTik1MZD/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E7F39308B7;
	Thu,  9 Apr 2026 20:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Remove Salil Mehta as HiSilicon HNS3/HNS
 Ethernet maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177576660929.1728013.14788015779792020178.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 20:30:09 +0000
References: <20260409000430.7217-1-salil.mehta@huawei.com>
In-Reply-To: <20260409000430.7217-1-salil.mehta@huawei.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
 salil.mehta@opnsrc.net, shenjian15@huawei.com, shaojijie@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 Apr 2026 01:04:30 +0100 you wrote:
> From: Salil Mehta <salil.mehta@opnsrc.net>
> 
> Closing this chapter and a long wonderful journey with my team, I sign off one
> last time with my Huawei email address. Remove my maintainer entry for the
> HiSilicon HNS and HNS3 10G/100G Ethernet drivers, and add a CREDITS entry for
> my co-authorship and maintenance contributions to these drivers.
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Remove Salil Mehta as HiSilicon HNS3/HNS Ethernet maintainer
    https://git.kernel.org/netdev/net/c/eb216e422044

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


