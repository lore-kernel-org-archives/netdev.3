Received: from mta0.migadu.com (out-90.mta0.migadu.com [91.218.175.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319AE47A0A9
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798763; cv=none; b=f4C1b20mbcr5qS/DN3DY/6NLoGthDY6/63Z4oHntFTnXkeTM93R1TOl60pWLgxrhg86IvJIcT6VaIDdhb8ZpmltJ3BsvSxihnSwWrAZQudqUVKwWNIDUl8wJRLiERjhvZTVOB4dc/ps2GQyrrl8HOiBgdLtks/ug5PxFg06Eebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798763; c=relaxed/simple;
	bh=AHIA+RwpuT28qbCBDhX6p5dPp+xOpJIdP2j0VIC8bKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qa2yt0yA/9iznMNJqF0b3dnIDo9LgiQH1vnD+uCvigwMNALCAsArs1UyDXlEwJoeHyOpwRz7i4hr+SK3t8dBnvFISabmGlCw9OmjPeg0oEmw+YRkdHFLIlzZv1TFaOZrtJDN9oVeqknDaar8eefJEM3NnLJVQ9BPU3+jMi6gGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pWHlIX+T; arc=none smtp.client-ip=91.218.175.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pWHlIX+T"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AHIA+RwpuT28qbCBDhX6p5dPp+xOpJIdP2j0VIC8bKI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791798756; v=1; x=1792403556;
 b=pWHlIX+T2F9isaGrLL5ap4n9saxm9Dvs7pvZ7myYA+uFu/OigHyZbvm7k/l1WpKf7gxK0Qma
 kbAEErrsYVwLOn8S1Fz0IFzDLtf9DmPBd8Q2ROus1WBrv0hflYsNPJb/NcFdXMkLLD+JRefjAU6
 yRjI1BvVxKzEKtbFBf3rAl4g=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id d5efb0101126e00b;
	Mon, 12 Oct 2026 09:52:36 +0000
X-Mizu-Trace-ID: d5efb0101126e00b
X-Migadu-Flow: FLOW_OUT
Date: Mon, 12 Oct 2026 17:52:24 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: luyun <luyun_611@163.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	maheshb@google.com, razor@blackwall.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v3] bonding: 3ad: select a port when the TX array is
 empty
Message-ID: <asyt2Gt4LzKWWnZS@fedora>
References: <20261008024031.16224-1-luyun_611@163.com>
 <asoItm3JVXSC5GQ4@fedora>
 <463c6b0e-8b46-4c70-b9d8-56b42beaa7d0@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <463c6b0e-8b46-4c70-b9d8-56b42beaa7d0@163.com>

Hi Lu Yun,

On Mon, Oct 12, 2026 at 03:20:09PM +0800, luyun wrote:
> 
> 在 2026/10/10 17:43, Hangbin Liu 写道:
> > Hi Lu Yun,
> > On Thu, Oct 08, 2026 at 10:40:31AM +0800, Yun Lu wrote:
> > > From: Yun Lu <luyun@kylinos.cn>
> > > 
> > > This issue was observed on a machine in real use. During 802.3ad
> > > bring-up in production, packets were dropped even though the bond's
> > > carrier was up and LACP had enabled ports for distribution. The
> > > transmit path only consults usable_slaves and returns no slave when
> > > the array is NULL or its count is zero.
> > > 
> > > LACP port eligibility and the TX array are updated separately. The
> > > state machine enables ports and updates carrier before scheduling
> > > slave_arr_work to rebuild and publish the array. The worker requires
> > > RTNL and retries if rtnl_trylock() fails, so RTNL contention can
> > > prolong the interval in which eligible ports exist but the cached
> > > array is empty.
> > > 
> > > Add a fallback for 802.3ad when the usable array is empty and carrier
> > > is up. Walk the RCU-protected slave list and use ports whose
> > > aggregator is active and which pass bond_slave_can_tx(), without
> > > taking mode_lock or changing LACP state. In 802.3ad mode the
> > > per-slave active flag is set only by the mux machine for ports of the
> > > active aggregator, so these lockless reads identify distributable
> > > ports with the same criteria bond_update_slave_arr() applies when
> > > building the array.
> > `bond_update_slave_arr()` is called from `bond_enslave()`, and it should be
> > very fast. Could we add a check in `bond_3ad_state_machine_handler()` or
> > another suitable place to ensure usable slaves exist before entering the
> > distribution state?
> > 
> > The fallback path seems somewhat complex and costly. Or you can wait for
> > Jay's feedback.
> 
> Hi Hangbin,
> 
> Thanks for the review and the suggestion.
> 
> bond_enslave() does call bond_update_slave_arr() synchronously, but at
> that point the newly enslaved 802.3ad port is still inactive and there
> is usually no active aggregator yet, so that call typically resets both
> arrays to NULL. The problematic window opens later, when LACP

Ah, yes.

> convergence completes, and it comes from the delay stages between port
> enablement and array publication:
> 
> 1) The state machine enables the port and brings carrier up inside the
>    sweep (__enable_port() -> bond_3ad_set_carrier()), but slave_arr_work
>    is only queued after mode_lock is released.
> 
> 2) bond->wq is an ordered workqueue shared with ad_work, mcast_work and
>    peer_notify_work, so slave_arr_work runs only after the work items
>    queued ahead of it finish, on top of normal scheduler latency under
>    boot load.
> 
> 3) The worker needs RTNL. rtnl_lock is global: any concurrent netdev
>    operation (e.g. udev / network manager churn during boot) makes
>    rtnl_trylock() fail, and the worker requeues itself with a 1 jiffy
>    delay, retrying until RTNL becomes available. This was exactly the
>    situation on the production machine where we hit the problem.
> 
> During this window carrier is up and the ports are already
> collecting/distributing, but usable_slaves is still NULL or empty, so
> every packet goes through bond_tx_drop() and the sender sees no error.
> In production ARP simply never went out.
> 
> A control-path check before entering the distribution state would be
> circular with the current builder: bond_update_slave_arr() only picks
> ports that already pass bond_slave_can_tx(), and that flag is set by
> the mux machine itself on entering collecting/distributing. Waiting
> for a non-empty array before enabling the first port never converges.

I feel calling bond_update_slave_arr after collecting/distributing is a bit
late. Maybe we should start updating slave array after entering
LACP_STATE_SYNCHRONIZATION, cause after that we start sending
LACP sync messages, which means the port is already up and usable.

> 
> Deferring the mux transition instead would delay carrier-on, be
> visible to the LACP partner, and under RTNL contention extend bring-up
> by the same delay the fallback covers, so traffic would not flow any
> sooner. The builder also needs RTNL, may sleep and takes mode_lock
> itself, so it cannot be called from the mux critical section; a
> control-path fix means splitting array preparation from port
> enablement, with recovery when RTNL or allocation fails.
> 
> On cost: the fallback only runs when the array is empty, so the normal
> transmit path is untouched. Inside the window it is a lockless RCU list
> walk with no new state; the second pass and the broadcast branch are
> there to keep the array path's hash mapping and broadcast_neighbor
> semantics.
> 
> I would also like Jay's feedback on the preferred direction. If a
> control-path solution is preferred, I am open to working on separating
> array preparation from port enablement, as long as it does not change
> LACP convergence behavior.

+1

Thanks
Hangbin
