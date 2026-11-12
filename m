Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493206;
	b=DIyas25XBlGCkVJkErvrfs5hsg1rOdV2vAJ3E4NPJJQ5qdUc24oUZ7r7axtYg0kT2UE8
	 PJ3rF1ZK7qaipPJ7D55QaXkfSMgUORFKI93Ln6Hi6frHIoOdeerZQptabadBd7ScaBXRH
	 ot09ZLE+Euye2hPkHklhTx32gvuiCAhEJIlIrqTWhTBddV4Bt66iZtQvYfeaxK2FIwb78
	 mi+cBBmyv2wZ+EpWJ7qIEpfFg+y9NmRM/2KDnA9KM5NLi2DGgbQUzhazyIPs8763TtkdF
	 +uoViaMhGPpzrQdoAP959l/QgxV/kcrgoqMwutufmCFh2bUM7Zi/5iCgW7VvdK0Il7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Oup8hf/VluzFp/Jvmh8o9AU/sY+czazjJSw/LVMQpj8=;
	b=RozhA7SEl51poAbSPd4SECtpwrALxQymbx+8iRFN2tAmG4rabiNuNxc7YmS2f63DySsD
	 CxaG8SLkTUQOBh4DREmguKjRiaA65heR+WpSN9c8VxvQXb2l3M76IG6584h8FgwqKSp89
	 1hLy27Ti3sqIkq28H7By5wexlermVFww5yfbFe0vmtLO3z65GWufGx1uzhKVHKgEerS+B
	 fju8FmY/J3NUBp+mKjgCfTWD4YgDb7PdYBuH9FC4xMcVl00WKwWWOQdiZ5DxFukJAmt1Q
	 PgDk1goEZ9Fon1r/E1dBFTSOpa63nDWUnRviJNYtsjnJoNLynXRU8KNp1GI6/W4FZNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUUK27g+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494116073784;
	Thu, 12 Nov 2026 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUUK27g+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A438C1F00A08;
	Thu, 12 Nov 2026 14:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493205;
	bh=Oup8hf/VluzFp/Jvmh8o9AU/sY+czazjJSw/LVMQpj8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KUUK27g+Y3C92QrUK2cAr93esc402w8PDLsSEt4CjVEfEgAdB07YvUFV3Nv0v3r2A
	 BjoYcy8kw8ZB4kP+mvBiJDPSY+TNqLGuaFiUm0VRJXz/bKXHiJ1Zpa1r7kWFp22YRJ
	 w2udf8hIc6D64CI6JDsBGAjxVT4j/nCcKAsLGw8UtbaJXiQWKt/9kFGN6jvuBbrftb
	 PhJ2FGDMdU24sH5l3xmcDIJjJCCOCq1gh60o/BW6yEYkyJfb97nX8xPNieJMhBqPJE
	 5NUkEzfbbA7I7747e9+k9sFh7sZeotud1zhAKTos67MgUHNiPPn2bJhqoVyXtdUNAj
	 FznZHWs+rIUeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B3A53AAA0F1;
	Thu, 12 Nov 2026 14:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igmp: use the joined device when leaving a multicast
 group
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179449320443.2132344.1113992068061365245.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 14:20:04 +0000
References: <20261109125312.2208874-1-graypanda.inzag@gmail.com>
In-Reply-To: <20261109125312.2208874-1-graypanda.inzag@gmail.com>
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  9 Nov 2026 21:53:11 +0900 you wrote:
> ip_mc_leave_group() resolves in_dev from the leave request before
> matching the request against the socket's multicast membership list.
> This lookup can return NULL even while the interface recorded in the
> matched membership (iml->multi.imr_ifindex) is still alive:
> 
> 1. An application joins a group using a local IPv4 address, that
>    secondary address is later removed while the interface stays up,
>    and the application leaves using the same 8-byte ip_mreq.
> 2. An unprivileged user joins a group with a 12-byte ip_mreqn
>    specifying a valid imr_ifindex and a nonlocal imr_address, then
>    leaves with an 8-byte ip_mreq containing that nonlocal address
>    and no ifindex.
> 
> [...]

Here is the summary with links:
  - [net] igmp: use the joined device when leaving a multicast group
    https://git.kernel.org/netdev/net/c/19ec8416a76c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


