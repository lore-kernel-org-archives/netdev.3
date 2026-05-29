Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448123DDDD0
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086025; cv=none; b=uZhia0/lsYR/ZoekB9tWWHuxg0cuS8Mn08h+kF0VLQSvt8KxFj/OWLnaBRx8Orq2PHvCU/ZVgoQzEexO4+x32eIZsZpqV/1ReJChBP2HglafaVPlD17GixBi9k+gWEyvVBCZftbKG+IIM33vAgVwteF0i6Cs/No7TKuB80ZUzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086025; c=relaxed/simple;
	bh=nf49gS7eX3DKJi1ypov/TgrNzJNr1hWa7aD7giMMypQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LEkyFri5m4oOns35YTs5UmvGpzb8aoX2ezU2vTdiqj8uhqujRJQvqdu79t6N9E93v+rfenvh159O/kIb7xBtA3KZf2HMh3HY+5OEPMCIukomHeeBqtY2Si2mrQyb9T+usqTOvBaLKsdCdkGtMhv2naMjLD+FWfMBUM/AuR/aOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHPuVBSf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHPuVBSf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0841F00898;
	Fri, 29 May 2026 20:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780086023;
	bh=d80FK9vKxa+FSFDmA/wlHfJdvdn8QtpUTEDPBDmLPdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eHPuVBSfFWmEvZb+DmA2PrbTNVV7thINwah7n3YQvisl66DDmm8qgAtMEXHmPESis
	 EIM8xEAadQgNGJjRyokez9Qz6TEDuf1k1RuZCQjwDgVrmZD8O0VOGxUNBpvphhY7ys
	 /8o3WpRPOrRtRww4Ld8LyCNXFaJR50XeehL/ubpjUV4D/hnvDsd/UEuRO93oqmIYlh
	 QUE8yPvTJkMLHtVLPi48IrYQDIEx0XOXAnAL9MP6JIcOk9MEQIxb+2Mp+StKQg/Fo0
	 556PT1LjHdxEUGpSm6KjQLOwtCYeu3vEM/e8HQUxDXUJQAxY/lREQzM0HUB7oRjnFJ
	 BTR90sx8b5R0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A9E39301A0;
	Fri, 29 May 2026 20:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] WireGuard fixes for 7.1-rc6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178008602713.1951456.15370609139220938983.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 20:20:27 +0000
References: <20260529173134.3080773-1-Jason@zx2c4.com>
In-Reply-To: <20260529173134.3080773-1-Jason@zx2c4.com>
To: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 19:31:33 +0200 you wrote:
> Hi Jakub,
> 
> Please find one small patch, fixing the order of adding padding onto a
> packet, to ensure padding bytes get zeroed properly.
> 
> Thanks,
> Jason
> 
> [...]

Here is the summary with links:
  - [net,1/1] wireguard: send: append trailer after expanding head
    https://git.kernel.org/netdev/net/c/f75e3eb08fe3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


