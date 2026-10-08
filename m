Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE0F48E0D9
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481813; cv=none; b=tEH5cF3bOVoku/alm/kOiBiL+Qmj/wlc3SknBp4Ef6rU5MSwrR3py704wJFLg6yv74VIWJGDOcrdaEvRWtXIdJPgAfsAFtUmKeYEBSFyeCNGESU1PxeNWD4dPOxkYchgXY2CJY1b6RYyvwOq/h2CuM+U3IEr1n/9b3U5WgkCHEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481813; c=relaxed/simple;
	bh=7BHFFvOSJU4MqQUd1EemO2SqvVBGODpP3Y+xiMnCjRQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pAoSIE4SzMatKjEOw1Zz+S1GhsnASjkfGZ5Wa79JsU1AQj7+3/H1LM0JjlKqF2CLEmfZnbQfmrhthqzqzuqomWlOCrDbg1rwWBOEEk0+mtTzO1tyxpplgJtzfVP5KnMch+mns8ilV5nrQt6KbHYFvXWjIZEwobMCyCbZqIMDots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACedMp/9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACedMp/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D9A1F000FF;
	Thu,  8 Oct 2026 17:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791481812;
	bh=vVv4DMBU1wv8m2fRK4AguP+Twq3BTT78cIhOEGPMj24=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ACedMp/9hfqSmDUYWGtGchOB26aOIP8bp7xWWHPbz8MU0f2rP2HCfC0VmJ9wLmi0e
	 6U6uFlWARdQsRjxG0Iw3gexASqCVt7VuH2GddjNdqaBfTEleVobQu2uQ0YtTPFlHyf
	 a+liBp7/Rf9HaBWGbFYRtUiZgPuxWFd7MjKdC2zIMdvUcRutgu/8ukJbEr7FC2fKk9
	 8tpqCYMkAXfUOKd0grr4jI6E8IJcP1QVx1Q3djaHwDibqQ4L8/1wVzHpKxXK8OHJ+f
	 0lM5oF3Z5YamhHqP25IfqX6Zc0kPfxufqUTjqCuKB6eXEQ7nWpPb+AG+bsQ6KFFSK2
	 Xy1EEfFQ9Jadw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2F3380AAFF;
	Thu,  8 Oct 2026 17:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dsa: microchip: fix KSZ8765 fiber detection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148181077.369078.6504817076934431520.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 17:50:10 +0000
References: <20261007080557.15719-1-sebastien.royen@armadeus.com>
In-Reply-To: <20261007080557.15719-1-sebastien.royen@armadeus.com>
To: Sebastien Royen <sebastien.royen@armadeus.com>
Cc: woojung.huh@microchip.com, netdev@vger.kernel.org, nb@tipi-net.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Oct 2026 10:05:57 +0200 you wrote:
> The KSZ8765 is similar to the KSZ8795 but has two fiber ports.
> 
> KSZ8_PORT_STATUS_0 is used to detect fiber mode. It is currently
> defined as 0x08, which is the Global Control 6 MIB Control register
> and has bit 7 defined as Flush Counter.
> 
> Set KSZ8_PORT_STATUS_0 to 0x18, which is the Port 1 Status 0 register
> where bit 7 is the Fiber Mode bit.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dsa: microchip: fix KSZ8765 fiber detection
    https://git.kernel.org/netdev/net/c/fc13ba44da19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


