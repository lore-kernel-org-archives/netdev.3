Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF604EBAD7;
	Tue, 13 Oct 2026 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900115; cv=none; b=VGP09lej0evlLaVLdOghcCo2UUn/sQmLl/L/Tq5nPrkziwzfl84YioQ6q2a9y8gLUozA388HDZm0H9wA3uTjhR7Y+EpvhjCnymclnDWd6eCBCkdAOv1Q8qS2KnF0EVCkA1oUfnVDdfYgcbICGUx/6/e7Fd7aDoiHcfHIHrttIuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900115; c=relaxed/simple;
	bh=5g4Wsi/+kTP1JMeUNxsg0XrMYfmMrjHm+TsjlAEgzNw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WnRbzJvWc/5zXFy82Iuqs3/cldkdyY5fHOi2UaS1QOJfS1aUJijfPgjV894KJZxeoWwoMTzzrY4r3FCQ3Q1K1rBUL4DgRG6xwpBwdFcr48MExY4EQUQRz8y5Ys82aUQ7iCbBvZcCdyX48rlXiY7JuAmE9Cwf5w6jG7cFq/5ceJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRykNrPG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRykNrPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E551F000FF;
	Tue, 13 Oct 2026 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791900113;
	bh=pMbi/Ejlz2ZtXHuiR85GIc5pgV0btfqeQSckP/9ulSQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MRykNrPGF//8A2NbWQ40jr4QxV58EHc3GKvRCNbYrJ9E6PaqHo/Se+OfnMgvPBM6N
	 2ELqIotawMSC/6X7b9MkMAlPKXyKVMiCST6/vdJfc0JR874iPlN6XZRvql/Q1Tj8Y+
	 v5H2Gs2HvWiKidMGdJWMDrEG517QFf95zaDPU0gYXml47mjY6UJMDBHPSQuKJCOZZk
	 GYBCxC7FVx1T1D7YliZxUqeQxFgATrQZjJ1lYkoMzzcnhx3i/pf1xAgxUsp+oZUZej
	 Lkjmx4wlSvdAQOoWeBLJWRH3z7CclNBNOzQBDEhEAUwHSfx36JngIh5HoAkr5FgOoT
	 pdtGESuuEypEg==
Subject: Re: [PATCH net v3 5/6] amt: make pre-query report drops visible
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Tue, 13 Oct 2026 14:01:52 +0000
Message-ID: <179190011281.434549.18095097697039931783@kernel.org>
In-Reply-To: <20261012125943.558629-6-omar@blockcast.net>
References: <20261012125943.558629-6-omar@blockcast.net>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In gateway mode, amt_dev_xmit() (drivers/net/amt.c) counts
  every successfully forwarded IGMP/MLD report as a TX drop.
- [Low] The new netdev_dbg in amt_dev_xmit() (drivers/net/amt.c:1259)
  says "drop %s report: no Membership Query for this family yet"…
- [Low] net: amt: lockless non-atomic increments of dev->stats in tx path

--

amt: make pre-query report drops visible

This adds a family-specific netdev_dbg() to amt_dev_xmit(). It fires when
a gateway drops an IGMP or MLD report because the relay's Membership Query
for that family has not arrived yet. The commit message says the existing
drop path already increments tx_dropped, so each discarded report is
counted once.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 2feb418e87edb..fec32650cb91f 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -1249,9 +1249,17 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  		/* Gateway only passes IGMP/MLD packets */
>  		if (!report)
>  			goto free;
> +		/* A validated report can only be forwarded after the relay's
> +		 * family-specific Membership Query supplies the state echoed
> +		 * by the Membership Update. Log this readiness failure before
> +		 * the shared drop path accounts it.
> +		 */
>  		if ((!v6 && !READ_ONCE(amt->ready4)) ||
> -		    (v6 && !READ_ONCE(amt->ready6)))
> +		    (v6 && !READ_ONCE(amt->ready6))) {
> +			netdev_dbg(dev, "drop %s report: no Membership Query for this family yet\n",
> +				   v6 ? "MLD" : "IGMP");

[Severity: Low]
This isn't introduced by this patch, but the commit message relies on
tx_dropped to count each discarded report exactly once. Is that counter
reliable here?

amt_link_setup() sets dev->lltx = true along with IFF_NO_QUEUE. So the
core does not take HARD_TX_LOCK around ndo_start_xmit, and
amt_dev_xmit() can run on several CPUs at once.

Both drop paths in amt_dev_xmit() update the counters with plain
increments:

	dev->stats.tx_errors++;
	...
	dev->stats.tx_dropped++;

These are non-atomic read-modify-write operations on unsigned long.
Two CPUs dropping packets at the same time can lose increments. The
only effect is inaccurate statistics, but it means "accounted exactly
once" doesn't hold under concurrent transmit.

Would it make sense to switch these to DEV_STATS_INC(dev, tx_dropped)
and DEV_STATS_INC(dev, tx_errors)? Those use atomic_long_inc() on the
same fields. Another option is to move the driver to per-CPU stats.
That is probably a separate fix rather than something for this patch.

[Severity: Low]
This isn't a bug, but could the wording of this message be a bit more
precise?

ready4 and ready6 are false before the first Query, and they are also
cleared on every refresh cycle in amt_event_send_request():

	if (!amt->req_cnt) {
		WRITE_ONCE(amt->ready4, false);
		WRITE_ONCE(amt->ready6, false);
		get_random_bytes(&amt->nonce, sizeof(__be32));
	}

They are cleared again on the relay-lost path, when req_cnt exceeds
AMT_MAX_REQ_COUNT.

The nonce is regenerated at the same time, and
amt_membership_query_handler() rejects Queries with a stale nonce. So the
message is correct for the current Request.

Still, an operator who sees it in steady state might read "no Membership
Query for this family yet" as meaning the relay never answered. Would
something like "waiting for Membership Query" be clearer?

> +			goto free;
> +		}
>  		if (amt_send_membership_update(amt, skb,  v6))
>  			goto free;
>  		goto unlock;

[Severity: Medium]
The commit message says:

    That path already increments tx_dropped, so each discarded report
    is accounted exactly once.

The new comment also refers to "the shared drop path". Can tx_dropped
actually be used to count these drops?

When amt_send_membership_update() returns false, it has already handed
the skb to the tunnel:

	udp_tunnel_xmit_skb(rt, sk, skb, ...);
	amt_update_gw_status(amt, AMT_STATUS_SENT_UPDATE, true);
	return false;

The caller then does goto unlock. That label reaches the same increment
that the real drops use:

free:
	dev_kfree_skb(skb);
unlock:
	dev->stats.tx_dropped++;
	return NETDEV_TX_OK;

So in gateway mode, every IGMP/MLD report that is forwarded successfully
is also counted in tx_dropped. That doesn't match the rtnl_link_stats64
definition of tx_dropped ("Number of packets dropped on their way to
transmission").

The success-path increment has been there since commit cbc21dc1cfe9
("amt: add data plane of amt interface"). This patch, though, depends on
tx_dropped to count the pre-Query drops. How would the counter tell those
drops apart from reports that were sent?

Should the goto unlock success path skip the tx_dropped increment?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012125943.558629-1-omar%40blockcast.net
