Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9F3955D3
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792954; cv=none; b=Q5Qr72wuQR0DoaFEbMMFe9O5GKGp5EMS1oL2VY0pHpuzD6MjlC/nI8lldbyCcNUCjptFz++6TlRwdZY+TRBHJEE1nMcGehWd+lYM//3IV/jNSwDGIUqfFFLtWFqx+8RS3uWMfdriZcHCl0SB9GS9Y7eiiwDErIeNc2WIkBcjJag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792954; c=relaxed/simple;
	bh=Zt4hHDZ29vwmILLPDCY7mm6yyInCPMa3RAnKboHlyNs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gXUtQNZp6cfTNOCwdbNvYDr2oaF4oa4aSKWALBEzgxPy7566oQiy3OgKOrHk/p5c0ift8Ephv1+bVxK2kHkYzUwg/TQgLUfWFzHXK0KHIgYub5OjVdogi6z6ekgm8+nbig8iB54ej+PBCo1mKt5t0Xtjz6Js5GVFwLBmVyNws78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCLofL4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCLofL4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405461F0089B;
	Mon, 12 Oct 2026 08:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791792952;
	bh=SCawRjNF2cEG3bYudW9Ft19zAi4PfNEk/TIxbMOeRtY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aCLofL4/m7iAfkWid9TT9rxiZTDVMsqgP54RBI3LzK29kORQr4n0J/amWnQT0O6V0
	 VnibZh3Qwys8Xnyu4s99iRA+e49ur+YgkkYC5BO3DJr5FAMy3jlNBQD0W3fw5KLVBg
	 9fJ0TkrrGusubmpx+eziqn3jUB1h8vpjgCdNRjUfxgdGi/tE+W4v+xiYk2vCLMwj9z
	 nC+6188fP3NJ3PwScmh+Evsbu3jvfM7iM6VBmWeL3ONbt4StnUzotJvY6N60c6lGIY
	 IrL58Dc3ZJvqn8dgsw6FbhK532PlJakR35QI8o3LSElb7mLsJx2LeoMBPzfklVcUVL
	 ouIlmclDAYNtQ==
Subject: Re: [PATCH net-next 2/4] net/sched/sch_cake: reduce parent backlog
 when clearing a tin
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, toke@toke.dk, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, victor@mojatatu.com, cake@lists.bufferbloat.net
Date: Mon, 12 Oct 2026 08:15:51 +0000
Message-ID: <179179295184.434549.14404407377546037457@kernel.org>
In-Reply-To: <QDISC-5RTM.v1.20261007130704-3@mojatatu.com>
References: <QDISC-5RTM.v1.20261007130704-3@mojatatu.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit is missing a Fixes: tag.

--

net/sched/sch_cake: reduce parent backlog when clearing a tin

This commit changes cake_configure_rates() to record CAKE's qlen and
backlog before and after the purge of unused tins during DiffServ
reconfiguration. It then calls qdisc_tree_reduce_backlog() once with the
difference. Before this, cake_clear_tin() dropped those packets without
updating classful parents such as HTB, so their qlen/backlog accounting
was left wrong.

Link: https://sashiko.dev/#/patchset/20260816012109.2865223-1-ooonea@gmail.com
Link: https://lore.kernel.org/netdev/20260816012109.2865223-1-ooonea@gmail.com/

> CAKE has purged unused tins on DiffServ reconfiguration since commit
> 83f8fd69af4f ("sch_cake: Add DiffServ handling") without propagating the
> resulting backlog reduction to classful parents. The issue was noticed
> while reviewing 7cbfb180945c, but predates that change.

[ ... ]

> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260816012109.2865223-1-ooonea@gmail.com
> Link: https://lore.kernel.org/netdev/20260816012109.2865223-1-ooonea@gmail.com/
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
Should this patch have a Fixes: tag? The commit message names 83f8fd69af4f
as the commit that added the cake_clear_tin() purge in
cake_configure_rates() without a parent backlog reduction. However, the
only trailers are Reported-by, Link, Reviewed-by and Signed-off-by.

Would it make sense to add something like this:

Fixes: 83f8fd69af4f ("sch_cake: Add DiffServ handling")

so that stable tooling can pick up the fix for older kernels?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-5RTM.v1.20261007130704%40mojatatu.com
