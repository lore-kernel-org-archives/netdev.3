Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F153BB9EB;
	Wed, 15 Apr 2026 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262784; cv=none; b=cr3uQXNO2pVR52gS8kKfnFBEhP8/spt7XjMxX5/1YHXx1+A22RcpyPWBSoNAyePOlTQ9el+DVNl98E5VeOYiXldtu5X6mWVDv+sfYCpuFqwiQhmxeIqbHO9J2ELPa+5/MoLKWzwrTcHu08qrCq/cZqyebFuigPqMpiKSTEhTvpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262784; c=relaxed/simple;
	bh=4GDlMJEm4uVtqtram785F36PyRUfMCvFYewp0lcHc8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDx+51oSsl/7X2vbA0ErpL9BNoHjGTCcw1Jj2YOw9xLeV4mhlTHMU2Kxyl8SzrJy7VsaXVMkfjvz/3BO2KgijXGRctZGBMzaqBXmnHHJ3eTyzzcWvdJ0aXi4GzZnrKZsEUxJoDTXbzo2SczIyremySjl6GUw0FsGPqAixP7CJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UydNJhxI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UydNJhxI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE62C19424;
	Wed, 15 Apr 2026 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776262784;
	bh=4GDlMJEm4uVtqtram785F36PyRUfMCvFYewp0lcHc8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UydNJhxIRJG9BJgltJg71m5M4dy/9nd9xl5tI0PlbHQ/gDR5h7w+Xa4ZmvKPG2Mj5
	 FGd+gudalqE2TgVn2T8WukPXMV2J1HuilVDxIhVLDWIyiPrBlGBA7HGzz0TTLPlU0q
	 snciT6pPnPcQfpYF7r6P9Fk/1DWo24gvhw+1YPfifNED6etuLY7VpN6FJ6MHA4bWQu
	 TIz2nNbOU2WBu8t2T+hhFR2j6HjjpQwYA/arTS5EroyPpQGWuHSFAOW9SF5fhnuAt5
	 BD4Os/SbKn9Ng2FMuxvwtSHPrj9bYUMb6LtVUSaPpSWQd7Df28aL//CGqVnIuLFou6
	 4tF6EsMBlZDcA==
From: Simon Horman <horms@kernel.org>
To: hxzene@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: act_mirred: Fix blockcast recursion bypass leading to stack overflow
Date: Wed, 15 Apr 2026 15:19:31 +0100
Message-ID: <20260415141931.808383-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413082027.2244884-1-hxzene@gmail.com>
References: <20260413082027.2244884-1-hxzene@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net/sched: act_mirred: Fix blockcast recursion bypass leading to stack overflow

This patch fixes a stack overflow bug where mirred blockcast actions would
bypass the recursion limit check because the recursion counter was not
incremented for blockcast actions.

> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 05e0b14b57731..5928fcf3e6514 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -444,8 +444,12 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
>  	tcf_action_update_bstats(&m->common, skb);
>  
>  	blockid = READ_ONCE(m->tcfm_blockid);
> -	if (blockid)
> -		return tcf_blockcast(skb, m, blockid, res, retval);
> +	if (blockid) {
> +		xmit->sched_mirred_nest++;

Could this leave a stale pointer in sched_mirred_dev since netdev_xmit is
persistent per-CPU (or per-task in PREEMPT_RT) memory?

If a nested mirred action later iterates over sched_mirred_dev up to the new
nesting depth to detect routing loops, could it match a stale pointer from
whatever unrelated packet previously reached this nesting level?

This might cause a false-positive loop detection and incorrectly drop a valid
packet. Should we set xmit->sched_mirred_dev[xmit->sched_mirred_nest] = NULL
before incrementing the counter?

> +		retval = tcf_blockcast(skb, m, blockid, res, retval);

This isn't a regression introduced by this patch, but it exists in the early
error returns of tcf_mirred_act() (e.g., when the target device is gone, or a
routing loop is detected) and in tcf_blockcast() (e.g., when
xa_empty(&block->ports) is true).

In these error paths, the functions simply return retval. For mirred redirect
actions, retval is initialized to m->tcf_action, which is typically
TC_ACT_STOLEN.

When TC_ACT_STOLEN is returned, the TC framework assumes the action has taken
ownership of the packet and will not free the sk_buff. Since the code does
not free the sk_buff before returning in these error paths, does this leak
the sk_buff?

Could an unprivileged user inside a network namespace trigger this
intentionally by creating a routing loop with mirred redirect rules, leading
to continuous sk_buff leaks and system memory exhaustion?

Should these error paths ensure the sk_buff is freed or force the return value
to TC_ACT_SHOT if the action is a redirect, mirroring the existing behavior in
tcf_mirred_to_dev()?

> +		xmit->sched_mirred_nest--;
> +		return retval;
> +	}
