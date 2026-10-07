Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBFC367B63;
	Wed,  7 Oct 2026 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338414; cv=none; b=CsNbgttTpDIwxV61O7Ywzc93JBSWfWzZOPBmrR1TTGP/1j5m2oTp9W+QG/Q7/+AkI8xOGF6eP5xYhg1EP84fDCnPJPwmMHoVu2yrdAYarg5cA8pA+CBxDJPOVtgFWm5aZaaZCmvZuM9egg8f/cZynaKSHW5aca7hA7dkT6O7q4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338414; c=relaxed/simple;
	bh=gi/y+TwF++C1z0Vcaw2AI7M0rCakaR3X6h7YqU4Q0TU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s0pdfI0JAL82+R02hqiOQwBXu2ObImETJ6wt+TbTl0hE4o0uRHIBV+aq+QZlQhI+bLxTyIL2Q3G20+9UW7hcESHqS80UOjRo6bi00lGVpFP8Ewz93qWc4mtnLoWvlP8pXlzwD/ztA1cnaMRiXxcH7P4Ji4upj8eYS+n9K1T9rWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxIDX2MC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxIDX2MC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD00B1F0089C;
	Wed,  7 Oct 2026 02:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791338412;
	bh=Q2fydv21AmluA4JaYt0YtWcydZZxhibbgfG0vCj4y+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lxIDX2MCmcr7QCg9pWkHCZ8BvL5AaEX/jpzXupPdf2MEdxuL1wmvGQA1+tGLxhUWo
	 mikx0ZzlV0H3BUPAl6T4jwE9Fs3Zxk+5Pyhn6Um3b8KFzi7NGri8eLt5V+c2Uwx5wp
	 dhRdwWe2cyI+MAbhDebjyzLRR2HcJ89fUeFnxgu0QIRTT3xGqgONYEia7LUZ0uF+ah
	 ZpgpqGML8yG7Q9iiqEPGz9JhsFwggzPjTe48qC7KNvX2WunlNhjWz9gMhAgldkayJ1
	 Kz+5icOj/CVui+xYyFVR8eph0MJet8/w+Vh+GtHoK8f9dmhbO2Mt3rD6bBx0dxVBKC
	 x1Mi7UksGrqDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43853806541;
	Wed,  7 Oct 2026 02:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: devmem: remove net_iov_area base_virtual
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133841127.2870283.3925575192538703161.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 02:00:11 +0000
References: <20261005201822.3060658-1-sdf@fomichev.me>
In-Reply-To: <20261005201822.3060658-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org, horms@kernel.org,
 sdf@fomichev.me, bobbyeshleman@meta.com, almasrymina@google.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Oct 2026 13:18:22 -0700 you wrote:
> Since commit 083e64a3af77 ("net: devmem: replace gen_pool with
> freelist"), a binding has a single net_iov_area covering the whole
> dma-buf, and base_virtual is always 0. Its only reader is
> net_iov_virtual_addr(), where it adds nothing. io_uring zcrx never
> uses it.
> 
> Drop the field and the store, and compute the dma-buf offset from the
> net_iov index alone.
> 
> [...]

Here is the summary with links:
  - [net-next] net: devmem: remove net_iov_area base_virtual
    https://git.kernel.org/netdev/net-next/c/7d3e5984d0fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


