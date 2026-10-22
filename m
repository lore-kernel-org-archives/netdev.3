Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792636806;
	b=h4YpVyXD0shKJwGyoZMy+9WLhUAP1vbfePduMNsdeX/Dct3b9IWwCSbV6jKYv4rvRvKU
	 h8f1m1fgBIa+PiCnwuYqBfwd3C59jtrtORDeODL0252UmWtHjrc8kpyvlGRuEQK0HcS6d
	 84EXjpANilW+Pg1NANYkmml/uPadYirFxoeLPsAz31Ccj3Ooj7pueK2vwh6bbINy6E0IA
	 01puLkZcbSgVQ1VcHvs7Vo/sroNfQq5j3gXVCLuwTDaw0Dekf05NPDFiiRKu9OIRVEkRt
	 PN3op7hUbxE45TzuV3cUtrpXBvpU2si3SP0vQcl238ruXFaIoHa7SG9QJsRrw/04d5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792636806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=M/fg1+U3EnOh2+pYzx/9Onq1tlvh1e+sbL+GlRjzD9o=;
	b=WBFh31TKGjrmyNJD9Js7cD7lrz75MFCqHOW+abNlJanrtQFCGog7Sg5M6wdUL9Y3Cn2y
	 7QrRVzWspd9wYMll+xPyXNCtL0voqQvsokBGtQWm5qFzwIpAzlizLDADMEY5M2vH65res
	 EAD6iMH4QuGJftMPsGL1yr17wIxwZKfBFoj1XxxtsUZDiBwQlCs9SWmC9C/9Vjiuzw0Ks
	 4UuoLlTOVTSA43ghzTFnF6po2vtUnMuHZ1XVF8U0L3zf4LEsNuyrN2/WEW4u13wV/hmW1
	 psgx6P/gYl7Edgvw6vCh1louexVagew0IJ4ZobIzaz7NKhoB/j7gcKfihDtb6H9rc1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJjKf6fc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A57B606A319;
	Thu, 22 Oct 2026 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJjKf6fc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EFC1F000C1;
	Thu, 22 Oct 2026 02:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792636806;
	bh=M/fg1+U3EnOh2+pYzx/9Onq1tlvh1e+sbL+GlRjzD9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LJjKf6fcVA2qQOUUET3ViPyD3a93dso2Jr3KbQKiunfmx1EU4CQplSZPGEudgkC17
	 DtryIOy3uSi1NBmNul7bLA1NLpJHM4TGr1dtnH0SkFjukuEkLmZSluWltYW4QaGVlH
	 eBQMFl8a99gn9YyUdg4qOZQx/bE9928FmWxBJF87TJradKnrLqI8kkPcwP3O2WF3rz
	 UcMWzJhwDpIhnlczxzV8an/AGydjm9Uf4R3Eh++4lLkO6X1tJ7DjwVucq4dC7krAio
	 OpHxp87eEc6qSazFrBvmSdOMIPOzU6IKoJ2tIkCMeyBLauNEej/Vtfv3+EQNw0ETHN
	 DFOfAfgsGPweg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A44E380A965;
	Thu, 22 Oct 2026 02:40:06 +0000 (UTC)
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
Subject: Re: [PATCH net-next] r8169: clear TX LPI on RTL8168h at link up after
 phylink conversion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179263680504.1419062.880435030900903777.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 02:40:05 +0000
References: <20261020161543.3712208-1-sashal@kernel.org>
In-Reply-To: <20261020161543.3712208-1-sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, javen_xu@realsil.com.cn,
 o.rempel@pengutronix.de, d.piecha@ymail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 12:15:42 -0400 you wrote:
> Commit 3cdeaef1754a ("r8169: disable EEE on RTL8168h/8111h") disables
> EEE on RTL_GIGA_MAC_VER_46 with phy_disable_eee() but keeps the version
> EEE-capable, so that link up still calls rtl_enable_tx_lpi(tp, false)
> and clears the MAC TX-LPI bits (ERI 0x1b0[1:0]). rtl_hw_start_8168h_1()
> does not clear them, so a warm reboot from an EEE-active state could
> otherwise leave TX-LPI asserted while the PHY no longer negotiates EEE.
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: clear TX LPI on RTL8168h at link up after phylink conversion
    https://git.kernel.org/netdev/net-next/c/f71ff7d40652

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


