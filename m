Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AFB2E0914;
	Fri,  2 Oct 2026 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790901013; cv=none; b=bT9vKVw0HAlncPfkB+O5N/miFxnCW+CklNuIj0Px76MEKVIB0blZ/CVugp15MIrAaJka/t5lpntbWL8l234zU5Yl3DgLacuwvC3dd9Y/I9rfjCXRboKk27edTaCCiU7adDsi6Wpe/jqEAlX7FspUzy2FGAiDbTny56dpeGWKQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790901013; c=relaxed/simple;
	bh=pI6o4VOS3YGxq7ywoeUfwv6pCSePYDn3T8LRbqDAN5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=krIyyXjpX8K6QLnfGvA9n3DxRaCazhVkeN3qXOof0GW4cyr8MLGonZGcrVCGbLxG8fvaBI8ELhEsRn+2hS92ebYWIc4rtH0E55zsrtd/FO3kwRfXZl9+esb6++ENJSJWRtfwU2ieQ5NJ0UABIHsolKCoaZsCYF4LRkXS/VDkkB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VybcHzic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VybcHzic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F901F000FF;
	Fri,  2 Oct 2026 00:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790901009;
	bh=JwCvtX86Ucbr3R4a/HgZuNF3ZxFuBjiEpsEifY6gmhc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VybcHzicfjtPVwrfwbbg9hQTCE3b1butqlbiWSEeX8xeonh+TmYrGdEZEv6MkmyaC
	 4BS/ETkHdjZmKyhM9ZB3gjEEBJa2Dpl2eQVFk85aFZsj2arbhnKSQQ7U6rMBDSssZ4
	 O0A2+MgRytkZdTgyZIr5y6qpV1G+JbcXgIgYcAEPaLtcD4bsLPH0zi5733T3ajtrk6
	 1MIfnJrxvkXXgibrLmdXLHzMHmldvPJ0KDdao2suVnx1S2LxoTqmK65SdeAzrLUC5I
	 PtzaYtW16YwcXqh2Z7+5dK/YPLLBeg3ENxHUEZVbd92XVWN+icU3vQm/jfG0RcnZOI
	 oYxKsS6t9w0fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773F5381197C;
	Fri,  2 Oct 2026 00:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: asix: remove redundant PHY address
 short-read check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179090100827.3156447.5003274645282264888.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 00:30:08 +0000
References: <20260928192119.73351-1-xinsheng.zhu.ny@gmail.com>
In-Reply-To: <20260928192119.73351-1-xinsheng.zhu.ny@gmail.com>
To: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 15:21:19 -0400 you wrote:
> Short-read handling was added to asix_read_cmd() by commit
> 920a9fa27e78 ("net: asix: add proper error handling of usb read errors").
> The helper converts short reads to -ENODATA while preserving negative
> errors from the underlying USB read operation.
> 
> Remove the redundant short-read check in asix_read_phy_addr()
> and its unreachable -EIO assignment. The existing negative-return check
> handles both short reads and underlying USB read errors.
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: asix: remove redundant PHY address short-read check
    https://git.kernel.org/netdev/net-next/c/264f8ac8ec51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


