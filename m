Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D66E330668
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773363616; cv=none; b=AND+EWOxtb/QDORGCVvL14qLCYRI607053Vv4idjHoawnwXIbEEYbH9CNN42O9K20z8U7ZuxMQuqTeUP0mQMZjip61/vDL/IqmeV9QORYBOyvXSrWbKD/kzNlM7B6RkBNVg7Gb4RxZV8BctWuv/5bOB9OVFO1EjxBqzz+PH8+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773363616; c=relaxed/simple;
	bh=z3JJ7gBlwgrOn/pDcXuqti9DSNRLX34Yol5LOPP5Cts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kPDR83rJkgojZnBF4FHwUHFlBw8cDvBDTtbYdZ1VCXsec9emrsjZs09bj+BIToPvKpPxkQd4Ft2IaLIVL/1GlBbwB4dVl+rD8k0jXJs6GrcJhaYNK8vPFSySW/sLS7CUaAd4zscH9mXrsHgRqI8Utt2p2T9D8Leww8nfHbnhTgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN2Tbgm7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN2Tbgm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153C2C4CEF7;
	Fri, 13 Mar 2026 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773363616;
	bh=z3JJ7gBlwgrOn/pDcXuqti9DSNRLX34Yol5LOPP5Cts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nN2Tbgm7gsrFLGtAs4LTAEnwhII6r1I5dAee0FlBMYWtrHwgtqRumGnT6Q5qkCzTZ
	 VuUfAEzfy8sLhsVpfkUtpTuAwxBeQZhuaYyRUoCrzlK7f+BEbnoX+2Y5gyKTzoeUd/
	 VCFhOpeHoYIXByiAdY88WW0S1TOKGhXUe79OhFdHwCrzvP4kXeJcAnE8KSzTD+Zv/B
	 C9qm3bla4Iil75a04VK3n39bH9G8V3v9F8I/Y1oB4wNwB9DivgiXDyB3JCe4kB39By
	 9C6LCCYflEg/14j/M9Ly5QS3z3nv1QlBILjVLT61Cx047w2Be3LkSealW5pRlNLQLN
	 NwE9SPLcWfKoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDB93808200;
	Fri, 13 Mar 2026 01:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: vitesse: add inband caps and
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177336361104.619871.8288889004999699479.git-patchwork-notify@kernel.org>
Date: Fri, 13 Mar 2026 01:00:11 +0000
References: <E1w082O-0000000ChNc-1wDz@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1w082O-0000000ChNc-1wDz@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, conor@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 01:07:00 +0000 you wrote:
> Add support for VSC8662 reporting its inband capabilities, and also
> hook to configure the PHY's inband mode.
> 
> This fixes a regression in the macb driver caused by commit
> 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")
> 
> Reported-by: Conor Dooley <conor@kernel.org>
> Link: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81a2ba1@spud
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: vitesse: add inband caps and configuration
    https://git.kernel.org/netdev/net-next/c/6e263aadbaf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


