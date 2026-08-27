Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B518443E4B0;
	Thu, 27 Aug 2026 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787827866; cv=none; b=W9VO/PaElX93xBu330eupfht4mv755OvjjNLzgIuM05Fv4CiNzxX2Zj9TJs20cGZyRcTi9UcWwTWNnd0H64fKHPfMJqTiyWQznzLd48oavQH+vNu4/KujWDtQU1LAtnp4OTM6mX3VyV/mLIfPrOIv9zi6Nsw5/sEaTOQOuvbTWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787827866; c=relaxed/simple;
	bh=2z4mxLEafKu6Fh7cQrm5RJcUTRmkBbv8GAfykNB8z3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z+/HsUTeTwqnxrlfvRK3kZPPCBio9lbnEIMuH03zqFQmcif4PSedmm3Gy1R+WNVwPhm3xkwS2rfwv8RVIX1e9AbL/VjM09SmGnDnfcLJgK8kxMeQ661Jt6O1TGli49ISbScVv4T0TAhfmodDOsgNxHQV0oj7Nfhb3l8iij0cqLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPvKX0GQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPvKX0GQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FDC1F00A3A;
	Thu, 27 Aug 2026 10:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787827864;
	bh=5UD/WXSEkIW8wMh9gaB0TOOHS2Vrc2AyN517gGWFLcM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JPvKX0GQrMXP/+9/EKWhqLBqjlTWBE7J5S1z9PgXXUShXOo5piNTW9mKGzZGSi5HQ
	 u2gCNP7qwfTu02xUJ1mFAp3RfZ8qZNbvS6RLpVmFEBqnYmYR9AwuKhSC962HL4e3rQ
	 3fKRzS0XBCz7qikOehu5VI+6UU3U5rLx4gFloALXlv9zkZobbtl7wxqVwJ6Mp7mbGa
	 iT9Ovgffo6AF+t5b0K//m6bwM13TQ1j52SS9g27eVx6khzPSn1c7XNDVHOgkjgNjBp
	 hQm1I7Eg6BM6+i+FVGRgLakAUtJ+tWVNT/ySTpCItu5vp14uTmXtVHANXhcZ6Qz2Ar
	 sTdcxW2MB0fvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5688A3809A19;
	Thu, 27 Aug 2026 10:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: selftests: Pass the IP proto mask in
 the
 TC selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178782780993.1160948.1335335298813579043.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 10:50:09 +0000
References: <20260825211748.360935-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260825211748.360935-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, alexis.lothore@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 muhammad.nazim.amirul.nazle.asmade@altera.com, andrew@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Aug 2026 23:17:46 +0200 you wrote:
> The stmmac TC filtering rules have recently gained sanity checks to make
> sure the passed keys and their respective masks are aligned with the HW
> filtering abilities.
> 
> The stmmac selftests failed to pass the mask in the match data for L4
> filtering tests, and are now failing consistently with -EINVAL :
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: selftests: Pass the IP proto mask in the TC selftest
    https://git.kernel.org/netdev/net/c/9a56a27e6002

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


