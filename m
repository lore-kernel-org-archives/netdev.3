Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448806;
	b=GLqbMEvjirB1nkIjKrJUQd67bPeTXjvQ2GTQr9oClJOzWPbB2LQde5mY2+JuFWFF+Ft3
	 d2agK6ODIho9gB1VjdFFuRsIWlOYdmyjh6OOb4PqWm8DBO8G5i7XIm3B5soHUbtQxHa2p
	 PI13EOv6XbrZx+uRzoSQzdu2aO5nIlPaVyN2iv+z7D23NrSAP51Z8P7lOXBYWDfz8xM7x
	 rVopy7j+L2uHUn0FQa36yjvKxvFgcnvwrYR0LUp7k9r2nAnGZFMxiJ9NhmRhokUkiw0uR
	 LCnsu45aIOHo4e0SA8czll8YZRiM8QDYVTki4yTZrrC/3fZppMemODbp6MYNEH1pzEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=CrFEoxXRWmp4QQvsClKG/2hu9QeByJV/faRb/ux4aRs=;
	b=sc+j5fX9GBxvqauveT1OXNFbZ8lDMEMPHEuXAstAaMz/ieyLnJoGsLwYPjrvPZQE447d
	 XYFTsjZAghB3HKHv742GNT87Bmjwrgys3pvSPdPcm4YB2u8tMcs04KSoHCHqlzPeSWOp9
	 VWKqhWr0mmWiBEzvqntkHQJBmcI/DrPWjib3Uu0QiYreVkzLy/ESc7s/RRiF8TF7w9MKG
	 CYPzwSYsMckXV6y+ACYHOR5bdma8TvyA2mcInxwwgS5ecTaJ00m0uw7ac6osSjplpUntt
	 /OMcQ+tvIC8u1sPQ4B5iBCBF6/OKQosWGUWcRL4hykDgVSq95rzJijrKVir9DL5kEMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGtTVj90;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C0C606A31C;
	Thu, 12 Nov 2026 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGtTVj90
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8F71F00A05;
	Thu, 12 Nov 2026 02:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448806;
	bh=CrFEoxXRWmp4QQvsClKG/2hu9QeByJV/faRb/ux4aRs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OGtTVj90eBjPUVgoWLZ8MyrGJ+ALXKTWj5onhkLzEuiBBMcDRO+07MWuHHSqCJV3Z
	 y+phMlBXgsoWv6QAo1i/jUwisqLD6eM/8qXW94XRG/kwMyo9QDxUe70C0lcJZSgmA+
	 LnOMjcdAf/1MA+oo7AR6FdLtodliy2lKrNfgMANY0hc60k8rGsml7YI1fs6O6Yn3QU
	 qGrTDbwFvdGzGsd5LXgcwImH/wfZtVibfJW/dVZJTRl9jKqrpu6udWAJdfuRimFog1
	 DPtTZG5qOe7F4nZ8x7K0WLCH0PNTub12enaqfc+mwsPuoi91PfIOhVRDt+Fgf2NHh/
	 4m8bpm60Px0QQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E0EF391AFD2;
	Thu, 12 Nov 2026 02:00:06 +0000 (UTC)
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
Subject: Re: [PATCH,net-next,v2] af_unix: Fix wrong socket tested in the
 symmetric
 half of unix_state_lock_cmp_fn().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179444880494.1768068.16134554554597594383.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 02:00:04 +0000
References: <20261109092016.2082-1-lirongqing@baidu.com>
In-Reply-To: <20261109092016.2082-1-lirongqing@baidu.com>
To: Li@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Rongqing <lirongqing@baidu.com>
Cc: kuniyu@google.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 9 Nov 2026 17:20:16 +0800 you wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The second half of unix_state_lock_cmp_fn() mirrors the first with a and b
> swapped, but it tests b->sk.sk_state again.  Since b is already known to be
> TCP_LISTEN, the switch only hits default and always returns 0 ("no order
> known") instead of 1.  Test a's state instead, as the first half does.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] af_unix: Fix wrong socket tested in the symmetric half of unix_state_lock_cmp_fn().
    https://git.kernel.org/netdev/net-next/c/96750c67eda8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


