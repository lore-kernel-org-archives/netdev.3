Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832AA342535
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962630; cv=none; b=rPEmNP8wCZnJJmpE+SmTBvZcwvEzCZsotB13zqWFaai6OKPBLGd6nTTzhhd6CzZC3psx01OnXf4Nm5OH2im8p4jP5RQMuoHCu/hYXs3qJvX1PSO6IitJGAa58dDgW+jtG7CxixVKCbVfMVnZnnaGk9L7emGfgoIfqfBRC4mIUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962630; c=relaxed/simple;
	bh=MjJ0IZy9FsIhphkaPuiqPz/egBzEf962isFRwsPQM0g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RxNyPOXBySC4Hp68nXabLlhwqUBSx8Gf02oZDS9ZtMOmtw3JPYYTFT3ARaS8p/MlfPjrN4WSpmBEl2LsgpoMZFX2cTbAMLPV11jKjN1BwUUwBO25vUo35RfKNk8uvjS7OW6HrrsBg7QgnZYGYBMTuZdcpogOjGSNwvraz/d4tpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6QOvXxJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6QOvXxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83B3C16AAE;
	Wed, 21 Jan 2026 02:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768962629;
	bh=MjJ0IZy9FsIhphkaPuiqPz/egBzEf962isFRwsPQM0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u6QOvXxJJHufSQ/uCoGw73YXNnUc1Ql+SLOaqx6aSfBMWR7hZxdS7yR8STsfBWeVP
	 Vk+DES9xywAGCqMCmz5hV/2LJxNWaMzcvvvJGpmChIvL1jk2cxAd9TiLIEWSjmtMrK
	 aoBCE4+T015jmJYeJmaUMYSvdUHfniEO1ozRWsZr5/eTGGeoWWJPz+SRmczUgUn8eU
	 +8wK+b0KA/xy/hGdxInZ0+wL6a9TGDC/r6WqI4R9fnl1iB5akJ7e7wvoojwJ0SGis1
	 M2Ts1tTbtoM9o09xtdQS2+5jTHJBYX0imRg+9EXQqtuCL38Trkutc3QPJN/ZkxOLWz
	 ia744TKB9aNUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBB1380820D;
	Wed, 21 Jan 2026 02:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next] net: split kmalloc_reserve() to allow
 inlining
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896262610.696500.11948856261490760214.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:30:26 +0000
References: <20260116041359.181104-1-edumazet@google.com>
In-Reply-To: <20260116041359.181104-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Jan 2026 04:13:59 +0000 you wrote:
> kmalloc_reserve() is too big to be inlined.
> 
> Put the slow path in a new out-of-line function : kmalloc_pfmemalloc()
> 
> Then let kmalloc_reserve() set skb->pfmemalloc only when/if
> the slow path is taken.
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next] net: split kmalloc_reserve() to allow inlining
    https://git.kernel.org/netdev/net-next/c/3fbb5395c730

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


