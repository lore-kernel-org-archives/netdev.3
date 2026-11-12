Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502810;
	b=RGOW6wONaTpt1R8us4RS4BtNjiAoygczh+PQdyqGacxV7ahlgQ9jdMaTfwe+9UsMfiUQ
	 sX/PNaXSt6RPTz+J3H2LxKl/lKsv/wmvgzR4oI3HwCpxqt54Jn5CXbpJ5bT0K2TDElasK
	 Hop3AZ+MBCAcdRAZTTaXhBY2ZZaLhcrikEBmNhAk8nYbITfp6cPPnbvxX/5j0kNQLFDXx
	 MbM2KtFvgq9CvXwn8TAFtGUfkw4u2Xo5J/TcPMR/pREHV/2EzSRgoB6D60bK3M63eUzSt
	 hz5Fo4FvzEtqNxMJ+1/OhDjGNlaZfaWF55alz0mvyg/RpgbvFfjNH0hrreBKhiL5y3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=uPaBPas8QSZgZUblXK1sKxbYH6lLTfncfAH76rt7QiE=;
	b=VHW4ZRcke8N1jjdLu01+eRAD4LTaXGrDe2pSlMz+m4Y+5QyTCq68PoD0V4ijC/0Xf6hM
	 I9uN37vx82mVBYlDvYfsl1NwF0EwP8m4UaAlOZErnwJmyl/1q7U3f8TeAnKX/oPo1K5/n
	 cgN4OiACd62SuKl3fNP+I524l/MVX+CbnYZVRanu04jJcNHFadYbyNrI86002cZI1Flh8
	 TEzGk38dBoA4bUOQ01aOCV411ZK3SPI5MkkTcSOpveBkvY07Vp+jmrsoCsCHabV6edwr9
	 hmPDWNoOxbTmWvRs1DlEW2pqSqk7tWiT38Xkga2hcjdB5wJSaPUM6eif/50w6LylGlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7d6pTUU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E255606A32E;
	Thu, 12 Nov 2026 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7d6pTUU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079751F000C4;
	Thu, 12 Nov 2026 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794502810;
	bh=uPaBPas8QSZgZUblXK1sKxbYH6lLTfncfAH76rt7QiE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l7d6pTUU/zEjF2V0VRdC7f8lWPawLzdIYhHFUuxpIsvPZ69xYw0DO3oz+TriQvLsG
	 FluSdmyyzh6yywFEv7/9pJo1q3CA+IpHWzO0tYt7fEKNs0v/KfmRqkflM69m8woPEb
	 MfyufqUbB5bEk5pE2gb0U25hwMl6/A2IiSgRZ6j0sYg890szd/dlUuQEdf1nD4PN2L
	 fYW7x8e61uPjLP+EgceAangg4tX9+z1XyRavQeaXRiw6Zff8TXLh/2gwjE2DGW8Sx0
	 2iGvonKqlNYlkXbgBEHNX4fb89VJuGZBpPVeMa5KLrDm21g/roMb2pnpZMxSK02lKx
	 qx2xy3YPuLAew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F148E380AA75;
	Thu, 12 Nov 2026 17:00:09 +0000 (UTC)
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
Subject: Re: [PATCH net-next v3] net: preserve rps_default_mask on failed
 writes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450280852.175938.5856955473629004399.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 17:00:08 +0000
References: 
 <a235de028cc4160692127c6bf44ac567185b5449.1794143938.git.x-professor@outlook.com>
In-Reply-To: 
 <a235de028cc4160692127c6bf44ac567185b5449.1794143938.git.x-professor@outlook.com>
To: Yingjie Wang <x-professor@outlook.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, wang.zhan@smartx.com,
 kuniyu@google.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 8 Nov 2026 13:19:12 +0000 you wrote:
> rps_default_mask_sysctl() passes the live per-netns mask to
> cpumask_parse(). bitmap_parse() stores chunks as it scans from right to
> left, so a later error can leave lower chunks changed.
> rps_cpumask_housekeeping() also intersects its input in place before
> returning -EINVAL when no housekeeping CPUs remain.
> 
> Consequently, a failed write changes both the value read from the sysctl
> and the default copied to RX queues created later. On a four-CPU VM,
> after setting the mask to 1, writing zz,00000003 failed with EOVERFLOW
> but changed the mask to 3. Writing a mask containing only isolated CPUs
> failed with EINVAL but changed it to 0. No kernel modification or error
> injection was needed to reproduce either case.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: preserve rps_default_mask on failed writes
    https://git.kernel.org/netdev/net-next/c/b39a8c891523

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


