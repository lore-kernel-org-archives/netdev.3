Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58C23BFE3C
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792319330; cv=none; b=Pb5B1k0fefE6JgfbZSeAMRWqXWTV7D0k9JRxF7vUncbe2IIvsI89pmcaPzYWjP2QTkmPs+94tYsMJ+9gfKhCI207oNLq811HzMH/ONMh+MfNVw33GbvEweNKG8byvvgcnlmiSvMtWfKO/CXmZ0fLGxDvYlJo25xlkEnXfbvw1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792319330; c=relaxed/simple;
	bh=VMEPrd02TV1lYzXH1MXddssILsVUbeo2zp0j77mkZOY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mkmhwRLD7qp1ediDJh3ICq1yGZ63AkOiIWEa3rYZ9ZFKHoDQP2Gj85XgBGDH6j2EbJrEgHHDqDSIo+GRGdXtblx5kmhwazCwFJy07EQeEvYzaqdBciJQU5P8Uq6hESZb2o6NlhMMKeYypaY+fX7tkzM5UzGSud48VrMzN3P2H/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmVm+dZc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmVm+dZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A2A1F000C4;
	Sun, 18 Oct 2026 10:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792319329;
	bh=qUGlVEGEXGO27eMqITS9PPkEN93N02+nAAGDjrJQSHA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RmVm+dZc20MkjgeMbwvmGLjyvwDOVdr4nWwUy/wzfT4PoZwE3RO9IxiV9SOw1e8gp
	 dw0XH1w3vVTW5j3qc2pGF5clmmVLWJ8/qT4jqP7dj2JgRpYbYfKnMrtZ27OZgD1iZj
	 MUOu9ntCuTSuWWGs8oAU1sf4dFS+PraQehMDiBIDd5C/Th1KqWqA4KTsNqrJRGrPmI
	 UNCnq/QhGuZIArXieRrSDHNBbirmemo05B0gPfOWbVADozjnwwVkVItwrAGm9Lcf9K
	 +kK+/8I707Qa1EWh2wXAtms57Gi1SWfJjhok6VYsSqGtySH3YdhPptqDRHjLruldlG
	 2DpLfyppsp3OQ==
Subject: Re: [PATCH net-next v6 1/4] net/sched: cake, fq_codel: return the
 classifier result to the caller
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, toke@toke.dk, sashiko-bot@kernel.org
Date: Sun, 18 Oct 2026 10:28:48 +0000
Message-ID: <179231932829.3135.5746553688919070963@kernel.org>
In-Reply-To: <QDISC-BA27.v6.r0.20261014054826-1@mojatatu.com>
References: <QDISC-BA27.v6.r0.20261014054826-1@mojatatu.com>
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

- [Low] The new comment above fq_codel_classify() in
  net/sched/sch_fq_codel.c gives two reasons the function returns true…

--

net/sched: cake, fq_codel: return the classifier result to the caller

This patch changes the classifier helpers in cake and fq_codel so they no
longer compute the flow hash. The cake helper now returns the filter's
flow/host overrides. The fq_codel helper now returns either a 1-based flow
index or a request to hash, so the caller picks the flow. It is preparation
for later accounting changes, and classification behaviour should stay the
same.

> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index e6c87a32950f9..4cf3d379b8e95 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c
> @@ -73,22 +73,35 @@ static unsigned int fq_codel_hash(const struct fq_codel_sched_data *q,
>  	return reciprocal_scale(skb_get_hash(skb), q->flows_cnt);
>  }
>
> -static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
> -				      int *qerr)
> +/* Run the qdisc's optional external classifier. Returns true when the
> + * caller must drop the packet (a terminal TC action consumed it, or the
> + * result carried no class ID); the reason is then in *qerr. Otherwise *idx
> + * is the 1-based flow index, or *do_hash asks the caller to use
> + * fq_codel_hash().
> + */

[Severity: Low]
This isn't a bug, but the comment above fq_codel_classify() lists only two
cases where it returns true. The code returns true in two more cases.

First, if no filter in the chain matches, tcf_classify_qdisc() returns a
negative value. The if (result >= 0) block is skipped and the function hits
the final return true.

Second, a filter can return a class ID whose minor is above q->flows_cnt.
One example is classid 1:2000 with the default 1024 flows. That fails this
check and also falls through to return true:

	if (TC_H_MIN(res.classid) > 0 &&
	    TC_H_MIN(res.classid) <= q->flows_cnt) {

Neither case is a terminal action, and the second one does carry a class
ID. The behaviour matches the old helper, which returned 0 in both cases.
Only the new comment is incomplete.

The commit message says follow-up accounting patches build on this helper.
Could the comment say that true is returned whenever no valid class in
1..flows_cnt was selected (no match, minor 0, or minor above flows_cnt)?
Otherwise a reader may assume these packets fall back to hashing, as they
do in cake_tcf_classify(), when fq_codel drops them as BYPASS drops.

> +static bool fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
> +			      unsigned int *idx, bool *do_hash, int *qerr)
>  {

[ ... ]

> -		if (TC_H_MIN(res.classid) <= q->flows_cnt)
> -			return TC_H_MIN(res.classid);
> +		if (TC_H_MIN(res.classid) > 0 &&
> +		    TC_H_MIN(res.classid) <= q->flows_cnt) {
> +			*idx = TC_H_MIN(res.classid);
> +			return false;
> +		}
>  	}
> -	return 0;
> +	return true;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v6.r0.20261014054826%40mojatatu.com
