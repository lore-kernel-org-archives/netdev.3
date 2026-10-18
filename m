Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599264B95D2;
	Sun, 18 Oct 2026 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792334089; cv=none; b=bfeiToogMkTP1dMZhBJBTDhYnxl2D8rRCYkZbQiyTAgcwDf0vcrx+PsK3bwG8sFedcmrmfQjWA1KbWD1t80VDznmk/nQAjJRgFRg/P7t9LxdrUY6BfknBKaGw3VVk1EWVUDHPQzr2vgzekWwXNVHkpWC66Vyty8MJ7N6vbGqrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792334089; c=relaxed/simple;
	bh=3jEfgEGRdHxD+SJ57/dOp099u0keoRLZbQO5y87PRVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guk0wIR7Uq3plucSNe/FDRIZixQkmZk1HSWCUkAXr5AEt7qftt5PQ9R4kbg8PZvvW4mMxqsdaGiIlCOiYCo80Oczk+BSvddOZqMhpoM5EUfevf630l4+Q48q/hMjxg0XdQ9y3SWsg0Pct0SngsuAKB6mQygT0xgaO1Cb7A0MbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHCEctUr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHCEctUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BFD1F000C4;
	Sun, 18 Oct 2026 14:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792334087;
	bh=Z8QttljgIo65jFz6uVQolqSpmyy8ZQ72s0nS5NA9PSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fHCEctUr7U+pvDaF8wrcDDHeb9zqfd3wgjCcXnLDgtaftMor9vffC9sB2XnTwJ2IN
	 tf+eBBnUI8Ak2Y2hVJ8GIkWmyGBktr6k+e4L7Ca+qZaiznVBUR1ytSYLKYGNijllPv
	 +oKoLzsH9mbCsk1QoIdU6dNu7/pgcZQ4LxZWvyzu5cSUL/pNt2FKLzk0vrd8xwrKLU
	 SbZD6URPm0hCEktMtCaGA3HuCZQX9O9SBN8dgetO0n3l3rMKuraJmDGenrVMk88nf+
	 x3zU3JVbRyWzQNWhkuBNrr8FsBohvyqe7TWyuka8uKPRbhei+LjIbqF8CgTpDpKP5J
	 coyyA1MBD/gDg==
Date: Sun, 18 Oct 2026 15:34:42 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: marco.crivellari@suse.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, tj@kernel.org, jiangshanlai@gmail.com,
	frederic@kernel.org, bigeasy@linutronix.de, mhocko@suse.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, enelsonmoore@gmail.com,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/6] net: ti: icssg-stats: Move long delayed
 work on system_dfl_long_wq
Message-ID: <20261018143442.GM503057@horms.kernel.org>
References: <20261012095452.135828-3-marco.crivellari@suse.com>
 <179188543192.434549.4257004266357227847@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179188543192.434549.4257004266357227847@kernel.org>

On Tue, Oct 13, 2026 at 09:57:11AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The conversion is incomplete, so one delayed_work is queued on
>   two different workqueues.
> 
> --
> 
> net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq
> 
> This commit changes the self-requeue in icssg_stats_work_handler() from
> the per-cpu system_long_wq to the unbound system_dfl_long_wq. The goal is
> to let the periodic stats work benefit from scheduler task placement.
> 
> > diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> > index 7159baa0155cf..7d6d6692d8192 100644
> > --- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
> > +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> > @@ -69,7 +69,7 @@ void icssg_stats_work_handler(struct work_struct *work)
> >  						stats_work.work);
> >  	emac_update_hardware_stats(emac);
> >  
> > -	queue_delayed_work(system_long_wq, &emac->stats_work,
> > +	queue_delayed_work(system_dfl_long_wq, &emac->stats_work,
> >  			   msecs_to_jiffies((STATS_TIME_LIMIT_1G_MS * 1000) / emac->speed));
> >  }
> 
> [Severity: Medium]
> Is this conversion complete?
> 
> Both ICSSG drivers use icssg_stats_work_handler() for the same
> emac->stats_work. Both prueth_netdev_init() functions, in icssg_prueth.c
> and icssg_prueth_sr1.c, do this:
> 
>     INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
> 
> However, the first run is still queued on the per-cpu workqueue from
> the ndo_open path:
> 
> drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c:emac_ndo_open() {
>     ...
> 	queue_work(system_long_wq, &emac->stats_work.work);
>     ...
> }
> 
> The follow-up patch "net: ti: icssg-prueth: Move long delayed work on
> system_dfl_long_wq" converts the matching call in icssg_prueth.c. No
> patch in the series seems to change icssg_prueth_sr1.c.
> 
> On SR1.0 hardware, the first stats run after each open would still go to
> a per-cpu worker. Every later run would go to system_dfl_long_wq.
> 
> Could mixing the two workqueues also bypass the non-reentrancy check in
> __queue_work()?
> 
> kernel/workqueue.c:__queue_work() {
>     ...
> 		if (worker && worker->current_pwq->wq == wq) {
>     ...
> }
> 
> The instance running on system_long_wq re-arms onto system_dfl_long_wq,
> so this check fails. If the timer expires before the first worker
> returns, a second instance could start at the same time on another
> worker.
> 
> Today this looks harmless. The handler does nothing after
> queue_delayed_work(), and emac_update_hardware_stats() takes
> prueth->stats_lock.
> 
> Should emac_ndo_open() in icssg_prueth_sr1.c also switch to
> system_dfl_long_wq, so stats_work is only ever queued on one workqueue?

It seem to me that it would be worth getting this right upfront.

-- 
pw-bot: changes-requested

