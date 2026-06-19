Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385AC283CAF
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 01:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781831421; cv=none; b=LDjAd4qrPfNHGzUNycZXUJwp13MUHD9loh8WCLCRzPnutR5gTO6C3MMTNh4LdYEqsNINueAMl/WDaCiJw9MHuivQ9B023BidtW7rnq/KFLsmGSZVTffWB/SbRyTau9TkYj3Ba2g1kZ1gpEfSv4Zgv+JA3YSQ1+18us0kH8/jKTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781831421; c=relaxed/simple;
	bh=QQvSJsQ1a44RI46JAn+KepQjcvBSWGqRVRcqok40ROA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KTiG4NuJutYdrS+QiAn+mlXdjzchlrmfgu0C39xTF6zVr5rFeEqAjZB98Ld2zDNbW8X8o6HiE5BONeJM1Mb6nK66nsAmWvda71G8vVHtoJsa0q3GpGSIKuQAaYnW2mvQuDQ6r/f2oI2RHi0ut91FMUzU16IOFfme9akRNWrRZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK2oENrM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kK2oENrM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE1D1F000E9;
	Fri, 19 Jun 2026 01:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781831419;
	bh=XAV1Lkn9x7DjQIlVjm3qbHHpdfC0GAePkIxSz4M+XZs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kK2oENrMiCNMhWzdqshjZfWNDoHpnd/dLc7NdNfCJYV7Jd8HVmdvveiexzfyx/xbh
	 xrx8cCleHCAOB32QLkUX+0j3DxfgU1hI5DZB4fbFvC6Qpi/+bB/2uHrFrF0wS1MM7x
	 xaMG/tElazWzP1c5J6CjxRIiazMi0Dr2UVmOwL2j9viVCXC/Pqp29xTO3B/Bu0H7dM
	 DnFM9i2wpAAVceGiL5byEmk3D+JgJhuCd7R7lYzi2r60QVt5jlLE4+oz7kSGyYBVjm
	 neQLo1jenxiP57vQIm8Y+If/ZFSsWLL8X3kwQdwbnEgEEDzKqEdmSmKh57uyycOrUx
	 bOMWWa/HVoFmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AD83A78A7C;
	Fri, 19 Jun 2026 01:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] devlink: Fix a couple parent ref leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183141314.3148637.4107532095640365241.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:10:13 +0000
References: <20260616110633.1449432-1-cratiu@nvidia.com>
In-Reply-To: <20260616110633.1449432-1-cratiu@nvidia.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 michal.wilczynski@intel.com, cjubran@nvidia.com, mbloch@nvidia.com,
 tariqt@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 14:06:31 +0300 you wrote:
> These two patches fix parent ref leaks on errors.
> 
> Cosmin Ratiu (2):
>   devlink: Fix parent ref leak in devl_rate_node_create()
>   devlink: Fix parent ref leak on tc-bw failure
> 
>  net/devlink/rate.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [net,1/2] devlink: Fix parent ref leak in devl_rate_node_create()
    https://git.kernel.org/netdev/net/c/ba45106342bb
  - [net,2/2] devlink: Fix parent ref leak on tc-bw failure
    https://git.kernel.org/netdev/net/c/ba81a8b80f04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


