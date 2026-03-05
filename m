Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA828225791
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671805; cv=none; b=WwuviC0DDObjRM8UfV5mKK68I5W0RvF4+e1/PEY2ajRuB5YzUdmf5lRgM2/tyiLGzc3bxcdxHEG1PN2fiUy++qGSZ9FqAbovnn+J/jWnKIsoUdM1ppC0U87WXw4TtK1ejCm4Iacb2pnmC3wE2Zke3C9IeQwUjzozNrTM8lKulAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671805; c=relaxed/simple;
	bh=ua6IjF5HGGj3OYHOwrGP3n0DY/E8IFcmv1QuaOg3NTg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=On1tP0SSc3ggO6iEqjB4R5VzhK4ehNLopxrT5IWu2+r+4Efzkgro3FKudN1ovcQUBlwsi147gqW44/ogVrAeWJRnlUnaYpepyZHTXog2/NM/kY2+HCYSYS2BE+mlCs+/LrbK026JPnqqT0ZL77YiI7X8I0taaNIF+8zihmlp2z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EC3J9aVE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC3J9aVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2933AC4CEF7;
	Thu,  5 Mar 2026 00:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772671805;
	bh=ua6IjF5HGGj3OYHOwrGP3n0DY/E8IFcmv1QuaOg3NTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EC3J9aVEnKiIeWVv14dqDA0DzoHGN8AK/4eXkggFgO/twHKWzXjLzxIIwrgoqHG4K
	 JGmV/4wP7ny68OSSrR+GdE45kaCtfP8oowZs3NPV7PGEHxZ7BcrE0H4ji+9+5Pp7w2
	 CutbJd4YY2I68aoZ4FRtyuwy8hwhHFDi5KnWfzUA9bTPIrGQ8JrRHAA01w/3gs1OXH
	 juCjXfQ+hYiFO7bSN/K/PZ3If3zbPg6zaaYP2yookZkZyUPHuJS62QvAwbRQRcXMUN
	 scj+dyFpyV7Sg3vnOnOxGl6A0mV2RJxyAaWUzAxtNroDgMbhAhCS4b1nqdrktp/R9F
	 YLp7d3QvsM/2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FDC3808200;
	Thu,  5 Mar 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mailmap: reflect my gmail as default
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267180555.2460379.12027824002247694403.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 00:50:05 +0000
References: <20260303033720.84108-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260303033720.84108-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Mar 2026 11:37:20 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Use my gmail instead so that I can easily handle those emails
> that CC me.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> 
> [...]

Here is the summary with links:
  - [net-next] mailmap: reflect my gmail as default
    https://git.kernel.org/netdev/net/c/18b43bec5437

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


