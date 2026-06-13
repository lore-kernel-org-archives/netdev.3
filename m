Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0C437754B;
	Sat, 13 Jun 2026 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781372413; cv=none; b=AJ87a8wkqSNijPZ3HBxJfwo1q0rx3+J2g8Iebs51Fz00HIXAD7YpnzwXdjF6nb89E/3P3RvPi2ysZvwcoclRRT8wmUOP4EICaw6ySFlUgVq4IFWRmlQX4uq0ZP+DtYU/w7P9st1b2SbJKn+1drCjH4ioZeFTdcpCOzUixi9/gYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781372413; c=relaxed/simple;
	bh=fzQPIo98WSnq26pReN4v5u50b9hBGmFpyw8maQQp56Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W9bNP35O9ZIlLnoUqBOl8wwAafcvwgCSPiigortlnqC0AtaSHKfsUPx0VfB4gfeL6hCJrax4+k2X3HwdNxKB4+jxFIuPabN4TAIF50KdxUBo4LQJuTXhqzJM44vWxW52Hyl4xAlJrRI1baY0LXbA7exdXuA6ycZqFcqpdZU5xBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5nISUYz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5nISUYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD261F000E9;
	Sat, 13 Jun 2026 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781372411;
	bh=T3uZ1HbtmwQRUr0m+28geuRxV82rDzniNv37pQNQxcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=V5nISUYzBwP7FQgie6Jwt29LO5qARjY7jUphgrieeIyCqYXyzKOKQLPUa3WJcoDzb
	 wz887WMGEcU8pSi/U3aeHKgLgxdBCmGk493UAb8JVhP5thH4gfINqH6VQD0wdtjLiQ
	 OivjkcbEKLoGVFAuvcEHn5ZWnAJgVxFavJDAeUkoefGHqM5ZN1L0ArFs2m0fP16TiW
	 Ypg30IVLMY242hJu8MltgHVc+YS5bBR9oRLQZK4AENTxEUkcwUgOJvYqXP4jDn8f97
	 SvDnMv/j5STHdDRAkjj7ZuYjUOsU7W11rTB3BbwWVdI6h25uXbQssOA5Ck7VF81P+n
	 8Kq7oPKFo4RgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568523A40FD9;
	Sat, 13 Jun 2026 17:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_wed: debugfs: correct index in
 wed_amsdu_show()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178137240791.1545867.1744302590783011291.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 17:40:07 +0000
References: <20260612064501.203058-1-guanwentao@uniontech.com>
In-Reply-To: <20260612064501.203058-1-guanwentao@uniontech.com>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: lorenzo@kernel.org, nbd@nbd.name, sujuan.chen@mediatek.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 niecheng1@uniontech.com, zhanjun@uniontech.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 14:45:01 +0800 you wrote:
> WED_MON_AMSDU_ENG_CNT point to different entry by 'base+n*offect' mode,
> correct the wed amsdu entry number in wed_amsdu_show().
> 
> Fixes: 3f3de094e8342 ("net: ethernet: mtk_wed: debugfs: add WED 3.0 debugfs entries")
> Assisted-by: Copilot:gpt-5.2
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mtk_wed: debugfs: correct index in wed_amsdu_show()
    https://git.kernel.org/netdev/net/c/14a8bc41ce9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


