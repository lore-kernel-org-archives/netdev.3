Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEB029AAEF
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203003; cv=none; b=M5SKfnIj1ncTXL5dF6JWeJfgphQnITLpAJVHzsJDMQ7P5hAgURzRaJ0T+pHcyL1bUU/bPyucr+3PiM0Nsp+AhoVY0R18Z48jGsGarLORlaokw53Nwc2SHfWePLBQ9XlBaW/X1y4WJQkTH6/z9r6wXNDBoeVRZA6u+CUm6NmhpKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203003; c=relaxed/simple;
	bh=TitGL2dSMUTzQKeGPfliaX+xTjQqdg/oBWVsPyfwkzY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t0miil+2cZlbKl8+RvQqNQpkzywbuXXfiCcyETpfO4HtSMq7OVqgZTR6wTLH/guGfEYRizR4LV/p7fyUM4fSEaaIYRkdlUZpL4uecvUsqXWdpBmn5AgrOUSpZcc7lx/tJbQGDif1p8BKIxrpSAyC1NAEBPPxIdH5ore4ddn/SGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oF5d3Xqz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oF5d3Xqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A196C4CEE3;
	Tue, 17 Jun 2025 23:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750203003;
	bh=TitGL2dSMUTzQKeGPfliaX+xTjQqdg/oBWVsPyfwkzY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oF5d3Xqzl3Wwa99m3ROSo/x5INve5ptx3qvSfg3rgR90FynoxxN/c037aps/F3cf0
	 atPs6OLoQaLJdKYZMtDxGZmc1cT6APek/gPPMtLCO4FgYI1DsGyejUaEF4Fh0POMbi
	 3o2Iqn/P0jqEVtJNOfuptx/1d+DXabVhjaXgPqzf4l1L/nOZ1muggHdC/SNMQHBnHl
	 nYzvVMVefGKM3FD4sLaRMUPAHfKVkqA4yZbPUlqS29d9Uc2MiuDDBohuvqxZFmJOft
	 9GYcz+AqmSCq2fBttDEfFFmI6BIXIPlMJbdxttTcBIqEDD+m5Y9TSEEJAK1XYbMvsV
	 P6H1YmDtwUhFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BFF38111DD;
	Tue, 17 Jun 2025 23:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] ptp_vclock fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020303200.3735715.8650005095292139097.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 23:30:32 +0000
References: <20250613174749.406826-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250613174749.406826-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 aha310510@gmail.com, yangbo.lu@nxp.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Jun 2025 20:47:47 +0300 you wrote:
> Hello,
> 
> While I was intending to test something else related to PTP in net-next
> I noticed any time I would run ptp4l on an interface, the kernel would
> print "ptp: physical clock is free running" and ptp4l would exit with an
> error code.
> 
> [...]

Here is the summary with links:
  - [net,1/2] ptp: fix breakage after ptp_vclock_in_use() rework
    https://git.kernel.org/netdev/net/c/5ab73b010cad
  - [net,2/2] ptp: allow reading of currently dialed frequency to succeed on free-running clocks
    https://git.kernel.org/netdev/net/c/aa112cbc5f0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


