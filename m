Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378883FAE15;
	Tue, 13 Oct 2026 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885437; cv=none; b=bsL8mGEB8NrSGI/G9kuJHnYrQikv1lk0gaa/FVB/Yj1DvI+w0psbSlkU3PDQN1NWG6oGzPTREDCnnaRLrFzueq0jzjoLZmpETJXglbbNVURCC+5T3MhayjkZYRT6pPBOscLsjj71q4PdU/dsGHW9ALNYRnJ1xkP2Ix7m+5INieM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885437; c=relaxed/simple;
	bh=/gmdF7YmfNsqnEVsD6u+WboB4rfQQ/rIUdFEcyRjVqk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MkJuuzD3o3kTTN5C0PSQzNOdLCXTrOiCPrvNrUfgAtskSTmxq3V/a8UkRIdLeC1mF+2CgHOrUGVo39MjIk27V43cHmVEMr9K21G4lPGTI375ehE8mMyTeMj2D+avjW1tHNw4rvNSLlB6tv5wiwE296UHA9XlPdk+XHuvSeYs6QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD0T/o52; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD0T/o52"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2831A1F00893;
	Tue, 13 Oct 2026 09:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885435;
	bh=zOnOap3kwuIHZFLOhdDrnOaxYY6F0QxVe7oas8nyUzs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nD0T/o52Uk4G0uVDh8sw2Cv7yWQaf1PSofyxdqBk8eeke5orssF/qiehuszQPoQeZ
	 GEwtEuT402d1HdjTH2gUAgvy5LXzd5fukmAGOHbTdVzFzYQD68r8NQ8rrMvVfCIGdN
	 QT6miGOHS7fFU/MSoRagbPFAQbA34CE9NDQiQ2x6gs1RCnIy+p7sW59rf7KhjUq8Yw
	 8XhTIxVlfh34npaTUXNuouoUw/zVJEItPPT6jUDaE9RnVec8h9dfrTfbkztyc6M+Ds
	 7eb+wsb9+s8jIvam0PDgo4U5oAqmn+DPhxWTg0uxlEcYKDIFP8P2jW9FiWjDbgHHOY
	 STANxDKtmTGiA==
Subject: Re: [PATCH net-next v4 4/6] net: thunderbolt: Move long delayed work
 on system_dfl_long_wq
From: netdev-bot+sashiko@kernel.org
To: marco.crivellari@suse.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
 jiangshanlai@gmail.com, frederic@kernel.org, bigeasy@linutronix.de,
 mhocko@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 enelsonmoore@gmail.com, linux-usb@vger.kernel.org
Date: Tue, 13 Oct 2026 09:57:14 +0000
Message-ID: <179188543474.434549.10017915949287882233@kernel.org>
In-Reply-To: <20261012095452.135828-5-marco.crivellari@suse.com>
References: <20261012095452.135828-5-marco.crivellari@suse.com>
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

- [Low] Part of the commit message's justification does not match this
  driver.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a
  use-after-free when the driver is torn down.
- [Medium] This problem wasn't introduced by this patch, but
  net->login_retries is accessed without consistent locking.

--

net: thunderbolt: Move long delayed work on system_dfl_long_wq

This commit moves the three queue_delayed_work() calls for login_work in
the thunderbolt networking driver from the per-cpu system_long_wq to the
unbound system_dfl_long_wq. connected_work and disconnect_work stay on
system_long_wq.

> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected and it is a per-cpu workqueue.
>
> The function(s) end up calling __queue_delayed_work(), which set a global
> timer that could fire anywhere, enqueuing the work where the timer fired.

[Severity: Low]
Does this description match this driver? drivers/net/thunderbolt/main.c
never calls mod_delayed_work().

Also, the call in tbnet_handle_packet() passes a delay of 0. With delay 0,
__queue_delayed_work() never arms a timer:

kernel/workqueue.c:__queue_delayed_work() {
    ...
	if (!delay) {
		__queue_work(cpu, wq, &dwork->work);
		return;
	}
    ...
}

__queue_work() with WORK_CPU_UNBOUND on a per-cpu workqueue then picks
raw_smp_processor_id(). So before this patch, that instance of login_work
ran on the CPU that handled the TBIP_LOGIN packet, not where a timer fired.

