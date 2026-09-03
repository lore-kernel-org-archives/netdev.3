Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096454908AB;
	Thu,  3 Sep 2026 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432666; cv=none; b=OTzHhz7zuuOjMGmiRm+U6MaqQDtFv3W25qTKZvAHXKTiTunIahawDRvuiK2ZR6a24pxoxL9UbQOXkcryHMM4D3aHQhGKtQ9JPboNmWQUY6dIaEObK9VdymPO/V4Av+0V2/C+dl0jelUnM2tjXerhfvolgsboRGaOafbKDHS+Whg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432666; c=relaxed/simple;
	bh=78JmQ8DXOqVBtBLHIDgPU5lSXJBpfXkLcrnIJ6cjsic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cMZXwV9Ztkl3eUu8GI2hKq00ZAVwWugNFhVhn+l307Fe+QGT4qr6zXYInNLsEXOZ6obRGteze2MgyffzphNHT7VUe/ugCIgXdNc6MYsRVDpSFAdE9/pbQ7QWCtJq1VBjGXrLrSRuRrjG2vqLcPe/vwOpDRTYiped02TLyPa5jKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKCigzJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKCigzJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C501F000E9;
	Thu,  3 Sep 2026 10:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788432664;
	bh=V77YITXNYaAAhpB2y040Wws/xOi4v5zHsTWoZMprBt4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DKCigzJPPRJL6AsOsV2pIApQVJl0Ljce1U2gaIHl6Wjc5D8w6HLWITG8/BaXmBVG1
	 Bksu9iUcOiUr2HfZtsVgigHiIC6ovNZG2wR66HY9xkT7E66jt6PXyBXH+kcZTHi1jZ
	 Jl1HNBnOpcr6Z+MCenuQDDy9/uwXwEGTIpQiMNTfLHsjmZrL5NwcZ6Bip8Fmzlmsas
	 2d0lMiXp0CCzDxaDOGMTRKIDJBlb5RK8th7j47ywlUxWU1T+g0uquGpRZrENPswqq/
	 WOhU693gGNsL8ndjMoeLwJ7aieL2qccn64rDpP+c6V5/dzxLF9fKwhXlL1AFGs3zb9
	 TFqWVe3z/obdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569243811968;
	Thu,  3 Sep 2026 10:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] octeontx2-pf: Add NIXLF error and poison
 interrupt handlers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178843260590.3268326.14566089616464473775.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 10:50:05 +0000
References: <20260831062600.839203-1-nshettyj@marvell.com>
In-Reply-To: <20260831062600.839203-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, naveenm@marvell.com,
 sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 31 Aug 2026 11:56:00 +0530 you wrote:
> From: Naveen Mamindlapalli <naveenm@marvell.com>
> 
> Register and handle the NIX LF error (NIX_LF_ERR_INT) and poison/RAS
> (NIX_LF_RAS) interrupt vectors, The handlers acknowledge the interrupt
> and log the status (ratelimited) to help debug NIX LF faults.
> 
> Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] octeontx2-pf: Add NIXLF error and poison interrupt handlers
    https://git.kernel.org/netdev/net-next/c/60c1bcdeeb8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


