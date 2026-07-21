Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B4B3B9930;
	Tue, 21 Jul 2026 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784671242; cv=none; b=bmUn9WSUn1Yp3h6MRJrQ8vEj/4P/CJ4TGxXAMyj5xW4ymKMaQzuZCiKn9aS5nBFdTT/wB3hG4yIN4PrAshPnXNuhrQkuDA3DRrnMsWafqqCT68db0128iroUhkDF9R5BGyWEgL+zhI69SC8EAap+G9YPsBE2ckcchAB66bvvIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784671242; c=relaxed/simple;
	bh=0xVuYxZPON1oC4B+N576A69t5gUAAqL2FjxXLumQlic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KC40VOM547AQGT31i1S70AbLP6tnutoBtjLvi7lWR2ufNObp9KgvW/pA83n89JKqCDlaKNxHvhD0HXr7ueS0RTOkTrWTw7Dh9eeq1ZZr/wjcG/FxLJdKkTzyNGV1Yv4F2tf0Zs3r8M7VjDr3O/RaTDefB3whi8Q/YlqlUR2tSOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI6XvGn1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI6XvGn1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B05B1F00A3D;
	Tue, 21 Jul 2026 22:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784671241;
	bh=MsEIGcspohxSKfWmv6M8XET8JahqnW8ojtQncthEbnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nI6XvGn1txtQLNq46u6pD331/mmCFBOdhy52DXOKxx91rMqGQF/zR1ehilp92CPXX
	 FZ66Uo5vegJQ602SKScfCgC2vTbvbhx6Vg3nH3YIp89KzsiJPkkK5nVfD3dmBfobBp
	 HFXgygUBbK5ven3rRd9dYTE0HIWhAJnCFVrHETTAVWdYyDUBSRnrgD2OYIcXE0BpE3
	 7JdMb+UgzXpWyi3JcQSpE0olSdkObsSaU4LinpHS4Ato3TusxCn3zh0jWlRSKW3i24
	 7qXm/IgL9Um7/lB12v9oEDQc7WUulZVefG3oX3hRPAED4joNDUOPhOz5vlppfZ8/MU
	 fz25o29+ghQ1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198E0380820D;
	Tue, 21 Jul 2026 22:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: Simplify ioctl handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178467121083.1102577.17257961368358653679.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 22:00:10 +0000
References: <20260718143848.677531-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260718143848.677531-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, thomas.petazzoni@bootlin.com,
 alexis.lothore@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 18 Jul 2026 16:38:47 +0200 you wrote:
> Now that timestamping is controlled through an NDO, we can simply
> call phylink_mii_ioctl() to handle ioctls.
> 
> The only functional difference is that phylink_mii_ioctl() ->
> phy_mii_ioctl() can handle SIOCSHWTSTAMP, but this no longer happens
> as this ioctl is not longer dispatched to the ndo_eth_ioctl().
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: Simplify ioctl handling
    https://git.kernel.org/netdev/net-next/c/357997831d0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


