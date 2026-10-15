Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C13541472;
	Thu, 15 Oct 2026 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086945; cv=none; b=F6udf1A/xEzE69qljZ+bDY0UyvxAMyiUnpPvJPNV2HyS9koiHtGyLf1pEUqc+Y2v4OZ5gZNSq0wzmly3nuQHmVx7uN7AzygGGy4mR+CNtXifTZgTn10HB9nC35MgGQv5tGutLlaNSIHTEFbVc4KFK7/MtuFBTdtJ5Ncro3kXkIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086945; c=relaxed/simple;
	bh=XqPzHyhEKZKyuoJuZQJELeJ89ss2AbKTEmb86VgDVlw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z23ujQBV0Q0INNo2ipu3U0CuvI64czowNgO8XsZ1VQ+WQpSeATXHg9TzCAaoM+aa5zWY4rB74hDmDjEuzHDtX2mtVS9Oi15ggtm/4qP/ZwV+qEJjp5NRF/kcF0fSRvbnc86ZqqyzCeFzXVkP82hu0h+TTsFS6CBscztgLsI6XLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I///8MVj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I///8MVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4701F000C6;
	Thu, 15 Oct 2026 17:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792086936;
	bh=J7HZg6rAksXVoBr2xnRWmOUj/JfdCs0vGmQfyQ1uNU0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I///8MVjsn23/Rw/DcLLQbbllvLaWR2TSY7V0DhNSIkeyG2uQyVJCKvOJZ1O9sxRQ
	 GZIEVWFH0jGIM4UntA6T9pec0eqMalOvLE6ArnbDkUfQcWDZUiGnQIfAfg/ZbuFcIF
	 04Hp/racptyO576WMNAoYu+ea89c5mqCO8qClUJxyRE2SNvlizBIsECYJVQCklFtdk
	 2pQjJYoAi2GTGOzjuWvYuGiJuVrrp/aONpwP1yW9pWuw5HgGSCzRwqKmMwi5UfMxxt
	 Dv1iaV0IEJifEgpGILHkmsdx6bTweNtKi3xWRTBLyIjgFkVLi6Fs6MDFjejZNB+LbP
	 5MI1OI/WbobXA==
Subject: Re: [PATCH net v4 4/5] amt: make pre-query report drops visible
From: netdev-bot+sashiko@kernel.org
To: omar@blockcast.net
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Date: Thu, 15 Oct 2026 17:55:35 +0000
Message-ID: <179208693596.434549.15039653939486955091@kernel.org>
In-Reply-To: <20261013175407.947606-5-omar@blockcast.net>
References: <20261013175407.947606-5-omar@blockcast.net>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says amt_dev_xmit() now uses
  DEV_STATS_INC() for tx_dropped and tx_errors "so concurrent increments…

--

amt: make pre-query report drops visible

When a gateway drops an IGMP or MLD report because the relay's Membership
Query has not arrived yet, this patch now logs a netdev_dbg() message. It
also stops counting successfully forwarded gateway reports as tx_dropped.
The tx_dropped and tx_errors updates in amt_dev_xmit() now use
DEV_STATS_INC().

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index e466cf815a358..884f27fd84a4a 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -1236,7 +1236,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  		group.ip6 = ipv6_hdr(skb)->daddr;
>  #endif
>  	} else {
> -		dev->stats.tx_errors++;
> +		DEV_STATS_INC(dev, tx_errors);
>  		goto free;
>  	}
>  

[ ... ]

> @@ -1283,8 +1292,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  free:
>  	dev_kfree_skb(skb);
> -unlock:
> -	dev->stats.tx_dropped++;
> +	DEV_STATS_INC(dev, tx_dropped);
>  	return NETDEV_TX_OK;
>  }

[Severity: Medium]
The commit message says DEV_STATS_INC() is used "so concurrent increments
are not lost". Is that still true while other code in amt.c updates the
same counters with a plain increment?

DEV_STATS_INC() expands to atomic_long_inc(&dev->stats.__tx_dropped).
NET_DEV_STAT() makes __tx_dropped a union alias of the same unsigned long
that stats.tx_dropped++ modifies. If one site uses the atomic increment and
another does a plain read-modify-write on that word, updates can still be
lost.

For tx_dropped, amt_send_igmp_gq() and amt_send_mld_gq() still use the
plain form:

drivers/net/amt.c:amt_send_igmp_gq() {
    ...
	if (amt_send_membership_query(amt, skb, tunnel, false)) {
		amt->dev->stats.tx_dropped++;
		kfree_skb(skb);
	}
}

In relay mode these functions run from RX softirq via
amt_rcv()->amt_request_handler(). A remote gateway's AMT Request is enough
to trigger them. Nothing serializes them with amt_dev_xmit(), which is
LLTX:

CPU1 amt_send_igmp_gq()          CPU0 amt_dev_xmit()
  load tx_dropped (N)
                                   atomic_long_inc() -> N+1
  store N+1

The counter ends up at N+1 instead of N+2.

For tx_errors, plain increments remain in amt_send_discovery() and
amt_send_request() (gateway event work). They also remain in
amt_build_mld_gq() and amt_send_advertisement() (relay RX softirq). For
example:

drivers/net/amt.c:amt_send_request() {
    ...
	if (IS_ERR(rt)) {
		amt->dev->stats.tx_errors++;
		goto out;
	}
    ...
}

Should every tx_dropped and tx_errors writer in amt.c be converted to
DEV_STATS_INC(), so that the statement in the commit message is accurate?
No later patch in the series seems to make this change.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013175407.947606-1-omar%40blockcast.net
