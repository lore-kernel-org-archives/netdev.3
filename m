Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F9A37C904;
	Mon, 13 Apr 2026 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120042; cv=none; b=kyJOJx40SU7KuTLlM46pHaNJCbCa7SmKHotqy/jAOY2/uqURNAQKdTwy2Hncqa1/L8t0j0YE1jTAJWPX1LYh449WGC2njy9Dq8ZjfnUQgs6wDrB64I/KLF3LJlbgXRLDv+L8zqLzo57aSh5SscwPJaq128+r06tLwkFbTTBGtMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120042; c=relaxed/simple;
	bh=RCAlocxEccM0PUWRbtDC+GyvpubgzyGtrwo1OYSI5sc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iVTcDVdbgj0PyFmJ2mTp5KFab9F3wdmkIx18TZ3MO1q3JmxqA2kd8wTH3WwHfTzI8oL3/Yj6Y4lcWqiU3f6xHakrYMPpmTBEKHtWvTznxIO138PvcWhfIkMrAcueMkWgmUaaF1gJ0wHqrS16LkK485hsCcKNIsd/iO2UXP3iHjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNVPFAS/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNVPFAS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869FBC2BCAF;
	Mon, 13 Apr 2026 22:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776120041;
	bh=RCAlocxEccM0PUWRbtDC+GyvpubgzyGtrwo1OYSI5sc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TNVPFAS/2bBxt0rRNOOBjz+SGc6n+sMiuXL3s/bnqbxTvm6ncbgDMgAzWlNqblhM9
	 y/cyj2aBBaZDRb42lWWVuMTzI9zYLikkB0fZti16AEBevODy+LkoPfDndUvtNAdmKX
	 eVEETDrPhXgkl2OaxswPfWzhAu3jYgFQGGUHpFL99s0k6EP+8c3vEKi4fvij2Rpjt1
	 VC9ZWiwNzbpnz63fCpCwi0ijk6PhmB0qEvwD7vXt5lDCyG43JkPkxAVrZfBE4h+5td
	 FkJ+fI05lwxVZpKK3hM8vM20I3KtnPms7RDeFoC0+NTUTdmfxWBGRoNInj/obrcpay
	 XZDLGGDXKEBEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EEB3809A0B;
	Mon, 13 Apr 2026 22:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/5] net: qrtr: ns: A bunch of fixs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177612001280.580000.3716167191659430474.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 22:40:12 +0000
References: <20260409-qrtr-fix-v3-0-00a8a5ff2b51@oss.qualcomm.com>
In-Reply-To: <20260409-qrtr-fix-v3-0-00a8a5ff2b51@oss.qualcomm.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, yimingqian591@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 09 Apr 2026 23:04:11 +0530 you wrote:
> Hi,
> 
> This series fixes a bunch of possible memory exhaustion issues in the QRTR
> nameserver.
> 
> ---
> Changes in v3:
> - Fixed the issues in remove() callback and other places reported by Sashiko
> - Link to v2: https://patch.msgid.link/20260403-qrtr-fix-v2-0-f88a14859c63@oss.qualcomm.com
> 
> [...]

Here is the summary with links:
  - [v3,1/5] net: qrtr: ns: Limit the maximum server registration per node
    https://git.kernel.org/netdev/net/c/d5ee2ff98322
  - [v3,2/5] net: qrtr: ns: Limit the maximum number of lookups
    https://git.kernel.org/netdev/net/c/5640227d9a21
  - [v3,3/5] net: qrtr: ns: Free the node during ctrl_cmd_bye()
    https://git.kernel.org/netdev/net/c/68efba36446a
  - [v3,4/5] net: qrtr: ns: Limit the total number of nodes
    https://git.kernel.org/netdev/net/c/27d5e84e810b
  - [v3,5/5] net: qrtr: ns: Fix use-after-free in driver remove()
    https://git.kernel.org/netdev/net/c/7809fea20c94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


