Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5A3A7D91;
	Mon, 15 Jun 2026 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558443; cv=none; b=u9VRrGoWY3LjvoE8FVNQQ1pvHllszpdHUwiqljp/ai52SldO0pLhlaJpUEqNnPUpszi6c7y/brUtMuP83+kb3RyWlKPvdLXqLkJ4FtWSpHJr5t2piLR7ULDu0dA2vAUCRxkKB2HWeIr6o0Dfd9awzF3v4a6ay3NJss7ndE8Qgeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558443; c=relaxed/simple;
	bh=6SFZ1Z8FWmFOFN0+EapHzJIpEVt9aMs8514PT78fDu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QgMbxRcfIK4C+phaTM6n9rwCwiJF/tK8N6zDHBf2rIznQSiW/hRW71jmAuCzRaZOd0sYDqadVkvX4z3J/OB9Dkgkod6ymfkXY1gPLmBoAEvWMaLxrVRl9XFS2js63nZ6PCByfNeiknCCtPLMHHF54BBVLUyxKJ3hyRPGSEPtYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5SMW8he; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5SMW8he"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADD21F000E9;
	Mon, 15 Jun 2026 21:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558442;
	bh=hIklq/7rHscenEH8VHGYyl23zXN1GT6gbEWhbckp1hM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P5SMW8hewF1NtC5pAYHdm1xzzkXhYCk0f1jGU5vAtyy9par8dUBfggGrG5xG9vbtN
	 toBVaUTaoXB+YUqLeplsUwp+bECqA263Y63q2p9cGW34ittCcJEInFWv+BUHbtR1xA
	 8yyvovVOY96MXkK/qrkuTsuSvkfFFaISzIeKS6y1uTgPbLBWKoHgjhlioY2tqOhFLY
	 vr+WyUkC6eu734C5RX4pM2//s8Ur3m8HGUJQ1DAOMtjKZtF4TfY3/8McaCn2pkeZGL
	 t2p0imHGTdLyir/nh7waEK/EvnNf5YoO2HFN2MBdZrfJYY6TgIWlFbmkdkGGW/HP54
	 m3uFR8hwB37UQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D097F3839A06;
	Mon, 15 Jun 2026 21:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 0/2] net: sfp: extend SMBus support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155843738.301119.9459899533729939488.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 21:20:37 +0000
References: <20260614133418.2068201-1-jelonek.jonas@gmail.com>
In-Reply-To: <20260614133418.2068201-1-jelonek.jonas@gmail.com>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn@mork.no, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Jun 2026 13:34:16 +0000 you wrote:
> Today, the SFP driver only drives I2C adapters that advertise full
> I2C_FUNC_I2C, or SMBus-only adapters via single-byte transfers (with
> hwmon disabled). Several SoCs ship I2C/SMBus-only controllers that
> support more than just byte access -- e.g. word and I2C block -- and
> have SFP cages wired to them. Today, those adapters either work
> poorly or not at all.
> 
> [...]

Here is the summary with links:
  - [net-next,v11,1/2] net: sfp: apply I2C adapter quirks to limit block size
    https://git.kernel.org/netdev/net-next/c/f2a138abfb71
  - [net-next,v11,2/2] net: sfp: extend SMBus support
    https://git.kernel.org/netdev/net-next/c/58b29bdf6186

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


