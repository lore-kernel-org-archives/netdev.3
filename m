Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BB3081A2
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790905807; cv=none; b=dpVkpuELzFHzhHd5q3jHTn6likvDJ+X/0L0FbQDOIhs2P9y2cqXjWIUaDjynnG6ZCkRotQST8YjfvTRCdvFT78K2Pb93BuILshnaf0cO478CxvTl+mwvmIVa/DTyXSpgdtIZ29E3BLEHfwkhxLfvtk9a9Y+neqqR8clFJ4oI9kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790905807; c=relaxed/simple;
	bh=zcJU73VMmJf5jQsSde1rtj9Ul8T8ygzfpXBDx8LXsdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HBx9E2IBZn3o1A3LU7CR54I4BycBPOclpoKEDyLAEmyqIDpDOEjsj8ZfBKHvAsrQwfjxLWNCP+rEMmC9slsVyp+z78C+3Wl3MSd9ZiiS0HDNnr++GiHpspP6iqfgDWfcoj8NmWyLx8gjur4Ozch2nDal82sAP5pbO7wcNYEyQMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6NenAEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6NenAEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A65B1F000FF;
	Fri,  2 Oct 2026 01:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790905806;
	bh=gE+wA0VWJUQW9U97Jx+A4oQTEggZmi9DjoGecX+uCf8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b6NenAEjQSShkq5Ta/7p1owYTs1xCNCIbspQ2s+9FXilJRYYNXzj98Bj0zeuJaH3z
	 /ZoI1XWkvVf7Yn2UPab7vrMXzm1tQOF5kt/xva5UXsPv79crqRGm8nEaYLQiesxid9
	 FkC0T+MRfOZbUBEJF1viU7YwC9YsSz4Voa4JAnaoZRMJr7SIcKKMP6hqW44xshyZyu
	 1gwk7s4HRsUWUATSE73eY/aUE4F5ZAw7azxOSHEJPFmsA7RlS9LgkFarCHYHoJ7hjK
	 SufnRmwsJMWQmBqvxfSD03QRuFWu9pfhFV29W/xEshzHWrG8exbRSvmvpfIJVabx+U
	 QJzFsHka396FA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A306381197C;
	Fri,  2 Oct 2026 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ref_tracker: Don't use __GFP_NOFAIL for
 PF_MEMALLOC
 thread.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179090580478.3175897.3150668516679948132.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 01:50:04 +0000
References: <20260930220137.843785-1-kuniyu@google.com>
In-Reply-To: <20260930220137.843785-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, akpm@linux-foundation.org,
 dvyukov@google.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+f95c2f0a71a98cef50eb@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 22:01:34 +0000 you wrote:
> syzbot triggered a warning in __alloc_pages_slowpath(). [0]
> 
> ref_tracker_alloc() uses __GFP_NOFAIL if the passed gfp has
> __GFP_DIRECT_RECLAIM.
> 
> However, cifs_demultiplex_thread() calls memalloc_noreclaim_save()
> and its kthread has PF_MEMALLOC.
> 
> [...]

Here is the summary with links:
  - [v1,net] ref_tracker: Don't use __GFP_NOFAIL for PF_MEMALLOC thread.
    https://git.kernel.org/netdev/net-next/c/071876fd5048

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


