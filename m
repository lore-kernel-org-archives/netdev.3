Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAB364052
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 04:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918048; cv=none; b=cPUJk72E1waVDv0pAiOI187M0JiiyLgm2P14jhCxahgBDv9LM6yVIFZCaz2t/JzyJWGiW8c5HWe4uDexgC29FzymoN/qVlD1CU+etrPP1nLEvTzN6hyFIieLLw9f1nwfYz8FJx1E5BmUDsmLzIsWXlNAEqLGoIWdp1Hlu22kYYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918048; c=relaxed/simple;
	bh=/Mteqa8safDKZA447DVNnKvoqg3bhjVmmE76Mczy5dQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l1Juwldiyy2T5l9u6lySluIVrp31eoIfmYhTzamqTLB9SPeqGS68vur7+tc0Ooa1FcuKXwv2iGxTq8bqhWKMtoP/uvS3GXhC2C/0PJGdPDi0lIG47nGtowKWHulWGW/5E3aVsyq9E3n0y7QNKQrX9ZWnUz+xcdHrEav21MEll6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stdGB2Gi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stdGB2Gi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD90C2BCB5;
	Thu, 23 Apr 2026 04:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918048;
	bh=/Mteqa8safDKZA447DVNnKvoqg3bhjVmmE76Mczy5dQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=stdGB2GiNFfQsTSHIwkyH2tSYeU04u30r9KtbBRndePUMpZccoLlXutr29XQs5ls1
	 Bw1JnFgY7ss3mYMJABxZtAEbhF1mjSJrswqgNdQcROJaXR8AbHCjHeK8kqkHRiqk/i
	 2mFsCSUV9xY3J2uZKD235vg6SjabSo0N47dVkscBqH9bPamYdYGUgr685K/SKOsXXu
	 46biRbq/jYyV+JSXAqYtFeNvyHxUWmlo/oIaV45E0gQ10zYnxqTN44kFkl95iSXdDk
	 guNG5IU2qQFO5qwkbhDPUrYCAg54nPEvnCrPZRZctgE/tlOwRnFX0AKmvhhidWKDUK
	 9fMMpRSgnI0hA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EAB3809A86;
	Thu, 23 Apr 2026 04:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] Intel Wired LAN Driver Updates 2026-04-20 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177691801055.4154974.15731252792481087039.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 04:20:10 +0000
References: 
 <20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-v1-0-bc2240f42251@intel.com>
In-Reply-To: 
 <20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-v1-0-bc2240f42251@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, poros@redhat.com, sunithax.d.mekala@intel.com,
 timothy.miskell@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Apr 2026 17:51:24 -0700 you wrote:
> Since this is a set of related fixes for just the ice driver, Jake provides
> the following description for the series:
> 
> We recently ran into a nasty corner case issue with a customer operating
> E825C cards seeing some strange behavior with missing Tx timestamps. During
> the course of debugging. This series contains a few fixes found during this
> debugging process.
> 
> [...]

Here is the summary with links:
  - [net,1/4] ice: fix timestamp interrupt configuration for E825C
    https://git.kernel.org/netdev/net/c/c0a575a801a2
  - [net,2/4] ice: perform PHY soft reset for E825C ports at initialization
    https://git.kernel.org/netdev/net/c/3ec46e157c7f
  - [net,3/4] ice: fix ready bitmap check for non-E822 devices
    https://git.kernel.org/netdev/net/c/359dc1d41358
  - [net,4/4] ice: fix ice_ptp_read_tx_hwtstamp_status_eth56g
    https://git.kernel.org/netdev/net/c/1f75dbc53f68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


