Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384606;
	b=bnY1ujqZoYWpD0s2Xfmv9cNRbFC3ip3jfdZn17fwSXtV0M800SuKMuuZGns1Sl5ESlLG
	 BMgU/JhMDfqIXqxw9+F6Qxvg6UtWVxydoJaNU7PYd2mavm8t72XFmQEgzN56yJ7Wbhsli
	 4XxozBekvLbQ3pOgfYGa69yI5ASSnI3ywDvPM9DDdygBOQ61YS5Qc3K39j5AFpaoNiWo1
	 hLKNYhPh0ffw93MIJ5tlutnph0doS8JfpWf1d4vJrczRZUKOSqq3im2kXBufymJk2tFXJ
	 xhyVOZ8stC+nMEmykQN4t32Bkaw1lT5rWruwPJbMLmakoHL7e9/fWRa7ZEn4K8+KCQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ZJNGibamrz7xlIochfHNAE9z/RlAYopXQdJbYjz5yD0=;
	b=VYnBtqYLi90q0kkLCjlJK0GR7JtlEA551wWkcwMC1iUr8nY5NR3FJwBCS9qHAMLEkBQ0
	 paxsIUT01EiTJunoRiaX0Vc65/CayH8lmOzy1Xp7EG1+Xu5cvm2fjzT9AtxOX0ALTUsPk
	 uNOUIDQYRWojA1vGgJl7tbLwzksPhGiBBkBmMFG6M8uzJURQfOn+AIe5hr5tTbnkH62GB
	 zr+iu2tjbon0+x/6PHQ+WCMTSu7vV9tAt/91polQVUH0CHlpHiRRJrKt5YDil85/M528a
	 G1UFK7flXhpI37v5s19nXNyNaQBWpwHkzf9bWgj3xYfpu/o2BVKjH4f0DVKkSOJHSvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K/zsJUU6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C0606A31C;
	Wed, 11 Nov 2026 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K/zsJUU6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86851F00A05;
	Wed, 11 Nov 2026 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384606;
	bh=ZJNGibamrz7xlIochfHNAE9z/RlAYopXQdJbYjz5yD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K/zsJUU6n71lCk4dIKFJW9+uIls3DL68JKJxY9IU8Oke1501DQDJcTgl50KIRbStQ
	 2Z521i4TtP4Td1uHTNu6ChAI+UX1uEUoD/qJzSpUsyMIvZv8dwSgrIkItC93SCO0tm
	 kIqyN6nV4c5uVwNHk2TN0UK/vBuzFLTjboqhDankZ1ybJHXnPPdx8RPj4Ulp37R/3C
	 vvhXpi2mKFZCt0/eQt2DucMXe76V8y642yDvYpL9gfr0a+lk6+4AaETdz6eYYzQKeV
	 P8eZF3zMeV3q9cnmJl9DhRTYsSIYUY19wXt4sDl3NtAcRffXVv86qXOc/YLjfIy7FZ
	 UkQYGdb4HPBKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B17238007E0;
	Wed, 11 Nov 2026 08:10:06 +0000 (UTC)
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
Subject: Re: [PATCH net-next] netxen: fix the ring interrupt name buffer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179438460518.778247.8559006219743310858.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 08:10:05 +0000
References: <20261106095115.3564392-1-xujiahao@cmss.chinamobile.com>
In-Reply-To: <20261106095115.3564392-1-xujiahao@cmss.chinamobile.com>
To: Jiahao Xu <xujiahao@cmss.chinamobile.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, manishc@marvell.com, rahulv@marvell.com,
 GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Fri,  6 Nov 2026 17:51:15 +0800 you wrote:
> The receive ring interrupt names are assembled with sprintf() into
> IFNAMSIZ + 4 byte buffers as "%s[%d]", with netdev->name (up to
> IFNAMSIZ - 1 characters) and the ring index.  A 15-character name plus
> "[" and a full-range %d needs 28 bytes, so gcc reports in a W=1 build:
> 
>   drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c:1052:45: warning: '%d' directive writing between 1 and 11 bytes into a region of size between 4 and 19 [-Wformat-overflow=]
> 
> [...]

Here is the summary with links:
  - [net-next] netxen: fix the ring interrupt name buffer
    https://git.kernel.org/netdev/net-next/c/c40c6c365183

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


