Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7A3B995D;
	Thu, 24 Sep 2026 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790218292; cv=none; b=k1G5vvUGBQZChJPiMVAfoePR1/eOLtOILY4XVCgASP0nfrVwdp4dsW54zp7DZQHTTHZ3ugiADYEeJ3Zo22jtrcC4HFLusl+pEeCR97Ty6MBnGOLj9NLxTddorcK+l2AxA+SLhMNhvYTTCPRByLKXuCHiAbG41iw6st7OcbKzJqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790218292; c=relaxed/simple;
	bh=eUqIdC18gAeiBUSlRWe00BJr8lbt27tqHr1b5lVWAQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KdQ6pYhZhKqYbSUWfaiqWSQ9O2jqIoES/+B582Oztv3CBbLw9dURKqMGC16QSQvWoNQrFvzDuSVJp/M7xEe5XR2Bqj84dhlzVlhgSLSpK8xVf18cfyZypEz8vSMzjqpq4rpTtoFyBnHncsW86vJoGstvKXLRSXaZupsKSfvFijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7qneP/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7qneP/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5285F1F00893;
	Thu, 24 Sep 2026 02:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790218291;
	bh=+APMoqLN+Tuex8iafa+jvUWJA4TUMYBhpFGLRXNb+hk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b7qneP/beNhBOqXs1LdOQOGDj3vPJ80nXZ5w6MRN4Yl19DLSf78hslPjYoL/3l2tr
	 WrUJtFiCNOjWVT2NIkZJF7JrIrP/+JdweU6ZRBC2yN6LvFltRuSTwmQ4pi5silacdU
	 rND5xmBaCEfJlvfDopIx4DGI2+8pIIivZE53ST6LOqO9uTb31CIWCXXKrOJMYNruhW
	 +6eZggTepAMC+tZwT8uHXBHICP31nxUg67j4oyy7gs7GnV3VdEanoSkvwVc/Kw5+Rk
	 i39YOLd+5/mog1uLLe5IqbLJYZXW0A+vIEZeZRbNSUsmIdwfEPM6NyYSdTUMO9M6Ri
	 Rd1uXir6uleRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19E4939E9611;
	Thu, 24 Sep 2026 02:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] vxlan: use one headroom snapshot for neighbour
 replies
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021822067.1291983.18145336450444388236.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:50:20 +0000
References: <20260918032842.502409-2-sanghyun.park.cnu@gmail.com>
In-Reply-To: <20260918032842.502409-2-sanghyun.park.cnu@gmail.com>
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dlstevens@us.ibm.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Sep 2026 12:26:58 +0900 you wrote:
> vxlan_na_create() samples LL_RESERVED_SPACE() to size the reply skb and then
> samples it again to reserve headroom. A concurrent vxlan_changelink() can
> update needed_headroom between the two reads, creating a TOCTOU race. The
> second value can exceed the allocation and make the Ethernet header write out
> of bounds.
> 
> The race is reproducible on the unpatched kernel. It occurred when
> vxlan_na_create() generated a neighbour reply while vxlan_changelink() changed
> the link headroom. KASAN caught a four-byte write two bytes beyond a 704-byte
> skbuff_small_head allocation.
> 
> [...]

Here is the summary with links:
  - [net,v2] vxlan: use one headroom snapshot for neighbour replies
    https://git.kernel.org/netdev/net/c/481506a756dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


