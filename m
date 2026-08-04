Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50833815CA;
	Tue,  4 Aug 2026 00:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785804062; cv=none; b=lPI41qRJU5yo13u3nmryABw1r1IF9muZhM3Jee3MVn9orxZP7fpBoig0roURv1wdiVuqt6xXaztF75U5nzSQSDQK/JHQfSR1c5hljycEZiMxKtEbLf9earfvEfmnJkFFmE/qyjBOeOEzVzJU12aYjdvPH5ArCv5H49wqSe1EMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785804062; c=relaxed/simple;
	bh=Ttk4APAcDUGNXXflERaRnDO9QfZRKHaeXex/NK/VFEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I1Fw/2nPTLjInIEbSHLp9wW+XmjwRePy061F/MTuGBa1nm++7wrR1x0qnDXdV6ffnHl1+b1DmPC0EpOUxnzARuVMrT/g/THHBofsuWoQAlJxqZwB8sSlsjc7CTghGSlZPjNIccD8XIS4Eg4Wf+IQbHbdHgp6AFE6r0TUNuSoZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFQUBfmH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFQUBfmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A11E1F00A3A;
	Tue,  4 Aug 2026 00:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785804060;
	bh=qD/kTSIycb4D0zwgPTSDDqWXIMWN3dBO5Y/1O5wHyq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kFQUBfmHS++WLFAJKGYgkyoaTcdYafYfeww/3HnI8VWa+InVYbcaKF52JAuFAoTlg
	 hO+Raogh8fUf0AVizyisjlWY0xKNrcVbWc13dSSe9cn8sRPJJsb40JhJX6/KPmwwCM
	 AkD4DMlJCHkk/qHDmxLBM1+HGjxS79IuxsfBxbd6qDCbTBQDbCTyUspa89UnrEdqw2
	 VoDRtA2tCCj/LNQGvHrt4nZiJQaJaxkb3ICtS55UlJ8ATDjxsuGCfnQM2iaKg5GU8d
	 qIfaIcnjfaMVm70gIjkkRDHT7kYscMaU8FuyfInZEhMOuGXmmc/F1+F/zbgyV1RM4x
	 k5czMrK0BvmaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5698E3924467;
	Tue,  4 Aug 2026 00:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: stmmac: Fix PHY attach when custom
 PCS
 is in use
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178580402088.2893509.17745137125486197990.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 00:40:20 +0000
References: <20260729074237.2624940-1-zxyan0222@gmail.com>
In-Reply-To: <20260729074237.2624940-1-zxyan0222@gmail.com>
To: Zxyan Zhu <zxyan0222@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, fancer.lancer@gmail.com,
 romain.gantois@bootlin.com, hkelam@marvell.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jul 2026 15:42:35 +0800 you wrote:
> This series fixes the issue where stmmac platforms using a custom PCS
> via the pcs_init callback fail to probe when no phy-handle is specified
> in the device tree.
> 
> Patch 1 skips the PHY attach in stmmac when a custom PCS is already
> configured via priv->hw->phylink_pcs and phy_addr is invalid, avoiding
> the "no phy found" error for platforms that manage link state entirely
> through the PCS.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: stmmac: Skip PHY attach if custom PCS is in use
    https://git.kernel.org/netdev/net-next/c/af4d93416445
  - [net-next,v3,2/2] net: phylink: allow PHYs to be attached in 802.3z inband mode
    https://git.kernel.org/netdev/net-next/c/e5db987f5d7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


