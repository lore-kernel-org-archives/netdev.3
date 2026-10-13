Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B303BE64B;
	Tue, 13 Oct 2026 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885434; cv=none; b=nvllWiZY7xAO2UaU7qSmk3TrAxP8G/EaA3wY1t3JaUUC7A93fvEkluoPFL5tRI1U0evmwMIRG4u4TUKXT45WiRC57lZGxj/+EXqLUb2mUeDoRIYuVspNp2Q6NyCALRH3b8a1Z7Rp0pMv3uB+hk0MC/6MN6A/ss4A2ojwl1bE2bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885434; c=relaxed/simple;
	bh=qwCGy5Z9BFrhVBc+d3vLO5Mx2UIoIQyDOl2+KXToEHA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qZmk6CcGELdkCqDimOd5hEPKclGHdnteded8/Ub3pK/aISpjoQ8Ayzrf1zpnSsLgdCKoumh4AgCIN+WNNhBB2nEDwemQ8bhvg+bH0g1+fizJTVYM86BG41821ER4qYSPyY9qAVAJGBscpmd914YX6f7nMcKJt/f9/ieaDnL0vOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA/Fe3OE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA/Fe3OE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2051F00899;
	Tue, 13 Oct 2026 09:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885433;
	bh=03p4hmNLxQvCPfXlSb5X3901p/Ku/HYOiCjySAo7lFk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FA/Fe3OEFqQ4KQGhakl+hPQ+0PTD/3D5lkMklkMffs5rVcE4njw7ScZYQCQ5dSKip
	 WEcLaVHD8m/6qW7RZ8RLtVS4atV5b1WuLzlCfrYq7Ij1Q0alRa2pSKgFZ1Yab/r+sd
	 /TUIEaqIX0QoWX2fHSvb4XvlO290er2ibtcIBWR7hDBe5rsLV01zzfZfNo7eLlhbiy
	 ++EQxKE8qzelfl7ujuxhSyvSvxUizR+QtctD5cszTTb7AwOVYd6K69xeS9PbzECJ+x
	 h/RtQ7y8Z9LnMWG6juvmE4aW64oxD5Z+q4++H2WZn4t/boCxK3a42w6vBICFz5tQEl
	 /0QvjKI++1Sjg==
Subject: Re: [PATCH net-next v4 2/6] net: ti: icssg-stats: Move long delayed
 work on system_dfl_long_wq
From: netdev-bot+sashiko@kernel.org
To: marco.crivellari@suse.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
 jiangshanlai@gmail.com, frederic@kernel.org, bigeasy@linutronix.de,
 mhocko@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 enelsonmoore@gmail.com, linux-usb@vger.kernel.org
Date: Tue, 13 Oct 2026 09:57:11 +0000
Message-ID: <179188543192.434549.4257004266357227847@kernel.org>
In-Reply-To: <20261012095452.135828-3-marco.crivellari@suse.com>
References: <20261012095452.135828-3-marco.crivellari@suse.com>
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

- [Medium] The conversion is incomplete, so one delayed_work is queued on
  two different workqueues.

--

net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq

This commit changes the self-requeue in icssg_stats_work_handler() from
the per-cpu system_long_wq to the unbound system_dfl_long_wq. The goal is
to let the periodic stats work benefit from scheduler task placement.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> index 7159baa0155cf..7d6d6692d8192 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> @@ -69,7 +69,7 @@ void icssg_stats_work_handler(struct work_struct *work)
>  						stats_work.work);
>  	emac_update_hardware_stats(emac);
>  
> -	queue_delayed_work(system_long_wq, &emac->stats_work,
> +	queue_delayed_work(system_dfl_long_wq, &emac->stats_work,
>  			   msecs_to_jiffies((STATS_TIME_LIMIT_1G_MS * 1000) / emac->speed));
>  }

[Severity: Medium]
Is this conversion complete?

Both ICSSG drivers use icssg_stats_work_handler() for the same
emac->stats_work. Both prueth_netdev_init() functions, in icssg_prueth.c
and icssg_prueth_sr1.c, do this:

    INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);

However, the first run is still queued on the per-cpu workqueue from
the ndo_open path:

drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c:emac_ndo_open() {
    ...
	queue_work(system_long_wq, &emac->stats_work.work);
    ...
}

The follow-up patch "net: ti: icssg-prueth: Move long delayed work on
system_dfl_long_wq" converts the matching call in icssg_prueth.c. No
patch in the series seems to change icssg_prueth_sr1.c.

On SR1.0 hardware, the first stats run after each open would still go to
a per-cpu worker. Every later run would go to system_dfl_long_wq.

Could mixing the two workqueues also bypass the non-reentrancy check in
__queue_work()?

kernel/workqueue.c:__queue_work() {
    ...
		if (worker && worker->current_pwq->wq == wq) {
    ...
}

The instance running on system_long_wq re-arms onto system_dfl_long_wq,
so this check fails. If the timer expires before the first worker
returns, a second instance could start at the same time on another
worker.

Today this looks harmless. The handler does nothing after
queue_delayed_work(), and emac_update_hardware_stats() takes
prueth->stats_lock.

Should emac_ndo_open() in icssg_prueth_sr1.c also switch to
system_dfl_long_wq, so stats_work is only ever queued on one workqueue?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012095452.135828-1-marco.crivellari%40suse.com
