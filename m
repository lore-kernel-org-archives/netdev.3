Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E21DDFE
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786496453; cv=none; b=ARZzhehigOa31NkEJdRxXctVASxIsA5BmOvU8IgX4w+u6FmEkOMncSi3vZmDqhZll9PcWG9b5K+l43aY+jYSKyV/qustxvPdrAz7fZWSrl1vU2pFOyVSd4+/WiLjkkigXhJ72je+XB+3Vptzf6/oUF78x/dTSnpGyvFc29FuVJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786496453; c=relaxed/simple;
	bh=/urIOVaRGG6KOtBGj1vdky4U3kFp+LSu4+NJP614vus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YlEDl/rzBjFYsoYgdKICsudJqQhw41/O1gT4PjHOPTUbyqIfW0/SeRK8jGGNl8gCR280d+wZzw2AxFvrEMrlnLFrbOdlEgmVKh6Nl+CFqqB3VDN504HKaP43ZG6XcO+SnyeZY+mIQch7/bKQmTAbGNirdaVgt5ihw1BXDXZKeec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWLVq9Jz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWLVq9Jz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51311F000E9;
	Wed, 12 Aug 2026 01:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786496451;
	bh=cFH27gbXWFApYrUpgUKuBoAFJT8OE2eHBrLvkmTqReg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lWLVq9JzMp2p5FxUAkQCD7p/uMUWoIR3SfIFPdXxn9XGPaUNsrgWlnGL+m2Z9TUbX
	 TGZ7bShdpEqQpYn+Sl8RCJN5FBNDn0uAWcuCuL1kF0v0c0zDoPR+SfCZHUUq68YG/h
	 LUhVzyocv6gHiGB4Bc+byOToRAIThHZ+lb4bky6ur7hl8MqzT8ZaAA9WgsQ1C6A6m6
	 AH044mAYg2t7Yve3opyGSwPuSya8oCgfNVwMjdfstV/Io8zgkrnNJZSqntatCm0+SB
	 MKNU7YkH9tSDiIC0XDVe/eKmNXb/7xl73b2evqxfjcrNazbGOoP7cdDHolnvFjF2p2
	 2K3kwibOJz74A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A133809A35;
	Wed, 12 Aug 2026 01:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: make Tung an official TIPC
 maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178649640739.1219115.11996260324143491565.git-patchwork-notify@kernel.org>
Date: Wed, 12 Aug 2026 01:00:07 +0000
References: <20260810180148.680425-1-kuba@kernel.org>
In-Reply-To: <20260810180148.680425-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jmaloy@redhat.com, tung.quang.nguyen@est.tech

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Aug 2026 11:01:48 -0700 you wrote:
> Tung Quang Nguyen has been working as the de facto TIPC maintainer
> for a few years now. Make sure the MAINTAINERS file reflects this
> reality. Dealing with the flood of AI patches is a significant
> effort, and Tung's work and responsiveness is exemplary.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: make Tung an official TIPC maintainer
    https://git.kernel.org/netdev/net-next/c/e68028339907

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


