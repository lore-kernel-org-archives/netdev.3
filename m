Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BCB32E68D;
	Wed, 30 Sep 2026 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731214; cv=none; b=MHEzvbz+Eg4z2hJoUX5dquoSarPqRNh5zTEs9ESEUSs+yCqbeJdTM11suEWWG5YVHdo4ZJwN2mKtxmyQU7ZFT8LofboBb+xbMz8GsEZCVJNgVgXDOcRbNHkMGzuS5HoIHuSwfMAU27wp9Kjpory6nT86kl6YsFo4xrUiKdFE39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731214; c=relaxed/simple;
	bh=zoW64vxMeb/Lb5apKSU/imQicVcCqEsTmMb87Ss3pEU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P9rkYg4uiJ+39SJPg+6x1n8mFa7b5aMw31tuCDjYCQPeJQE3IBmMc1xuyBwEPGF4oKoECYRMvERAdKBqbRQ1Fzh8Oc1QVjDgSjLkFpt6enjz6EHS7pX/16WmcgtjXiLx4YgveB6MEluuXFc16H+zoO5ZPhAWvKeMq1CCa8pZVEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVenMHhA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVenMHhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4506C1F00898;
	Wed, 30 Sep 2026 01:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790731211;
	bh=c4qXAkRkFH2BrM9ich78uiUxUASD+HAZoTxvNl/Jrfc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BVenMHhArH7UpyU20V/MTkqiwpKUFqX+i+XhopAQ4wV2P4rGs/kRBdEVxKS3jqTSG
	 CA7UllMHePCu315J7TyWlZQBSmZVEH/8PXkHoRcc9kBl50LUfOOzw/pHqEOhmU+ud7
	 mR3KRV1gv3g2z7EUyelGboizxilEW4h21d2tCQq3PciUqw8LbrE5ofR2n4M0ejQeL3
	 RN1nyh5xlGKMx+OFNxdLt70QdG2JFwv4LvIk1AXzGHrnOkLJM7ohk6D7MuWC/aJt/U
	 lm4WjaOcLqiRGlc6u64tdZ5jEfHccvm8deVwO6tevwvMs8mpg//TwBPZB6+ASGT2Eb
	 +tqsjkYUJcvQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4C43924FEA;
	Wed, 30 Sep 2026 01:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: enetc: document enetc_msg_vsi_send() return values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179073120977.1194536.6526680014561695847.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 01:20:09 +0000
References: 
 <09f24cefc214455305543a0528ceae6349c77419.1790357822.git.error27@gmail.com>
In-Reply-To: 
 <09f24cefc214455305543a0528ceae6349c77419.1790357822.git.error27@gmail.com>
To: Dan Carpenter <error27@gmail.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Sep 2026 14:56:13 +0300 you wrote:
> Smatch combines the return values together and wants all the callers
> to handle the positive values so it leads to static checker warnings.
> Add a comment explaining the return values.
> 
> Generally functions which return non-standard values should have a
> comment.
> 
> [...]

Here is the summary with links:
  - net: enetc: document enetc_msg_vsi_send() return values
    https://git.kernel.org/netdev/net-next/c/549f5f48f10e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


