Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE98368D47;
	Sat, 22 Aug 2026 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428878; cv=none; b=UeVs+Dmre/hNsmfMTBvc/spPvyp7OCJlV4crf/DpVGbTCYhpo/hx0CsadW90tcqE9dbzmiJSUVwkk7+DOmdBCr4qbFdhPTW/NJkSJ1kcxR1oQZXwLXSFecMlof99o0nxAh25GwEr1WAaDgwmMPP5EI/PleOM9pGvFyhn9QMt82o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428878; c=relaxed/simple;
	bh=PfV5pKYAlA10wY04ezr3lQGReR/SeEKEqz/0oRWUUQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BAWCIIu/R9aVOCnYuMqL+ocGwYgFurCFJqZ3y0LU37OuJg+cELa9F1U7SJCCG79nB+/Yqxag3br9ROIt91tQ0wuoGRuc6jaLQ5xJos8XXYQtI5sBfa4BS4Ma4BclOBNliKE0tIQCERhAL5C6I7v/TJZrMkJ3JSPpcUmNPYPKeEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiqH8v0Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiqH8v0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA86D1F000E9;
	Sat, 22 Aug 2026 20:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787428875;
	bh=kq4p13CMxVGsbry+FZF0jHxnmqEwXWsnzFddzfnWCUw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZiqH8v0Y+4uuJt29jTGL17+DE9yMcZQ21KZL90C1sWCkgq2wGWbWznDpRssKlALx1
	 PWmBajrISyI6n/IiRVWUP5SP0eWVonMj5/lU5rnjfGkrs1rIaGtl603sQJsaY+vAkt
	 +AOnkUtdXTqjaZ7F5fQQduvXe9LLlEfNCYlrcRxN7cW+/b/hmoyZLuwnCjppHHvwuI
	 mDGV5KKnMFN++bWcwxk2fNHHV92Yy+v3iulkC8/hYFzkbWJR2fXjPYXpvnRDaVj+dr
	 4cSQs67SWzOWxAS+RPjyXXk/0HVpPX3UsOQ7LeUOV36Rn7A5QaTnXiNzDwOgZDaVlK
	 dUvbLFKrpbSGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09FE380CEF9;
	Sat, 22 Aug 2026 20:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bnxt_en: Gate TPH enablement behind
 BNXT_SUPPORTS_QUEUE_API check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178742882438.1812309.1073620495883535958.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:00:24 +0000
References: <20260820220544.1240879-1-thwalsh@redhat.com>
In-Reply-To: <20260820220544.1240879-1-thwalsh@redhat.com>
To: Thomas Walsh <thwalsh@redhat.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mschmidt@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Aug 2026 18:05:44 -0400 you wrote:
> In bnxt_request_irq(), pcie_enable_tph() is called unconditionally to
> enable PCIe TPH when setting up interrupts.
> 
> If the NIC hardware or firmware capabilities do not support queue ops,
> attempting to enable TPH during bnxt_request_irq() is unnecessary.
> 
> As a result a flood of "RX queue restart failed: err=-95"  messages is
> seen upon boot.
> 
> [...]

Here is the summary with links:
  - [net,v2] bnxt_en: Gate TPH enablement behind BNXT_SUPPORTS_QUEUE_API check
    https://git.kernel.org/netdev/net/c/a70859cf3121

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


