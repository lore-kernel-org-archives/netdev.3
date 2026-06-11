Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94D63CDBC0
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217034; cv=none; b=ahniGLwQ4O87kq7XDNqsU0MuJqB36rt6pkyBeby9+grmsel9WI2J6C6bA9j1PIeGcM3hKLjb0VJyz1xqffXXT8HcQxK8KzoplEVE9BHg7DMMS2gycZ35/Esy7VPtVv07pfli9tzjH0IuHOHAXRtEzcXu0QNR9Ga52s0dAhFtLkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217034; c=relaxed/simple;
	bh=jBqoSpW7+0NhvOMqR/GomQMJswaD59B4Vt5XhZoNHDE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EwLrY4l8jZyTLBzsvhMD0ZT4Ccdqiyg7e5n5TvHOYCgux1yOOGXDPC4lgGWRZQn0Mli4tPzvAg/sK73DflxkQQbGvSi/dJFPKvsyKQzNtMQpGOyXhApGx5K9lzMsuRVm2q5rcjBEsQqZh67M+MaXvfJZkqV0BTziJr6kQuX6aWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f95h+ajN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f95h+ajN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F911F000E9;
	Thu, 11 Jun 2026 22:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781217028;
	bh=4Wcf7phm+5zW58xmIIN/R67av8KlnEeqYbMlrcD2Tak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f95h+ajNjZNo3xEEyX/XOHSgtZiNH1s3cW8bi5v/dxt0yK41xMPvPqdphnnpp3GgZ
	 T+YfHUNKqpeXhX5DHKRw2BSUsTtW9Z5neIc2FD9A6YFfvl+c0EdcyHLKIbrIjoXvqt
	 1kdDdZDrCyJt+rtRjHOoTE1UaLZm9lVoFqcnNAPvrA/n646jwJLSOQBwovIxpnNrqQ
	 ykC0amak0VYg5ryWYNzOegXveEVd7HugQV7XThGM2o/vcrUR8yaZHx9a9yAuZrMkcE
	 giF+WVrDuNr3mqPSjfaJW8OGcRe/W3xntK3178+rSVCLq6hjdNAeMM646bykuVsfKI
	 OugrplI8toxRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569053930FAD;
	Thu, 11 Jun 2026 22:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: fec: remove reference to nonexistent
 CONFIG_GILBARCONAP
 option
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121702588.389578.15203265198914114198.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:30:25 +0000
References: <20260609045200.32606-1-enelsonmoore@gmail.com>
In-Reply-To: <20260609045200.32606-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, wei.fang@nxp.com, frank.li@nxp.com,
 shenwei.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 21:52:00 -0700 you wrote:
> The CONFIG_GILBARCONAP option has never been defined by the kernel, but
> is referred to by drivers/net/ethernet/freescale/fec_main.c. Remove this
> reference to eliminate dead code.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
> 
> [...]

Here is the summary with links:
  - net: fec: remove reference to nonexistent CONFIG_GILBARCONAP option
    https://git.kernel.org/netdev/net-next/c/f8142f5578b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


