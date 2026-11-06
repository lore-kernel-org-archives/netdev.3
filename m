Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973606;
	b=l3mA70k9C2oYiUAStKIwwY3BX/a2BpKz22lTsQVVg2s/c4j6cO4MWVjloF7g3k35PiVc
	 FFK3WCDyB/SWD66+jWU7MsA97YZsli5dhJ4pi02JGOpvSrAS+s/FjKq2ODGk870ploeHm
	 gVhFepwk2OymoH0FdchKeqLYcB7jn0uBQaL9POn3UFlNTtBPZoJcwx3Uo9mNsEFF2pQrO
	 RE2s7K0IowX01j+DjT/1aqmN8sXdwIFA2aYI2NBTASmYOqdBLOrffqgX67utwTXL0kiam
	 YW+CIBj/3Xr+b0YHFN6yYoME09qCT2utrUbsz44HxhnDBCKJ9UDB1SMXL5fzwczpvDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=0s74ZEYdly1/UkkGryzb8KYuxZCSbi/EUf0lzGtMVLU=;
	b=CfGyJfyC0rwBd2/XSACUBL9I8edxLZtkVM7GNkQouSk+xQgiExjrIKrdNSfHptWvTqlC
	 Qm4zuveNclXYT8kjretVGtn5OmAvFoqYo4zWpr15dU4oEXuaj2tdAGJMK4dvGb/i+85dg
	 nuOH+OumTCwOCIU33m9UWThEP3v48d4d1GxaIBRmboG2BOG4+eJzt/phXa1VSepSR02+/
	 vdm5V93DznpupgeULF5BHIhYuN5hlbwblQ0NOc6JeDnSckp+uToyFQhRiioRAcwMKBvEZ
	 orPEasCBD4Ss006MKu8cV6k06yQOF6pM20/PcDa3XyaNwHi3a2SbsLelNFmxsQwAV1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFT1Mkbp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8FB606D81D;
	Fri,  6 Nov 2026 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFT1Mkbp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C491F00930;
	Fri,  6 Nov 2026 14:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793973605;
	bh=0s74ZEYdly1/UkkGryzb8KYuxZCSbi/EUf0lzGtMVLU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UFT1Mkbpzj/FgwZXmo3/zUgSAXZOzE0O9HPeYktfVJ5RHCBugmr1RmF5tt62cNqUj
	 C7yBGaaEJV4Q+RRnJgs7iZn+ESrZYznI6mIBREwVd3+MtHWiVOEaGH052CzEY7FUyD
	 ZvmSiCpC3ct9J8djnUwMS7jNgy6NdlTZWE3akXerqKfa6Fsijm8t0Kews8bf1sHahB
	 seqs+Nm7zrIkpQ0fhu3/N2ANJ01pzoGty330V+9CuMWps6OAI6mnBPvrVJn1+NXdwG
	 NBaVDIX/NVX/+/NC3xu5CIT6mr8e4Kdga0aeAXUeTGdto0hsFNNNTYWRTAh7CcpORC
	 dt6k9NQahhOmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D829439E9636;
	Fri,  6 Nov 2026 14:00:05 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: stmmac: selftests: Add missing endianness
 conversions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179397360441.639202.10722722859154063493.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 14:00:04 +0000
References: <20261103122249.951523-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20261103122249.951523-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, thomas.petazzoni@bootlin.com,
 alexis.lothore@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Nov 2026 13:22:48 +0100 you wrote:
> The kbuild bot found some endianness issues in the stmmac ethtool
> selftests [1] let's address these.
> 
> In practice these missing conversions didn't cause any issue, as the
> masks / values on which the conversions were missing were either always
> 0 or ~0, so skipping the byte swaps lead to the same value being passed
> anyway.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: selftests: Add missing endianness conversions
    https://git.kernel.org/netdev/net-next/c/bb67589c8724

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


