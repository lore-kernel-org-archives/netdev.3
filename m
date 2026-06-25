Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528F5293B75;
	Thu, 25 Jun 2026 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354632; cv=none; b=K193tSS6sFIKvbWZDTSVUduoLy6BZaOUp77OVJfN5bj0uefJUd5doJsXdwLCUIuI3R7rrYxdOW3tdluRl2Z5ibDdw9jrdqQ4H17c6T8sFVr7Ken5iBQOuNiHXU8lTZFPdlXJSuLGx8kxjPgax5lKockUgte2xE42hGcSPwTqRTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354632; c=relaxed/simple;
	bh=ICmyJ4907qCBkbbMLTKFMDrEPqktIge4J3LxYDt4SiM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dYdQZauxsceVUKKWDOpfezBHCBHNxbucy5/t8Dg9xwOeu2M9P60Aj4iNDSWuTg14Eilf7utZNeXj2zW595cFHU3P8tGoWPaLYP1wSCX3W+l60DHRr4TIVJiiAwJzPR1VfsO/tAhhtbeIzVn3gM7VMz5dFhgO7n6PCRV3a4iZESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyT8OeT3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyT8OeT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2484B1F00A3A;
	Thu, 25 Jun 2026 02:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782354631;
	bh=Q+IyHpflciDj3wZp1cwaEblnrPMuWYbay4+4zLMHa8A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lyT8OeT3efnmNWY2yLvqmcAeYfHMOhcd/LJRAfwAT0x4uSezRpdk1tK91CbZsWPzX
	 qUp50RFNcPid5bQ/jOBnYiJ2VJFzNERW2O7oKNiiE5jXJ4T3KLWZIu7UKYSNVNPajW
	 pT1RhKFnSC83Yf7cmRKBAAnXLJ+ShVr+e6nT0clmxySRKARtbMreVqi4SPzt+Bm4PR
	 22iCvx/jNIkw7yNtIio7c1Byw3N2t5tUG0sUGTB39aXVbolmgWhNAysIk4BTV+ubWU
	 b5lbxpdL0WTkeLnrHB6ERP2TFo0ysHjYo59eTn/Prdarn0go8gZWn0EAD6X1wDqsw5
	 4vGKJpiBoHW1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938C43AAA6DE;
	Thu, 25 Jun 2026 02:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: sungem: fix probe error cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235461930.3088510.2174930670555719019.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 02:30:19 +0000
References: <20260623025759.3468566-1-ruoyuw560@gmail.com>
In-Reply-To: <20260623025759.3468566-1-ruoyuw560@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 10:57:59 +0800 you wrote:
> gem_init_one() calls gem_remove_one() when register_netdev() fails.
> gem_remove_one() unregisters and frees resources owned by the net_device,
> including the DMA block, MMIO mapping, PCI regions, and the net_device
> itself. gem_init_one() then falls through to its own cleanup labels and
> frees the same resources again.
> 
> Keep the register_netdev() error path in gem_init_one(): clear drvdata so
> PM/remove paths do not see a half-registered device, remove the NAPI
> instance added during probe, and let the existing cleanup labels release
> the resources once.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: sungem: fix probe error cleanup
    https://git.kernel.org/netdev/net/c/36dea2f63924

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


