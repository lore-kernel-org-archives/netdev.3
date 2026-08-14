Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF883E0C46;
	Fri, 14 Aug 2026 03:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677914; cv=none; b=qa6foSwLyqyHBIQ4cweuNgQNNMn8YQFsSuttpxjTh6EbEa0mfCM9LYVRwXas1iyKDRUtGPsSiHt8ImVTe7XBOQ4OFek6uQkchUEv0DqZSGx7s0T87/A02vTVfF7bRfXLEK4tS1UULsuXtZPVgIK7maeeAjnMsapyYkW/M6J0rDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677914; c=relaxed/simple;
	bh=GEw/PoDsteqcbZcGrJgJ4NYmmTMIn4SnpwJ7OD8blvM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UnX0oSH90gK1pDkGyIot/KXAKvySPjdPeEBX4buG+RFlyUG49EX3rsW10p5pHca/CqsC63RO/LyDUPURZ5FRyy6/HAbb/3HsmPHpkkqrRyy7hLbrrQa0p8IdRdEMEwzj9tUvNG65SZA02sfdz3HDfnIUAWwPcQFKE1EjqRxVoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/+GARXh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/+GARXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27F41F000E9;
	Fri, 14 Aug 2026 03:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786677912;
	bh=hM7kQ6JSwJkf/05LPbTQW7P+yRLW4HUM/dM4/7ueJXc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f/+GARXhswKCEIeqV6/6W6nBUzUy/Fj2LKIezF9ptZWNV4ZsivIrh/UpXUYVhODnl
	 +nR7L58BoCKlzzZNMo4okZw6XeR2JkmNQ5HLqDpTtzNUjsWx4NDPcSPSekfUdRIuRD
	 liNyK1vPxaRW2Sw7aMpMuMPa2bWXmOSVr+dGhLo3QntI47N22QcW8V1j1ktwSOEmm5
	 QalHPZL8yvgJSLbfrP32p2FN4jrRXUsAb69St5LST8VtikZB7jyBy1avKN4KnBAPhU
	 MgWEWcAOs8nWct1bieS2QoCEeOV8JA56SnKk8tgDFy9k+VGRR5ltp2mO/UtImd+1VW
	 nSe2OHRHwvaOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5689A3810900;
	Fri, 14 Aug 2026 03:24:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: phylink: treat PSGMII as an inband capable
 interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178667786689.3150297.13780382184308922141.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 03:24:26 +0000
References: <20260809-phylink-psgmii-v3-1-908dcd3a9e3d@gmail.com>
In-Reply-To: <20260809-phylink-psgmii-v3-1-908dcd3a9e3d@gmail.com>
To: Sandeep Sondagar <sandeepsondagar@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 j4g8y7@gmail.com, robert.marko@sartura.hr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 09 Aug 2026 21:31:41 +0530 you wrote:
> PSGMII (the Qualcomm 5-port SGMII) conveys the link negotiation result
> from the PHY back to the MAC through per-channel in-band SGMII words,
> exactly like SGMII and QSGMII.
> 
> However, PHY_INTERFACE_MODE_PSGMII is missing from
> phylink_get_inband_type(), so phylink reports INBAND_NONE for it and
> phylink_pcs_neg_mode() falls back to PHYLINK_PCS_NEG_NONE. The PCS is
> then programmed in force mode and its control-register speed bits (which
> default to 1000base) are used, so a slower copper link - e.g. 100base-T
> - is reported as 1Gbps and cannot pass traffic.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: phylink: treat PSGMII as an inband capable interface
    https://git.kernel.org/netdev/net-next/c/5ba017f9efef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


