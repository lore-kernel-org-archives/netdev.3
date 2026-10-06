Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0546F2DB7BF;
	Tue,  6 Oct 2026 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791248408; cv=none; b=WecrtXeNO+6uGaXdQtPkusx6csm2mlsD4IdIUBf6qweVSqMbGBeSfkG/yklgKHch74dVLR8Ee0rPV6LCIBtIjkf5zgjnsMD77XHzOg9D9n+H9al84PtMh9MlSf2fpj817uQMyheWZ3zrnDEEDWmSRICqDLa09hGr23kFMuEiXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791248408; c=relaxed/simple;
	bh=UtuMmVX64Qq5QsPhW3D0FZCOSvp6D2DUoklXO69R36Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nZgU0l9X+wa/PN53OW9EUWmVMeFBXWVStF/A5w8/dFokeJ1QyqPAirQpiiJahZHON+Xr+FQZbSVMaYPnihlnOYYRg7lH+ekdYo2dF2QedZD8NFs2/ZzcEz/US++/3hNl1BNGrUioNW7SYHiSxzAkviFUgTdIarjyEUBvIhhKg8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ4hZHtt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ4hZHtt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8417C1F000FF;
	Tue,  6 Oct 2026 01:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791248406;
	bh=fmSHdEOjLyNe+GHx6L6yhQrxZwZE1u9619dhybyCLx8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AZ4hZHttCyXm7ZE36P8yA6Hr+o+dgADV1/ZWhB8sAPBr2wTczj2cJ7F2hsNeAf5YX
	 RuvsdPE7lP9Uy+DxyR3JuC7kweFufqpJI7EcWnPm/hJdR2VDOsdke+IaUDeWyNC/e5
	 lhUdltCi4wZngBz1AcKPMNUniLR4V4bnOKhAS1BLdcV6UMJoZKxbzxG0zb+qnECT3Z
	 +1ErjRqIvmx1dHxd6s8X3EZheMZmOpUVIfSBgWbhX1y5saTR8ufp9rp/EUtEZ4eVdr
	 psM/lzeTKjgFU/aLhruA29ALhzTFwD15HNGDe1Vs25O6FijtYusrSZ/Oz/E3n/rhks
	 SiWbNHzhLinBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77382392667F;
	Tue,  6 Oct 2026 01:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] net: airoha: Add retry mechanism to
 airoha_qdma_set_trtcm_param()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124840530.1963510.8749215756359738246.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 01:00:05 +0000
References: <20260930065855.46171-1-ansuelsmth@gmail.com>
In-Reply-To: <20260930065855.46171-1-ansuelsmth@gmail.com>
To: Christian Marangi (Ansuel) <ansuelsmth@gmail.com>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Leto.Liu@airoha.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 08:58:48 +0200 you wrote:
> From: Leto Liu (刘涛) <Leto.Liu@airoha.com>
> 
> CPU accesses QDMA via the bus. When multiple modules are using the bus
> simultaneously, CPU access to QDMA may encounter bus timeouts and fails,
> resulting in QDMA configuration failures and potentially causing packet
> transmission issues. In order to mitigate the issue, introduce a retry
> mechanism to airoha_qdma_set_trtcm_param routine in order to ensure the
> configuration is correctly applied to the hardware.
> 
> [...]

Here is the summary with links:
  - [net,v6] net: airoha: Add retry mechanism to airoha_qdma_set_trtcm_param()
    https://git.kernel.org/netdev/net/c/7e170da2edec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


