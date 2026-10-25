Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792939242;
	b=5r88vPF/o5DziHqUBCmU9Z9nCNdXv31U/MIiEZuVYVB28aWzt/lK2QaaQLZAGlUhSs6k
	 AGVwoHZ5BENPGxTAFZUapa73bX2dYY488qjpXdfLdkxEmq7asMyKgMgDjNGWPxWXzG5Pm
	 NMsC4cZjfdVVHRpblB0ALZ93Q/SJzFn8IZgL7Uifs9VJxTXbMdCrx/VKK37xKXceF1Vew
	 taXbbDyQQUPCq3yeZd0fdhG7W7roHb9GOI5Ontvq2TC+2Si4fbupBFJS4zuty9kFkqaNJ
	 0FRKDuns+Ki567brcRWLOshoPr0J4BSTvyGtezKEI7Z3/+KgZu25nZvDqzXG6m97oPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792939242;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9FAAKmlEypGsI9J86zAjMvVPqXYkvra1xp/aDP/bK/g=;
	b=q/mN6GMy5L5nEW9XsMxZZksZEfH/N/a05YHdB3ikwbdfUyfxDMgBdfxHszp61IvSb53z
	 TRRw2Y0RrjgwAniurWAxuJG6Q+9S3LAF59T3cVfxrmPRnr41OcbDigIc40Dj7hQe/vF5o
	 PI1/6+sPPpUatAkqE5gVv0sJ+ByHskVd0d4eV1VP7047z3W/jm2NObFAm7Bj1b+WKCta1
	 2TP/NnXTLouQCiUOjMdRjibt/L2AK0G8bupttEOqBoGNJPC7bKfxGvqazixhJ+VPGCWDX
	 a2+SzvJ19QeYpBJLE1xURJ9hUQpljhENoXzLgtnJapZH7B6o/U0LLC1mwKqko5CWL2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4p9RgXF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2392606A31A;
	Sun, 25 Oct 2026 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4p9RgXF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2A51F01825;
	Sun, 25 Oct 2026 14:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792939241;
	bh=9FAAKmlEypGsI9J86zAjMvVPqXYkvra1xp/aDP/bK/g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=a4p9RgXFDdTIMncUeym0clbeqw5a446nsraSwDw1pBh9d9gQXcnbq/IFl4kL71eEv
	 tdZKgP7EKMfg45l2194j9Z0UYiZ0Le3lSzfsZlhRodVz9XbfI9q9SBo+notV6Jag5g
	 JkkOzQHf3nE2kcYfybNGV2ojbeD+FSQKg1i0SldRKWm7+piHIHICw0LLZd1/1Q5H5p
	 2yHoKM3p9bhAGEVxBsO8qGTx5lrq/Qj3PJ+6ca/2lh6ClIlC9+dF/rQyGYHrNjRqQS
	 +Fewk5VwvadGyCXE8Q5s5y1sZ37KjQtQpf2MkbHiy+8aevtfB9/Kp3sZhhMkpKB9x/
	 ZfMAJ5FsLYrTA==
Subject: Re: [PATCH net v4 3/3] netconsole: recheck device registration after
 waiting for carrier
From: netdev-bot+sashiko@kernel.org
To: gustavold@gmail.com
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 stephen@networkplumber.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 14:40:40 +0000
Message-ID: <179293924034.3134.1271340447995228966@kernel.org>
In-Reply-To: <20261021-netcons-fixes-v4-3-3857120c6340@gmail.com>
References: <20261021-netcons-fixes-v4-3-3857120c6340@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The stall the commit message names is still reachable during
  the carrier wait.
- [Low] The patch fixes a user-visible bug but has no Fixes: tag.
- [Low] The new check in netcons_netpoll_setup()
  (drivers/net/netconsole.c:541) reads ndev->reg_state with a plain load.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the same
  RTNL-drop window in netcons_netpoll_setup() loses other notifier…

--

netconsole: recheck device registration after waiting for carrier

This patch adds a check in netcons_netpoll_setup(). After RTNL is retaken
following the carrier wait, it confirms that ndev is still registered. If
the device was unregistered in that window, the device reference is
released and -ENODEV is returned.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-netcons-fixes-v3-1-1aac85ed7665@gmail.com

> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-netcons-fixes-v3-1-1aac85ed7665@gmail.com
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

[Severity: Low]
Should this have a Fixes: tag? The commit message only has Closes: and
Signed-off-by:.

