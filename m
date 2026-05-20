Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E16B29AB02;
	Wed, 20 May 2026 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238796; cv=none; b=aeM6M30QIkky9aZCo9l4qcSHz8YXoyemCKLAchO29Ux0BIDwlqZCSb0jMtAr0dANK3sf/jod6R1+4ZX3f4blKoEXxsr35l/aQLxpCefI+QUMLfU0a2WDEffFUUHj34GJgv+WoBsA+7tZvbwAMUG9HdbGO8aEEz5V6xEBy/PIV+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238796; c=relaxed/simple;
	bh=Gk+zrEidxeyH8/m65U8s2CofRddr5N2qo9NAbJEoFtc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lySeViyEHsz7Cdwg477yvb1JftZouuLtDQYmFJlQj2EioV+cZH46Xglu5aKcJwvPnXR3teMSGxMUBLW2F9SNwHuK+Vn2Wpv3/SEcChRLCbZjHdqfr5MQ7zUgOf5aXRB8gMQUijRc8GtmZmn0VWMmuIZqsxbrNdEX/SRm+wVZdTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3eByz9F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3eByz9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CFA1F000E9;
	Wed, 20 May 2026 00:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779238795;
	bh=LTA03XVNuI2B4/4ZJtJTbBevnemJyRqVpLCixthwgCs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F3eByz9FMv5J+9uICJjxo8nttu3TVFovs/DyLrQtM9EnGBEczlPLkgzHqfwZ3+NAP
	 l/+QsLqMRqzIsjAQT/teKVI4+Nq/hc65mpLMfuEuoEqXDrVm1hIZSPUoEipOaByLWz
	 JK6LpT2TyPGkbdF+fQBMBtVBMuqYgr5Rj5Na+mngxBGOkuC+woVTolwRNzDu0/fenU
	 NJL6RMWF14cb+dqrTJjgWJF059FNDTpfmO59d13EzzuwsiMkjZ7+OvCnQUwC5UuvpG
	 +Ss5/jtDsnGLCoRZnWKnqiuJdM1DLJYW7Daw5RgeC4N6f2auklID0pk4+gTXReJy0k
	 Bpa9uMm5sWDhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197A0383BF53;
	Wed, 20 May 2026 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: avoid double free of pool->stack on AQ
 init
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177923880590.2938085.17920392610827952238.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 01:00:05 +0000
References: <20260515151826.1005397-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260515151826.1005397-1-dawei.feng@seu.edu.cn>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org,
 zilin@seu.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 May 2026 23:18:26 +0800 you wrote:
> otx2_pool_aq_init() frees pool->stack when mailbox sync or retry
> allocation fails, but leaves the pointer unchanged. Later,
> otx2_sq_aura_pool_init() unwinds the partial setup through
> otx2_aura_pool_free(), which frees pool->stack again. The CN20K-specific
> cn20k_pool_aq_init() implementation has the same bug in
> its corresponding error path.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: avoid double free of pool->stack on AQ init failure
    https://git.kernel.org/netdev/net/c/9b244c242bec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


