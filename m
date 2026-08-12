Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07022C21E6;
	Wed, 12 Aug 2026 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786496454; cv=none; b=bqHXg+h6bXCLgVa8az2/3Y1KBgTbrzVcKL/hitPghSBnsv44K6TtWtjmPKtwo1b2LVqti3X2365kYJiVZKC+j9u6Hiq5b36MoLkXzR3YFM/DahnpQ7bSTe9M0/LVdWt2fQs2d2o/XiBhvxt5aXpXtuiKQkRO+U7WxUx24a8O8vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786496454; c=relaxed/simple;
	bh=OKbyhL4JIqEtBa7BrdNelSsRvvLXNJUjje+qg+/tbs4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ivuh3Gh4edOoE72hqhwJ/QYgCVApEONQPYG4nl8RucfyZFeSHO7kt9A9b5T74TVYcAVL8HOjXa2kEI10YUyRiSJI6eWazvDO/ZYtWvWyxeU3Wg1mhcRM19sliKDzlkr1mtjuswRMAA4kJPi8MqzW/0y1jGOSLrzZB15XeHjCHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n56mkscl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n56mkscl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D06C1F00A3A;
	Wed, 12 Aug 2026 01:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786496453;
	bh=p28Ye2q90nsyaTefpFlOR3ZDEsCllYRsRxiwdvbFfjg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n56mksclm9CfqMV1PfLBk16f6GCLyDkqmhFDxpdDkIvCCd/JJVP1ECrJT+sO87uWi
	 oqaKGpR08B28r1Z7A6VQHBw8BfqvNkUXnkUCKj7kF4pb+XeXL2Jaf3B5puA4FTIg5G
	 rw+XnFiBuN2tvfBy0bhZUh/Jrx4bhBgmIyYrpxJs6d89ZN4Eeckjn+6wp4NJ1sDOk4
	 etI+G3Qtcnj2BeM9I5QB3mL6tFOQdFKO2mIv9K0Bn2hsEcd0EH2E5yDAgR4l0vYijE
	 ry+JjCGKs4LjXLdEHiLj/rQVj1g4ULwvLccdNunlT81V08h7qNGfd4tYqwiP74PHLz
	 RIFBk4hoJYdmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5691E3809A35;
	Wed, 12 Aug 2026 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: add myself as QCA8K maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178649640888.1219115.15036481843919070243.git-patchwork-notify@kernel.org>
Date: Wed, 12 Aug 2026 01:00:08 +0000
References: <20260810143740.652804-1-ansuelsmth@gmail.com>
In-Reply-To: <20260810143740.652804-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Aug 2026 16:37:05 +0200 you wrote:
> List all the files of the QCA8K DSA Switch driver and add myself as
> maintainer.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)

Here is the summary with links:
  - [net-next] MAINTAINERS: add myself as QCA8K maintainer
    https://git.kernel.org/netdev/net-next/c/6266eeb24fd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


