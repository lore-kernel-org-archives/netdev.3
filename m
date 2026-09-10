Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24BB379966;
	Thu, 10 Sep 2026 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053678; cv=none; b=k0FVRzaHftBxMt2DZKtm5fdyySMa26ktNklyR86RoEsIbOllroIELdq+shuUl+H5YwAdE8c++CjVfE128rOzo9E5MreK8X20Jn+w/opPZkIMlnv6p506JF8p1aes3DtnDkNvInNek8LZTS8fYNhcJq8yGhyc4h7B0gMrE/ZjpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053678; c=relaxed/simple;
	bh=8bAjnqzY0mGonpyNaozcR67fe9y0bo029qp2p8Aca9c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ai7v/uR0hkqqUa4axTcTHwFGEREvriAndKEPf+mVDOSnKR8/WO8J1NWi4HaobMjvIyntESkK7QpGRsdhyRZ2oWgzGzPuSXHVcDQMoqF10nQQrJYJtoS8dS5OIgaTHKqfAs1BxDoPD+7H+Q+eM4FxdJmcyMvRbqrfCclHMLRjtms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDhoLinu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDhoLinu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A3E1F00898;
	Thu, 10 Sep 2026 15:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053670;
	bh=k1ydG+COX6EP6u4Ha+C9PQoKFI0/OkXIk5jPYfCyL8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BDhoLinux09ESDCJSyQ3RsLXJaAFAy94vhRNrQ2JEu4pRVeMQ8sg6rqJcNitJVnXL
	 r+ypq79W4wLb5R1ZTBhKV/QcRW0u/6woHkhHI5s+w1WTVQcLG7YwyoRPgPm5DCR4ni
	 7nY94fcSvW3KFrAwZAjgpqeK5AErEtWG7ygfVMFJ8vqII3Yp0OlTzmyJwNhKtIAgUg
	 ptvtBFLM5bzYctkGQn0M7TfqPnIOtxhJVSbYXism15Usgv8V1VX86jEkc28EiN5UjG
	 In7PzpPtywAA+caJP1xItmL/y6aRNVAHBbOR741gEZ2jR9jaZaEYW/F2Xcf+ShMwl3
	 YoUR9M9nxY76A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D8380CEF8;
	Thu, 10 Sep 2026 15:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: dp83867: handle the active-high LED
 polarity
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178905360798.1492964.12723842189706369467.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 15:20:07 +0000
References: <20260903022839.4006614-1-donggeunyoo.kernel@gmail.com>
In-Reply-To: <20260903022839.4006614-1-donggeunyoo.kernel@gmail.com>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 11:28:38 +0900 you wrote:
> Commit a274465cc3be ("net: phy: support 'active-high' property for PHY
> LEDs") added PHY_LED_ACTIVE_HIGH and made of_phy_led() set the matching
> bit in the modes mask when a LED node carries the 'active-high'
> property. dp83867 was not part of that series.
> 
> dp83867_led_polarity_set() only recognizes PHY_LED_ACTIVE_LOW, so
> PHY_LED_ACTIVE_HIGH falls through to the default case and returns -EINVAL.
> of_phy_led() propagates the error, of_phy_leds() drops the LEDs registered
> so far and passes it on, and phy_probe() fails. A device tree marking a
> DP83867 LED as 'active-high', which leds/common.yaml allows and
> ethernet-phy.yaml references for led@N nodes, thus stops the PHY from
> probing.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: dp83867: handle the active-high LED polarity mode
    https://git.kernel.org/netdev/net/c/36a45facedd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


