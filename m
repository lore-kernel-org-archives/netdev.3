Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE62C21DD
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650853; cv=none; b=lnc95aKzZhRqSNdlpy6Y4SeXnTRPJnsqyP8Yp2j8v2Nx5d4QveOU1RP1NvnR+s5tpr+g+oxKeNSPk7e1HuaC/Pjy5M9wbuqF2mVNAI39HdYE30SY2EWI+LscFHyaUkPMFuYb5hOuer2R/nrTHrangKBge7FbA7XWuCX/T+KT868=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650853; c=relaxed/simple;
	bh=U5U5TpUtZAlzQIUOWM3PKtXX5dztQyFbkPM46wvYDFo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sOkoIXATECv/Tc7zgXh6GkndbnleHEgW+b5XUfyWtXuP79DqS5+lXxBCh7XtO7cxH/V7qnAkBLiFqJjvW/SZlHsCVF4p/S2L3VqG5zOn9JzVmIpybRUGSjS+ehsh3v4jNjbtWR8MaNpolVix3gBsWiPZEo1gmUGd/P/+FN1sRTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYkmwIFU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYkmwIFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837461F00A3D;
	Tue, 21 Jul 2026 16:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784650852;
	bh=oTrN+cvFZgvJDDVhXVNsiY2o3rd1JcA+mZxHWB/ZxR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KYkmwIFU31xHWUo4Pj7U3x933mM4OS424iLJx1jqNuq/bSCDZTw4cEEl0cOzxOq07
	 dR6AUAKc6eT4Hcza9gTYnQTHkwTJhzmGoPrR6t0FlexOfHvTS/Wyfl0vkqtFUL+rYo
	 EE5BKWpOJecdwjcuBqTC6Mlqb3dtnXSeCiBdztIL2AVNtts5VEB/f+nEQoO9OiggfS
	 /jREMVIycRtgRx1/Pylj3gisCYYIL18zMhWLwkmN6DkjifhlwzmlxzaXuKo8W/6KHp
	 dDoyhYoVTdDnVjtAj1RvBHpvbQ3cikZWh1f8RyAVQ1Wn8H8MDxm1tNcYovA8Ph42MK
	 uNmJE7dISzUgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568FC3924FFE;
	Tue, 21 Jul 2026 16:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/tcp: Prevent inlining tcp_syn_ack_timeout()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178465082188.386198.1103713176802997297.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 16:20:21 +0000
References: <20260708180837.9507-1-emil@etsalapatis.com>
In-Reply-To: <20260708180837.9507-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Jul 2026 14:08:37 -0400 you wrote:
> The tcp_syn_ack_timeout() function gets inlined by Clang,
> preventing tracing. Since the call is not in the fast
> path, prevent it from being inlined.
> 
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  net/ipv4/tcp_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net/tcp: Prevent inlining tcp_syn_ack_timeout()
    https://git.kernel.org/netdev/net-next/c/d05338c1290e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


