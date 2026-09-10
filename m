Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AEA35F182
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007469; cv=none; b=mcgSsa1Kj9QSAqUbMrmI+aEtDb/nrjYz6etZMC/FDolVQIeF1AMM5HZEzmsH5F9lxatmkgthPBCq3H26HiQfGIbOBtXkHueC5MN4WrYs3fvptHlzI33Y7tchw1yda9+UVe3O9SWcpg5UVKmzW2KN1UqaEN+mCwnD0FWAl6Oj00k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007469; c=relaxed/simple;
	bh=GPSewceStH/QUsrjES8VWPcJ8EiCPuSl4N1K+MP+Vu4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jsBfBz2kPa2wVQgJtNidMzteu77XSllabbev3jlqKiK66Ah+qBWnm441B8fprCduM2mzSt0ULVGvJtoITSIBVQXRtv3MG8e9cBzLhcur6N9eZm/CYAHooluN2tMZxSreyairMYW7jvog7Uo9QXOg9XHe1xwggl51Y/39FhjauTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C28JvL1H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C28JvL1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43871F000FF;
	Thu, 10 Sep 2026 02:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789007466;
	bh=mx6UGT3LIpnPAYN185YxCNFaJMqNkLiz8yLgGMh8ifo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=C28JvL1HLKvUb4uqaRKfCWYegoGE3ScjbNlK+WEdzvZ+/Dc3yBsTwZhtogX0LqHu/
	 63s+3GlX0wvjmgSoib69EbcPv86/wGYAr8k/bwXeb0HghHidF6VWeOMRB7NddmAFvK
	 Gg164kk0fIcqYksPLUz8CAepaewaoCwbQUOMv/03hilmJtlWdoNzigru0e6x3LbJ2A
	 6mQG0OUMEElReJiUpgX+BYU4reQL+CR2Zg49ZHonIwsNgCV4Oxvvdth79oJWDzAUi+
	 8/d2EE62tJxqKYiU7PgfDHpS2yXsy/U9rgm/hJo9msjf2hz6pE2hJ1PMhctcVXYeie
	 //9nvbRHwdEgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C3A380CEC7;
	Thu, 10 Sep 2026 02:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: initialize ptp_lock at probe time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900740464.1158570.11551563086535432629.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 02:30:04 +0000
References: 
 <20260904-stmmac-fix-ptp-clock-init-v1-1-df70eb1eb04d@oss.qualcomm.com>
In-Reply-To: 
 <20260904-stmmac-fix-ptp-clock-init-v1-1-df70eb1eb04d@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 04 Sep 2026 12:32:55 +0200 you wrote:
> priv->ptp_lock is only initialized in stmmac_ptp_register(), which runs
> during __stmmac_open(). However, the lock is also used while the
> interface is down and has never been opened: tc_taprio_configure()
> invokes the PTP gettime64() callback to compute the EST base time when
> offloading a TAPRIO schedule, and stmmac_get_time() takes
> priv->ptp_lock. Using an uninitialized rwlock is undefined behaviour.
> Move the rwlock_init() to __stmmac_dvr_probe(), together with the other
> private locks, so that ptp_lock is always valid regardless of the
> interface state.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: initialize ptp_lock at probe time
    https://git.kernel.org/netdev/net/c/0338c68e22ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


