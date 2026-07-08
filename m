Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AF8404BE9;
	Wed,  8 Jul 2026 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500635; cv=none; b=LcLiUoJy4sQuGNtgkhkhN5nV62UG3u/Lcgr78fFnhNx902PQKcFsb+UqlPaxdk6RxcIHSHkZbQEHZvdZWSciDMr2gIE5hchfPPXvVH8c0whKSY5FML5tapBr00SdeTFZrnkbNPYvyusJCxNk9PhAWlqeprlOIvLcKfUTGF0tFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500635; c=relaxed/simple;
	bh=2bbwMYIcY/VaVC4F5ZEBy/gkWdeWV2QYde5Rz3fLXdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LE4oHETsqG8HLARZwhNe81ijLFMM1TTPFq7N9+l8aMqlSPfZamfdE7b68kfsUJqq0em93pRS0IV/wSsdr2pfM1dNTvBkzGj2fkUhVHaWRyImfqzSzRyuzI4ld+lxR4tkXog+4NbylUjbMCW761rr/bFHkGtr3nw0pNSKg3XQCjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el5z+yeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el5z+yeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA1B1F000E9;
	Wed,  8 Jul 2026 08:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783500632;
	bh=y76FFC23c7SAB1YbYSOwuwTdxocIu4x8oXq50/TkRl4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=el5z+yeQ9R5b4pp1+Im//k9FzR8zywA+1wiGpWt8kl2AjuJ5Cj8EWJNS6OZnncL6K
	 xOJdLLhilJz/HreFUjspTnU7HxY8VafhUrZsN0fKl5oXIGlRi3n4zMhlvcliPEi8u9
	 +VnvA//bTpemuC6ZcM/Pgc3G95d830tn75dTCKvfp0TcVPO9Dq+Oz42wSBfC9P3RoO
	 gbUHt4tf4MU1j2ivBJDXOCT6Ps3jvi9tjj/CcOKc/X3H7dO7vNRWcLOTkkLo5+KNYC
	 m0+XjW0wy2R2mQEGyNg2z72O71XnBzMUDWD2wpGXEedaewdLJEfho7oX1OxPS0E1hj
	 8y2x8D29o401A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198BD3926389;
	Wed,  8 Jul 2026 08:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] drivers/net/ethernet: replace __get_free_pages() with
 kmalloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178350061164.2381125.12226069469974368415.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 08:50:11 +0000
References: <20260701-b4-drivers-ethernet-v1-0-58776615db6e@kernel.org>
In-Reply-To: <20260701-b4-drivers-ethernet-v1-0-58776615db6e@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, manishc@marvell.com, pabeni@redhat.com,
 ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, skalluru@marvell.com,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-net-drivers@amd.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 01 Jul 2026 16:57:17 +0300 you wrote:
> This is a (small) part of larger work of replacing page allocator calls
> with kmalloc.
> 
> My initial intention a few month ago was to remove ugly casts [1], but then
> willy pointed out that Linus objected to something like this [2] and it
> looks like more than a decade old technical debt.
> 
> [...]

Here is the summary with links:
  - [1/4] bnx2x: use kzalloc() to allocate mac filtering list
    https://git.kernel.org/netdev/net-next/c/28a236c54c9a
  - [2/4] ice: use kzalloc() to allocate staging buffer for reading from GNSS
    https://git.kernel.org/netdev/net-next/c/764f2a0c6d1e
  - [3/4] sfc/siena: use kmalloc() to allocate logging buffer
    https://git.kernel.org/netdev/net-next/c/50bfc5eac4cb
  - [4/4] sfc: use kmalloc() to allocate logging buffer
    https://git.kernel.org/netdev/net-next/c/e8cfc70720ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


