Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADE82EEE71
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622420; cv=none; b=LQbbEOTq1YIPsqLLvJ+Q52hZo8DOxo1Kf1dnmGMTX+pa+qTyeVF7ry+pVnqXiivRuz+A7kthUNnGlBfh/KxCWnyz8nYRshevlmOO97Z1E3PgayMPbnUlq47M3ayGmfX9R55h8QKOMmE9H9VFfTLnlE2YBgD9IdPvwy/MGyUnQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622420; c=relaxed/simple;
	bh=s92NE7k/tYJ+gUcYEXEBuCmfGt3WJYhm5PQ7NA7S7Fk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XFCTzwl3z3UWgySkdy6u5arjl4l/AM8TCyRU9fQnS/Ulu0VG0q8TyNfOzCgUohHMEJxGPNLsrT+LXPNJKTXx3mcZpf42oUbyOlIj6S0g4PUYQbHgum8UI6ByUizI/edzRP9iINILtyqwDTcQcubtk5HE1TTi3J+SMgWkdwOP/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKkAEYB1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKkAEYB1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A041F00893;
	Fri,  5 Jun 2026 01:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622415;
	bh=E3JnGa1+MYCrgdCoNF24JoTJ46FCm5qzbegBjegyhL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YKkAEYB1r3/rUhUIM7JYXcpt/DAzPqiuSk6oH3UgO2jzLrGGlkKA8hwA12coafXww
	 Ij/DUmUXX6X9klAAU68SHqx5UMIaeowKR6uxf1Md3ytFPWSb/xRVKDQxYe3CNUBTue
	 PBLVcVx01Jh+3nEHvaDsevnTL80TDWgiSxd4PA1YpLDFXfr8QlRM1dKRP/c7WGppxm
	 M01IIoBltGmxfUBj+GPeKfnM/A/tQUp8YmotCpuaj2WJ7TlSNHSs1Laf7iaZ2mWZXe
	 lq40M2nzQr1addzQT558GDRY3EroWEotKOcqpMzmiug7+rbZTO4vVajZWvME4MrVv+
	 CxLz6VqCZRQOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A9C3930A8A;
	Fri,  5 Jun 2026 01:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bonding: annotate data-races in sysfs and procfs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062241589.3090676.12496831277617152146.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:20:15 +0000
References: <20260602152748.2564393-1-edumazet@google.com>
In-Reply-To: <20260602152748.2564393-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jv@jvosburgh.net,
 andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 15:27:48 +0000 you wrote:
> bonding sysfs and procfs read parameters locklessly,
> while drivers/net/bonding/bond_options.c can write over them.
> 
> Add missing READ_ONCE()/WRITE_ONCE() annotations.
> 
> This came as a prereq to avoid RTNL in bond_fill_info().
> 
> [...]

Here is the summary with links:
  - [net-next] bonding: annotate data-races in sysfs and procfs
    https://git.kernel.org/netdev/net-next/c/4dc5a40b3bc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


