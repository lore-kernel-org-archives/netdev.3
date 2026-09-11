Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F39131E84F;
	Fri, 11 Sep 2026 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089071; cv=none; b=NaQSOF19JmHyAjxgYoB4kpdIR53YPDptt7BPhBvhuZEiCyzaa9gOHY6v+B7fugRM4REuJVR5dasDZNDKDNSgXydy4wjxhLSrMtsDKEqS/1Ue+QhpKZ95VEBe8MaNUhm7hAHXPuPr2Jze1GXxuWAHZq3Swm9x8uzDqOTF8DfDxFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089071; c=relaxed/simple;
	bh=FV6CEht3ctDd2lb8SyspeDnonzEZu/ro5gvpTMjEusw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RM7Zl9RcXHxQASDoryzQoL84rSqpjENVQ5y7XOHvKUjjyLnP0m0sITm16EmWo4ZYBX64ZYqNJ2NvuGhCPI3LdjYfZTqYWd4+72egvQgOv8RIWuQipWPRGzDdQauF55pua+/vp28nVn9T6J86lilvbBc0Fv8zrWaxtaCAF50sCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqtZiQzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqtZiQzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6671F000FF;
	Fri, 11 Sep 2026 01:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089070;
	bh=VXOGle0kbcp9gDSOrpjEwexfVq9elnJ3jsD11Yfhgdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TqtZiQzd5s5o0hg4Q3qs5M+ztPF0MurzkpDXuhYPe7SY3Vcs7MRtfQr8rRQHQLEyd
	 AT09ksw8+X2/CkxT+LBAecAE9Wca0U2Q9zeKBy/ZtHazPyoC0IGBhuDyVx1kW1yPH2
	 Oe2gMa+JyOnCHQxmDfHI04pLDuHRuC1weLnquzzrmdA08/2CUFf5H8H8KqHuj6fZ5+
	 jc0jSSD5o87DAxlm8kHBqFFKYCQMiEuWG4KiBuuOV6r9T60LpyR69DiqTXtCxcp9u1
	 CONwH+L7S6zk+L4mqtzZFvE9u6E1slSNUuVSpdhTCsc8M5xSEnF3tQ2395qNsIZavx
	 gGYiHxzQv2Gew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BD33810901;
	Fri, 11 Sep 2026 01:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: davicom: Propagate wakeup IRQ errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178908900738.2170035.4609640246303136729.git-patchwork-notify@kernel.org>
Date: Fri, 11 Sep 2026 01:10:07 +0000
References: <20260909045738.16705-1-phucduc.bui@gmail.com>
In-Reply-To: <20260909045738.16705-1-phucduc.bui@gmail.com>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Sep 2026 11:57:37 +0700 you wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> The wakeup IRQ is optional, but errors from platform_get_irq_optional()
> are currently ignored. Propagate errors from the IRQ lookup, except
> -ENXIO which indicates that the optional IRQ is not available.
> 
> Found by manual code inspection.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: davicom: Propagate wakeup IRQ errors
    https://git.kernel.org/netdev/net-next/c/75a73afd0b32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


