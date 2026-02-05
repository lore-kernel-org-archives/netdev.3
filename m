Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E7757C9F
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 04:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770267014; cv=none; b=FUJmjE+I/bntUbFYbVa/TunnS/7xJ5yYYZSIxai4lbLZb+yN3anDzjYe1Gje89IKQ8GTYNBDx4dFzkxlVDglupOy/BOuk2Thz8mKh4Bd3W81imaVxIciELX78ep01H0oQVMcPK22HW0LRsD6DxSv+BUrQHI+IR9Do+IUL8cjYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770267014; c=relaxed/simple;
	bh=vF9KCmzMTiOaVCjfOtMDvD5uDabJ/xhhHBYfP1utGnQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JfnugLphpuVpxT0JuWbEBmMZXt32dd6Ijpz/wLS+hQBCfXk1v2hE/oto4HQMHwe7N0fZQi16t2A01GtCr//r3loccH+B6U15M2AI7EOS1l7YrizUlt0TE2QoLpUoUjaTadE88x3/FpRS64j9rvuV4OVY6VkDp2KLVm68wmRbvhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WflnQUrF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WflnQUrF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EC1C116D0;
	Thu,  5 Feb 2026 04:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770267014;
	bh=vF9KCmzMTiOaVCjfOtMDvD5uDabJ/xhhHBYfP1utGnQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WflnQUrFjdJDokFupuxP+MewzoptN6wuaZY+0FObn5Erf6nk0tHHtW5Rr1caEiK0c
	 4Ussle8BmxpS2ToDTl7Yioop1QigsPrjRiWeS513IiZn/Hnf8QYiJyI0/Yt4dAnR+0
	 uL2wkcpc/0MLZw2X3rkwWu0wO5md2xv1p3wIFoEhIG4FYv1diBl/39oOn2CRw5StNx
	 qUKcKiz/3IbDHNamjtAeuNfMS1ekCRZpVYzHI2YjkD0233f3g0Mm6JJDVTWYvB0r9a
	 rSSdNNObK7QmEcDXz3iCrGd6pxwWeLAhR0zDyPyN+omBAGrZB04fhrd6fVd3W/DPgN
	 eGi6sxaP8WGhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 483BA3808200;
	Thu,  5 Feb 2026 04:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: move tcp_rbtree_insert() to tcp_output.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177026701208.165764.18371893962289031802.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 04:50:12 +0000
References: <20260203045110.3499713-1-edumazet@google.com>
In-Reply-To: <20260203045110.3499713-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Feb 2026 04:51:10 +0000 you wrote:
> tcp_rbtree_insert() is primarily used from tcp_output.c
> In tcp_input.c, only (slow path) tcp_collapse() uses it.
> 
> Move it to tcp_output.c to allow its (auto)inlining to improve
> TCP tx fast path.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 4/1 up/down: 445/-115 (330)
> Function                                     old     new   delta
> tcp_connect                                 4277    4478    +201
> tcp_event_new_data_sent                      162     248     +86
> tcp_send_synack                              780     862     +82
> tcp_fragment                                1185    1261     +76
> tcp_collapse                                1524    1409    -115
> Total: Before=24896043, After=24896373, chg +0.00%
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: move tcp_rbtree_insert() to tcp_output.c
    https://git.kernel.org/netdev/net-next/c/7c1db78ff75f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


