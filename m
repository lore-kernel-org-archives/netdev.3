Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C822B41A78B
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431636; cv=none; b=bjkodZYbIzzCmi6xOoZZXCt2HwWPci5l/W93HhWCHfZSR3zkMnoj/eeLUD5ALl24GpJLEO5kFhP42ILkdkRBZ57t2xtEgUQALQcq5OcHNOmd7N9m14L2aom+HbMfst4DInfLmpUWNGYPub1n2no6lnTsy2enP7sFqB1+4sr06WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431636; c=relaxed/simple;
	bh=TYCAB73nmJwMARlspU+aLKniDj9pF5JbYzHAo0LnN2c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XhrWEb28n2N1cEwdAR+k8SuFlclEsUx6V3qn+rX06Oxh+y0MtHhz55JDDsIdo+e0cV0qdDsVAXW7Kqi+yRkxeJg60uGhJVr1Q5t9lMdt4CEdBXxvWlL4erxUBcuXY2Ov+isOruhqNwzQA6F447jAHX2adfW5BG3CKq/zPcx/Nn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W51SJiui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W51SJiui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BA01F00A3D;
	Tue,  7 Jul 2026 13:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783431635;
	bh=3MNJksVgEbRti8cuN4RXrW5FVxU2xglq3ohTnp0UYnQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W51SJiuii6ZWV7fRWDB4aMkvVAqiV11wg2Q3YF1g0y3pAxeOsNb+QCIKvFY61FdJF
	 0rCbAcKDK6trfFkuauKJuArpb4yfSQUD3HaVhejsC8fenfGichBerboKKva/MuAU9G
	 XELyoVNt8xlK20eg3NB1k8W4jK6ggemTOjAZXZIaCsVadu3xlSx/5aoOREn7DJ4/0W
	 eJI3d3aAP5RZcT8NFYgcD6hpH8OI/DxNqHMw2CHjv5WHrDJj20mP/E2a9l7xPaETM+
	 yqkRgUiIPEQBcnTNCNS6UaE7TGNY8Iak1yxDh+HeaPai94ogdRklGvSeB2wFlYSonX
	 nlhuc3m/dguhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B7E39253DA;
	Tue,  7 Jul 2026 13:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] net: hold instance lock around
 NETDEV_DOWN
 and NETDEV_GOING_DOWN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178343161539.1993077.11580513248901815053.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 13:40:15 +0000
References: <20260702224150.3730033-1-sdf@fomichev.me>
In-Reply-To: <20260702224150.3730033-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  2 Jul 2026 15:41:44 -0700 you wrote:
> NETDEV_UP and NETDEV_REGISTER already run under the per-device
> instance lock. The teardown side does not. Make it symmetric so
> ops-locked drivers can rely on the lock being held in both
> directions.
> 
> v2:
> - reword NETDEV_UNREGISTER unlocked rationale (Jakub)
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] net: hold instance lock around NETDEV_DOWN/GOING_DOWN
    https://git.kernel.org/netdev/net-next/c/5326fefb9fe8
  - [net-next,v2,2/6] net: dsa: hold instance lock on close-on-shutdown paths
    https://git.kernel.org/netdev/net-next/c/cefa18fab29c
  - [net-next,v2,3/6] net: mtk_eth_soc: hold instance lock around DMA-device-swap close
    https://git.kernel.org/netdev/net-next/c/6034bc4febc9
  - [net-next,v2,4/6] net: rtnetlink: take instance lock inside rtnl_configure_link
    https://git.kernel.org/netdev/net-next/c/b8d2262b966a
  - [net-next,v2,5/6] net: require instance lock for NETDEV_DOWN/GOING_DOWN notifiers
    https://git.kernel.org/netdev/net-next/c/f540caaaca8d
  - [net-next,v2,6/6] net: document NETDEV_UNREGISTER unlocked rationale
    https://git.kernel.org/netdev/net-next/c/538d89fd9146

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