The change itself looks fine, because tbnet_login_work() has no per-cpu
dependency. Could the commit message describe the old behaviour more
precisely? The current wording seems to come from a template shared
across the series.

> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> index d9fb587a62c5e..59a4dcf719b82 100644
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c

[ ... ]

> @@ -470,7 +470,7 @@ static int tbnet_handle_packet(const void *buf, size_t size, void *data)
>  			if (net->login_retries >= TBNET_LOGIN_RETRIES ||
>  			    !net->login_sent) {
>  				net->login_retries = 0;
> -				queue_delayed_work(system_long_wq,
> +				queue_delayed_work(system_dfl_long_wq,
>  						   &net->login_work, 0);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Can
login_work, connected_work or disconnect_work still be pending when
tbnet_remove() frees the netdev?

drivers/net/thunderbolt/main.c:tbnet_remove() {
	...
	unregister_netdev(net->dev);
	tb_unregister_protocol_handler(&net->handler);
	free_netdev(net->dev);
}

tbnet_stop() cancels disconnect_work, and tbnet_tear_down()->stop_login()
cancels login_work and connected_work. The protocol handler is still
registered at that point, though, so tbnet_handle_packet() can run
afterwards and queue the works again.

tb_unregister_protocol_handler() also does not wait for a callback that is
already running, because tb_xdomain_handle_request() drops xdomain_lock
around the call:

drivers/thunderbolt/xdomain.c:tb_xdomain_handle_request() {
    ...
		mutex_unlock(&xdomain_lock);
		ret = handler->callback(buf, size, handler->data);
		mutex_lock(&xdomain_lock);
    ...
}

The TBIP_LOGOUT case has no netif_running() check:

	queue_work(system_long_wq, &net->disconnect_work);

A TBIP_LOGIN that passed netif_running() just before close can also queue
login_work here, and connected_work right after it.

If the interface is down at remove time, ndo_stop never runs. In that case
a disconnect_work queued by a LOGOUT packet is never cancelled.

After free_netdev(), tbnet_disconnect_work()->tbnet_tear_down(),
tbnet_login_work() or tbnet_connected_work() would use the freed struct
tbnet (connection_lock, net->dev, the rings).

tbnet_suspend() has the same ordering: stop_login() runs before
tb_unregister_protocol_handler().

One option is to unregister the protocol handler and wait for in-flight
callbacks before the final cancel_*_sync() calls. Another is to cancel all
three works again after unregistering and before free_netdev(). Would
either of those work here?

No later patch in the series touches drivers/net/thunderbolt/.

>  			}
>  			mutex_unlock(&net->connection_lock);

[ ... ]

> @@ -722,7 +722,8 @@ static void tbnet_login_work(struct work_struct *work)
>  		netdev_dbg(net->dev, "sending login request failed, ret=%d\n",
>  			   ret);
>  		if (net->login_retries++ < TBNET_LOGIN_RETRIES) {

[Severity: Medium]
This isn't a bug introduced by this patch. Is net->login_retries meant to
be protected by connection_lock?

tbnet_handle_packet() checks and resets it while holding the lock:

	mutex_lock(&net->connection_lock);
	...
	if (net->login_retries >= TBNET_LOGIN_RETRIES ||
	    !net->login_sent) {
		net->login_retries = 0;
		queue_delayed_work(system_dfl_long_wq,
				   &net->login_work, 0);
	}

tbnet_login_work() reads it, increments it here and sets it to 0 on
success, all without connection_lock.

Here is one sequence:

- The worker is doing its final increment (60 -> 61).
- At the same time, the handler resets the counter to 0 and queues
  login_work again. This succeeds because the work is running, not
  pending.
- The worker's store can then overwrite the reset.

The re-queued run then makes a single attempt and prints "ThunderboltIP
login timed out" instead of starting a new retry round.

It recovers when the peer sends another TBIP_LOGIN. login_work already ran
concurrently with the RX handler on system_long_wq, so the workqueue change
neither adds nor removes this race.

> -			queue_delayed_work(system_long_wq, &net->login_work,
> +			queue_delayed_work(system_dfl_long_wq,
> +					   &net->login_work,
>  					   delay);
>  		} else {
>  			netdev_info(net->dev, "ThunderboltIP login timed out\n");

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012095452.135828-1-marco.crivellari%40suse.com
