Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FF13B6C01;
	Mon, 15 Jun 2026 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553039; cv=none; b=Te3T+0nK55Xt4epVmB+snVDIJpnXFA0wDW8tx5sO4SIBxmqHwaaCkZi6bcaDsACxeT3BgZRSljO39Nrjd233TPI77r278waycUcqa1aLXrOezil9qzR1hODPN4Mi1hN2BoGjjTDVnL/aLGl04WtfnFpKmrZGKMqBbruTpLdrUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553039; c=relaxed/simple;
	bh=Z77/GdTCeWdmQdC27U0PuHvM2mPKrOrZHOCXDAYVoBM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iePOv06pJPgcnCyovGSI5rJVmhOWEkAjHxrygm/PzFm2k8RHVfp166aBuLXVJo3fXgaX6wOp0S+5xF0i7aSmOD4ZbaxtglsU1tVE7JUwUYCiXTMuafeTSf326jH9ZIe6SSjGbfD6umO98y3LAU/p2PRGHxxx7E/d+y5sLBkc7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgDieSZ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgDieSZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CB21F000E9;
	Mon, 15 Jun 2026 19:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553038;
	bh=xqKI0anXFa6Mu9LkJEEcXSh/c6yH/5QyAdhTCzzt/2Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EgDieSZ5xKgAFYssIoe0kQEyACZK/DaMbGqJG+HXCuwZX2SzvrL4DJj3l0kMmRBae
	 ocZfl8pNfK48dhswjKfBATCaTruZEvkKKgfRJUZ4rGyzeuatTusjNe3+v5OnSSjlF/
	 pO1ErTZ7PQqqFtRgyqClq/KCoF/bzYNV8dO4YGYEKoAEPcsDuJo6f6Z1k7wxSmkd9N
	 xUDhosYJqe3FSbxriqn85SiMEgjlhdxk2d31XKTILCCNz6n7VoKOFv8ye9LfRIlxNk
	 nrrUxWuzdkUwWN7uWsHfAxGGwGgxmZiUyxbuWJXJMfnNuSKcoO4JyERMTD1G8VBqr+
	 SSfPSIEHSa6cA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569F63839A06;
	Mon, 15 Jun 2026 19:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: phy: sfp: detect presence via I2C when
 no
 MOD_DEF0 GPIO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155303288.269508.9458032419916353803.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 19:50:32 +0000
References: <20260611175341.2223184-1-gregspatrick@hotmail.com>
In-Reply-To: <20260611175341.2223184-1-gregspatrick@hotmail.com>
To: Greg Patrick <gregspatrick@hotmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, mensi@mensi.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 17:53:41 +0000 you wrote:
> An SFP cage (compatible "sff,sfp") whose MOD_DEF0 signal is not wired to a
> GPIO currently falls back to sff_gpio_get_state(), which unconditionally
> reports the module as present. An empty cage therefore fails its probe and
> is parked in SFP_MOD_ERROR forever; because SFP_F_PRESENT never deasserts
> there is no REMOVE event to recover the state machine, so a module inserted
> after boot is never detected, and empty cages spam -EIO at boot.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: phy: sfp: detect presence via I2C when no MOD_DEF0 GPIO
    https://git.kernel.org/netdev/net-next/c/8ac44d24c3a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


