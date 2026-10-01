Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B847ACE8;
	Thu,  1 Oct 2026 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842809; cv=none; b=VHqC83DxNJ8XuPV54yIoUOlqKPC5dSOx34nehwF8L3+h0QXnxCfurU183sWBfMngQqiT20jtdEjUaKA3XSAWZqFFezCfoKn1Qf0O9QP5YPqrs1j+uTlrQyJzjecWz5WWXQ60yZ+hSrDGGACGIiSx82wLNwCZ5ZrjhYJQfFeIaFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842809; c=relaxed/simple;
	bh=jKJ929piK79nIx5hZ5XE8MWpLA7cfM9ky+fPfR7foR8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CiIPkMX0IaEEz9Xybt0oeyAnOOxkLiPfsItjuqe5iDzpusyA4qTMfdx2JmmxUnM5o+r6MtMV8VrQ3+YCaDC8zXEP9XDP7jpSXIWBf9Al1Soi01RkSZdpoUvDaGazmu95FWjJBd4lLwMQUD2gvfPViyVufa8CyyyGE4M9ICHvRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sx4aXXuH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sx4aXXuH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453101F000FF;
	Thu,  1 Oct 2026 08:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790842807;
	bh=NCK/vtMOrbcVDdBrjZGfheC/3nQmLE7ZcgKVbsaagwQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Sx4aXXuH/WX2CXGTNwzCUz1k8RBAAoNyAjmxPyzAQGQ6kOefXj0TZjOVIuMHf8SqB
	 Te2qarYcRLzyRdOgDxbGu6nX70XSKlMHHChJyiqqieEX1wbHxWyvZMag2THC+6w23L
	 OSMoYcYc+S/KgvSSPyFREotnfCpPuzHlgrVNpa7t2+nFOvXouEcPM5k6BX9eM5ST0k
	 /RWFdhchXCd/iLUJyNJpF9nWA88C7Cx6LX2Ym0ouGB7oAQAklixGbJhpC2BWGV9iFh
	 3BxS005fRWRstnx/B7YsOmKHjTs+l48dD8+0eODmq664qARPSJCPM7oD1kZT1lVrfz
	 Mijedxz0cb3iA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A42A380CFE4;
	Thu,  1 Oct 2026 08:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: move the type 2 sockets out of tree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179084280603.2317625.14903596427850220915.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 08:20:06 +0000
References: <20260928190800.2521749-1-kuba@kernel.org>
In-Reply-To: <20260928190800.2521749-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 kernel@xen0n.name, chenhuacai@kernel.org, tsbogend@alpha.franken.de,
 deller@gmx.de, razor@blackwall.org, idosch@nvidia.com, aconole@redhat.com,
 ardb@kernel.org, tim.bird@sony.com, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 28 Sep 2026 12:07:57 -0700 you wrote:
> LLC2 sockets are admin-only already. We have been getting a trickle
> of LLM-driven fixes for these, even tho we don't know of any active
> user. The code is so bad the LLM fixes just turn into a never ending
> stream of revisions and follow ups as fixing one condition reveals
> 5 more bugs. Let's move this code out of tree.
> 
> The series itself is LLM generated, the LLM was also nice enough
> to generates some tests and validate that the OOT module actually
> works.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] llc: move the type 2 sockets out of tree
    https://git.kernel.org/netdev/net-next/c/003f21868b2b
  - [net-next,2/3] llc: strip the leftovers of the llc2 removal
    https://git.kernel.org/netdev/net-next/c/6c1f58d7d5df
  - [net-next,3/3] net: drop unused LLC-related includes
    https://git.kernel.org/netdev/net-next/c/0b934eb6b142

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


