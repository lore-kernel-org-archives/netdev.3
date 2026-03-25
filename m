Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E28284672;
	Wed, 25 Mar 2026 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411218; cv=none; b=IfoBigWRxdg26DCDGHOtx5MpPzbRmKmCLBsGfdhIWE/rkBHH9r/WvjmP+FJXUPxFK2nACxQz44dyhjFHV7SWOp23yhc7jSPRD0C+8Rl+oaqd3AgMH9VyK8I+JslJB5lFW+kORyFSPdjnq1QyL47MPLVOQGnY1acTgxheyIVBbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411218; c=relaxed/simple;
	bh=y7doqZTIe+tirsAelIkVCicIvRqFu6O6DeNHII+CVIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O6CrqseRY9Vo+flWK+4w7IGq9arv3tpAJpag3G/O59dytMG7M5GsLPkKQxuedDlpoCzhtIAuqQ6651c6P7WhUZJIz1tmuOfPRJXUWEFILKj77vEvb8CMuVYfprpp7M6t6s7sFiKPernNG1yWPLjcYAsnx4FlH79QjgQu9JHz8oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqfSIuso; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqfSIuso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03109C4CEF7;
	Wed, 25 Mar 2026 04:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774411218;
	bh=y7doqZTIe+tirsAelIkVCicIvRqFu6O6DeNHII+CVIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pqfSIusoxY0CeOXt3lkgZ3Ug6xcNEt05Ko2YS0tD11jzH6MIh4GaMd//MjsTGLm3T
	 EJVzf/JdhX7mi8Yr91RC2Hdtx6I04Kp42Wuylji5XzCv0P7TUvvLm2n9XEksaTg6UD
	 YEC8HulEizKOwlPmFaNxg9H2jrqT4pRK88/ThlhjJ1Z2PMwJXxjw+GODM/BMaYS1kJ
	 79kg7dKizlJ3fnvkxuAyx86ZBiJv/HeBI2mTwU63mq7Qzs7MBlBEKn3I4fDuLWL2xb
	 c587Z98JW6/W6e+N8Xvi8IGqTrHP4a6QGFuWZ/EqSw7m6OuupRvi0gj6IasJjLUUQQ
	 n1OjKokNQx2+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F143808203;
	Wed, 25 Mar 2026 04:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: lan743x: fix duplex configuration in mac_link_up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177441120534.1418231.4565108469032926267.git-patchwork-notify@kernel.org>
Date: Wed, 25 Mar 2026 04:00:05 +0000
References: <20260323065345.144915-1-thangaraj.s@microchip.com>
In-Reply-To: <20260323065345.144915-1-thangaraj.s@microchip.com>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 Raju.Lakkaraju@microchip.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Mar 2026 12:23:45 +0530 you wrote:
> The driver does not explicitly configure the MAC duplex mode when
> bringing the link up. As a result, the MAC may retain a stale duplex
> setting from a previous link state, leading to duplex mismatches with
> the link partner and degraded network performance.
> 
> Update lan743x_phylink_mac_link_up() to set or clear the MAC_CR_DPX_
> bit according to the negotiated duplex mode.
> 
> [...]

Here is the summary with links:
  - [net] net: lan743x: fix duplex configuration in mac_link_up
    https://git.kernel.org/netdev/net/c/71399707876b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


