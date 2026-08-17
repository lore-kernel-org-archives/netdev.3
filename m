Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983BD4508EB;
	Mon, 17 Aug 2026 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786995994; cv=none; b=ER4BiCBTCSZ2P4cqbQx/sgSBI4WWjBssupHy+fC6tJWUhQb/AJcx+2QY6lGr3vG++i6WeF9o+9mTU/easC9ttRqZjvgrX5TKjS3zzfLZaqM9e11msOtNYEtlyRqg12l3TYE595RbwkIT904+YRkS0YJudA+iIzXNJqNWLgasd+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786995994; c=relaxed/simple;
	bh=5c7Kz5IVDTMyowuHcQWRFOiQuKLo7h+oV9J4XhSphYk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GpXr5zk1CImNXbchaADEWS4jc3/z1eLWHrq5ROYvASLguVH+xyxydhCNGzSPqu7cpZi2b+WYQW8CKWdqFPK4rb9W7K2ijLvndp0no2bIK61V69IbiWfL+X/gNa60b+vwkyfJsACPN0IWN2jNG2fftGvRd40nvAON1rxVB5nSkq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0aaEWA5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0aaEWA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344FB1F000E9;
	Mon, 17 Aug 2026 19:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786995993;
	bh=rC3ojWjRTAGHa8x24vX7L5+ymmd2bYBAPv1gjlgJgtI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q0aaEWA5uDcfS/ZDTCNEbayyds5SGDeTo4L32W0MkCjKeRtdQon5wIYuxJMLl+Seh
	 EqFqFYAL0/5UF0zBhGxbJRYTrn10ey8YP+MQptPbA8UkLS0pjQ/pSxjeWkuFNEO3nZ
	 5GXSHupdGUYc6rA9l9lVBIMp3BHKfl7iNwwINhNk+Ds2YLLW18E7FoDjRurBL2AVxX
	 DDCceOyR5fg1GZu5n+NOFq+3T56qW7W+64z/pM9qLYuGgQrFjt0noJGumdJrRtZew/
	 ZtYRr/hc2movcNeedgKjaavO+pJrzRBjy9YcDpS7JK6FiiN7AXzNhVj4Mlk7xeNtfr
	 CX50EZhiNg+qQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9389F3926262;
	Mon, 17 Aug 2026 19:45:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] psp: use unrcu_pointer() for the cmpxchg() on netdev
 psp_dev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699594513.1691257.13576000456370210344.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:45:45 +0000
References: <20260813193416.1544518-1-weibunny.kernel@gmail.com>
In-Reply-To: <20260813193416.1544518-1-weibunny.kernel@gmail.com>
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: daniel.zahka@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, weibunny@fb.com, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Aug 2026 12:34:16 -0700 you wrote:
> From: Wei Wang <weibunny@fb.com>
> 
> sparse reports:
> 
>   net/psp/psp_nl.c:513:13: sparse: sparse: cast removes address space
>   '__rcu' of expression
> 
> [...]

Here is the summary with links:
  - [net] psp: use unrcu_pointer() for the cmpxchg() on netdev psp_dev
    https://git.kernel.org/netdev/net-next/c/97a1e65df7ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


