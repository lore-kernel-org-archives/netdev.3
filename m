Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18F33E6DE7;
	Tue, 13 Oct 2026 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885436; cv=none; b=oNinB4LXC0IuuRFSZoo2QokV9l/Y80rljjPHYC2owiuvX6e2qDyKtuJ2VPy4iBJFhQv4gvaSRKIxqw90IOHKDMQkTaBZXLG2jkaOKghPoLfmWhkZGaCybIBsNozNGy6vEQ6A+UM54nVcxov+xs10XYp42fwfmhVRrdIi0GIQqMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885436; c=relaxed/simple;
	bh=6TYElkl1vMwUo8ragwlZEazBoe8TG/eKKLf7zn241E8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oelB5N4FVixD3XAR0gcPLFaoBbtHrTLzuVCFSEzE1aSs9hqgRGPFQHO4dfXhw0yotdl/G0p5bM9roQysTP+38LfCVdX5tzHU3ALESr/j/97hMkakmoJf3UjJnqbyIChBOXqQE0vk46qZ07TYmrfQY+G4tayLGkdT8Gnx6NLovAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUkGAmqp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUkGAmqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00971F000FF;
	Tue, 13 Oct 2026 09:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885434;
	bh=T7aNwfsLUa94zkJPIVd3zM4XapiCDmPKjk2jNb3L81I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SUkGAmqp3aoA8ktn4n8Gsbp9VbnU1Fh8xO9f58NT3iKDAVnY8R/kV7KMU0j/opvcL
	 q7lC5Zn45JjGiOaTOdl4deAzc1fX3EuPws9qc6/ZRK3iyLvmBCYzScddaNnpTA7jPs
	 kohMfpp57vQ5xafz57XGHosdIWc4o5f06naKxWfvg70V431UfnRTFk2GAuUdhMnU0X
	 PhXJKMe049iY+yXDIDPBymcwdxddiPzXgdk+vR4xzAAjNrltaTXXYgLsu6Tsqxss+l
	 JAybER+rseRcQZRlH9hha8cssVmI6OfGmWEK1tClK7f7vMCQ0yFHgYZ+ObzNxpYnDK
	 +hzQkWyZagSug==
Subject: Re: [PATCH net-next v4 3/6] net: ti: icssg-prueth: Move long delayed
 work on system_dfl_long_wq
From: netdev-bot+sashiko@kernel.org
To: marco.crivellari@suse.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
 jiangshanlai@gmail.com, frederic@kernel.org, bigeasy@linutronix.de,
 mhocko@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 enelsonmoore@gmail.com, linux-usb@vger.kernel.org
Date: Tue, 13 Oct 2026 09:57:13 +0000
Message-ID: <179188543334.434549.2591392619037446016@kernel.org>
In-Reply-To: <20261012095452.135828-4-marco.crivellari@suse.com>
References: <20261012095452.135828-4-marco.crivellari@suse.com>
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

- [Low] The stats_work conversion is only half done because the SR1
  driver variant was missed.
- [Low] The commit message is boilerplate copied from the delayed-work
  conversions and does not describe this diff.

--

net: ti: icssg-prueth: Move long delayed work on system_dfl_long_wq

This patch changes the first queueing of emac->stats_work in
emac_ndo_open() from the per-CPU system_long_wq to the unbound
system_dfl_long_wq. The goal is to let the scheduler place the work.

> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected and it is a per-cpu workqueue.
>
> The function(s) end up calling __queue_delayed_work(), which set a global
> timer that could fire anywhere, enqueuing the work where the timer fired.

[Severity: Low]
Does this description match the diff?

The only line changed is in emac_ndo_open() in icssg_prueth.c, and it
uses queue_work(), not {queue|mod}_delayed_work():

    queue_work(system_dfl_long_wq, &emac->stats_work.work);

queue_work() is queue_work_on(WORK_CPU_UNBOUND, wq, work). It queues the
embedded work_struct right away. It arms no timer and does not go through
__queue_delayed_work().

The delayed re-arm that the message describes lives in
icssg_stats_work_handler() in icssg_stats.c. The companion patch
"net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq"
converts that one.

Could the message describe the immediate first kick of stats_work instead,
and mention the companion patch?

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 591be5c8056b4..0fba22c1046e9 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -1100,7 +1100,7 @@ static int emac_ndo_open(struct net_device *ndev)
>
>  	prueth->emacs_initialized++;
>
> -	queue_work(system_long_wq, &emac->stats_work.work);
> +	queue_work(system_dfl_long_wq, &emac->stats_work.work);

[Severity: Low]
Should the SR1 variant of this driver get the same change?

emac_ndo_open() in drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c still
does this:

    queue_work(system_long_wq, &emac->stats_work.work);

Both drivers set up stats_work with the same shared handler:

    INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);

After the companion icssg-stats patch, icssg_stats_work_handler() re-arms
itself on the unbound workqueue:

    queue_delayed_work(system_dfl_long_wq, &emac->stats_work,
                       msecs_to_jiffies((STATS_TIME_LIMIT_1G_MS * 1000) / emac->speed));

So on SR1 hardware, the first run after ndo_open goes to the per-CPU
system_long_wq. Every later run goes to system_dfl_long_wq.

The commit message reasoning ("the workqueue work doesn't rely on per-cpu
variables") applies to the SR1 call site too. Nothing else in the series
seems to convert it.

>
>  	return 0;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012095452.135828-1-marco.crivellari%40suse.com
