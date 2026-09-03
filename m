Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A15376483;
	Thu,  3 Sep 2026 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426068; cv=none; b=HAywuEvax1+bz6wcUFc5oh4ea1Q+NVyEuxAR3bkLMnkhbImTxQRH9af79dk864xWaBSRGnn37hkp39oqdNrHHgvraCodaCcJRMXELcK27PtWYGyDTl6nNf4jkcL278cKwhEQ0N7iKl1tnlJfh0UurP4I0hQ8tvdY9T07RC0ksho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426068; c=relaxed/simple;
	bh=vLMvwx4oZo86xTlh2FJV5p1Se7e8691YE6TB1uKI1hA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uHw+SmWc9JKMaveg7KYxBBLXoKhIQJy4wR18umSbhvgqN0OjNvWXTGRtWC+NIIppU1Asoo9CRocB9OjdG6EO47/g9sebT49LpKY+UhcNsZ24pJcdMLtU5nFXDXMMtREtcYtB3orHZaAz4F19Ow2xp3u2t23VyPil7JaSlJ7lQoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4YDmv6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4YDmv6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7F91F000E9;
	Thu,  3 Sep 2026 09:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788426067;
	bh=/UG7zMVZVaj57JKaT/NgSm3yz88db2K0TI/06GsPpNc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A4YDmv6dvoVogcMTXsrbyKW5pUL5wkQ7Mh/n/Kpq3gW2iN11xBWFcLhgFTZXkbj05
	 RAmoL7fZ/nbRUw6CgmlI7z9QUpDBmN3lYMA3YCH/6JaQEdFZ1RPYrYACv6/ntH5ph7
	 arm2nm+OJKhR/tlbPXVrvoZ+a/PVO0kPRtmR5jkbQl64TIGm7j0E0C6QCH4tdVGFf6
	 Czw6Bd0etlvE9tYErEpV6rtmhAnm0mXCOf+bocoOOBDGnXNV6MIvnNubm8G3w3pUoM
	 RFuAlsCeieY6D8os01ZUdn6CnQ9YMDY49y6YO/UO2Ztbp+LVJK7CbCPd1EELPj1Dhp
	 0GqqEqLv52NZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 62B133811961;
	Thu,  3 Sep 2026 09:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: stmmac: dwmac4: Auto-discover UC filter
 size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178842600911.3208873.5559894421239346742.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 09:00:09 +0000
References: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, thomas.petazzoni@bootlin.com,
 alexis.lothore@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 31 Aug 2026 09:01:18 +0200 you wrote:
> Following my attempts to get clean ethtool selftests runs on stmmac [1],
> several issues were found with the unicast filtering.
> 
> [1]: https://lore.kernel.org/netdev/20260827134004.45ffb57e@kernel.org/
> 
> This lead to the discovery that on dwmac4 platforms, the unicast filter
> size is always falling back to the default value of 1 entry. On older
> variants, the size comes from devicetree.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: stmmac: dwmac4: Read the UC filter size from hardware capabilities
    https://git.kernel.org/netdev/net-next/c/384ee2379a66
  - [net-next,2/2] net: stmmac: dwmac4: Use the full perfect filter ability for UC filter
    https://git.kernel.org/netdev/net-next/c/6815415d68b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


