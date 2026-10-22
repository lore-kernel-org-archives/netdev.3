Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627216;
	b=Ac68TZ8fGLKNj5LoXqgBA6VkaNtDcFiOdGd1wetfrMexCzAtRYNZsYt7gLCIBUghzEvi
	 jccQ0Zke+3T9Vl/qw8rxTYsbC5wImKpW0x4HDlTv8Q2VrpHxjqhoovgRHEdqxFQNd0lGj
	 9ATGV68NzTh1wMcifP7CwLqfChvIyhEwDR05tjnvpbvcyAHPJ8Ogkw2cLRz0x1mRsB9SC
	 pQ3qL647i+yRGXkZx2AnIQFwAND8ezTFyazQBHU1Kas0e8a3MzuYudeBO/wE5pdOweHtl
	 JBpKa9pw1eUVtyYyN67krDS3AowswYQ1WDKXHQ8fqCxJ7MZvbq90fPmS0x79fi6BFbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627216;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=oeaPBug6/xWLhwouYwYkca8RXEKCAo3ofPz2I6rBfnw=;
	b=3W6fHE1gUpjtKBom+udbqOjmVgnhxRDYjgogfGH8l1AUDjyA70m4SZx3TcdPNOHTy2Lu
	 MFe3kwAMPBspc3F9a2xHQP9ppFEQ5JAAMKRxPedGdr4SFZmlgCbyx3X/DlEaFWCnaOYqK
	 iXbhLxAH7OzFKekDbN07vSWTvXvriliWvI1yxBqumBarWGbd0qlrNs5/xHA7ml+3UHyLm
	 HidzD/XwjMiCYE/aZmfyAXdO6krnFYC2khP1mRp94gXmzwO9qZFmu/M8ez6CdMVDSx3MP
	 H9eWa18HQ++NixRGhGxnhpqU1dTWeElFjf5zMg1aVJmdHN2XaMvSQdhnqqksGdp6M2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SH7ETnz1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E7606A322;
	Thu, 22 Oct 2026 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SH7ETnz1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434A81F000C4;
	Thu, 22 Oct 2026 00:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792627215;
	bh=oeaPBug6/xWLhwouYwYkca8RXEKCAo3ofPz2I6rBfnw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SH7ETnz1YetRCDkzeITBRMBeku3mwFPAxNZWkqy6KmisasaXRbX4c4kCLRfifqzyJ
	 NpaaYD+up0TXFSX0C/3gyj07Iro0J/ymad22CpJrvUwagcJojPs14Ey+vmMwe6mYxk
	 EWx1PcDCAtrOXGDFl62y63LcSoW+QSEXhyvCkbd1OoNY9JCutqPvG+S3Pj7TieuXoQ
	 iIBLm92zZUYGE1UAVCT9hYRfJB1m4G4oyg1SHREO9Qr1M+0iAhSoiPlr8DqTDsoPiH
	 uLeAhH9kCVb8TKLBJavXbW5IGSsuuIwSh752UIp7/S73NTf3PJc3I2szPD7k26zcUA
	 py9Sq9NWLuulw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A374380A963;
	Thu, 22 Oct 2026 00:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 0/6] net: pcs: add basic support for RK3568
 XPCS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179262721377.1368559.4824000922345412806.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 00:00:13 +0000
References: <20261017054406.1828061-1-coiaprant@gmail.com>
In-Reply-To: <20261017054406.1828061-1-coiaprant@gmail.com>
To: Coia Prant <coiaprant@gmail.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 david.wu@rock-chips.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 17 Oct 2026 13:43:58 +0800 you wrote:
> This series adds proper SGMII support for the Rockchip RK3568 SoC
> using the integrated Synopsys DesignWare XPCS, along with necessary
> fixes and refactoring in the stmmac core and XPCS driver.
> 
> Motivation
> ==========
> The RK3568 integrates a DW XPCS accessed via APB3 and connected to
> a Naneng Combo SerDes PHY.  Several boards (e.g., Ariaboard
> Photonicat) use this interface for Gigabit Ethernet.  However, the
> current upstream stmmac driver does not support this configuration,
> and the XPCS driver has issues in SGMII poll mode that cause the
> link to be reported incorrectly.
> 
> [...]

Here is the summary with links:
  - [net-next,v12,1/6] net: pcs: xpcs: add ANRESTART support for SGMII link recovery
    https://git.kernel.org/netdev/net-next/c/e42329945d16
  - [net-next,v12,2/6] dt-bindings: net: pcs: add rockchip,rk3568-xpcs support
    https://git.kernel.org/netdev/net-next/c/20bd39c3c267
  - [net-next,v12,3/6] net: pcs: xpcs: add Rockchip RK3568 platform glue driver
    https://git.kernel.org/netdev/net-next/c/b9e7cb89aac8
  - [net-next,v12,4/6] dt-bindings: net: rockchip-dwmac: document pcs-handle
    https://git.kernel.org/netdev/net-next/c/dffa8241fca5
  - [net-next,v12,5/6] net: stmmac: dwmac-rk: add SGMII support for RK3568
    https://git.kernel.org/netdev/net-next/c/5cd3229579ef
  - [net-next,v12,6/6] MAINTAINERS: add entry for Rockchip XPCS driver
    https://git.kernel.org/netdev/net-next/c/5e91edfb0e45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


