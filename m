Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900BF380FF5;
	Mon, 25 May 2026 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779739202; cv=none; b=cLGO03ZIhDPipb9ALpZL83cOeslBtyTYDYSgg4RvqLMr4ej8dPxBrRByVFWyIkPgigbO2xdj11GxbHcibHlClRiuhuyVRN5ckIuRz841Kgm6Z6RePg2OBden9Y2Kcm4ig3RbruvT3wltLG0EMeIE2bR4u3ephj4vd6A7886G6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779739202; c=relaxed/simple;
	bh=XfugHMtoteLUf1jfOy5qYNF39eNRFoCQmlpPThwVtz4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rYEhqFBvK2HEiPSYmWBdxmVTZMEv2Irly1gE31Q/HirnrpaN8exVANHRBCpgznKH/Acz3/Vkh7o0Q+puoaHiGXy9pXj/n6uFAAl4Oz6QJ4Mu6iXiOTNHYD5Zdg8gP/UpKvJ4UflbofmyiND5oyGWlJROA8Ja4apMZOZlg31oBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKsOwsUt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKsOwsUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAADD1F000E9;
	Mon, 25 May 2026 20:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779739200;
	bh=yvIC2rcF8NcBf/siqsXskmGdnEzTxPW8jZ4XUKTfVaQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FKsOwsUtB9kv75zUZwjCYBBVHT/PzCdvftxFfs9fxg94mi7fJ/IPil5ryqfnHVozl
	 CldZjrXMYmBgmeujcSViIaCbSHeVDo/ud4Mj2SlD8iLI7Oj1LTh3M/zo1mk8Qn+fkM
	 TytbWiA+YucpPlsLdq+0hzkZOWZOim6vDZFXQZnJ/Zh166wDeHJfnYjB84VPgU6viJ
	 AT0p0ZFajwe69HnbRAzIkaUXOwwgG4BWcLyyO60rTR0JIdOaydUyeBFQEX/3vKNFiN
	 3F8s1PdcjDPR1jrYXuUUiyAdAXJNfOUsJCeax5VniQcYF0tPcS1kSwlbYEk4mQ7wMy
	 cwFQ2NFaLjUTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C6C380AA76;
	Mon, 25 May 2026 20:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: validate body pcifunc in
 rvu_mbox_handler_rep_event_notify
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177973920715.3098866.6475333748941191821.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 20:00:07 +0000
References: <20260520154157.1439319-1-michael.bommarito@gmail.com>
In-Reply-To: <20260520154157.1439319-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 11:41:57 -0400 you wrote:
> rvu_mbox_handler_rep_event_notify() in drivers/net/ethernet/marvell/
> octeontx2/af/rvu_rep.c queues a sender-controlled REP_EVENT_NOTIFY
> request body verbatim, and rvu_rep_up_notify() then forwards
> event->pcifunc (the nested body field, distinct from the
> AF-normalised header pcifunc) into rvu_get_pfvf(), rvu_get_pf() and
> the AF->PF mailbox device index without any bounds check.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: validate body pcifunc in rvu_mbox_handler_rep_event_notify
    https://git.kernel.org/netdev/net/c/2156a29aecff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


