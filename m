Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E06322C67
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 03:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792440; cv=none; b=uaVxOIv5tulLGU8FsduueP+OycmBJkMPWkv3xyljFpgqK6T+FtDZSRSixj30d2IZ6lf3xovhaYDJot74Yc7ZHSEjKE5gqtUmUatUnkD27dTw4zSIGgFpUdagcaQX+wvx/T2/GErUSNXZaJDf5B+N+0DkT4by7nE9h1mNoCtHmbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792440; c=relaxed/simple;
	bh=4QCvPD9AZ63dpL1uXXGkfV4C0i9Z6kEkgDqNQY9GE3A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HJ9ppmZ/M68BjupCZj4zAXEjcdFsBAkmEcGhLg64vWpmfdWXIMkUei5bJeuOui/MP4qK1AXVjmiS2ncbGRn1fJnGgznHqmuer1H/+mOeH7tteSurJfgkracmOptBfX5EYnru+bnKc+TxTuUT/geulFuS0oC/umAlyR4zdz43dmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SECBq1jg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SECBq1jg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1360C19421;
	Fri, 10 Apr 2026 03:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775792439;
	bh=4QCvPD9AZ63dpL1uXXGkfV4C0i9Z6kEkgDqNQY9GE3A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SECBq1jgogHRc6CEUK2s32VLaXqQo5bXj0kzK+7y+DV8MAtm+lqx+9pbRl290tAkG
	 DYy7bg7mwzGjO0IjLuUzmA3P+6/3QLMZRodovov1IqPcLuo7jQumHMg6iVaAqqyRrN
	 /GTGimORB58J6PTMbm1f88cl3uSFXCG5CrXDLgBqIuBMwNjdhlQcLdWVlOf/cR3Chw
	 JjPzsxvRr024Rv+6MwvYyMdz7dsfW3dVSb/APd9dM8y8aZ7LDB3MAPA4KuA/IGkJ94
	 fC5Rdboa4vF0096QjOu+FvvDkqBgjjw93oE6Qxsqx27tygOOZb41b2hcK++R7/j2Uf
	 UP1XKdj0uAfLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BB13809A22;
	Fri, 10 Apr 2026 03:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: airoha: Add dma_rmb() and READ_ONCE() in
 airoha_qdma_rx_process()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177579241479.1854480.10305828080332220396.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 03:40:14 +0000
References: 
 <20260407-airoha_qdma_rx_process-fix-reordering-v3-1-91c36e9da31f@kernel.org>
In-Reply-To: 
 <20260407-airoha_qdma_rx_process-fix-reordering-v3-1-91c36e9da31f@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, xuegang.lu@airoha.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 07 Apr 2026 08:48:04 +0200 you wrote:
> Add missing dma_rmb() in airoha_qdma_rx_process routine to make sure the
> DMA read operations are completed when the NIC reports the processing on
> the current descriptor is done. Moreover, add missing READ_ONCE() in
> airoha_qdma_rx_process() for DMA descriptor control fields in order to
> avoid any compiler reordering.
> 
> Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: airoha: Add dma_rmb() and READ_ONCE() in airoha_qdma_rx_process()
    https://git.kernel.org/netdev/net/c/4ae0604a0673

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


