Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E129ACFD;
	Thu,  8 Oct 2026 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791421214; cv=none; b=dY/2/S5oiq5d4zgqVb+IWA9d40gDAmAMCORfiaPny58EG7vLHHLNirftFg1We8ljxKVeOASLIt7RbTIexMJFS2pvVGlfvSqV+CJVNbd8vDyB1PKRMoU7oO+Do75YVBGQ7m9Hoq3fEWCskvcQHSC+alYIpaDPRVs7EFaiHdljjH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791421214; c=relaxed/simple;
	bh=cCfV1PSBVPMYA3xc4cpl2tT8mUpVgqnKPv/3ZSdTdvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YoFvktyyFRT7d4fiyGepTIhDqGIkRtAHOOM+NSXLFOC5JDAebINU23vxFsbRNjBc7JfZ1T8q53njOVujJqg9ENNsd0tIhFYulRUhm/WNNetwrCT0Rh0dljHvlfU6gXKZAqwcPNZKVj7PEyJ2FV3yPniTPHx9W08NZO0xA0MAmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHqouBWE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHqouBWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438761F00893;
	Thu,  8 Oct 2026 01:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791421213;
	bh=s9Z7/F9D6SKTGoPtNrGIDlkQpqQzDG54NuvKCSy2IRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jHqouBWE7HRatr8dEi+lj4y//396uNjDo9mA29RdVHpXFrFdiP12V6En6g5/TBgGS
	 PlKsP0rp+1ZwOEoY3W0IK8sGCyez+r1L0+Eo4XgP3YfyivrROOSMid3hrnRs/JUAkq
	 hC5NNpg1pfyojQ4LfOND4ih6e28TSsMZiQ5bRmjUlRmkNzfHIJiMau1o3X+bZXr3Ji
	 yYJSOUYtbgbEXykMtWjUspsecdm1mOFKX1k5cjs/fjkxU7QAF8dLQu02lhVpgigdbp
	 GxEaXt++tNfN26+oAcwIX9DpKSjwlFmrYRiPAKrgeLkAcGnD7LMThBBpzZx8u49PhO
	 BAbjJguPtbHqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A58D3809A08;
	Thu,  8 Oct 2026 01:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] dt-bindings: net: Convert HiSilicon hns-dsaf
 to
 DT schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179142121202.3755089.14103764017703102353.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 01:00:12 +0000
References: <20261005202808.1982164-2-robh@kernel.org>
In-Reply-To: <20261005202808.1982164-2-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 shenjian15@huawei.com, shaojijie@huawei.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Oct 2026 15:28:08 -0500 you wrote:
> Convert the HiSilicon hns-dsaf binding to DT schema format.
> 
> Drop 'phy-handle' at top level as there are no users. Add undocumented
> 'media-type' property.
> 
> Support for 4 'reg' regions is dropped as that has long been deprecated
> and there are no known users of it.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] dt-bindings: net: Convert HiSilicon hns-dsaf to DT schema
    https://git.kernel.org/netdev/net-next/c/3917a13917e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


