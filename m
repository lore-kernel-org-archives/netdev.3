Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8163CE495
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437076; cv=none; b=cBGIVii5oJtkOarVMaFtAq7h8CVbBQnnVWrLw/P8wSROEQmHOq14MYOE7RGJzAlJbOF0fWCzT+tnGQp8hOQj/gBVT9Ev4RGsg/6ATvJ2RnXUCfwog1cN7ZBZURrj2cs86HSzDhlKFr5HXrRYbqtU/ruXApETExynadPMBkoDSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437076; c=relaxed/simple;
	bh=2afa70e0ZVLQbaOdGjn2d6nX6oIrbr58IaDf+s8pa0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uIwxZh+lgoWIf+Ay2H9OZgBzGnFjoGfS0SLxo8hZnWndATTYpCGEUgRM3PuU1PE6YbqF7XTEt0N4LjsmUIli/Q64SV2GT8hZBIVTciUEc3PjuX/Itv7OvNFYiLBBMNVNxOK5qzBhsDu5X6Icl85T0JYFSwnx/kFZcF/aINh1B8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLPeftJ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLPeftJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342DF1F000FF;
	Tue, 15 Sep 2026 01:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437075;
	bh=itwfnddppYts/aNh14NQXudZ+g/qHKM1ljo2Odl43j8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dLPeftJ1fhcJ7f7zNyFpCvlPdmwLHBDm94aFvbpa7aCd/H+6CqHV0lyNOTcMv0zhz
	 KrQ9O1WAFq/wdYNhKPAhfoGcX6ZjMQoz8aAjRG39k0C7BfBXmokMLHZBsg10nKlFde
	 dOBsbjUw2CWv8Ndk2i29itlGPTTGv8VJF4HSbJJV7enkRylCtTDoA/XXeYNGETYKto
	 8qhQEDU57gt3sX0J7EZvdqVuKHlL9KS6ogV+pEB5wSN4ez2F980imFrAlgZbSzx2lE
	 hrq6E5UuikRzgvdHyk3585algHMWdLzkHmD3K7tmpDJW1G2GUhW8Mg0HzF5OvIuque
	 YpCdNSf8DcMOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56E4E3924FFE;
	Tue, 15 Sep 2026 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7] net: airoha: add LRO offload support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178943700988.1306524.1515972440197677223.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 01:50:09 +0000
References: <20260909-airoha-eth-lro-v7-1-e6317be79067@kernel.org>
In-Reply-To: <20260909-airoha-eth-lro-v7-1-e6317be79067@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, madhur.agrawal@airoha.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 09 Sep 2026 21:06:05 +0200 you wrote:
> Introduce LRO offload support to the airoha_eth driver, leveraging
> the EN7581/AN7583 SoC's 8 dedicated LRO hardware queues mapped to RX
> queues 24-31. LRO offloading does not support Scatter-Gather (SG) so
> it is required to increase the page_pool allocation order to 2 for RX
> queues 24-31 (LRO queues).
> 
> Since LRO is configured per-QDMA and shared across all devices using
> it, LRO is mutually exclusive with multiple devices bound to the
> same QDMA block. NETIF_F_LRO availability is re-evaluated whenever the
> QDMA user count changes (device registration and runtime QDMA
> migration): airoha_update_netdev_features() drops the feature when the
> QDMA has more than one user, while airoha_dev_set_qdma() re-enables LRO
> on the destination QDMA after a migration so that a running device
> keeps it active on the new QDMA block.
> 
> [...]

Here is the summary with links:
  - [net-next,v7] net: airoha: add LRO offload support
    https://git.kernel.org/netdev/net-next/c/a952507ca094

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


