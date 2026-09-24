Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F941134CCF;
	Thu, 24 Sep 2026 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790247079; cv=none; b=kIZnMZ7u0wKEuH9ARXSkc7ZhlVHbr/u1ZD8a12T7TwOt5aIZit1ERNgmdP9sSLva2IepyCFNnZAoU9p5yGoIm1EoJmhBEdcI5KvjMzKK/7hDrbBzNXBTzwZ1wgeEbJbtVYv4zLzqxIvFp00ch5o+5wBQUJym8L11d9IOgg8Jnwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790247079; c=relaxed/simple;
	bh=0cBbLROjvA+Cc6ZhXzWbASKJW7e02Kr/xCUlwxETpOM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TB4HpWR/GUQWLBKrE0y5im9sAiEe30NbjxB/rlw0JiLsgoEogfBVhBfhHMVxhNAk9p7FlYJFxe1D0HS6RWjnjdmPj8Ppp2RBH3RyVW0APgUCBRgJFaC5/6lp7PQNWeoFPFl0Li4xYbgpm+88DY5Si26eSyzENnmq2i2UFpa/DeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKEjElLJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKEjElLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18121F000FF;
	Thu, 24 Sep 2026 10:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790247077;
	bh=298whuRxcuqiTQgB45FLu0fKTx0gW440i0+qDDrM8Vs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AKEjElLJWa6C1Ht6fbHfbT6r8sNieUK3ECY7B6gn/MOHBedyRiNeO3oRfKX7BHWbJ
	 Ul1Lyiinxh6nX8nguwLQIOkXI9EoVZh76hgfc+0R7Z2yFLpv5a928biwj8ISeSHal5
	 u6aUQVRbmf/TMK9txAwWkdtiQOR7xDshUtq+Q2RaStb/o+lH2HinuXA6G0QkKVhXq8
	 6Vy009QZ/L9ULVlNKMdfm88iallLpcRrimRHvG5EQpyBinMMkAXNOkyWovunLajNoB
	 OyCcgQz7rcVuJNMZNJefxpc9EGGV1FvYSyL24b/lOqUxTU0uP4utR5WoS6Ize48E86
	 NY0bUxWW92FuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987C39EB077;
	Thu, 24 Sep 2026 10:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] net: atl1c/atl1e/atl1: fix soft lockup on
 out-of-range tx
 consumer index
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179024700671.1476028.661746840818666162.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 10:50:06 +0000
References: <20260921091334.3571525-1-tamas@rimpianto.com>
In-Reply-To: <20260921091334.3571525-1-tamas@rimpianto.com>
To: =?utf-8?q?Gajdos_Tam=C3=A1s_=3Ctamas=40rimpianto=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: netdev@vger.kernel.org, chris.snook@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 gatis@mikrotik.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 21 Sep 2026 11:13:31 +0200 you wrote:
> atl1c_clean_tx() reads a hardware-maintained tx consumer index and
> walks a software index towards it:
> 
>     while (next_to_clean != hw_next_to_clean) {
>             ...
>             if (++next_to_clean == tpd_ring->count)
>                     next_to_clean = 0;
>     }
> 
> [...]

Here is the summary with links:
  - [1/3] net: atl1c: fix soft lockup on out-of-range tpd_cons read
    https://git.kernel.org/netdev/net/c/36c2009d90f2
  - [2/3] net: atl1e: fix soft lockup on out-of-range hw_next_to_clean read
    https://git.kernel.org/netdev/net/c/374bf9e4b90f
  - [3/3] net: atl1: fix soft lockup on out-of-range cmb_tpd_next_to_clean read
    https://git.kernel.org/netdev/net/c/43e746821f5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


