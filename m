Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432143563DD
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773287414; cv=none; b=oo2yzNj3oS1vmy03a2VM+2sGuDN68KhlLVtnITDaOpU4vjGbTQnswFAmC16LATANiQs8c0ZR13AKfRmpGBuEEC3U68QBKdtcsecYJK4jp3QQOC4OisGQwumfLS678ILWKTA0r5EPtjj2UemP8l3GJg9v2y0X9FFD+gjLioZnCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773287414; c=relaxed/simple;
	bh=BTpNLKi5b7JdKVh46HJKLw2410huIoWbLEhZwa64oJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q4SJjlmX+QOdh9l5COhLi/DOGKUN8rGyFBqztSpnl5/NRkcEY/UtbmfFWjh5PaEhJBo1JiKyHkrdy7rzRTpv5thgHNx4UlP7Ov2Vh35oS7zaEkBZm0MaXA+QciF4My7cwkbahw5nbfyQSZkppeC/pImbba7XISIC9+H9rAuy4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuzOaZ40; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuzOaZ40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9234C4CEF7;
	Thu, 12 Mar 2026 03:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773287413;
	bh=BTpNLKi5b7JdKVh46HJKLw2410huIoWbLEhZwa64oJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nuzOaZ40ee5/yhHVL7o+WNje46I9y+pAlM1fB5eIRj6CTJuRitAIa0PRifQtEkb44
	 4IbKn1b4FY56AYJTgAZu/9iB9BPh+wq9MgAq+h+r7MxNYTVcJV1ULodHNBPkZ/tDjd
	 Bec4XPJKRERH4MUigir3mzptqynnfBVBfZu0ZHuofTBr0UVcVPqPcDSiO3tK0lc1/Y
	 FGMjQVcYVufmT1e41Sf+28FdUrDTbfiaLhTRJJtND77sBHX9AohzY1KCtxy444ir3t
	 M6QazS4FS8DAKamFpg0WK7yu/FxBVcQaEO36bLaZzhIGKxNXOfdkozachkftTwwulL
	 EEXPGVVRGtnSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EC03808200;
	Thu, 12 Mar 2026 03:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] octeontx2-af: devlink: fix NIX RAS reporter recovery
 condition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177328740955.3930157.15850300877882489500.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 03:50:09 +0000
References: <20260310184824.1183651-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260310184824.1183651-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: sbhatta@marvell.com, hkelam@marvell.com, gakula@marvell.com,
 lcherian@marvell.com, sgoutham@marvell.com, andrew+netdev@lunn.ch,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 11:48:16 -0700 you wrote:
> The NIX RAS health reporter recovery routine checks nix_af_rvu_int to
> decide whether to re-enable NIX_AF_RAS interrupts. This is the RVU
> interrupt status field and is unrelated to RAS events, so the recovery
> flow may incorrectly skip re-enabling NIX_AF_RAS interrupts.
> 
> Check nix_af_rvu_ras instead before writing NIX_AF_RAS_ENA_W1S.
> 
> [...]

Here is the summary with links:
  - [1/2] octeontx2-af: devlink: fix NIX RAS reporter recovery condition
    https://git.kernel.org/netdev/net/c/dc26ca99b835
  - [2/2] octeontx2-af: devlink: fix NIX RAS reporter to use RAS interrupt status
    https://git.kernel.org/netdev/net/c/87f7dff3ec75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


