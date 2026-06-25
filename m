Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E28355F2A;
	Thu, 25 Jun 2026 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355231; cv=none; b=eO/unoyC2nhiNs3kGFKQOATA1AVNJBAvDCnpowB2UANxy35WyVuL6m5WthkjMbtnd4Ta0isbqNdkSFTSerixD4CqQl0GtlKaewMRC0jEvlHEkzQYlXYJTwpXr9X4V14FnIUGU2aBwA8SI4lTgTd5tS6Vb/vzv8LrKEMY/soGx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355231; c=relaxed/simple;
	bh=2QJv8S0Z7SJd/ryOY1/Nqzo8MrZ3oE+WrazGZAEA9oE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XsUh0vDGSXLCvo7ZFjZbO8idQDr/GSabW/9A3g5LwapN0s9HKd9mfh6CpuVccuxgl6P/WVY/PPhnruM7mW45QG43+L9rfu2jf0fZ3zAZz5usio/qoCqVKigSq52z/kFRpX2qba/77yG1/gOkAvCFt44KDsuBE0fhBlJqsHuJBXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7na+Pil; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7na+Pil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A318D1F000E9;
	Thu, 25 Jun 2026 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782355230;
	bh=p3p64QLxeoSw9Yq4VL1TE72ZFtwb/GGd34Qq6hX/+TA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P7na+PilaTea4ySP01h/CB9/1d51ZEgJcB7t4yjiyW9Ebe7bbB7g6R4goX2Rmjp0H
	 cLTNwxK3eGUO/45R/Th60rbmu7WVB71uVsdxW6Eug3N7pygfq0v/uHvrGk3WSpYxYk
	 woZZHkRYnTntt0wUy7+jl6jsPvOAVL5NrKXIH26Ej6JVfwLVHAXh93JXiyoT+NOPMM
	 Mx1HIGld4tyrEBuL39iT9CmYKVGY59II1ErPcDFch1hfcX3mf24hIiJqp+ijX8Ic0Z
	 AM1gKYE6qD2JJJPKsFnv22Cg//Hmj/3qWuDHLSkuJPoGGNFJKA6ATQwzlhLbARGgl2
	 1mhHuKPw/iXLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199423AAA6DE;
	Thu, 25 Jun 2026 02:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: stmmac: dwmac-spacemit: Fix wrong macro
 definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235521877.3091545.4674535688381617061.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 02:40:18 +0000
References: <20260623074637.503864-1-inochiama@gmail.com>
In-Reply-To: <20260623074637.503864-1-inochiama@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, dlan@kernel.org, rmk+kernel@armlinux.org.uk,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, dlan@gentoo.org,
 looong.bin@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 15:46:33 +0800 you wrote:
> Fix Wrong macro definition of the Spacemit K3.
> 
> Changed from v1:
> - https://lore.kernel.org/netdev/20260618064143.1102179-1-inochiama@gmail.com
> 1. Separate the patch into two patches
> 2. Use the right macro name for the LPI interrupt.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: stmmac: dwmac-spacemit: Fix wrong phy interface definition
    https://git.kernel.org/netdev/net/c/d1e3a4c3b24d
  - [net,v2,2/2] net: stmmac: dwmac-spacemit: Fix wrong irq definition
    https://git.kernel.org/netdev/net/c/bf5cd5d4ca42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


