Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D73361978
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820302; cv=none; b=JthcC7Uw1Z4sNXypD3OXCe2KlTmrCx5QCpG/emb8GZjqRQeApLmSXEQPJJ9Nyij1XIoAMQRmOlyOyAtfrX2XVUQv6YqIdBKs1ag8xqjdbqIiKcBjjJLWJC6yGTIKr5nTCg5SWVL5G5n/oFT6KgZ6hcwyyExm5nMoUOjP7V1XRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820302; c=relaxed/simple;
	bh=H74nxtqssHHsSAhcZolki5kpV/tKu2WtCc4RpQ0Hm5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNfyJbOI6GhS1WeRJfT43PwQCFRT3PQY2sc9pQHbzSDqPDXhN0ZXfV1YLUgQB2FkMCMmFPTWjno506qFOFqe5otX8UBW469Tzg+R5B3s71UaMhA2HzcFPqlgQITtxlXOd7oKdd38V01qsL4ndOQl/cg4YjMcB/zQd8bcGwB/xoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k01MFnfr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k01MFnfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769251F000E9;
	Thu, 27 Aug 2026 08:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787820300;
	bh=yGuMwn2KT0ixRcy0glAWYlk9En8T+71o2unnvQTXz7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k01MFnfr7UqvthLXcWzZvVIC9sSZGItgGf9c2IM+s46QQQrTzgKtG9oL070592HaN
	 sJqUA0aJIMwGIlK4TtCVm+V9Rn3Q0qI6xEe4XjF8lM8XCSzudiyDBkpf33WitwA+7D
	 PDf5bUGK82s+TwCR0ZHNUipJvYLfgDGVqNjnWZ4kHNLl85urrhgCt5lkmli7lN5WBb
	 L3/QOjQfIQpYoVaxnQ2GaeVf2Py2AFgBqhoIjkGu4F+S/oyzCvajDi9puEmBf+kuqg
	 BLKFGh+zLMvcQPjH4cnA60adfK9Yx+RBiYCNLal4by/QifbnuvtgDogMoV10JZ0klA
	 hbQiiSgwYtW3g==
Date: Thu, 27 Aug 2026 09:44:56 +0100
From: Simon Horman <horms@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
	baowen.zheng@corigine.com, louis.peens@corigine.com,
	pctammela@mojatatu.com, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/4] net/sched: act_api: budget all shared attributes
 in notify skbs
Message-ID: <20260827084456.GA396647@horms.kernel.org>
References: <20260824153903.4143642-1-victor@mojatatu.com>
 <20260824153903.4143642-2-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824153903.4143642-2-victor@mojatatu.com>

On Mon, Aug 24, 2026 at 12:39:00PM -0300, Victor Nogueira wrote:
> tcf_action_shared_attrs_size() is supposed to return an upper bound on the
> netlink attributes every action dump emits outside of TCA_ACT_OPTIONS, so
> that tcf_add_notify_msg(), tcf_del_notify_msg() and friends can allocate
> an skb large enough for the reply.  It has fallen behind the dump path and
> is now an underestimate for every single action.
> 
> Attributes, such as, TCA_ACT_IN_HW_COUNT and TCA_STATS_BASIC_HW are
> emitted unconditionally and never accounted for. TCA_STATS_PKT64,
> TCA_ACT_USED_HW_STATS, TCA_STATS_RATE_EST, TCA_STATS_RATE_EST64 require
> specific conditions, but are also not accounted for.
> 
> Fix the issue by budgeting all of them so that we have a legitimate
> upper bound. Even tough for of them require specific conditions, they
> are cheap so, to avoid overcomplicating, we opted to account for them
> unconditionally as well to account for a real worst case scenario.
> 
> Fixes: 4e76e75d6aba ("net sched actions: calculate add/delete event message size")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810164357.1653956-1-victor%40mojatatu.com
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>  net/sched/act_api.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index b4415d358c91..766162b0b810 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -443,12 +443,21 @@ static size_t tcf_action_shared_attrs_size(const struct tc_action *act)
>  		+ nla_total_size(IFNAMSIZ) /* TCA_ACT_KIND */
>  		+ cookie_len /* TCA_ACT_COOKIE */
>  		+ nla_total_size(sizeof(struct nla_bitfield32)) /* TCA_ACT_HW_STATS */
> +		/* TCA_ACT_USED_HW_STATS */
> +		+ nla_total_size(sizeof(struct nla_bitfield32))
> +		+ nla_total_size(sizeof(u32)) /* TCA_ACT_IN_HW_COUNT */
>  		+ nla_total_size(0) /* TCA_ACT_STATS nested */
>  		+ nla_total_size(sizeof(struct nla_bitfield32)) /* TCA_ACT_FLAGS */
>  		/* TCA_STATS_BASIC */
>  		+ nla_total_size_64bit(sizeof(struct gnet_stats_basic))
> -		/* TCA_STATS_PKT64 */
> -		+ nla_total_size_64bit(sizeof(u64))
> +		/* TCA_STATS_BASIC_HW */
> +		+ nla_total_size_64bit(sizeof(struct gnet_stats_basic))
> +		/* TCA_STATS_PKT64, emitted by both of the basic copies above */
> +		+ 2 * nla_total_size_64bit(sizeof(u64))
> +		/* TCA_STATS_RATE_EST */
> +		+ nla_total_size_64bit(sizeof(struct gnet_stats_rate_est))
> +		/* TCA_STATS_RATE_EST64 */
> +		+ nla_total_size_64bit(sizeof(struct gnet_stats_rate_est64))
>  		/* TCA_STATS_QUEUE */
>  		+ nla_total_size_64bit(sizeof(struct gnet_stats_queue))
>  		+ nla_total_size(0) /* TCA_ACT_OPTIONS nested */

Hi Victor,

As you are no doubt aware there is an AI-generated review
of this patchset available at
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.4143642-1-victor%40mojatatu.com

And while I trust you will look over it, I did feel the following issue
was worth raising here for you to comment on.

I do see that it doesn't strictly effect this patch. But at the same time,
perhaps it ought to be fixed, either as part of this patch or as a
follow-up.

Text of the AI-generated review:

  This isn't a bug introduced by this patch, the TCA_ACT_STATS line is
  unchanged, but while the surrounding terms are being made exact, should this
  container use nla_total_size_64bit(0)?

  It is opened through nla_put_64bit():

  net/sched/act_api.c:tcf_action_copy_stats() {
		err = gnet_stats_start_copy(skb, TCA_ACT_STATS,
					    &p->tcfa_lock, &d, TCA_ACT_PAD);
  }

  which reaches gnet_stats_start_copy_compat() -> gnet_stats_copy(d, type,
  NULL, 0, padattr), and on !CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS a 4-byte
  TCA_ACT_PAD attribute can precede the nest.  gen_stats.c even fixes up
  d->tail for exactly that case:

  net/core/gen_stats.c:gnet_stats_start_copy_compat() {
		int ret = gnet_stats_copy(d, type, NULL, 0, padattr);
		/* The initial attribute added in gnet_stats_copy() may be
		 * preceded by a padding attribute, ...
		 */
		if (ret == 0 && d->tail->nla_type == padattr)
  }

  No overrun follows from this today: TCA_ACT_KIND is budgeted
  nla_total_size(IFNAMSIZ) = 20 bytes while the longest registered in-tree
  kind is "tunnel_key", emitted as 16, so every action carries at least 4 bytes
  of slack that absorbs the missing pad.  It is only the term-by-term upper
  bound property that is lost.