In netcons_netpoll_setup(), the rtnl_unlock() / netcons_wait_carrier() /
rtnl_lock() sequence blames to 672ecd3bb145 ("netconsole: take over
netpoll_setup() from netpoll"). That commit describes itself as pure code
motion.

Before that commit, the same window existed in
net/core/netpoll.c:netpoll_setup():

	rtnl_unlock();
	netpoll_wait_carrier(np, ndev);
	rtnl_lock();

It was followed by __netpoll_setup() with no recheck.

So the bug appears to be older than the netconsole.c history shows. Older
stable trees would need a backport against net/core/netpoll.c rather than
drivers/net/netconsole.c.

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index be7eb632ee424..bd36ebd334aa4 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -534,6 +534,16 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
>  		rtnl_unlock();
>  		netcons_wait_carrier(np, ndev);

[Severity: Medium]
Can the unregister_netdevice() stall from the commit message still happen
during this wait?

netcons_netpoll_setup() takes netdev_hold(ndev, &np->dev_tracker) before it
drops RTNL. netcons_wait_carrier() only watches carrier:

drivers/net/netconsole.c:netcons_wait_carrier() {
	...
	while (!netif_carrier_ok(ndev)) {
		if (time_after(jiffies, atmost)) {
			np_notice(np, "timeout waiting for carrier\n");
			break;
		}
		msleep(1);
	}
}

Suppose the device is unregistered while this loop runs. netdev_run_todo()
then waits in netdev_wait_allrefs_any() and resends NETDEV_UNREGISTER.
netconsole can't drop its reference in response, because np->dev is still
NULL and netconsole_netdev_event() only matches on nt->np.dev == dev.

A device that was just opened and then torn down usually won't get
carrier. The loop then tends to run until carrier_timeout expires (default
4 seconds, a writable module parameter). Only after that does the new
reg_state check reach netdev_put().

Doesn't that leave unregister_netdevice() blocked for up to
carrier_timeout seconds? If that is longer than
netdev_unregister_timeout_secs, the "waiting for ... to become free"
warning is also printed.

The resend already limited the stall before this patch, so the change
seems to shorten it by about one resend interval at most.

Would it make sense to also break out of netcons_wait_carrier() when
READ_ONCE(ndev->reg_state) != NETREG_REGISTERED? The new check after
rtnl_lock() would then do the cleanup.

>  		rtnl_lock();
> +
> +		/* Check that ndev hasn't been unregistered when we released
> +		 * the RTNL above.
> +		 */
> +		if (ndev->reg_state != NETREG_REGISTERED) {

[Severity: Low]
Should this be READ_ONCE(ndev->reg_state)?

RTNL doesn't serialize this read against every writer. netdev_run_todo()
drops RTNL before it writes the final state:

net/core/dev.c:netdev_run_todo() {
	...
	__rtnl_unlock();
	...
		netdev_lock(dev);
		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
		netdev_unlock(dev);
	...
}

This means netconsole can hold RTNL and read reg_state while that
WRITE_ONCE() runs. A plain read racing a marked write is a data race that
KCSAN can report.

The behavior is the same either way, since both NETREG_UNREGISTERING and
NETREG_UNREGISTERED fail the check. Other lockless readers in dev.c use
READ_ONCE() here. process_resume_target() has the same plain read.

> +			np_err(np, "%s was unregistered while waiting for carrier, aborting\n",
> +			       netcons_egress_dev(np, buf, sizeof(buf)));
> +			err = -ENODEV;
> +			goto put;
> +		}
>  	}

[Severity: Medium]
This isn't a bug introduced by this patch, but the same RTNL-drop window
also loses other notifier events, and the reg_state check doesn't catch
them.

np->dev stays NULL until __netpoll_setup(). Any NETDEV_UNREGISTER,
NETDEV_JOIN or NETDEV_CHANGENAME sent during netcons_wait_carrier() is
therefore ignored by netconsole_netdev_event():

	if (nt->np.dev == dev) {

Two cases seem to get past the new check.

The first is a netns move. __dev_change_net_namespace() calls netif_close(),
unlist_netdevice() and call_netdevice_notifiers(NETDEV_UNREGISTER, dev).
Its comment says "dev->reg_state stays at NETREG_REGISTERED". If local_ip
was set explicitly, __netpoll_setup() then binds an enabled target to a
device that now lives in another netns.

The second is enslavement. bond_enslave() and br_add_if() send NETDEV_JOIN,
and that event is lost too. The netdev_master_upper_dev_get() check is not
run again after rtnl_lock(), and __netpoll_setup() only checks
IFF_DISABLE_NETPOLL. netconsole can then end up on a slave device, which the
-EBUSY check is meant to prevent.

process_resume_target() has the same reg_state-only recheck.

Would it be worth also checking net_eq(dev_net(ndev), net) and
!netdev_master_upper_dev_get(ndev) after RTNL is retaken?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021-netcons-fixes-v4-0-3857120c6340%40gmail.com
