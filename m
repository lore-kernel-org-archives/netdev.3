Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03548987D;
	Thu, 30 Jul 2026 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369656; cv=none; b=bXkiqpveQzPEPSa4SPbLMSYh08wAzCnGF2wxLs+LErkRGXkmJr6dUWc8jOqMRVx+cj7cn6STtKuvzpLfYVx9JsxQUPxECWVAjLgXcyHkf/O6e4KoYbfuZLQqjYONhJPmXzy3P3smOvywlAlynwf4RZTGmTQ3w9NOhm72CNeA0co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369656; c=relaxed/simple;
	bh=S8ZnFSu4zuIQf9ktmkVyZiabp9g6W8MLxx4/lsWIITM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gHfURbl4BnwXgW+hrYKCrDMfNQ/2ws3HuLRX9mXLre81w+cJBuL8MRYWJpLkVOnTFL9lPAwVJFR2jfIrU0vasCO+Ri+dwiof38gaK/pVXZ/thCQN5fnKD8752ifdMGmmUtqVVttYacYNSm1K7yu6OtG4AQei2Vex5Uc7Lk+O+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irAxgLFe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irAxgLFe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B451F000E9;
	Thu, 30 Jul 2026 00:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785369655;
	bh=f0ObShkYIFspG0PGoCkW4uUDT8J/blsMsOkLF8jj9KU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=irAxgLFeC/ibkvlE2HH/jH1lzBv6oXVQsBNaT9AH0SxejDz7YpzFSJtx9/lXbPKgr
	 BQvcocUrD0PIRStTcoaEAPgVGHNN+gwvl25bHvDd5RRyD2+Q8vmrDG49uHU15zKZy3
	 nyFKP/TzHQoa14j5roEhm5e0EX7IcoCAfOTMSu0g3bx/CosyULcVOzLzlfUfvXY5lB
	 ty8DRFK6bsLk8sPZ5RNdrsUi7OkoDaQamQEK04DGuOdChvnh+pk5dH47qj6H/GUbxu
	 k25mL2x2g8MKrOJsZWCCYCx7GAXGWi51VHWHpQN8eUzZEuNzWe8lq0npc2Yo692Vb5
	 qBn3G9Lg6ELWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C1D3926250;
	Thu, 30 Jul 2026 00:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: make Luiz a maintainer and myself
 reviewer for Realtek DSA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178536961913.3288516.6000326014158430355.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 00:00:19 +0000
References: <20260727-realtek-maintainers-v1-1-ab501adc0cdb@analog.com>
In-Reply-To: <20260727-realtek-maintainers-v1-1-ab501adc0cdb@analog.com>
To: =?utf-8?b?QWx2aW4gxaBpcHJhZ2EgPGFsdmluQHBxcnMuZGs+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: luizluca@gmail.com, linusw@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, alvin.sipraga@analog.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 22:29:29 +0200 you wrote:
> From: Alvin Šipraga <alvin.sipraga@analog.com>
> 
> I have changed jobs and therefore no longer have access to hardware
> using Realtek Ethernet switches. Luiz has kindly agreed to take up the
> role of maintainer, while I will stick around as a reviewer.
> 
> Also update .mailmap so that mails to my old company email stop
> bouncing. Use my new work email for Analog Devices Inc. instead.
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: make Luiz a maintainer and myself reviewer for Realtek DSA
    https://git.kernel.org/netdev/net/c/1c15e75dc21f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


