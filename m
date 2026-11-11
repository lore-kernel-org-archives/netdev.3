Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439206;
	b=O1b0IAXigjfjCWAWVW37ffYLw4b4ZbA/QObo1lXhAUkPFhMpkiX8U/s3e3ipEIb6S3D9
	 2sNhjjDGxk0/Rr+zwM7wq1S2Ge02BN1bSKMaAylKH52TTarFkZEe34sw2Eb9sA7vCxPJQ
	 LFCnanyED3jgPI/nq9OIoxd5DXiBLpw865MqMWcSkHTZzuSXzsWGPCYgmZaln1bhyB96Y
	 rH2XY/d/0DGAwegmejMe+YtQpKL1G61APlQlkQLESSiViJ0KYAa9wIvNaqLE9NrpFsm3h
	 A/DFMzlKNwI8xvSyR28oqkHtcgx0MlBNrgKUI1PAEcAyDVJkz6yfjMH5ZYvSKoHPfUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=506UW8ffVFFn+fNOAYPgqIsgKBO+hMz+FtRpDH/HaMA=;
	b=yPzUqIk2zpUUYbrqdFcBvwiVc/7naUlYGcfo6ibGimdpa4KrvABX01BeYUux8GmZ3++0
	 AurBruHs/OzFouYbkZXLVpqp5IXhRYFurzLAvOArp4aeQRVA1GDbtzB0MJTOMJ5n1p+Eb
	 KEQEnzGHoUkP/06kA5JvJm9yybkxsN3kmWCiwlirvGiJbBg8R/bu52ly0aadtP1ED7K2u
	 Mqq61CRYKBsakLURszrUAQzH+h1tVtSzLUvln07hUNfTuCXTbS/hGRmXkA5QeY/Z6pmc1
	 vywTWBS1UrdGEX5yoQypjm8lOfgSzQjILUNo7pqM/u93WH6sHrf8FMnumMlJlLm6eTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cl84jhJq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B7F606A31C;
	Wed, 11 Nov 2026 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cl84jhJq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690AC1F00A05;
	Wed, 11 Nov 2026 23:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439206;
	bh=506UW8ffVFFn+fNOAYPgqIsgKBO+hMz+FtRpDH/HaMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Cl84jhJqEpSPimzQ1H9hjU38+wRkEO0gROgHtApqa7f9TNGlue70CV0fMUQErQ3Iq
	 cs7UMRfR2AGJcYpHMa2Li7Zgr+ZQddjbqCV4UgIDjz+ohovDLD7FRRRzBBg0XfBsJ/
	 LlOBw1dI+beIRu2ZUHS22sGInHvch7tHPGWD8rnjjQmvR6KgMa7qgmXkyiij6WCFin
	 i6x5Q4fbkV3dXFbH+79DkNVWIkrO71OX/rbuV6fERds6STITVT/g+9cqc6CwTftvge
	 4HK9B6BhrZnFtZr4Az9ysDMGnt4y9/lV+M/Q8xPkWrG4Wh73ah0PeGDGYUA7quCjIb
	 BF5k05wj4e49Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E0F6391AFC6;
	Wed, 11 Nov 2026 23:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] net: dsa: motorcomm: Free the MIB block on
 port
 teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179443920518.1699546.17528295651329739725.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 23:20:05 +0000
References: <20261109144705.1737460-1-mmyangfl@gmail.com>
In-Reply-To: <20261109144705.1737460-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 22:46:50 +0800 you wrote:
> .setup() can run again within one registration: removing another switch
> from the tree tears the whole tree down, and re-probing sets every
> member switch up again.
> 
> The hardware reset at the start of .setup() brings the MIB counters back
> to zero, but a MIB block kept across that cycle still holds the old
> software buffer, so the next yt921x_mib_read() treats the small value as
> a 32-bit wrap and adds 2^32 to every counter it extends.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: dsa: motorcomm: Free the MIB block on port teardown
    https://git.kernel.org/netdev/net-next/c/a9a173f81c83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


