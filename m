Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD233B2FFF
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262259; cv=none; b=Z/zskw3qxw4kJJRjxUHSH4+hOdeU6+YlGetdzmIGwvAUHo53ZRM3ti4pUoAU/2DO+Gpvcp9nT4GTjkCDPXt2viNWGU0gfxu0ujfswjNWfv/yN1Kq1HTmCEYTLc6tJQFsNp6PIJxQFy03mR+KJ4+AWF3porwvwZY/tvn1frnRk6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262259; c=relaxed/simple;
	bh=sjBRVDAsmAulNnV9BDsC6LoztIdR2DPuHoBI+7DM6j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fP+FbdnXIOxU46Evu5UKw00NYcCkbqbXz3hcCf90hSNXuaj/DUPGTdGCTFPzXQE41uAjw3GLRZtD/N3NJNC/eUOGPwWRnj9P6rmQ+WVqzTexY6wdAjH6sXzeWuCG28nav9BrUXB34t321+fuyDS034n4HcuSRozc4VjqVlYuyzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMBXtaMn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMBXtaMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC9FC2BCB3;
	Wed, 15 Apr 2026 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776262259;
	bh=sjBRVDAsmAulNnV9BDsC6LoztIdR2DPuHoBI+7DM6j8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LMBXtaMn58FoSThQH457XP4dSv2JaQ9S632C6UXa09cZSurQxfaz+AvzbkQ7pYL+k
	 QLJqwt19xlxQF4XI4y2tvyLGez30+QgB2hSxMX9/mR7QkUsrD29MavK3YhSKVFJRTb
	 anuJTcpZeGYvgeSGJThGY24YO0PQ6KKiEyGFI+6vTfpAeJ7hY8MGNYs27UBT9IUCGX
	 25LW3+h2d2nTwObn1NUPBddyBKWQ9qk4VyRyxrhBKLRYb4EQ9hpOG5rIIIcxQEmn3I
	 jyiVGMnOofF0CfQJS1e2YEoKraSQ9EhJBos8LmSDtNl272RaVf+4kW5H8DxkGBYyyC
	 unncmVBxp+WAw==
From: Simon Horman <horms@kernel.org>
To: phx0fer@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	jhs@mojatatu.com
Subject: Re: [PATCH] net/sched: act_ct: fix skb leak on fragment check failure
Date: Wed, 15 Apr 2026 15:10:26 +0100
Message-ID: <20260415141027.807275-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413084609.69560-1-phx0fer@gmail.com>
References: <20260413084609.69560-1-phx0fer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/sched: act_ct: fix skb leak on fragment check failure

This commit fixes a socket buffer leak in the act_ct traffic control action.
When tcf_ct_handle_fragments() encounters malformed fragments and returns an
error, the skb was not being freed, leading to memory exhaustion under
sustained traffic. The fix changes the return value to TC_ACT_SHOT to ensure
proper cleanup.

> net/sched: act_ct: fix skb leak on fragment check failure
>
> tcf_ct_handle_fragments() returns TC_ACT_CONSUMED when
> tcf_ct_ipv4/6_is_fragment() fails. This causes the caller to

The commit message contains a technical inaccuracy. It states
'tcf_ct_handle_fragments() returns TC_ACT_CONSUMED when
tcf_ct_ipv4/6_is_fragment() fails', but tcf_ct_handle_fragments() returns
integer error codes (like -EINVAL, -ENOMEM, -EPROTO), not TC action codes.

The function that returns TC_ACT_CONSUMED is tcf_ct_act(), which interprets
the error codes from tcf_ct_handle_fragments(). The code fix itself is
correct - only the commit message attribution is wrong.

More accurate would be: 'tcf_ct_act() returns TC_ACT_CONSUMED when
tcf_ct_handle_fragments() fails'.

> believe the skb was consumed, but it was not freed. Each
> malformed fragment leaks one skb, leading to OOM DoS under
> sustained traffic.
>
> Change the return value to TC_ACT_SHOT so the skb is properly
> freed by the caller.
>
> Fixes: b57dc7c13ea9 ("net/sched: Introduce action ct")

The existing Fixes: tag points to commit b57dc7c13ea9 ("net/sched: Introduce
action ct"), but the bug was actually introduced by commit 3f14b377d01d
("net/sched: act_ct: fix skb leak and crash on ooo frags").

The original commit b57dc7c13ea9 had correct error handling where fragment
check failures went to the 'drop' label. Commit 3f14b377d01d introduced the
'out_frag' label that always returns TC_ACT_CONSUMED, causing the skb leak
when fragment checks fail with errors other than -EINPROGRESS.

Suggested: Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo frags")

> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
>
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 7d5e50c921a0..870655f682bd 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1107,8 +1107,10 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
>  	return retval;
>
>  out_frag:
> -	if (err != -EINPROGRESS)
> +	if (err != -EINPROGRESS) {
>  		tcf_action_inc_drop_qstats(&c->common);
> +		return TC_ACT_SHOT;
> +	}
>  	return TC_ACT_CONSUMED;
>
>  drop:
