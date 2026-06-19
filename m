Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF5A25B0A8;
	Fri, 19 Jun 2026 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830815; cv=none; b=caXefv7Vk/nOVP9igAl45Ai7i2ptyEPfd2M610jrdo7ya4oWw8pJqtLxkPpik5UZElOWutyg2QoioxVtuMUxCg0h0lrWe+TP6ezLjXJ3Px+mXnRLbl1juWU8szPEJltCKuG8bfjvbRsNQIEOMVR7E+KlGTK00te2yonYwD1YgyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830815; c=relaxed/simple;
	bh=4I1wa3nVucRz0wkrxlZ8D1EhAcarpsQJmiNAC6P1xw0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZsKjsY2ztpfSkafZbPkQ+6jQSTw66McAVfGhEWTeIf4L9++OYKI3q7LNrPAMEqDwWGMgr1TvIYZSGiSowRIw4kofe5mb6ajvKjLyOVpyAPPmOMfq6wGxKh+8r3bqFTPLk0BIooZWsveMa+HwppMl3RG2yLy6QYMqH+ulvH0kkrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFIU2f5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFIU2f5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F021F00A3A;
	Fri, 19 Jun 2026 01:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830814;
	bh=535b70SMz1t0ZNueM+mbvXHgUvWYCp5y2Bnb1lN+Mp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mFIU2f5qPwDVU+cE0khAk6u8ijVQmILihc+piGkId5xHBV4zlh4XpN4DUymCw9HdI
	 U2DRDEujZtXGX4SVuGj6niCk+lrJ4w1tDCp5YWBe7rx6biljd8jp02Pjq3ZrapST9W
	 muiOltSB+l6If48AHhb1ag3senE1yfYSa1nuOezUaTqCQzAvOZVVNguGEhnbnMjioR
	 Dhk+paX3SO5QJ/nOMnUN4rTLnQa2MmcyLDdESmNEZKSZODPj4rd0d+7mzrBSlFR0/r
	 gr3G5ftfsSVHE66Z3/SrQAZb2koD2l7Ova1bl4Pvn9ZatetbR2jtzFdlA4c2vCknqN
	 +8CPets1BCntA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939793A78A7C;
	Fri, 19 Jun 2026 01:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: llc: make empty have static storage duration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183080714.3146201.2416381470086210541.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:00:07 +0000
References: <20260616064053.690154-1-guanwentao@uniontech.com>
In-Reply-To: <20260616064053.690154-1-guanwentao@uniontech.com>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: kuba@kernel.org, joel.granados@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhanjun@uniontech.com, niecheng1@uniontech.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 14:40:53 +0800 you wrote:
> Make empty have static storage duration (like net/sysctl_net.c does) to
> avoid a potential use-after-return and keep consistent with
> __register_sysctl_table @table 'should not be free'd after registration'.
> 
> Fixes: 73dbd8cf7947 ("net: Remove ctl_table sentinel elements from several networking subsystems")
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> 
> [...]

Here is the summary with links:
  - [net] net: llc: make empty have static storage duration
    https://git.kernel.org/netdev/net/c/d31deeab707b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


