Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BD73F5BEC;
	Mon, 21 Sep 2026 23:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033484; cv=none; b=lZDo4DZMU41kz7ozs1Tv2basx3sH/4lIviDqX1gUKgbPbPyxrq78cVLHyUzmIckBwNbtkaS5Odi99r65Jb6U1x4hNsmhjr/b6QZ2i30TIoD78lwQcrOBx3bYdbUCtbAbAW0MImNCDhXHQd2GKQImeNwZGbjjT68JluDTyCuP23A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033484; c=relaxed/simple;
	bh=TbIZaUcrAgeVlrrw+mWj+Xg7htFjC0fcSeHNUlLnncY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s5VS4SR2If9tZXNX6Hk7DOFiX6U+kmb1PDcO0ziDM2o0cgZ//Ov/AO4r8PzaIyLIGyeUBnmMo0x3jHjiE2K+emcvN6RDixNM0tioVUaIEx/DHgDVaBLPaQ56GpHlwNo1SNEAx8VXyTpvt5yjgGHSNP2kJNZ0oJ2ZtnjOjDGb3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUn7gCl2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUn7gCl2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE9D1F00893;
	Mon, 21 Sep 2026 23:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033478;
	bh=A7SZzCuIKRwIGT2Fvpei1TqB9ntX9B7E0WRRS/Vpg+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kUn7gCl2OnI6tGz67h6lKqBDdug3RMg7LmM7RFCJR1MoZpF3SZc0kp9F7xvwWoQM/
	 rzxApucN+FrzZw/VY9M9578x2HMhMokRy3yQkqLG/lIfUSFA8SiPTp9BGIUTkBj2Tj
	 Vo6n3WrGFouSYtk4j0Ta1G3urzYEWiCQFfLG/fEBcdj835f5m0m0QBQ9ray+sifAht
	 y0IjXBwv4q3anBGff1HVU4FUAAnQQM6/BQdBfdeMGMUz5vMnplYR8z+h0VjArZMrnj
	 PxS1MBTlyit9a3ofzoIIpQa/BGWOIOf5SzR9mduO/17Nb6QfoXhrN/21iCx9sAElH6
	 m2lLPj2S8E7Kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197C23927048;
	Mon, 21 Sep 2026 23:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: Fix memory scaling limitation in SR-IOV
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003340964.3287147.15335729283521445845.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 23:30:09 +0000
References: <20260916022111.1083017-1-rkannoth@marvell.com>
In-Reply-To: <20260916022111.1083017-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, gakula@marvell.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 07:51:11 +0530 you wrote:
> The original code used DMA_ATTR_FORCE_CONTIGUOUS, which could exhaust
> the CMA pool when a large number of VFs were requested.
> 
> Fix this by switching to the DMA streaming API. This is equivalent on
> Octeon platforms, which provide full I/O coherency via the SMMU.
> 
> Cc: Leon Romanovsky <leon@kernel.org>
> Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix memory scaling limitation in SR-IOV mode
    https://git.kernel.org/netdev/net/c/d06f2ebf67ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


