Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DDE2DECCC;
	Sat, 26 Sep 2026 00:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383285; cv=none; b=kcwmM3D0niEsCrq8RPDsoHCGPAvBbW0a3cfJ7C698jmIOcQq2r+9D1kb2Gfg1JrXh03vcPSl3+T0wXMj9KaYC6SQb07bvjRAFiwlV4VMEDUnuKyHHbG3sMLERcNl/f1/2RSN5lYOHWPyMr+US7IQVR1Nh36rtzYbmoH2Ict4yvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383285; c=relaxed/simple;
	bh=luLX/b7xMB1ThCBD849EoUxx/GQRxllPdY+5QN7jKlk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o7/nZHgA9MheVnM40+5yw/TIzqOpFlLjQvlSBSMF5lUplsOhViJNjhL2TqxAl0H079Kw+5hUKyh5hUHMTRLXlr74qapdNl6QLXpaTJ8fWO4vf8kN+nyScUcBE5Id+I0ToVD8AadlZHCDFzdTjQZ/QNn5s5lCriOTginj0oO93xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzNleLDK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzNleLDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FFD1F000FF;
	Sat, 26 Sep 2026 00:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790383283;
	bh=BZrmPDfMUXPri6T70hD/626L+PQhSoTxZmOWHeqlUvM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DzNleLDKG8/bS3iuuBcsIvJ1vmexwZc5lJyH2vwlMlZzyM+IaaMSMbL6ZivptfAMu
	 TPS+QdFGGXCTxQhvOrdPPx3HWCrD7YVPIg9s6xKBxrt8L6Hpr6F+mBGy67Gs/IZYQE
	 UbQ4iqqqADndcZNwTh314EnbIFluxwpdk5zKxBCfHXOcqxr5oYV4zKnTPr0A7MXSOP
	 9YgkjzdEFQ5DHl7A9GQTrqfbzjy7yec/GyM1rkG9s93oygCp5nvZIBnj2B1JXnf898
	 agpvKrjuabv0YDRrFGFCFnzfC4eqskgdnlaws5iBWVDBqYVSBJ0TPIyp5/tv2UAha3
	 YkzkacIIOSrDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5683C3809A04;
	Sat, 26 Sep 2026 00:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: pcs: lynx: enable autonegotiation for
 10g-qxgmii and usxgmii
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038321089.3221981.652591640596312146.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 00:40:10 +0000
References: <20260923-b4-fix-pcs-lynx-an-v4-1-3f7927606d12@gmail.com>
In-Reply-To: <20260923-b4-fix-pcs-lynx-an-v4-1-3f7927606d12@gmail.com>
To: Patryk Biel <pbiel7@gmail.com>
Cc: ioana.ciornei@nxp.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Sep 2026 18:14:12 +0200 you wrote:
> The Lynx PCS setup for 10g-qxgmii and usxgmii programs the
> USXGMII replicator advertisement, but does not explicitly enable and
> restart in-band autonegotiation or program the replicator link timers.
> 
> This leaves the PCS dependent on firmware or bootloader state. Systems
> which do not get the USXGMII replicator preconfigured before Linux may
> therefore fail to negotiate the link correctly.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: pcs: lynx: enable autonegotiation for 10g-qxgmii and usxgmii
    https://git.kernel.org/netdev/net-next/c/a0dfaa3ecdce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


