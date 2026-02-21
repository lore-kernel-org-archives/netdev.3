Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606334253C
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771657798; cv=none; b=HrB2WHyZ4XNXoaQmCbyfCewcbfPyQrDGkKjWWGV1ULM5PdmxVw7ZkG6pFQBp1ub+mtNOshBlGkGoj0UTZLJKAsoJ/9VGgZQ4WU1qDfZvzC/mwULI94AfM/itbO8x3VacoDa1Wdr6lmsmro4Czb6pfBaj/aNYD5x0ott69+IDD3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771657798; c=relaxed/simple;
	bh=D8/V/GEcXIYvUezO8dhY5DxTLqDSM6nCLY/uPPWjgww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cQRbOv5KfyRIYi+gdAINDufDwNbjtRs+QRIg0vdWkmEciJXNrGFH198YNIEvw+Fq89Y53Gsx9ha7ky5GBNoDDrN4ZWLHzPdH9MgAEyTBOB2jh3c53TU+sp/vJbv01B3nKPQ+3+7lWVlSJspdY4eprTAyC1gPfqISPqA6aiNhrkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIvjyIk4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIvjyIk4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB04C4CEF7;
	Sat, 21 Feb 2026 07:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771657797;
	bh=D8/V/GEcXIYvUezO8dhY5DxTLqDSM6nCLY/uPPWjgww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vIvjyIk4fxM3zwUPUVknvgrJ6Wu3iQ4vxIGxDyrevwtDHaSwOw/Voe9KsEQcB5v2a
	 xFTiQqHJgk0yg+7AxnwebiJh32cWWz34QQ3abtE5nEottXpiNt0cyzZFjtXY1cCx0G
	 jhgzhdjFbJBeft+unexe9gMSkIPddw45m1SX28ALjd1nSixlo2v6EpHnWyETe3jRWi
	 N9AbrW34tkfe0FAkNxXH8jHmBkQvOQ+JM724lN48WlFZGN+cgRz9lgtoeaEpoS8WZr
	 5t7BAs9p59mM6e05KQUc5P5GoW9zjm1DlWZnK4aPHvCssEM07hxtQt63AFjtzh4jnF
	 rJ5YnifULQ18w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FA33808200;
	Sat, 21 Feb 2026 07:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ovpn: tcp - fix packet extraction from stream
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177165780555.1048752.5180904557768627656.git-patchwork-notify@kernel.org>
Date: Sat, 21 Feb 2026 07:10:05 +0000
References: <20260218200826.24025-1-antonio@openvpn.net>
In-Reply-To: <20260218200826.24025-1-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ralf@mandelbit.com, sd@queasysnail.net

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 18 Feb 2026 21:08:26 +0100 you wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> When processing TCP stream data in ovpn_tcp_recv, we receive large
> cloned skbs from __strp_rcv that may contain multiple coalesced packets.
> The current implementation has two bugs:
> 
> 1. Header offset overflow: Using pskb_pull with large offsets on
>    coalesced skbs causes skb->data - skb->head to exceed the u16 storage
>    of skb->network_header. This causes skb_reset_network_header to fail
>    on the inner decapsulated packet, resulting in packet drops.
> 
> [...]

Here is the summary with links:
  - [net] ovpn: tcp - fix packet extraction from stream
    https://git.kernel.org/netdev/net/c/d4f687fbbce4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


