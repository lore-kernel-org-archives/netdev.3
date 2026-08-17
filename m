Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F636227EA7
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 20:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996864; cv=none; b=UdM6aE21cJZ+R0HEld+GaX3zGuOiw/3B4OnuGvTRV703fSAx7WDS6A1CrcdVm9gAEvtJTCbG82UHMsCfiCtgb1ixNK4xhyAjmOVbR3HJjnx40w7LpIXKcUAjbla4WZ2k02IuHehPWBtVgYMTM6bvSYgitLaBYZsOzEag4RMPCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996864; c=relaxed/simple;
	bh=CZeRI5N2mrso48em9uhxetB6iuKsgpszXqXBToh46FY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sUduRZvdgkmoY5+pyTuawQMRqRrFFWlp6LIKZHOkhXP2Tq6jesd/k1XOK4NaK52ViQmBI4wf7SaSQqfxN/nlBsZQpZkc7zbGG4GQLUHsn8JZY6JosUq2xbfMRhdkB94E7Imt1CR+rDK1vKVWzwZVGaYzNpNur193WHU6mLZy5/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STWALhmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STWALhmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED6A1F000E9;
	Mon, 17 Aug 2026 20:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786996862;
	bh=0jvrWwTehVmb5w9Jrs1lbbo+lQY9clcuW1htn8irMMM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=STWALhmxmo971NV+73ctpsmSCkG6drU0OMSHFndm91mks8LdsEhyw03ps1TvkvWIe
	 GHzkcj8mitdROY0jr85gSdkW/JI2YELTpp1pHft0KzD5fgadNapuRCJPYvK5yIA9/M
	 15grvbu57qkVw/2EGB7cYhpki/z8cFchJJdbuKKQqQETzGqqMCSi8lEBlDDYvCPn2I
	 ONaC8GECq0Y5//2E/bOImuXoHlsBB5ilnYSTT7hpBVDr/GbB1DnULerW1Q/r/HR1BF
	 GFjBj8WFMiPqUliTZ9Q8KTpFLfrywyiyAhe4h/FpvMRHYmRfzX50CCTSy3zh/XJ3v7
	 +lkQrLvybrNTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A893926263;
	Mon, 17 Aug 2026 20:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] ionic: fix completion descriptor access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699681464.1714062.14061885744342067780.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 20:00:14 +0000
References: <20260811195039.1315045-1-eric.joyner@amd.com>
In-Reply-To: <20260811195039.1315045-1-eric.joyner@amd.com>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 prabu.ponrajthayalan@amd.com, nikhil.rao@amd.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Aug 2026 12:50:37 -0700 you wrote:
> The first patch adds the missing dma_rmb() between the completion
> publish checks and the reads of the descriptor payloads, suggested by
> the Sashiko review from [1] for the second patch.
> 
> The second locates the completion within its slot from cq->desc_size
> rather than a fixed stride, which is necessary when IONIC_Q_F_2X_CQ_DESC
> (double-sized completion descriptors) is used (e.g. for hardware
> timestamps).
> 
> [...]

Here is the summary with links:
  - [net,1/2] ionic: add missing dma_rmb() after the completion publish check
    https://git.kernel.org/netdev/net/c/621f44af8c5b
  - [net,2/2] ionic: fix completion descriptor access with 2x desc size
    https://git.kernel.org/netdev/net/c/5da6ec6f06f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


