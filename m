Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0F83A7F60;
	Thu, 25 Jun 2026 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352828; cv=none; b=YmVvt6zMoGTMYs2hazmcoWIkqy6RZrdXSmvVKc6IjO4wEX7slM8EY19n+28L4fa8bm9iBG866sgdIhT/b9Ubaq72VVC2P62hekHxNhaHZCn3FPGxoPKbmFwOnrGmVXKb+ONhnl81Z1efkWEBoVXINQr8JOpFZhpQR/fXS/Rhnr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352828; c=relaxed/simple;
	bh=p87vRsk58HtKqKF1CnuZlwdjWZqzKgt4a3wVWg42uG0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=msF2WPf8/Twh6HoIFLJHqsIbrz1j4Z2J5YL3j6HMkdpsOSRbk91jXnZFQzOdSSwsIyVMu43pTXhzvwWRTv1H9Vy+3BMQbsPlLruHKxkeqO7HCUuFvRzzgI97zHEI2YIutFFjlYU+CkQXrZQYmlgtZPXRK7CvCTPA2WnAIeVIHd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmUhYxgo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmUhYxgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C621F000E9;
	Thu, 25 Jun 2026 02:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782352827;
	bh=HXLUPt+dF5yoPf8TKv5bTrXXbeP8lmPzCG/lAQWMy4g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hmUhYxgolLMR9Ha3EHJ87neK6+jjahPW8qKiZYla5SAyAhcOOAPjz7TVvCW9lODwh
	 MYbYusqwnEIgMYuo6epDGEF4E4CRMFQLqSxGFeMzAZ6lTN54f9D+kjU0OSDn9YP6sb
	 xN1dLpmuJvqTchF9uhhchioA9PyKhyem+4fWKY5Cb7n/Q065L2Jo4MT3NAisej9Du8
	 TK2c/J2VPja4JkI2gP1137W1AgHnH/G3lTrdw8gQcRAySKoZhDMT1t/rfHpngiegwT
	 XzAq7iQZQheq5v+qOyx0ysHnr+Vv59ZDllerXyGvlnaWD866UCG4NrNAx9avgWghFX
	 pNBSMmNlXwFCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199E73AAA6D4;
	Thu, 25 Jun 2026 02:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] octeontx2-af: fix CGX debugfs RVU AF PCI reference
 leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235281552.3078979.11141600461739241806.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 02:00:15 +0000
References: <20260622034229.2254145-1-rkannoth@marvell.com>
In-Reply-To: <20260622034229.2254145-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, hkelam@marvell.com, lcherian@marvell.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 sgoutham@marvell.com, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, dbgh9129@gmail.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jun 2026 09:12:29 +0530 you wrote:
> CGX per-lmac debugfs seq readers obtained struct rvu via
> pci_get_drvdata(pci_get_device(..., PCI_DEVID_OCTEONTX2_RVU_AF, ...)),
> which leaks a PCI device reference on every read. Store rvu and the CGX
> handle in debugfs inode private data when creating stats, mac_filter,
> and fwdata files (one context per CGX), and use debugfs aux numbers for
> fwdata so lmac_id matches the other CGX debugfs entries.
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-af: fix CGX debugfs RVU AF PCI reference leaks
    https://git.kernel.org/netdev/net/c/469f4462ec83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


