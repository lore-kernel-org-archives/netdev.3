Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84772D5923
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779933013; cv=none; b=iQkCUTpo2SZnlQ8n+OOgFYZnCV//Pf6d/eK311c7UBU4bGcXo998XJyYRKCLquNsaJ0vkiu/MepzYXU1meG1sjIKXm2wOlgu2UtMY5qGILjREm/CedfVYFu/be3fe0hATfENshmqlfF6B2Zl/kgA+JM2G0LF1Cwp8UuIilrvrh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779933013; c=relaxed/simple;
	bh=90veYhT5BqQrpc16wdSLH2YccdgNva3JfNv3yYGmf2c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tn8FrHErj+G8RXeu+6zxPlWZJXZh5qeYgE2H+mq/76k6SOJG+SQf4qCHOr7u/GTta+7lBR/bWfnb4Xq6kCtb5VAL+dGvr9S2/snsUHc+KmWPbVXuJQ2WBVBIJ6GTMPi6ph45SQMqAYA29ZpNyKe87bYggZMELcROows4s7B1f20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc4Etgv1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc4Etgv1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706981F00A3A;
	Thu, 28 May 2026 01:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779933012;
	bh=iGj/750PFY6Fc6uPtVsEOFyVGA0dzzJg7UXa+qrjgEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jc4Etgv1lxqnsXN0cEVgNjzM11KzZ+cqY0oRJc7FbHYJuG2hvTPED4eV6MiFyirCB
	 ACP3wjbvh//cBJbKkgOWTIEc6tlsmcnv3CgU/Lm5sN7nJiWOQ4FaiKaPeuU81emr/u
	 znzgksnvLlsQ4JU84SmFHJujbCypwcM8ghACot/eqnVCGPTxqV/r/LCH5IFHRfHiLT
	 lvlVyqgMpTUKmhIE7TQGBwoGIWs4gXbFGaXzsUy+n4TMCwxck5/fTxueI1Tk41uMnZ
	 r9kb/I8fOpr01W8ba9uD7X3psPR4Q95jRD629cu0U0iAi2X3U+qpetKlG2Wg4qTdjY
	 PD6Jutcmkk82g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C1E380CFEF;
	Thu, 28 May 2026 01:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net_sched: sch_fq: update flow delivery time on
 earlier EDT packet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177993301714.711996.14192307099648562972.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 01:50:17 +0000
References: <20260526134109.2624493-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260526134109.2624493-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 09:40:37 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> When inserting an EDT packet with time before flow->time_next_packet,
> update the flow and possibly queue next delivery time.
> 
> Reinsert the flow into the q->delayed rb-tree to position correctly
> and to have fq_check_throttled set wake-up at the right next time.
> 
> [...]

Here is the summary with links:
  - [net-next] net_sched: sch_fq: update flow delivery time on earlier EDT packet
    https://git.kernel.org/netdev/net-next/c/fabcf8cad67b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


