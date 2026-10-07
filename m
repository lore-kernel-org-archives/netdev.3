Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CCD27A907;
	Wed,  7 Oct 2026 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791333612; cv=none; b=cJq/fY04WbyttguhLoGE68L7QXQnRBQjFqbeCg/LNDYQZrIMrxpNQtgy/CyJNXn3UsXHNUDXSyVVf00yxKrUB3GSJQPwRQu50smD67c8mTEN7JBZ+2KnmMS+Paj30YFdHqP8/6N30ouBtgLWfk1kVumsALC2J0FDW/MXH3Ks6w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791333612; c=relaxed/simple;
	bh=QJgBiBZ1tHRm8IjaBxllZcUr7NK3Ic6uKjbJ1/a3tsc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F14MOYEVNwpj+W+wCslapEiRZXmn16PvRpvDwotdT8SR4AEjwxEfDUbktCqfNzeK2+1l4439DQa12w1WChbPmTV5pzlduWfpLRR307iL7W/e5kJaf9gicBllRpU6FLLO9gReeSYqZV8tlCxeRSD+nsHo8B7jjo+iIEy2h8Wjn3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deD3c+EJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deD3c+EJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2EE1F0089B;
	Wed,  7 Oct 2026 00:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791333611;
	bh=Xwo5qNEZfC03/hFdaLBPbLxGypueBjEgwWqZlUEmzts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=deD3c+EJKQUFL8PPK20rlHSEHWqTNxOywnPmU6rMAPjuFd2Gs+r3sRIqwa2sadwcs
	 zOObpILVwSls5FPVFNHxFJNZDCUFN5tPt0DVgeEG+ohyhC02h6Am4+ClUXpycLly6F
	 QgQr+cqyrpDOT47Z5pc2EboZfL6+Gwae56ZJ9xHsS1pYoX37yyoLk7bbYb8sZ+WaSx
	 7EQ1SoZBGBDnctpFgijdiX7V2PuSCL7iA6popZqe+GzlNlP/c/yumPdgOa/1+5B1Lb
	 Opp7bZE2rN5G3bB2Bnl8vBAa6Gg6Wui14zC+l9jYaqAQ7/XZjixD86+2wNNdpkwWp2
	 kXVhxM50sO+EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773AE3806541;
	Wed,  7 Oct 2026 00:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v13 0/4] net: phy: keep a PHY interrupt across a
 generic
 bind cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133361003.2844451.4683989741719599976.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 00:40:10 +0000
References: <20261001130236.106059-1-f@lex.la>
In-Reply-To: <20261001130236.106059-1-f@lex.la>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 olteanv@gmail.com, Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 steve.glendinning@shawell.net, f.fainelli@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Oct 2026 16:02:32 +0300 you wrote:
> On a Keenetic KN-1012 the EN8811H PHY behind lan4 has its driver as a
> module on the root filesystem, so it binds to the generic driver first.
> phy_probe() replaces its interrupt with PHY_POLL, and nothing puts it
> back when the real driver takes over, so the PHY is polled for the rest
> of the uptime.
> 
> Patches 1 and 2 put the lan78xx and smsc95xx PHY interrupts into the
> MDIO bus table entry of the PHY each driver uses, so there is a number
> to restore for them too. Patch 3 restores the interrupt from that table
> in phy_detach(). Patch 4 restores it when the generic bind fails inside
> phy_attach_direct().
> 
> [...]

Here is the summary with links:
  - [net,v13,1/4] net: usb: lan78xx: register the PHY interrupt with the MDIO bus
    https://git.kernel.org/netdev/net-next/c/06192231d089
  - [net,v13,2/4] net: usb: smsc95xx: register the PHY interrupt with the MDIO bus
    https://git.kernel.org/netdev/net-next/c/2c583f49e8f0
  - [net,v13,3/4] net: phy: take the interrupt back from the bus on detach
    https://git.kernel.org/netdev/net-next/c/026bb4593faf
  - [net,v13,4/4] net: phy: restore the interrupt when the generic bind cycle fails
    https://git.kernel.org/netdev/net-next/c/4719b69bb66b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


