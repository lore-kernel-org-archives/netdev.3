Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F48356A3A
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963247; cv=none; b=hUmC/ChO2LPnB16n1Ruf2ldallaARxoRD5d++XWNTPCg8r6xS8qYFgWi4PV9bg3x5cZ0gGi6ecqsBmGAPqDGuXyo0zcPITocWISnSXHTYhafbESWBW8crbgQNXGYUZvHzEnqc4pLhGcaf5zT1RJuaGDwsh47ejzbPD+ki/Zm9ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963247; c=relaxed/simple;
	bh=xkc/qafbndTs+c7HESAlPKw3k1DOa7hVZ889NHj1Kn4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RkHPMdwT+AwC5Kw3mVmQakPHs8Ame5UYQ4aYd9o1kaowefnaAiMhMkMZusfBuRfLHYb8UUOxeVepo/UT3mzur7SU4sElaRr8ypwlQOVDZq0pkEJtmLpLz92IBUWIADo78ir5xa6R5duXUEGdjfaMirohLABmnHhCmsUjqwEWDUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTGEIv/m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTGEIv/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD03C16AAE;
	Wed, 21 Jan 2026 02:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963247;
	bh=xkc/qafbndTs+c7HESAlPKw3k1DOa7hVZ889NHj1Kn4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LTGEIv/mQRYmQ6M+EtzcqBkicV0h3i55BHt3x9N6Yozj5GsASDNytRl4DHqrPNkuC
	 MFTDtMasCvFDjtJ6G1fT+0dnLNmLWNHeqVCYiS0TMSUcoES/UmcU5Rx8QaB9ZPUawo
	 /nqNfU5DxoRlm5/wAbImX3B4hV6UN9IQltnxM4xLkrsY10BUkwEUIVQjnb58lErxcs
	 mqg3Tj1JdSWOZlw8HwuCBi0P3hzzjvDciDUUwTZ8BTYLD9COMz8D0m2dzEUQgbUIO4
	 3Gandqxpe+U6y49Q3pnwC0Ni02XwEdkHK4jX9QVZNw6CIgZJXAneCzk+kwBtNgv2aE
	 MWOoPM5cMcihQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CCE43380820D;
	Wed, 21 Jan 2026 02:40:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: airoha_eth: increase max MTU to 9220 for
 DSA
 jumbo frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896324459.699622.2094070103891917067.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:44 +0000
References: <20260119073658.6216-1-sayantann11@gmail.com>
In-Reply-To: <20260119073658.6216-1-sayantann11@gmail.com>
To: Sayantan Nandy <sayantann11@gmail.com>
Cc: lorenzo@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 sayantan.nandy@airoha.com, bread.hsu@airoha.com, kuldeep.malik@airoha.com,
 aniket.negi@airoha.com, brown.huang@airoha.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 13:06:58 +0530 you wrote:
> The industry standard jumbo frame MTU is 9216 bytes. When using the DSA
> subsystem, a 4-byte tag is added to each Ethernet frame.
> 
> Increase AIROHA_MAX_MTU to 9220 bytes (9216 + 4) so that users can set a
> standard 9216-byte MTU on DSA ports.
> 
> The underlying hardware supports significantly larger frame sizes
> (approximately 16K). However, the maximum MTU is limited to 9220 bytes
> for now, as this is sufficient to support standard jumbo frames and does
> not incur additional memory allocation overhead.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: airoha_eth: increase max MTU to 9220 for DSA jumbo frames
    https://git.kernel.org/netdev/net-next/c/6406fc709ace

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


