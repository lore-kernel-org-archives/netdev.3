Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF73386567;
	Wed, 13 May 2026 03:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643995; cv=none; b=gB5Zb9rh77eV7bEJTrOhrJD5SyglKS9uHmB2CIhhw8G291tRgJQxaKZElx6OTga47fw+2UhrMrMbmUBjErP3uD6PTn+JOhopRkhkLUOnHbnN7zSd8uHOMQQqfGIFpH56gAvxszxtlI06DrKydEVOEc8mFRNFnQQ5B49imd5UlFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643995; c=relaxed/simple;
	bh=WMMrAHaUa3ktmnZlGugNX+UkygrX/5H1MTWj1L51bAk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pZbfmHzKvp/BV1ipOITiwKEmXGImxPTSSWjmIrSo2WhoZWBQp6GL6b2FBrmZOsSoH+gdUcIexdpSusBGoP8uSVPsaIubi5YqO+wTQwsRYFvlRBLELEBU6Y9Ny8DuQPbDdkZLpQMb5O+CIcSGVgWB47qaCYnySpGeK3HEMbz4ZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egoaKjPo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egoaKjPo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD46C2BCC9;
	Wed, 13 May 2026 03:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643995;
	bh=WMMrAHaUa3ktmnZlGugNX+UkygrX/5H1MTWj1L51bAk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=egoaKjPo2QNTEEKX+Q97vC5KXC5IDcKa7gnpyc3Dgm2Oq/XSxn49cAQPeLdi1TZYn
	 ULs47KlqQUfxGmrYcvSn7H2gjRUq/U3oOnDHXxt6yNZdAe2Ngf8Y67g8DxquI1enoH
	 E8pmvPcAbS/Su5HatS0iltvOeWH0Ikuyd1PORpH1FxinHYLKgONj1fFWpjrclRF8gh
	 ehsveY41+Ia2I9Oe9cypxry5aQ2We1EODclVIGR48oIvyJZTO00uX00VLscQobzFhc
	 UUUW7qSCTFEyvukdUr1fkz/BtP432smmWheLpXJ+WO3R4YyioB2Eys+BWMQNsaghS3
	 SFtJGNgwPY6Cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE753822D60;
	Wed, 13 May 2026 03:45:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: intel-xway: add PHY-level statistics via
 ethtool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177864394104.3173643.14686567254374504217.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 03:45:41 +0000
References: <20260509205933.3965832-1-olek2@wp.pl>
In-Reply-To: <20260509205933.3965832-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  9 May 2026 22:59:27 +0200 you wrote:
> Report PCS receive error counts for all supported PEF 7061, 7071, 7072 and
> xRX200 PHYs.
> 
> Accumulate the vendor-specific PHY_ERRCNT read-clear counter
> (SEL=RXERR) in .update_stats() and expose it as both IEEE 802.3
> SymbolErrorDuringCarrier and generic rx_errors via
> .get_phy_stats().
> 
> [...]

Here is the summary with links:
  - net: phy: intel-xway: add PHY-level statistics via ethtool
    https://git.kernel.org/netdev/net-next/c/46444df9ff47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


