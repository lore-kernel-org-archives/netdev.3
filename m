Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF4A95E;
	Sat, 26 Sep 2026 00:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790380882; cv=none; b=YoB4E+xRIw+Nmc0qgojg5/ve2PmqxaR0Oabt9u8mKxc9QEBNXUjNCOc1lyfauplL9+QIvipvXm+MXAIqr3SWsfKgZ+1yZvytCMcOUtNTWNZ0BUNdMb32ZKKtWHXKa7zLzmW5HughfqJbHY7v26sFOrystEU1pW8XH6VPEaQCCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790380882; c=relaxed/simple;
	bh=WzRn5L8M2tTkvJFwcw1/BNdm59Z1MZcC63p8OsOOwOQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rzgBhIZWDlnpObTxOyj6HDUhZ9z1+MUmUNgRB1/fMABX+T6TGVk4u9E7OzqJsekxoY/fTHqeXxRCDdYNcqlrJI8x47bm6NuhwaQlrvgrEPAUO4M+gzzSZqjwU/WpqGHhjgaX1yuVJjM3AeiPXXTi2O25zST4FTi06oi3bg1M5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9iAgW0i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9iAgW0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5311F000FF;
	Sat, 26 Sep 2026 00:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790380880;
	bh=fdh2NH+Rdb8U6WLIUirE+fmL7OPmHpkOcF+Z6jXXj+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l9iAgW0iGF8rG9w3hXeQjZK/JPnvBAhAFw7oe3uR2s2jqim+NASui8CWDdtlW1q2k
	 gblbrrA4yFvjUE9LtiW8QBh+epdedbr5Plu0ZJepHNMTWHn08Kbp66KVp0u0Oktm/R
	 xPt/TYRWxoiTn2kKdtIJWA+BNk3uPXIJBNqifYmwSc/nor4CoG4QfIL+DlruUFOXkC
	 ZPB6OV6IYeA/LCEgy3nYs09me5tAdfAOFALIbv1vA8puMGvBvAGeHUFJoOnytBri13
	 aEDYRzbs4mA273rGQCOrImEnlWJ5WfgeiAOm87RcKplWT2AeLm8OsW/GBezwq9ar+j
	 Kw1sKagec7A0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938973809A04;
	Sat, 26 Sep 2026 00:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] ptp: idt82p33: Stop PTP work producers before teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038080814.3212797.11225200642127710918.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 00:00:08 +0000
References: <20260922113601.855416-1-lhfff@tju.edu.cn>
In-Reply-To: <20260922113601.855416-1-lhfff@tju.edu.cn>
To: Yibo Tan <lhfff@tju.edu.cn>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 19:36:01 +0800 you wrote:
> idt82p33_ptp_clock_unregister_all() cancels each channel's adjtime work
> before unregistering its PTP clock. An adjustment callback already in
> progress can schedule that work after cancellation returns. Device
> removal then frees the channel while its delayed work remains queued,
> causing a use-after-free.
> 
> Mark the device as stopping under its lock before draining work. Reject
> new adjustment and EXTS requests, clear the EXTS polling mask, and
> synchronously drain the EXTS and channel adjustment work before the
> device storage is released.
> 
> [...]

Here is the summary with links:
  - [v1] ptp: idt82p33: Stop PTP work producers before teardown
    https://git.kernel.org/netdev/net-next/c/a529f9258da5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


