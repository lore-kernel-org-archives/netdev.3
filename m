Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9D823ABBE;
	Sat, 19 Sep 2026 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857075; cv=none; b=TNnGaFHPZhzJ8kHZ5HtgKgaBB2CfUZ+YdHFTV7HY01K2AtPgyhdKR7so+BU1L2MPXUadv81KTHn/os1EiPH7bJ0PNmnU20onZVx/INY6ONCYenYa963H2yzwxMsyx4h+5TGJcg3JLpFTkYzdXfP4OyzsCUZU1q3q7FM5fA/3pWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857075; c=relaxed/simple;
	bh=zvN7KZxk6J0poWVjKI0NFjEsVL4d46kYfYVIIWasHRY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IXbE/3BJqemaFgOjlDaeNu0z9pqZeptIdbKolH4Cr9WNAn5OusjT+vsvUsqB8pPCXyo4JvMfzlgs+j/puCMFR3upTY9dCaLPd/q1IlGWODK9Zykp4wc/RKDVhYlvGyTmDe3AI6xOWDv3HJkP1UsZFMMLBYo1q20cdyqpQw1gP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZ1cdCO4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ1cdCO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216371F000FF;
	Sat, 19 Sep 2026 22:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789857074;
	bh=x3+m5Tu4HlQdWcbanmYHcPpM7UkwtvHzxe23bG7eP18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HZ1cdCO4iOaPu9FQuW1SILCEx68HeSDkz01FzfzybHfnqxd70pDKaY9mCNZ6ThwKW
	 OH2/MYrUJiw9wF1A32GQ+FVsprYAPczrBNa6mQwIQO4P7KBIVg8WhbZTCNwjnjxw+R
	 SS6bieVcAgJqIB5XJvw8nKwU3U2OwCB6esiOBxAxP2Zterr/yjwmoA0sEgsmmOu+Wa
	 Zf+RdY2lvpPMrFuyHopGHp7R/OJjr+1pfjoBmpPdvmG9dz6uwu5IoOuvPxCEJazsgu
	 OOtQfmbt8UklmTgVweT4EzaF9MMCQQIeSx23qbe8XlPl0n9SFFjQhct3SsdWYb0bK4
	 TROa9/5GzCdTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D099E392447A;
	Sat, 19 Sep 2026 22:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: reject IDR error pointers when deleting
 actions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178985700666.1481324.12869015066630990593.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 22:30:06 +0000
References: <20260914065123.4109709-2-bestswngs@gmail.com>
In-Reply-To: <20260914065123.4109709-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, vladbu@mellanox.com,
 marcelo.leitner@gmail.com, xmei5@asu.edu

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Sep 2026 14:51:23 +0800 you wrote:
> tcf_action_delete() drops the reference held by its lookup before calling
> tcf_idr_delete_index() with the saved action index.  An unlocked
> classifier can remove that action and reserve the same IDR slot with
> ERR_PTR(-EBUSY) in between.
> 
> tcf_idr_delete_index() only checks the lookup result for NULL.  It
> therefore treats the reservation as a tc_action and dereferences
> tcfa_bindcnt.  A hardware execution breakpoint was used to schedule the
> interleaving without changing the kernel source.  KASAN reported this
> decoded trace:
> 
> [...]

Here is the summary with links:
  - [net] net/sched: reject IDR error pointers when deleting actions
    https://git.kernel.org/netdev/net/c/c82b797abe66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


