Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEEC4E1C84
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407756; cv=none; b=jmOUtjYGwmynegBta+kQ5lgKxrlZ+2Cc7UYsSf9KxmPlXsks0P3W/tS+rG718SCRuGXpr6B9+o8QQOk5NF5xTaNxvahOk+0XPABcYKL/ksto3CsLXqPzmBCfpHehuMw1EWkxU40DvJySoOCRFXACpd4GaodQMVHDfY33obZ1a9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407756; c=relaxed/simple;
	bh=zRYLNf9/X3t6SrEHb17yhKE4Z27PfjuV+iVPm54OknI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ei+Pqfi+a/asP/oTK2wyYPvfGPzdVE+zsZmvb+aOirLNfIbXWwH0qLGMX3DPH6NPzAPTr1yAhSr9gBpklQiJ+e6Vi5qw3N9oJ3+9058nD23+2spGt0/6+JZ1wmghsDWQUEmvp6VLBEHuH/8r2RXfoHfvpsNZV5nlvp6CQjcESpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L01enBiW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L01enBiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C997D1F000C5;
	Mon, 19 Oct 2026 11:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792407755;
	bh=RFOIPAMsqFFn/tAGm8veeMIh24eQUqS0PtTbyHgNzL8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L01enBiWFz2AXoOBWPYKj42tkof2pP0h7UWzlM7ySsYYOaRH9McXsIBWmjK3P5FXL
	 eQBQe25WFZPXgDtvF6ozX9/gO4ffUVHw0JIX935lK54eEWrXs9HD443IKmgQzs0qLK
	 9ppr9uWO2pL9Vh3B8bfvpJeP1cU+h0tWtbpeK2Or+Uhq2aNeYlftdwB5bwhuxOmTci
	 Oxop1m1bGhwlUUGEqjST//CDG83SZlVBih3EGL4kMLJMZXopEI9+7vUdzm+DKa+kEO
	 TQLn776kO15kIw79wse2/lJUMdvZUUA4IlpfrI+PCetiYEcI0QiVDWI4hLuDUObqsf
	 VhfsOA7yuwfOg==
Subject: Re: [PATCH net-next v2 2/4] net/sched/sch_cake: reduce parent backlog
 when clearing a tin
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, toke@toke.dk, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, victor@mojatatu.com
Date: Mon, 19 Oct 2026 11:02:34 +0000
Message-ID: <179240775440.3135.8295520972044487564@kernel.org>
In-Reply-To: <QDISC-5RTM.v2.r0.20261015051735-2@mojatatu.com>
References: <QDISC-5RTM.v2.r0.20261015051735-2@mojatatu.com>
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

- [Low] The commit "net/sched/sch_cake: reduce parent backlog when
  clearing a tin" fixes a real, user-visible accounting bug but has no…

--

net/sched/sch_cake: reduce parent backlog when clearing a tin

The patch changes cake_configure_rates() so that, on a reconfigure
(!rate_adjust), it snapshots CAKE's qlen and backlog before purging the
unused tins with cake_clear_tin(). Afterwards it calls
qdisc_tree_reduce_backlog() with the delta, so classful parents like HTB
no longer keep counting the purged packets. The reset path is left
alone because qdisc_purge_queue() already reduces the tree there.

Link: https://sashiko.dev/#/patchset/20260816012109.2865223-1-ooonea@gmail.com
Link: https://lore.kernel.org/netdev/20260816012109.2865223-1-ooonea@gmail.com/
Link: https://lore.kernel.org/netdev/8733ugtry8.fsf@toke.dk/

> The issue:
> CAKE has purged unused tins on DiffServ reconfiguration since commit
> 83f8fd69af4f ("sch_cake: Add DiffServ handling") without propagating the
> resulting backlog reduction to classful parents. The issue was noticed
> while reviewing 7cbfb180945c, but predates that change.

[ ... ]

> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260816012109.2865223-1-ooonea@gmail.com
> Link: https://lore.kernel.org/netdev/20260816012109.2865223-1-ooonea@gmail.com/
> Link: https://lore.kernel.org/netdev/8733ugtry8.fsf@toke.dk/
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
This isn't a bug, but should this have a Fixes: trailer?

The changelog already names the commit that introduced the missing
parent accounting in cake_configure_rates()->cake_clear_tin(). The
trailer block has Reported-by, Link, Reviewed-by, Acked-by and
Signed-off-by, but no Fixes: tag.

Without the tag, stable and backport tooling may not match this fix to
83f8fd69af4f. Stable kernels would then keep the wrong HTB parent
qlen/backlog after a diffserv8 to diffserv3 change.

Would something like this work?

Fixes: 83f8fd69af4f ("sch_cake: Add DiffServ handling")

The code change itself looks correct to me. It reduces the parent only
for the reconfigure purge, and the reset path is already covered by
qdisc_purge_queue().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-5RTM.v2.r0.20261015051735%40mojatatu.com
