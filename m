Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BDB1684B0;
	Thu, 24 Sep 2026 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790208077; cv=none; b=fmavZhaLYUM2kZthn8nr6odBrsT38TxXqgm+qScTazekV42l6QLB3kNW/P0ZGD2A3r0OAs+lKclCHJXl+DZIzUxBGKg9lD9FJ05VaQkTTQSS3tdoOgze2KESNT3zj/Oxtl7h8P8GdonMEOTu6z0NutBntC1aHW+W/Y1jL7ptqQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790208077; c=relaxed/simple;
	bh=6DtevpjuCuayKgeR+l/LjobMd85jbp9g0fvqL8T9NLU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WMOa+7/NPDn0mIgopih6Hr48fJpiMUt5di4VO2NtOFAY8SwHgLlqlzLtczWV6JpXap0L3stMuzEGhsg/S99L7y9PY6hvvwCVNbIUOomlBPx5lYMprmEuxp7enaf5zG0EBiMI0lFjrjJu1zgXMXq2TGslasLZPbRKlnGOlLVGkGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRDeDhaq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRDeDhaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7043C1F00893;
	Thu, 24 Sep 2026 00:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790208076;
	bh=CiPUkyPJUJTpWB0Vp/LnjZrVq0jR08HX/2ies2yPGTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eRDeDhaqchWg/WmLArDa6c5cBm+Py5Y/bu8UmAHtMHEvEBe6Hs3i1XqPWq1SQY847
	 JIiAch3QCKw6sqGBw+7vyvjEjj/0DNmnXn2i4I+U4ZxeA3b7Wy1rxYvIV6LX8GWasK
	 3VWjmBBu7mMwgkIz99oJbqfkwkyj7NV0AdgTNcU8cXzpnm9pbOuGwCY6+R+fab6C7U
	 afHFHoeG1b04iIZiYxoZsXl/KIcuqtb9d6IZ0NDqCNYItOLAx0VffUtcrEXMc2pFMd
	 DL96hRuuYjhxkgRAhnMjNNvYfD+44kRkl7NUvIelfTuDu1Q7fBzlRuWUWfeCTKHYSz
	 zoDsTgTV30LEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5688B39E9602;
	Thu, 24 Sep 2026 00:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: add Nicolai Buchwitz as GENET
 maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179020800590.1240300.8400948356928940763.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 00:00:05 +0000
References: <20260922073140.1471858-1-nb@tipi-net.de>
In-Reply-To: <20260922073140.1471858-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, opendmb@gmail.com, florian.fainelli@broadcom.com,
 justin.chen@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 09:31:40 +0200 you wrote:
> I have been contributing to and reviewing the GENET driver for a while
> now. Florian asked if I would like to formalize this commitment, so add
> myself as a maintainer.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] MAINTAINERS: add Nicolai Buchwitz as GENET maintainer
    https://git.kernel.org/netdev/net/c/fdfec06ac1eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


