Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0EB367B85;
	Tue,  9 Jun 2026 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780975209; cv=none; b=PcRe585FoIbX3L+SbrzJyyYw4SwAHs0tlq5r31GI6jvvDrX2eDwZF3YH9yT+QXupCDV18j9eLwW6Gy4lJcuuC3bUVBwln3NjJkLH+tCd6efwXZw+cuEUeaEMZTZwLpuCVr+aXwh/OKcUlVuSS3l/M8ab89HU88LOiIy0LYk+wU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780975209; c=relaxed/simple;
	bh=GEEGcxZaJNuZgdkavAeua7GODr4CWD2n3zGlEA6G9Pc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fQdU8404NoV8/srYQIYnIhogo2n8lBLk6s00VpwO0n77JacHqtp4yG293PKfuwnHhzuQ8AM0mmGWFvs3rROxTs1qLeTalb1249dVi8ozc9eatHbr9oLRMtWI+brVUYnhrSa7jGcb+m+avOlZvpzf/SJ7Tl+fCovBURw2JSsUvhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPVcEKg5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPVcEKg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7781F00893;
	Tue,  9 Jun 2026 03:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780975207;
	bh=IrR8JdMI2dePAqtokDqR2+xrbFDLg33tUvpKpRtHVTc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gPVcEKg5HVsxK1jSIZhCxeL83mGvAf8uxz/eTCVgv/qoU5P1adgydtyRR5MC7LV/o
	 WN146nvIsdpmKS4KvyPVkPpqOtwOJ8K2dBZ1ZZAzu6nCpEDRW8P703N/tT6PPMLrKg
	 H5sMikFcTTIgZuYkDeeIVMQ13u1M4I4Z2Sv7biIJcxobT0If+Ib0Si6pDVaeCbtbz1
	 zyfRHBV2GluJ8U7w6aDSLq8n+Dq1w59f3NOr/MucglY67tJcmBVZCNE1Kg696dyaxI
	 ske92NV8n11hmAOgoT3YaRkndxdyQnE+ZwXlGZO3LlNvTdp1LerwPFAu9vX8F6vDSV
	 GBUAKjX21ZeTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569893822D4A;
	Tue,  9 Jun 2026 03:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: openvswitch: fix possible kfree_skb of ERR_PTR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178097520590.1776256.15660722905631491116.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 03:20:05 +0000
References: <20260604121946.942164-1-amorenoz@redhat.com>
In-Reply-To: <20260604121946.942164-1-amorenoz@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, pshelar@nicira.com,
 jrajahalme@nicira.com, dev@openvswitch.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 14:19:46 +0200 you wrote:
> After the patch in the "Fixes" tag, the allocation of the "reply" skb
> can happen either before or after locking the ovs_mutex.
> 
> However, error cleanups still follow the classical reversed order,
> assuming "reply" is allocated before locking: it is freed after unlocking.
> 
> If "reply" allocation happens after locking the mutex and it fails,
> "reply" is left with an ERR_PTR, and execution jumps to the correspondent
> cleanup stage which will try to free an invalid pointer.
> 
> [...]

Here is the summary with links:
  - [net] net: openvswitch: fix possible kfree_skb of ERR_PTR
    https://git.kernel.org/netdev/net/c/ee30dd2909d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


