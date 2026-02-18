Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85645270ED7;
	Wed, 18 Feb 2026 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771378813; cv=none; b=URJ/oy+PBP37xxcavHL4cKozy6Vbrbwqepuo00ZuvW/fHDBEDliYNV/nEEGDmyibIOj/e80nImzaV+mwUVkLCg0wVFVPhnq3hbngDnwZWwYi2fEH994h7wxt/AUrbD1RC1mK73LoQtZH+zpNK1GseShKe2naoNX8otDko3tBl+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771378813; c=relaxed/simple;
	bh=xDMU6xe/gvXUM3uzPRrZLpCMCm6eyCNOCpnh6A8pi5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hfoVpGtVrxBKu3STgSlIlogRV7lDfG1UhEFFMpgwSU+KVxmaK5kxDQKuv+bcGD1DXVhv/QWUFjkQHkhgPFQZqQEEGd0folE2UiW+gVxgcXFzHFjYmnjlzjUqP5H6odCidJ9G6tFMkBMQEtMQx7xnAl1T16DtqMuOPa7Db8zG0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGRMRqbE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGRMRqbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CF8C4CEF7;
	Wed, 18 Feb 2026 01:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771378813;
	bh=xDMU6xe/gvXUM3uzPRrZLpCMCm6eyCNOCpnh6A8pi5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oGRMRqbE254X1+qUOH7KhyxoqW9Qm7Lg0haDcH4a/nlPxiINkKPbQDVXAHv7KOAzs
	 glUBsGVrtMlzBgJS8sKEXaWAJnOL3kXwBqs8aUKJapOklVPF2Y6+4GrAniWKodJJji
	 Laah9biJn2N6rZrJU1PwmNnsimUf/L9e5m2PzBtW4A2Oi/qAodxHcYv2kdeUBdXXt2
	 pIhEZ5EDTmzPeKxv7/LEcmeqUGq/qk4rGfguQuk5NzREJXRoeq3H9E+fAD1NROqwAW
	 ArG0bQQ5Qwg3bm0K7L/t1HrJe706RS+MipqvVGCUEFCwQTwr5yS/3/Va1Tr3QEOtr4
	 RCIek0HXxtJsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 482333806667;
	Wed, 18 Feb 2026 01:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/sched: act_skbedit: fix divide-by-zero in
 tcf_skbedit_hash()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137880508.770724.8992862496888446687.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:40:05 +0000
References: <20260213175948.1505257-1-cnitlrt@gmail.com>
In-Reply-To: <20260213175948.1505257-1-cnitlrt@gmail.com>
To: Ruitong Liu <cnitlrt@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, L0x1c3r@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Feb 2026 01:59:48 +0800 you wrote:
> Commit 38a6f0865796 ("net: sched: support hash selecting tx queue")
> added SKBEDIT_F_TXQ_SKBHASH support. The inclusive range size is
> computed as:
> 
> mapping_mod = queue_mapping_max - queue_mapping + 1;
> 
> The range size can be 65536 when the requested range covers all possible
> u16 queue IDs (e.g. queue_mapping=0 and queue_mapping_max=U16_MAX).
> That value cannot be represented in a u16 and previously wrapped to 0,
> so tcf_skbedit_hash() could trigger a divide-by-zero:
> 
> [...]

Here is the summary with links:
  - [v3] net/sched: act_skbedit: fix divide-by-zero in tcf_skbedit_hash()
    https://git.kernel.org/netdev/net/c/be054cc66f73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


